Return-Path: <linux-wireless+bounces-11681-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62886958660
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 14:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FEED2862DF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F918FC98;
	Tue, 20 Aug 2024 12:00:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F3F18F2D5
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 12:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724155232; cv=none; b=C/cR6jx8xPaFkw0u0BdPD3hBFMdxiMod11jnuhIjk1airJ7fT/4jNWJLW9XKVMQPaR8riHznl5LaPx9B9sMxJCBhnCrX9J5OyoJUEKSBb+9FAbyf62d0Biqe2K8cH0qk2EhpdAzDX+WUvLMvzKCt4Fx9UrjRmEo+bnyoKG2Nhc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724155232; c=relaxed/simple;
	bh=HEhEdThzY+uVINtwXzwbGho/WWVV5DgBTO5dvcE9lNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1S3+O5Bvutoe1rj2kZuXjJ5VLTMu9XJ9q/9Cuanw3goScGMsGZK3e7XVydpKjxgPI3zDmzo679uaWu/bdsR+6SG5//sFDGKNK/Y69fCGk2lcGWINQqU7s1g0+5Bxv/CKwsFQNhlv83ucOVcz8mrP6fOJIGKLQ+MnArjWxpK9ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXG-0000tj-4y; Tue, 20 Aug 2024 14:00:26 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNXF-001lN1-My; Tue, 20 Aug 2024 14:00:25 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-1X;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Tue, 20 Aug 2024 13:55:52 +0200
Subject: [PATCH 27/31] wifi: mwifiex: do not use mwifiex_get_priv() in
 mwifiex_dnld_sleep_confirm_cmd()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240820-mwifiex-cleanup-v1-27-320d8de4a4b7@pengutronix.de>
References: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
In-Reply-To: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=1359;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=HEhEdThzY+uVINtwXzwbGho/WWVV5DgBTO5dvcE9lNk=;
 b=vLiKh67V6kWSKJW7so2pK07WIBeOHxad5EJ4KyBUZpUxjcOBV7vakUfbqbMqrtKH32k7LaugV
 zvLZDFg9lQSAMqtegsRoWaJyxMj0Kri/rfb5gXijy/uOUc4mg2jTopm
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY) returns an arbitrary
priv *, so we can just make up some valid bss_num and bss_type values
ourselves without calling this function.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/cmdevt.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/cmdevt.c b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
index 410e548fab074..1b6d50b8078a3 100644
--- a/drivers/net/wireless/marvell/mwifiex/cmdevt.c
+++ b/drivers/net/wireless/marvell/mwifiex/cmdevt.c
@@ -298,19 +298,15 @@ static int mwifiex_dnld_cmd_to_fw(struct mwifiex_adapter *adapter,
 static int mwifiex_dnld_sleep_confirm_cmd(struct mwifiex_adapter *adapter)
 {
 	int ret;
-	struct mwifiex_private *priv;
 	struct mwifiex_opt_sleep_confirm *sleep_cfm_buf =
 				(struct mwifiex_opt_sleep_confirm *)
 						adapter->sleep_cfm->data;
 	struct sk_buff *sleep_cfm_tmp;
 
-	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);
-
 	adapter->seq_num++;
 	sleep_cfm_buf->seq_num =
 		cpu_to_le16(HostCmd_SET_SEQ_NO_BSS_INFO
-					(adapter->seq_num, priv->bss_num,
-					 priv->bss_type));
+					(adapter->seq_num, 0, 0));
 
 	mwifiex_dbg(adapter, CMD,
 		    "cmd: DNLD_CMD: %#x, act %#x, len %d, seqno %#x\n",

-- 
2.39.2


