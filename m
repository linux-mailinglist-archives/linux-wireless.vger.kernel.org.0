Return-Path: <linux-wireless+bounces-7309-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728918BF106
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 01:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A358E1C210B5
	for <lists+linux-wireless@lfdr.de>; Tue,  7 May 2024 23:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B738A127E3A;
	Tue,  7 May 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwbmTWPI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FC127E37;
	Tue,  7 May 2024 23:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122878; cv=none; b=OnEuoW2qkEgUBAFkspu7PPyQzwI9SX3cJp14VbuSgv9ZMmnm800BwVcbmPr3xFUInCBI4I4xL9ThPVpZpaYBIfz68DLi2bVyB4je5jcbqr8mihF70m/PcM0NSA/jPpx6+YDtV8ID/KYmDdA3yYWXLQ/Fap1+msc0WzTWpOnlDUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122878; c=relaxed/simple;
	bh=3/NFBpjT4jUczh7O4BPH1c1TUbI+ZoUJ+WDeiBqyrWk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nh50p6HzB3r15lZfaNcahKCES/oJ8Vp0G+y/CeOwmmsdIQ2cPCx6P3oYEKxEaLdz5GQnF/M+jG0McNAASGp9cv7677HF6buCS7VXqhHND2PBoH5lGafN9TeOjHUN/4XaV/ZwD9XGcrKkxaDopIfCOiq9yKcjdRN6GfvldhDQq7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwbmTWPI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF07C3277B;
	Tue,  7 May 2024 23:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122878;
	bh=3/NFBpjT4jUczh7O4BPH1c1TUbI+ZoUJ+WDeiBqyrWk=;
	h=From:To:Cc:Subject:Date:From;
	b=ZwbmTWPIK8kgjAsRoXpmpzR1XndH2+xqAoP6cIKpYgJTWQzwhJIWynfZZZHMhyf9j
	 NYhg2axiXuS0oOUWR/eICQ9oSbiwmo+sCgJaNNc9AozEJnQXd/2BAMfAkNmNwvtuNV
	 yc5SkGJiZGtq597xOHAJDWJXcXid7pqejicp9MxdMQ0ohK6+5lqqE+F3WzaDzG9gjH
	 p7zz17uxft+MUaXeWYzLGdWgDTGZkSpbWxvsrZeXOvP3vDd9gW08qdylHtngiaRO1z
	 ZfT5v9nTDckSnLsA8e6la3Vu7vPuoQjA01QqE2DPIARRolnUwiyKt8hTi0+2jZn+HV
	 umZhFUC4r1+kg==
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
Subject: [PATCH AUTOSEL 5.15 1/5] wifi: cfg80211: fix the order of arguments for trace events of the tx_rx_evt class
Date: Tue,  7 May 2024 19:01:05 -0400
Message-ID: <20240507230115.391725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.158
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
index 19b78d4722834..dfd36cba14bc6 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1687,7 +1687,7 @@ TRACE_EVENT(rdev_return_void_tx_rx,
 
 DECLARE_EVENT_CLASS(tx_rx_evt,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx),
+	TP_ARGS(wiphy, tx, rx),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		__field(u32, tx)
@@ -1704,7 +1704,7 @@ DECLARE_EVENT_CLASS(tx_rx_evt,
 
 DEFINE_EVENT(tx_rx_evt, rdev_set_antenna,
 	TP_PROTO(struct wiphy *wiphy, u32 tx, u32 rx),
-	TP_ARGS(wiphy, rx, tx)
+	TP_ARGS(wiphy, tx, rx)
 );
 
 DECLARE_EVENT_CLASS(wiphy_netdev_id_evt,
-- 
2.43.0


