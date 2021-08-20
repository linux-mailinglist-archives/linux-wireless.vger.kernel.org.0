Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1758A3F2BF4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 14:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239917AbhHTMWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 08:22:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:53290 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240613AbhHTMV5 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 08:21:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629462079; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x/Cgq183T9f89XOOcwri40VOSTuVlC/dB43M5oaeiNc=; b=rDH0GxiEaYjkJPldProZUbwBGhx8d8sZQ1k2I8d0cCWgmRpHyhIxh4o1xxHtpqib+kcJXRAB
 OxbCE4rcSKq5LQ5xj/C5qMEo0+TD9jilVLte/lnFmJsfPj0C9SYAe/AT6ZylJ4eitv/caqRN
 yz+fFWt0kQ7xW3uMBe6O+ZOdv7s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 611f9e2d0f9b337f11cd3ab6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 20 Aug 2021 12:21:01
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4FE75C43460; Fri, 20 Aug 2021 12:21:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9CEC0C43460;
        Fri, 20 Aug 2021 12:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 9CEC0C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v2 8/8] mac80211: save transmit power envelope element and power constraint
Date:   Fri, 20 Aug 2021 08:20:41 -0400
Message-Id: <20210820122041.12157-9-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210820122041.12157-1-wgong@codeaurora.org>
References: <20210820122041.12157-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is to save the transmit power envelope element and power
constraint in struct ieee80211_bss_conf for 6 GHz. Lower driver
will use this info to calculate the power limit.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 include/net/mac80211.h |  6 ++++++
 net/mac80211/chan.c    |  9 +++++++++
 net/mac80211/mlme.c    | 26 ++++++++++++++++++++++++++
 3 files changed, 41 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index e89530d0d9c6..6e11e122e364 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -631,6 +631,9 @@ struct ieee80211_fils_discovery {
  * @s1g: BSS is S1G BSS (affects Association Request format).
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
+ * @tx_pwr_env: transmit power envelope array of BSS.
+ * @tx_pwr_env_num: number of @tx_pwr_env.
+ * @pwr_reduction: power constraint of BSS.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -700,6 +703,9 @@ struct ieee80211_bss_conf {
 	u32 unsol_bcast_probe_resp_interval;
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
+	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
+	u8 tx_pwr_env_num;
+	u8 pwr_reduction;
 };
 
 /**
diff --git a/net/mac80211/chan.c b/net/mac80211/chan.c
index 907bb1f748a1..149d4ac798f6 100644
--- a/net/mac80211/chan.c
+++ b/net/mac80211/chan.c
@@ -721,6 +721,15 @@ static int ieee80211_assign_vif_chanctx(struct ieee80211_sub_if_data *sdata,
 					 lockdep_is_held(&local->chanctx_mtx));
 
 	if (conf) {
+		if (conf->def.chan->band == NL80211_BAND_6GHZ) {
+			struct ieee80211_bss_conf *bss_conf;
+
+			bss_conf = &sdata->vif.bss_conf;
+			bss_conf->pwr_reduction = 0;
+			bss_conf->tx_pwr_env_num = 0;
+			memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
+		}
+
 		curr_ctx = container_of(conf, struct ieee80211_chanctx, conf);
 
 		drv_unassign_vif_chanctx(local, sdata, curr_ctx);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2480bd0577bb..a6d66b4ad7ee 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5070,6 +5070,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
 		const struct cfg80211_bss_ies *ies;
+		struct ieee80211_bss_conf *bss_conf;
 		const u8 *he_oper_ie;
 
 		ies = rcu_dereference(cbss->ies);
@@ -5081,6 +5082,31 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		else
 			he_oper = NULL;
 
+		if (is_6ghz) {
+			struct ieee802_11_elems elems;
+			u8 i, j = 0;
+
+			ieee802_11_parse_elems(ies->data, ies->len, false, &elems,
+					       NULL, NULL);
+
+			if (elems.pwr_constr_elem)
+				bss_conf->pwr_reduction = *elems.pwr_constr_elem;
+
+			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
+				     ARRAY_SIZE(elems.tx_pwr_env));
+
+			for (i = 0; i < elems.tx_pwr_env_num; i++) {
+				if (elems.tx_pwr_env_len[i] >
+				    sizeof(bss_conf->tx_pwr_env[j]))
+					continue;
+
+				bss_conf->tx_pwr_env_num++;
+				memcpy(&bss_conf->tx_pwr_env[j], elems.tx_pwr_env[i],
+				       elems.tx_pwr_env_len[i]);
+				j++;
+			}
+		}
+
 		if (!ieee80211_verify_sta_he_mcs_support(sband, he_oper))
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
-- 
2.31.1

