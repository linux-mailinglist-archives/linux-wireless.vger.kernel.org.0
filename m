Return-Path: <linux-wireless+bounces-13871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC349993D5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 22:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF51C1C22E5A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 20:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413241E3773;
	Thu, 10 Oct 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="T9NZxnir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858FC1E1A1F
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592850; cv=none; b=BnfeU1u+XLYd3uzauvhxwmFxolJxeXyh1o7lGnePFdY4QgJ4EoNsHrCkqPAqzOv/YopkzL5hWYGTRYKZStcY/8j9tAhv8BZxxc+USnfdxfLRBxxjaOB6IlkNoXrgVH3cF6MeeTtPF9cuEK4FVKTsPFtsH0W31h243gAeH0Di+lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592850; c=relaxed/simple;
	bh=qVtjUSQ1xu/BPA2PBbE9BH+knZcLmyQ6Vef8HF7XOZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EylpucaYvo3UZeIWeL25d2V2UAyLuMzLV/04UEgtxFzwkAZSQbjTIAoefCZbeIjyWbZs1Ew6suORtI/nIyWLD5RvLtY5+yr1TA9JZfS/F6Iw6ED9ttjNG7VOSA98RLJqZeVlRFKUIjOZJe9s0dbSFwDElmfvMp/eGjKDtQEG2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=T9NZxnir; arc=none smtp.client-ip=148.163.129.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 674CBC40077
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:40:41 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id D86AE13C2B0;
	Thu, 10 Oct 2024 13:40:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D86AE13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728592841;
	bh=qVtjUSQ1xu/BPA2PBbE9BH+knZcLmyQ6Vef8HF7XOZA=;
	h=From:To:Cc:Subject:Date:From;
	b=T9NZxnira1ejDUaKwMjYKYl61jVNSZQWkutwt48UAWIN4Y7OBcpk+txWzDYrqT6+T
	 YswrQ7ywKbGDzjjpjsJ4shW18TcOcEOL3sj7zdGeCpuSg/0K46FCt6BeIXn3KHNQ8L
	 pA1J06rAgiLVskjRRj1aKYO/gBLIXASN72dGNyl4=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  Remove NOP call to ieee80211_hw_config
Date: Thu, 10 Oct 2024 13:40:36 -0700
Message-ID: <20241010204036.1219896-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728592842-LSo_LNB1bJm2
X-MDID-O:
 us5;ut7;1728592842;LSo_LNB1bJm2;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

If changed is '0', then the ieee80211_hw_config takes no
action, so just remove the call in
__ieee809211_recalc_txpower()

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/iface.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 566edad36b0a..88e9e19d34ea 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -70,7 +70,6 @@ bool __ieee80211_recalc_txpower(struct ieee80211_sub_if_data *sdata)
 
 	if (power != sdata->vif.bss_conf.txpower) {
 		sdata->vif.bss_conf.txpower = power;
-		ieee80211_hw_config(sdata->local, 0);
 		return true;
 	}
 
-- 
2.42.0


