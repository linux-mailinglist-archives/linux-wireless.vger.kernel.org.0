Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F36A85C3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Mar 2023 17:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjCBQDs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Mar 2023 11:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjCBQDr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Mar 2023 11:03:47 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E720D2820E
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 08:03:38 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaa701aso316375347b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 08:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677773018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7z2mQwup8/gR0OgPQE/3FqgLiWq8E3qDsgwW2p24hUo=;
        b=RqtWxu/vlOLpAGVO+L2Wqu10LB7ZUlqYeKTKHJthlEsA39H2sPge3Tz+wM9SwqMEUf
         kboKwXXxOAMRD9heqka0yedSG54LbZivTfNEsBvqIcttWUtR26krOkc7tYIHMimkpD5+
         GHX7TskgE0sq0SPkMiLBJOD2NBDABYx43AFJGY8gnxddDkHkQ/QPC9YiuISbekyz2fdH
         zWe+ggxvlH72Sp8ir7Jcn6u+eGWJ4mdqPK4P2TVkH5YZgsB3N+HQSSJ3ronLO4W5Q36l
         yOm+DXSRBw5bY2G8OM2hVBuXF45mUpGaomtThEz/F+haCmnJpZKNwL42XSLyp6j2lDB1
         vh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677773018;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7z2mQwup8/gR0OgPQE/3FqgLiWq8E3qDsgwW2p24hUo=;
        b=Be/JSmTBasCuU4O/9vY8KIO4jmvu2ObJbHkt5M4xS5dNew6R0fdeJkSDkKENTYyfQX
         Yn1QHKuTT/FBOrrVDr6I9XjRu5P86h0m/ENAeq15KTLGOvTPqGrt1tYm0Rd+wmB0BzDK
         7KYV2aU2aWWGhRS0S3eDRqgAKqbc8UdWuBdRZiLnOo1nwWUCjCooRTIqoH0kKo5zrPXk
         Vqx0P3kXkszLPRHLm85VHmnZALvK4hBNArRTUi2P8xAXO2O5D2zCxf59tTY/6PF+uhYH
         sP0WvhefCT2r28nDsQEgLGeZdLumpN+i9tN+zw+7DspK7IiHWq/eDocR4X5uYDDTQUjg
         +Lzw==
X-Gm-Message-State: AO0yUKVnmBBcyDKkZibQGqDLycbjQXJFif71PKeF7q9iOr5w47tb0ExK
        ls33O6eoVICqIWAvdvp1Fa6BcLtitdI=
X-Google-Smtp-Source: AK7set/ZqfGJh6RUCwrBlNGtf3JCH1lpqiK4gssnBUTv8RaTDyhVj3DW1YmpuYLsRak5jfeuaBSAUJDBfQc=
X-Received: from jaewan1.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:e59])
 (user=jaewan job=sendgmr) by 2002:a05:6902:101:b0:a4e:4575:f3ec with SMTP id
 o1-20020a056902010100b00a4e4575f3ecmr4841778ybh.0.1677773018551; Thu, 02 Mar
 2023 08:03:38 -0800 (PST)
Date:   Thu,  2 Mar 2023 16:03:10 +0000
In-Reply-To: <20230302160310.923349-1-jaewan@google.com>
Mime-Version: 1.0
References: <20230302160310.923349-1-jaewan@google.com>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230302160310.923349-6-jaewan@google.com>
Subject: [PATCH v8 5/5] mac80211_hwsim: add PMSR report support via virtio
From:   Jaewan Kim <jaewan@google.com>
To:     gregkh@linuxfoundation.org, johannes@sipsolutions.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-team@android.com, adelva@google.com,
        Jaewan Kim <jaewan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PMSR (a.k.a. peer measurement) is generalized measurement between two
devices with Wi-Fi support. And currently FTM (a.k.a. fine time measurement
or flight time measurement) is the one and only measurement.

Add the necessary functionality to allow mac80211_hwsim to report PMSR
result. The result would come from the wmediumd, where other Wi-Fi
devices' information are kept. mac80211_hwsim only need to deliver the
result to the userspace.

