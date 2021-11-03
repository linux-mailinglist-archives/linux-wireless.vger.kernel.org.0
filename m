Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E2B4441EA
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 13:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhKCMxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 08:53:33 -0400
Received: from mail-bo1ind01olkn0155.outbound.protection.outlook.com ([104.47.101.155]:6560
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231343AbhKCMxc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 08:53:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6IcmiZuWfx7XfrL0iqe199pxhbtcktSAvgKU4EPpFezi/mJl6Qn6f0mvl3X7zf0MqQ1MAuSd1yjDIRikAhsNhzQSbIjEdmA2ALGeWhtF3WMH0sG2wdfDqhKv6FnN7fDbJsENS/UcjL7GL90y1aKwbEPdhOvr+MsZypR7FqLNkwlhmjQN/YktpBte8bjGPIYzd/N8ZflwKMbdjgAXdISEjKsvhLT5xDexsoU5NP1fo+ENBcXM8rIMDI0KEa8YLscZuObGcz8dWZK8DRKgt2XQEVDHMDLqnYoMkS6egXMh582CrBHhE3CGCF2Q2XrD+AmWljQyksD0K17X9FIdjeEMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QI7I1QUpFs/4kChCPtQcGXs1FjGoq38JziQeJbJDyl8=;
 b=FWGSGkJ9Qvvv1NRCkI1cZWRBpF6DjhguqvJrsntZ+gvHhBVQw+1jaHQ771g5ZREkcS9TRGseNfyZ/EF4e1dZWu7Hj9ANNh2THB4ncHWUPJw4YwuimxMqsGi0UU7FVUxjWDqF3M3tgJlIwt/nGlsktNACBjhFYo19xbqdNJQ66c4vQwPngg/DFNnZ+r89gADd7ZY9C+glHnvcgCMUCje5MUEQw+M4MrzAK3wOtb+24NJ9n0tmF6+T24+DmlkzeSclBhM1P17k0ZCwIPSQR0ddTK3B7A7xePgZqecJ8LMPpX3AiXSRUZUV/jLq0sqqfxMp5sx1B6UWggm1TaQt9jIGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QI7I1QUpFs/4kChCPtQcGXs1FjGoq38JziQeJbJDyl8=;
 b=QDpIgIqb6Zd6Y7hDoHa8M+t8ETrpQXJXGJDuMJbg4i8sTb7O6c6ORU21Ezot3TkSsRcXumlJsrpMf1hVnnlxfcy/GEYIBoNM3P7rHB4m2LG1Zp2SW3X+N3DI6Jz6hQMGtkRr+789qME/X7mVA8jjRlZgNvlWmZG6TE/srBZ4rD2fnBOsUSfK1LEv2+Gb2Lx5PdYa3Y5fh6GT2NlWnE3GIyfBwsP92/n9LbRtf81PtvRjPU8+Mfn7sYH2D8GMfEVOqXEhtRZ4WJPA2k9om42V87vFOdt63Lu9SK2odHV+p8VGk6uH5gqRxy84/nwEIly8qb6SFf3vXj0LjC5t6c9cZA==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4558.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.19; Wed, 3 Nov
 2021 12:50:49 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::cdc4:def5:dc73:28f7%6]) with mapi id 15.20.4649.020; Wed, 3 Nov 2021
 12:50:49 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Hector Martin <marcan@marcan.st>
CC:     "aspriel@gmail.com" <aspriel@gmail.com>,
        "franky.lin@broadcom.com" <franky.lin@broadcom.com>,
        "hante.meuleman@broadcom.com" <hante.meuleman@broadcom.com>,
        "chi-hsien.lin@infineon.com" <chi-hsien.lin@infineon.com>,
        "wright.feng@infineon.com" <wright.feng@infineon.com>,
        "chung-hsien.hsu@infineon.com" <chung-hsien.hsu@infineon.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "brcm80211-dev-list.pdl@broadcom.com" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "SHA-cyfmac-dev-list@infineon.com" <SHA-cyfmac-dev-list@infineon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stan Skowronek <stan@corellium.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Joey Gouly <joey.gouly@arm.com>
Subject: Re: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Thread-Topic: [PATCH v3 1/3] brcmfmac: Add support for BCM4378 on Apple
 hardware (with their special OTP).
