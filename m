Return-Path: <linux-wireless+bounces-21377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE693A8408C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24241B81C8C
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7567428153C;
	Thu, 10 Apr 2025 10:24:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17990281357
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280686; cv=none; b=esTi0oNfqYGf6SxXhufmHi7/b+4zA5GBwj36cOaHVUeA6ugRRBhBFENFsbshtRYQ8W3+AMg+9ZtpnFQi14++fJZk9PHBNYqBscHo/53ig8qMAVstSjAnMMlG4Xur2YsQBoanIXPiDrOBLSpHi42L5zdigjBpUR5y27rq3IPY91Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280686; c=relaxed/simple;
	bh=rMJbXWC+jDUOohOA/xD6FAvMOqOrfNDnQE4N55xs420=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zy+LNDBSrIckQZmE7QhyedjV+K3DIFjwduh0DI0nMfJ4iarIeW7ziay09FiN/222sJaLYU3bcAzyM7c/dJQu08PN8huwN43q+wXPGzWtod3MKEF9eUJzIwCZtJs8rHkw+Y3XdV9zhsiekhdzzqCkaalqGP0ObHwenhJm+ypQES8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DK-5i; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fn1-2r;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2Q;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Thu, 10 Apr 2025 12:24:32 +0200
Subject: [PATCH wireless-next v6 8/9] wifi: mwifiex: make locally used
 function static
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mwifiex-cleanup-1-v6-8-a6bbd4ac4d37@pengutronix.de>
References: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
In-Reply-To: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=1694;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=rMJbXWC+jDUOohOA/xD6FAvMOqOrfNDnQE4N55xs420=;
 b=TIMOuWgT9ecLw6MLv3Fyd+4aIjU5rwweCJ8xQrAwYmjmmHlPNc6P358GRES89oUBFIylM/HlB
 BEG20jcDc/1CMkmbdsXmwDc/IXoQX4uSTZnqunfu2MEYT/O2Piu4vcA
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

mwifiex_is_tdls_off_chan() is only used locally. Make it static.

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Brian Norris <briannorris@chromium.org>
---
 drivers/net/wireless/marvell/mwifiex/main.h | 1 -
 drivers/net/wireless/marvell/mwifiex/util.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.h b/drivers/net/wireless/marvell/mwifiex/main.h
index 3efdd53c4b59f..e566470226d8f 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1598,7 +1598,6 @@ mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac);
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


