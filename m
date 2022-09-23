Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FF95E7FFF
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 18:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiIWQjL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbiIWQiv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 12:38:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371E82B6
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 09:37:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id y8so940567edc.10
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 09:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=U6zWkSVm/5XUfJKQftexYROvC3O3dH2P6snXPJakddg=;
        b=THDXxbvQB+gUm66nAVHSpJp00nmx71MONe3lj+v0LvAcRQelbHV5xaxHQ13ytwalpg
         yC1qWSgJAFAXxosxaa0sYfdIyrsig2shTlBls9N7DisJcT8oVaxyfrjMzWCWT0+T/lK3
         G+u4vbrPlyuubUJ7oG1+WGhkPzByZRKnpJ3sk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=U6zWkSVm/5XUfJKQftexYROvC3O3dH2P6snXPJakddg=;
        b=HNjuCysn46jApweRFNuUKDfTZBFLGAs4kYW+6HJbXyvRROR7dGuESeQW94E8Up8xZJ
         ZdsyLYw5AxPLGaBKx/2KtkcyxthLQsKfn/Nw8br5Tkg+mCXvozVC3HhHuR5fOs38DVze
         3lWW9UCDsR8RQ6+BHO2revhau8MxpxZCjJKjQqMQVA2FC+z77abUtAg6I7Z2v38wGolQ
         fXN7s/vZ5U/OFvLrVwtPx2YyxB9vjJcKeqNB9XWgzPDLSsMhMiHDUoV5r8SAfxFxE5RH
         pnENk8RIFJJgue8Nmo0FjtRBF6g7W9S9eqMAukY472N9qD6gDU7R1sr/NnIXSW14hwhT
         Gqww==
X-Gm-Message-State: ACrzQf0Hj6QVNKwBf+soyPzaERTY5vuHTBbUgigjxJDaGG+swNHJZ7JM
        R9QUmacdXBDtrE4o/DnA9JoZokoWyXkwwh2ujs6ong==
X-Google-Smtp-Source: AMsMyM6UWodyC9xRtCJhqfCO5IEkjbsuB5dK5VkhawotusZmepHnROvooRJPDwrzGzCJ/kPUFZYC0GHlkRuVX4uJhZo=
X-Received: by 2002:aa7:d054:0:b0:450:f6b9:bc2e with SMTP id
 n20-20020aa7d054000000b00450f6b9bc2emr9140487edo.413.1663951031136; Fri, 23
 Sep 2022 09:37:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220921015951.16178-1-ian.lin@infineon.com> <20220921015951.16178-2-ian.lin@infineon.com>
 <CA+8PC_fN+bqfpmQapYqJMyO3kouS9-u_Dwvo_FH8nGhhDP5V5A@mail.gmail.com> <0b102940-0175-7b66-d3c7-822e41ffa1e8@infineon.com>
