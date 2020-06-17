Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333161FCE34
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jun 2020 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgFQNQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 Jun 2020 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgFQNQq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 Jun 2020 09:16:46 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7C1C06174E
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2020 06:16:46 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x6so2268986wrm.13
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jun 2020 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=rUTamwVsFfIxX0FoNrI1EuwJboOVJFzFBh6bUv/7kXc=;
        b=qJ8uuRIXDig991gbCVSwZHvoZKyAX4E7UoFHVL7ks6vfiz3KtLQFn0diGop4bkfhb3
         fddJnM+QuyfKRZlkuCAxP2+7wNLHGYiPu7BM1l7lQGqp0J5w2an/njPKFdPspxlt4url
         ZCA0sGnuGI+BGOmUdzEg0xVGYG3TSdfSFWaZMmRjIGyfSAxlfspwziWjLj4YkjlBMFPp
         Sc24nZIfL0BsOsWbLbVDIYVeMxN/ZUSyoIGF1Z4L6ucUOxi8qTQ9LU6KYOuXVU2ExSDW
         pWWzarf7y7h+clE+Qb+M/IsmRZZrgTFIkAHeW+bhqlzvrgqlo57g4JOOd9IGk7Ye9fkB
         xojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rUTamwVsFfIxX0FoNrI1EuwJboOVJFzFBh6bUv/7kXc=;
        b=PDTYWAlj8oir+nDyRAiKXN/DD2PDG49F+C80pS8GfFHBWOkXfp8Dqkz8tQhBqD8Elk
         vEv8tU6CSaQBD9jqf77EIbuUHBexd1gXqwmiGhN9s7P5qlpLpnNgh3lglXKMQZ+uPnot
         Y4kBIBMkdbhQUdqnMadMvlNeb4CRfd5+LOmh/v7oLZ1JQfhfBfUvmp6WEcRNizOuWLtp
         o0Rpw5nWeIr6OuB0ADjXd/dM//It+6XxZCe706Mtk3IY5mJEV8Q4jc73Tncjz067Oh15
         ETHpkR6MJDPCwT3LT5g4/mYSdTDaEvKTZ/kIIz2aXXkmdt3AsUJH8MCxaFNH4eSA0zdL
         PxJQ==
X-Gm-Message-State: AOAM533XkMyDNI1X8OaC96BlD+qopenEbmluZ+LdbtGOEEEzXOEvg23f
        7uyDcmK/5kPUpZ1kLmM1R+ZO4wQ2WColwQ==
X-Google-Smtp-Source: ABdhPJy/OQwUfo3Szzf29ioCB2XtDfXfOzLyJSEyzZtHxfrAFln1EBLxpxBt5FSzwCYrsyKcjb6rww==
X-Received: by 2002:a05:6000:12c8:: with SMTP id l8mr8706557wrx.148.1592399804680;
        Wed, 17 Jun 2020 06:16:44 -0700 (PDT)
Received: from localhost.localdomain ([88.122.66.28])
        by smtp.gmail.com with ESMTPSA id z6sm32906859wrh.79.2020.06.17.06.16.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 06:16:44 -0700 (PDT)
From:   Loic Poulain <loic.poulain@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] wcn36xx: Fix multiple AMPDU sessions support
Date:   Wed, 17 Jun 2020 15:21:40 +0200
Message-Id: <1592400100-22666-1-git-send-email-loic.poulain@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Several AMPDU sessions can be started, e.g. for different TIDs.
Currently the driver does not take care of the session ID when
requesting block-ack (statically set to 0), which leads to never
block-acked packet with sessions other than 0.

Fix this by saving the session id when creating the ba session and
use it in subsequent ba operations.

This issue can be reproduced with iperf in two steps (tid 0 strem
then tid 6 stream).

1.0 iperf -s                                # wcn36xx side
1.1 iperf -c ${IP_ADDR}                     # host side

Then

2.0 iperf -s -u -S 0xC0                     # wcn36xx side
2.1 iperf -c ${IP_ADDR} -u -S 0xC0 -l 2000  # host side

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 10 ++++++----
 drivers/net/wireless/ath/wcn36xx/smd.c  | 32 ++++++++++++++++++++++++++------
 drivers/net/wireless/ath/wcn36xx/smd.h  |  4 ++--
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 702b689..af32bd6 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1083,6 +1083,7 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	u16 tid = params->tid;
 	u16 *ssn = &params->ssn;
 	int ret = 0;
+	u8 session;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac ampdu action action %d tid %d\n",
 		    action, tid);
