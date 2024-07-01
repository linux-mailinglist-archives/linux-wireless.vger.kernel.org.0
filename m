Return-Path: <linux-wireless+bounces-9785-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E7091E53A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 18:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A211F23990
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 16:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63916D4C7;
	Mon,  1 Jul 2024 16:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fY5tU62/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D527D1E502;
	Mon,  1 Jul 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719851028; cv=none; b=nJo5I/pmuHSToTNYS0FqNIaRjhdNh4ft1ys7DixI5ak4Are/wVBLGvl50k1ES/qf7vDYzGi4HvL7yB0um/e2xVzQXqg+t5cnC17Qfw8voKq50IqvJJYIF05uIXnkNX5/B1xOOmNgVhIRgChpdQHcEhf9G13Iti3lwACUGNSEmTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719851028; c=relaxed/simple;
	bh=Ud3k0f++bmCP7hWQnpYEc+m3bgTKGjCo+YcPEKguZLg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KyXQ3kLgpl+iFPX6XEGAvCo4e9CLyufAf7sTBa2jeRKCTr7r+iRYNpMtTJzUood3g0BtCskPYM2tZAoG/hfAzig1G7aWmrpkLbQzKxI0BkbYM38sHFpANw5uMMI0FYAw8l2/36FHZiNdtzHLlUlJ+lKllOh8584hZLAjBiLwdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fY5tU62/; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7C44B60004;
	Mon,  1 Jul 2024 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719851024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0OIw1ocR1thOu8eYtY456hy6sQkLy4RVv5nu2QroPPg=;
	b=fY5tU62/+Rzy8e30dGr5EXI2dVsnn1LUKBSozZ5RYft8rlml2G1tYG5veKerJippDsAgHq
	Frj8bKayAioJO+2G1vrT9hqTTlbNTRH0ubVskoT+rZKfTDSQeE1U9fZPrrHMGOidpLEPGk
	vXrvmchfQ4CgpIA21N+sSNOummwxGz+ZMO1O2p1UqSqfW13RXuwOJsO/6IK4K+Wato/Fp1
	wwY5rPnzJc6jgdwzu2H3bKZR9QjsuWsTdHFl092ZcXSQu5xtejLP49C3HCWDVT7KT/sdUF
	bxktLEvI5hR1Ra6KzL12GOLEsgeEmus7g58+z187z1Siiyiw1MaEbgHcx2NVwQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Mon, 01 Jul 2024 18:23:20 +0200
Subject: [PATCH wireless] wifi: wilc1000: fix ies_len type in connect path
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240701-wilc_fix_ies_data-v1-1-7486cbacf98a@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAPfXgmYC/x2MUQqDMBAFryL7bSBZSwWvIiWE5LVdEJVsUUG8u
 0vf3/CYOUlRBUpDc1LFJirLbBDahvI3zR84KcbEnh++98HtMuX4liOaFUv6Jce2Z8cM9JnMWyv
 s/zdH2qVigiq9rusGKmNIBG0AAAA=
To: linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, Jozef Hopko <jozef.hopko@altana.com>, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

From: Jozef Hopko <jozef.hopko@altana.com>

Commit 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
made sure that the IEs data was manipulated under the relevant RCU section.
Unfortunately, while doing so, the commit brought a faulty implicit cast
from int to u8 on the ies_len variable, making the parsing fail to be
performed correctly if the IEs block is larger than 255 bytes. This failure
can be observed with Access Points appending a lot of IEs TLVs in their
beacon frames (reproduced with a Pixel phone acting as an Access Point,
which brough 273 bytes of IE data in my testing environment).

Fix IEs parsing by removing this undesired implicit cast.

Fixes: 205c50306acf ("wifi: wilc1000: fix RCU usage in connect path")
Signed-off-by: Jozef Hopko <jozef.hopko@altana.com>
Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
The issue has been initially detected by Jozef Hopko, and the resulting
patch is also from him. He asked me to upstream it on his behalf. I have
successfuly reproduced the same issue and confirmed that the patch indeed
fixes the connection to the AP I used. The only update I did is about
adding details about the issue in commit message and fixing whitespaces.
The issue has been disclosed to me directly through private mail, so I have
no relevant Reported-By/Closes tag to provide. I am not sure however why I
do not manage to make sparse detect this faulty cast.
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index d67293142ffb..3c48e1a57b24 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -382,7 +382,8 @@ wilc_parse_join_bss_param(struct cfg80211_bss *bss,
 	struct ieee80211_p2p_noa_attr noa_attr;
 	const struct cfg80211_bss_ies *ies;
 	struct wilc_join_bss_param *param;
-	u8 rates_len = 0, ies_len;
+	u8 rates_len = 0;
+	int ies_len;
 	int ret;
 
 	param = kzalloc(sizeof(*param), GFP_KERNEL);

---
base-commit: 21cfb73516c112f0cf0d3ebd3e4bdfbadc819576
change-id: 20240701-wilc_fix_ies_data-22226322ee7c

Best regards,
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


