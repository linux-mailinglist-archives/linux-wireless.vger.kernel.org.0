Return-Path: <linux-wireless+bounces-20642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28942A6B658
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 09:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7736A19C6471
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Mar 2025 08:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B228BEE;
	Fri, 21 Mar 2025 08:50:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43AD1F03EC
	for <linux-wireless@vger.kernel.org>; Fri, 21 Mar 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742547045; cv=none; b=BUDoCiOGYL1FKs6AtcVrjSTksVdljQR/km+TfxcudXMUtWJAcD2rZPJ3ZzOhyRP50K2tT9fWc05ayfwTc/2uVNqn23LWDu33XJIWnqiwHEuIRbxLWMALPyrsriMJSULh0UAyBII7oJlanP/smYniZkWzdsLAIx21mY5cIuifsFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742547045; c=relaxed/simple;
	bh=rpxFrAxcQEK5R4bnI18ngPLOw4ftcmp4UGCaE93X8Rg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpP3+MoEGjlwOGbWC53LA4CV0/LkslTm3b8XrUqwc4glAJK/+FT2rg0CqACa9uMyg6pBkgoXBzCD0Tsd7ppUhcduJfwdgGrvee2mDv2ngzQWe7HZf6aRNrxdaMKytrkH2OXezAUd00rIQ4/UFZa9KdnXh2ZZoRFl09WLe228mQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY51-0001Lt-HE; Fri, 21 Mar 2025 09:50:15 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY4z-000taR-2V;
	Fri, 21 Mar 2025 09:50:14 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tvY50-003L3W-0D;
	Fri, 21 Mar 2025 09:50:14 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 21 Mar 2025 09:50:08 +0100
Subject: [PATCH v4 08/10] wifi: mwifiex: make locally used function static
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-mwifiex-cleanup-1-v4-8-4a32b21e2553@pengutronix.de>
References: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
In-Reply-To: <20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742547013; l=1643;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=rpxFrAxcQEK5R4bnI18ngPLOw4ftcmp4UGCaE93X8Rg=;
 b=lFYX9847wMR3XbFuZNi1dAmIx38qygg5ssdTtdK7d63VqgWJNr6wUWDMPIN0cvnV0tRsWbpMq
 s3DBsSA4pc8Awa7+GlQmNgV1zKsLss7hQobuCsHirDAYNIydvgPGquP
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
index 5714ec22f97b5..a6e3dbfc76233 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.h
+++ b/drivers/net/wireless/marvell/mwifiex/main.h
@@ -1600,7 +1600,6 @@ mwifiex_add_sta_entry(struct mwifiex_private *priv, const u8 *mac);
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


