Return-Path: <linux-wireless+bounces-8206-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3F68D1E79
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19992863F9
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE3317167A;
	Tue, 28 May 2024 14:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="paK4ao9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C500171084;
	Tue, 28 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906049; cv=none; b=aEjPCE26/WOHTMWqmDK6K9qB6ryiGMUsezIMdRyNI0TM3yKFsoOLN4GCkzrU6EjXVX2rvZ0+z3kpjqkZkC6XLO9ChT9p40DGTcLKm2/1+GmestA92sdPnPlPg19CmiC0KToMFon6uTKV7fVWWODkwtCYEiP2KvFHLHM1QgP6VEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906049; c=relaxed/simple;
	bh=MowbVoylCLPdTnkVoMtei/xczZTPVKWoGtaujR/CjOY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8gSZs1p2IlIEfHXSdOEj4HRpD5PoN5FjlqhVEU/1lqodbb1HT+f+nr4WkK54BeTvD20iakO9OULgKWZsspT0VvRcISqHNi8P9GSzn7oyYhKmkG6TxaA5mLYQWhUIiJETBjIGMPkRYnuI9CVGWB+rt8x2/pix/HFGTi77U8WA7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=paK4ao9+; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1A411240011;
	Tue, 28 May 2024 14:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716906045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8v3q4Vs7LL1S/mNsQu+tWKz6VplDLgiIVBfJ0RWWjjI=;
	b=paK4ao9+tQfS62hU66mT6zuPJZID7fFFQ/B2CQSboksfV63rpPJWm6H1jLjpoo4PWRr/nA
	MrTLGFMCvPcAgJFexoVYCC89N+JU94D7hGzj6LwVVMH/ODpzPGyuT46JqkrM8DNU2AkMkU
	D5OnA7yb49bGMF5g1DYpd5J6p7fAJ2nNT4AtjymsRw8SckAs63Ed2/r7aMOK/lWbyIL5Co
	hwsg8fMLstmJ78hlnpBq5dczG4JvKP9J6ZL7wWNK037gxO4xrjmOqvHlw16MERMFrVV03k
	ufl6ZGtfPrJ9pcUxyyfV1pGRVDEl3SPImawQBmn9QURfqBT01EVkMZkyboS+xw==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Tue, 28 May 2024 16:20:30 +0200
Subject: [PATCH wireless 3/3] wifi: wilc1000: document SRCU usage instead
 of SRCU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240528-wilc_revert_srcu_to_rcu-v1-3-bce096e0798c@bootlin.com>
References: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
In-Reply-To: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

Commit f236464f1db7 ("wifi: wilc1000: convert list management to RCU")
attempted to convert SRCU to RCU usage, assuming it was not really needed.
The runtime issues that arose after merging it showed that there are code
paths involving sleeping functions, and removing those would need some
heavier driver rework.

Add some documentation about SRCU need to make sure that any future
developer do not miss some use cases if tempted to convert back again to
RCU.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/netdev.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.h b/drivers/net/wireless/microchip/wilc1000/netdev.h
index 5937d6d45695..fde8610a9c84 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.h
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.h
@@ -220,6 +220,13 @@ struct wilc {
 
 	/* protect vif list */
 	struct mutex vif_mutex;
+	/* Sleepable RCU struct to manipulate vif list. Sleepable version is
+	 * needed over the classic RCU version because the driver's current
+	 * design involves some sleeping code while manipulating a vif
+	 * retrieved from vif list (so in a SRCU critical section), like:
+	 * - sending commands to the chip, using info from retrieved vif
+	 * - registering a new monitoring net device
+	 */
 	struct srcu_struct srcu;
 	u8 open_ifcs;
 

-- 
2.45.1


