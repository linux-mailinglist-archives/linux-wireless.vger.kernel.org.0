Return-Path: <linux-wireless+bounces-15271-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44B649C7670
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 16:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E8B5B24737
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 14:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317FF171D2;
	Wed, 13 Nov 2024 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="j4t1B0Hq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C323A0
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 14:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509184; cv=none; b=Bw9MlMGKL3lq1KbhvtceNPiBgelp9MhymEdUfW/N+5+yzl+3VqpJxAlH8XlPrDZZ/ZW4L3HfHeLdqeC2qsI7HIkIkbPiQDFxq6w8SNpmeb199N7Q1iRTlXfp4uapiJ4gTRPQPJW81//JMary5mW/njKCFDOO5NMfOfvptSq3D2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509184; c=relaxed/simple;
	bh=YOOeOU5u/ImgeuEd5d/cNlmDesmusnbb1den4oeFrN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpTlneXTrpPtuEaYsSRpUcpB2SrId0qGJWZeGciWML6qDUOcw9/OlgmfKQ6YCbXZLLNJzqcVx4rPFyB21v5Eex5N5Max4DKKNMUiK+jxIBzgeF8nrk7obyNdykAZ/GCLfyE0c/eYReg9cdebr8MMv3gTUzFuF2GZ8sZZ/5gbXOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=j4t1B0Hq; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id D5B5DB80089;
	Wed, 13 Nov 2024 14:46:19 +0000 (UTC)
Received: from popkern.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 1711113C2B0;
	Wed, 13 Nov 2024 06:46:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1711113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731509179;
	bh=YOOeOU5u/ImgeuEd5d/cNlmDesmusnbb1den4oeFrN8=;
	h=From:To:Cc:Subject:Date:From;
	b=j4t1B0Hqn2ZTNfz92eYGChGneT99roIcMEB3+8783/H7Ad2Oy8tbrU/MZUlpc3Phu
	 XYrCZ+kgVmHP7WvHs22TquleUKT41uqTFYkS4K9SMUoUM+3uPI7oCKXfEV+3L34bJp
	 A0VfyPJVxPdufR9C319ewuERCQhNLOFPeBJN4HX0=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH v2] wifi: mac80211: ethtool: add monitor channel reporting
Date: Wed, 13 Nov 2024 06:46:08 -0800
Message-ID: <20241113144608.334060-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1731509180-oqEDyb-wgHzL
X-MDID-O:
 us5;at1;1731509180;oqEDyb-wgHzL;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

When running ethtool on a monitor interface, the channel
wasn't reporting properly. This adds logic to properly report
the channel for monitor interfaces in ethtool.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
v2:
  - Better commit header
---
 net/mac80211/ethtool.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 99f6174a9d69..d36f4e22230b 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -160,6 +160,10 @@ static void ieee80211_get_stats(struct net_device *dev,
 	chanctx_conf = rcu_dereference(sdata->vif.bss_conf.chanctx_conf);
 	if (chanctx_conf)
 		channel = chanctx_conf->def.chan;
+	else if (local->open_count > 0 &&
+		 local->open_count == local->monitors &&
+		 sdata->vif.type == NL80211_IFTYPE_MONITOR)
+		channel = local->monitor_chanreq.oper.chan;
 	else
 		channel = NULL;
 	rcu_read_unlock();
-- 
2.47.0


