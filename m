Return-Path: <linux-wireless+bounces-7822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 390A08C919E
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 18:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B2F1C20B24
	for <lists+linux-wireless@lfdr.de>; Sat, 18 May 2024 16:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96B73A8C0;
	Sat, 18 May 2024 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Q/K+Jsct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailo.com (msg-4.mailo.com [213.182.54.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225FBD517;
	Sat, 18 May 2024 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.182.54.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716048460; cv=none; b=VG4KOjSDi0tnF/lHzsmrkZJZ48O9qLwoA8OBb+2HdbJEEl8a1ddwjSHyB49sfvMwGiF1GOA4/TH508GU7kgVVymnOw9JAg3WhFHGJuMrCSQKM/xgmyIFQZbLOozW0O55fmJn7M9U07a6qo9bw0VR1pISwJgzELfJApevLDWCka8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716048460; c=relaxed/simple;
	bh=y9WNVsgGMREzVKZ2bdsIouB8ybQanHZTXhyytqHhgto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=diInsRWO2mztQZ7sCSf3DYKqhHggtu7SgGsBriqSHtx+0Ho9AdKjgt2unCSLrLMByoz0qKAJHvs6YzH04w6F9HDqFYL+gLxfgCpkrSh9SAOfQrH7T4uX8t1TB46JJMWg3Aeent8AELcYhc2N4BTi0ZZqQPQan2f7ywZKh1MWCp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=triplefau.lt; dkim=pass (1024-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Q/K+Jsct; arc=none smtp.client-ip=213.182.54.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=triplefau.lt; s=mailo;
	t=1716048352; bh=y9WNVsgGMREzVKZ2bdsIouB8ybQanHZTXhyytqHhgto=;
	h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	b=Q/K+Jsctcj6IBBIrJ+91l1i9gn1tPtWAoEeSraj8RD0eUfnUMsDeELBrpmbKGinK/
	 18cLHG6kjEFm8P92GC6b00Drw6jVr70Y+NeN799K6PqWPSXsKPmop5w2OFekxit2OE
	 v+9fmReHyWdZvcnl+MqGYx9aQ3Y8FocC775eqdJs=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
	via ip-20.mailobj.net [213.182.54.20]
	Sat, 18 May 2024 18:05:52 +0200 (CEST)
X-EA-Auth: FHHgzVaT3dFz8PYIU2DJ5A4kdsuh94NZTxKzfmrEj5H6vMHxytpWwHZbOJ7G5cQqZSgEhc4mmPQ7OE8tc5l6EStTzyMOwWJA
From: Remi Pommarel <repk@triplefau.lt>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH] wifi: mac80211: Recalc offload when monitor stop
Date: Sat, 18 May 2024 18:07:33 +0200
Message-Id: <840baab454f83718e6e16fd836ac597d924e85b9.1716048326.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.40.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a monitor interface is started, ieee80211_recalc_offload() is
called and 802.11 encapsulation offloading support get disabled so
monitor interface could get native wifi frames directly. But when
this interface is stopped there is no need to keep the 802.11
encpasulation offloading off.

This call ieee80211_recalc_offload() when monitor interface is stopped
so 802.11 encapsulation offloading gets re-activated if possible.

Fixes: 6aea26ce5a4c ("mac80211: rework tx encapsulation offload API")
Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 net/mac80211/iface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index dc42902e2693..0c54554bf761 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -686,6 +686,7 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata, bool going_do
 			ieee80211_del_virtual_monitor(local);
 
 		ieee80211_recalc_idle(local);
+		ieee80211_recalc_offload(local);
 
 		if (!(sdata->u.mntr.flags & MONITOR_FLAG_ACTIVE))
 			break;
-- 
2.40.0