Thread-Index: AQHX0GuU60Mzr7gPW0qK2qCd4kZ7oKvxeKSAgABJWwA=
Date:   Wed, 3 Nov 2021 12:50:49 +0000
Message-ID: <C6EE3B44-84FD-4246-89F5-98CE52E746C1@live.com>
References: <PNZPR01MB4415874CD530F2C305872F88B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44155DC40EAA3A13FCE85193B88A9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <PNZPR01MB44156C94263746D4EC592E96B88B9@PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM>
 <391FADA9-4C9D-42F5-97FA-B87D36BE901B@live.com>
 <4928ea79-2794-05fb-d1a8-942b589a1c3a@marcan.st>
In-Reply-To: <4928ea79-2794-05fb-d1a8-942b589a1c3a@marcan.st>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [s57ZngZ5LrwlLqpp1iPLV2Ysqryv5K7w5kyK6QLHTpCD3Y3hfHSpwHAJOZrUPRSw]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 320ca90e-ab60-413a-4aed-08d99ec88fb6
x-ms-traffictypediagnostic: PNZPR01MB4558:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qgie4sWXPGVRptyVwbXnPGqMaJ7pi2PJigs4qa/d+gD9Fus8ZskV/2RCKjcGT82ATG6kKD6f0xvBPUjGFLe8Xf8N+icETvW8sJO9daZV8UKB8chM73z0sjn9EEvSsjw5CBExY6UP9UuWpTNf7hfgWbUu8UP1GHUw0gZ2n8dVey75akSvo8G3XZqCGlVD9rY2kYvpzuUudWk+E6CadB7M0yqDiaIoOSjbjus0pKic0lEA5GthkLUn9afeAAonkUVxsGfzBTUxAjTMdInPBSnxIfXINhegkM9qCjxjF01Uq+ewHYfWnfY077N7Q/zgczKXSe29SJqJo+4VY05s3+hkxNEgiHDKVJIxkn2xgilaxBk6LCUgG64SU5WnpAlxCTslemVu9XIbmjcealGLYTRmZu1Ez8hzKie4rfZXGLEZHzQdr3Sq5h39+5pVtCK1ENcAucBXnoXUGE740xm6xj4hibkqdClb9lqThgpTvFhjR/Ia5wR2r2KNM1PMbKN0fvRCKuXK93n4SxCsK9PS5xaZdyItdLJ9aO15r8nTt8NEvEVvTtlQUNDSabZDAXcqKw1kFWX1C0iyFEPw8Tu76I48g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: vdP5A52ZdeOp0wsKw0jE/1IceoDsmsUAN8L80UVB4xQwNdhLdso6L5IIOhV386EiaBkr/VprGKWFyQi7Bh39PiwCKuyCP3a6pv97Ew0+gqr0Tye/j9f1AoR/0yckadZtSj3GYrADPylckNxnrekjKLT0eH0sy0w87+CeLmgLqsOpu3zS3nogbhNRAf3DjXq+JHNvcRlmBS3l9BsF2/uTxezKYkqoSdrYaNHoyXGIHKEovzKji1lsbBpOYxXvcz9A4ZpHavbjfAuG8j1owmWa7v8XymfxFTMgDnWrttzTodnecdVAmCujnMEC+m1RCqtrrBJ3lT2hM+WKHEcSNV3PZvW7hW5C8HU2UIrbZZd/GwQ5GvpZnrBnLbR782NCsvwg3MC16bmtjTfcUZIOG77+OFzUScIq00lUsbKjKRMxsTET5BGURIpCxMZ7gcJo7BT+5EDkXXqHDZVwSjACI+zx0NQmaSJmz1y6xgVPD+rsbNL5WXc5CHc8P5Wqos5h3DsdQi5n1DtNFfjUVwp5Pwz0qPgtM9Z/5OD1qrxXI8SOSD8r9FZT8brEUm9RynDuZLj2eQtDFgD+rh6xz7tB+Ht6jvEfboRux7NMpn7+6DMihSxIgQ0XFNDccS91PoZlW0v7R5JnPiCjSCRz2mvIu0JwETmrnzKBsBGQ6PETQwCVJoJioJV6NqkEZ0wwO0HNWZ2bJ10eMK7lSeF4oGxSN4L+qgD61I9SBQS77ikfA/NzfXRKI89SBdRfIIg2jB+bdoF8cIpH09Y6sSLO8DP9jOZ+jA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <92C19BD3054E7C46995B36B63C91A44B@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-20-msonline-outlook-a1a1a.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 320ca90e-ab60-413a-4aed-08d99ec88fb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2021 12:50:49.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4558
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On 03-Nov-2021, at 1:58 PM, Hector Martin <marcan@marcan.st> wrote:
>=20
> Hi,
>=20
> I'd been meaning to rewrite this patch because it's such a mess, but sinc=
e we're here... (CCing some relevant folks)
>=20
> Overall: this patch combines a ton of unrelated random changes, many of w=
hich without explanation, with some completely crazy approaches. Stan (CC'e=
d) has so far refused to interact with the kernel community in any way what=
soever, and I do not feel comfortable using his patches without thorough re=
view, including reverse engineering the changes to figure out what they act=
ually do and why. We've already gone through this with some of his other pa=
tches, which ended up being largely rewritten or entirely dropped in the en=
d.
I see. Well cause I am not associated with Correlium in any way, so I won't=
 be able to explain the changes they have done myself. The purpose I sent t=
