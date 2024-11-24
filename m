Return-Path: <linux-wireless+bounces-15622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F06C9D709C
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 14:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067D016227B
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 13:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A671AF0DC;
	Sun, 24 Nov 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tEVgJzik"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4B81AF0DA;
	Sun, 24 Nov 2024 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455210; cv=none; b=qG2L8A0cpARW8N+RjwY5cg6Mbn8MEezRI2qRVgxY0jVsdr5+AHQ3AJWYvyPZsakhDJz2rBkmTkj1/6GoN/9+jMEgzK1SCZ6UvlQ75z5lCiEvIka+1EBeMWwL3aKf6M6u1R9gUmT2Uk2xZFhOSVCoRcwKmYhqh6hy1ld0sEERj1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455210; c=relaxed/simple;
	bh=l5K7zb8kbNcSVUyZ5VB+hQzn3RrjjX+wHEoFI3gLTQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf6nNzId3lYsEiwc17jOvDmdti9wHZDzUboYew84dKeNWg3OcG58HeVkHAwM9Vu3sknEj8lqJnJUs7SgLZ+htg4/r4TOnrIxjZU/WgDlwO6Il/xOiViLs/cvtVScdjVr6t3k+YKYuIrscsckJ0CXwq9W1mJekYVGo/colxtVDSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tEVgJzik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60070C4CED1;
	Sun, 24 Nov 2024 13:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455210;
	bh=l5K7zb8kbNcSVUyZ5VB+hQzn3RrjjX+wHEoFI3gLTQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tEVgJzikLNMmqrSkkseevEzVHJA9OQJKPDxlIdL+Qm72niF9zDr5BA5rXMN5jH1+F
	 L83pxQwRYfZNrWm+i28cm6iD+MOM/qxTuVVnn24tr/JvBKtC3LpDS2WkW5YD764CXd
	 HqvwyIuj+/u2833i3yezXcvlQoNbPyw3ju3/0XNJfmD5JY353iT3a8yadGAoBtXsXG
	 wJrQV3Z7g4WnCF2UBWdrAVAw9zVA0NHsoFEFo9J3Wb8eZPZE/Ta3HpcMvPBQ+/Emnt
	 HWPJmkHHbYv6WqD+9lyFv0HYrOHcAuH7E2sWbeVhrgSA+5wV/pXgfmB+XX3imroV5s
	 R/ela1+/L5R5A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 015/107] wifi: rtw89: check return value of ieee80211_probereq_get() for RNR
Date: Sun, 24 Nov 2024 08:28:35 -0500
Message-ID: <20241124133301.3341829-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 630d5d8f2bf6b340202b6bc2c05d794bbd8e4c1c ]

The return value of ieee80211_probereq_get() might be NULL, so check it
before using to avoid NULL pointer access.

Addresses-Coverity-ID: 1529805 ("Dereference null return value")

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20240919081216.28505-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d9b0e7ebe619a..f2b7348840a29 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6002,6 +6002,9 @@ static int rtw89_update_6ghz_rnr_chan(struct rtw89_dev *rtwdev,
 
 		skb = ieee80211_probereq_get(rtwdev->hw, rtwvif->mac_addr,
 					     NULL, 0, req->ie_len);
+		if (!skb)
+			return -ENOMEM;
+
 		skb_put_data(skb, ies->ies[NL80211_BAND_6GHZ], ies->len[NL80211_BAND_6GHZ]);
 		skb_put_data(skb, ies->common_ies, ies->common_ie_len);
 		hdr = (struct ieee80211_hdr *)skb->data;
-- 
2.43.0