In-Reply-To: <0b102940-0175-7b66-d3c7-822e41ffa1e8@infineon.com>
From:   Franky Lin <franky.lin@broadcom.com>
Date:   Fri, 23 Sep 2022 09:36:43 -0700
Message-ID: <CA+8PC_dcK1TkJXcBzunJpjSKds5=iA3mVNxgC3fC_i6opzQDPw@mail.gmail.com>
Subject: Re: [PATCH 1/3] brcmfmac: Support DPP feature
To:     "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
Cc:     linux-wireless@vger.kernel.org, brcm80211-dev-list@broadcom.com,
        brcm80211-dev-list@cypress.com, hante.meuleman@broadcom.com,
        kvalo@kernel.org, Double.Lo@infineon.com
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002a8fc505e95acac7"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000002a8fc505e95acac7
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 23, 2022 at 1:20 AM Lin Ian (CSSITB CSS ICW SW WFS / EE)
<ian.lin@infineon.com> wrote:
>
>
>
> On 9/22/2022 1:10 AM, Franky Lin wrote:
> > On Tue, Sep 20, 2022 at 7:04 PM Ian Lin <ian.lin@infineon.com> wrote:
> >> From: Kurt Lee <kurt.lee@cypress.com>
> >>
> >> Let driver parse DPP frames from upper layer and do conresponding
> > corresponding
> Will fix in next version.
>
> >> configuration to firmware.
> >> This change supports DPP handshake based on wpa_supplicant v2.9.
> >>
> >> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
> >> Signed-off-by: Ian Lin <ian.lin@infineon.com>
> >> ---
> >>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 85 ++++++++++++-------
> >>   .../broadcom/brcm80211/brcmfmac/p2p.c         | 72 ++++++++++++----
> >>   .../broadcom/brcm80211/brcmfmac/p2p.h         |  4 +-
> >>   .../broadcom/brcm80211/include/brcmu_wifi.h   |  5 ++
> >>   4 files changed, 117 insertions(+), 49 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >> index 7c72ea26a7d7..4a8aceda8fe8 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
> >> @@ -64,6 +64,9 @@
> >>   #define RSN_CAP_MFPC_MASK              BIT(7)
> >>   #define RSN_PMKID_COUNT_LEN            2
> >>
> >> +#define DPP_AKM_SUITE_TYPE             2
> >> +#define WLAN_AKM_SUITE_DPP             SUITE(WLAN_OUI_WFA, DPP_AKM_SUITE_TYPE)
> > Please use WLAN_AKM_SUITE_WFA_DPP.
> Will fix in next version.
>
> >
> >> +
> >>   #define VNDR_IE_CMD_LEN                        4       /* length of the set command
> >>                                                   * string :"add", "del" (+ NUL)
> >>                                                   */
> >> @@ -1816,6 +1819,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
> >>                          val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
> >>                          profile->is_ft = true;
> >>                          break;
> >> +               case WLAN_AKM_SUITE_DPP:
> >> +                       val = WFA_AUTH_DPP;
> >> +                       break;
> >>                  default:
> >>                          bphy_err(drvr, "invalid akm suite (%d)\n",
> >>                                   sme->crypto.akm_suites[0]);
> >> @@ -4144,6 +4150,12 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
> >>          return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
> >>   }
> >>
> >> +static bool brcmf_valid_dpp_suite(u8 *oui)
> >> +{
> >> +       return (memcmp(oui, WFA_OUI, TLV_OUI_LEN) == 0 &&
> >> +               *(oui + TLV_OUI_LEN) == DPP_AKM_SUITE_TYPE);
> >> +}
> >> +
> >>   static s32
> >>   brcmf_configure_wpaie(struct brcmf_if *ifp,
> >>                        const struct brcmf_vs_tlv *wpa_ie,
> >> @@ -4257,42 +4269,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
> >>                  goto exit;
> >>          }
> >>          for (i = 0; i < count; i++) {
> >> -               if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
> >> +               if (brcmf_valid_dpp_suite(&data[offset])) {
> >> +                       wpa_auth |= WFA_AUTH_DPP;
> >> +                       offset += TLV_OUI_LEN;
> >> +               } else if (brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
> >> +                       offset += TLV_OUI_LEN;
> >> +                       switch (data[offset]) {
> >> +                       case RSN_AKM_NONE:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
> >> +                               wpa_auth |= WPA_AUTH_NONE;
> >> +                               break;
> >> +                       case RSN_AKM_UNSPECIFIED:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
> >> +                               is_rsn_ie ?
> >> +                                       (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
> >> +                                       (wpa_auth |= WPA_AUTH_UNSPECIFIED);
> >> +                               break;
> >> +                       case RSN_AKM_PSK:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
> >> +                               is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
> >> +                                           (wpa_auth |= WPA_AUTH_PSK);
> >> +                               break;
> >> +                       case RSN_AKM_SHA256_PSK:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
> >> +                               wpa_auth |= WPA2_AUTH_PSK_SHA256;
> >> +                               break;
> >> +                       case RSN_AKM_SHA256_1X:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
> >> +                               wpa_auth |= WPA2_AUTH_1X_SHA256;
> >> +                               break;
> >> +                       case RSN_AKM_SAE:
> >> +                               brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
> >> +                               wpa_auth |= WPA3_AUTH_SAE_PSK;
> >> +                               break;
> >> +                       default:
> >> +                               bphy_err(drvr, "Invalid key mgmt info\n");
> >> +                       }
> >> +               } else {
> > Only check for invalid case here
> >      if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie) &&
> >              !brcmf_valid_dpp_suite(&data[offset])) {
> >
> > And keep the switch below but add a new case for DPP_AKM_SUITE_TYPE.
> The two authentication type refer to equal value: DPP_AKM_SUITE_TYPE &
> RSN_AKM_PSK (both =2)
> So I can not directly place DPP_AKM_SUITE_TYPE into switch case.
>
> It's more reasonable that we firstly check if it's DPP by
> brcmf_valid_dpp_suite
>   - need to check WFA_OUI and DPP_AKM_SUITE_TYPE
> Then go to the other cases.
>
> >>                          err = -EINVAL;
> >>                          bphy_err(drvr, "ivalid OUI\n");
> >>                          goto exit;
> >>                  }
> >> -               offset += TLV_OUI_LEN;
> >> -               switch (data[offset]) {
> >> -               case RSN_AKM_NONE:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
> >> -                       wpa_auth |= WPA_AUTH_NONE;
> >> -                       break;
> >> -               case RSN_AKM_UNSPECIFIED:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
> >> -                       is_rsn_ie ? (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
> >> -                                   (wpa_auth |= WPA_AUTH_UNSPECIFIED);
> >> -                       break;
> >> -               case RSN_AKM_PSK:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
> >> -                       is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
> >> -                                   (wpa_auth |= WPA_AUTH_PSK);
> >> -                       break;
> >> -               case RSN_AKM_SHA256_PSK:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
> >> -                       wpa_auth |= WPA2_AUTH_PSK_SHA256;
> >> -                       break;
> >> -               case RSN_AKM_SHA256_1X:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
> >> -                       wpa_auth |= WPA2_AUTH_1X_SHA256;
> >> -                       break;
> >> -               case RSN_AKM_SAE:
> >> -                       brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
> >> -                       wpa_auth |= WPA3_AUTH_SAE_PSK;
> >> -                       break;
> >> -               default:
> >> -                       bphy_err(drvr, "Invalid key mgmt info\n");
> >> -               }
> >>                  offset++;
> >>          }
> >>
> >> @@ -4312,10 +4329,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
> >>                                   */
> >>                                  if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
> >>                                                    WPA2_AUTH_1X_SHA256 |
> >> +                                                 WFA_AUTH_DPP |
> >>                                                    WPA3_AUTH_SAE_PSK))) {
> >>                                          err = -EINVAL;
> >>                                          goto exit;
> >>                                  }
> >> +
> >>                                  /* Firmware has requirement that WPA2_AUTH_PSK/
> >>                                   * WPA2_AUTH_UNSPECIFIED be set, if SHA256 OUI
> >>                                   * is to be included in the rsn ie.
> >> @@ -5225,7 +5244,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
> >>                            *cookie, le16_to_cpu(action_frame->len), freq);
> >>
> >>                  ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
> >> -                                                 af_params);
> >> +                                                 af_params, vif);
> >>
> >>                  cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
> >>                                          GFP_KERNEL);
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >> index 479041f070f9..4636fc27e915 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
> >> @@ -231,7 +231,35 @@ static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
> >>          if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
> >>              pact_frm->action == P2P_PUB_AF_ACTION &&
> >>              pact_frm->oui_type == P2P_VER &&
> >> -           memcmp(pact_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
> >> +           memcmp(pact_frm->oui, WFA_OUI, P2P_OUI_LEN) == 0)
> > This change is irrelevant although the two macros are the same. Please
> > have a separate patch to clean up P2P_OUI.
> Will fix in next version.
>
> >> +               return true;
> >> +
> >> +       return false;
> >> +}
> >> +
> >> +/**
> >> + * brcmf_p2p_is_dpp_pub_action() - true if dpp public type frame.
> >> + *
> >> + * @frame: action frame data.
> >> + * @frame_len: length of action frame data.
> >> + *
> >> + * Determine if action frame is dpp public action type
> >> + */
> >> +static bool brcmf_p2p_is_dpp_pub_action(void *frame, u32 frame_len)
> >> +{
> >> +       struct brcmf_p2p_pub_act_frame *pact_frm;
> >> +
> >> +       if (!frame)
> >> +               return false;
> >> +
> >> +       pact_frm = (struct brcmf_p2p_pub_act_frame *)frame;
> >> +       if (frame_len < sizeof(struct brcmf_p2p_pub_act_frame) - 1)
> >> +               return false;
> >> +
> >> +       if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
> >> +           pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
> >> +           pact_frm->oui_type == DPP_VER &&
> >> +           memcmp(pact_frm->oui, WFA_OUI, TLV_OUI_LEN) == 0)
> >>                  return true;
> >>
> >>          return false;
> >> @@ -991,6 +1019,8 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
> >>          if (err)
> >>                  goto exit;
> >>
> >> +       p2p->remin_on_channel_wdev = wdev;
> >> +
> >>          memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
> >>          *cookie = p2p->remain_on_channel_cookie;
> >>          cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
> >> @@ -1014,6 +1044,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
> >>   {
> >>          struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
> >>          struct brcmf_p2p_info *p2p = &cfg->p2p;
> >> +       struct wireless_dev *wdev = p2p->remin_on_channel_wdev;
> >>
> >>          brcmf_dbg(TRACE, "Enter\n");
> >>          if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
> >> @@ -1026,10 +1057,16 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
> >>                          complete(&p2p->wait_next_af);
> >>                  }
> >>
> >> -               cfg80211_remain_on_channel_expired(&ifp->vif->wdev,
> >> +               wdev = p2p->remin_on_channel_wdev ?
> >> +                       p2p->remin_on_channel_wdev :
> >> +                       &ifp->vif->wdev;
> >> +
> >> +               cfg80211_remain_on_channel_expired(wdev,
> >>                                                     p2p->remain_on_channel_cookie,
> >>                                                     &p2p->remain_on_channel,
> >>                                                     GFP_KERNEL);
> >> +               p2p->remin_on_channel_wdev = NULL;
> >> +
> >>          }
> >>          return 0;
> >>   }
> >> @@ -1531,6 +1568,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
> >>    *
> >>    * @p2p: p2p info struct for vif.
> >>    * @af_params: action frame data/info.
> >> + * @vif: vif to send
> >>    *
> >>    * Send an action frame immediately without doing channel synchronization.
> >>    *
> >> @@ -1539,12 +1577,17 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
> >>    * frame is transmitted.
> >>    */
> >>   static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
> >> -                                    struct brcmf_fil_af_params_le *af_params)
> >> +                                    struct brcmf_fil_af_params_le *af_params,
> >> +                                    struct brcmf_cfg80211_vif *vif
> >> +                                    )
> >>   {
> >>          struct brcmf_pub *drvr = p2p->cfg->pub;
> >> -       struct brcmf_cfg80211_vif *vif;
> >> -       struct brcmf_p2p_action_frame *p2p_af;
> >>          s32 err = 0;
> >> +       struct brcmf_fil_action_frame_le *action_frame;
> >> +       u16 action_frame_len;
> >> +
> >> +       action_frame = &af_params->action_frame;
> >> +       action_frame_len = le16_to_cpu(action_frame->len);
> >>
> >>          brcmf_dbg(TRACE, "Enter\n");
> >>
> >> @@ -1552,13 +1595,6 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
> >>          clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
> >>          clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
> >>
> >> -       /* check if it is a p2p_presence response */
> >> -       p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;
> >> -       if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
> >> -               vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
> >> -       else
> >> -               vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
> >> -
> >>          err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
> >>                                          sizeof(*af_params));
> >>          if (err) {
> >> @@ -1714,10 +1750,13 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
> >>    * @cfg: driver private data for cfg80211 interface.
> >>    * @ndev: net device to transmit on.
> >>    * @af_params: configuration data for action frame.
> >> + * @vif: virtual interface to send
> >>    */
> >>   bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
> >>                                   struct net_device *ndev,
> >> -                                struct brcmf_fil_af_params_le *af_params)
> >> +                                struct brcmf_fil_af_params_le *af_params,
> >> +                                struct brcmf_cfg80211_vif *vif
> >> +                                )
> >>   {
> >>          struct brcmf_p2p_info *p2p = &cfg->p2p;
> >>          struct brcmf_if *ifp = netdev_priv(ndev);
> >> @@ -1789,7 +1828,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
> >>                          goto exit;
> >>                  }
> >>          } else if (brcmf_p2p_is_p2p_action(action_frame->data,
> >> -                                          action_frame_len)) {
> >> +                                          action_frame_len) ||
> >> +                  brcmf_p2p_is_dpp_pub_action(action_frame->data,
> >> +                                              action_frame_len)) {
> >>                  /* do not configure anything. it will be */
> >>                  /* sent with a default configuration     */
> >>          } else {
> >> @@ -1857,7 +1898,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
> >>                  if (af_params->channel)
> >>                          msleep(P2P_AF_RETRY_DELAY_TIME);
> >>
> >> -               ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
> >> +               ack = !brcmf_p2p_tx_action_frame(p2p, af_params, vif);
> >>                  tx_retry++;
> >>                  dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
> >>                                                                  dwell_jiffies);
> >> @@ -2508,6 +2549,7 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
> >>
> >>          pri_ifp = brcmf_get_ifp(cfg->pub, 0);
> >>          p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
> >> +       init_completion(&p2p->send_af_done);
> >>
> >>          if (p2pdev_forced) {
> >>                  err_ptr = brcmf_p2p_create_p2pdev(p2p, NULL, NULL);
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
> >> index d2ecee565bf2..bbc455238707 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
> >> @@ -138,6 +138,7 @@ struct brcmf_p2p_info {
> >>          bool block_gon_req_tx;
> >>          bool p2pdev_dynamically;
> >>          bool wait_for_offchan_complete;
> >> +       struct wireless_dev *remin_on_channel_wdev;
> > Docstring needs update. Also s/remin/remain
> Will fix in next version.
>
> >>   };
> >>
> >>   s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
> >> @@ -170,7 +171,8 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
> >>                                          void *data);
> >>   bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
> >>                                   struct net_device *ndev,
> >> -                                struct brcmf_fil_af_params_le *af_params);
> >> +                                struct brcmf_fil_af_params_le *af_params,
> >> +                                struct brcmf_cfg80211_vif *vif);
> >>   bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
> >>                                             struct brcmf_bss_info_le *bi);
> >>   s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
> >> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
> >> index 7552bdb91991..3a9cad3730b8 100644
> >> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
> >> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
> >> @@ -233,6 +233,11 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
> >>
> >>   #define WPA3_AUTH_SAE_PSK      0x40000 /* SAE with 4-way handshake */
> >>
> >> +#define WFA_AUTH_DPP           0x200000 /* WFA DPP AUTH */
> > This is incompatible with Broadcom's bit definitions. Please use a per
> > vendor approach.
> We had extended the bit definition.
> The authentication mode will be set to our FW so it's FW-dependent.
> Do you suggest I change the name? like CY_WFA_AUTH_DPP?

