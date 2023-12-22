Return-Path: <linux-wireless+bounces-1200-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2DE81C4A6
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 06:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3471C24F20
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 05:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507847476;
	Fri, 22 Dec 2023 05:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="jtqHdDgJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEB35395
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 05:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E6FDD4258C;
	Fri, 22 Dec 2023 05:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703222891; bh=Jf1238bahR1609uptSJItE/4qY0VTJmv20+8pGwjOd8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jtqHdDgJAFDxvFbdTGh5OJO69UcEQ2CxxvnYIVmVVIylmRsWhSyGHUTzwux6LPlIB
	 l3gJ6d06kPXbQysr034AgQzKjIkopoCojCfVt6FQ/ehFNIl9oABQpUJyQddhnlFW7u
	 TEtAn7urc0DOmLb2IHqVahbSnt7T2aDZRHCo+ql/VgMHDjMJwJsKsYrBnPD0hQj6sq
	 T5YelbmFeha7pqQUWwJvvjsSlzQ0cZ0j5UHSMgnDN0+chrdPsHbIWyz6WgH32JeT0g
	 6fn04GrhEH4R0b7ab3hlw/wiVSjtC7tRVFDxt6lt5HKUFL7KVaSCpU+BpXjliDudVE
	 U2TD7k+cDkb/A==
Message-ID: <537c3ebe-ffe6-4579-a791-1450a3c1b107@marcan.st>
Date: Fri, 22 Dec 2023 14:28:08 +0900
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Neal Gompa <neal@gompa.dev>,
 =?UTF-8?Q?Pawe=C5=82_Drewniak?= <czajernia@gmail.com>,
 Kalle Valo <kvalo@codeaurora.org>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <20231221140416.223639-1-arend.vanspriel@broadcom.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <20231221140416.223639-1-arend.vanspriel@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/21 23:04, Arend van Spriel wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Using the WSEC command instead of sae_password seems to be the supported
> mechanism on newer firmware, and also how the brcmdhd driver does it.
> 
> According to user reports [1], the sae_password codepath doesn't actually
> work on machines with Cypress chips anyway, so no harm in removing it.
> 
> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
> patchset [2].
> 
> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
> [arend.vanspriel@broadcom.com: use multi-vendor framework]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
> Here is how the multi-vendor code could support both Cypress and
> WCC mobility chips. As said it might be easier to just override
> entire cfg80211 callback operations.
> 
> Regards,
> Arend
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 13 +++++++---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  3 +++
>  .../broadcom/brcm80211/brcmfmac/fwil.c        |  1 +
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
>  .../broadcom/brcm80211/brcmfmac/fwvid.h       | 14 ++++++++++
>  .../broadcom/brcm80211/brcmfmac/wcc/core.c    | 26 +++++++++++++++++++
>  6 files changed, 55 insertions(+), 4 deletions(-)
> 
[snip]
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> index 5573a47766ad..01025d5c137b 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> @@ -7,6 +7,7 @@
>  #include <core.h>
>  #include <bus.h>
>  #include <fwvid.h>
> +#include <fwil.h>
>  
>  #include "vops.h"
>  
> @@ -21,7 +22,32 @@ static void brcmf_wcc_detach(struct brcmf_pub *drvr)
>  	pr_debug("%s: executing\n", __func__);
>  }
>  
> +static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
> +				 struct cfg80211_crypto_settings *crypto)
> +{
> +	struct brcmf_pub *drvr = ifp->drvr;
> +	struct brcmf_wsec_pmk_le pmk;
> +	int err;
> +
> +	memset(&pmk, 0, sizeof(pmk));
> +
> +	/* pass pmk directly */
> +	pmk.key_len = cpu_to_le16(crypto->sae_pwd_len);
> +	pmk.flags = cpu_to_le16(BRCMF_WSEC_PASSPHRASE);
> +	memcpy(pmk.key, crypto->sae_pwd, crypto->sae_pwd_len);
> +
> +	/* store psk in firmware */
> +	err = brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
> +				     &pmk, sizeof(pmk));
> +	if (err < 0)
> +		bphy_err(drvr, "failed to change PSK in firmware (len=%u)\n",
> +			 crypto->sae_pwd_len);
> +
> +	return err;
> +}
> +
>  const struct brcmf_fwvid_ops brcmf_wcc_ops = {
>  	.attach = brcmf_wcc_attach,
>  	.detach = brcmf_wcc_detach,
> +	.set_sae_password = brcmf_wcc_set_sae_pwd,
>  };

If we're going to move this into per-vendor code, we should also move
the Cypress codepath repectively. Is there a reason why we can't just
rename and export brcmf_set_wsec (as in my original patch) instead of
duplicating the code here? Fundamentally this code already exists in
common code for WPA support, so why not reuse it for SAE for WCC?

- Hector

