Return-Path: <linux-wireless+bounces-27291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB0BB570BC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F121897D4E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39F5214236;
	Mon, 15 Sep 2025 06:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o7YxJxdD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA852C0F6F
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919302; cv=none; b=TruG7SSix7uhQFz9z/PqMFonPfzETR3KYXN7LTqFrTPUWJ0Zi7NnVJRYmnO1bpQ+1EZMqYwJ4wB1EKOS9D8ywEsLmrzMyBhDRQ6Z3t2FhsWHs8DQYMuC0xyxsAr18qQjxJMykAfMt7GXUChZxJqy1hUZ2VHxqt37LM4xZwa19QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919302; c=relaxed/simple;
	bh=Fp8yr3f4nwnuq83yS3W9wTUGaFv5+QtvqFPyGPTZppY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b5Rs+LmqWKFS1/m3wULc7G94gJb5mYocyZlXx5VfGCKJCvTUjtH/DgUZzWiB4OPJQYqbpv2zcI7rq+gs4qe002WbN2cKVWwpyg6HmLkQNQwMg4y7MPkjCV+7VplKinS6kecRQPUIC2GOEiCnEOmBZHIN0dWS/Obw2JI5VPLOu1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o7YxJxdD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6swCE3594478, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919298; bh=yF3kH9UWug/OcX+oBe5ad/zrw3gBjI1UqNglC2KpJVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=o7YxJxdDt7GHlZRSZPTCubP8HvFJQjUWuocnuhUMniSHymJQVUWG7XVi0Elmew/zd
	 GvUsumiHUvi3D74nDWsmH94rwyZx+UXQPfVfGOPKW5olOlePxrkelujZ1hSQFavKmp
	 7KnZv0PLuhv4njvGAi8tourvz9P7qT5kKcNqd8tURaCtVIAAw3ZZmicf5Ojmy4AvYq
	 NC7OLs9BrJ0+clO8J8P7O+jnP8aqoR/eaQp6e3PcbPdl+bVh2vOReHCW4xot/wBBib
	 M3kCBJCxjva9MiHFYZiwGi9j2C99v5HGKzmrYM+AIE7zpGif9DMg37IQ4+v7TZ0MGO
	 TCcqSxq6p2gSQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6swCE3594478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:54:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:54:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:54:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: renew a completion for each H2C command waiting C2H event
Date: Mon, 15 Sep 2025 14:53:43 +0800
Message-ID: <20250915065343.39023-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250915065213.38659-1-pkshih@realtek.com>
References: <20250915065213.38659-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Logically before a waiting side which has already timed out turns the
atomic status back to idle, a completing side could still pass atomic
condition and call complete. It will make the following H2C commands,
waiting C2H events, get a completion unexpectedly early. Hence, renew
a completion for each H2C command waiting a C2H event.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 49 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 10 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 +
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e445fcd02187..759b9f850df2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5340,37 +5340,74 @@ void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond)
 {
-	struct completion *cmpl = &wait->completion;
+	struct rtw89_wait_response *prep;
 	unsigned long time_left;
 	unsigned int cur;
+	int err = 0;
 
 	cur = atomic_cmpxchg(&wait->cond, RTW89_WAIT_COND_IDLE, cond);
 	if (cur != RTW89_WAIT_COND_IDLE)
 		return -EBUSY;
 
-	time_left = wait_for_completion_timeout(cmpl, RTW89_WAIT_FOR_COND_TIMEOUT);
+	prep = kzalloc(sizeof(*prep), GFP_KERNEL);
+	if (!prep) {
+		err = -ENOMEM;
+		goto reset;
+	}
+
+	init_completion(&prep->completion);
+
+	rcu_assign_pointer(wait->resp, prep);
+
+	time_left = wait_for_completion_timeout(&prep->completion,
+						RTW89_WAIT_FOR_COND_TIMEOUT);
 	if (time_left == 0) {
-		atomic_set(&wait->cond, RTW89_WAIT_COND_IDLE);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto cleanup;
 	}
 
+	wait->data = prep->data;
+
+cleanup:
+	rcu_assign_pointer(wait->resp, NULL);
+	kfree_rcu(prep, rcu_head);
+
+reset:
+	atomic_set(&wait->cond, RTW89_WAIT_COND_IDLE);
+
+	if (err)
+		return err;
+
 	if (wait->data.err)
 		return -EFAULT;
 
 	return 0;
 }
 
+static void rtw89_complete_cond_resp(struct rtw89_wait_response *resp,
+				     const struct rtw89_completion_data *data)
+{
+	resp->data = *data;
+	complete(&resp->completion);
+}
+
 void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 			 const struct rtw89_completion_data *data)
 {
+	struct rtw89_wait_response *resp;
 	unsigned int cur;
 
+	guard(rcu)();
+
+	resp = rcu_dereference(wait->resp);
+	if (!resp)
+		return;
+
 	cur = atomic_cmpxchg(&wait->cond, cond, RTW89_WAIT_COND_IDLE);
 	if (cur != cond)
 		return;
 
-	wait->data = *data;
-	complete(&wait->completion);
+	rtw89_complete_cond_resp(resp, data);
 }
 
 void rtw89_core_ntfy_btc_event(struct rtw89_dev *rtwdev, enum rtw89_btc_hmsg event)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 708132363da3..2098c033b461 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4550,17 +4550,23 @@ struct rtw89_completion_data {
 	u8 buf[RTW89_COMPLETION_BUF_SIZE];
 };
 
+struct rtw89_wait_response {
+	struct rcu_head rcu_head;
+	struct completion completion;
+	struct rtw89_completion_data data;
+};
+
 struct rtw89_wait_info {
 	atomic_t cond;
-	struct completion completion;
 	struct rtw89_completion_data data;
+	struct rtw89_wait_response __rcu *resp;
 };
 
 #define RTW89_WAIT_FOR_COND_TIMEOUT msecs_to_jiffies(100)
 
 static inline void rtw89_init_wait(struct rtw89_wait_info *wait)
 {
-	init_completion(&wait->completion);
+	rcu_assign_pointer(wait->resp, NULL);
 	atomic_set(&wait->cond, RTW89_WAIT_COND_IDLE);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 53d3591e2397..dbb94ed1f3c0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8788,6 +8788,8 @@ static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 {
 	int ret;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-- 
2.25.1