Being firmware dependent is exactly the problem here. The user
functions of this macro are in common code path so this bit could go
to firmware from any vendor. A mechanism should be in place to only
set this bit when the driver is working with a infineon/cypress
firmware.

Regards,
- Franky


>
> Thank you for the review.
>
> >> +
> >> +#define WFA_OUI                        "\x50\x6F\x9A"  /* WFA OUI */
> >> +#define DPP_VER                        0x1A    /* WFA DPP v1.0 */
> >> +
> >>   #define DOT11_DEFAULT_RTS_LEN          2347
> >>   #define DOT11_DEFAULT_FRAG_LEN         2346
> >>
> >> --
> >> 2.25.0
> >>
>

--0000000000002a8fc505e95acac7
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
AWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIOhd/U3AUD2XWab1gH4mZDLbDpLJkK/L52C9do5v
MCUEMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIyMDkyMzE2Mzcx
MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQB
AjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkq
hkiG9w0BAQEFAASCAQAhb5oELaZeHBldweqXp//GmFDMvlgDE0ak0+878Sd6l2RZLyRaSsinB+b8
Qn1n0HirARw/2UyS6Aoz3MbG0TJ4nbYm1TGdHit71MKBQmnR2a1E/m0xvsVndLkWQcKp/ZSo+nWv
yO/Xqzdc6uWKOQAv9DfChe/+Cp85pHyUlaEM9bf768yjbgl5C864hBHNO73H7wwP836D5D2MCV8B
WhF0VN1uwc+zHXSv+yUXZbXYU5X2xG3QntvnuPR57tsPlQ1p7L/SXK24aa60dKYyq933X7qwA8uj
zzOCg+oO68Jo7rX0pF669Mn1Jf3W7VltdpK/97qg22W8bUH1cjDyX3nK
--0000000000002a8fc505e95acac7--