his patch was cause this patch with the other 2 patches I sent, has success=
fully got wifi working on T2 Macs too.
>=20
> The firmware situation with this patch is completely unacceptable. It see=
ms the original intent here is to have users load the driver, have it print=
 the required firmware version, and then expect users to copy specifically =
that firmware file set from macOS, and reload again. This is obviously not =
the right way to do this. We need to statically copy all firmware from macO=
S/recovery mode with a naming scheme that this driver can use, at initial i=
nstall time, and it needs to dynamically select the right firmware for any =
given platform it is booted on.
>=20
> The main issue with these machines is that there is a large set of requir=
ed firmware variants; a few core firmware files plus many nvram variants fo=
r different hardware modules and device revisions. A lot of them are identi=
cal and can be symlinked, but we need to work out a naming scheme for these=
 variations. There are several more dimensions of nvram selection than what=
 we're used to on Linux.
>=20
> For example, nvram is currently named in this kind of fashion:
>=20
> brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt
>=20
> While Apple indexes firmware using a combination of platform module, vend=
or, module version, and antenna config. The first three come from an OTP in=
side the WiFi module, while the antenna config comes from the Apple Device =
Tree and needs to be forwarded to Linux at boot time by the bootloader. In =
addition, there is also chip ID and revision.
>=20
> Apple names their NVRAM using the following scheme:
>=20
> C-4378__s-B1/P-honshu-X3_M-RASP_V-u__m-6.5.txt
>=20
> Where 4378 is the chip, B1 is the revision, "honshu" is the platform, "X3=
" is the antenna config, "RASP" is the module, "u" is the vendor, and "6.5"=
 is the module version.
In linux the platform has been found in the DSDT acpi table. A known `iasl =
-d` it and found this out. The revision antenna config have not been signif=
icant as per the best of my knowledge after reading the article (link below=
).
>=20
> Trying to translate this to something following the Linux conventions, we=
 might end up with something like this:
>=20
> brcmfmac4378b1-pcie.apple,honshu-RASP-u-6.5-X3.txt
>=20
> However, on macOS, many of these files are copies or symlinks. For exampl=
e, on honshu, the module version and antenna config do not matter. So this =
can simplify to:
The module version does matter for T2 Macs. In my case, MacBook Pro 16,1, 7=
.7 and 7.9 antenna config have been found which work only on the devices th=
ey are used.
>=20
> brcmfmac4378b1-pcie.apple,honshu-RASP-u.txt
>=20
> What I've been thinking is we can have the installation process detect th=
ose duplicates/links, and install only firmware files with the most generic=
 name. Then the driver could attempt to load firmwares starting with more s=
pecific naming and going towards less specific. That would avoid having to =
have a giant pile of symlinks in /lib/firmware/brcm (there are 286 discrete=
 files/links in Apple's firmware directory just for 4378...)
>=20
> I would like to have a thorough discussion about how to handle the firmwa=
re situation, as this affects the software stack from the installer to the =
bootloader to the kernel. We also need a new devicetree binding for the ant=
enna type parameter, as that needs to be set via the bootloader from the Ap=
ple Device Tree info.
For the firmware, I don't know about the M1 Macs (Though the patch seems to=
 claim that it supports OTP), for T2, I agree that we have to manually copy=
 and rename the firmware from macOS to linux. A research article about this=
 is there on https://wiki.t2linux.org/guides/wifi/.