In detail, add new mac80211_hwsim attributes HWSIM_CMD_REPORT_PMSR, and
HWSIM_ATTR_PMSR_RESULT. When mac80211_hwsim receives the PMSR result with
command HWSIM_CMD_REPORT_PMSR and detail with attribute
HWSIM_ATTR_PMSR_RESULT, received data is parsed to cfg80211_pmsr_result and
resent to the userspace by cfg80211_pmsr_report().

To help receive the details of PMSR result, hwsim_rate_info_attributes is
added to receive rate_info without complex bitrate calculation. (i.e. send
rate_info without adding inverse of nl80211_put_sta_rate()).

Signed-off-by: Jaewan Kim <jaewan@google.com>
---
V7->V8: Specify calculated last HWSIM_CMD for resv_start_op instead of
        __HWSIM_CMD_MAX for adding new CMD more explicit.
V7: Initial commit (split from previously large patch)
---
 drivers/net/wireless/mac80211_hwsim.c | 379 +++++++++++++++++++++++++-
 drivers/net/wireless/mac80211_hwsim.h |  51 +++-
 2 files changed, 420 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 0d92a7e51057..2a664b7e50d5 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -752,6 +752,11 @@ struct hwsim_radiotap_ack_hdr {
 	__le16 rt_chbitmask;
 } __packed;
 
+static struct mac80211_hwsim_data *get_hwsim_data_ref_from_addr(const u8 *addr)
+{
+	return rhashtable_lookup_fast(&hwsim_radios_rht, addr, hwsim_rht_params);
+}
+
 /* MAC80211_HWSIM netlink family */
 static struct genl_family hwsim_genl_family;
 
@@ -765,6 +770,76 @@ static const struct genl_multicast_group hwsim_mcgrps[] = {
 
 /* MAC80211_HWSIM netlink policy */
 
+static const struct nla_policy
+hwsim_rate_info_policy[HWSIM_RATE_INFO_ATTR_MAX + 1] = {
+	[HWSIM_RATE_INFO_ATTR_FLAGS] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_MCS] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_LEGACY] = { .type = NLA_U16 },
+	[HWSIM_RATE_INFO_ATTR_NSS] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_BW] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_HE_GI] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_HE_DCM] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_HE_RU_ALLOC] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_N_BOUNDED_CH] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_EHT_GI] = { .type = NLA_U8 },
+	[HWSIM_RATE_INFO_ATTR_EHT_RU_ALLOC] = { .type = NLA_U8 },
+};
+
+static const struct nla_policy
+hwsim_ftm_result_policy[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1] = {
+	[NL80211_PMSR_FTM_RESP_ATTR_FAIL_REASON] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_BURST_INDEX] = { .type = NLA_U16 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_ATTEMPTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_SUCCESSES] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_BUSY_RETRY_TIME] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_NUM_BURSTS_EXP] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_BURST_DURATION] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_FTMS_PER_BURST] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RSSI_AVG] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RSSI_SPREAD] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_RESP_ATTR_TX_RATE] = NLA_POLICY_NESTED(hwsim_rate_info_policy),
+	[NL80211_PMSR_FTM_RESP_ATTR_RX_RATE] = NLA_POLICY_NESTED(hwsim_rate_info_policy),
+	[NL80211_PMSR_FTM_RESP_ATTR_RTT_AVG] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RTT_VARIANCE] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_RTT_SPREAD] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_DIST_AVG] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_DIST_VARIANCE] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_RESP_ATTR_LCI] = { .type = NLA_STRING },
+	[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC] = { .type = NLA_STRING },
+};
+
+static const struct nla_policy
+hwsim_pmsr_resp_type_policy[NL80211_PMSR_TYPE_MAX + 1] = {
+	[NL80211_PMSR_TYPE_FTM] = NLA_POLICY_NESTED(hwsim_ftm_result_policy),
+};
+
+static const struct nla_policy
+hwsim_pmsr_resp_policy[NL80211_PMSR_RESP_ATTR_MAX + 1] = {
+	[NL80211_PMSR_RESP_ATTR_STATUS] = { .type = NLA_U32 },
+	[NL80211_PMSR_RESP_ATTR_HOST_TIME] = { .type = NLA_U64 },
+	[NL80211_PMSR_RESP_ATTR_AP_TSF] = { .type = NLA_U64 },
+	[NL80211_PMSR_RESP_ATTR_FINAL] = { .type = NLA_FLAG },
+	[NL80211_PMSR_RESP_ATTR_DATA] = NLA_POLICY_NESTED(hwsim_pmsr_resp_type_policy),
+};
+
+static const struct nla_policy
+hwsim_pmsr_peer_result_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
+	[NL80211_PMSR_PEER_ATTR_ADDR] = NLA_POLICY_ETH_ADDR_COMPAT,
+	[NL80211_PMSR_PEER_ATTR_CHAN] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_REQ] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_RESP] = NLA_POLICY_NESTED(hwsim_pmsr_resp_policy),
+};
+
+static const struct nla_policy
+hwsim_pmsr_peers_result_policy[NL80211_PMSR_ATTR_MAX + 1] = {
+	[NL80211_PMSR_ATTR_MAX_PEERS] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_REPORT_AP_TSF] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_TYPE_CAPA] = { .type = NLA_REJECT },
+	[NL80211_PMSR_ATTR_PEERS] = NLA_POLICY_NESTED_ARRAY(hwsim_pmsr_peer_result_policy),
+};
+
 static const struct nla_policy
 hwsim_ftm_capa_policy[NL80211_PMSR_FTM_CAPA_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_CAPA_ATTR_ASAP] = { .type = NLA_FLAG },
