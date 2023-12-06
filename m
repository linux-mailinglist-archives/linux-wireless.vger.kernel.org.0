Return-Path: <linux-wireless+bounces-497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036E68070AB
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 14:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1FB31F21563
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 13:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7843374EA;
	Wed,  6 Dec 2023 13:13:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDBAC
	for <linux-wireless@vger.kernel.org>; Wed,  6 Dec 2023 05:13:46 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <rcz@pengutronix.de>)
	id 1rArii-0001DV-2f; Wed, 06 Dec 2023 14:13:44 +0100
Received: from [2a0a:edc0:0:1101:1d::54] (helo=dude05.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <rcz@pengutronix.de>)
	id 1rArig-00DyO1-MO; Wed, 06 Dec 2023 14:13:42 +0100
Received: from rcz by dude05.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <rcz@pengutronix.de>)
	id 1rArig-00D0Qc-20;
	Wed, 06 Dec 2023 14:13:42 +0100
From: Rouven Czerwinski <r.czerwinski@pengutronix.de>
To: Josua Mayer <josua@solid-run.com>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	stable@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] net: rfkill: gpio: set GPIO direction
Date: Wed,  6 Dec 2023 14:13:35 +0100
Message-Id: <20231206131336.3099727-1-r.czerwinski@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: rcz@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Fix the undefined usage of the GPIO consumer API after retrieving the
GPIO description with GPIO_ASIS. The API documentation mentions that
GPIO_ASIS won't set a GPIO direction and requires the user to set a
direction before using the GPIO.

This can be confirmed on i.MX6 hardware, where rfkill-gpio is no longer
able to enabled/disable a device, presumably because the GPIO controller
was never configured for the output direction.

Fixes: b2f750c3a80b ("net: rfkill: gpio: prevent value glitch during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
---
 net/rfkill/rfkill-gpio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index 5a81505fba9ac..3d9ae696397cf 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -126,6 +126,16 @@ static int rfkill_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (rfkill->reset_gpio)
+		ret = gpiod_direction_output(rfkill->reset_gpio, true);
+	if (ret)
+		return ret;
+
+	if (rfkill->shutdown_gpio)
+		ret = gpiod_direction_output(rfkill->shutdown_gpio, true);
+	if (ret)
+		return ret;
+
 	rfkill->rfkill_dev = rfkill_alloc(rfkill->name, &pdev->dev,
 					  rfkill->type, &rfkill_gpio_ops,
 					  rfkill);

base-commit: 994d5c58e50e91bb02c7be4a91d5186292a895c8
-- 
2.39.2


