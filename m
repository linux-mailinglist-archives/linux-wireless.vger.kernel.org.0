Return-Path: <linux-wireless+bounces-7310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 242648BF119
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE17A282080
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9AC13C3DF;
	Tue,  7 May 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM97zXxR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C67B80BF5;
	Tue,  7 May 2024 23:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122897; cv=none; b=LVtm+G/ZHFlAVN/67O6Kd5qXJFU3rQmX2BA0D+wuB4MZ/C56diVJbk8jNQYKz/htmnmBNRRWn6Ub6U5nvjiObTTQefTkUrn/D3NZmoL7xLskUBGZjvTGT1V2h2JmmSKvrnRaESLXSdTzvq4iw375F8221a0pjYQGj4gLWBDal1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122897; c=relaxed/simple;
	bh=4bgUwdSaScCb+SsbbOjHt9j9MR+mObnTLbnNpdPCJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=laU3IaKLKBl12aOpLgcwrW+Kk8IEh0k+XHZotugJj/BZ/lJpJWsFDE6JX+upa1aqc2o90keKK/me2nV26j68k3905NCxndxbuMeY5yEdpvB01QUXJnpdkDStiO6azWIbqbmipq6FeFbxxg57cVhXmKS5aXqjqxn4bAR3k9CwiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM97zXxR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4ECBC2BBFC;
	Tue,  7 May 2024 23:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122896;
	bh=4bgUwdSaScCb+SsbbOjHt9j9MR+mObnTLbnNpdPCJdo=;
	h=From:To:Cc:Subject:Date:From;
	b=nM97zXxRC3DmTHs4r2GHAjVDhZKfoGCBuzZNHHN0QmTeHEdTBl+xRw0ifwINugXhn
	 JvihNIISiHtrLxyQESueopFFP391e/5+zjYv5zecRc68zi/zdibi9hfwUjgRjGkfj3
	 RSmDcxZV5GAQ+Jazq0M4Ih4ipWhZLrJDfyxXQNMbmfuF1X5ZqBQcr2nmpHQ53Iyjcd
	 zTRyf6HZX717RQtGbhuf4nVpoyKo6v6mJDM5O1KCkc72a1BaV9LsiK3v57GTlhxaVS
	 qPZbAb3rVuAtf061plVIazEUA1+dbXupQoe9E4afaED55ksyTVAbYXjZL9xBVGIomQ
	 yT7HiyMaINcqw==
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
Subject: [PATCH AUTOSEL 5.10 1/3] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 19:01:28 -0400
Message-ID: <20240507230134.391850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.216
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
index 6e218a0acd4e3..9bd6a6ef5ee47 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1660,7 +1660,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1677,7 +1677,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


