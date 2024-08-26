Return-Path: <linux-wireless+bounces-11944-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2672D95EA60
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 09:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22BD1F21E4E
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 07:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21F813B286;
	Mon, 26 Aug 2024 07:27:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F58612C54D
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 07:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657235; cv=none; b=rTRjARbZbg7wjHs/6LzByDw17qEsZqugPeZ7Ug/B3UmaPMBVy67rVIISuS9ZBu2cv9puuTVmPchovEJhod0RKrTteA+jQLWI3XSPLfICqxJ86JnyVX3ws/cQTrG+RA74EHJh9Xxqhm4fxrcR93nDaU5w3joCnmr3QCfWXGKvbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657235; c=relaxed/simple;
	bh=NtahUHX9CE0RzYfvV3yhtc/blBQY9V1UzWIWs/MxwLw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=It36yhMQwFxJw+UM8eS7B/Oz1w4HtymPYF1D5b4TdO+pGk8rRWssRT/qTF13b02IhwgApe7PaQ2rSpe818f9Rj3A0f3NtLy/gnmK29DswCfFN3Rn0jRuKz7aMMLjmYZs+q8p7+cGzqgqgyTJNugP5mt7DKwS7P/NfRcHCTHMPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0005HS-SJ; Mon, 26 Aug 2024 09:26:53 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-0038Ev-6C; Mon, 26 Aug 2024 09:26:53 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siU7p-000hSF-0G;
	Mon, 26 Aug 2024 09:26:53 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Calvin Owens <calvin@wbinvd.org>,
	Brian Norris <briannorris@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	David Lin <yu-hao.lin@nxp.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 3/4] wifi: mwifiex: wait longer for SDIO card status
Date: Mon, 26 Aug 2024 09:26:47 +0200
Message-Id: <20240826072648.167004-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240826072648.167004-1-s.hauer@pengutronix.de>
References: <20240826072648.167004-1-s.hauer@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The IW61x needs longer than the currently used MAX_POLL_TRIES for some
operations. Increase the value to 10000 * 10us = 100000us as done in the
downstream driver as well.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 490ffd981164d..cbcb5674b8036 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -1265,7 +1265,7 @@ mwifiex_sdio_poll_card_status(struct mwifiex_adapter *adapter, u8 bits)
 	u32 tries;
 	u8 cs;
 
-	for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
+	for (tries = 0; tries < 10000; tries++) {
 		if (mwifiex_read_reg(adapter, card->reg->poll_reg, &cs))
 			break;
 		else if ((cs & bits) == bits)
-- 
2.39.2


