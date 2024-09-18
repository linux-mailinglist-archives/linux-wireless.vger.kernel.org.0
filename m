Return-Path: <linux-wireless+bounces-12951-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B732897BBA2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97161C20FD4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A7133F9;
	Wed, 18 Sep 2024 11:28:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E2210EC
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726658903; cv=none; b=iIoxulYPZ6W923sfFyhcV6azMb2CE8vBZXT0ftFO9wZjwAr2t1r7FvZzeq1WfEaEc54+WI3/GAp+YAxKZs6b0WkFDRU66Lv/7uiK5V5Et8Ek291/O86eghygYSEIBOjfphE9fKevBRrGCIJTllFYh6DexQ3CjoBTSD0/uSKqoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726658903; c=relaxed/simple;
	bh=CUyoMyC2hCayysckc/FbG1xzD7GsfZEVr01htWGico4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Do8vDL+/lTkjEMnSNuV/zCL2v6cgTOW0A4z3kmnvOWe5PyNl5D63pRcoAP2YRqcR6L4RZcMyvhgf08jeVZVjh/XxJFzcKzMDSKfU0UQgZHMFKJzR/1uReiW0Ll0qJvH7PT5sYr5+DK93S1Ib2VCbodPhXZpy4camunW8ulWhRAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsr3-00045n-Gz; Wed, 18 Sep 2024 13:28:17 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsr2-008noI-Kp; Wed, 18 Sep 2024 13:28:16 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-1E;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 18 Sep 2024 13:10:35 +0200
Subject: [PATCH v2 10/12] wifi: mwifiex: make locally used function static
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240918-mwifiex-cleanup-1-v2-10-2d0597187d3c@pengutronix.de>
References: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
In-Reply-To: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=1643;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=CUyoMyC2hCayysckc/FbG1xzD7GsfZEVr01htWGico4=;
 b=MMFV1XRmfuSh0AvsOOREaqT73iqUFSZjCJtVVixFJznC0mAiaZVCOCOZLB82gaw8xcFTUFeTR
 kj6u7hzd4XuCUvRHhWuEGEjSXFy6/atU3aTDenrRX/9u02R0B+KbsI5
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_is_tdls_off_chan() is only used locally. Make it static.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 1 -
 drivers/net/wireless/marvell/mwifiex/util.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 56f413cb6eb30..f026e6069be3f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1604,7 +1604,6 @@ mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac);
 struct mwifiex_sta_node *
 mwifiex_get_sta_entry(struct mwifiex_private *priv, const u8 *mac);
 u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv);
-u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv);
 u8 mwifiex_is_send_cmd_allowed(struct mwifiex_private *priv);
 int mwifiex_send_tdls_data_frame(struct mwifiex_private *priv, const u8 *peer,
 				 u8 action_code, u8 dialog_token,
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 1f1f6280a0f25..ea28d604ee69c 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -663,7 +663,7 @@ u8 mwifiex_is_tdls_chan_switching(struct mwifiex_private *priv)
 	return false;
 }
 
-u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
+static u8 mwifiex_is_tdls_off_chan(struct mwifiex_private *priv)
 {
 	struct mwifiex_sta_node *sta_ptr;
 

-- 
2.39.5


