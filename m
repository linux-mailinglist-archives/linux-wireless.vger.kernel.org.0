Return-Path: <linux-wireless+bounces-36448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHe/DlB7BmqFkAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:48:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD870548896
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 03:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD663307B069
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 01:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6866A1DF26E;
	Fri, 15 May 2026 01:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c5B51Z65"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99F216A956
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809532; cv=none; b=KJtfl0p9/Ax5KFGZw49hHkY+ZVRiFd+J2ts86hLHqJYiwGsjX0SXUx5U/91aLHISrh9cA40h/W0fhARhov4rXgVKfMG0EenjZGaXLSylE3DL4SiSRvc/oIjAbgXBM8mSjAEKn2oiakEjQ1hzlTwTTvGpqtLbRy8zS1AwmssXNOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809532; c=relaxed/simple;
	bh=lze1GJHvqnJ9Ol/xuAvJ7o00Ner8f/xLHCLiry8vt7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rmfaqAY5RcXkZIdglNotFPJVKmqjugK6E4SAEumtQeiqKU6pu1HVihoMY9FnuJSlGwpxZu70oQPsrge/k56mCflxjf3lsHxqsR1DQhvY4jVHNw/Gvd+eJDFUQ0Afon1VEOCydGJR5Ylnf8w1Zq8fmFxezyEm9UQNDZulwKuur5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c5B51Z65; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64F1jTSY12587284, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778809529; bh=jw/8Nw56iRUvV/IOrhDqwtTgXdIwJ1sCUTG2lo47BLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=c5B51Z65294ks53EcJtZN5KinMkc9e9mLilpGwYjUhm8j3NW95tPHu3OQMzvcSlu9
	 lGeMe2fCFAYO5qyOE6gUx5rv2aFgDizUYWbj/9WLXw2mTlFuW8vtVOU5+53bEjkDsp
	 d3HtA+400OgeNonEnuY65vJl3GbYklujnVk1UlffHOoyOxnkCp7CzTwGP2x8jcifWE
	 7lTwrVcb2tU9TK7+lxG+DizmU4TLX57DiQkjKOYgiNh7H1bTAz5fLjtTl8imf+OEpQ
	 USvDK7IkatGKngGlsRrXvTy2Yrf7u9pqTszH3Y9ulAq4sJfWlftFKvOEpWeGUuyAKL
	 X6rmf8DquQQig==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64F1jTSY12587284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 09:45:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 15 May 2026 09:45:29 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 15 May 2026 09:45:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <dian_syuan0116@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/13] wifi: rtw89: correct drop logic for malformed AMPDU frames
Date: Fri, 15 May 2026 09:44:29 +0800
Message-ID: <20260515014433.16168-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260515014433.16168-1-pkshih@realtek.com>
References: <20260515014433.16168-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Queue-Id: AD870548896
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36448-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Action: no action

From: Po-Hao Huang <phhuang@realtek.com>

The previous commit aims to fix issue caused by malformed AMPDU frames.
But the drop logic fails to deal with the first AMPDU packet paired with
certain range of sequence number, and leads to unexpected packet drop.
It is more likely to encounter this failure when there are busy traffic
during rekey process and could lead to disconnection from the AP.
Fix this by adding a initial state judgement and only reset status
during pairwise rekey.

Fixes: bda294ed0ed0 ("wifi: rtw89: Drop malformed AMPDU frames with abnormal PN")
Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 3 ++-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 432d46dfd26a..533b83c32f8d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3948,7 +3948,8 @@ static bool rtw89_core_skb_pn_valid(struct rtw89_dev *rtwdev,
 		last_pn = tid_stats->last_pn;
 
 		if (pn > last_pn) {
-			if (ieee80211_sn_less(mpdu_sn, tid_stats->last_sn)) {
+			if (last_pn != -1LL &&
+			    ieee80211_sn_less(mpdu_sn, tid_stats->last_sn)) {
 				dev_kfree_skb_any(skb);
 
 				return false;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 330ece51286d..aade5c5b79e8 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -979,7 +979,8 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 			rtw89_err(rtwdev, "failed to add key to sec cam\n");
 			return ret;
 		}
-		rtw89_core_tid_rx_stats_reset(rtwdev);
+		if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
+			rtw89_core_tid_rx_stats_reset(rtwdev);
 		break;
 	case DISABLE_KEY:
 		flush_work(&rtwdev->txq_work);
-- 
2.25.1


