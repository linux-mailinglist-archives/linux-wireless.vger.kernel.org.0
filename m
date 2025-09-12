Return-Path: <linux-wireless+bounces-27264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EDBB5486F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 11:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876ED1793B4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Sep 2025 09:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DC2288CA6;
	Fri, 12 Sep 2025 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JKkJJz1j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5124B28541A
	for <linux-wireless@vger.kernel.org>; Fri, 12 Sep 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757670888; cv=none; b=CqeL/jBn/K0xG0eghiCd+oBarYLhEC+ZUS4JAxC2voQw/z+/96VvM3EDBAZjVFWwJDmjAenPUsnwsc83rkk1/jin6vXhp6iB6zPS69VAZFnV7xnjw4jjjxZRiyFotVgvOfpwxOjxsV4Zr4HSmerDmsBfC1l1+e3k8HWrvr+uZcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757670888; c=relaxed/simple;
	bh=MHyXVcdGDe+9FjRhgPthIWAPxUwyL4DDclX0vfhFPZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3/JIxwz0euAAfD4Q8WHS2YaCPwi80K5FsIg23V1fID2f5mIuPTJpbuU0+N7d0cwEveSoAyWkpk1dmqTqvQBeHTnugnsARtIemdsI1wwr/Lrwqp58vyC6w1t+crl6qQ9E4ZieZ4Kb8RFw+DU8Zq6+S/0oCKqKhQV9cfzWSA1ovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JKkJJz1j; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58C9sYBj9495137, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757670874; bh=danLb/DNV6TCqV4r7Mr+Eck4oncgqpKjIwz+pX6ohIU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JKkJJz1j7+A21RuJLZBszCCN+4d+RvrfTpOKxInRBAnEi44WKzdqPfy83ZyEgdEyt
	 maKsBLDzWtZ/Vs3tAP5w9aAPT+ucM5/Kic24CehBsI+P1dZAZPewkwhcVxKuV0Dclw
	 L/lL4tOLd+wGYdGQLsXilu3nPjEO5HJdzspgGExzdVtQEeZhA3rK1MWDt3KbUQuFeL
	 91PIDXLsF73cOfLlGpiIvWAfQJUmf09+Q4UADGzPOibhOL14eGEQhJgQQS9gOUuYXP
	 iTVEe9ltsjubAv5IEBcCd5vh+YEFzhGZVuzUb1s4dxrit9lJZaMLTJQATdj1LfNyFp
	 L9DAHcTgFAv8g==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58C9sYBj9495137
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 17:54:34 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Sep 2025 17:54:35 +0800
Received: from localhost.localhost (172.21.69.104) by RTEXMBS03.realtek.com.tw
 (172.21.6.96) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Sep
 2025 17:54:34 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/5] iw: info: extended features print EHT beacon rate
Date: Fri, 12 Sep 2025 17:54:20 +0800
Message-ID: <20250912095423.27266-3-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250912095423.27266-1-kevin_yang@realtek.com>
References: <20250912095423.27266-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
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


