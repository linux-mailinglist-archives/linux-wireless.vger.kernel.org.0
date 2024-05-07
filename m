Return-Path: <linux-wireless+bounces-7308-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7338D8BF0C6
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A53631C20888
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869BD8615A;
	Tue,  7 May 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+WmnFxl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A001137917;
	Tue,  7 May 2024 23:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122837; cv=none; b=nY5WfCcFRONZ/EaIGk5BKoZHq5KOiWaraNyYGvgX5Aqrsi9xPJIMURN8VJpt9P48oAWxs8A3sO814Mx7fHI3DaMvmUmCKLebl6kn/k7Ta/A0q24+BEol7mDYN2H7On22tAdHlxOZKQHKilv6OwlRL+RYf+TSRFIMAV+IKNaHpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122837; c=relaxed/simple;
	bh=LSY5NccFqzkIUuQj1G6csswl+1bdu2ZXPFrKDf7Yyzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PT2/0R1la9zZQnzYurlvPDgl8VFirX0G3Nzm8vpIOKjxAGwZBGHXa0VJEP8AavWTrmWy/TO3tAHd/cDegPZIcCJTWrCWYVfqXm8rLm5BPOyVefZ8XqE04y3hfczXn4nzjPGPCgl7ZruwXu8s0mXRe/JGKSb8D1CrEFzgmutVk28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+WmnFxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE965C4AF68;
	Tue,  7 May 2024 23:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122837;
	bh=LSY5NccFqzkIUuQj1G6csswl+1bdu2ZXPFrKDf7Yyzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C+WmnFxlK8UA/m/qg1UUumViDHhNSDYfUBs3qXtHyDP7xp9TjECl34hS4i5boTRCO
	 Xgqt2sXbh/hRbYwmkeZJ3AdgEJepIKWIwdzT9XNm9piNva/PdSWbwN9Rt2x51XDOmO
	 PLLrM0ktr3BOE7WOwAJYPUgJJYAr6R5bKeeKhJ4S/ZaNhR5oZKg/OrDHpRrC+ZzHJ8
	 MlTLkBRgYpOZCnbNE7lGRTx1EyH0h9vKRGDCfKV0J+sBHRp/6BBs76gn8JylQ0Q8xt
	 J3aEyXpNJJgYZZgMNXSdAg0DBL+G3CEGUDv5yTMqxceELZ8fd7x+9G9h8tnk7lTPa/
	 FAXr5d02GWSUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 03/12] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 19:00:05 -0400
Message-ID: <20240507230031.391436-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507230031.391436-1-sashal@kernel.org>
References: <20240507230031.391436-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.90
Content-Transfer-Encoding: 8bit

From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>

[ Upstream commit 9ef369973cd2c97cce3388d2c0c7e3c056656e8a ]

The declarations of the tx_rx_evt class and the rdev_set_antenna event
use the wrong order of arguments in the TP_ARGS macro.

Fix the order of arguments in the TP_ARGS macro.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Link: https://msgid.link/20240405152431.270267-1-Igor.A.Artemiev@mcst.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/trace.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index a405c3edbc47e..6480e8487f6b1 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1734,7 +1734,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1751,7 +1751,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