>=20
> On 03/11/2021 13.30, Aditya Garg wrote:
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c=
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index 0ee421f30aa24..8f7db434de111 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -5136,8 +5136,13 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struc=
t wireless_dev *wdev,
>>  		ie_offset =3D  DOT11_MGMT_HDR_LEN +
>>  			     DOT11_BCN_PRB_FIXED_LEN;
>>  		ie_len =3D len - ie_offset;
>> -		if (vif =3D=3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif)
>> +		if (vif =3D=3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_PRIMARY].vif) {
>>  			vif =3D cfg->p2p.bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>> +			if (vif =3D=3D NULL) {
>> +				bphy_err(drvr, "No p2p device available for probe response\n");
>> +				return -ENODEV;
>> +			}
>> +		}
>=20
> Why is this necessary?
>=20
>> -static char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
>> +char brcmf_firmware_path[BRCMF_FW_ALTPATH_LEN];
>>  module_param_string(alternative_fw_path, brcmf_firmware_path,
>> -		    BRCMF_FW_ALTPATH_LEN, 0400);
>> +		    BRCMF_FW_ALTPATH_LEN, 0600);
>>  MODULE_PARM_DESC(alternative_fw_path, "Alternative firmware path");
>>  +char brcmf_mac_addr[18];
>> +module_param_string(nvram_mac_addr, brcmf_mac_addr,
>> +			18, 0600);
>> +MODULE_PARM_DESC(nvram_mac_addr, "Set MAC address in NVRAM");
>=20
> The MAC address should come from the device tree, just as it works for ev=
ery other ethernet device on OF platforms. This already works fine for e.g.=
 the wired ethernet; it should be done the same way here.
>=20
>> +
>> +char brcmf_otp_chip_id[BRCMF_OTP_VERSION_MAX];
>> +module_param_string(otp_chip_id, brcmf_otp_chip_id, BRCMF_OTP_VERSION_M=
AX, 0400);
>> +MODULE_PARM_DESC(otp_chip_id, "Chip ID and revision from OTP");
>> +
>> +char brcmf_otp_nvram_id[BRCMF_OTP_VERSION_MAX];
>> +module_param_string(otp_nvram_id, brcmf_otp_nvram_id, BRCMF_OTP_VERSION=
_MAX, 0400);
>> +MODULE_PARM_DESC(otp_chip_id, "NVRAM variant from OTP");
>> +
>=20
> This is crazy; the driver should read OTP and figure out what firmware it=
 needs. The only piece of external information required is the antenna conf=
