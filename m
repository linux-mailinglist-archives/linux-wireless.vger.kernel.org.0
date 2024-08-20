Return-Path: <linux-wireless+bounces-11683-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F61958669
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5529A287BC7
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DD5190043;
	Tue, 20 Aug 2024 12:00:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8275618F2FD
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155233; cv=none; b=QRO/iHy9/mHdTsYii4uS2o9i0Gd4OT+Yi9rEfTxT+NlKyZPWrWjb7i5qWCstEERmYdMFZnthPhzo7Vr1JX0fkyUqsDA564a0WmF+zAnQHMFzoAaDfzLPQAH6yQcDuEwDk7CYYW6LJYNkGzYuAmBMJB5v3IDjFK0YpFyN63cNo4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155233; c=relaxed/simple;
	bh=8/mU3JIog635n2Gcp73eIC9/7pYEDV7BK6F144LB3LU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7cnMIOYaeQbF8/PizV9ZZLIAiXwk77jGVvmKqvxXa5U1gEtbpVh4A1zNWGt4RI/+5hkoMrLDtI/poY80ORavrvf8Aq6HEjrRbv1kIat3rAKBykWb2cvottx59/N3vS4Ct3RTfhBVlXk2/V0SgzGrj0K3kGH/KpWtnYp6S08H20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000v7-LK; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-001lNJ-5K; Tue, 20 Aug 2024 14:00:26 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1O;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:43 +0200
Subject: [PATCH 18/31] wifi: mwifiex: make mwifiex_enable_hs() safe for
 multiple station mode
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-18-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=975;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=8/mU3JIog635n2Gcp73eIC9/7pYEDV7BK6F144LB3LU=;
 b=bN1Hw4kMvtl0irBjfdqdg1UXeHRGEbbz26brCCL/ebFyjb8pE6JjE66cCLyO4zU+5Q6IuQXU3
 nUBqmO+nReZCmmIQyzMmH0TJ3nj68XIY1R1J7UFh7kGCCide4UQmOFK
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

We have to stop the bg scan for all bss in station mode, not only the
first one.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
index d3cba6895f8ce..aa138cab7bea9 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_ioctl.c
@@ -507,9 +507,12 @@ int mwifiex_enable_hs(struct mwifiex_adapter *adapter)
 		}
 	}
 
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);
+	for (i = 0; i < adapter->priv_num; i++) {
+		priv = adapter->priv[i];
+
+		if (!priv->sched_scanning)
+			continue;
 
-	if (priv && priv->sched_scanning) {
 #ifdef CONFIG_PM
 		if (priv->wdev.wiphy->wowlan_config &&
 		    !priv->wdev.wiphy->wowlan_config->nd_config) {

-- 
2.39.2