@@ -1092,10 +1093,11 @@ static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		sta_priv->tid = tid;
-		wcn36xx_smd_add_ba_session(wcn, sta, tid, ssn, 0,
-			get_sta_index(vif, sta_priv));
-		wcn36xx_smd_add_ba(wcn);
-		wcn36xx_smd_trigger_ba(wcn, get_sta_index(vif, sta_priv));
+		session = wcn36xx_smd_add_ba_session(wcn, sta, tid, ssn, 0,
+						     get_sta_index(vif, sta_priv));
+		wcn36xx_smd_add_ba(wcn, session);
+		wcn36xx_smd_trigger_ba(wcn, get_sta_index(vif, sta_priv), tid,
+				       session);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		wcn36xx_smd_del_ba(wcn, tid, get_sta_index(vif, sta_priv));
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 77269ac..0ad605f 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2102,6 +2102,22 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	return ret;
 }
 
+static int wcn36xx_smd_add_ba_session_rsp(void *buf, int len, u8 *session)
+{
+	struct wcn36xx_hal_add_ba_session_rsp_msg *rsp;
+
+	if (len < sizeof(*rsp))
+		return -EINVAL;
+
+	rsp = (struct wcn36xx_hal_add_ba_session_rsp_msg *) buf;
+	if (WCN36XX_FW_MSG_RESULT_SUCCESS != rsp->status)
+		return rsp->status;
+
+	*session = rsp->ba_session_id;
+
+	return 0;
+}
+
 int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 		struct ieee80211_sta *sta,
 		u16 tid,
@@ -2110,6 +2126,7 @@ int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 		u8 sta_index)
 {
 	struct wcn36xx_hal_add_ba_session_req_msg msg_body;
+	u8 session_id;
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
@@ -2135,17 +2152,20 @@ int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 		wcn36xx_err("Sending hal_add_ba_session failed\n");
 		goto out;
 	}
-	ret = wcn36xx_smd_rsp_status_check(wcn->hal_buf, wcn->hal_rsp_len);
+	ret = wcn36xx_smd_add_ba_session_rsp(wcn->hal_buf, wcn->hal_rsp_len,
+					     &session_id);
 	if (ret) {
 		wcn36xx_err("hal_add_ba_session response failed err=%d\n", ret);
 		goto out;
 	}
+
+	ret = session_id;
 out:
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
 
-int wcn36xx_smd_add_ba(struct wcn36xx *wcn)
+int wcn36xx_smd_add_ba(struct wcn36xx *wcn, u8 session_id)
 {
 	struct wcn36xx_hal_add_ba_req_msg msg_body;
 	int ret;
@@ -2153,7 +2173,7 @@ int wcn36xx_smd_add_ba(struct wcn36xx *wcn)
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_ADD_BA_REQ);
 
-	msg_body.session_id = 0;
+	msg_body.session_id = session_id;
 	msg_body.win_size = WCN36XX_AGGR_BUFFER_SIZE;
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
@@ -2212,7 +2232,7 @@ static int wcn36xx_smd_trigger_ba_rsp(void *buf, int len)
 	return rsp->status;
 }
 
-int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index)
+int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u8 session_id)
 {
 	struct wcn36xx_hal_trigger_ba_req_msg msg_body;
 	struct wcn36xx_hal_trigger_ba_req_candidate *candidate;
@@ -2221,7 +2241,7 @@ int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index)
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_TRIGGER_BA_REQ);
 
-	msg_body.session_id = 0;
+	msg_body.session_id = session_id;
 	msg_body.candidate_cnt = 1;
 	msg_body.header.len += sizeof(*candidate);
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
@@ -2229,7 +2249,7 @@ int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index)
 	candidate = (struct wcn36xx_hal_trigger_ba_req_candidate *)
 		(wcn->hal_buf + sizeof(msg_body));
 	candidate->sta_index = sta_index;
-	candidate->tid_bitmap = 1;
+	candidate->tid_bitmap = 1 << tid;
 
 	ret = wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.h b/drivers/net/wireless/ath/wcn36xx/smd.h
index ff15df8..68c59df 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.h
+++ b/drivers/net/wireless/ath/wcn36xx/smd.h
@@ -132,9 +132,9 @@ int wcn36xx_smd_add_ba_session(struct wcn36xx *wcn,
 		u16 *ssn,
 		u8 direction,
 		u8 sta_index);
-int wcn36xx_smd_add_ba(struct wcn36xx *wcn);
+int wcn36xx_smd_add_ba(struct wcn36xx *wcn, u8 session_id);
 int wcn36xx_smd_del_ba(struct wcn36xx *wcn, u16 tid, u8 sta_index);
-int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index);
+int wcn36xx_smd_trigger_ba(struct wcn36xx *wcn, u8 sta_index, u16 tid, u8 session_id);
 
 int wcn36xx_smd_update_cfg(struct wcn36xx *wcn, u32 cfg_id, u32 value);
 
-- 
2.7.4

