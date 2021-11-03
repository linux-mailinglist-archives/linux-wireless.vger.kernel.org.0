Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6976C443E63
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 09:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbhKCIbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 04:31:00 -0400
Received: from marcansoft.com ([212.63.210.85]:53186 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231705AbhKCIa7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 04:30:59 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A925E425B3;
        Wed,  3 Nov 2021 08:28:16 +0000 (UTC)
To:     Aditya Garg <gargaditya08@live.com>,
        "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joey Gouly <joey.gouly@arm.com>
References: <PNZPR01MB4415874CD530F2C305872F88B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44155DC40EAA3A13FCE85193B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44156C94263746D4EC592E96B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <391FADA9-4C9D-42F5-97FA-B87D36BE901B@live.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Message-ID: <4928ea79-2794-05fb-d1a8-942b589a1c3a@marcan.st>
Date:   Wed, 3 Nov 2021 17:28:13 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <391FADA9-4C9D-42F5-97FA-B87D36BE901B@live.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I'd been meaning to rewrite this patch because it's such a mess, but 
since we're here... (CCing some relevant folks)

Overall: this patch combines a ton of unrelated random changes, many of 
which without explanation, with some completely crazy approaches. Stan 
(CC'ed) has so far refused to interact with the kernel community in any 
way whatsoever, and I do not feel comfortable using his patches without 
thorough review, including reverse engineering the changes to figure out 
what they actually do and why. We've already gone through this with some 
of his other patches, which ended up being largely rewritten or entirely 
dropped in the end.

The firmware situation with this patch is completely unacceptable. It 
seems the original intent here is to have users load the driver, have it 
print the required firmware version, and then expect users to copy 
specifically that firmware file set from macOS, and reload again. This 
is obviously not the right way to do this. We need to statically copy 
all firmware from macOS/recovery mode with a naming scheme that this 
driver can use, at initial install time, and it needs to dynamically 
select the right firmware for any given platform it is booted on.

The main issue with these machines is that there is a large set of 
required firmware variants; a few core firmware files plus many nvram 
variants for different hardware modules and device revisions. A lot of 
them are identical and can be symlinked, but we need to work out a 
naming scheme for these variations. There are several more dimensions of 
nvram selection than what we're used to on Linux.

For example, nvram is currently named in this kind of fashion:

brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt

While Apple indexes firmware using a combination of platform module, 
vendor, module version, and antenna config. The first three come from an 
OTP inside the WiFi module, while the antenna config comes from the 
Apple Device Tree and needs to be forwarded to Linux at boot time by the 
bootloader. In addition, there is also chip ID and revision.

Apple names their NVRAM using the following scheme:

C-4378__s-B1/P-honshu-X3_M-RASP_V-u__m-6.5.txt

Where 4378 is the chip, B1 is the revision, "honshu" is the platform, 
"X3" is the antenna config, "RASP" is the module, "u" is the vendor, and 
"6.5" is the module version.

Trying to translate this to something following the Linux conventions, 
we might end up with something like this:

brcmfmac4378b1-pcie.apple,honshu-RASP-u-6.5-X3.txt

However, on macOS, many of these files are copies or symlinks. For 
example, on honshu, the module version and antenna config do not matter. 
So this can simplify to:

brcmfmac4378b1-pcie.apple,honshu-RASP-u.txt

What I've been thinking is we can have the installation process detect 
those duplicates/links, and install only firmware files with the most 
generic name. Then the driver could attempt to load firmwares starting 
with more specific naming and going towards less specific. That would 
avoid having to have a giant pile of symlinks in /lib/firmware/brcm 
(there are 286 discrete files/links in Apple's firmware directory just 
for 4378...)

I would like to have a thorough discussion about how to handle the 
firmware situation, as this affects the software stack from the 
installer to the bootloader to the kernel. We also need a new devicetree 
binding for the antenna type parameter, as that needs to be set via the 
bootloader from the Apple Device Tree info.

On 03/11/2021 13.30, Aditya Garg wrote:
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 0ee421f30aa24..8f7db434de111 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -5136,8 +5136,13 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>   		ie_offset =  DOT11_MGMT_HDR_LEN +
>   			     DOT11_BCN_PRB_FIXED_LEN;
>   		ie_len = len - ie_offset;
> -		if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif)
> +		if (vif == cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif) {
>   			vif = cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> +			if (vif == NULL) {
> +				bphy_err(drvr, "No p2p device available for probe response\n");
> +				return -ENODEV;
> +			}
> +		}

Why is this necessary?

> -static char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
> +char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
>   module_param_string(alternative_fw_path, brcmf_firmware_path,
> -		    BRCMF_FW_ALTPATH_LEN, 0400);
> +		    BRCMF_FW_ALTPATH_LEN, 0600);
>   MODULE_PARM_DESC(alternative_fw_path, "Alternative firmware path");
>   
> +char brcmf_mac_addr[18];
> +module_param_string(nvram_mac_addr, brcmf_mac_addr,
> +			18, 0600);
> +MODULE_PARM_DESC(nvram_mac_addr, "Set MAC address in NVRAM");

