Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 032D414065
	for <lists+linux-wireless@lfdr.de>; Sun,  5 May 2019 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbfEEOwr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 May 2019 10:52:47 -0400
Received: from 0.ictbs.com ([203.137.112.168]:49491 "EHLO 0.ictbs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbfEEOwr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 May 2019 10:52:47 -0400
Received: by hq.local (Postfix, from userid 1000)
        id 3B13E6641B; Sun,  5 May 2019 16:52:41 +0200 (CEST)
Date:   Sun, 5 May 2019 16:52:41 +0200
From:   Victor Bravo <1905@spmblk.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH RFC] brcmfmac: sanitize DMI strings
Message-ID: <20190505145241.fs5uinwjzs4ptaob@localhost>
References: <20190504162633.ldrz2nqfocg55grb@localhost>
 <cce7604e-2b02-80ed-1df5-6f304cada0cb@broadcom.com>
 <20190504194440.4zcxjrtj2aft3ka4@localhost>
 <16a87149068.2764.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <20190505144852.addbdluel7edoevm@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505144852.addbdluel7edoevm@localhost>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Didn't notice that the patch removes some fresh changes which got in
while I was tuning it. Please wait for v2. Sorry for the noise.
v.

On Sun, May 05, 2019 at 04:48:52PM +0200, Victor Bravo wrote:
> Sanitize DMI strings in brcmfmac driver to make resulting filenames
> contain only safe characters. This version replaces all non-printable
> characters incl. delete (0-31, 127-255), spaces and slashes with
> underscores.
> 
> This change breaks backward compatibility, but adds control over strings
> passed to firmware loader and compatibility with CONFIG_EXTRA_FIRMWARE
> which doesn't support spaces in filenames.
> 
> Signed-off-by: Victor Bravo <1905@spmblk.com>
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> index 7535cb0d4ac0..fa654ce7172b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/dmi.c
> @@ -23,6 +23,14 @@
>  /* The DMI data never changes so we can use a static buf for this */
>  static char dmi_board_type[128];
>  
> +/* Array of 128 bits representing 7-bit characters allowed in DMI strings. */
> +static unsigned char brcmf_dmi_allowed_chars[] = {
> +	0x00, 0x00, 0x00, 0x00, 0xfe, 0x7f, 0xff, 0xff,
> +	0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x7f
> +};
> +
> +#define BRCMF_DMI_SAFE_CHAR '_'
> +
>  struct brcmf_dmi_data {
>  	u32 chip;
>  	u32 chiprev;
> @@ -43,10 +51,6 @@ static const struct brcmf_dmi_data meegopad_t08_data = {
>  	BRCM_CC_43340_CHIP_ID, 2, "meegopad-t08"
>  };
>  
> -static const struct brcmf_dmi_data pov_tab_p1006w_data = {
> -	BRCM_CC_43340_CHIP_ID, 2, "pov-tab-p1006w-data"
> -};
> -
>  static const struct dmi_system_id dmi_platform_data[] = {
>  	{
>  		/* Match for the GPDwin which unfortunately uses somewhat
> @@ -85,20 +89,18 @@ static const struct dmi_system_id dmi_platform_data[] = {
>  		},
>  		.driver_data = (void *)&meegopad_t08_data,
>  	},
> -	{
> -		/* Point of View TAB-P1006W-232 */
> -		.matches = {
> -			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
> -			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "BayTrail"),
> -			/* Note 105b is Foxcon's USB/PCI vendor id */
> -			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "105B"),
> -			DMI_EXACT_MATCH(DMI_BOARD_NAME, "0E57"),
> -		},
> -		.driver_data = (void *)&pov_tab_p1006w_data,
> -	},
>  	{}
>  };
>  
> +void brcmf_dmi_sanitize(char *dst, const unsigned char *allowed, char safe)
> +{
> +	while (*dst) {
> +		if ((*dst < 0) || !(allowed[*dst / 8] & (1 << (*dst % 8))))
> +			*dst = safe;
> +		dst++;
> +	}
> +}
> +
>  void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
>  {
>  	const struct dmi_system_id *match;
> @@ -126,6 +128,9 @@ void brcmf_dmi_probe(struct brcmf_mp_device *settings, u32 chip, u32 chiprev)
>  	if (sys_vendor && product_name) {
>  		snprintf(dmi_board_type, sizeof(dmi_board_type), "%s-%s",
>  			 sys_vendor, product_name);
> +		brcmf_dmi_sanitize(dmi_board_type,
> +				   brcmf_dmi_allowed_chars,
> +				   BRCMF_DMI_SAFE_CHAR);
>  		settings->board_type = dmi_board_type;
>  	}
>  }
> 

-- 
NOTE FOR WINDOWS (TM) USERS:  IN NO EVENT UNLESS REQUIRED BY APPLICABLE
LAW WILL I BE LIABLE TO YOU FOR ANY SW OR HW DAMAGE, SYSTEM MALFUNCTION,
DATA LOSS AND/OR DATA BREACH ARISING OUT WHILE YOU ARE READING THIS NOTE.