ig, which should come from the device tree on ARM platforms (not sure how t=
his is passed through on x86/T2 Macs, does anyone have any idea?)
>=20
>>  static int brcmf_fcmode;
>>  module_param_named(fcmode, brcmf_fcmode, int, 0);
>>  MODULE_PARM_DESC(fcmode, "Mode of firmware signalled flow control");
>> @@ -75,7 +88,6 @@ MODULE_PARM_DESC(ignore_probe_fail, "always succeed pr=
obe for debugging");
>>  #endif
>>    static struct brcmfmac_platform_data *brcmfmac_pdata;
>> -struct brcmf_mp_global_t brcmf_mp_global;
>>    void brcmf_c_set_joinpref_default(struct brcmf_if *ifp)
>>  {
>> @@ -376,22 +388,6 @@ void __brcmf_dbg(u32 level, const char *func, const=
 char *fmt, ...)
>>  }
>>  #endif
>>  -static void brcmf_mp_attach(void)
>> -{
>> -	/* If module param firmware path is set then this will always be used,
>> -	 * if not set then if available use the platform data version. To make
>> -	 * sure it gets initialized at all, always copy the module param versi=
on
>> -	 */
>> -	strlcpy(brcmf_mp_global.firmware_path, brcmf_firmware_path,
>> -		BRCMF_FW_ALTPATH_LEN);
>> -	if ((brcmfmac_pdata) && (brcmfmac_pdata->fw_alternative_path) &&
>> -	    (brcmf_mp_global.firmware_path[0] =3D=3D '\0')) {
>> -		strlcpy(brcmf_mp_global.firmware_path,
>> -			brcmfmac_pdata->fw_alternative_path,
>> -			BRCMF_FW_ALTPATH_LEN);
>> -	}
>> -}
>=20
> Why is this being removed?
>=20
>> +static void brcmf_fw_set_macaddr(struct nvram_parser *nvp, const char *=
mac_addr)
>> +{
>> +	uint8_t mac[6] =3D { 0 };
>> +	size_t len =3D strlen("macaddr=3D") + 17 + 1; /* 17 =3D "aa:bb:cc:dd:e=
e:ff" */
>> +	unsigned i =3D 0;
>> +	unsigned long res =3D 0;
>> +	char tmp[3];
>> +
>> +	while(mac_addr[0] && mac_addr[1] && i < 6) {
>> +		tmp[0] =3D mac_addr[0];
>> +		tmp[1] =3D mac_addr[1];
>> +		tmp[2] =3D 0;
>> +		if(kstrtoul(tmp, 16, &res))
>> +			break;
>> +		mac[i] =3D res;
>> +		mac_addr +=3D 2;
>> +		i ++;
>> +		while(*mac_addr =3D=3D ':' || *mac_addr =3D=3D ' ' || *mac_addr =3D=
=3D '-')
>> +			mac_addr ++;
>> +	}
>> +	if(i < 6)
>> +		pr_warn("invalid MAC address supplied for brcmfmac!\n");
>> +
>> +	memmove(&nvp->nvram[len], &nvp->nvram[0], nvp->nvram_len);
>> +	nvp->nvram_len +=3D len;
>> +	sprintf(&nvp->nvram[0], "macaddr=3D%02x:%02x:%02x:%02x:%02x:%02x",
>> +		mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
>> +}
>=20
> The driver already has the ability to set the MAC address; why do we need=
 to set it in nvram? Just call the MAC address change function at driver in=
itialization (instead of the MAC address get function, for these chips). Th=
e MAC address should come from the device tree, e.g. via eth_platform_get_m=
ac_address(). See tg3 for a driver that already does this properly (and wor=
ks on the M1 Mac Mini with zero changes).
>=20
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> index ec6fc7a150a6a..1c1d5131c3f36 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> @@ -565,7 +565,8 @@ static s32 brcmf_p2p_deinit_discovery(struct brcmf_p=
2p_info *p2p)
>>    	/* Set the discovery state to SCAN */
>>  	vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>> -	(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, 0=
);
>> +	if (vif !=3D NULL)
>> +		(void)brcmf_p2p_set_discover_state(vif->ifp, WL_P2P_DISC_ST_SCAN, 0, =
0);
>>    	/* Disable P2P discovery in the firmware */
>>  	vif =3D p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif;
>> @@ -1351,6 +1352,8 @@ brcmf_p2p_gon_req_collision(struct brcmf_p2p_info =
*p2p, u8 *mac)
>>  	 * if not (sa addr > da addr),
>>  	 * this device will process gon request and drop gon req of peer.
>>  	 */
>> +	if(p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif =3D=3D NULL)
>> +		return false;
>>  	ifp =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif->ifp;
>>  	if (memcmp(mac, ifp->mac_addr, ETH_ALEN) < 0) {
>>  		brcmf_dbg(INFO, "Block transmit gon req !!!\n");
>> @@ -1559,6 +1562,10 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf=
_p2p_info *p2p,
>>  	else
>>  		vif =3D p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>>  +	if (vif =3D=3D NULL) {
>> +		bphy_err(drvr, " no P2P interface available\n");
>> +		goto exit;
>> +	}
>>  	err =3D brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
>>  					sizeof(*af_params));
>>  	if (err) {
>=20
> Are these really the only brcmfmac chips without a P2P interface? What do=
es this mean for end users? What features are lost?
>=20
>> +static u32
>> +brcmf_pcie_reg_map(struct brcmf_pciedev_info *devinfo, u32 reg)
>> +{
>> +	switch(reg) {
>> +	case BRCMF_PCIE_PCIE2REG_INTMASK:
>> +		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
>> +			return BRCMF_PCIE_64_PCIE2REG_INTMASK;
>> +		return reg;
>> +	case BRCMF_PCIE_PCIE2REG_MAILBOXINT:
>> +		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
>> +			return BRCMF_PCIE_64_PCIE2REG_MAILBOXINT;
>> +		return reg;
>> +	case BRCMF_PCIE_PCIE2REG_MAILBOXMASK:
>> +		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
>> +			return BRCMF_PCIE_64_PCIE2REG_MAILBOXMASK;
>> +		return reg;
>> +	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_0:
>> +		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
>> +			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_0;
>> +		return reg;
>> +	case BRCMF_PCIE_PCIE2REG_H2D_MAILBOX_1:
>> +		if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID)
>> +			return BRCMF_PCIE_64_PCIE2REG_H2D_MAILBOX_1;
>> +		return reg;
>> +	default:
>> +		return reg;
>> +	}
>> +}
>=20
> This kind of register mapping is ugly. A much better way to do this is to=
 have static structures containing the list of registers for each given chi=
p/variant. Then you just set it at load time and the functions that need th=
ose registers use those structures to find them, instead of constants.
>=20
>> +
>> +
>> +
>=20
> Too many blank lines
>=20
>>  #define WRITECC32(devinfo, reg, value) brcmf_pcie_write_reg32(devinfo, =
\
>>  		CHIPCREGOFFS(reg), value)
>>  @@ -543,6 +626,7 @@ brcmf_pcie_select_core(struct brcmf_pciedev_info *d=
evinfo, u16 coreid)
>>  	core =3D brcmf_chip_get_core(devinfo->ci, coreid);
>>  	if (core) {
>>  		bar0_win =3D core->base;
>> +
>>  		pci_write_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW, bar0_win);
>>  		if (pci_read_config_dword(pdev, BRCMF_PCIE_BAR0_WINDOW,
>>  					  &bar0_win) =3D=3D 0) {
>=20
> This seems like a leftover.
>=20
>> @@ -615,11 +699,129 @@ static void brcmf_pcie_reset_device(struct brcmf_=
pciedev_info *devinfo)
>>  	}
>>  }
>>  +#define OTP_SIZE		64
>> +#define OTP_CORE_ID		BCMA_CORE_GCI
>> +#define OTP_CC_ADDR_4378	0x1120
>> +
>> +static void brcmf_pcie_process_otp_tuple(struct brcmf_pciedev_info *dev=
info, u8 type, u8 size, u8 *data)
>> +{
>> +	char tmp[OTP_SIZE], t_chiprev[8] =3D "", t_module[8] =3D "", t_modrev[=
8] =3D "", t_vendor[8] =3D "", t_chip[8] =3D "";
>> +	unsigned i, len;
>> +
>> +	switch(type) {
>> +	case 0x15: /* system vendor OTP */
>> +		if(size < 4)
>> +			return;
>> +		if(*(u32 *)data !=3D 8)
>> +			dev_warn(&devinfo->pdev->dev, "system vendor OTP header unexpected: =
%d\n", *(u32 *)data);
>> +		size -=3D 4;
>> +		data +=3D 4;
>> +		while(size) {
>> +			if(data[0] =3D=3D 0xFF)
>> +				break;
>> +			for(len=3D0; len<size; len++)
>> +				if(data[len] =3D=3D 0x00 || data[len] =3D=3D ' ' || data[len] =3D=
=3D 0xFF)
>> +					break;
>> +			memcpy(tmp, data, len);
>> +			tmp[len] =3D 0;
>> +			data +=3D len;
>> +			size -=3D len;
>> +			if(size) {
>> +				data ++;
>> +				size --;
>> +			}
>> +			brcmf_dbg(PCIE, "system vendor OTP element '%s'\n", tmp);
>> +
>> +			if(len < 2)
>> +				continue;
>> +			if(tmp[1] =3D=3D '=3D' && len < 8)
>> +				switch(tmp[0]) {
>> +				case 's':
>> +					strcpy(t_chiprev, tmp + 2);
>> +					break;
>> +				case 'M':
>> +					strcpy(t_module, tmp + 2);
>> +					break;
>> +				case 'm':
>> +					strcpy(t_modrev, tmp + 2);
>> +					break;
>> +				case 'V':
>> +					strcpy(t_vendor, tmp + 2);
>> +					break;
>> +				}
>> +		}
>> +
>> +		sprintf(t_chip, (devinfo->ci->chip > 40000) ? "%05d" : "%04x", devinf=
o->ci->chip);
>> +		dev_info(&devinfo->pdev->dev, "module revision data: chip %s, chip re=
v %s, module %s, module rev %s, vendor %s\n", t_chip, t_chiprev, t_module, =
t_modrev, t_vendor);
>> +
>> +		if(t_chiprev[0])
>> +			sprintf(brcmf_otp_chip_id, "C-%s__s-%s", t_chip, t_chiprev);
>> +		else
>> +			sprintf(brcmf_otp_chip_id, "C-%s", t_chip);
>> +		sprintf(brcmf_otp_nvram_id, "M-%s_V-%s__m-%s", t_module, t_vendor, t_=
modrev);
>> +
>> +		break;
>> +	case 0x80: /* Broadcom CIS */
>> +		if(size < 1)
>> +			return;
>> +		switch(data[0]) {
>> +		case 0x83: /* serial number */
>> +			for(i=3D0; i<16 && i<size-1; i++)
>> +				sprintf(tmp + 2 * i, "%02x", data[i+1]);
>> +			dev_info(&devinfo->pdev->dev, "module serial number: %s\n", tmp);
>> +			break;
>> +		}
>> +		break;
>> +	}
>> +}
>=20
> This seems to be building the Apple-formwat firmware name for users to us=
e to find the right firmware. As I said, this is entirely the wrong approac=
h to do it. The driver needs to use this information to find the right firm=
ware itself, and the firmware copying/installation process needs to copy *a=
ll* of them.
>=20
>> +
>> +static u32 brcmf_pcie_buscore_prep_addr(const struct pci_dev *pdev, u32=
 addr);
>> +
>> +static void brcmf_pcie_read_otp(struct brcmf_pciedev_info *devinfo)
>> +{
>> +	u8 otp[OTP_SIZE], type, size;
>> +	unsigned i;
>> +	struct brcmf_core *core;
>> +	u32 base;
>> +
>> +	if (devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID) {
>> +		/* for whatever reason, reading OTP works only once after reset */
>> +		if(brcmf_otp_chip_id[0])
>> +			return;
>=20
> Why? Has this been debugged to figure out why it fails and after what poi=
nt?
>=20
>> +
>> +		core =3D brcmf_chip_get_core(devinfo->ci, OTP_CORE_ID);
>> +		if(!core) {
>> +			dev_err(&devinfo->pdev->dev, "can't find core for OTP\n");
>> +			return;
>> +		}
>> +		base =3D brcmf_pcie_buscore_prep_addr(devinfo->pdev, core->base + OTP=
_CC_ADDR_4378);
>> +
>> +		for(i=3D0; i<OTP_SIZE; i+=3D2)
>> +			((u16 *)otp)[i/2] =3D brcmf_pcie_read_reg16(devinfo, base + i);
>> +
>> +		i =3D 0;
>> +		while(i < OTP_SIZE - 1) {
>> +			type =3D otp[i];
>> +			if(!type) { /* null tuple */
>> +				i ++;
>> +				continue;
>> +			}
>> +			size =3D otp[i + 1];
>> +			i +=3D 2;
>> +			if(i + size <=3D OTP_SIZE)
>> +				brcmf_pcie_process_otp_tuple(devinfo, type, size, otp + i);
>> +			i +=3D size;
>> +		}
>> +	}
>> +}
>> +
>>    static void brcmf_pcie_attach(struct brcmf_pciedev_info *devinfo)
>>  {
>>  	u32 config;
>>  +	brcmf_pcie_read_otp(devinfo);
>> +
>>  	/* BAR1 window may not be sized properly */
>>  	brcmf_pcie_select_core(devinfo, BCMA_CORE_PCIE2);
>>  	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_CONFIGADDR, 0x4e0)=
;
>> @@ -809,30 +1011,34 @@ static void brcmf_pcie_bus_console_read(struct br=
cmf_pciedev_info *devinfo,
>>    static void brcmf_pcie_intr_disable(struct brcmf_pciedev_info *devinf=
o)
>>  {
>> -	brcmf_pcie_write_reg32(devinfo, BRCMF_PCIE_PCIE2REG_MAILBOXMASK, 0);
>> +	brcmf_pcie_write_reg32(devinfo, brcmf_pcie_reg_map(devinfo, BRCMF_PCIE=
_PCIE2REG_MAILBOXMASK), 0);
>>  }
>=20
> See above for why this is the wrong approach (also the other instances).
>> @@ -1543,6 +1754,8 @@ brcmf_pcie_init_share_ram_info(struct brcmf_pciede=
v_info *devinfo,
>>  	return 0;
>>  }
>>  +#define RANDOMBYTES_SIZE        264
>> +#define CLEAR_SIZE              256
>>    static int brcmf_pcie_download_fw_nvram(struct brcmf_pciedev_info *de=
vinfo,
>>  					const struct firmware *fw, void *nvram,
>> @@ -1553,15 +1766,16 @@ static int brcmf_pcie_download_fw_nvram(struct b=
rcmf_pciedev_info *devinfo,
>>  	u32 sharedram_addr_written;
>>  	u32 loop_counter;
>>  	int err;
>> -	u32 address;
>> +	u32 address, clraddr;
>>  	u32 resetintr;
>> +	uint8_t randb[RANDOMBYTES_SIZE];
>>    	brcmf_dbg(PCIE, "Halt ARM.\n");
>>  	err =3D brcmf_pcie_enter_download_state(devinfo);
>>  	if (err)
>>  		return err;
>>  -	brcmf_dbg(PCIE, "Download FW %s\n", devinfo->fw_name);
>> +	brcmf_dbg(PCIE, "Download FW %s 0x%x 0x%x\n", devinfo->fw_name, (unsig=
ned)devinfo->ci->rambase, (unsigned)fw->size);
>=20
> This seems like a leftover debug change.
>=20
>>  	brcmf_pcie_copy_mem_todev(devinfo, devinfo->ci->rambase,
>>  				  (void *)fw->data, fw->size);
>>  @@ -1574,20 +1788,38 @@ static int brcmf_pcie_download_fw_nvram(struct =
brcmf_pciedev_info *devinfo,
>>  	brcmf_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4, 0);
>>    	if (nvram) {
>> -		brcmf_dbg(PCIE, "Download NVRAM %s\n", devinfo->nvram_name);
>>  		address =3D devinfo->ci->rambase + devinfo->ci->ramsize -
>>  			  nvram_len;
>> +		brcmf_dbg(PCIE, "Download NVRAM %s 0x%x 0x%x\n", devinfo->nvram_name,=
 address, nvram_len);
>=20
> Ditto
>=20
>>  		brcmf_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
>>  		brcmf_fw_nvram_free(nvram);
>> +
>> +		address -=3D RANDOMBYTES_SIZE;
>> +		get_random_bytes(randb, RANDOMBYTES_SIZE - 8);
>> +		memcpy(randb + RANDOMBYTES_SIZE - 8, "\x00\x01\x00\x00\xde\xc0\xed\xf=
e", 8);
>> +		brcmf_pcie_copy_mem_todev(devinfo, address, randb, RANDOMBYTES_SIZE);
>=20
> Do Apple chips require some random seed placed before the nvram? And if s=
o, why is this being done unconditionally for all chips? Do the other chips=
 not care if we do this? Can it cause issues?
>=20
>>  	} else {
>>  		brcmf_dbg(PCIE, "No matching NVRAM file found %s\n",
>>  			  devinfo->nvram_name);
>> +		address =3D devinfo->ci->rambase + devinfo->ci->ramsize;
>> +	}
>> +
>> +	memset(randb, 0, CLEAR_SIZE);
>> +	clraddr =3D devinfo->ci->rambase + fw->size;
>> +	while(clraddr < address) {
>> +		u32 block =3D address - clraddr;
>> +		if(block > CLEAR_SIZE)
>> +			block =3D CLEAR_SIZE;
>> +		if(((clraddr + block - 1) ^ clraddr) & -CLEAR_SIZE)
>> +			block =3D (CLEAR_SIZE - clraddr) & (CLEAR_SIZE - 1);
>> +		brcmf_pcie_copy_mem_todev(devinfo, clraddr, randb, block);
>> +		clraddr +=3D block;
>>  	}
>=20
> Looks like this is clearing memory from the end of firmware to the nvram/=
random area. Why is this necessary?
>=20
>>    	sharedram_addr_written =3D brcmf_pcie_read_ram32(devinfo,
>>  						       devinfo->ci->ramsize -
>>  						       4);
>> -	brcmf_dbg(PCIE, "Bring ARM in running state\n");
>> +	brcmf_dbg(PCIE, "Bring ARM in running state (RAM sign: 0x%08x)\n", sha=
redram_addr_written);
>>  	err =3D brcmf_pcie_exit_download_state(devinfo, resetintr);
>>  	if (err)
>>  		return err;
>=20
> Leftover debug?
>=20
>> +	if(devinfo->ci->chip =3D=3D BRCM_CC_4378_CHIP_ID) {
>> +		brcmf_pcie_read_otp(devinfo);
>> +
>> +		if(!brcmf_mac_addr[0]) {
>> +			dev_info(&pdev->dev, "hardware discovery complete, not starting driv=
er\n");
>> +			ret =3D -ENODEV;
>> +			goto exit;
>> +		}
>> +	}
>=20
> Yeah, this is crazy. The whole "load the driver once, tell the user what =
info they need, have them copy the firmware and set things up and load it a=
gain" dance is ridiculous. Hard NAK on doing things this way.
>=20
> --=20
> Hector Martin (marcan@marcan.st)
> Public Key: https://mrcn.st/pub

