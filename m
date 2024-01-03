Return-Path: <linux-wireless+bounces-1447-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751BB822F05
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 14:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF6D1F240F8
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jan 2024 13:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5189419BCA;
	Wed,  3 Jan 2024 13:58:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BFE19BC3
	for <linux-wireless@vger.kernel.org>; Wed,  3 Jan 2024 13:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-555e07761acso4053113a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jan 2024 05:58:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704290321; x=1704895121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ3XeMcWsVUllX9V0QIL1VvnGWkTTrRwIhSABrbioIM=;
        b=w++txrCUvHcNHh8UYyUijUVBfwEYDkHF+iGsA5Q7RusMslQJ9BwQ0R1aiClO/dtkTi
         9dpxVCdKTaFE1fxPMV5narmFGaOXb+/INxaQZpQ47/G6p77tDuJmdqjbWdpDkJYlunLS
         EIF0bAC/gZpyBcZXrXpXEFbolO16bgSuU9+is90nOHvWV7ZuuN8ebqxBEFtdSQBXw+ny
         RPhGRkPvUBO/DZxPa97GTri2IfDfWp19dXiPYDOHboV4LHTcCcB61TphFR9HBCAsdALR
         OCMKDdUlz4CmRKjKpZNdRKuCFTJT2SnN3VSE6+kXPpOUE/fZ9hINC9DnEdMbFdxEX2Ka
         v8LQ==
X-Gm-Message-State: AOJu0YzFKd5nTIYj0Zf5i75JdZitXf5AzRK9BXQwn8euWnJrrO9obTpf
	xwvZ6MDoF806V9SL6nKhP4rdOP+MniQo1/Mn
X-Google-Smtp-Source: AGHT+IEpoyAHlkazG+b74g7a3y0+irFlIvab9NmLypYc06IuxAvronOJq2ZlmFz+nqFa1gCv1KLPxg==
X-Received: by 2002:a17:906:fc09:b0:a27:9a38:1768 with SMTP id ov9-20020a170906fc0900b00a279a381768mr2302960ejb.93.1704290320732;
        Wed, 03 Jan 2024 05:58:40 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id fg8-20020a1709069c4800b00a26aaad6618sm9541735ejc.35.2024.01.03.05.58.40
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jan 2024 05:58:40 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a27cc46d40bso346255466b.0
        for <linux-wireless@vger.kernel.org>; Wed, 03 Jan 2024 05:58:40 -0800 (PST)
X-Received: by 2002:a17:907:c99b:b0:a23:7576:3552 with SMTP id
 uj27-20020a170907c99b00b00a2375763552mr4843029ejc.45.1704290320254; Wed, 03
 Jan 2024 05:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103095704.135651-1-arend.vanspriel@broadcom.com> <20240103095704.135651-5-arend.vanspriel@broadcom.com>
In-Reply-To: <20240103095704.135651-5-arend.vanspriel@broadcom.com>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 3 Jan 2024 08:58:03 -0500
X-Gmail-Original-Message-ID: <CAEg-Je-M6cWGUGHZCGgEAuZJbTokj04DVUpzE21OHZTiot_xKQ@mail.gmail.com>
Message-ID: <CAEg-Je-M6cWGUGHZCGgEAuZJbTokj04DVUpzE21OHZTiot_xKQ@mail.gmail.com>
Subject: Re: [PATCH V2 4/4] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	Hector Martin <marcan@marcan.st>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 4:57=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
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
> [arend.vanspriel@broadcom.com: use multi-vendor framework]
> Signed-off-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 56 ++++++++-----------
>  .../broadcom/brcm80211/brcmfmac/cfg80211.h    |  2 +
>  .../broadcom/brcm80211/brcmfmac/cyw/core.c    | 28 ++++++++++
>  .../broadcom/brcm80211/brcmfmac/fwil.c        |  1 +
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h  |  2 +-
>  .../broadcom/brcm80211/brcmfmac/fwvid.h       | 13 +++++
>  .../broadcom/brcm80211/brcmfmac/wcc/core.c    |  9 +++
>  7 files changed, 76 insertions(+), 35 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 4df3d53bf5d3..03e5d4f986ca 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -32,6 +32,7 @@
>  #include "vendor.h"
>  #include "bus.h"
>  #include "common.h"
> +#include "fwvid.h"
>
>  #define BRCMF_SCAN_IE_LEN_MAX          2048
>
> @@ -1687,52 +1688,39 @@ static u16 brcmf_map_fw_linkdown_reason(const str=
uct brcmf_event_msg *e)
>         return reason;
>  }
>
> -static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 p=
mk_len)
> +int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16=
 flags)
