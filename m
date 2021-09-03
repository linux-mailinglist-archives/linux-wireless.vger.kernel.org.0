Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D62453FFF63
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235252AbhICLts (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:49:48 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:17175 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbhICLtr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669728; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MII1jvCgs+l0Vv+ZFpi/PRCGlZgAoEL+LQqoA/PUiCE=; b=poCF6gxKX5kOkOoauNbmc8hnKh26PCD5DyFJILze+3lRIwCMQKZynJM1ckfVWdozGN0jrNof
 5v2U7gh2SPM4EgMqWuYzFet9WeGe5ftknJ07Tx8oMWTl4JAZkOmrb7c8LRRc1F8rzCXdy5gC
 u28UcF55Yrbqgx3kseHAJ2COK5k=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61320b9b1567234b8c8fec61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:43
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86215C4360C; Fri,  3 Sep 2021 11:48:42 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBED6C4360C;
        Fri,  3 Sep 2021 11:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org BBED6C4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 9/9] mac80211: save transmit power envelope element and power constraint
Date:   Fri,  3 Sep 2021 07:48:21 -0400
Message-Id: <20210903114821.23346-10-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
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
 net/mac80211/mlme.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d0522d7f3351..0ac6fe7b8f99 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -632,6 +632,9 @@ struct ieee80211_fils_discovery {
  * @beacon_tx_rate: The configured beacon transmit rate that needs to be passed
  *	to driver when rate control is offloaded to firmware.
  * @power_type: power type of BSS for 6 GHz
+ * @tx_pwr_env: transmit power envelope array of BSS.
+ * @tx_pwr_env_num: number of @tx_pwr_env.
+ * @pwr_reduction: power constraint of BSS.
  */
 struct ieee80211_bss_conf {
 	const u8 *bssid;
@@ -702,6 +705,9 @@ struct ieee80211_bss_conf {
 	bool s1g;
 	struct cfg80211_bitrate_mask beacon_tx_rate;
 	enum ieee80211_ap_reg_power power_type;
+	struct ieee80211_tx_pwr_env tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
+	u8 tx_pwr_env_num;
+	u8 pwr_reduction;
 };
 
 /**
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 6b32cdd590cd..cda28ec58a31 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2340,6 +2340,7 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
 	struct ieee80211_local *local = sdata->local;
+	struct ieee80211_bss_conf *bss_conf;
 	u32 changed = 0;
 
 	sdata_assert_lock(sdata);
@@ -2483,6 +2484,11 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	cancel_delayed_work_sync(&ifmgd->tx_tspec_wk);
 
 	sdata->encrypt_headroom = IEEE80211_ENCRYPT_HEADROOM;
+
+	bss_conf = &sdata->vif.bss_conf;
+	bss_conf->pwr_reduction = 0;
+	bss_conf->tx_pwr_env_num = 0;
+	memset(bss_conf->tx_pwr_env, 0, sizeof(bss_conf->tx_pwr_env));
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -5087,6 +5093,30 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		else
 			he_oper = NULL;
 
+		if (is_6ghz) {
+			struct ieee80211_bss_conf *bss_conf;
+			u8 i, j = 0;
+
+			bss_conf = &sdata->vif.bss_conf;
+
+			if (elems->pwr_constr_elem)
+				bss_conf->pwr_reduction = *elems->pwr_constr_elem;
+
+			BUILD_BUG_ON(ARRAY_SIZE(bss_conf->tx_pwr_env) !=
+				     ARRAY_SIZE(elems->tx_pwr_env));
+
+			for (i = 0; i < elems->tx_pwr_env_num; i++) {
+				if (elems->tx_pwr_env_len[i] >
+				    sizeof(bss_conf->tx_pwr_env[j]))
+					continue;
+
+				bss_conf->tx_pwr_env_num++;
+				memcpy(&bss_conf->tx_pwr_env[j], elems->tx_pwr_env[i],
+				       elems->tx_pwr_env_len[i]);
+				j++;
+			}
+		}
+
 		if (!ieee80211_verify_sta_he_mcs_support(sband, he_oper))
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
-- 
2.31.1

