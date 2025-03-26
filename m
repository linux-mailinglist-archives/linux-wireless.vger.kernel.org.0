Return-Path: <linux-wireless+bounces-20845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 822E7A71673
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034271895342
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4BE1E834A;
	Wed, 26 Mar 2025 12:18:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898FD1DE3C1
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 12:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991529; cv=none; b=O0V6BzfRsFC5+T+cUrXA1aMIy1kiZ7KrhEb3YspzjbvnXpNLSQq7ONgf0SQqXrsfHDn3UP8xPFefiLk4hmJeQYOEK876sAFc2DwRO8vxqiKjmMSq3egfyT4EjuXhabx9R9L5yMJOiFFDp7I8wOQ3jxjaO81poXdk0my6rry5pnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991529; c=relaxed/simple;
	bh=ZhuSgfVvoFL8j91f0GyZ17IbBlu3hqya+dX4IjhnLxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cYZXhwzX0ada/hhubZX2JcCUncJsfW7RLJ/bHIQwTEASbneuuH/uReQdhzeO+Em6p+V/o98hVsgvCtJQk8yIti/WnQn74M/rEljxM91ni/oOlpy5POvU0EAJuc5WdBiuPWnTVQUiXtYryQKmd7ZZtSEyMgNTjCX5usz3enEXr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-0005si-HM; Wed, 26 Mar 2025 13:18:35 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiM-001kIu-2O;
	Wed, 26 Mar 2025 13:18:35 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-000aOn-0G;
	Wed, 26 Mar 2025 13:18:35 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 26 Mar 2025 13:18:33 +0100
Subject: [PATCH do not merge 3/4] wifi: mwifiex: wait longer for SDIO card
 status
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-mwifiex-iw61x-v1-3-ff875ed35efc@pengutronix.de>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
In-Reply-To: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742991515; l=930;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ZhuSgfVvoFL8j91f0GyZ17IbBlu3hqya+dX4IjhnLxg=;
 b=bRgVARmEzdzkMtTs79TUf73nOQOq2AjYiNjFBJ3i65y0z8y6B2kdnASGOea34jO6g2yjHy9h1
 W15D1rIr3uXCzGRPAFKGxPfQ3W+G0AC8NhU04Aw1PjQYmyzOsYO5mH7
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
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
2.39.5


