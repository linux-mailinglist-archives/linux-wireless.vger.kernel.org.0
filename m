Return-Path: <linux-wireless+bounces-12940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D49897BB53
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91EA1F2532B
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417EB189907;
	Wed, 18 Sep 2024 11:10:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4C18A93E
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657840; cv=none; b=CJXZgXqYqFET9t6S205EvBr+YmqR96Ae8rhzG7okV5B4bisLV6BhyT+xefnwHjyKCiggGMANWWjv3mTbu0N0BNPh2D3NTcxTW6WiZoC0+zJe3SVxYsACNLjklzrsSbbOa5s7n92La7MdVWKeZNGFvVGJrIUBPPYuXngnmXYGECw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657840; c=relaxed/simple;
	bh=48+PYPR2/Of/mJeAc7DVeqDQkO4dzLzfOOVQJmQl3wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4RqvEa9GG/xz+b1qA0es+Q8PD2xDnRtgFhoDbbl5pgKD7rd7xOKMZbEnwAE42ozOuaIYePmPpOELJuzXvl0qa8ZkBJs1bW42aGD/xiqiSt+TfDqPFIqPdyE/3t24Z/LsAV21WU3o6TiA8TNpB48TVVDlgdFj3yKozuzoXM/08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZs-0007wk-Pi; Wed, 18 Sep 2024 13:10:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-008nTE-Fe; Wed, 18 Sep 2024 13:10:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-1D;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Sep 2024 13:10:34 +0200
Subject: [PATCH v2 09/12] wifi: mwifiex: fix indention
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-mwifiex-cleanup-1-v2-9-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=1250;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=48+PYPR2/Of/mJeAc7DVeqDQkO4dzLzfOOVQJmQl3wE=;
 b=XaLOWEIyBk345bAIpBexz2Gicj2hUAB7/uOOn9uec6VhHcQQz/SbvhftXKPjkkAeXhnl5FpJm
 Qe7UXPyQjQ3Ao4nkghVtZ3DE+gEn+qJ+7Oqv2nL5jUgJbUkV+fv72Zy
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Align multiline if() under the opening brace.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
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
2.39.5


