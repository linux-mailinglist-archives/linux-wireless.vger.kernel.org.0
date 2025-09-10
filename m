Return-Path: <linux-wireless+bounces-27211-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 487E6B5178A
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 15:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98C3465D62
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Sep 2025 13:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BFF4149C41;
	Wed, 10 Sep 2025 13:03:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA41A9FB5
	for <linux-wireless@vger.kernel.org>; Wed, 10 Sep 2025 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509420; cv=none; b=JAqMKlDTJFChAzEH4UBjh3sk6ubUw9nytS7AJFPaHEv5QE/VcqhOCUC/SVNHIJGRUW84H4YNQEIAA1tr/q+Y8sLvx01eslOXh1imq2J5lNbhzu6ngK3kZ+hUCqigKGOEEMZduT319XNcatShH3j2UYEOQ4Uj3pSRazmSyGllBtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509420; c=relaxed/simple;
	bh=UXhJw5qdqqlSnkCfF7xwIE+zNV5//HXyiaD7wKDHFPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PSnEjrCRH8izIm+kNK4dm+A90OvfxxFFY8XZV7j00Y6X69p4NIo+SxA8Azr7D7BHPPQVesCkWtHAQlYbjgEaGRA9H7jBoX/JW7J4TM4ZZy+JRH3vhxt9VGDotBSyveWVKH3/o8QMY3h89T7yhwJSj3buBzNk2Jr861cPq85Bwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwKU2-0005of-7F; Wed, 10 Sep 2025 15:03:34 +0200
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwKU1-000auH-0t;
	Wed, 10 Sep 2025 15:03:33 +0200
Received: from localhost ([::1] helo=dude05.red.stw.pengutronix.de)
	by dude05.red.stw.pengutronix.de with esmtp (Exim 4.98.2)
	(envelope-from <s.kerkmann@pengutronix.de>)
	id 1uwKU1-00000000poj-0snf;
	Wed, 10 Sep 2025 15:03:33 +0200
From: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Date: Wed, 10 Sep 2025 15:03:32 +0200
Subject: [PATCH] wifi: mwifiex: fix endianness handling in
 mwifiex_send_rgpower_table
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-for-next-v1-1-3ee311706231@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIACN3wWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDS0MD3bT8It281IoSXQMDi9QUi1SLRHOTVCWg8oKi1LTMCrBR0bG1tQA
 /w7uOWgAAAA==
X-Change-ID: 20250910-for-next-008ed8e8a74e
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Johannes Berg <johannes.berg@intel.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Kerkmann <s.kerkmann@pengutronix.de>
X-Mailer: b4 0.14.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.kerkmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

The length of the host command is a u16 stored in little endian byte
order, which needs byte order conversion to work correctly on big endian
systems.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/linux-wireless/aLqZI4FfOI4iJZtf@stanley.mountain
Fixes: 7b6f16a25806 ("wifi: mwifiex: add rgpower table loading support")
Signed-off-by: Stefan Kerkmann <s.kerkmann@pengutronix.de>
---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index 91d5098081e8b97420322484a229654c026e4618..dcca71158fc682902c0bd3376da32e81f8f6561f 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -1537,7 +1537,7 @@ int mwifiex_send_rgpower_table(struct mwifiex_private *priv, const u8 *data,
 		}
 
 		if (*pos == '}' && start_raw) {
-			memcpy(&hostcmd->len, &hostcmd->cmd[2], sizeof(u16));
+			hostcmd->len = get_unaligned_le16(&hostcmd->cmd[2]);
 			ret = mwifiex_send_cmd(priv, 0, 0, 0, hostcmd, false);
 			if (ret) {
 				mwifiex_dbg(adapter, ERROR,

---
base-commit: e3ac93e9d916ebae0711a42f524429dad89c4887
change-id: 20250910-for-next-008ed8e8a74e

Best regards,
-- 
Stefan Kerkmann <s.kerkmann@pengutronix.de>


