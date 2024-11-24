Return-Path: <linux-wireless+bounces-15646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CB39D745E
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 16:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFEE285659
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Nov 2024 15:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A179D237B71;
	Sun, 24 Nov 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCj5NFAG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D2237B6B;
	Sun, 24 Nov 2024 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456409; cv=none; b=B++oj+gJEHjiahxpa5fmWTD8jbOPpBGhntomn4jwbB3wvoAZUtFmjVokeF5Cr6U9ucMRO7uSWNlGGqjqW1STt5hszzzPCARzWQ2NHnYRriKq11EaM3RKLnDysx0rysczDbeVQQR/8bIG3WfchaV9BNURSQqUhlCxxut3jueH4Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456409; c=relaxed/simple;
	bh=e0a/25+MmNItWmdk8EGb0vTjKRwEHoX7pg++9FJSlrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN7G8Wv3euL/SOTrjUPfzJ6ESJBahXq8Q35g4X91WJUATAqbrxs5Ry0QBJCBSVBILjtk3UyHIqysW++gGLxliXVhJPEqNoThAF7pyfxRRVDLvxFWnpyxAL3uuR7W9DEW4CqgjJzGrSaYSl8N4rdWrG07GbrvMmidc86iEIGhw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCj5NFAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2118AC4CECC;
	Sun, 24 Nov 2024 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456409;
	bh=e0a/25+MmNItWmdk8EGb0vTjKRwEHoX7pg++9FJSlrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCj5NFAGnqsb7Af31FpkJxu6NLP7PQ8sfejhdZPnnB3YlIzT8MOQY885uThF+PNXx
	 Knr7OAtURyBN1+/zildQ4LMe1D0ZSLuzNptQVYmGxklz0RRIdxgWsk/zsfCoszyo4j
	 cA7druTZ1LuB0ZQ+md9OgRTGRKkqz/hrRevHw7TLIO43aBs1H/XArFLdg0DhlQaPEC
	 HZYA2Dr/eGMLJFmmH3Fb6hK/zeZnlJAB0Wzh444Aj4uX0JR7lhCmTYEZmVyLSqbbkt
	 4ShOETCW0mj5R4ISb90Fa19NVABJsqugxceAgvTZGkz1dJ9TEAWuLl5HF6hX0d/fVs
	 zvbkgaFe2VQkQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	stas.yakovlev@gmail.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 30/36] wifi: ipw2x00: libipw_rx_any(): fix bad alignment
Date: Sun, 24 Nov 2024 08:51:44 -0500
Message-ID: <20241124135219.3349183-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124135219.3349183-1-sashal@kernel.org>
References: <20241124135219.3349183-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
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
index 7a684b76f39b7..ae9d026374953 100644
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


