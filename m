Return-Path: <linux-wireless+bounces-2468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350B483BCE6
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 10:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C94E31F2FA0E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 09:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0541C696;
	Thu, 25 Jan 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="dOj1MvzF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993F1C69A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 09:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173671; cv=none; b=MkQ03iKLoE6IteaZmdwhcpRvv/ZeiYgaRP59NdClQsW6i01y6wT5ExGMU6pQFj4ZouHiV0n0bXIW6f2AW70EUUmC6TNX1NCmoJB2PrBdFImNMgv4kzuCP5vKkKP9oAxz/9hrGGTElRItRARYKig2gi36KG/cWLbeSiUYYRkxCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173671; c=relaxed/simple;
	bh=G4rxPxqYrOpEeiC4aFEAtejlZsQCpMNz4ARIWqxN05s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fb49PFTwj4ZSOmlNusSmFXFbkfU2M+kasPiuzzO8x90vGO076kxWP36YZ7kxch11KYyAsBkKqr43fMvbTKqXFX+TVfuEd8OJo60GwwGIH34tRzeKnMF3nsERG+LAQlgW4A8jQYNBeJXW3csZ+2Uc0JhNe4atxnbmO4S3nCJxj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=dOj1MvzF; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:230c:0:640:f8e:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 2976146CA2;
	Thu, 25 Jan 2024 12:07:45 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id h7QI3JPOhCg0-qsevXirJ;
	Thu, 25 Jan 2024 12:07:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1706173664; bh=9FTqSChaLBwOJ7AOiCHLJGBn8v/vvYL98+V4pfVMXNI=;
	h=In-Reply-To:Cc:References:To:Message-ID:Date:Subject:From;
	b=dOj1MvzFSK+PWcNPgYvhT7xFpoqBef4uOYsbDFsP64AT7/8yYqg/JI+G2KBz6roxV
	 L61wzhldOmZagXEM5plX7PX6Va+giaG+7BjKBNTm+xZSX38WopcSr3MGzbFhS0un2x
	 z/Z7wEzJBbWWWs65xDRK1o+m/9MKjWL1+dZe7bWg=
Authentication-Results: mail-nwsmtp-smtp-production-main-55.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Subject: [PATCH 1/1] wifi: mac80211: ignore the bitrate mask when scanning
Date: Thu, 25 Jan 2024 12:07:35 +0300
Message-ID: <20240125090737.49673-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125090737.49673-1-dmantipov@yandex.ru>
References: <58970b94a314414402a932576ec54188c0675016.camel@sipsolutions.net>
 <20240125090737.49673-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the frame is transmitted due to scanning rather than
regular operation on the interface, ignore the bitrate mask.

Reported-by: syzbot+fdc5123366fb9c3fdc6d@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
Suggested-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/mac80211.h | 3 +++
 net/mac80211/rate.c    | 4 +++-
 net/mac80211/scan.c    | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d400fe2e8668..df9b578e58bb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -932,6 +932,8 @@ enum mac80211_tx_info_flags {
  *	of their QoS TID or other priority field values.
  * @IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX: first MLO TX, used mostly internally
  *	for sequence number assignment
+ * @IEEE80211_TX_CTRL_SCAN_TX: Indicates that this frame is transmitted
+ *	due to scanning, not in normal operation on the interface.
  * @IEEE80211_TX_CTRL_MLO_LINK: If not @IEEE80211_LINK_UNSPECIFIED, this
  *	frame should be transmitted on the specific link. This really is
  *	only relevant for frames that do not have data present, and is
@@ -952,6 +954,7 @@ enum mac80211_tx_control_flags {
 	IEEE80211_TX_CTRL_NO_SEQNO		= BIT(7),
 	IEEE80211_TX_CTRL_DONT_REORDER		= BIT(8),
 	IEEE80211_TX_CTRL_MCAST_MLO_FIRST_TX	= BIT(9),
+	IEEE80211_TX_CTRL_SCAN_TX		= BIT(10),
 	IEEE80211_TX_CTRL_MLO_LINK		= 0xf0000000,
 };
 
diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index d5ea5f5bcf3a..6878fe454c36 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -351,6 +351,7 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 	int i;
 	u32 rate_flags =
 		ieee80211_chandef_rate_flags(&hw->conf.chandef);
+	bool scanning = !!(info->control.flags & IEEE80211_TX_CTRL_SCAN_TX);
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		info->control.rates[0].flags |= IEEE80211_TX_RC_S1G_MCS;
@@ -364,7 +365,8 @@ static void __rate_control_send_low(struct ieee80211_hw *hw,
 
 	info->control.rates[0].idx = 0;
 	for (i = 0; i < sband->n_bitrates; i++) {
-		if (!(rate_mask & BIT(i)))
+		/* Do not use the bitrate mask when scanning. */
+		if (!scanning && !(rate_mask & BIT(i)))
 			continue;
 
 		if ((rate_flags & sband->bitrates[i].flags) != rate_flags)
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 645355e5f1bc..dd68dfe46e0e 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -632,6 +632,8 @@ static void ieee80211_send_scan_probe_req(struct ieee80211_sub_if_data *sdata,
 				cpu_to_le16(IEEE80211_SN_TO_SEQ(sn));
 		}
 		IEEE80211_SKB_CB(skb)->flags |= tx_flags;
+		IEEE80211_SKB_CB(skb)->control.flags |=
+			IEEE80211_TX_CTRL_SCAN_TX;
 		ieee80211_tx_skb_tid_band(sdata, skb, 7, channel->band);
 	}
 }
-- 
2.43.0


