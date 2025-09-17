Return-Path: <linux-wireless+bounces-27426-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A27B7F68E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 15:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6436523D1C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB85128505E;
	Wed, 17 Sep 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="TeRqqu9F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B71E269D18
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088577; cv=none; b=PR6ZGqlvBaEoUt8hFXkITwSkIlW1Szf3esuom/P6WdkzRmf4Q89PPNBhdtmL4jmRcpwCiFCgIocKfeCbKfEX56Z3T1PWxfSuzpfBxuyv6m7lCe+Lmq5tfzP5AP/r9DbzAXiaWRQhG9jn6Mbl3TkOlgFaOH273/AjNgz9ONS4XFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088577; c=relaxed/simple;
	bh=MHyXVcdGDe+9FjRhgPthIWAPxUwyL4DDclX0vfhFPZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rTYzr7KqVc/ka6k2QDER7FOftdumNexi8VRkxJw9Yga3UvTaoJdMeKx6frVs6B10jaPud/pSa4bnYabT/iJPUFsBvcgJK5xXBMhyWkEdUAyXnXoFZBPR7l03zCgYQMJXng0Bik4JyEl+KctUyR+/Z14PvQ0fImyizFj9Nowvo6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=TeRqqu9F; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58H5u0rA53954262, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758088560; bh=danLb/DNV6TCqV4r7Mr+Eck4oncgqpKjIwz+pX6ohIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TeRqqu9Fb5qDTPE+F8vTD3iP5ig4BneTnQ9m3q/O9Qf1GPqUjQ320j9dS+xKGNHaK
	 pQs7VhAKvnVCCfEeuNNQWTWzFUUvVytl9K/oKt4sFMjOtphhWu1p/8fpYHWobfLk1k
	 mKAWH1srEt8LFhGxz8aoV7MqhGCZUr0t/Grs9qmrSoBES+dYp698xu1KomEuB4npew
	 SacejAvIcK9M8DURHL4R+oYj69hXUA/GsNtr3lhiRP/ZNJVNilO3HwfcQPKE2LtRJ1
	 q8tVkh00d8Fad08jGNkoCGUcDEjC0+xROx65r10jRZHBxGh59Gpz9Z0a/C1rtwSyIJ
	 7xBX5lQCXYOug==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58H5u0rA53954262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 13:56:00 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 17 Sep 2025 13:56:00 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Sep 2025 13:56:00 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v2 2/6] iw: info: extended features print EHT beacon rate
Date: Wed, 17 Sep 2025 13:55:39 +0800
Message-ID: <20250917055543.27499-3-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250917055543.27499-1-kevin_yang@realtek.com>
References: <20250917055543.27499-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Deal with BEACON_RATE_EHT in ext_feat_print.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/info.c b/info.c
index 18dcd368d0f8..5ce3f78688a0 100644
--- a/info.c
+++ b/info.c
@@ -174,6 +174,7 @@ static void ext_feat_print(enum nl80211_ext_feature_index idx)
 	ext_feat_case(OWE_OFFLOAD_AP, "OWE DH element handling offload (AP)");
 	ext_feat_case(DFS_CONCURRENT, "DFS channel use under concurrent DFS master");
 	ext_feat_case(SPP_AMSDU_SUPPORT, "SPP A-MSDU support");
+	ext_feat_case(BEACON_RATE_EHT, "EHT beacon rate support (AP/mesh)");
 	}
 }
 
-- 
2.39.0


