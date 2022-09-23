Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D015E7597
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Sep 2022 10:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbiIWIUR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Sep 2022 04:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiIWIUP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Sep 2022 04:20:15 -0400
Received: from smtp2.infineon.com (smtp2.infineon.com [IPv6:2a00:18f0:1e00:4::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFC07C1C8
        for <linux-wireless@vger.kernel.org>; Fri, 23 Sep 2022 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1663921213; x=1695457213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pG2EWWoNhI8y6tcpi5cL8JHkTHYD9Xsd/NUkDKBTgN4=;
  b=Nvxig7l2LwAdN8PJ6t5TGw99C031tD4RrIx4iE1J5uT7pa2EnWGigjZl
   VpQ822MbjWebxmEg9AC9rIQtrDA95CdLsCJmCosHTauAQHnDbjL07YPnR
   Jz7eLOoZg2wG+2wzUUTEzPE/I7YVwA1oHFgKm9+gyjL8qJnNDNHXRfK/D
   4=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="1584394"
X-IronPort-AV: E=Sophos;i="5.93,337,1654552800"; 
   d="scan'208";a="1584394"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2022 10:20:10 +0200
Received: from MUCSE822.infineon.com (MUCSE822.infineon.com [172.23.29.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 23 Sep 2022 10:20:09 +0200 (CEST)
Received: from MUCSE835.infineon.com (172.23.7.107) by MUCSE822.infineon.com
 (172.23.29.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 10:20:09 +0200
Received: from [10.234.36.68] (10.234.36.68) by MUCSE835.infineon.com
 (172.23.7.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Fri, 23 Sep
 2022 10:20:07 +0200
Message-ID: <0b102940-0175-7b66-d3c7-822e41ffa1e8@infineon.com>
Date:   Fri, 23 Sep 2022 16:20:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 1/3] brcmfmac: Support DPP feature
Content-Language: en-US
To:     Franky Lin <franky.lin@broadcom.com>
CC:     <linux-wireless@vger.kernel.org>,
        <brcm80211-dev-list@broadcom.com>,
        <brcm80211-dev-list@cypress.com>, <hante.meuleman@broadcom.com>,
        <kvalo@kernel.org>, <Double.Lo@infineon.com>
References: <20220921015951.16178-1-ian.lin@infineon.com>
 <20220921015951.16178-2-ian.lin@infineon.com>
 <CA+8PC_fN+bqfpmQapYqJMyO3kouS9-u_Dwvo_FH8nGhhDP5V5A@mail.gmail.com>
From:   "Lin Ian (CSSITB CSS ICW SW WFS / EE)" <ian.lin@infineon.com>
In-Reply-To: <CA+8PC_fN+bqfpmQapYqJMyO3kouS9-u_Dwvo_FH8nGhhDP5V5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.234.36.68]
X-ClientProxiedBy: MUCSE807.infineon.com (172.23.29.33) To
 MUCSE835.infineon.com (172.23.7.107)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



On 9/22/2022 1:10 AM, Franky Lin wrote:
> On Tue, Sep 20, 2022 at 7:04 PM Ian Lin <ian.lin@infineon.com> wrote:
>> From: Kurt Lee <kurt.lee@cypress.com>
>>
>> Let driver parse DPP frames from upper layer and do conresponding
> corresponding
Will fix in next version.

>> configuration to firmware.
>> This change supports DPP handshake based on wpa_supplicant v2.9.
>>
>> Signed-off-by: Kurt Lee <kurt.lee@cypress.com>
>> Signed-off-by: Ian Lin <ian.lin@infineon.com>
>> ---
>>   .../broadcom/brcm80211/brcmfmac/cfg80211.c    | 85 ++++++++++++-------
>>   .../broadcom/brcm80211/brcmfmac/p2p.c         | 72 ++++++++++++----
>>   .../broadcom/brcm80211/brcmfmac/p2p.h         |  4 +-
>>   .../broadcom/brcm80211/include/brcmu_wifi.h   |  5 ++
>>   4 files changed, 117 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> index 7c72ea26a7d7..4a8aceda8fe8 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>> @@ -64,6 +64,9 @@
>>   #define RSN_CAP_MFPC_MASK              BIT(7)
>>   #define RSN_PMKID_COUNT_LEN            2
>>
>> +#define DPP_AKM_SUITE_TYPE             2
>> +#define WLAN_AKM_SUITE_DPP             SUITE(WLAN_OUI_WFA, DPP_AKM_SUITE_TYPE)
> Please use WLAN_AKM_SUITE_WFA_DPP.
Will fix in next version.

>
>> +
>>   #define VNDR_IE_CMD_LEN                        4       /* length of the set command
>>                                                   * string :"add", "del" (+ NUL)
>>                                                   */
>> @@ -1816,6 +1819,9 @@ brcmf_set_key_mgmt(struct net_device *ndev, struct cfg80211_connect_params *sme)
>>                          val = WPA2_AUTH_PSK | WPA2_AUTH_FT;
>>                          profile->is_ft = true;
>>                          break;
>> +               case WLAN_AKM_SUITE_DPP:
>> +                       val = WFA_AUTH_DPP;
>> +                       break;
>>                  default:
>>                          bphy_err(drvr, "invalid akm suite (%d)\n",
>>                                   sme->crypto.akm_suites[0]);
>> @@ -4144,6 +4150,12 @@ static bool brcmf_valid_wpa_oui(u8 *oui, bool is_rsn_ie)
>>          return (memcmp(oui, WPA_OUI, TLV_OUI_LEN) == 0);
>>   }
>>
>> +static bool brcmf_valid_dpp_suite(u8 *oui)
>> +{
>> +       return (memcmp(oui, WFA_OUI, TLV_OUI_LEN) == 0 &&
>> +               *(oui + TLV_OUI_LEN) == DPP_AKM_SUITE_TYPE);
>> +}
>> +
>>   static s32
>>   brcmf_configure_wpaie(struct brcmf_if *ifp,
>>                        const struct brcmf_vs_tlv *wpa_ie,
>> @@ -4257,42 +4269,47 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
>>                  goto exit;
>>          }
>>          for (i = 0; i < count; i++) {
>> -               if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
>> +               if (brcmf_valid_dpp_suite(&data[offset])) {
>> +                       wpa_auth |= WFA_AUTH_DPP;
>> +                       offset += TLV_OUI_LEN;
>> +               } else if (brcmf_valid_wpa_oui(&data[offset], is_rsn_ie)) {
>> +                       offset += TLV_OUI_LEN;
>> +                       switch (data[offset]) {
>> +                       case RSN_AKM_NONE:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
>> +                               wpa_auth |= WPA_AUTH_NONE;
>> +                               break;
>> +                       case RSN_AKM_UNSPECIFIED:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
>> +                               is_rsn_ie ?
>> +                                       (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
>> +                                       (wpa_auth |= WPA_AUTH_UNSPECIFIED);
>> +                               break;
>> +                       case RSN_AKM_PSK:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
>> +                               is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
>> +                                           (wpa_auth |= WPA_AUTH_PSK);
>> +                               break;
>> +                       case RSN_AKM_SHA256_PSK:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
>> +                               wpa_auth |= WPA2_AUTH_PSK_SHA256;
>> +                               break;
>> +                       case RSN_AKM_SHA256_1X:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
>> +                               wpa_auth |= WPA2_AUTH_1X_SHA256;
>> +                               break;
>> +                       case RSN_AKM_SAE:
>> +                               brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
>> +                               wpa_auth |= WPA3_AUTH_SAE_PSK;
>> +                               break;
>> +                       default:
>> +                               bphy_err(drvr, "Invalid key mgmt info\n");
>> +                       }
>> +               } else {
> Only check for invalid case here
>      if (!brcmf_valid_wpa_oui(&data[offset], is_rsn_ie) &&
>              !brcmf_valid_dpp_suite(&data[offset])) {
>
> And keep the switch below but add a new case for DPP_AKM_SUITE_TYPE.
The two authentication type refer to equal value: DPP_AKM_SUITE_TYPE & 
RSN_AKM_PSK (both =2)
So I can not directly place DPP_AKM_SUITE_TYPE into switch case.

It's more reasonable that we firstly check if it's DPP by 
brcmf_valid_dpp_suite
  - need to check WFA_OUI and DPP_AKM_SUITE_TYPE
Then go to the other cases.

>>                          err = -EINVAL;
>>                          bphy_err(drvr, "ivalid OUI\n");
>>                          goto exit;
>>                  }
>> -               offset += TLV_OUI_LEN;
>> -               switch (data[offset]) {
>> -               case RSN_AKM_NONE:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_NONE\n");
>> -                       wpa_auth |= WPA_AUTH_NONE;
>> -                       break;
>> -               case RSN_AKM_UNSPECIFIED:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_UNSPECIFIED\n");
>> -                       is_rsn_ie ? (wpa_auth |= WPA2_AUTH_UNSPECIFIED) :
>> -                                   (wpa_auth |= WPA_AUTH_UNSPECIFIED);
>> -                       break;
>> -               case RSN_AKM_PSK:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_PSK\n");
>> -                       is_rsn_ie ? (wpa_auth |= WPA2_AUTH_PSK) :
>> -                                   (wpa_auth |= WPA_AUTH_PSK);
>> -                       break;
>> -               case RSN_AKM_SHA256_PSK:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_MFP_PSK\n");
>> -                       wpa_auth |= WPA2_AUTH_PSK_SHA256;
>> -                       break;
>> -               case RSN_AKM_SHA256_1X:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_MFP_1X\n");
>> -                       wpa_auth |= WPA2_AUTH_1X_SHA256;
>> -                       break;
>> -               case RSN_AKM_SAE:
>> -                       brcmf_dbg(TRACE, "RSN_AKM_SAE\n");
>> -                       wpa_auth |= WPA3_AUTH_SAE_PSK;
>> -                       break;
>> -               default:
>> -                       bphy_err(drvr, "Invalid key mgmt info\n");
>> -               }
>>                  offset++;
>>          }
>>
>> @@ -4312,10 +4329,12 @@ brcmf_configure_wpaie(struct brcmf_if *ifp,
>>                                   */
>>                                  if (!(wpa_auth & (WPA2_AUTH_PSK_SHA256 |
>>                                                    WPA2_AUTH_1X_SHA256 |
>> +                                                 WFA_AUTH_DPP |
>>                                                    WPA3_AUTH_SAE_PSK))) {
>>                                          err = -EINVAL;
>>                                          goto exit;
>>                                  }
>> +
>>                                  /* Firmware has requirement that WPA2_AUTH_PSK/
>>                                   * WPA2_AUTH_UNSPECIFIED be set, if SHA256 OUI
>>                                   * is to be included in the rsn ie.
>> @@ -5225,7 +5244,7 @@ brcmf_cfg80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>                            *cookie, le16_to_cpu(action_frame->len), freq);
>>
>>                  ack = brcmf_p2p_send_action_frame(cfg, cfg_to_ndev(cfg),
>> -                                                 af_params);
>> +                                                 af_params, vif);
>>
>>                  cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
>>                                          GFP_KERNEL);
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> index 479041f070f9..4636fc27e915 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
>> @@ -231,7 +231,35 @@ static bool brcmf_p2p_is_pub_action(void *frame, u32 frame_len)
>>          if (pact_frm->category == P2P_PUB_AF_CATEGORY &&
>>              pact_frm->action == P2P_PUB_AF_ACTION &&
>>              pact_frm->oui_type == P2P_VER &&
>> -           memcmp(pact_frm->oui, P2P_OUI, P2P_OUI_LEN) == 0)
>> +           memcmp(pact_frm->oui, WFA_OUI, P2P_OUI_LEN) == 0)
> This change is irrelevant although the two macros are the same. Please
> have a separate patch to clean up P2P_OUI.
Will fix in next version.

>> +               return true;
>> +
>> +       return false;
>> +}
>> +
>> +/**
>> + * brcmf_p2p_is_dpp_pub_action() - true if dpp public type frame.
>> + *
>> + * @frame: action frame data.
>> + * @frame_len: length of action frame data.
>> + *
>> + * Determine if action frame is dpp public action type
>> + */
>> +static bool brcmf_p2p_is_dpp_pub_action(void *frame, u32 frame_len)
>> +{
>> +       struct brcmf_p2p_pub_act_frame *pact_frm;
>> +
>> +       if (!frame)
>> +               return false;
>> +
>> +       pact_frm = (struct brcmf_p2p_pub_act_frame *)frame;
>> +       if (frame_len < sizeof(struct brcmf_p2p_pub_act_frame) - 1)
>> +               return false;
>> +
>> +       if (pact_frm->category == WLAN_CATEGORY_PUBLIC &&
>> +           pact_frm->action == WLAN_PUB_ACTION_VENDOR_SPECIFIC &&
>> +           pact_frm->oui_type == DPP_VER &&
>> +           memcmp(pact_frm->oui, WFA_OUI, TLV_OUI_LEN) == 0)
>>                  return true;
>>
>>          return false;
>> @@ -991,6 +1019,8 @@ int brcmf_p2p_remain_on_channel(struct wiphy *wiphy, struct wireless_dev *wdev,
>>          if (err)
>>                  goto exit;
>>
>> +       p2p->remin_on_channel_wdev = wdev;
>> +
>>          memcpy(&p2p->remain_on_channel, channel, sizeof(*channel));
>>          *cookie = p2p->remain_on_channel_cookie;
>>          cfg80211_ready_on_channel(wdev, *cookie, channel, duration, GFP_KERNEL);
>> @@ -1014,6 +1044,7 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
>>   {
>>          struct brcmf_cfg80211_info *cfg = ifp->drvr->config;
>>          struct brcmf_p2p_info *p2p = &cfg->p2p;
>> +       struct wireless_dev *wdev = p2p->remin_on_channel_wdev;
>>
>>          brcmf_dbg(TRACE, "Enter\n");
>>          if (test_and_clear_bit(BRCMF_P2P_STATUS_DISCOVER_LISTEN,
>> @@ -1026,10 +1057,16 @@ int brcmf_p2p_notify_listen_complete(struct brcmf_if *ifp,
>>                          complete(&p2p->wait_next_af);
>>                  }
>>
>> -               cfg80211_remain_on_channel_expired(&ifp->vif->wdev,
>> +               wdev = p2p->remin_on_channel_wdev ?
>> +                       p2p->remin_on_channel_wdev :
>> +                       &ifp->vif->wdev;
>> +
>> +               cfg80211_remain_on_channel_expired(wdev,
>>                                                     p2p->remain_on_channel_cookie,
>>                                                     &p2p->remain_on_channel,
>>                                                     GFP_KERNEL);
>> +               p2p->remin_on_channel_wdev = NULL;
>> +
>>          }
>>          return 0;
>>   }
>> @@ -1531,6 +1568,7 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
>>    *
>>    * @p2p: p2p info struct for vif.
>>    * @af_params: action frame data/info.
>> + * @vif: vif to send
>>    *
>>    * Send an action frame immediately without doing channel synchronization.
>>    *
>> @@ -1539,12 +1577,17 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
>>    * frame is transmitted.
>>    */
>>   static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
>> -                                    struct brcmf_fil_af_params_le *af_params)
>> +                                    struct brcmf_fil_af_params_le *af_params,
>> +                                    struct brcmf_cfg80211_vif *vif
>> +                                    )
>>   {
>>          struct brcmf_pub *drvr = p2p->cfg->pub;
>> -       struct brcmf_cfg80211_vif *vif;
>> -       struct brcmf_p2p_action_frame *p2p_af;
>>          s32 err = 0;
>> +       struct brcmf_fil_action_frame_le *action_frame;
>> +       u16 action_frame_len;
>> +
>> +       action_frame = &af_params->action_frame;
>> +       action_frame_len = le16_to_cpu(action_frame->len);
>>
>>          brcmf_dbg(TRACE, "Enter\n");
>>
>> @@ -1552,13 +1595,6 @@ static s32 brcmf_p2p_tx_action_frame(struct brcmf_p2p_info *p2p,
>>          clear_bit(BRCMF_P2P_STATUS_ACTION_TX_COMPLETED, &p2p->status);
>>          clear_bit(BRCMF_P2P_STATUS_ACTION_TX_NOACK, &p2p->status);
>>
>> -       /* check if it is a p2p_presence response */
>> -       p2p_af = (struct brcmf_p2p_action_frame *)af_params->action_frame.data;
>> -       if (p2p_af->subtype == P2P_AF_PRESENCE_RSP)
>> -               vif = p2p->bss_idx[P2PAPI_BSSCFG_CONNECTION].vif;
>> -       else
>> -               vif = p2p->bss_idx[P2PAPI_BSSCFG_DEVICE].vif;
>> -
>>          err = brcmf_fil_bsscfg_data_set(vif->ifp, "actframe", af_params,
>>                                          sizeof(*af_params));
>>          if (err) {
>> @@ -1714,10 +1750,13 @@ static bool brcmf_p2p_check_dwell_overflow(u32 requested_dwell,
>>    * @cfg: driver private data for cfg80211 interface.
>>    * @ndev: net device to transmit on.
>>    * @af_params: configuration data for action frame.
>> + * @vif: virtual interface to send
>>    */
>>   bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>>                                   struct net_device *ndev,
>> -                                struct brcmf_fil_af_params_le *af_params)
>> +                                struct brcmf_fil_af_params_le *af_params,
>> +                                struct brcmf_cfg80211_vif *vif
>> +                                )
>>   {
>>          struct brcmf_p2p_info *p2p = &cfg->p2p;
>>          struct brcmf_if *ifp = netdev_priv(ndev);
>> @@ -1789,7 +1828,9 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>>                          goto exit;
>>                  }
>>          } else if (brcmf_p2p_is_p2p_action(action_frame->data,
>> -                                          action_frame_len)) {
>> +                                          action_frame_len) ||
>> +                  brcmf_p2p_is_dpp_pub_action(action_frame->data,
>> +                                              action_frame_len)) {
>>                  /* do not configure anything. it will be */
>>                  /* sent with a default configuration     */
>>          } else {
>> @@ -1857,7 +1898,7 @@ bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>>                  if (af_params->channel)
>>                          msleep(P2P_AF_RETRY_DELAY_TIME);
>>
>> -               ack = !brcmf_p2p_tx_action_frame(p2p, af_params);
>> +               ack = !brcmf_p2p_tx_action_frame(p2p, af_params, vif);
>>                  tx_retry++;
>>                  dwell_overflow = brcmf_p2p_check_dwell_overflow(requested_dwell,
>>                                                                  dwell_jiffies);
>> @@ -2508,6 +2549,7 @@ s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced)
>>
>>          pri_ifp = brcmf_get_ifp(cfg->pub, 0);
>>          p2p->bss_idx[P2PAPI_BSSCFG_PRIMARY].vif = pri_ifp->vif;
>> +       init_completion(&p2p->send_af_done);
>>
>>          if (p2pdev_forced) {
>>                  err_ptr = brcmf_p2p_create_p2pdev(p2p, NULL, NULL);
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
>> index d2ecee565bf2..bbc455238707 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.h
>> @@ -138,6 +138,7 @@ struct brcmf_p2p_info {
>>          bool block_gon_req_tx;
>>          bool p2pdev_dynamically;
>>          bool wait_for_offchan_complete;
>> +       struct wireless_dev *remin_on_channel_wdev;
> Docstring needs update. Also s/remin/remain
Will fix in next version.

>>   };
>>
>>   s32 brcmf_p2p_attach(struct brcmf_cfg80211_info *cfg, bool p2pdev_forced);
>> @@ -170,7 +171,8 @@ int brcmf_p2p_notify_action_tx_complete(struct brcmf_if *ifp,
>>                                          void *data);
>>   bool brcmf_p2p_send_action_frame(struct brcmf_cfg80211_info *cfg,
>>                                   struct net_device *ndev,
>> -                                struct brcmf_fil_af_params_le *af_params);
>> +                                struct brcmf_fil_af_params_le *af_params,
>> +                                struct brcmf_cfg80211_vif *vif);
>>   bool brcmf_p2p_scan_finding_common_channel(struct brcmf_cfg80211_info *cfg,
>>                                             struct brcmf_bss_info_le *bi);
>>   s32 brcmf_p2p_notify_rx_mgmt_p2p_probereq(struct brcmf_if *ifp,
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>> index 7552bdb91991..3a9cad3730b8 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>> +++ b/drivers/net/wireless/broadcom/brcm80211/include/brcmu_wifi.h
>> @@ -233,6 +233,11 @@ static inline bool ac_bitmap_tst(u8 bitmap, int prec)
>>
>>   #define WPA3_AUTH_SAE_PSK      0x40000 /* SAE with 4-way handshake */
>>
>> +#define WFA_AUTH_DPP           0x200000 /* WFA DPP AUTH */
> This is incompatible with Broadcom's bit definitions. Please use a per
> vendor approach.
We had extended the bit definition.
The authentication mode will be set to our FW so it's FW-dependent.
Do you suggest I change the name? like CY_WFA_AUTH_DPP?

Thank you for the review.

>> +
>> +#define WFA_OUI                        "\x50\x6F\x9A"  /* WFA OUI */
>> +#define DPP_VER                        0x1A    /* WFA DPP v1.0 */
>> +
>>   #define DOT11_DEFAULT_RTS_LEN          2347
>>   #define DOT11_DEFAULT_FRAG_LEN         2346
>>
>> --
>> 2.25.0
>>

