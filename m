Return-Path: <linux-wireless+bounces-28246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC15C09445
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 18:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A2B03B3C7D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 16:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C4C3054F0;
	Sat, 25 Oct 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkbXtnlz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E5303CAE;
	Sat, 25 Oct 2025 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761408827; cv=none; b=JZ4yheaGHEg6A913PIOqDeWQ1XX/oQQXxKk0RSu8mIAdiJgrwFxyKlOhxMjGyCzZ+IUD83z2VVCONbCQM4efGHEpQwyuMr72dE7BfLwx42fb3y7JEmhzU95mbFNKydt1qemOeqV/If4+uNwlv313QHcvpn8dqxtE+BoK6LcC06A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761408827; c=relaxed/simple;
	bh=T2giKg+qF6Nfy4umlarcbSoYvJ6K2c4UGvre46xLhpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHBUPj1Zz64SkWreOJcbFXprSSacLzjDoBL3AwYS93x3ihrB/tdSJxw8oke+bUD+j08QPytRtjcAEAaBdSMci0QPw+/10xdTgQ5C3xTe8IQoUKu+vqbuugpBCasMtYsVcGXDoGedfGbd06llso2Egu+i6TIGbAo25FjkYABj5gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkbXtnlz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEF5AC4CEF5;
	Sat, 25 Oct 2025 16:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761408827;
	bh=T2giKg+qF6Nfy4umlarcbSoYvJ6K2c4UGvre46xLhpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkbXtnlzunTfaA7YKx9wxymdYhmltydfa4I8OwWUJgrw4IgMRfp9+S+osXaqbBuML
	 fMPFSzT3APZc63wqULaYCks0PyBEuyBhpVcvAzIwjLPbmhk4ginuYBtrQdx+0gHDve
	 SI0o7UCKjXHdM75v8TzN2x1G7bxqWkJh+mFgh8Qi/NpSx6kvavxQ1PaCZFSfDF4568
	 e8P8H4xE01leJlU0ZKFVODLS0eQlmOibaOzfJWdyJzaZMzqd+J5s7XcotDPsve6Dov
	 WIdVLeE43wVhkeEtNBp0TJuJYulrzqK6D/3Uk19g/MtDOtMI+0l92yS2T4Y37X0WWl
	 99ve8B/IkGsfQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zong-Zhe Yang <kevin_yang@realtek.com>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.12] wifi: rtw89: renew a completion for each H2C command waiting C2H event
Date: Sat, 25 Oct 2025 11:55:20 -0400
Message-ID: <20251025160905.3857885-89-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Zong-Zhe Yang <kevin_yang@realtek.com>

[ Upstream commit bc2a5a12fa6259e190c7edb03e63b28ab480101b ]

Logically before a waiting side which has already timed out turns the
atomic status back to idle, a completing side could still pass atomic
condition and call complete. It will make the following H2C commands,
waiting C2H events, get a completion unexpectedly early. Hence, renew
a completion for each H2C command waiting a C2H event.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250915065343.39023-1-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES
**Why Backport**
- A timed-out wait leaves the shared completion object signaled, so the
  very next H2C command returns before firmware really responds and
  reuses stale `wait->data`, breaking consumers like
  `rtw89_fw_h2c_mcc_req_tsf` that immediately copy that buffer
  (`drivers/net/wireless/realtek/rtw89/fw.c:7484`).
- The fix adds `struct rtw89_wait_response` and an RCU-protected pointer
  in `rtw89_wait_info`, giving each wait its own completion/data storage
  and preventing reuse of a fulfilled completion
  (`drivers/net/wireless/realtek/rtw89/core.h:4014`).
- `rtw89_wait_for_cond` now allocates, initializes, and frees that
  response around every wait, so late C2H replies can only complete the
  instance that created them and never affect a later command
  (`drivers/net/wireless/realtek/rtw89/core.c:4463`).
- The completion path dereferences the current response under RCU before
  signalling, guaranteeing that firmware acks only wake the matching
  waiter and that late packets after a timeout are safely ignored
  (`drivers/net/wireless/realtek/rtw89/core.c:4503`,
  `drivers/net/wireless/realtek/rtw89/mac.c:4493`).
- Adding `lockdep_assert_wiphy` documents the required serialization,
  and the new `kzalloc`/`kfree_rcu` pair is tiny and self-contained,
  making regression risk low compared to the hard failures this race
  causes in power-save, WoW, and MCC command flows
  (`drivers/net/wireless/realtek/rtw89/fw.c:7304`).

Next steps: 1) Consider also pulling `a27136f1050a6` (“open C2H event
waiting window first...”) which complements this area but fixes a
different race.

 drivers/net/wireless/realtek/rtw89/core.c | 49 ++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/core.h | 10 ++++-
 drivers/net/wireless/realtek/rtw89/fw.c   |  2 +
 3 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2cebea10cb99b..9896c4ab7146b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4860,37 +4860,74 @@ void rtw89_core_csa_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 
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
index 2de9505c48ffc..460453e63f844 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4545,17 +4545,23 @@ struct rtw89_completion_data {
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
index e6f8fab799fc1..7a5d616f7a9b8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8679,6 +8679,8 @@ static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 {
 	int ret;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-- 
2.51.0


