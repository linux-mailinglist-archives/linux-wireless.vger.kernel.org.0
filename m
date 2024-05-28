Return-Path: <linux-wireless+bounces-8208-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447D38D1E7E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 16:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E790D28645B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 14:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C0716F85A;
	Tue, 28 May 2024 14:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YARx4o7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A465717106F;
	Tue, 28 May 2024 14:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716906050; cv=none; b=BfkxKWPvJ/WwLvmbDRD4zkG4oiC9dagvu9aunYytnGoM7E+4ZdKftNRi+ECh7gsPKbVBAQ1IfTOdb62/g9WD4xqFWSqfyWq28Jh/8LhWGo/riJwQKG1bvIUO9N4iMhtr/RT2GH0fAEFViwjyhZM40QnmTEEks2wMRT3oJnRo3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716906050; c=relaxed/simple;
	bh=ckK8HV/PJ4m/OmbtPxcBWpY4ly7ROI74ua0Gl+Joj7Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ghmsYqpmbTExnyGg9MCgEq2P2jI/xBjNxcR3ZL0UmYTZ1F1jhPLRexvRffoQDXI++5t3jAwI/DprafwLIhW1R4Z4InqAnu5GlGM/f1VvWQ9kpQFZxXEjII0j47g2hriynW7cz7UT5CYTDOdjiPWRSMZxOJqe6XT7JmloB6tAUCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YARx4o7q; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8C7BE24000B;
	Tue, 28 May 2024 14:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1716906044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rcyQBhDqTkZo84eopnmm/cwcP4P/TkQC4sy913CIbEE=;
	b=YARx4o7qJJytCR2QCrHYofS8SrVdgZB0rLESOVPUdLQSgYlhZY1DnRdzn7mNB5wlAy5N5z
	GoyHLexz/t/I7kU6XLxln+czq7VRQrHPyl+HtWou1xajI7IhQ5dw0uZCBlKIg/Y6Su15Ax
	qxzW/izSminS4TFc0b5867IS/Ohp1LiHvja+TRYxlUJZcCGYOLf8FfDcsAsIIrtxMSB9My
	zGNiZiFV9BTWB85xjh3IVa3YnB0ZaS3w6LZn4psEWo1gYg3j2w2HsXmjP6fPiWKbAoUVne
	C56a/qGKkS0jHBRVGhinmG29Q9Awag2y4UiMCCfm//p6iqYHvlCIS07LFmHHzg==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH wireless 0/3] wifi: wilc1000: revert SRCU to RCU conversion
 series
Date: Tue, 28 May 2024 16:20:27 +0200
Message-Id: <20240528-wilc_revert_srcu_to_rcu-v1-0-bce096e0798c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACzoVWYC/x2MUQqEMAwFryL5tqDVuq5XESlSoxsQXRK1gnh3g
 1/DwLx3gSATCjTJBYwHCa2LSp4mEH79MqGhQR1sZsvM2dpEmoPXEnnzwmH32+oVxn1C1X/zoi5
 KB7r+M450vs8tRGKcUQS6+34AybG6JXMAAAA=
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

This series is a follow-up to the static analyzer warnings raised by Dan
Carpenter ([1]), and the agreement to proceed with a revert ([2]) due to the
difficulties involved in fixing the remaining issues.

The initial series aimed to simplify the driver by switching it to
classical RCU, since there was no evidence of SRCU usage legitimity in it.
The warnings raised after the merge are likely hinting at some technical
constraints which eventually led to SRCU usage, so put it back.
Additionally, the series adds some comments to document SRCU usage.

Unfortunately the faulty series reached a tagged release, so this revert
series targets the wireless tree (ie not the wireless-next).

[1] https://lore.kernel.org/linux-wireless/3b46ec7c-baee-49fd-b760-3bc12fb12eaf@moroto.mountain/
[2] https://lore.kernel.org/linux-wireless/878qzu8e4k.fsf@kernel.org/

---
Alexis Lothoré (3):
      Revert "wifi: wilc1000: convert list management to RCU"
      Revert "wifi: wilc1000: set atomic flag on kmemdup in srcu critical section"
      wifi: wilc1000: document SRCU usage instead of SRCU

 drivers/net/wireless/microchip/wilc1000/cfg80211.c | 41 ++++++++++++---------
 drivers/net/wireless/microchip/wilc1000/hif.c      | 17 +++++----
 drivers/net/wireless/microchip/wilc1000/netdev.c   | 43 +++++++++++++---------
 drivers/net/wireless/microchip/wilc1000/netdev.h   | 12 +++++-
 drivers/net/wireless/microchip/wilc1000/wlan.c     |  5 ++-
 5 files changed, 72 insertions(+), 46 deletions(-)
---
base-commit: 7e81b62cfb9abdd8177606f7c79a0585503bd7ae
change-id: 20240528-wilc_revert_srcu_to_rcu-57c6a9138345

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