The MAC address should come from the device tree, just as it works for 
every other ethernet device on OF platforms. This already works fine for 
e.g. the wired ethernet; it should be done the same way here.

> +
> +char brcmf_otp_chip_id[BRCMF_OTP_VERSION_MAX];
> +module_param_string(otp_chip_id, brcmf_otp_chip_id, BRCMF_OTP_VERSION_MAX, 0400);
> +MODULE_PARM_DESC(otp_chip_id, "Chip ID and revision from OTP");
> +
> +char brcmf_otp_nvram_id[BRCMF_OTP_VERSION_MAX];
> +module_param_string(otp_nvram_id, brcmf_otp_nvram_id, BRCMF_OTP_VERSION_MAX, 0400);
> +MODULE_PARM_DESC(otp_chip_id, "NVRAM variant from OTP");
> +

This is crazy; the driver should read OTP and figure out what firmware 
it needs. The only piece of external information required is the antenna 
config, which should come from the device tree on ARM platforms (not 
sure how this is passed through on x86/T2 Macs, does anyone have any idea?)

>   static int brcmf_fcmode;
>   module_param_named(fcmode, brcmf_fcmode, int, 0);
>   MODULE_PARM_DESC(fcmode, "Mode of firmware signalled flow control");
> @@ -75,7 +88,6 @@ MODULE_PARM_DESC(ignore_probe_fail, "always succeed probe for debugging");
>   #endif
>   
>   static struct brcmfmac_platform_data *brcmfmac_pdata;
> -struct brcmf_mp_global_t brcmf_mp_global;
>   
>   void brcmf_c_set_joinpref_default(struct brcmf_if *ifp)
>   {
> @@ -376,22 +388,6 @@ void __brcmf_dbg(u32 level, const char *func, const char *fmt, ...)
>   }
>   #endif
>   
> -static void brcmf_mp_attach(void)
> -{
> -	/* If module param firmware path is set then this will always be used,
> -	 * if not set then if available use the platform data version. To make
> -	 * sure it gets initialized at all, always copy the module param version
> -	 */
> -	strlcpy(brcmf_mp_global.firmware_path, brcmf_firmware_path,
> -		BRCMF_FW_ALTPATH_LEN);
> -	if ((brcmfmac_pdata) && (brcmfmac_pdata->fw_alternative_path) &&
> -	    (brcmf_mp_global.firmware_path[0] == '\0')) {
> -		strlcpy(brcmf_mp_global.firmware_path,
> -			brcmfmac_pdata->fw_alternative_path,
> -			BRCMF_FW_ALTPATH_LEN);
> -	}
> -}

Why is this being removed?

