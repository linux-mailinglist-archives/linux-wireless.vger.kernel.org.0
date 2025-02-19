Return-Path: <linux-wireless+bounces-19150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90AA3C9FB
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 21:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76043BB65E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 20:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD4D23ED40;
	Wed, 19 Feb 2025 20:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EXUOMX0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E5122CBCC;
	Wed, 19 Feb 2025 20:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997166; cv=none; b=F654akP8t8WrhsAOe8mm/kRNkzEF2+jyMsNJ1zeXJFd4sz2QYdAUoYCX/5u4Kusza6bt/kG7GgivZqmMiaS2NVPzJfLCgNRuUZzaWqoChSlxhSrxiw+wJ9zW7nS4SmmhmnGTdoTUTuy/zAYKqSqE4GbinnijVLCe3ses3kOfOP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997166; c=relaxed/simple;
	bh=HRVgObHs8bGEc7tH2gAcvbemXgz8rX2U9nVw7dNd+1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GQYzpxsu0+fsHvIX91LSaoOeJj/UoF/qFPD/7Pmf0lKtLGNP8m/ymnu0FBwqsS4Vpbn3nVkKiL99JNf6G/7trqb+8STQ14d39h1e5xgCAr6kOGvo9WWkVE5kFmWyZaIt87iCJnjMwf1pNzXe7E+ua+UUdsQR9ytCUBgDnRTeoGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EXUOMX0l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from eahariha-devbox.5bhznamrcrmeznzvghz2s0u2eh.xx.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AFCA204E595;
	Wed, 19 Feb 2025 12:32:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AFCA204E595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739997164;
	bh=0FPekyUor37/wk7zjsHB9TTmXocvbT+z0VCSgOISBI4=;
	h=From:To:Cc:Subject:Date:From;
	b=EXUOMX0l+t8WdFMSbbFmdpfTc/QM2hWBfZnxG5iJ2uE3bxMGoypDlMGUUHExuBeeR
	 R4xLIPl5gjgFtktFOvjolJn2VtR7ZP4WCQCYt6x1R1rTMkmkyA+flnQqPtKALdasew
	 v1f6jnbJvp3HsNBFLbqUKKzeamKGC4LIJDNrlySA=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org (open list:802.11 (including CFG80211/NL80211)),
	linux-kernel@vger.kernel.org (open list)
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>
Subject: [PATCH] wifi: cfg80211: convert timeouts to secs_to_jiffies()
Date: Wed, 19 Feb 2025 20:32:40 +0000
Message-ID: <20250219203240.141272-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies(E * 1000)
+secs_to_jiffies(E)

-msecs_to_jiffies(E * MSEC_PER_SEC)
+secs_to_jiffies(E)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 net/wireless/scan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index cd2124329521..1de25e9763cb 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1365,7 +1365,7 @@ void cfg80211_bss_age(struct cfg80211_registered_device *rdev,
                       unsigned long age_secs)
 {
 	struct cfg80211_internal_bss *bss;
-	unsigned long age_jiffies = msecs_to_jiffies(age_secs * MSEC_PER_SEC);
+	unsigned long age_jiffies = secs_to_jiffies(age_secs);
 
 	spin_lock_bh(&rdev->bss_lock);
 	list_for_each_entry(bss, &rdev->bss_list, list)
-- 
2.43.0


