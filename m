Return-Path: <linux-wireless+bounces-15654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 295239D74F0
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C09285532
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9803244836;
	Sun, 24 Nov 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTLCv/1X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF751E9070;
	Sun, 24 Nov 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456597; cv=none; b=FfncNKuGdGiOMnugmwx6qS0YGx30s7bHZiclnMIs4K4+mvccEyWbTVxX2oNrG4VMVZ89KObIUH4DUuAKpOxu1aeOnn4EksVGPZh+tUEZ6E2jU7CB2iSnm9jNiN5BjuXXYO2+YFB2BCbEukwgcaeFWPn+qnwQv32x/i/7kkLj/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456597; c=relaxed/simple;
	bh=mvKsl6kh+IY8VgqZbeT+UYNZmF+x8DYraU3ldEM8hhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AecYGTwwYko+OWLuiTB2CSe+DXXxciqXh48qTX1EA9G/FIpCNXzckgOwBdXePs2Aa681BVynqVAkXmQ7O5sc/Xvi2qVwrZbZ9MYe2bTMnmZiAfGA8rXn9xW4UeR/yVT5bPKEGThYAbHhhTEDWQDNftjc3wY/PGxkXkERU7xX+wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTLCv/1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9319C4CED3;
	Sun, 24 Nov 2024 13:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456597;
	bh=mvKsl6kh+IY8VgqZbeT+UYNZmF+x8DYraU3ldEM8hhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JTLCv/1XNajR0HtcKnORGwySfCggq6QpyegycjVM4XWXljWMnY3AAPaH9Nt6aWKIq
	 Y82/Gc/a5qID8459tmhnVKxAR1J7PhGeho4fMkFXMilTsOJeNwKqq+WRVEofb/1ZjW
	 3j/Hy4nfkblLOpxnVZlK8kOnrhEv9UmoADweMdezXA7LH0uFean79Mfx4T8tpAtAo1
	 iSLbpbsrevPm0SZf64MeG19GGD0iLEpIKIpsy4fRmfKoNMZDhr5hVDwib0rr5a6bgz
	 1V+bInUjiix74gt2x59LB92ozp8O7silgcnSxFOl/3DeJ5wTmiEr2fP/v0yzzKuGnI
	 8TXEfFxzxGbqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	stas.yakovlev@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 22/28] wifi: ipw2x00: libipw_rx_any(): fix bad alignment
Date: Sun, 24 Nov 2024 08:55:22 -0500
Message-ID: <20241124135549.3350700-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135549.3350700-1-sashal@kernel.org>
References: <20241124135549.3350700-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit 4fa4f049dc0d9741b16c96bcbf0108c85368a2b9 ]

This patch fixes incorrect code alignment.

./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:871:2-3: code aligned with following code on line 882.
./drivers/net/wireless/intel/ipw2x00/libipw_rx.c:886:2-3: code aligned with following code on line 900.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11381
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://patch.msgid.link/20241101060725.54640-1-jiapeng.chong@linux.alibaba.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/ipw2x00/libipw_rx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 34cfd81628559..36831f4a2ea5e 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -870,8 +870,8 @@ void libipw_rx_any(struct libipw_device *ieee,
 	switch (ieee->iw_mode) {
 	case IW_MODE_ADHOC:
 		/* our BSS and not from/to DS */
-		if (ether_addr_equal(hdr->addr3, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == 0) {
+		if (ether_addr_equal(hdr->addr3, ieee->bssid) &&
+		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == 0)) {
 			/* promisc: get all */
 			if (ieee->dev->flags & IFF_PROMISC)
 				is_packet_for_us = 1;
@@ -885,8 +885,8 @@ void libipw_rx_any(struct libipw_device *ieee,
 		break;
 	case IW_MODE_INFRA:
 		/* our BSS (== from our AP) and from DS */
-		if (ether_addr_equal(hdr->addr2, ieee->bssid))
-		if ((fc & (IEEE80211_FCTL_TODS+IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS) {
+		if (ether_addr_equal(hdr->addr2, ieee->bssid) &&
+		    ((fc & (IEEE80211_FCTL_TODS + IEEE80211_FCTL_FROMDS)) == IEEE80211_FCTL_FROMDS)) {
 			/* promisc: get all */
 			if (ieee->dev->flags & IFF_PROMISC)
 				is_packet_for_us = 1;
-- 
2.43.0