> +static void brcmf_fw_set_macaddr(struct nvram_parser *nvp, const char *mac_addr)
> +{
> +	uint8_t mac[6] = { 0 };
> +	size_t len = strlen("macaddr=") + 17 + 1; /* 17 = "aa:bb:cc:dd:ee:ff" */
> +	unsigned i = 0;
> +	unsigned long res = 0;
> +	char tmp[3];
> +
> +	while(mac_addr[0] && mac_addr[1] && i < 6) {
> +		tmp[0] = mac_addr[0];
> +		tmp[1] = mac_addr[1];
> +		tmp[2] = 0;
> +		if(kstrtoul(tmp, 16, &res))
> +			break;
> +		mac[i] = res;
> +		mac_addr += 2;
> +		i ++;
> +		while(*mac_addr == ':' || *mac_addr == ' ' || *mac_addr == '-')
> +			mac_addr ++;
> +	}
> +	if(i < 6)
> +		pr_warn("invalid MAC address supplied for brcmfmac!\n");
> +
> +	memmove(&nvp->nvram[len], &nvp->nvram[0], nvp->nvram_len);
> +	nvp->nvram_len += len;
> +	sprintf(&nvp->nvram[0], "macaddr=%02x:%02x:%02x:%02x:%02x:%02x",
> +		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
> +}

The driver already has the ability to set the MAC address; why do we 
need to set it in nvram? Just call the MAC address change function at 
driver initialization (instead of the MAC address get function, for 
these chips). The MAC address should come from the device tree, e.g. via 
eth_platform_get_mac_address(). See tg3 for a driver that already does 
this properly (and works on the M1 Mac Mini with zero changes).

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> index ec6fc7a150a6a..1c1d5131c3f36 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> @@ -565,7 +565,8 @@ static s32 brcmf_p2p_deinit_discovery(struct brcmf_p2p_info *p2p)
>   
>   	/* Set the discovery state to SCAN */
>   	vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> -	(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
> +	if (vif != NULL)
> +		(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0);
>   
>   	/* Disable P2P discovery in the firmware */
>   	vif = p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
> @@ -1351,6 +1352,8 @@ brcmf_p2p_gon_req_collision(struct brcmf_p2p_info *p2p, u8 *mac)
>   	 * if not (sa addr > da addr),
>   	 * this device will process gon request and drop gon req of peer.
>   	 */
> +	if(p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif == NULL)
> +		return false;
>   	ifp = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->ifp;
>   	if (memcmp(mac, ifp->mac_addr, ETH_ALEN) < 0) {
>   		brcmf_dbg(INFO, "Block transmit gon req !!!\n");
> @@ -1559,6 +1562,10 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
>   	else
>   		vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>   
> +	if (vif == NULL) {
> +		bphy_err(drvr, " no P2P interface available\n");
> +		goto exit;
> +	}
>   	err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
>   					sizeof(*af_params));
>   	if (err) {

Are these really the only brcmfmac chips without a P2P interface? What 
does this mean for end users? What features are lost?

> +static u32
> +brcmf_pcie_reg_map(struct brcmf_pciedev_info *devinfo, u32 reg)
> +{
> +	switch(reg) {
> +	case BRCMF_PCIE_PCIE2REG_INTMASK:
> +		if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID)
> +			return BRCMF_PCIE_64_PCIE2REG_INTMASK;
> +		return reg;
> +	case BRCMF_PCIE_PCIE2REG_MAILBOXINT:
> +		if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID)
> +			return BRCMF_PCIE_64_PCIE2REG_MAILBOXINT;
> +		return reg;
> +	case BRCMF_PCIE_PCIE2REG_MAILBOXMASK:
> +		if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID)
> +			return BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK;
> +		return reg;
> +	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0:
> +		if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID)
> +			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0;
> +		return reg;
> +	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1:
> +		if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID)
> +			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1;
> +		return reg;
> +	default:
> +		return reg;
> +	}
> +}

This kind of register mapping is ugly. A much better way to do this is 
to have static structures containing the list of registers for each 
given chip/variant. Then you just set it at load time and the functions 
that need those registers use those structures to find them, instead of 
constants.

> +
> +
> +

Too many blank lines

