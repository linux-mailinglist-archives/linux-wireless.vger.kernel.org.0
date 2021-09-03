Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27D63FFF66
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Sep 2021 13:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349315AbhICLuD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Sep 2021 07:50:03 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40733 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349150AbhICLt4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Sep 2021 07:49:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630669737; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=m6I4lQrgQMUlQhV7i0cGQqRPyKnzr9KCU3CfgE5qOBo=; b=ALzAIfTOmFiqxyO9F5Weh3tRw/aT7mgJNonWeUeop1Sg6OADNadPd+ElRT2CIPb+rRJvVCLc
 usdpeunm22lwCdXK1IxEH1OU0Fo9LFQAFjniOql7OXANlPZlq/FHUnOaJdVL7bb4AnzMUSDp
 /Oj9fbsLZWv4XwtaNNTjuHOYzB8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61320b9789cdb62061a55789 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Sep 2021 11:48:39
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5626EC4360D; Fri,  3 Sep 2021 11:48:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5941C43460;
        Fri,  3 Sep 2021 11:48:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org B5941C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     johannes@sipsolutions.net, ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, wgong@codeaurora.org
Subject: [PATCH v3 7/9] mac80211: add parse transmit power envelope element
Date:   Fri,  3 Sep 2021 07:48:19 -0400
Message-Id: <20210903114821.23346-8-wgong@codeaurora.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210903114821.23346-1-wgong@codeaurora.org>
References: <20210903114821.23346-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The transmit power envelope elements in beacon is used to calculate
the power limit by lower driver, and sometimes it has more than
one elements in a beacon frame.

This is to add parse the transmit power envelope elements, then it
will be saved and transfer to lower driver to calculate the power
limit.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 net/mac80211/ieee80211_i.h |  3 +++
 net/mac80211/util.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 648696b49f89..bb62de5e3758 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1494,6 +1494,7 @@ struct ieee802_11_elems {
 	const struct ieee80211_he_spr *he_spr;
 	const struct ieee80211_mu_edca_param_set *mu_edca_param_set;
 	const struct ieee80211_he_6ghz_capa *he_6ghz_capa;
+	const struct ieee80211_tx_pwr_env *tx_pwr_env[IEEE80211_TPE_MAX_IE_COUNT];
 	const u8 *uora_element;
 	const u8 *mesh_id;
 	const u8 *peering;
@@ -1544,6 +1545,8 @@ struct ieee802_11_elems {
 	u8 perr_len;
 	u8 country_elem_len;
 	u8 bssid_index_len;
+	u8 tx_pwr_env_len[IEEE80211_TPE_MAX_IE_COUNT];
+	u8 tx_pwr_env_num;
 
 	/* whether a parse error occurred while retrieving these elements */
 	bool parse_error;
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 04f2ba530d4f..c94ba3221086 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1336,6 +1336,16 @@ _ieee802_11_parse_elems_crc(const u8 *start, size_t len, bool action,
 			elems->rsnx = pos;
 			elems->rsnx_len = elen;
 			break;
+		case WLAN_EID_TX_POWER_ENVELOPE:
+			if (elems->tx_pwr_env_num >= ARRAY_SIZE(elems->tx_pwr_env) ||
+			    elen < 1 ||
+			    elen > sizeof(elems->tx_pwr_env[0]))
+				break;
+
+			elems->tx_pwr_env[elems->tx_pwr_env_num] = (void *)pos;
+			elems->tx_pwr_env_len[elems->tx_pwr_env_num] = elen;
+			elems->tx_pwr_env_num++;
+			break;
 		case WLAN_EID_EXTENSION:
 			ieee80211_parse_extension_element(calc_crc ?
 								&crc : NULL,
-- 
2.31.1

