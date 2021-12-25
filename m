Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B494347F342
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Dec 2021 13:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhLYMqo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 25 Dec 2021 07:46:44 -0500
Received: from mout.web.de ([212.227.15.3]:60313 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhLYMqo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 25 Dec 2021 07:46:44 -0500
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Dec 2021 07:46:43 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1640436399;
        bh=/P0ETY1xdoVEqX8lt3dHHUcpzyzrD4cXugpKOZVZbWU=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DR2JjBPQNpXxLe+yOUt3qXJprsQC1XEIrP2k2j4jvGbvwlNO9LEwH5RzbuLZOACQQ
         9pHj15eGT1hhtlVIGLG6zu3O/XY3jjFI43YakBqOdxgJ3svjNdPAxOa2H7I3M7+xyU
         sDtkjnEo10FBixgpNO3FFB/0+u327HGkdiCOFHX4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.9.8.2] ([62.227.163.4]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mrww5-1mdt0z3WQ1-00neE4; Sat, 25
 Dec 2021 13:41:25 +0100
Subject: Re: [PATCH] brcmfmac: use ISO3166 country code and 0 rev as fallback
 on some devices
To:     Hans de Goede <hdegoede@redhat.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Chi-Hsien Lin <chi-hsien.lin@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Wright Feng <wright.feng@infineon.com>
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, Shawn Guo <shawn.guo@linaro.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>
References: <20211218185643.158182-1-hdegoede@redhat.com>
From:   Soeren Moch <smoch@web.de>
Message-ID: <2896d15d-b5d9-c80d-7474-dcafaed0fdef@web.de>
Date:   Sat, 25 Dec 2021 13:41:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211218185643.158182-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-Provags-ID: V03:K1:vAPLD5vQ8nOSgJk0hed4rMuaZv6mFzSXAv2FyAzRrRtWsqMYIg3
 nC9QkB3aXX9/GeGmIen8OOK/djTkEGruhGt7ivCTTUxzD/FVhn4EPpqsgzMR58JXFt5mWzt
 h9B2W8Hteypdi0IML2ZALEo7BbsYw46VBg7hebYWjEYfeomXidh1EtNmcw4NlLNyZ33YVhd
 iJSl5+7CA/rwN/mx4CLKA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:y17nZHCmfmg=:HBsqlawU5LhELwObAHFxWC
 yNippPYnkq8dVN7egXQz3KM2Pa0xSaPdlbJ2eMreIIKr5XJwPJLt11rY7Fgdo/WmFYen14j8K
 QvyxQqL5eNOiYuJn14exrzYo8FCcOUX2ZOx8zV4rmKV+/BtNopensO6mKo0nV/0stTiRsRRVV
 SBKE9Ku2ZsaD1xhic/ANPauT70lO1YqnJ3ZF6BPP+H4ERr+d67OHCFrN54jTQO0/MD+V6L9yB
 v6QcYuXVeveGAfqk9PP0NdYyd3vzWOvkmOvVOPwjEspnI6yMjJRTBzOJlTbg1vJZ5P0+PTp32
 W/nwNklGWj9LzyOxO38+s71UnWOcseJ7qTWFKOnSKFQPujZPE58IsRYQ9t8rJjRp1pmLDAH29
 7uBH1hlhQTzp1CTrjHdkDVqXwf5DgIzGl+Jkxu9b2OmL8eu754XgB/p8zX6J7lkobaT2C22dB
 RhC8O+j8mZw8Q9wVUUgGb2tUKNstmnqx3Ua6cD1djcx2vtVdreEgBbqEWKZcenZikUDjGY/LW
 rbRpXfAbozIEUayXsihvM+y+3aiGXXBZKWBAhzh2+n5w2U4hgr+/vnNBUJvDBFAO+G6WfuR3f
 lZlJQ7ED6Devj7yyt69SinxfcCR8hzqKx7LrwBw4YOrAhrCqCfLHM2Ns5UVWecXvhXFAPNeQo
 SACgenjHAWsM6DxXmjWhfxAO/Ox0Sc0n7C/9tIAGb3yrcwnU8C8037vH/0oO9R1YDoKL1zYGZ
 V0wEBB+x01sGHTx8WgOCVG/xEXscEu6qUjbH5zx1IrCvuytTGFEgkKYIXoX9B4AH8DFbN4UFu
 /87UFel1NVefW0H5Rd+X/vsG+fdngMyBe4nY1YMNewtcGdoCI3+bdQfgguR4AaXJAEJLnONTG
 5022CYNvcSi1+hvudaGd+wbq1gUJl8V/E8Jim0mM5osbrYGL5Q5snjSZHZYpVjR6wmoBwmLVW
 AZwqHKbtqh0VqRFCt9aa0A9WdBB9FQmlqYG1I6kqVubm55DNh7ocKtBs+wjHMdlGNzRxw6Q8U
 qy1hVBBgjLxnAXEkijWe7iRnUno+BYmKmTXEzoRuQA8ZP5shZ1CKFRUI5455v2haYeQOMjPqb
 KcWvX+WAq4f3qs=
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 18.12.21 19:56, Hans de Goede wrote:
> This is a second attempt at honering the country code send out by access
> points. This was first added in commit b0b524f079a2 ("brcmfmac: use
> ISO3166 country code and 0 rev as fallback").
>
> Subsequently this was reverted in commit 151a7c12c4fc ("Revert "brcmfmac=
:
> use ISO3166 country code and 0 rev as fallback""), because it was causin=
g
> issues with AP mode on some brcmfmac models (specifically on BCM4359/9).
>
> Many devices ship with a nvram ccode value of X2/XT/XU/XV/ALL which are
> all special world-wide compatibility ccode-s. Most of these world-wide
> ccode-s allow passive scan mode only for 2.4GHz channels 12-14,
> only enabling them when an AP is seen on them.
>
> But at least on brcmfmac43455 devices this is not working correctly, the=
se
> do not see accesspoints on channels 12-14 unless the ccode is changes to
> a country where these channels are allowed.
>
> Translating received country codes to an ISO3166 country code and 0 rev
> ccreq fixes devices using a brcmfmac43455 with a X2/XT/XU/XV/ALL ccode
> not seeing accesspoints on channels 12-14.
>
> To avoid this causing issues on other brcmfmac models again, the
> fallback is limited to only brcmfmac4345* chips this time.
>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Soeren Moch <smoch@web.de>
> Cc: Fabio Aiuto <fabioaiuto83@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Unsurprisingly this does not hurt on BCM4359/9. So FWIW

Tested-by: Soeren Moch <smoch@web.de>=C2=A0 # on BCM4359/9
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 33 +++++++++++++++----
>  1 file changed, 27 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c=
 b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index fb727778312c..c10ac839dd26 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -16,6 +16,7 @@
>  #include <brcmu_utils.h>
>  #include <defs.h>
>  #include <brcmu_wifi.h>
> +#include <brcm_hw_ids.h>
>  #include "core.h"
>  #include "debug.h"
>  #include "tracepoint.h"
> @@ -7455,6 +7456,16 @@ int brcmf_cfg80211_wait_vif_event(struct brcmf_cf=
g80211_info *cfg,
>  				  vif_event_equals(event, action), timeout);
>  }
>
> +static bool brmcf_use_iso3166_ccode_fallback(struct brcmf_pub *drvr)
> +{
> +	switch (drvr->bus_if->chip) {
> +	case BRCM_CC_4345_CHIP_ID:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
>  static s32 brcmf_translate_country_code(struct brcmf_pub *drvr, char al=
pha2[2],
>  					struct brcmf_fil_country_le *ccreq)
>  {
> @@ -7463,18 +7474,28 @@ static s32 brcmf_translate_country_code(struct b=
rcmf_pub *drvr, char alpha2[2],
>  	s32 found_index;
>  	int i;
>
> -	country_codes =3D drvr->settings->country_codes;
> -	if (!country_codes) {
> -		brcmf_dbg(TRACE, "No country codes configured for device\n");
> -		return -EINVAL;
> -	}
> -
>  	if ((alpha2[0] =3D=3D ccreq->country_abbrev[0]) &&
>  	    (alpha2[1] =3D=3D ccreq->country_abbrev[1])) {
>  		brcmf_dbg(TRACE, "Country code already set\n");
>  		return -EAGAIN;
>  	}
>
> +	country_codes =3D drvr->settings->country_codes;
> +	if (!country_codes) {
> +		if (brmcf_use_iso3166_ccode_fallback(drvr)) {
> +			brcmf_dbg(TRACE, "No country codes configured for device, using ISO3=
166 code and 0 rev\n");
> +			memset(ccreq, 0, sizeof(*ccreq));
> +			ccreq->country_abbrev[0] =3D alpha2[0];
> +			ccreq->country_abbrev[1] =3D alpha2[1];
> +			ccreq->ccode[0] =3D alpha2[0];
> +			ccreq->ccode[1] =3D alpha2[1];
> +			return 0;
> +		}
> +
> +		brcmf_dbg(TRACE, "No country codes configured for device\n");
> +		return -EINVAL;
> +	}
> +
>  	found_index =3D -1;
>  	for (i =3D 0; i < country_codes->table_size; i++) {
>  		cc =3D &country_codes->table[i];

