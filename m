Return-Path: <linux-wireless+bounces-27292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9C0B570BB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65B43A336D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C972C0293;
	Mon, 15 Sep 2025 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uUcWhnhf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3A32C028B
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919310; cv=none; b=APtso6D30nwdSrQaQ0uQrn/pavkmJt+BHFFgFiVL7Y9oSHLWaGwQjm377sAca23UOF7khsNpn09rxyWn2lpAhiWYpjDkVAPxK1K3welW+4sR+G3AgKENmHCZIpN3vliU8UMA67hQUbltOq5qZcZIV9MEYZxMoQurJc07VkEafYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919310; c=relaxed/simple;
	bh=9j0Vmf574MYZRQhoGVTGnlibCK7o/bQ/FvrpxeQr33I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iZRQ9sHx+n8O10lq0pJCxyx1D+9i9UQPUg+fWaXfnMgHrig0Vdq9CdBAQqJXjZKC76m33LStkDrpji6eDIAsU7hE3XlXdLCmw7mWm4XIDdfipF8ZDySEzeuv/L/djjLwqhk4W9iN3WKkzztIKyXEhJiTW346O0gHLei/j2tjY4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uUcWhnhf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6t6fQ5594717, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919306; bh=kUcnW7+lVvE+IgvL4gfoRJnjr68Zm5YZUwZqDA776j4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uUcWhnhfxfE2TVMIGTlouCbV2sfOHo71c8Poq2qnPHxpwzfLR3P0/8ZTRRraWq7G2
	 vXdA3tz1Vp47LICtDuKzvQNpCjQIG1OsyayGL/ga5dJF6lr5/i+zQxDSIYKj5xebQG
	 igToefQ9169F+fW1qG+befA4R6kloY395FQIGOygQ3m9BCDX4QPoTo5AqEzQ2VkCkS
	 r4alLmA/l91Twh2mAd/KmS1Nrr6nWQ6y8JOavXKw11KYl/BlnD7PvwXVR4//DYYYTJ
	 4ToNcpYsIbkicLHuOHnccUr2JyUP8aKea6B0VolauxhCxgq6UutX9U4DCkc0KXxK+b
	 iJdenpZsp10XQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6t6fQ5594717
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:55:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:55:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:55:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/11] wifi: rtw89: open C2H event waiting window first before sending H2C command
Date: Mon, 15 Sep 2025 14:53:52 +0800
Message-ID: <20250915065352.39082-1-pkshih@realtek.com>
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

Some H2C commands need to wait for target C2H events to confirm they
are executed well. The characteristics of a target C2H event will be
encoded into a value, called condition. Then, the corresponding H2C
command will wait for it. And, C2H events will complete a condition
according to their own characteristics. So, when conditions of both
side match, the corresponding H2C command will be completed.

Originally, condition waiting window is opened after the H2C command
is sent. However, for CPU-bound systems, target C2H event might be
already done before the H2C command opens condition waiting window.
Without that, C2H event won't match condition, and it will complete
nothing. Finally, H2C command wait will time out.

Hence, now open condition waiting window first for H2C commands which
need to wait for target C2H events. The waiting function is split to
two parts, prepare and evaluate. And, waiting side becomes the below
where prepare part and evaluate part must be a pair.

    waiting prepare: condition
        (open condition waiting window)

        Do the needed things to trigger completing side.
        Record errors that will cause no real completer.

    waiting evaluate: prepare, errors
        (start waiting for completion if things are fine;
         otherwise, clean up and return final result.)

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c | 36 ++++++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/core.h |  7 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c   | 19 ++++++++----
 3 files changed, 48 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 759b9f850df2..c7907949d3a2 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -5338,27 +5338,47 @@ void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 	}
 }
 
-int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond)
+struct rtw89_wait_response *
+rtw89_wait_for_cond_prep(struct rtw89_wait_info *wait, unsigned int cond)
 {
 	struct rtw89_wait_response *prep;
-	unsigned long time_left;
 	unsigned int cur;
-	int err = 0;
+
+	/* use -EPERM _iff_ telling eval side not to make any changes */
 
 	cur = atomic_cmpxchg(&wait->cond, RTW89_WAIT_COND_IDLE, cond);
 	if (cur != RTW89_WAIT_COND_IDLE)
-		return -EBUSY;
+		return ERR_PTR(-EPERM);
 
 	prep = kzalloc(sizeof(*prep), GFP_KERNEL);
-	if (!prep) {
-		err = -ENOMEM;
-		goto reset;
-	}
+	if (!prep)
+		return ERR_PTR(-ENOMEM);
 
 	init_completion(&prep->completion);
 
 	rcu_assign_pointer(wait->resp, prep);
 
+	return prep;
+}
+
+int rtw89_wait_for_cond_eval(struct rtw89_wait_info *wait,
+			     struct rtw89_wait_response *prep, int err)
+{
+	unsigned long time_left;
+
+	if (IS_ERR(prep)) {
+		err = err ?: PTR_ERR(prep);
+
+		/* special error case: no permission to reset anything */
+		if (PTR_ERR(prep) == -EPERM)
+			return err;
+
+		goto reset;
+	}
+
+	if (err)
+		goto cleanup;
+
 	time_left = wait_for_completion_timeout(&prep->completion,
 						RTW89_WAIT_FOR_COND_TIMEOUT);
 	if (time_left == 0) {
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 2098c033b461..8408d5d8d42d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -7549,7 +7549,12 @@ int rtw89_regd_init_hint(struct rtw89_dev *rtwdev);
 const char *rtw89_regd_get_string(enum rtw89_regulation_type regd);
 void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 			      struct rtw89_traffic_stats *stats);
-int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond);
+struct rtw89_wait_response *
+rtw89_wait_for_cond_prep(struct rtw89_wait_info *wait, unsigned int cond)
+__acquires(rtw89_wait);
+int rtw89_wait_for_cond_eval(struct rtw89_wait_info *wait,
+			     struct rtw89_wait_response *prep, int err)
+__releases(rtw89_wait);
 void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 			 const struct rtw89_completion_data *data);
 int rtw89_core_start(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index dbb94ed1f3c0..9c98c25c10ce 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8786,21 +8786,30 @@ int rtw89_fw_h2c_wow_request_aoac(struct rtw89_dev *rtwdev)
 static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 				 struct rtw89_wait_info *wait, unsigned int cond)
 {
-	int ret;
+	struct rtw89_wait_response *prep;
+	int ret = 0;
 
 	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
+	prep = rtw89_wait_for_cond_prep(wait, cond);
+	if (IS_ERR(prep))
+		goto out;
+
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
 		dev_kfree_skb_any(skb);
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
-	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags))
-		return 1;
+	if (test_bit(RTW89_FLAG_SER_HANDLING, rtwdev->flags)) {
+		ret = 1;
+		goto out;
+	}
 
-	return rtw89_wait_for_cond(wait, cond);
+out:
+	return rtw89_wait_for_cond_eval(wait, prep, ret);
 }
 
 #define H2C_ADD_MCC_LEN 16
-- 
2.25.1


