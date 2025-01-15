Return-Path: <linux-wireless+bounces-17565-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB9AA12999
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 18:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4203A71DA
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67523C47B;
	Wed, 15 Jan 2025 17:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="kILSfVn/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8480F1581F0
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736961494; cv=none; b=UAzWWx988bbw+IcZ3kWZo503PicZShWiKxnBshHp5cAQZQvd2+oE3uq07mPWofQ+7ArlNq8RBvEq3vs8bYyRj8esl8/0hTo3YF+vZ6NOKdImWxsUczJl0xJuMJcwIX559hViozklUcdjuQQNdvwjx10gV6UahCOVWXqtzzX3CNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736961494; c=relaxed/simple;
	bh=byoDkJh1sgS03N2aPX4X/edWNq6voO+iZl+z5fDCuK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3mi4YolNwDClmSdPnWjjqFPuwTbK/k566uG7YeCP5q1i2E0g0ak44OarN2NnFlui9UhoiDA7Izp/DU+HlW/ZrXCQzraL+n6z3OGDSzllQPw4xQymxYzZOrLL8qBUtaK/BBEo7iv7VRybHJk31V0Qp/fsgX0piL2u/5pXcK1Fm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=kILSfVn/; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:171e:0:640:d7a4:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id B4060472D8;
	Wed, 15 Jan 2025 20:18:01 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 0IUVK7BOjmI0-NfxPfTqf;
	Wed, 15 Jan 2025 20:18:01 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1736961481; bh=DEWOMBB6G6T+uwlkw7rDtm5LkbvDogHc1ZbSek+OmX0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=kILSfVn/uH8gic5BuZ7zsinbCaxsIdCD9xlAcweTVvWsVm7owgETj2n073PKO63md
	 VfVtcvVmmlersyFtBKjy8BKeD4OsnZWXBg9K8NmqL+29t8EqZQfCk8IkC4o4+FQscJ
	 m9kRCXiHKnxLPdhqe515yUYwR2soP/C5XLtW2y1M=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Kalle Valo <kvalo@kernel.org>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 1/2] wifi: ath9k: cleanup struct ath_tx_control and ath_tx_prepare()
Date: Wed, 15 Jan 2025 20:17:49 +0300
Message-ID: <20250115171750.259917-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.48.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After switching to mac80211 software queues, pointer to 'struct ath_node'
in 'struct ath_tx_control' is still assigned but not actually used. So drop
it and cleanup related things in 'ath_tx_prepare()'. Compile tested only.

Fixes: 50f08edf9809 ("ath9k: Switch to using mac80211 intermediate software queues.")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/net/wireless/ath/ath9k/ath9k.h | 1 -
 drivers/net/wireless/ath/ath9k/xmit.c  | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/ath9k.h b/drivers/net/wireless/ath/ath9k/ath9k.h
index bcfc8df0efe5..65c2250db33d 100644
--- a/drivers/net/wireless/ath/ath9k/ath9k.h
+++ b/drivers/net/wireless/ath/ath9k/ath9k.h
@@ -274,7 +274,6 @@ struct ath_node {
 
 struct ath_tx_control {
 	struct ath_txq *txq;
-	struct ath_node *an;
 	struct ieee80211_sta *sta;
 	u8 paprd;
 };
diff --git a/drivers/net/wireless/ath/ath9k/xmit.c b/drivers/net/wireless/ath/ath9k/xmit.c
index 0a24439dd30d..84f8c28b038b 100644
--- a/drivers/net/wireless/ath/ath9k/xmit.c
+++ b/drivers/net/wireless/ath/ath9k/xmit.c
@@ -2295,19 +2295,10 @@ static int ath_tx_prepare(struct ieee80211_hw *hw, struct sk_buff *skb,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_sta *sta = txctl->sta;
 	struct ieee80211_vif *vif = info->control.vif;
-	struct ath_vif *avp;
 	struct ath_softc *sc = hw->priv;
 	int frmlen = skb->len + FCS_LEN;
 	int padpos, padsize;
 
-	/* NOTE:  sta can be NULL according to net/mac80211.h */
-	if (sta)
-		txctl->an = (struct ath_node *)sta->drv_priv;
-	else if (vif && ieee80211_is_data(hdr->frame_control)) {
-		avp = (void *)vif->drv_priv;
-		txctl->an = &avp->mcast_node;
-	}
-
 	if (info->control.hw_key)
 		frmlen += info->control.hw_key->icv_len;
 
-- 
2.48.0