@@ -822,6 +897,7 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_CIPHER_SUPPORT] = { .type = NLA_BINARY },
 	[HWSIM_ATTR_MLO_SUPPORT] = { .type = NLA_FLAG },
 	[HWSIM_ATTR_PMSR_SUPPORT] = NLA_POLICY_NESTED(hwsim_pmsr_capa_policy),
+	[HWSIM_ATTR_PMSR_RESULT] = NLA_POLICY_NESTED(hwsim_pmsr_peers_result_policy),
 };
 
 #if IS_REACHABLE(CONFIG_VIRTIO)
@@ -3403,6 +3479,292 @@ static void mac80211_hwsim_abort_pmsr(struct ieee80211_hw *hw,
 	mutex_unlock(&data->mutex);
 }
 
+static int mac80211_hwsim_parse_rate_info(struct nlattr *rateattr,
+					  struct rate_info *rate_info,
+					  struct genl_info *info)
+{
+	struct nlattr *tb[HWSIM_RATE_INFO_ATTR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, HWSIM_RATE_INFO_ATTR_MAX,
+			       rateattr, hwsim_rate_info_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (tb[HWSIM_RATE_INFO_ATTR_FLAGS])
+		rate_info->flags = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_FLAGS]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_MCS])
+		rate_info->mcs = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_MCS]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_LEGACY])
+		rate_info->legacy = nla_get_u16(tb[HWSIM_RATE_INFO_ATTR_LEGACY]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_NSS])
+		rate_info->nss = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_NSS]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_BW])
+		rate_info->bw = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_BW]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_HE_GI])
+		rate_info->he_gi = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_HE_GI]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_HE_DCM])
+		rate_info->he_dcm = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_HE_DCM]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_HE_RU_ALLOC])
+		rate_info->he_ru_alloc =
+			nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_HE_RU_ALLOC]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_N_BOUNDED_CH])
+		rate_info->n_bonded_ch = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_N_BOUNDED_CH]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_EHT_GI])
+		rate_info->eht_gi = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_EHT_GI]);
+
+	if (tb[HWSIM_RATE_INFO_ATTR_EHT_RU_ALLOC])
+		rate_info->eht_ru_alloc = nla_get_u8(tb[HWSIM_RATE_INFO_ATTR_EHT_RU_ALLOC]);
+
+	return 0;
+}
+
+static int mac80211_hwsim_parse_ftm_result(struct nlattr *ftm,
+					   struct cfg80211_pmsr_ftm_result *result,
+					   struct genl_info *info)
+{
+	struct nlattr *tb[NL80211_PMSR_FTM_RESP_ATTR_MAX + 1];
+	int ret;
+
+	ret = nla_parse_nested(tb, NL80211_PMSR_FTM_RESP_ATTR_MAX,
+			       ftm, hwsim_ftm_result_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_FAIL_REASON])
+		result->failure_reason = nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_FAIL_REASON]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_BURST_INDEX])
+		result->burst_index = nla_get_u16(tb[NL80211_PMSR_FTM_RESP_ATTR_BURST_INDEX]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_ATTEMPTS]) {
+		result->num_ftmr_attempts_valid = 1;
+		result->num_ftmr_attempts =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_ATTEMPTS]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_SUCCESSES]) {
+		result->num_ftmr_successes_valid = 1;
+		result->num_ftmr_successes =
+			nla_get_u32(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_FTMR_SUCCESSES]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_BUSY_RETRY_TIME])
+		result->busy_retry_time =
+			nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_BUSY_RETRY_TIME]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_BURSTS_EXP])
+		result->num_bursts_exp = nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_NUM_BURSTS_EXP]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_BURST_DURATION])
+		result->burst_duration = nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_BURST_DURATION]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_FTMS_PER_BURST])
+		result->ftms_per_burst = nla_get_u8(tb[NL80211_PMSR_FTM_RESP_ATTR_FTMS_PER_BURST]);
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RSSI_AVG]) {
+		result->rssi_avg_valid = 1;
+		result->rssi_avg = nla_get_s32(tb[NL80211_PMSR_FTM_RESP_ATTR_RSSI_AVG]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RSSI_SPREAD]) {
+		result->rssi_spread_valid = 1;
+		result->rssi_spread =
+			nla_get_s32(tb[NL80211_PMSR_FTM_RESP_ATTR_RSSI_SPREAD]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_TX_RATE]) {
+		result->tx_rate_valid = 1;
+		ret = mac80211_hwsim_parse_rate_info(tb[NL80211_PMSR_FTM_RESP_ATTR_TX_RATE],
+						     &result->tx_rate, info);
+		if (ret)
+			return ret;
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RX_RATE]) {
+		result->rx_rate_valid = 1;
+		ret = mac80211_hwsim_parse_rate_info(tb[NL80211_PMSR_FTM_RESP_ATTR_RX_RATE],
+						     &result->rx_rate, info);
+		if (ret)
+			return ret;
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_AVG]) {
+		result->rtt_avg_valid = 1;
+		result->rtt_avg =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_AVG]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_VARIANCE]) {
+		result->rtt_variance_valid = 1;
+		result->rtt_variance =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_VARIANCE]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_SPREAD]) {
+		result->rtt_spread_valid = 1;
+		result->rtt_spread =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_RTT_SPREAD]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_AVG]) {
+		result->dist_avg_valid = 1;
+		result->dist_avg =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_AVG]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_VARIANCE]) {
+		result->dist_variance_valid = 1;
+		result->dist_variance =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_VARIANCE]);
+	}
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD]) {
+		result->dist_spread_valid = 1;
+		result->dist_spread =
+			nla_get_u64(tb[NL80211_PMSR_FTM_RESP_ATTR_DIST_SPREAD]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_LCI]) {
+		result->lci = nla_data(tb[NL80211_PMSR_FTM_RESP_ATTR_LCI]);
+		result->lci_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_LCI]);
+	}
+
+	if (tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]) {
+		result->civicloc = nla_data(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
+		result->civicloc_len = nla_len(tb[NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC]);
+	}
+
+	return 0;
+}
+
+static int mac80211_hwsim_parse_pmsr_resp(struct nlattr *resp,
+					  struct cfg80211_pmsr_result *result,
+					  struct genl_info *info)
+{
+	struct nlattr *tb[NL80211_PMSR_RESP_ATTR_MAX + 1];
+	struct nlattr *pmsr;
+	int rem;
+	int ret;
+
+	ret = nla_parse_nested(tb, NL80211_PMSR_RESP_ATTR_MAX, resp,
+			       hwsim_pmsr_resp_policy, info->extack);
+
+	if (tb[NL80211_PMSR_RESP_ATTR_STATUS])
+		result->status = nla_get_u32(tb[NL80211_PMSR_RESP_ATTR_STATUS]);
+
+	if (tb[NL80211_PMSR_RESP_ATTR_HOST_TIME])
+		result->host_time = nla_get_u64(tb[NL80211_PMSR_RESP_ATTR_HOST_TIME]);
+
+	if (tb[NL80211_PMSR_RESP_ATTR_AP_TSF]) {
+		result->ap_tsf_valid = 1;
+		result->ap_tsf = nla_get_u64(tb[NL80211_PMSR_RESP_ATTR_AP_TSF]);
+	}
+
+	result->final = !!tb[NL80211_PMSR_RESP_ATTR_FINAL];
+
+	if (tb[NL80211_PMSR_RESP_ATTR_DATA]) {
+		nla_for_each_nested(pmsr, tb[NL80211_PMSR_RESP_ATTR_DATA], rem) {
+			switch (nla_type(pmsr)) {
+			case NL80211_PMSR_TYPE_FTM:
+				result->type = NL80211_PMSR_TYPE_FTM;
+				ret = mac80211_hwsim_parse_ftm_result(pmsr, &result->ftm, info);
+				if (ret)
+					return ret;
+				break;
+			default:
+				NL_SET_ERR_MSG_ATTR(info->extack, pmsr, "Unknown pmsr resp type");
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mac80211_hwsim_parse_pmsr_result(struct nlattr *peer,
+					    struct cfg80211_pmsr_result *result,
+					    struct genl_info *info)
+{
+	struct nlattr *tb[NL80211_PMSR_PEER_ATTR_MAX + 1];
+	int ret;
+
+	if (!peer)
+		return -EINVAL;
+
+	ret = nla_parse_nested(tb, NL80211_PMSR_PEER_ATTR_MAX, peer,
+			       hwsim_pmsr_peer_result_policy, info->extack);
+	if (ret)
+		return ret;
+
+	if (tb[NL80211_PMSR_PEER_ATTR_ADDR])
+		memcpy(result->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]),
+		       ETH_ALEN);
+
+	if (tb[NL80211_PMSR_PEER_ATTR_RESP]) {
+		ret = mac80211_hwsim_parse_pmsr_resp(tb[NL80211_PMSR_PEER_ATTR_RESP], result, info);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+};
+
+static int hwsim_pmsr_report_nl(struct sk_buff *msg, struct genl_info *info)
+{
+	struct nlattr *reqattr;
+	const u8 *src;
+	int err, rem;
+	struct nlattr *peers, *peer;
+	struct mac80211_hwsim_data *data;
+
+	src = nla_data(info->attrs[HWSIM_ATTR_ADDR_TRANSMITTER]);
+	data = get_hwsim_data_ref_from_addr(src);
+	if (!data)
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+	if (!data->pmsr_request) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	reqattr = info->attrs[HWSIM_ATTR_PMSR_RESULT];
+	if (!reqattr) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	peers = nla_find_nested(reqattr, NL80211_PMSR_ATTR_PEERS);
+	if (!peers) {
+		err = -EINVAL;
+		goto out_err;
+	}
+
+	nla_for_each_nested(peer, peers, rem) {
+		struct cfg80211_pmsr_result result;
+
+		err = mac80211_hwsim_parse_pmsr_result(peer, &result, info);
+		if (err)
+			goto out_err;
+
+		cfg80211_pmsr_report(data->pmsr_request_wdev,
+				     data->pmsr_request, &result, GFP_KERNEL);
+	}
+
+	cfg80211_pmsr_complete(data->pmsr_request_wdev, data->pmsr_request, GFP_KERNEL);
+
+out_err:
+	data->pmsr_request = NULL;
+	data->pmsr_request_wdev = NULL;
+
+	mutex_unlock(&data->mutex);
+	return err;
+}
+
 #define HWSIM_COMMON_OPS					\
 	.tx = mac80211_hwsim_tx,				\
 	.wake_tx_queue = ieee80211_handle_wake_tx_queue,	\
@@ -5072,13 +5434,6 @@ static void hwsim_mon_setup(struct net_device *dev)
 	eth_hw_addr_set(dev, addr);
 }
 
-static struct mac80211_hwsim_data *get_hwsim_data_ref_from_addr(const u8 *addr)
-{
-	return rhashtable_lookup_fast(&hwsim_radios_rht,
-				      addr,
-				      hwsim_rht_params);
-}
-
 static void hwsim_register_wmediumd(struct net *net, u32 portid)
 {
 	struct mac80211_hwsim_data *data;
@@ -5745,6 +6100,11 @@ static const struct genl_small_ops hwsim_ops[] = {
 		.doit = hwsim_get_radio_nl,
 		.dumpit = hwsim_dump_radio_nl,
 	},
+	{
+		.cmd = HWSIM_CMD_REPORT_PMSR,
+		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
+		.doit = hwsim_pmsr_report_nl,
+	},
 };
 
 static struct genl_family hwsim_genl_family __ro_after_init = {
@@ -5756,7 +6116,7 @@ static struct genl_family hwsim_genl_family __ro_after_init = {
 	.module = THIS_MODULE,
 	.small_ops = hwsim_ops,
 	.n_small_ops = ARRAY_SIZE(hwsim_ops),
-	.resv_start_op = HWSIM_CMD_DEL_MAC_ADDR + 1,
+	.resv_start_op = HWSIM_CMD_REPORT_PMSR + 1, // match with __HWSIM_CMD_MAX
 	.mcgrps = hwsim_mcgrps,
 	.n_mcgrps = ARRAY_SIZE(hwsim_mcgrps),
 };
@@ -5925,6 +6285,9 @@ static int hwsim_virtio_handle_cmd(struct sk_buff *skb)
 	case HWSIM_CMD_TX_INFO_FRAME:
 		hwsim_tx_info_frame_received_nl(skb, &info);
 		break;
+	case HWSIM_CMD_REPORT_PMSR:
+		hwsim_pmsr_report_nl(skb, &info);
+		break;
 	default:
 		pr_err_ratelimited("hwsim: invalid cmd: %d\n", gnlh->cmd);
 		return -EPROTO;
diff --git a/drivers/net/wireless/mac80211_hwsim.h b/drivers/net/wireless/mac80211_hwsim.h
index 383f3e39c911..92126f02c58f 100644
--- a/drivers/net/wireless/mac80211_hwsim.h
+++ b/drivers/net/wireless/mac80211_hwsim.h
@@ -82,8 +82,8 @@ enum hwsim_tx_control_flags {
  * @HWSIM_CMD_DEL_MAC_ADDR: remove the MAC address again, the attributes
  *	are the same as to @HWSIM_CMD_ADD_MAC_ADDR.
  * @HWSIM_CMD_START_PMSR: request to start peer measurement with the
- *	%HWSIM_ATTR_PMSR_REQUEST.
- * @HWSIM_CMD_ABORT_PMSR: abort previously sent peer measurement
+ *	%HWSIM_ATTR_PMSR_REQUEST. Result will be sent back asynchronously
+ *	with %HWSIM_CMD_REPORT_PMSR.
  * @__HWSIM_CMD_MAX: enum limit
  */
 enum {
@@ -98,6 +98,7 @@ enum {
 	HWSIM_CMD_DEL_MAC_ADDR,
 	HWSIM_CMD_START_PMSR,
 	HWSIM_CMD_ABORT_PMSR,
+	HWSIM_CMD_REPORT_PMSR,
 	__HWSIM_CMD_MAX,
 };
 #define HWSIM_CMD_MAX (_HWSIM_CMD_MAX - 1)
@@ -151,6 +152,8 @@ enum {
  *	to provide peer measurement capabilities. (nl80211_peer_measurement_attrs)
  * @HWSIM_ATTR_PMSR_REQUEST: nested attribute used with %HWSIM_CMD_START_PMSR
  *	to provide details about peer measurement request (nl80211_peer_measurement_attrs)
+ * @HWSIM_ATTR_PMSR_RESULT: nested attributed used with %HWSIM_CMD_REPORT_PMSR
+ *	to provide peer measurement result (nl80211_peer_measurement_attrs)
  * @__HWSIM_ATTR_MAX: enum limit
  */
 
@@ -184,6 +187,7 @@ enum {
 	HWSIM_ATTR_MLO_SUPPORT,
 	HWSIM_ATTR_PMSR_SUPPORT,
 	HWSIM_ATTR_PMSR_REQUEST,
+	HWSIM_ATTR_PMSR_RESULT,
 	__HWSIM_ATTR_MAX,
 };
 #define HWSIM_ATTR_MAX (__HWSIM_ATTR_MAX - 1)
@@ -288,4 +292,47 @@ enum {
 	HWSIM_VQ_RX,
 	HWSIM_NUM_VQS,
 };
+
+/**
+ * enum hwsim_rate_info -- bitrate information.
+ *
+ * Information about a receiving or transmitting bitrate
+ * that can be mapped to struct rate_info
+ *
+ * @HWSIM_RATE_INFO_ATTR_FLAGS: bitflag of flags from &enum rate_info_flags
+ * @HWSIM_RATE_INFO_ATTR_MCS: mcs index if struct describes an HT/VHT/HE rate
+ * @HWSIM_RATE_INFO_ATTR_LEGACY: bitrate in 100kbit/s for 802.11abg
+ * @HWSIM_RATE_INFO_ATTR_NSS: number of streams (VHT & HE only)
+ * @HWSIM_RATE_INFO_ATTR_BW: bandwidth (from &enum rate_info_bw)
+ * @HWSIM_RATE_INFO_ATTR_HE_GI: HE guard interval (from &enum nl80211_he_gi)
+ * @HWSIM_RATE_INFO_ATTR_HE_DCM: HE DCM value
+ * @HWSIM_RATE_INFO_ATTR_HE_RU_ALLOC:  HE RU allocation (from &enum nl80211_he_ru_alloc,
+ *	only valid if bw is %RATE_INFO_BW_HE_RU)
+ * @HWSIM_RATE_INFO_ATTR_N_BOUNDED_CH: In case of EDMG the number of bonded channels (1-4)
+ * @HWSIM_RATE_INFO_ATTR_EHT_GI: EHT guard interval (from &enum nl80211_eht_gi)
+ * @HWSIM_RATE_INFO_ATTR_EHT_RU_ALLOC: EHT RU allocation (from &enum nl80211_eht_ru_alloc,
+ *	only valid if bw is %RATE_INFO_BW_EHT_RU)
+ * @NUM_HWSIM_RATE_INFO_ATTRS: internal
+ * @HWSIM_RATE_INFO_ATTR_MAX: highest attribute number
+ */
+enum hwsim_rate_info_attributes {
+	__HWSIM_RATE_INFO_ATTR_INVALID,
+
+	HWSIM_RATE_INFO_ATTR_FLAGS,
+	HWSIM_RATE_INFO_ATTR_MCS,
+	HWSIM_RATE_INFO_ATTR_LEGACY,
+	HWSIM_RATE_INFO_ATTR_NSS,
+	HWSIM_RATE_INFO_ATTR_BW,
+	HWSIM_RATE_INFO_ATTR_HE_GI,
+	HWSIM_RATE_INFO_ATTR_HE_DCM,
+	HWSIM_RATE_INFO_ATTR_HE_RU_ALLOC,
+	HWSIM_RATE_INFO_ATTR_N_BOUNDED_CH,
+	HWSIM_RATE_INFO_ATTR_EHT_GI,
+	HWSIM_RATE_INFO_ATTR_EHT_RU_ALLOC,
+
+	/* keep last */
+	NUM_HWSIM_RATE_INFO_ATTRS,
+	HWSIM_RATE_INFO_ATTR_MAX = NUM_HWSIM_RATE_INFO_ATTRS - 1
+};
+
 #endif /* __MAC80211_HWSIM_H */
-- 
2.39.2.722.g9855ee24e9-goog

