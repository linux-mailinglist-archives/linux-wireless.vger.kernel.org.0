Return-Path: <linux-wireless+bounces-21902-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A2A98359
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 10:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A66281B64DD1
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DA27D788;
	Wed, 23 Apr 2025 08:21:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E2B27CB33
	for <linux-wireless@vger.kernel.org>; Wed, 23 Apr 2025 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396478; cv=none; b=kb6JiFaljRSUT9HtH8kTigLGtfRDhEolXRSUHwC4r05/nGLKTSqhlLiOrKnWCjpxb6N/18Ech3eJ25fvYtEYQqWdVlAhFCgf/TV1TkbOavpzoLTeWNw7C6oTTfVcud7xPjmxjRpen6ae5nHw4GaoDEI6xsm5MUqB30o2CFRzHYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396478; c=relaxed/simple;
	bh=ac5S2X3sWmh08U5JD9QdCfMbz/52WrPI+ah0XzYURio=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OkFgg2fsYKCyHjhbWdZJteBd/48EFiBxY4Giu5oJqSjnBi8Ilavv+Lcymqy5HPWDeq6eByDhQTNNq0hRwAcKM2CjVZslMQlnxJrR+odPmyhFZelGRvuGHPnLc/me9LldkhDef9ZiEC0D1+dEAHtwg42Ea5hXDIFTGNDqtdrvumc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLu-0003K4-5H; Wed, 23 Apr 2025 10:21:06 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-001gbF-1w;
	Wed, 23 Apr 2025 10:21:05 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u7VLt-00BoAZ-1Z;
	Wed, 23 Apr 2025 10:21:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/4] wifi: mwifiex: drop asynchronous init waiting code
Date: Wed, 23 Apr 2025 10:21:01 +0200
Message-Id: <20250423-mwifiex-drop-asynchronous-init-v2-0-1bb951073a06@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAO2iCGgC/42NQQ6CMBBFr0Jm7Zi2WBVX3sOwaGAKs7AlLWAJ6
 d2tnMDl+/l5b4dIgSnCo9oh0MqRvSugThV0o3EDIfeFQQmlxUUKfH/YMiXsg5/QxM11Y/DOLxH
 Z8YxGWlXXjWi0uUGRTIEspyPwaguPHGcftqO3yt/6t3qVKPBqlFTWNPKu6TmRG5a5fDide4I25
 /wFFhrEIdEAAAA=
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745396465; l=1565;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=ac5S2X3sWmh08U5JD9QdCfMbz/52WrPI+ah0XzYURio=;
 b=zVfDL9QyPySAhVoQt4Jy16nC1/aLV9W91br+67JJy3kzZybOpY/sGh+hxgIzM1Qr9RB0ZhFye
 pF3JdR1uHHYCZTIt6siOhK0Ff2/AeuFwWjhHs21GJ9oy7S+OpM3PFyl
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This is a spin-off from my mwifiex cleanup series. I have split the
original single patch into a series which hopefully makes the changes
easier to follow and verify.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- squashed fixup sent separately into series
- Fix some checkpatch warnings in commit messages
- Add Acked-by tags from Brian Norris
- Add Reviewed-by tags from Francesco Dolcini
- Link to v1: https://lore.kernel.org/r/20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de

---
Sascha Hauer (4):
      wifi: mwifiex: remove unnecessary queue empty check
      wifi: mwifiex: let mwifiex_init_fw() return 0 for success
      wifi: mwifiex: drop asynchronous init waiting code
      wifi: mwifiex: remove mwifiex_sta_init_cmd() last argument

 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  8 ++++----
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 16 ----------------
 drivers/net/wireless/marvell/mwifiex/init.c     | 21 ++++++++-------------
 drivers/net/wireless/marvell/mwifiex/main.c     | 25 +++----------------------
 drivers/net/wireless/marvell/mwifiex/main.h     |  8 +-------
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  |  8 +-------
 drivers/net/wireless/marvell/mwifiex/util.c     | 18 ------------------
 7 files changed, 17 insertions(+), 87 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-mwifiex-drop-asynchronous-init-a1f2339095a7

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


