Return-Path: <linux-wireless+bounces-18417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A8A271DC
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 13:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9091882588
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 12:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453D1A29A;
	Tue,  4 Feb 2025 12:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="in8ZqpJp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39AA20D506
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738672301; cv=none; b=kBryPZiu2pYNbpmt8FOBqXmX8BGWUpjsUu7cKZEIWXjtzB3uV/hn+dyAGkI3+Zr4PGz08+QYqYunHkrgQDTFFDISTAyomWIkCqI4C4hWbNMsIr/Xq9B330opwA9zPd9PThqJE3Ts8cVqYPk2wB2z6fEW0fCegp+JfbIedWC6cI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738672301; c=relaxed/simple;
	bh=pX2OqxqExFZegWrhn0bRG+Ob6CZG4W9CU452+wtm+5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyxiZsJpvXIPbxWFFayzbdI/Enu/1DMGUC6ISBASCNxgIn1PlStiJv0Fv4kdxdFWWh2eXN0EF7M2X3WAuWuc5e/CI5Sl5A15ym5mtB5h5WLE1ScnePegxDkJ0JIhLmlkgRPwnlb9AmC0HlCENW5X1/FPTZlgvBGCkFWvwklWxIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=in8ZqpJp; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
From: Alexander Wetzel <Alexander@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1738672297;
	bh=pX2OqxqExFZegWrhn0bRG+Ob6CZG4W9CU452+wtm+5E=;
	h=From:To:Cc:Subject:Date;
	b=in8ZqpJpXrk7dXSZKSm/0CdWbUvKZqCOmKrxhrxeppY8IYqYYIQuPUVmSKI32zkej
	 ODkOoeF/03LYNswa9tMygyRl0tKxmh8NYHyYewVaFxxE5IGVi+oEvZcD8TMCPisXlX
	 DkIhAT/qXVhfL6BoUqhNLjMkc9N5QdwrbjqpCeu4=
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Alexander Wetzel <Alexander@wetzel-home.de>
Subject: [PATCH] wifi: mac80211: Cleanup sta TXQs on flush
Date: Tue,  4 Feb 2025 13:31:29 +0100
Message-ID: <20250204123129.9162-1-Alexander@wetzel-home.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the sta TXQs on flush when the drivers is not supporting
flush.

ieee80211_set_disassoc() tries to clean up everything for the sta.
But it ignored queued frames in the sta TX queues when the driver
isn't supporting the flush driver ops.

Signed-off-by: Alexander Wetzel <Alexander@wetzel-home.de>
---
 net/mac80211/util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index f6b631faf4f7..7f02bd5891eb 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -687,7 +687,7 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 			      struct ieee80211_sub_if_data *sdata,
 			      unsigned int queues, bool drop)
 {
-	if (!local->ops->flush)
+	if (!local->ops->flush && !drop)
 		return;
 
 	/*
@@ -714,7 +714,8 @@ void __ieee80211_flush_queues(struct ieee80211_local *local,
 		}
 	}
 
-	drv_flush(local, sdata, queues, drop);
+	if (local->ops->flush)
+		drv_flush(local, sdata, queues, drop);
 
 	ieee80211_wake_queues_by_reason(&local->hw, queues,
 					IEEE80211_QUEUE_STOP_REASON_FLUSH,
-- 
2.48.1


