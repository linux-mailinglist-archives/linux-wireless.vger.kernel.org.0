Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA4C5EE202
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Sep 2022 18:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiI1QkQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Sep 2022 12:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiI1QkF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Sep 2022 12:40:05 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A19B5D10A
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 09:40:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e18so18056301edj.3
        for <linux-wireless@vger.kernel.org>; Wed, 28 Sep 2022 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=KmElrC7F5tHMaPijbx9N71E4W2KEQZa7v8x5WtRfLWY=;
        b=cb+FPaLCsny/Al6NIVhFb/GyWOGJmN2Gu/n8h0+pKDXvd5sJmw1UMDd+5KSekadxMx
         rg/b9CyIwczna7+99NBaKhNWKU98KmfcGE52hHB/4P1rqrJv+A2K9SL314k4SI00rpqX
         ajIbUuD0OWT+OThL0Dx5Oj2D0B01QSG6zX6JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=KmElrC7F5tHMaPijbx9N71E4W2KEQZa7v8x5WtRfLWY=;
        b=1kAImFseJXhhMLhmGplyp4WQb4T088pPz8vq8q4pb1IQuTIwTqO1hdg0eY7uujEbE9
         MTnVZVeudEe6GZ9f9BKLpC9MCA3UmArL8Lysax3HJUTb19sID1EQ0AvinZbvhsOrQpOm
         7+9pxpZgBXESi45AvWuEOigTwN8ZN8rZ9a7m2MsXCotdp63svMHncPLwuiJe1crfdh8j
         VAMAiZ2P4eEvPlVmLm+Oqyn7JnXdO5bJtymzZBros+4JSuTdMBr1U4Hw97fYNe+jhCvh
         yq17sB5NWDFE/Q68/6Rzng+R8t/lfDeJ14EwlY+N/SwpY+G01NMzNKUDCabkQj0ueGPd
         4caw==
X-Gm-Message-State: ACrzQf2ECta3UtAnsRAv834LUiaWvnHo5tKHYvyaly1c0HcY2a6X8vf3
        dKelTCJ7boV0SI930MJBh1DaidJJpEzuMkRSnBBelw==
X-Google-Smtp-Source: AMsMyM4cqvaxEHx8iDDxzHsLqr+UeJrt51LYF82sNfTVTnbQBmRHTEYmy/1s/aPDk7jGMzwp3mxNjlAdlqe5aM3fmqs=
X-Received: by 2002:aa7:c050:0:b0:453:4427:a947 with SMTP id
 k16-20020aa7c050000000b004534427a947mr34086795edo.172.1664383199851; Wed, 28
 Sep 2022 09:39:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220928092223.22673-1-ian.lin@infineon.com> <20220928092223.22673-2-ian.lin@infineon.com>
In-Reply-To: <20220928092223.22673-2-ian.lin@infineon.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Wed, 28 Sep 2022 09:39:31 -0700
Message-ID: <CA+8PC_d7rs2gj2_gP9u_fSNbTSuFOQt6xFHwbQBXuo9AjTsDdg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection
To:     Ian Lin <ian.lin@infineon.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000006a8a5705e9bf6918"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000006a8a5705e9bf6918
Content-Type: text/plain; charset="UTF-8"

