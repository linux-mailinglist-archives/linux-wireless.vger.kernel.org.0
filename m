Return-Path: <linux-wireless+bounces-11974-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469B495EF5B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 13:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4332B23319
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 11:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094231514F8;
	Mon, 26 Aug 2024 11:01:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F9817C9AD
	for <linux-wireless@vger.kernel.org>; Mon, 26 Aug 2024 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724670107; cv=none; b=eRYOnRNAoJ5FscUzLIans4ncrjTwGkE02P2HCE9pgXGGeFEAYStWVrg9DFxQ//NcLXVY1wgxi0uj1IV+81YJDt4xsTQ2TGnCvQZ6M75Tx1Seq7oTcUl1E+qZbAkhSKBCj6t/Tz76ES5RT5aRAmTdwLYjpz1KBBb3gBEEZpwkiE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724670107; c=relaxed/simple;
	bh=XCv9DbDDnLpAdoPTfTvW8KEmMqcmziLXCjJSsMKKM74=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bdkzAIa/iFa1JRLCpv7n+w7EyUQeiGXQGI3ZT7Jx25z7xS6N/dIzRBgd/6F7EDX1/OiWtwxlPBfIBN3z/EFn/Kr3WeGdCo8HFs9tJxZEmb8ThmJuWxK7jbG6/QFFaR6m3Js/pSbICJwxpuPtfXomer8jCqLlZ+Wx8xPSjETMkSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTY-00047T-JG; Mon, 26 Aug 2024 13:01:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-003Ae3-Ur; Mon, 26 Aug 2024 13:01:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1siXTX-004aRi-2p;
	Mon, 26 Aug 2024 13:01:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 00/12] mwifiex: two fixes and cleanup
Date: Mon, 26 Aug 2024 13:01:21 +0200
Message-Id: <20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJgzGYC/x3MSQqAMAxA0atI1gZqHfEq4qLWRANapcUBxLtbX
 L7F/w8E8kIB2uQBT6cE2VxEliZgZ+MmQhmjQStdqEZXuF7CQjfahYw7dsxwKFVe2poNcwWx2z2
 x3P+z69/3A8IcFXBjAAAA
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724670091; l=2326;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=XCv9DbDDnLpAdoPTfTvW8KEmMqcmziLXCjJSsMKKM74=;
 b=jXMrf9s0nu7jrqA/8pLiO3WcuF4zRG0auyEspfIknHh/ZTS3c6PksaaHvE7rQlV5KjCws5Io5
 9LkJpoOZboXAUZr+vBSfJfcEzEyOxvq6bquP5R1EpC05NZzwDRGZd37
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

These are a few patches broken out from [1]. Kalle requested to limit
the number of patches per series to approximately 12 and Francesco to
move the fixes to the front of the series, so here we go.

First two patches are fixes. First one is for host mlme support which
currently is in wireless-next, so no stable tag needed, second one has a
stable tag.

The remaining patches except the last one I have chosen to upstream
first. I'll continue with the other patches after having this series
in shape and merged.

The last one is a new patch not included in [1].

Sascha

[1] https://lore.kernel.org/all/20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de/

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (12):
      wifi: mwifiex: add missing locking
      wifi: mwifiex: fix MAC address handling
      wifi: mwifiex: deduplicate code in mwifiex_cmd_tx_rate_cfg()
      wifi: mwifiex: use adapter as context pointer for mwifiex_hs_activated_event()
      wifi: mwifiex: drop unnecessary initialization
      wifi: mwifiex: make region_code_mapping_t const
      wifi: mwifiex: pass adapter to mwifiex_dnld_cmd_to_fw()
      wifi: mwifiex: simplify mwifiex_setup_ht_caps()
      wifi: mwifiex: fix indention
      wifi: mwifiex: make locally used function static
      wifi: mwifiex: move common settings out of switch/case
      wifi: mwifiex: drop asynchronous init waiting code

 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 38 ++++------
 drivers/net/wireless/marvell/mwifiex/cfp.c      |  4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 76 +++++++-------------
 drivers/net/wireless/marvell/mwifiex/init.c     | 19 ++---
 drivers/net/wireless/marvell/mwifiex/main.c     | 94 +++++++++----------------
 drivers/net/wireless/marvell/mwifiex/main.h     | 16 ++---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  | 49 ++++---------
 drivers/net/wireless/marvell/mwifiex/txrx.c     |  3 +-
 drivers/net/wireless/marvell/mwifiex/util.c     | 22 +-----
 drivers/net/wireless/marvell/mwifiex/wmm.c      | 12 ++--
 10 files changed, 105 insertions(+), 228 deletions(-)
---
base-commit: 67a72043aa2e6f60f7bbe7bfa598ba168f16d04f
change-id: 20240826-mwifiex-cleanup-1-b5035c7faff6

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


