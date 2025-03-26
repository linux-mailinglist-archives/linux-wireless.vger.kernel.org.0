Return-Path: <linux-wireless+bounces-20843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15037A7165D
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9A393A7858
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9775D1DF963;
	Wed, 26 Mar 2025 12:18:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862131E4AE
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 12:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991521; cv=none; b=RiBZ7jJAXH7RKpaOr7tnIOBAIPwqQPz9YdaEZLE/eFuzBX5ldL/t3cJp9/ViIq20oFYbE8M4AMqvKOnDiikoMgba2lSAQW+7QecZ7NUDy6Ii+C1GgsdGw7EFWVdJtDw/GpmX1wkPIu1WDvm5z6gV0Vkb1GV9FeFXbIJYnfw+dlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991521; c=relaxed/simple;
	bh=SRfsHjiqZw1vKNWVfX/k2li0P5baWsoBJ1z9BXS+rLM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ANiETgZBAP5fZ5SJAGxS91t/Bfvm0HZdS7ur3QYb6erdrO1WJcHOlJKA+JH+CbW3RG09D2M5dMBm0L8PYrD0/4CBjTTu9PuRyz9y40eluOHdqhNZrpO04Kbkf97kCqzu4L5eHxoOqRV97PguUIO0TpYuTX5Ylr999DiLgdrJchQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-0005sk-HI; Wed, 26 Mar 2025 13:18:35 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiM-001kIq-2P;
	Wed, 26 Mar 2025 13:18:35 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-000aOn-0D;
	Wed, 26 Mar 2025 13:18:35 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 26 Mar 2025 13:18:31 +0100
Subject: [PATCH do not merge 1/4] wifi: mwifiex: release firmware at remove
 time
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-mwifiex-iw61x-v1-1-ff875ed35efc@pengutronix.de>
References: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
In-Reply-To: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742991515; l=1734;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=SRfsHjiqZw1vKNWVfX/k2li0P5baWsoBJ1z9BXS+rLM=;
 b=igzuuK8C2Jbwo3ZU4TbFs2xWE6/FtJL2qrvF3QRJho6HzovUW4MDGyBY9dr6iJ7kyjnhoxTHr
 hSPRCxYrr/DC2DsmEhPx3pjDdpwmgei77Vn9cSI78KsGoNngr0T88Aj
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

With VDLL support the device will request parts of the firmware during
runtime, so instead of releasing the firmware immediately after initial
firmware upload, release it during device deregistration.

FIXME: I am not sure if we run into trouble with the firmware framework
when we don't release the firmware. We might have to copy it over to
some private buffer instead of just keeping it around.

FIXME: we might want to limit the release firmware at remove time to the
devices that actually need it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
index 855019fe54858..0b394ea261316 100644
--- a/drivers/net/wireless/marvell/mwifiex/main.c
+++ b/drivers/net/wireless/marvell/mwifiex/main.c
@@ -695,10 +695,6 @@ static int _mwifiex_fw_dpc(const struct firmware *firmware, void *context)
 		release_firmware(adapter->cal_data);
 		adapter->cal_data = NULL;
 	}
-	if (adapter->firmware) {
-		release_firmware(adapter->firmware);
-		adapter->firmware = NULL;
-	}
 	if (init_failed) {
 		if (adapter->irq_wakeup >= 0)
 			device_init_wakeup(adapter->dev, false);
@@ -1836,6 +1832,11 @@ int mwifiex_remove_card(struct mwifiex_adapter *adapter)
 		    "info: unregister device\n");
 	if (adapter->if_ops.unregister_dev)
 		adapter->if_ops.unregister_dev(adapter);
+	if (adapter->firmware) {
+		release_firmware(adapter->firmware);
+		adapter->firmware = NULL;
+	}
+
 	/* Free adapter structure */
 	mwifiex_dbg(adapter, INFO,
 		    "info: free adapter\n");

-- 
2.39.5


