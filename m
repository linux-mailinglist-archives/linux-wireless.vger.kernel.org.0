Return-Path: <linux-wireless+bounces-1519-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0452A824F63
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 08:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC6421F22F9E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 07:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832511EB45;
	Fri,  5 Jan 2024 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lgk0To0F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723B120B0E;
	Fri,  5 Jan 2024 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DFD191BF208;
	Fri,  5 Jan 2024 07:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704441468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ePVzhc7ydJX94hwyc9SvNbbBg0js80IIMVNsWHlS780=;
	b=Lgk0To0FgR4IYIy51TbxoMuEJbKmVjPvFZm6cgofMT3V6duhR8QvMMOZmQLJdDVokyJuE5
	jD+Kk7Fk/tMfUdd5/vz16Nj7DhSOwDw81D1xXWWrCNt7zk4ZqrWfgVjMMGvEG7p2nwgR7z
	UpDkwa4/Rikud3fe2wPEH6caIyszXZRXIv2saRV9HAmRgSZHUr4FEzD0SCApvayFnY5m90
	xxb3V0kcUCSBr6ynmSGSv/u5wCDNkWFacLsSo9ugE0kRwr13Ro1seadKWSYAo83xR8vhor
	AwXIf1607+MG1tyDAw8gJVb9HPpkFHQm3rHAAAcYDv/WzhhdBT0P+tVTMGyGxQ==
From: =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Kalle Valo <kvalo@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/2] wifi: wilc1000: fix RCU warning in connect path
Date: Fri,  5 Jan 2024 08:57:31 +0100
Message-ID: <20240105075733.36331-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,
this small series aims to fix a RCU warning due to RCU pointer dereference
outside of a RCU critical read section.

Fix is in the second commit, the first one is a mere declarations
reordering before touching declared variables in wilc_parse_join_bss_param

Changes in v2:
- fix leak in early return

Alexis Lothoré (2):
  wifi: wilc1000: fix declarations ordering
  wifi: wilc1000: fix RCU usage in connect path

 drivers/net/wireless/microchip/wilc1000/hif.c | 40 ++++++++++++-------
 1 file changed, 26 insertions(+), 14 deletions(-)

-- 
2.42.1