>   #define WRITECC32(devinfo, reg, value) brcmf_pcie_write_reg32(devinfo, \
>   		CHIPCREGOFFS(reg), value)
>   
> @@ -543,6 +626,7 @@ brcmf_pcie_select_core(struct brcmf_pciedev_info *devinfo, u16 coreid)
>   	core = brcmf_chip_get_core(devinfo->ci, coreid);
>   	if (core) {
>   		bar0_win = core->base;
> +
>   		pci_write_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW, bar0_win);
>   		if (pci_read_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW,
>   					  &bar0_win) == 0) {

This seems like a leftover.

> @@ -615,11 +699,129 @@ static void brcmf_pcie_reset_device(struct brcmf_pciedev_info *devinfo)
>   	}
>   }
>   
> +#define OTP_SIZE		64
> +#define OTP_CORE_ID		BCMA_CORE_GCI
> +#define OTP_CC_ADDR_4378	0x1120
> +
> +static void brcmf_pcie_process_otp_tuple(struct brcmf_pciedev_info *devinfo, u8 type, u8 size, u8 *data)
> +{
> +	char tmp[OTP_SIZE], t_chiprev[8] = "", t_module[8] = "", t_modrev[8] = "", t_vendor[8] = "", t_chip[8] = "";
> +	unsigned i, len;
> +
> +	switch(type) {
> +	case 0x15: /* system vendor OTP */
> +		if(size < 4)
> +			return;
> +		if(*(u32 *)data != 8)
> +			dev_warn(&devinfo->pdev->dev, "system vendor OTP header unexpected: %d\n", *(u32 *)data);
> +		size -= 4;
> +		data += 4;
> +		while(size) {
> +			if(data[0] == 0xFF)
> +				break;
> +			for(len=0; len<size; len++)
> +				if(data[len] == 0x00 || data[len] == ' ' || data[len] == 0xFF)
> +					break;
> +			memcpy(tmp, data, len);
> +			tmp[len] = 0;
> +			data += len;
> +			size -= len;
> +			if(size) {
> +				data ++;
> +				size --;
> +			}
> +			brcmf_dbg(PCIE, "system vendor OTP element '%s'\n", tmp);
> +
> +			if(len < 2)
> +				continue;
> +			if(tmp[1] == '=' && len < 8)
> +				switch(tmp[0]) {
> +				case 's':
> +					strcpy(t_chiprev, tmp + 2);
> +					break;
> +				case 'M':
> +					strcpy(t_module, tmp + 2);
> +					break;
> +				case 'm':
> +					strcpy(t_modrev, tmp + 2);
> +					break;
> +				case 'V':
> +					strcpy(t_vendor, tmp + 2);
> +					break;
> +				}
> +		}
> +
> +		sprintf(t_chip, (devinfo->ci->chip > 40000) ? "%05d" : "%04x", devinfo->ci->chip);
> +		dev_info(&devinfo->pdev->dev, "module revision data: chip %s, chip rev %s, module %s, module rev %s, vendor %s\n", t_chip, t_chiprev, t_module, t_modrev, t_vendor);
> +
> +		if(t_chiprev[0])
> +			sprintf(brcmf_otp_chip_id, "C-%s__s-%s", t_chip, t_chiprev);
> +		else
> +			sprintf(brcmf_otp_chip_id, "C-%s", t_chip);
> +		sprintf(brcmf_otp_nvram_id, "M-%s_V-%s__m-%s", t_module, t_vendor, t_modrev);
> +
> +		break;
> +	case 0x80: /* Broadcom CIS */
> +		if(size < 1)
> +			return;
> +		switch(data[0]) {
> +		case 0x83: /* serial number */
> +			for(i=0; i<16 && i<size-1; i++)
> +				sprintf(tmp + 2 * i, "%02x", data[i+1]);
> +			dev_info(&devinfo->pdev->dev, "module serial number: %s\n", tmp);
> +			break;
> +		}
> +		break;
> +	}
> +}

This seems to be building the Apple-formwat firmware name for users to 
use to find the right firmware. As I said, this is entirely the wrong 
approach to do it. The driver needs to use this information to find the 
right firmware itself, and the firmware copying/installation process 
needs to copy *all* of them.

> +
> +static u32 brcmf_pcie_buscore_prep_addr(const struct pci_dev *pdev, u32 addr);
> +
> +static void brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
> +{
> +	u8 otp[OTP_SIZE], type, size;
> +	unsigned i;
> +	struct brcmf_core *core;
> +	u32 base;
> +
> +	if (devinfo->ci->chip == BRCM_CC_4378_CHIP_ID) {
> +		/* for whatever reason, reading OTP works only once after reset */
> +		if(brcmf_otp_chip_id[0])
> +			return;

Why? Has this been debugged to figure out why it fails and after what point?

> +
> +		core = brcmf_chip_get_core(devinfo->ci, OTP_CORE_ID);
> +		if(!core) {
> +			dev_err(&devinfo->pdev->dev, "can't find core for OTP\n");
> +			return;
> +		}
> +		base = brcmf_pcie_buscore_prep_addr(devinfo->pdev, core->base + OTP_CC_ADDR_4378);
> +
> +		for(i=0; i<OTP_SIZE; i+=2)
> +			((u16 *)otp)[i/2] = brcmf_pcie_read_reg16(devinfo, base + i);
> +
> +		i = 0;
> +		while(i < OTP_SIZE - 1) {
> +			type = otp[i];
> +			if(!type) { /* null tuple */
> +				i ++;
> +				continue;
> +			}
> +			size = otp[i + 1];
> +			i += 2;
> +			if(i + size <= OTP_SIZE)
> +				brcmf_pcie_process_otp_tuple(devinfo, type, size, otp + i);
> +			i += size;
> +		}
> +	}
> +}
> +
>   
>   static void brcmf_pcie_attach(struct brcmf_pciedev_info *devinfo)
>   {
>   	u32 config;
>   
> +	brcmf_pcie_read_otp(devinfo);
> +
>   	/* BAR1 window may not be sized properly */
>   	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
>   	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_CONFIGADDR, 0x4e0);
> @@ -809,30 +1011,34 @@ static void brcmf_pcie_bus_console_read(struct brcmf_pciedev_info *devinfo,
>   
>   static void brcmf_pcie_intr_disable(struct brcmf_pciedev_info *devinfo)
>   {
> -	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK, 0);
> +	brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK), 0);
>   }

