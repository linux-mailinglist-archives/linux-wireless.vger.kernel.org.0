Return-Path: <linux-wireless+bounces-15820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1A9E0406
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 14:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23ABEB3E210
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Dec 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383D202F92;
	Mon,  2 Dec 2024 12:58:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459FD1FF61A
	for <linux-wireless@vger.kernel.org>; Mon,  2 Dec 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733144295; cv=none; b=sjG07Q5hBioXOysCCjlUQkJ1zcVYAepmnxosG9720wd00D95eIvjU1pSGJgIM0TcwSpw/PLtawcMbH7RkxFyb8Z0KVs6CdUNRcAGmYjXRNnNwnyzXvkqK6nkchLuPchu1WBZJD6MiAd3aPBPN+fx7nvC+exdpQK/F5quAwGJOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733144295; c=relaxed/simple;
	bh=SJtOgMh+YH8aqBoI4uVh/lP5ajaNJaw0NU/zTSDHIeA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hq+DMW6kdD03AHtXNdbFRbOAct/4fs2nOnFfIGU4AQrDP33FODAnw5DJF2yBATww/KDmuz7e1lV8WynGecZ8V75XhC5S5Q7pQVvQFSetRczGZiEc6ppf9XbTFHiMV061mFi+pltM11kzpN5SgrxcF6bP+SN4ZyqynZPC8sogldo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI608-0000ZR-NJ; Mon, 02 Dec 2024 13:58:08 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-001IdJ-0r;
	Mon, 02 Dec 2024 13:58:08 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1tI607-00Boj9-36;
	Mon, 02 Dec 2024 13:58:07 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v3 00/12] mwifiex: two fixes and cleanup
Date: Mon, 02 Dec 2024 13:57:59 +0100
Message-Id: <20241202-mwifiex-cleanup-1-v3-0-317a6ce0dd5b@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANeuTWcC/33NwQ7CIAyA4VdZOIsBJgw9+R7Gw4SyNVG2wIYzy
 95dtosHjafmb9KvM4kQECI5FTMJkDBi53OUu4KYtvYNULS5iWDiwLRQ9PFEhzBRc4fajz3l9CZ
 ZKU3laucUyXd9AIfTZl6uuVuMQxde24vE1+0/LXHKqFSgnAaWpzn34JtxCJ3HaW+BrGQSH+bI9
 S9GZEZYJo8V15Utv5llWd5GArFw/gAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lin <yu-hao.lin@nxp.com>, kernel@pengutronix.de, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733144287; l=3117;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=SJtOgMh+YH8aqBoI4uVh/lP5ajaNJaw0NU/zTSDHIeA=;
 b=ztH142WoMDQz+ldqp3QhDoJmgsvc7iwNbYG1kuSIcgQjvxcpLWMJnhiLXrHxQUO0m5lOzIJgQ
 eIxqEzpJQ0mBBJawWX5AjnrqsTakbAuuzn/7767XoLZSqWfQ4GSZgHr
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