>  {
>         struct brcmf_pub *drvr =3D ifp->drvr;
>         struct brcmf_wsec_pmk_le pmk;
>         int err;
>
> +       if (key_len > sizeof(pmk.key)) {
> +               bphy_err(drvr, "key must be less than %zu bytes\n",
> +                        sizeof(pmk.key));
> +               return -EINVAL;
> +       }
> +
>         memset(&pmk, 0, sizeof(pmk));
>
> -       /* pass pmk directly */
> -       pmk.key_len =3D cpu_to_le16(pmk_len);
> -       pmk.flags =3D cpu_to_le16(0);
> -       memcpy(pmk.key, pmk_data, pmk_len);
> +       /* pass key material directly */
> +       pmk.key_len =3D cpu_to_le16(key_len);
> +       pmk.flags =3D cpu_to_le16(flags);
> +       memcpy(pmk.key, key, key_len);
>
> -       /* store psk in firmware */
> +       /* store key material in firmware */
>         err =3D brcmf_fil_cmd_data_set(ifp, BRCMF_C_SET_WSEC_PMK,
>                                      &pmk, sizeof(pmk));
>         if (err < 0)
>                 bphy_err(drvr, "failed to change PSK in firmware (len=3D%=
u)\n",
> -                        pmk_len);
> +                        key_len);
>
>         return err;
>  }
> +BRCMF_EXPORT_SYMBOL_GPL(brcmf_set_wsec);
>
> -static int brcmf_set_sae_password(struct brcmf_if *ifp, const u8 *pwd_da=
ta,
> -                                 u16 pwd_len)
> +static int brcmf_set_pmk(struct brcmf_if *ifp, const u8 *pmk_data, u16 p=
mk_len)
>  {
> -       struct brcmf_pub *drvr =3D ifp->drvr;
> -       struct brcmf_wsec_sae_pwd_le sae_pwd;
> -       int err;
> -
> -       if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
> -               bphy_err(drvr, "sae_password must be less than %d\n",
> -                        BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
> -               return -EINVAL;
> -       }
> -
> -       sae_pwd.key_len =3D cpu_to_le16(pwd_len);
> -       memcpy(sae_pwd.key, pwd_data, pwd_len);
> -
> -       err =3D brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
> -                                      sizeof(sae_pwd));
> -       if (err < 0)
> -               bphy_err(drvr, "failed to set SAE password in firmware (l=
en=3D%u)\n",
> -                        pwd_len);
> -
> -       return err;
> +       return brcmf_set_wsec(ifp, pmk_data, pmk_len, 0);
>  }
>
>  static void brcmf_link_down(struct brcmf_cfg80211_vif *vif, u16 reason,
> @@ -2503,8 +2491,7 @@ brcmf_cfg80211_connect(struct wiphy *wiphy, struct =
net_device *ndev,
>                         bphy_err(drvr, "failed to clean up user-space RSN=
E\n");
>                         goto done;
>                 }
> -               err =3D brcmf_set_sae_password(ifp, sme->crypto.sae_pwd,
> -                                            sme->crypto.sae_pwd_len);
> +               err =3D brcmf_fwvid_set_sae_password(ifp, &sme->crypto);
>                 if (!err && sme->crypto.psk)
>                         err =3D brcmf_set_pmk(ifp, sme->crypto.psk,
>                                             BRCMF_WSEC_MAX_PSK_LEN);
> @@ -5252,8 +5239,7 @@ brcmf_cfg80211_start_ap(struct wiphy *wiphy, struct=
 net_device *ndev,
>                 if (crypto->sae_pwd) {
>                         brcmf_dbg(INFO, "using SAE offload\n");
>                         profile->use_fwauth |=3D BIT(BRCMF_PROFILE_FWAUTH=
_SAE);
> -                       err =3D brcmf_set_sae_password(ifp, crypto->sae_p=
wd,
> -                                                    crypto->sae_pwd_len)=
;
> +                       err =3D brcmf_fwvid_set_sae_password(ifp, crypto)=
;
>                         if (err < 0)
>                                 goto exit;
>                 }
> @@ -5360,10 +5346,12 @@ static int brcmf_cfg80211_stop_ap(struct wiphy *w=
iphy, struct net_device *ndev,
>                 msleep(400);
>
>                 if (profile->use_fwauth !=3D BIT(BRCMF_PROFILE_FWAUTH_NON=
E)) {
> +                       struct cfg80211_crypto_settings crypto =3D {};
> +
>                         if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUT=
H_PSK))
>                                 brcmf_set_pmk(ifp, NULL, 0);
>                         if (profile->use_fwauth & BIT(BRCMF_PROFILE_FWAUT=
H_SAE))
> -                               brcmf_set_sae_password(ifp, NULL, 0);
> +                               brcmf_fwvid_set_sae_password(ifp, &crypto=
);
>                         profile->use_fwauth =3D BIT(BRCMF_PROFILE_FWAUTH_=
NONE);
>                 }
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> index 0e1fa3f0dea2..dc3a6a537507 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.h
> @@ -468,4 +468,6 @@ void brcmf_set_mpc(struct brcmf_if *ndev, int mpc);
>  void brcmf_abort_scanning(struct brcmf_cfg80211_info *cfg);
>  void brcmf_cfg80211_free_netdev(struct net_device *ndev);
>
> +int brcmf_set_wsec(struct brcmf_if *ifp, const u8 *key, u16 key_len, u16=
 flags);
> +
>  #endif /* BRCMFMAC_CFG80211_H */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> index b75652ba9359..24670497f1a4 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> @@ -7,6 +7,7 @@
>  #include <core.h>
>  #include <bus.h>
>  #include <fwvid.h>
> +#include <fwil.h>
>
>  #include "vops.h"
>
> @@ -21,7 +22,34 @@ static void brcmf_cyw_detach(struct brcmf_pub *drvr)
>         pr_err("%s: executing\n", __func__);
>  }
>
> +static int brcmf_cyw_set_sae_pwd(struct brcmf_if *ifp,
> +                                struct cfg80211_crypto_settings *crypto)
> +{
> +       struct brcmf_pub *drvr =3D ifp->drvr;
> +       struct brcmf_wsec_sae_pwd_le sae_pwd;
> +       u16 pwd_len =3D crypto->sae_pwd_len;
> +       int err;
> +
> +       if (pwd_len > BRCMF_WSEC_MAX_SAE_PASSWORD_LEN) {
> +               bphy_err(drvr, "sae_password must be less than %d\n",
> +                        BRCMF_WSEC_MAX_SAE_PASSWORD_LEN);
> +               return -EINVAL;
> +       }
> +
> +       sae_pwd.key_len =3D cpu_to_le16(pwd_len);
> +       memcpy(sae_pwd.key, crypto->sae_pwd, pwd_len);
> +
> +       err =3D brcmf_fil_iovar_data_set(ifp, "sae_password", &sae_pwd,
> +                                      sizeof(sae_pwd));
> +       if (err < 0)
> +               bphy_err(drvr, "failed to set SAE password in firmware (l=
en=3D%u)\n",
> +                        pwd_len);
> +
> +       return err;
> +}
> +
>  const struct brcmf_fwvid_ops brcmf_cyw_ops =3D {
>         .attach =3D brcmf_cyw_attach,
>         .detach =3D brcmf_cyw_detach,
> +       .set_sae_password =3D brcmf_cyw_set_sae_pwd,
>  };
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c b/dr=
ivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
> index 2aec7d2abd52..bc1c6b5a6e31 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil.c
> @@ -211,6 +211,7 @@ brcmf_fil_iovar_data_set(struct brcmf_if *ifp, const =
char *name, const void *dat
>         mutex_unlock(&drvr->proto_block);
>         return err;
>  }
> +BRCMF_EXPORT_SYMBOL_GPL(brcmf_fil_iovar_data_set);
>
>  s32
>  brcmf_fil_iovar_data_get(struct brcmf_if *ifp, const char *name, void *d=
ata,
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.=
h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> index 9d248ba1c0b2..e74a23e11830 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h
> @@ -584,7 +584,7 @@ struct brcmf_wsec_key_le {
>  struct brcmf_wsec_pmk_le {
>         __le16  key_len;
>         __le16  flags;
> -       u8 key[2 * BRCMF_WSEC_MAX_PSK_LEN + 1];
> +       u8 key[BRCMF_WSEC_MAX_SAE_PASSWORD_LEN];
>  };
>
>  /**
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h b/d=
rivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> index 17fbdbb76f51..d9fc76b46db9 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwvid.h
> @@ -6,6 +6,7 @@
>  #define FWVID_H_
>
>  #include "firmware.h"
> +#include "cfg80211.h"
>
>  struct brcmf_pub;
>  struct brcmf_if;
> @@ -14,6 +15,7 @@ struct brcmf_fwvid_ops {
>         int (*attach)(struct brcmf_pub *drvr);
>         void (*detach)(struct brcmf_pub *drvr);
>         void (*feat_attach)(struct brcmf_if *ifp);
> +       int (*set_sae_password)(struct brcmf_if *ifp, struct cfg80211_cry=
pto_settings *crypto);
>  };
>
>  /* exported functions */
> @@ -56,4 +58,15 @@ static inline void brcmf_fwvid_feat_attach(struct brcm=
f_if *ifp)
>         vops->feat_attach(ifp);
>  }
>
> +static inline int brcmf_fwvid_set_sae_password(struct brcmf_if *ifp,
> +                                              struct cfg80211_crypto_set=
tings *crypto)
> +{
> +       const struct brcmf_fwvid_ops *vops =3D ifp->drvr->vops;
> +
> +       if (!vops || !vops->set_sae_password)
> +               return -EOPNOTSUPP;
> +
> +       return vops->set_sae_password(ifp, crypto);
> +}
> +
>  #endif /* FWVID_H_ */
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c =
b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/wcc/core.c
> index 5573a47766ad..2d8f80bd7382 100644
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
> @@ -21,7 +22,15 @@ static void brcmf_wcc_detach(struct brcmf_pub *drvr)
>         pr_debug("%s: executing\n", __func__);
>  }
>
> +static int brcmf_wcc_set_sae_pwd(struct brcmf_if *ifp,
> +                                struct cfg80211_crypto_settings *crypto)
> +{
> +       return brcmf_set_wsec(ifp, crypto->sae_pwd, crypto->sae_pwd_len,
> +                             BRCMF_WSEC_PASSPHRASE);
> +}
> +
>  const struct brcmf_fwvid_ops brcmf_wcc_ops =3D {
>         .attach =3D brcmf_wcc_attach,
>         .detach =3D brcmf_wcc_detach,
> +       .set_sae_password =3D brcmf_wcc_set_sae_pwd,
>  };
> --
> 2.32.0
>

Though my R-b tag is there already from the previous version, this
patch still looks good to me to land.

Thanks for adapting it for the multi-vendor framework. :)



--
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