See above for why this is the wrong approach (also the other instances).
> @@ -1543,6 +1754,8 @@ brcmf_pcie_init_share_ram_info(struct brcmf_pciedev_info *devinfo,
>   	return 0;
>   }
>   
> +#define RANDOMBYTES_SIZE        264
> +#define CLEAR_SIZE              256
>   
>   static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   					const struct firmware *fw, void *nvram,
> @@ -1553,15 +1766,16 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   	u32 sharedram_addr_written;
>   	u32 loop_counter;
>   	int err;
> -	u32 address;
> +	u32 address, clraddr;
>   	u32 resetintr;
> +	uint8_t randb[RANDOMBYTES_SIZE];
>   
>   	brcmf_dbg(PCIE, "Halt ARM.\n");
>   	err = brcmf_pcie_enter_download_state(devinfo);
>   	if (err)
>   		return err;
>   
> -	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
> +	brcmf_dbg(PCIE, "Download FW %s 0x%x 0x%x\n", devinfo->fw_name, (unsigned)devinfo->ci->rambase, (unsigned)fw->size);

This seems like a leftover debug change.

>   	brcmf_pcie_copy_mem_todev(devinfo, devinfo->ci->rambase,
>   				  (void *)fw->data, fw->size);
>   
> @@ -1574,20 +1788,38 @@ static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *devinfo,
>   	brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
>   
>   	if (nvram) {
> -		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
>   		address = devinfo->ci->rambase + devinfo->ci->ramsize -
>   			  nvram_len;
> +		brcmf_dbg(PCIE, "Download NVRAM %s 0x%x 0x%x\n", devinfo->nvram_name, address, nvram_len);

Ditto

>   		brcmf_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
>   		brcmf_fw_nvram_free(nvram);
> +
> +		address -= RANDOMBYTES_SIZE;
> +		get_random_bytes(randb, RANDOMBYTES_SIZE - 8);
> +		memcpy(randb + RANDOMBYTES_SIZE - 8, "\x00\x01\x00\x00\xde\xc0\xed\xfe", 8);
> +		brcmf_pcie_copy_mem_todev(devinfo, address, randb, RANDOMBYTES_SIZE);

Do Apple chips require some random seed placed before the nvram? And if 
so, why is this being done unconditionally for all chips? Do the other 
chips not care if we do this? Can it cause issues?

>   	} else {
>   		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
>   			  devinfo->nvram_name);
> +		address = devinfo->ci->rambase + devinfo->ci->ramsize;
> +	}
> +
> +	memset(randb, 0, CLEAR_SIZE);
> +	clraddr = devinfo->ci->rambase + fw->size;
> +	while(clraddr < address) {
> +		u32 block = address - clraddr;
> +		if(block > CLEAR_SIZE)
> +			block = CLEAR_SIZE;
> +		if(((clraddr + block - 1) ^ clraddr) & -CLEAR_SIZE)
> +			block = (CLEAR_SIZE - clraddr) & (CLEAR_SIZE - 1);
> +		brcmf_pcie_copy_mem_todev(devinfo, clraddr, randb, block);
> +		clraddr += block;
>   	}

Looks like this is clearing memory from the end of firmware to the 
nvram/random area. Why is this necessary?

>   
>   	sharedram_addr_written = brcmf_pcie_read_ram32(devinfo,
>   						       devinfo->ci->ramsize -
>   						       4);
> -	brcmf_dbg(PCIE, "Bring ARM in running state\n");
> +	brcmf_dbg(PCIE, "Bring ARM in running state (RAM sign: 0x%08x)\n", sharedram_addr_written);
>   	err = brcmf_pcie_exit_download_state(devinfo, resetintr);
>   	if (err)
>   		return err;

Leftover debug?

> +	if(devinfo->ci->chip == BRCM_CC_4378_CHIP_ID) {
> +		brcmf_pcie_read_otp(devinfo);
> +
> +		if(!brcmf_mac_addr[0]) {
> +			dev_info(&pdev->dev, "hardware discovery complete, not starting driver\n");
> +			ret = -ENODEV;
> +			goto exit;
> +		}
> +	}

Yeah, this is crazy. The whole "load the driver once, tell the user what 
info they need, have them copy the firmware and set things up and load 
it again" dance is ridiculous. Hard NAK on doing things this way.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
