Return-Path: <linux-wireless+bounces-4570-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 234188785D4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 17:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83E11F21AD5
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 16:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B078487BF;
	Mon, 11 Mar 2024 16:55:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from tretyak2.mcst.ru (tretyak2.mcst.ru [212.5.119.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A05026D;
	Mon, 11 Mar 2024 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.5.119.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710176150; cv=none; b=rF48Lojjzs7Z8BBMBft+EyjxwpeBfxPacnKHJkOtrdrBRvJuFejNEw1fy7AZwkyW9jOiij01Ucw+J4BQE+frowOJYsd3RQtZalR17Q++BqjPXyfA7j8YlLiR6lsz5k2J+xPSqEAFQ78MIclqlkGlC33XEnuV8RGeFKq0j5WDGPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710176150; c=relaxed/simple;
	bh=kdzWBX3LAegiWKoliuOc67TGbPzxENLVqK5kivBeZ8A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OHz0osBoMyRlRtKYT1lsFdCo3L2ycjFQHs8yQRdr1ttpUNsiPqGX1GV8N8GMU6Vlo+/LjWMy8ZZzMmgzhtKlwVzAOUGqAvRx1IWkXzBRh4+rkuETCf/tcUbJXF6yqsOtw5kIaFfbnQUf7iuiGFSFRzW8DTScEJQARmJg06G6dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru; spf=pass smtp.mailfrom=mcst.ru; arc=none smtp.client-ip=212.5.119.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mcst.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mcst.ru
Received: from tretyak2.mcst.ru (localhost [127.0.0.1])
	by tretyak2.mcst.ru (Postfix) with ESMTP id 08035102398;
	Mon, 11 Mar 2024 19:48:48 +0300 (MSK)
Received: from frog.lab.sun.mcst.ru (frog.lab.sun.mcst.ru [176.16.4.50])
	by tretyak2.mcst.ru (Postfix) with ESMTP id E9BF910239A;
	Mon, 11 Mar 2024 19:48:02 +0300 (MSK)
Received: from artemiev-i.lab.sun.mcst.ru (avior-1 [192.168.63.223])
	by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id 42BGm2ma020437;
	Mon, 11 Mar 2024 19:48:02 +0300
From: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: [lvc-project] [PATCH] wifi: cfg80211: fix rdev_dump_mpp() arguments order
Date: Mon, 11 Mar 2024 19:45:19 +0300
Message-Id: <20240311164519.118398-1-Igor.A.Artemiev@mcst.ru>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Anti-Virus: Kaspersky Anti-Virus for Linux Mail Server 5.6.39/RELEASE,
	 bases: 20111107 #2745587, check: 20240311 notchecked
X-AV-Checked: ClamAV using ClamSMTP

Fix the order of arguments in the TP_ARGS macro 
for the rdev_dump_mpp tracepoint event.

Found by Linux Verification Center (linuxtesting.org).

Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
---
 net/wireless/trace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index 1f374c8a17a5..cc3fd4177bce 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -1013,7 +1013,7 @@ TRACE_EVENT(rdev_get_mpp,
 TRACE_EVENT(rdev_dump_mpp,
 	TP_PROTO(struct wiphy *wiphy, struct net_device *netdev, int _idx,
 		 u8 *dst, u8 *mpp),
-	TP_ARGS(wiphy, netdev, _idx, mpp, dst),
+	TP_ARGS(wiphy, netdev, _idx, dst, mpp),
 	TP_STRUCT__entry(
 		WIPHY_ENTRY
 		NETDEV_ENTRY
-- 
2.39.2


