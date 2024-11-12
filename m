Return-Path: <linux-wireless+bounces-15218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5015A9C64F1
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 00:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1393B293D5
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2024 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC657219E58;
	Tue, 12 Nov 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="IgMVOqtu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A2215018
	for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2024 21:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731446080; cv=none; b=nzjBAMU0gSKZg+4bBpADszqJtt85EKerPYQ5P9sRuYVLmfPNuQd/dognDxQuBEGp6TVBuLbmV5zzXk0Tu9NVn1wqzRaaCHtQodBq7MNIlwG8dUErW4N83Erqsaa/t3IwrrXcyf5G/PdF1pBxdomtaXnfFfVniXAnD2wnHY7+4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731446080; c=relaxed/simple;
	bh=nSGox+NJkLEWmTkTIaTsk+J6QSaUMvzD0mCcBoJ9v8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dK+EjtK7Rhs6pDJXitSINRwNyhRKT3LfmU8/1LKvxuGM4hNgMTSY/Ki8Aa3ZT/hqfco2eCd1F2K5gccsjw0pZHHStfOI6ZWM+d6SycKX5IbwzkxamtFbciXeLfCqWI2q6uNvCcm3Re42HRnpKYxOzTf5GWwSLLCBbT6zUo1/ezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=IgMVOqtu; arc=none smtp.client-ip=67.231.154.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C0F333C0073;
	Tue, 12 Nov 2024 21:14:29 +0000 (UTC)
Received: from popkern.candelatech.com (unknown [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 4468C13C2B0;
	Tue, 12 Nov 2024 13:14:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4468C13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1731446069;
	bh=nSGox+NJkLEWmTkTIaTsk+J6QSaUMvzD0mCcBoJ9v8A=;
	h=From:To:Cc:Subject:Date:From;
	b=IgMVOqtu0hiWfSNp0l7MqP4OnhaD9TbUUu/D12nx3NuQEYKdohZqd6t2iYSCxFe60
	 GGTHiHrAogsbOq7BB1LlRaA7i6u6WtD2mouNtllYy2eJQrwER4E5quE7SzHY56dOld
	 xmRLBMotXKEPtdr+uQiOfELqvllaizGBdDpetus8=
From: Dylan Eskew <dylan.eskew@candelatech.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH] wifi: ethtool: add monitor channel reporting
Date: Tue, 12 Nov 2024 13:14:22 -0800
Message-ID: <20241112211422.331928-1-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1731446070-EsSIcNaq-t87
X-MDID-O:
 us5;at1;1731446070;EsSIcNaq-t87;<dylan.eskew@candelatech.com>;b42792dba290a1257c3f0aaf1c60b0ff
X-PPE-TRUSTED: V=1;DIR=OUT;

When running ethtool on a monitor interface, the channel
wasn't reporting properly. This adds logic to properly report
the channel for monitor interfaces in ethtool.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
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


