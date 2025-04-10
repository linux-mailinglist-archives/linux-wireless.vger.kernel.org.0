Return-Path: <linux-wireless+bounces-21374-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE70DA84085
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EF277AE120
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68C4280CCD;
	Thu, 10 Apr 2025 10:24:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE62165E9
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280681; cv=none; b=uDVdzMttjFNBP28Js+HKUGR2d53VAnoumszqxRuKDHHGR//zktgeWYqsHVIIIPIMRJnNuiMpKtOxcMUW9crlLGrRKSed1BhXpKVWBaz5kmJVfLqRaG2wfzUJj+VE/a6y/eaQgMqEg1mI5kVItJpWUYd7rIJffF6qYkxqqXkl8fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280681; c=relaxed/simple;
	bh=b8D2N4Q5sTZrlImnPqXAOkUFUPiKROyT3XTwwuym6Qk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mXCDOOnfAUehj3PXcoXodtHzfmDmPyfywgDLgXlm4KXvhJERFKdqhMWK0o57+flWU835yBcu4We9XZH8JxcXMFnDSjCThLzJKnTK7raQRagJu7PnwmnHaa8w+a7auCnMtzoLMuZ/4bUUsJ5jfJI0NdW9gGWDkRDltfC4QIHgDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5C-0002DC-5j; Thu, 10 Apr 2025 12:24:30 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-004Fmt-2Z;
	Thu, 10 Apr 2025 12:24:28 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p5A-002ODU-2G;
	Thu, 10 Apr 2025 12:24:28 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH wireless-next v6 0/9] mwifiex: cleanups
Date: Thu, 10 Apr 2025 12:24:24 +0200
Message-Id: <20250410-mwifiex-cleanup-1-v6-0-a6bbd4ac4d37@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFic92cC/33QzWrDMAwA4FcpPs/DkmMn7WnvMXZwYrk1dE6w0
 zSj5N0nAvuBmV0khKRPoIcolCMVcTo8RKYlljgmLuzTQQwXl84ko+daoMJGdWjl+z2GSKscruT
 SbZIge6O0GdrgQrCC96ZMIa67+SruMdOVSpGJ1lm8cfsSyzzmj/3iAvvQP/gCUkljyYaOFOfhZ
 aJ0vs15THF99rSTC/4wR+hqDDKDXpljC13rdZ3R3wxwqDGaGQ2tswMp701fZZovhh+DUGMaZhq
 nsUcgNEZXGfObaWqMYQYAO4c9KXThD7Nt2ydcTpPH4gEAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280668; l=2930;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=b8D2N4Q5sTZrlImnPqXAOkUFUPiKROyT3XTwwuym6Qk=;
 b=tOfKZVuD8mJvAgK8bmNtMrWP1uKOwFogNRyYtJ6YbdCzDafdm6v55PXdfLXhczg9nOjocApYn
 5wFumIbXLOADEvUv1FOFGL/HneHbHT6R0et5GT+BHBLt+gwDl7dA3/N
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

Only change this time is that I dropped the last patch which I'll make a
separate series from and added Acks from Brian Norris.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v6:
- Drop "wifi: mwifiex: drop asynchronous init waiting code", will make a
  separate series from it
- Add Acked-by Brian Norris
- Link to v5: https://lore.kernel.org/r/20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de

Changes in v5:
- rebase on wireless-next
- Link to v4: https://lore.kernel.org/r/20250321-mwifiex-cleanup-1-v4-0-4a32b21e2553@pengutronix.de

Changes in v4:
- rebase and test on v6.14-rc7
- drop "wifi: mwifiex: fix MAC address handling" because needs more
  discussion
- Link to v3: https://lore.kernel.org/r/20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de

Changes in v3:
- Remove Cc: stable tag from 02/12 wifi: mwifiex: fix MAC address handling
- Add better reasons for setting the locally admistered bit in 02/12
  wifi: mwifiex: fix MAC address handling
- Link to v2: https://lore.kernel.org/r/20240918-mwifiex-cleanup-1-v2-0-2d0597187d3c@pengutronix.de

Changes in v2:
- Add refence to 7bff9c974e1a in commit message of "wifi: mwifiex: drop
  asynchronous init waiting code"
- Add extra sentence about bss_started in "wifi: mwifiex: move common
  settings out of switch/case"
- Kill now unused MWIFIEX_BSS_TYPE_ANY
- Collect reviewed-by tags from Francesco Dolcini
- Link to v1: https://lore.kernel.org/r/20240826-mwifiex-cleanup-1-v1-0-56e6f8e056ec@pengutronix.de

---
Sascha Hauer (9):
      wifi: mwifiex: deduplicate code in mwifiex_cmd_tx_rate_cfg()
      wifi: mwifiex: use adapter as context pointer for mwifiex_hs_activated_event()
      wifi: mwifiex: drop unnecessary initialization
      wifi: mwifiex: make region_code_mapping_t const
      wifi: mwifiex: pass adapter to mwifiex_dnld_cmd_to_fw()
      wifi: mwifiex: simplify mwifiex_setup_ht_caps()
      wifi: mwifiex: fix indention
      wifi: mwifiex: make locally used function static
      wifi: mwifiex: move common settings out of switch/case

 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 34 +++++----------
 drivers/net/wireless/marvell/mwifiex/cfp.c      |  4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 58 ++++++++++---------------
 drivers/net/wireless/marvell/mwifiex/main.c     | 15 ++-----
 drivers/net/wireless/marvell/mwifiex/main.h     |  5 +--
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  | 43 ++++++------------
 drivers/net/wireless/marvell/mwifiex/txrx.c     |  3 +-
 drivers/net/wireless/marvell/mwifiex/util.c     |  2 +-
 drivers/net/wireless/marvell/mwifiex/wmm.c      | 12 ++---
 9 files changed, 63 insertions(+), 113 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20240826-mwifiex-cleanup-1-b5035c7faff6

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


