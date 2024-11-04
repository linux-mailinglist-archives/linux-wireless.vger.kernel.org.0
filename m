Return-Path: <linux-wireless+bounces-14871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BBA9BB24C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DE76281CB6
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Nov 2024 11:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDDA1E1A18;
	Mon,  4 Nov 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f86zL+EH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6A1E1027;
	Mon,  4 Nov 2024 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717672; cv=none; b=tNsAqYWICE06n5q3gpDtmMQRKCuk4t+UFv6VW6quCKys9mssKSl6iwh47eHFmQ6GV+N2n0mLncl4CDL5TivLCNvRPlbgN1ZrZuWVliPZSHeauctdi4eMI+Z+WmcHvHxOAb2nGE7G6YrTrXhu0FKvzrQtirUijClPhZVQjjY/OQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717672; c=relaxed/simple;
	bh=IIw5YdDJ+qxZU7JKJPTnP36GO7gm14PlOZ1qDp0E0a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKGKf1Bk3TAmaYuDHxyCzT7FgUjw2jQguo3XfKM83GaiajVGT4XXsShs2d1R7X0WN8uLYFyP3B2dHxrbUYus/ajG+uQjU3cMraJz17xZ44y7FAHAuUBy2WKwD5+kvaoyQ4k+FaqUJh4lYyqCFqzUpOiwQiTBhAG8Hw8A1qB6/XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f86zL+EH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1F2C4CED5;
	Mon,  4 Nov 2024 10:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730717672;
	bh=IIw5YdDJ+qxZU7JKJPTnP36GO7gm14PlOZ1qDp0E0a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f86zL+EHleGeYTkZ/qy44hM4YB5KdrXErni/69z2EHZ6clSlR04CQrVLGnMJ+aTo7
	 AQ1ZHVcirPJ4IK8JZ3hyiCkCtYT2WXsPtC2rpBCw12dKyF171VBSfVu9bWuPtpRzaB
	 xHsJvGU4/SrYOdm1O61cWIdV7QydbFBEgOgVSP5sFf90YMHl0gcF7DADXA5meuFoaZ
	 wkHFleqL9IGufdBzYLykTXFp9W75Cj2gRKuP1CL2Cr254jBIxGNEkJToLgD0QvI7/9
	 gncA49efjPQitNp0xGR2Piv8XC8BP8jxSGpRJwIfmlWtAranjCWra2g2s3pTPc68h9
	 nediPaqICW0qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/10] mac80211: fix user-power when emulating chanctx
Date: Mon,  4 Nov 2024 05:53:54 -0500
Message-ID: <20241104105414.97666-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241104105414.97666-1-sashal@kernel.org>
References: <20241104105414.97666-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.170
Content-Transfer-Encoding: 8bit

From: Ben Greear <greearb@candelatech.com>

[ Upstream commit 9b15c6cf8d2e82c8427cd06f535d8de93b5b995c ]

ieee80211_calc_hw_conf_chan was ignoring the configured
user_txpower.  If it is set, use it to potentially decrease
txpower as requested.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Link: https://patch.msgid.link/20241010203954.1219686-1-greearb@candelatech.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 1c2cdaeb353b0..6253a89411cbe 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -144,6 +144,8 @@ static u32 ieee80211_hw_conf_chan(struct ieee80211_local *local)
 	}
 
 	power = ieee80211_chandef_max_power(&chandef);
+	if (local->user_power_level != IEEE80211_UNSET_POWER_LEVEL)
+		power = min(local->user_power_level, power);
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(sdata, &local->interfaces, list) {
-- 
2.43.0


