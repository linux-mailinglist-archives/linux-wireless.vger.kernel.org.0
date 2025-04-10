Return-Path: <linux-wireless+bounces-21385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77246A840AE
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF6047B2932
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 800FC280CFC;
	Thu, 10 Apr 2025 10:28:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F1280CE8
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280931; cv=none; b=jUzHPNB+W1KqxfclDuEiJcbnkj+ei85qExZNlBX19GA7eOsTniVd0bwaCHN+6hddu93/h81qsFAI1pPyeO9xtohZH0akmrTuAzmEVCaOHurDcPaWQnulCT1C7yeyQri9eKGrf682zeuSuev8RE/L/Cj4cjEpj0HYx7RsQsPLyxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280931; c=relaxed/simple;
	bh=xpbyRSZ3XcMdqucOB7wHc/ISKYOcYr6sdtFmQOCm8zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A3PkE7kp2wpKy7ml4PnRA1jssqRiW6/43eeUIoxyKp4sY6OVgSEfAZWaP4O4ljv79BkCAzNdRPBn1ZKhm6CyJUMDmyNoN//R1NXTIxy7F50pP400bRgBbhirgoWHHO7VdL2eHdR0/XZrJNPtwMjLkhGhxn8ssodRMZlh6bfX3f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-0003R1-KC; Thu, 10 Apr 2025 12:28:47 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-004Foc-16;
	Thu, 10 Apr 2025 12:28:47 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-002cFD-0r;
	Thu, 10 Apr 2025 12:28:47 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:28:43 +0200
Subject: [PATCH 1/4] wifi: mwifiex: remove unnecessary queue empty check
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-drop-asynchronous-init-v1-1-6a212fa9185e@pengutronix.de>
References: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
In-Reply-To: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280927; l=1396;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=xpbyRSZ3XcMdqucOB7wHc/ISKYOcYr6sdtFmQOCm8zc=;
 b=mSmPwS9KtDL5imygHmXKuSkt2swgYYOse5QsLyDNjiaX7NPhF378G59qGZS1BTssU+lNxrRq4
 qFx4zfBsEUPBfz0Qe3kaoVtgWNCJRh2Gy0a9oJj5ZswYr0H1e51DbtV
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Since 7bff9c974e1a ("mwifiex: send firmware initialization commands
synchronously") all initialization commands are sent synchronously which
means the command queue is empty when mwifiex_sta_init_cmd() returns. No
need to check for entries in the command code then, so remove the check.

Add a WARN_ON() just in case there is something wrong with the
reasoning.

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


