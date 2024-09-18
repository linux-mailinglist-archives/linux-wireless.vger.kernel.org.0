Return-Path: <linux-wireless+bounces-12941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BA097BB54
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AE311F25292
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C4D18B475;
	Wed, 18 Sep 2024 11:10:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1256218A932
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726657840; cv=none; b=qnhzZGM/x1bGX5R+E+AW4wwLt687KAEQt6a1UjTJI9MwMkQId7SAZ2ydFY+nYBl9ZI8eBfPDWZpLTSurF2uA/hnDLsnFzE9ujHRwBdZdx0P1Y5Iyo1onVyJuSrkEACnLQeHBOd3YvZrtwYDENdJs+Juh/z+ZW7GhFTv8ej8jwOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726657840; c=relaxed/simple;
	bh=n48xJFwrYkO4gEryicwpdT0e8ci2y59ASdpSx8tDWgE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UOpqhVpB3lgclEpmfbkq3MrLPXf2dUDhNoewJBBDjFSIhtbWJ2JZTmShH9B9EXpz8owxJYsbR5aDW/FzoZ52vCBfZnMOM9r+ZDOVTVCEFCVEbUBb7882aNCAoGO66n8VcWlu1t660d2ew6VSVftqTxsNJ8SV5HkHqOv0SjaV/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZs-0007wb-Ph; Wed, 18 Sep 2024 13:10:32 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-008nT5-Dh; Wed, 18 Sep 2024 13:10:31 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sqsZr-0086AC-13;
	Wed, 18 Sep 2024 13:10:31 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 00/12] mwifiex: two fixes and cleanup
Date: Wed, 18 Sep 2024 13:10:25 +0200
Message-Id: <20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACG16mYC/32NQQ6CMBBFr0Jm7Zi2SiWuvIdhgWUKk2jbtIAY0
 rtbOYCrn/eT//4GiSJTgmu1QaSFE3tXQB0qMGPnBkLuC4MS6iwapfH1Zsu0onlS5+aAEh+1ONX
 mYjtrNZRdiGR53Z33tvDIafLxs18s8tf+sy0SBdaatG1IlDS3QG6Yp+gdr8eeoM05fwE1JswKt
 wAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726657831; l=2809;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=n48xJFwrYkO4gEryicwpdT0e8ci2y59ASdpSx8tDWgE=;
 b=irMk4YppNqDW13IyhY/3LVje0KJTscQm6dDSO9e4q1cQXWz/WePV9EY9LC2wBYZHMekWUbM1O
 KcHra0PKbn7BFFU4SWfpZzbb/b831QVcOnvFhgf3cN6/MjfOUaGsGlW
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
Changes in v2:
- Add refence to 7bff9c974e1a in commit message of "wifi: mwifiex: drop
  asynchronous init waiting code"
- Add extra sentence about bss_started in "wifi: mwifiex: move common
  settings out of switch/case"
- Kill now unused MWIFIEX_BSS_TYPE_ANY
- Collect reviewed-by tags from Francesco Dolcini
- Link to v1: https://lore.kernel.org/r/20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de

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
 drivers/net/wireless/marvell/mwifiex/decl.h     |  1 -
 drivers/net/wireless/marvell/mwifiex/init.c     | 19 ++---
 drivers/net/wireless/marvell/mwifiex/main.c     | 94 +++++++++----------------
 drivers/net/wireless/marvell/mwifiex/main.h     | 16 ++---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  | 49 ++++---------
 drivers/net/wireless/marvell/mwifiex/txrx.c     |  3 +-
 drivers/net/wireless/marvell/mwifiex/util.c     | 22 +-----
 drivers/net/wireless/marvell/mwifiex/wmm.c      | 12 ++--
 11 files changed, 105 insertions(+), 229 deletions(-)
---
base-commit: 67a72043aa2e6f60f7bbe7bfa598ba168f16d04f
change-id: 20240826-mwifiex-cleanup-1-b5035c7faff6

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


