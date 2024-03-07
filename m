Return-Path: <linux-wireless+bounces-4465-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08355875607
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 19:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845A8B244D4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Mar 2024 18:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5465A133401;
	Thu,  7 Mar 2024 18:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="f7F40tMU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8531332AA
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835644; cv=none; b=LbJHwCyoFj66x+0WXc9MPQvPLxT550Mthy64p6h6SBBsJAjnwSpQmNQ2zQkRQovXlN9OgL7EzaBKqK8K7GLMLmYOOOnXutdvoqVorb0mHyJGyLneWfPKvfkqFJiMUGVpDuRYuQmBNaE+0wPxTEgFNG6p4GasV1A6Zpft9aSd0RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835644; c=relaxed/simple;
	bh=MJuHjlaNQXzJRjRj5UnHiXpaMdeh+7eUfRSf5q5UY3E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IhINlKeedbHYN3gAPoqersM39AyLahm08yeOlqoGvfeX/ABJpu3v1MkeG43gd5aTtEbvKMxicNgWAHe7YCMgSypIHKqcqHY/lal0GHR8k7EoXmVrZFdfKTgguMjN9Cullz6DI27Egqio9MKo8mwvxd2s3tlgQbDuIRN04f4AWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=f7F40tMU; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Received: from dispatch1-us1.ppe-hosted.com (ip6-localhost [127.0.0.1])
	by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5D1142C0122
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 18:20:35 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 407B11C006D
	for <linux-wireless@vger.kernel.org>; Thu,  7 Mar 2024 18:20:28 +0000 (UTC)
Received: from ben-dt5.candelatech.com (unknown [50.251.239.81])
	by mail3.candelatech.com (Postfix) with ESMTP id D31B913C2B0;
	Thu,  7 Mar 2024 10:20:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com D31B913C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1709835627;
	bh=MJuHjlaNQXzJRjRj5UnHiXpaMdeh+7eUfRSf5q5UY3E=;
	h=From:To:Cc:Subject:Date:From;
	b=f7F40tMUcYj4mydSjDBK4uokrWtKe1CXpZjhsEfVSTpAOnOZUkE7OuT4HCtPzS22j
	 YF6IrrpTADoD+t58xYY4B2897dSJ8U4sU31fwMiAgWOpKzZoH/gx4tChGtqLqHrJFW
	 8sjba02ejpm+LjhcB7f9ZIKSju4Ij5O8OWx7MyiQ=
From: greearb@candelatech.com
To: linux-wireless@vger.kernel.org
Cc: Ben Greear <greearb@candelatech.com>
Subject: [PATCH] wifi: mac80211: Report bss-color in ethtool stats.
Date: Thu,  7 Mar 2024 10:20:24 -0800
Message-ID: <20240307182024.3224197-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1709835628-cvt9M1HvIbTy
X-MDID-O:
 us5;ut7;1709835628;cvt9M1HvIbTy;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45

From: Ben Greear <greearb@candelatech.com>

Provide efficient way to read current bss color.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 net/mac80211/ethtool.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/ethtool.c b/net/mac80211/ethtool.c
index 99f6174a9d69..6058834db228 100644
--- a/net/mac80211/ethtool.c
+++ b/net/mac80211/ethtool.c
@@ -51,7 +51,8 @@ static const char ieee80211_gstrings_sta_stats[][ETH_GSTRING_LEN] = {
 	"rx_duplicates", "rx_fragments", "rx_dropped",
 	"tx_packets", "tx_bytes",
 	"tx_filtered", "tx_retry_failed", "tx_retries",
-	"sta_state", "txrate", "rxrate", "signal",
+	"sta_state", "txrate", "rxrate", "signal", "bss_color",
+	/* Add new stats above here, channel and others go below */
 	"channel", "noise", "ch_time", "ch_time_busy",
 	"ch_time_ext_busy", "ch_time_rx", "ch_time_tx"
 };
@@ -151,6 +152,11 @@ static void ieee80211_get_stats(struct net_device *dev,
 		}
 	}
 
+	if (sdata->vif.bss_conf.he_bss_color.enabled)
+		data[i++] = sdata->vif.bss_conf.he_bss_color.color;
+	else
+		data[i++] = 0;
+
 do_survey:
 	i = STA_STATS_LEN - STA_STATS_SURVEY_LEN;
 	/* Get survey stats for current channel */
-- 
2.42.0


