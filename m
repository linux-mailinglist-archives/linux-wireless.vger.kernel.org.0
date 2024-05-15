Return-Path: <linux-wireless+bounces-7675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B858C61DD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832D51C20E3D
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33502446AD;
	Wed, 15 May 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="HmRwmVG+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEED4AEE6
	for <linux-wireless@vger.kernel.org>; Wed, 15 May 2024 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758751; cv=none; b=Ll/mXi34LpPitJ4ptBe4Irf1LBHFJ+vcTqTiEBYcNLghM85VD6QHtmiXEIdYMDKK/25Tbmmn0HM/KMiA4/YzRork8ARE8tIE+/7BjwOy9fchTl4Ur/0wbv6yynctsoSHW4JKAdY/saNVNNpMw5u3CSDX3hWIyFHI4fOp6ZDJmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758751; c=relaxed/simple;
	bh=3kB58TH+CRag5VRZd3tL/Uq3yGdiuPY8+eq1h2AEnv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fjrjS//Tvg1WL7+SrmS3UbPJEPCxk5XEZV7h0tGEQrHlV3PKgxByXgVYXjwnuAnwzluDG70wC+LPV0OZD30fToL+54j484f51y83z1QY0SDpmWmsiHpDlOVal9ey8Tcu3zI4oLHq02gAB8iFSz6rScYAapsxL5E2IUaX4YdxFF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=HmRwmVG+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0TOf7Vh6B3BmD9PiFVyghzkWKOi3+YlIq0tJzanJp2k=;
	t=1715758749; x=1716968349; b=HmRwmVG+SenO4/qc2Yk2s8bRJWdrCowHReZdgn1E6RyDB31
	vMgzTakGf+U0ZQPJI8IcO+Psdvurg60N5RB8OcE9fDHkcrXUnZ6Yo0GpsbVoxl9agPSqoyqYSYAdj
	P3F3D1Ml0ix95/BuRn8XALpq3Dg9XxhbUMVg4xBgmFz9UQ8S8Vw9A++ekIYKdwJ983pKYs7YvFU33
	Jqn4XxxNO44fURJ7ffUm7y8ysoZSQ7GSomevPcxJEeguJHXkYWTMXqCcidutIz8R8EIDReg1nvvcQ
	xdKRhWNdXCSaJQNYD1pHtX1tIRRT7Ces/mmQ3GOMtmIt8UNrhKOjgpc8bNcMXmWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s79EB-000000063rL-09xt;
	Wed, 15 May 2024 09:39:07 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6/6] wifi: ieee80211: document two FTM related functions
Date: Wed, 15 May 2024 09:38:40 +0200
Message-ID: <20240515093852.229aa69e972c.Ifae6762a698e79cd5a49a055fe4c32330e826200@changeid>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240515073852.11273-8-johannes@sipsolutions.net>
References: <20240515073852.11273-8-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Add some documentation to ieee80211_is_timing_measurement()
and ieee80211_is_ftm().

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index 595f83783f0e..fb50a99daa93 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4731,6 +4731,11 @@ static inline bool ieee80211_action_contains_tpc(struct sk_buff *skb)
 	return true;
 }
 
+/**
+ * ieee80211_is_timing_measurement - check if frame is timing measurement response
+ * @skb: the SKB to check
+ * Return: whether or not the frame is a valid timing measurement response
+ */
 static inline bool ieee80211_is_timing_measurement(struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
@@ -4750,6 +4755,11 @@ static inline bool ieee80211_is_timing_measurement(struct sk_buff *skb)
 	return false;
 }
 
+/**
+ * ieee80211_is_ftm - check if frame is FTM response
+ * @skb: the SKB to check
+ * Return: whether or not the frame is a valid FTM response action frame
+ */
 static inline bool ieee80211_is_ftm(struct sk_buff *skb)
 {
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
-- 
2.45.0


