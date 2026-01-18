Return-Path: <linux-wireless+bounces-30937-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE5D394AD
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 13:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C604A30034A5
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Jan 2026 12:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79C430AAAF;
	Sun, 18 Jan 2026 12:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="LklVKcVn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18B720ED
	for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 12:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768738019; cv=none; b=uBK6HphWX+PD4cpaqDZNrtf+dcrBcPi3Y/DosdUBB+1xA6LVFg0YKYpwYRHvqWbW4eayGeEHJ/pGsPW/JatVP6JgyQ/0SPTYnFTiSAD50mfSiSfZqYfBKnBAjH/8B5waTA+YIUELyOSqH11XaIVcBWb7dN7MLTGVXtReQCpSGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768738019; c=relaxed/simple;
	bh=2snyPXzUW1pSP/ejzB76oBRrjcjiqx1wHfBjjbzVVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5CLOWgALcur3i+U5X80FJ9hVs96J0nmmNOmGxnBL8Kdgl/hJW1N+9p0/RNGvNj/u/CWvIezhlrSnvrvFifR0IrhLPn9KUV50rHBGQR7xoZ/fJPgRtu9r13uC+ojUYwRJus3ANSy1stHDc2Xsdz9oWBrOpmPtERB0MiqSFHnuqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=LklVKcVn; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30762 invoked from network); 18 Jan 2026 13:00:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1768737616; bh=ie3M1ko46PXaWufmkqkh26CiLdv3AmPElpQRdijD1V8=;
          h=From:To:Cc:Subject;
          b=LklVKcVnG/gAblYw3+A6VEdbBCelx+U+ktLlZqMCXQCPuMmwA46qQg9DozH1xGlJt
           0AzRvkWtqlB9R0mctoKvRxZqRsvbTQZrCeHzgAjDT/73eHc9Tj4Q/EH9AM0C2EkVKx
           ZZnJatCz3Q+g7MnGhYkRkLJP/u5JbuxVon/vzTjhtVDCvqCqX/8q17mrG3hg+cu0HE
           Gres6VSwsysGkJyPicPpfd56NH4OR6GnAki7m6DG8dlI6eloABrp9J2Fr0Xo1UEobR
           FpoXV26GYLAg8aAJYtAC146TXrIY9Anju720v7ww+LKmuOcYxqLOTMDwGMqeKaANeG
           QoX31MuVF59xg==
Received: from 83.24.149.95.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.149.95])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <johannes.berg@intel.com>; 18 Jan 2026 13:00:16 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: johannes.berg@intel.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Felix Fietkau <nbd@openwrt.org>
Subject: [PATCH] iw: survey: add BSS receive time to survey
Date: Sun, 18 Jan 2026 13:00:07 +0100
Message-ID: <20260118120013.4383-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: dbb982c988b0946880c17121d6f34366
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [MQOE]                               

Print channel BSS receive time in survey dump. This patch comes
from OpenWRT. It's been in use for 7 years.

Cc: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 survey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/survey.c b/survey.c
index 7f5385e..53cec9d 100644
--- a/survey.c
+++ b/survey.c
@@ -60,6 +60,9 @@ static int print_survey_handler(struct nl_msg *msg, void *arg)
 	if (sinfo[NL80211_SURVEY_INFO_CHANNEL_TIME_RX])
 		printf("\tchannel receive time:\t\t%llu ms\n",
 			(unsigned long long)nla_get_u64(sinfo[NL80211_SURVEY_INFO_CHANNEL_TIME_RX]));
+	if (sinfo[NL80211_SURVEY_INFO_TIME_BSS_RX])
+		printf("\tchannel BSS receive time:\t%llu ms\n",
+			(unsigned long long)nla_get_u64(sinfo[NL80211_SURVEY_INFO_TIME_BSS_RX]));
 	if (sinfo[NL80211_SURVEY_INFO_CHANNEL_TIME_TX])
 		printf("\tchannel transmit time:\t\t%llu ms\n",
 			(unsigned long long)nla_get_u64(sinfo[NL80211_SURVEY_INFO_CHANNEL_TIME_TX]));
-- 
2.47.3


