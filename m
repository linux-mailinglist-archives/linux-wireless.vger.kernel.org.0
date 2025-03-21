Return-Path: <linux-wireless+bounces-20643-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAEA6B662
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 09:54:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECCC03B1E55
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF7D1EFFB0;
	Fri, 21 Mar 2025 08:50:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79E1DDA39
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 08:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547052; cv=none; b=GpF9m9Wzs1hOay04i10YjceOgeFD17I9+HuyAFioM7CCgl0S3eLTW+NHx7szP329txrTwfY7byw+UDBXwqiikB8BZ3/d53asnVgWQ064FWC6UBl3Tl4zd9O7nt5Xoh4H3Iv+CrFPigUr6mascUthCsS/9Cf+zxe0BwYA8RocBbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547052; c=relaxed/simple;
	bh=48+PYPR2/Of/mJeAc7DVeqDQkO4dzLzfOOVQJmQl3wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lopr2v9Nq0Po1sxp0+AjWNym4X7sD+FQvVRvPl4+kDS/4N4yjHnfILRUBuHHFjr6bLvD0vsbylI2nDpYAfJIbdBgqV5aRDP3crxP9ZmMo66nuIFJLNTaChut5wzzNx9JKvd3C4L9wWRJ2fnW2H0lWZJOhWury/yQrFti0m/uzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Lp-HD; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taQ-2S;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-0C;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:07 +0100
Subject: [PATCH v4 07/10] wifi: mwifiex: fix indention
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-7-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547013; l=1250;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=48+PYPR2/Of/mJeAc7DVeqDQkO4dzLzfOOVQJmQl3wE=;
 b=Lo/vf0Mv7kBL1HWYdhLZbHTmh+SisJ8mCWDX6RFt0pnOenX7P00q5Z8fIYbQtavI/3vgEBOQS
 aIyjtV+JMXgCVmEvWA2fHj43+vqjWcSllPvs8bGac5u1s9aFgcJm5J+
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


