Return-Path: <linux-wireless+bounces-13870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF629993CE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 22:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A5CFB23197
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2061D31BB;
	Thu, 10 Oct 2024 20:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="DaMRsB97"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F691DF997
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592813; cv=none; b=UC0tv+GZXVIICBLABg7nwUK8FNctbrJiuLOm8s4iwZj7ThvxgMcOPxGqJ4iirix1hjCqeFdYPkEzDpHmbzt+TZ86XQ9OtrFM2HbWlrLvpmX2h1bGPGfCkRljosmJFC7J9X9dbKWG/42Pb+ZpdHEzF40XBLp5Sr0XUiVzCQk0oFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592813; c=relaxed/simple;
	bh=4LA/2X89mHUF7VndfAFJ5/hu5c1l5QoUbncHSF2iHPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lVUQFT3O32KmoXROVJYKg6ZeLAAVP/H5mtjGv5dWYmy32N6PpOOY1NdZdqI2Nbix5z1i0ckCDyXdFi0mqF8PyRbDH4KWWDM9LI8HzAsXROOaFZxwTx7ydH7uSmxbBZSH5V9hAbYF9cHoUcXfMHtsaVyENzLk60QaU5+Hg9P6dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=DaMRsB97; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 48D29800080
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 20:40:04 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id B3DAF13C2B0;
	Thu, 10 Oct 2024 13:40:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B3DAF13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1728592803;
	bh=4LA/2X89mHUF7VndfAFJ5/hu5c1l5QoUbncHSF2iHPs=;
	h=From:To:Cc:Subject:Date:From;
	b=DaMRsB97/44j9cr9zM1IwTYbnBJm8cGTlaiKPYSV3NyRcF+yFJSUlorgd6tiMQT81
	 F62zr1rdC+qjIbyrbo8mlDXfBrhSkN1+moeWbAli7ypE5L9KsJFA19UO9C3IhnUZUu
	 URyPJ2sdwpRrBy6cgnfsoRjohng5spYC/8sj9Q+M=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mac80211:  fix user-power when emulating chanctx
Date: Thu, 10 Oct 2024 13:39:54 -0700
Message-ID: <20241010203954.1219686-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1728592805-kYajqE64HJAk
X-MDID-O:
 us5;at1;1728592805;kYajqE64HJAk;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Ben Greear <greearb@candelatech.com>

ieee80211_calc_hw_conf_chan was ignoring the configured
user_txpower.  If it is set, use it to potentially decrease
txpower as requested.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index bac640310d86..ca20d08a9d21 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -167,6 +167,8 @@ static u32 ieee80211_calc_hw_conf_chan(struct ieee80211_local *local,
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.42.0


