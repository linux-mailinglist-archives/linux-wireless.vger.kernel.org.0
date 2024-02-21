Return-Path: <linux-wireless+bounces-3862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 505F085DD8B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 15:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044411F2280F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 14:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BC7E787;
	Wed, 21 Feb 2024 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JvPsis4s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9E7E77B
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 14:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524346; cv=none; b=PCyQeVEbAZqKsJDLceXHjG9LfZ4V+L1dc2tI1fx09TEKsi2fVu2ebUPVFI5nc347pqar86HZreCla6qkUdTsTEzn3V+qHmubkytIK6uUGxHbcQ6Phw2sO73yirOy337U6AYsnSAOB+LnwM47nRZ2lIakLaLk0gZGnwc2r+fwuLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524346; c=relaxed/simple;
	bh=qsWuKm8evu5K4yUMggc74bA4Y8Lyn6nj2LUILda81uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=crqEy+gRN3+vyE4wB6cxne/oX9PuQYLt76bKzEZVBFrg6prz3GiPSrCZTbcqCCUUHdPh7/OEyLPy2sd03ZYj98ox+mV4mWPBo6dHbeS2N/hjsjZcWaew6mB3gOGec1v0SasfL4tnFZnQOIyOPGOLuVngJ/pWJIF65awXWcX1pZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JvPsis4s; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=aDt6+kmcCWi6Bc2D5DLR7lWbRKR1li7CjmMesntOywI=; b=JvPsis4sRhO1nb72CP4Unhw9f1
	/qiRjP2FuqJw4Cvcs5pQTtEmE0i2Ks7fZXDoUBfueC/yvJwJtOZGHjjuDrFc0ET+wuPIyYofsqXov
	slsaYaeBZjyqeiu6sv2HBVPTkseMFm72RPPrNpsMjoR1aWclkvowmunDCR/NzMXSu+Sk=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rcnE8-00FW7u-6O; Wed, 21 Feb 2024 15:05:36 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH wireless] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Wed, 21 Feb 2024 15:05:35 +0100
Message-ID: <20240221140535.16102-1-nbd@nbd.name>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a station has not been uploaded yet, receiving SMPS or channel width
notification action frames can lead to rate_control_rate_update calling
drv_sta_rc_update with uninitialized driver private data.
Fix this by adding a missing check for sta->uploaded.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index d5ea5f5bcf3a..9d33fd2377c8 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -119,7 +119,8 @@ void rate_control_rate_update(struct ieee80211_local *local,
 		rcu_read_unlock();
 	}
 
-	drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
+	if (sta->uploaded)
+		drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
 }
 
 int ieee80211_rate_control_register(const struct rate_control_ops *ops)
-- 
2.43.0


