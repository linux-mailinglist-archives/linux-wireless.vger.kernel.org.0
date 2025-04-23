Return-Path: <linux-wireless+bounces-21903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14623A98363
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385A05A468D
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF75227D791;
	Wed, 23 Apr 2025 08:21:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9176527CB2E
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396478; cv=none; b=ADHheiPLe9j68pN0HlGpXGQSyy4Ra9lGOuINW3G5q62PRTu4w0p9iQTQI0LI2p0YuJUAmBlMotVnGMt9ECWr97YIRIhg3wWyeiCFivOEN5QbYjUVxEFMb8+oFTWrGjkR7K2dEmS22S0dL/wIcPgHydjOCUciMwDSFDkzHqR0U5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396478; c=relaxed/simple;
	bh=D/NfNX4Yol0kYiCVDRszhjyS5U1WukjLsJDFJo9/KfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gq5mIYB+dr6lw7lx0KXo3AFlx1inEt4wM1jZX8wvKripO+QHJ1Hh9hNvqPFmvPeIRaM545AA9YnjVgXKbWEh8zvMlJKwlr5Wrme8GWNUAGIsJa6HnjEFF5PmK9ReClk4zeeFjCE8khys8XYoy7/ZnPDQdujiVN9ybTE5JYwagJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLu-0003K1-5H; Wed, 23 Apr 2025 10:21:06 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-001gbD-1u;
	Wed, 23 Apr 2025 10:21:05 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-00BoAZ-1a;
	Wed, 23 Apr 2025 10:21:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 23 Apr 2025 10:21:02 +0200
Subject: [PATCH v2 1/4] wifi: mwifiex: remove unnecessary queue empty check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-mwifiex-drop-asynchronous-init-v2-1-1bb951073a06@pengutronix.de>
References: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
In-Reply-To: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745396465; l=1518;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=D/NfNX4Yol0kYiCVDRszhjyS5U1WukjLsJDFJo9/KfQ=;
 b=Pj6jyLu57YRs0a/qkl1Im+znLUsXJFODznD+EBwP9KouxLkgIzebPPNITldtR9Z0Z6uWfMDkE
 k27Fcr3BUWaDpDsORAiRaTOmSP/52lpxvN8R2HHR0v8Vta0vwUqaRhi
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Since Commit 7bff9c974e1a ("mwifiex: send firmware initialization commands
synchronously") all initialization commands are sent synchronously which
means the command queue is empty when mwifiex_sta_init_cmd() returns. No
need to check for entries in the command code then, so remove the check.

Add a WARN_ON() just in case there is something wrong with the
reasoning.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Acked-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index ce0d42e72e946..7877dfe5a2233 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -522,15 +522,10 @@ int mwifiex_init_fw(struct mwifiex_adapter *adapter)
 	}
 
 	spin_lock_bh(&adapter->cmd_pending_q_lock);
-	is_cmd_pend_q_empty = list_empty(&adapter->cmd_pending_q);
+	WARN_ON(!list_empty(&adapter->cmd_pending_q));
 	spin_unlock_bh(&adapter->cmd_pending_q_lock);
-	if (!is_cmd_pend_q_empty) {
-		/* Send the first command in queue and return */
-		if (mwifiex_main_process(adapter) != -1)
-			ret = -EINPROGRESS;
-	} else {
-		adapter->hw_status = MWIFIEX_HW_STATUS_READY;
-	}
+
+	adapter->hw_status = MWIFIEX_HW_STATUS_READY;
 
 	return ret;
 }

-- 
2.39.5