On Wed, Sep 28, 2022 at 2:22 AM Ian Lin <ian.lin@infineon.com> wrote:
>
> From: Wright Feng <wright.feng@cypress.com>
>
> To enable ACS feature in Hostap daemon, dump_survey cfg80211 ops and dump
> obss survey command in firmware side are needed. This patch is for adding
> dump_survey feature and adding DUMP_OBSS feature flag to check if
> firmware supports dump_obss iovar.
>
> Signed-off-by: Wright Feng <wright.feng@cypress.com>
> Signed-off-by: Chi-hsien Lin <chi-hsien.lin@cypress.com>
> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 256 ++++++++++++++++++
>  .../broadcom/brcm80211/brcmfmac/feature.c     |   3 +-
>  .../broadcom/brcm80211/brcmfmac/feature.h     |   4 +-
>  3 files changed, 261 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> index 42068145a447..f16dad462eb2 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> @@ -88,9 +88,39 @@
>
>  #define BRCMF_PS_MAX_TIMEOUT_MS                2000
>
> +/* Dump obss definitions */
> +#define ACS_MSRMNT_DELAY               100
> +#define CHAN_NOISE_DUMMY               (-80)
> +#define OBSS_TOKEN_IDX                 15
> +#define IBSS_TOKEN_IDX                 15
> +#define TX_TOKEN_IDX                   14
> +#define CTG_TOKEN_IDX                  13
> +#define PKT_TOKEN_IDX                  15
> +#define IDLE_TOKEN_IDX                 12
> +
>  #define BRCMF_ASSOC_PARAMS_FIXED_SIZE \
>         (sizeof(struct brcmf_assoc_params_le) - sizeof(u16))
>
> +struct brcmf_dump_survey {
> +       u32 obss;
> +       u32 ibss;
> +       u32 no_ctg;
> +       u32 no_pckt;
> +       u32 tx;
> +       u32 idle;
> +};
> +
> +struct cca_stats_n_flags {
> +       u32 msrmnt_time; /* Time for Measurement (msec) */
> +       u32 msrmnt_done; /* flag set when measurement complete */
> +       char buf[1];
> +};
> +
> +struct cca_msrmnt_query {
> +       u32 msrmnt_query;
> +       u32 time_req;
> +};
> +
>  static bool check_vif_up(struct brcmf_cfg80211_vif *vif)
>  {
>         if (!test_bit(BRCMF_VIF_STATUS_READY, &vif->sme_state)) {
> @@ -7549,6 +7579,229 @@ static s32 brcmf_translate_country_code(struct brcmf_pub *drvr, char alpha2[2],
>         return 0;
>  }
>
> +static int
> +brcmf_parse_dump_obss(char *buf, struct brcmf_dump_survey *survey)
> +{
> +       int i;
> +       char *token;
> +       char delim[] = "\n ";
> +       unsigned long val;
> +       int err = 0;
> +
> +       token = strsep(&buf, delim);
> +       while (token) {
> +               if (!strcmp(token, "OBSS")) {
> +                       for (i = 0; i < OBSS_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->obss = val;
> +               }
> +
> +               if (!strcmp(token, "IBSS")) {
> +                       for (i = 0; i < IBSS_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->ibss = val;
> +               }
> +
> +               if (!strcmp(token, "TXDur")) {
> +                       for (i = 0; i < TX_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->tx = val;
> +               }
> +
> +               if (!strcmp(token, "Category")) {
> +                       for (i = 0; i < CTG_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->no_ctg = val;
> +               }
> +
> +               if (!strcmp(token, "Packet")) {
> +                       for (i = 0; i < PKT_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->no_pckt = val;
> +               }
> +
> +               if (!strcmp(token, "Opp(time):")) {
> +                       for (i = 0; i < IDLE_TOKEN_IDX; i++)
> +                               token = strsep(&buf, delim);
> +                       err = kstrtoul(token, 10, &val);
> +                       if (err)
> +                               break;
> +                       survey->idle = val;
> +               }
> +
> +               token = strsep(&buf, delim);
> +       }
> +
> +       return err;
> +}
> +
> +static int
> +brcmf_dump_obss(struct brcmf_if *ifp, struct cca_msrmnt_query req,
> +               struct brcmf_dump_survey *survey)
> +{
> +       struct cca_stats_n_flags *results;
> +       char *buf;
> +       int err;
> +
> +       buf = kzalloc(sizeof(char) * BRCMF_DCMD_MEDLEN, GFP_KERNEL);
> +       if (unlikely(!buf)) {
> +               brcmf_err("%s: buf alloc failed\n", __func__);
> +               return -ENOMEM;
> +       }
> +
> +       memcpy(buf, &req, sizeof(struct cca_msrmnt_query));
> +       err = brcmf_fil_iovar_data_get(ifp, "dump_obss",
> +                                      buf, BRCMF_DCMD_MEDLEN);
> +       if (err < 0) {
> +               brcmf_err("dump_obss error (%d)\n", err);
> +               goto exit;
> +       }
> +       results = (struct cca_stats_n_flags *)(buf);
> +
> +       if (req.msrmnt_query)
> +               brcmf_parse_dump_obss(results->buf, survey);
> +
> +       kfree(buf);
> +       return 0;
> +exit:
> +       kfree(buf);
> +       return -EINVAL;
> +}
> +
> +static s32
> +cfg80211_set_channel(struct wiphy *wiphy, struct net_device *dev,
> +                    struct ieee80211_channel *chan,
> +                    enum nl80211_channel_type channel_type)
> +{
> +       u16 chspec = 0;
> +       int err = 0;
> +       struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
> +       struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
> +
> +       /* set_channel */
> +       chspec = channel_to_chanspec(&cfg->d11inf, chan);
> +       if (chspec != INVCHANSPEC) {
> +               err = brcmf_fil_iovar_int_set(ifp, "chanspec", chspec);
> +               if (err) {
> +                       err = -EINVAL;
> +                       brcmf_err("set chanspec 0x%04x fail\n", chspec);

Why not also print the original err before overwriting it.

> +               }
> +       } else {
> +               brcmf_err("failed to convert host chanspec to fw chanspec\n");
> +               err = -EINVAL;
> +       }
> +
> +       return err;
> +}
> +
> +static int
> +brcmf_cfg80211_dump_survey(struct wiphy *wiphy, struct net_device *ndev,
> +                          int idx, struct survey_info *info)
> +{
> +       struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
> +       struct brcmf_if *ifp = netdev_priv(cfg_to_ndev(cfg));
> +       struct brcmf_dump_survey survey = {};
> +       struct ieee80211_supported_band *band;
> +       struct ieee80211_channel *chan;
> +       struct cca_msrmnt_query req;
> +       u32 val, noise;
> +       int err;
> +
> +       brcmf_dbg(TRACE, "Enter: channel idx=%d\n", idx);
> +
> +       band = wiphy->bands[NL80211_BAND_2GHZ];
> +       if (band && idx >= band->n_channels) {
> +               idx -= band->n_channels;
> +               band = NULL;
> +       }
> +
> +       if (!band || idx >= band->n_channels) {
> +               band = wiphy->bands[NL80211_BAND_5GHZ];
> +               if (idx >= band->n_channels)
> +                       return -ENOENT;
> +       }
> +
> +       /* Setting current channel to the requested channel */
> +       chan = &band->channels[idx];
> +       err = cfg80211_set_channel(wiphy, ndev, chan, NL80211_CHAN_HT20);
> +       if (err) {
> +               info->channel = chan;
> +               info->filled = 0;
> +               return 0;
> +       }
> +
> +       if (!idx) {
> +               /* Disable mpc */
> +               val = 0;
> +               brcmf_set_mpc(ifp, val);
> +               /* Set interface up, explicitly. */
> +               val = 1;
> +               err = brcmf_fil_cmd_int_set(ifp, BRCMF_C_UP, val);
> +               if (err) {
> +                       brcmf_err("BRCMF_C_UP error (%d)\n", err);
> +                       return -EIO;
> +               }
> +       }
> +
> +       /* Get noise value */
> +       err = brcmf_fil_cmd_int_get(ifp, BRCMF_C_GET_PHY_NOISE, &noise);
> +       if (err) {
> +               brcmf_err("Get Phy Noise failed, error = %d\n", err);
> +               noise = CHAN_NOISE_DUMMY;
> +       }
> +
> +       /* Start Measurement for obss stats on current channel */
> +       req.msrmnt_query = 0;
> +       req.time_req = ACS_MSRMNT_DELAY;
> +       err = brcmf_dump_obss(ifp, req, &survey);
> +       if (err)
> +               goto exit;
> +
> +       /* Add 10 ms for IOVAR completion */
> +       msleep(ACS_MSRMNT_DELAY + 10);
> +
> +       /* Issue IOVAR to collect measurement results */
> +       req.msrmnt_query = 1;
> +       err = brcmf_dump_obss(ifp, req, &survey);
> +       if (err < 0)
> +               goto exit;
> +
> +       info->channel = chan;
> +       info->noise = noise;
> +       info->time = ACS_MSRMNT_DELAY;
> +       info->time_busy = ACS_MSRMNT_DELAY - survey.idle;
> +       info->time_rx = survey.obss + survey.ibss + survey.no_ctg +
> +               survey.no_pckt;
> +       info->time_tx = survey.tx;
> +       info->filled = SURVEY_INFO_NOISE_DBM | SURVEY_INFO_TIME |
> +               SURVEY_INFO_TIME_BUSY | SURVEY_INFO_TIME_RX |
> +               SURVEY_INFO_TIME_TX;
> +
> +       brcmf_dbg(INFO, "OBSS dump: channel %d: survey duraion %d\n",

s/duraion/duration

> +                 ieee80211_frequency_to_channel(chan->center_freq),
> +                 ACS_MSRMNT_DELAY);
> +       brcmf_dbg(INFO, "noise(%d) busy(%llu) rx(%llu) tx(%llu)\n",
> +                 info->noise, info->time_busy, info->time_rx, info->time_tx);
> +
> +exit:
> +       return err;
> +}
> +
>  static void brcmf_cfg80211_reg_notifier(struct wiphy *wiphy,
>                                         struct regulatory_request *req)
>  {
> @@ -7700,6 +7953,9 @@ struct brcmf_cfg80211_info *brcmf_cfg80211_attach(struct brcmf_pub *drvr,
>         if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_WOWL_GTK))
>                 ops->set_rekey_data = brcmf_cfg80211_set_rekey_data;
>  #endif
> +       if (brcmf_feat_is_enabled(ifp, BRCMF_FEAT_DUMP_OBSS))
> +               ops->dump_survey = brcmf_cfg80211_dump_survey;
> +
>         err = wiphy_register(wiphy);
>         if (err < 0) {
>                 bphy_err(drvr, "Could not register wiphy device (%d)\n", err);
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> index 2c2f3e026c13..10bac865d724 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.c
> @@ -143,7 +143,7 @@ static void brcmf_feat_iovar_int_get(struct brcmf_if *ifp,
>         ifp->fwil_fwerr = true;
>
>         err = brcmf_fil_iovar_int_get(ifp, name, &data);
> -       if (err == 0) {
> +       if (err != -BRCMF_FW_UNSUPPORTED) {
>                 brcmf_dbg(INFO, "enabling feature: %s\n", brcmf_feat_names[id]);
>                 ifp->drvr->feat_flags |= BIT(id);
>         } else {
> @@ -281,6 +281,7 @@ void brcmf_feat_attach(struct brcmf_pub *drvr)
>         brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_RSDB, "rsdb_mode");
>         brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_TDLS, "tdls_enable");
>         brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_MFP, "mfp");
> +       brcmf_feat_iovar_int_get(ifp, BRCMF_FEAT_DUMP_OBSS, "dump_obss");
>
>         pfn_mac.version = BRCMF_PFN_MACADDR_CFG_VER;
>         err = brcmf_fil_iovar_data_get(ifp, "pfn_macaddr", &pfn_mac,
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> index d1f4257af696..f1b086a69d73 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/feature.h
> @@ -29,6 +29,7 @@
>   * DOT11H: firmware supports 802.11h
>   * SAE: simultaneous authentication of equals
>   * FWAUTH: Firmware authenticator
> + * DUMP_OBSS: Firmware has capable to dump obss info to support ACS
>   */
>  #define BRCMF_FEAT_LIST \
>         BRCMF_FEAT_DEF(MBSS) \
> @@ -51,7 +52,8 @@
>         BRCMF_FEAT_DEF(MONITOR_FMT_HW_RX_HDR) \
>         BRCMF_FEAT_DEF(DOT11H) \
>         BRCMF_FEAT_DEF(SAE) \
> -       BRCMF_FEAT_DEF(FWAUTH)
> +       BRCMF_FEAT_DEF(FWAUTH) \
> +       BRCMF_FEAT_DEF(DUMP_OBSS)
>
>  /*
>   * Quirks:
> --
> 2.25.0
>

--0000000000006a8a5705e9bf6918
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
BZrfei1PlO2m9d3AfpeD7Y1pVL1SrZC1yvhXeDO463M8rGKz/l8XZrJY1P6qU8U6QwxjFgXr5o5B
9N6Yw9IhwXhZI3m6F1pe3mMdZ9cFC3xS3Ke+awIDAQABo4IB2DCCAdQwDgYDVR0PAQH/BAQDAgWg
MIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUFBzABhjVo
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMDBNBgNV
HSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2ln
bi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAiBgNVHREEGzAZ
gRdmcmFua3kubGluQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAW
gBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQU0v383z+6bcUXkukYi4fq7VBiM6swDQYJ
KoZIhvcNAQELBQADggEBABUIiuJPuLq9vbb6/7d0VJ6LS6osA6kNs0Tph9iEX49TxPQJtvA97oy4
AgPCjWNiAMLkmu+kNQKlNZG3Vl3S4A+VMOogB6aKtiLlz73Cs0sPgpohw6GSS41TKVt17PrAzo0o
/xuXczzIbtvrpoi6OnGlsW4aVCqQSOqKUamG8wU8u3/h+iPM1rr4z6ZHdyrllNi+ukH/Z6Dpn6wF
ATUa+n5ReFZpli4TzcqVHw7i+OaB23TMHCwed4OPFm0H3zcCJgVtgt3z95IPak7bBuYLAGMT2c3K
Xkdn27MnpydqZw5mnP970DgyUMHXY3Jvj65UAVioJUr4LkNBL7Tsk/6q0FExggJtMIICaQIBATBr
MFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9i
YWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxcbvtv+NUbtJoPDWwwDQYJYIZI
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP2oS1oy0oKTisnTmznVCINLVPQdCc4LLyT++Fwo
wEyKMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDkyODE2NDAw
MFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQADetDChtq8IcX2b3z2u79Z1hyjx/mvpTPDQGvP7e6gAzuNzFNOu1jkYXH9
ZNzgZwUajeqpolpEAbq1WzfffjMT1xiPFX/x+JEQPShyhLF43UJ1XLDpyhQj1SdJOsBJFzzYGIuV
2JSRvOhNhDEPC9zh3vaPCw7XadD+UfBCDQLT2Pi0xOPKeCEG12TP2iiXcefJnTD13E1UBSpoy0tA
XfFd5eG22yUYrWcmqA1LMWJZvGC2d+cWIU2Vk4etMEE/HZYzPPkQAQ09Wz1s69Fas25OD3hthuyi
tuxMwSaLrCgaSDluO8nB65ev6MnJW1GKvbWU+D9rbYscGYRY1IJSFXPJ
--0000000000006a8a5705e9bf6918--
