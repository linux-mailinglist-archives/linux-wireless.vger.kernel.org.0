Return-Path: <linux-wireless+bounces-11694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC9D958674
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 447341F26206
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF6919066E;
	Tue, 20 Aug 2024 12:00:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509B718FC91
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155235; cv=none; b=H4Ogi1BknjzYMfRor8UxMgSBGvLsUW2p/56g1kLdGs9IzWuLJ/Bu7IRHitwEeL10t9WVcoUw7uY14mGm/HdhjmIX9i52VrJ+icgnYwmk4mcAR+WEljezZpPZCIxiTaT0gsaV+l273vpO1pRcecdFu+HPMgdYGLWj8Z0y+Dysjmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155235; c=relaxed/simple;
	bh=fQ6OtQihTMtbJNSqAs/DTisQPMxfV34M4V7bfNcV97g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hijLICaY3EWU08JyBqT2ZEZHX1t7zxAsJOTffPXjchqw8aOIadCe5+/LFsPKgz+HhVI9CZXdkmL600JeCWdOfiMlPr9VHaWw8QL61wFuuMKEMVcKC1MbeMIVCesp081OVbZ5TuirmkD7Q9Zygt7ah1tDQubHr5cLunAFtecfuSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-0000yc-N4; Tue, 20 Aug 2024 14:00:27 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXH-001lO3-75; Tue, 20 Aug 2024 14:00:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1G;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:35 +0200
Subject: [PATCH 10/31] wifi: mwifiex: fix indention
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-10-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=1186;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=fQ6OtQihTMtbJNSqAs/DTisQPMxfV34M4V7bfNcV97g=;
 b=HYmKYDzN8i8IPm0HaQa+sMb1m2RkaaV0HBoUpR3cFvct8K4FqXMYtrVJdidDSUuw+4xp1EpyP
 9DD3gy72gxrCaEBS2UoYMUw/gSz3KiLdlNTzZ4XLCNd2a0/mDEUEYoB
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Align multiline if() under the opening brace.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/wmm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/wmm.c b/drivers/net/wireless/marvell/mwifiex/wmm.c
index bcb61dab7dc86..1b1222c73728f 100644
--- a/drivers/net/wireless/marvell/mwifiex/wmm.c
+++ b/drivers/net/wireless/marvell/mwifiex/wmm.c
@@ -1428,13 +1428,13 @@ mwifiex_dequeue_tx_packet(struct mwifiex_adapter *adapter)
 	}
 
 	if (!ptr->is_11n_enabled ||
-		ptr->ba_status ||
-		priv->wps.session_enable) {
+	    ptr->ba_status ||
+	    priv->wps.session_enable) {
 		if (ptr->is_11n_enabled &&
-			ptr->ba_status &&
-			ptr->amsdu_in_ampdu &&
-			mwifiex_is_amsdu_allowed(priv, tid) &&
-			mwifiex_is_11n_aggragation_possible(priv, ptr,
+		    ptr->ba_status &&
+		    ptr->amsdu_in_ampdu &&
+		    mwifiex_is_amsdu_allowed(priv, tid) &&
+		    mwifiex_is_11n_aggragation_possible(priv, ptr,
 							adapter->tx_buf_size))
 			mwifiex_11n_aggregate_pkt(priv, ptr, ptr_index);
 			/* ra_list_spinlock has been freed in

-- 
2.39.2


