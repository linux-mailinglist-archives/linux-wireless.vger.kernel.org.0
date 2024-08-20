Return-Path: <linux-wireless+bounces-11672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECCE95863F
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923201C219B9
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ABD18FDBB;
	Tue, 20 Aug 2024 11:55:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E0F18EFC9
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724154942; cv=none; b=om8Qo3M5ET2xxFD+AMb8ngsv9X345pbiGNf0X1rVxpqoOTOMwCdHcQyLm9PoXWh6afN84BBjXPXLTetU76l8F2XDhGtFSyOIhjVKhLBrxMvMSOlzh2iQ1o3ChdpXpyD8eRrZqCcEy6ZOypDtU5HbD0r/C5rriTBguL/bOHtUsX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724154942; c=relaxed/simple;
	bh=khAeZ+MRR58SCVMnUFeHAJQzYr9LEtflj5hFQc7AOps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V/040MDS99/p4l8LdXQI9SeJM4sFSz1hdsLOE39Oq/n4D/NWDpE89nzYaMUPjPhvjdZwcxk9cgQvQ3/BglCWFBkMU625uU8P+ZFUbnsrTz4+i2Sgl8vS30wJQmAhynpoqPgn18H/ziNGm5zrQBoVHpX1zZHn8WY5SFGu278brcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSS-0000Ae-5U; Tue, 20 Aug 2024 13:55:28 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-001lLe-DA; Tue, 20 Aug 2024 13:55:27 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sgNSR-00GnIQ-14;
	Tue, 20 Aug 2024 13:55:27 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 00/31] wifi: mwifiex: cleanup driver
Date: Tue, 20 Aug 2024 13:55:25 +0200
Message-Id: <20240820-mwifiex-cleanup-v1-0-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC6ExGYC/x3MQQqAIBBA0avErBN0yMiuEi1EpxooC6USorsnL
 d/i/wcSRaYEffVApIsT76FA1RW4xYaZBPtiQImN7FCK7eaJKQu3kg3nISxqbTwaahVCqY5IE+f
 /OIzv+wHD58JbYQAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724154927; l=6186;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=khAeZ+MRR58SCVMnUFeHAJQzYr9LEtflj5hFQc7AOps=;
 b=Ecx3MhiRKZWDlmpK0HKYTA2zxAWBFuCdMCdWHSs8nrhFDrE3Hgm+OWZL/4MVBt0KF/7iw1DdW
 5qeMHbb/LF7Awr31/xMlaLLyVfRAjReXbuF6UogGyvthktCTnbGhauH
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This series has a bunch of cleanup and bugfix patches for the mwifiex
driver.

There's one topic which goes through the whole series: an instance of
the mwifiex driver is referred to as an adapter (struct
mwifiex_adapter).  An adapter has an array of struct mwifiex_private
pointers, each of them belongs to a virtual interface. Many functions
throughout the driver take a struct mwifiex_private * as context, but
are not specific to a virtual interface, but affect the whole adapter.
In many places where a priv * is needed but none is available the code
obtains a priv * by doing a:

	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_ANY);

Depending on where it is used this is either a bug or could at least be
cleaned up. The driver currently has the send command function

int mwifiex_send_cmd(struct mwifiex_private *priv, u16 cmd_no,
                     u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync)

This series introduces a second send command function which takes the
adapter as context:

int mwifiex_adapter_send_cmd(struct mwifiex_adapter *adapter, u16 cmd_no,
                             u16 cmd_action, u32 cmd_oid, void *data_buf, bool sync)

Many places in the driver are converted to use this function instead and
are also converted to take a struct mwifiex_adapter * as context
themselves which makes the code better readable.

Some places use this to obtain a priv *:

	priv = mwifiex_get_priv(adapter, MWIFIEX_BSS_ROLE_STA);

This will return the first priv that is configured for station mode.
Depending on the driver configuration there can be none or many privs in
station mode, so priv can unexpectedly be NULL or in case there are
multiple privs in station mode we might have to iterate over all of
them. This is cleaned up in this series.

The remaining patches are driveby catches I found when looking through
the code.

One patch worth mentioning here is "wifi: mwifiex: fix MAC address
handling".  Without it the mwifiex driver sets a new MAC address during
a change_virtual_intf operation which is pretty unexpected by userspace
and keeps the driver from working when a virtual interface is altered
from its default mode it is initialized with.

I've already sent "wifi: mwifiex: remove unnecessary priv checks" as a
separate patch, I included here again as this series depends on it, but
it's unchanged to the version I have sent earlier.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (31):
      wifi: mwifiex: remove unnecessary checks for valid priv
      wifi: mwifiex: use adapter as context pointer for mwifiex_hs_activated_event()
      wifi: mwifiex: drop HostCmd_CMD_802_11_MAC_ADDRESS response handling
      wifi: mwifiex: drop unnecessary initialization
      wifi: mwifiex: make region_code_mapping_t const
      wifi: mwifiex: use mwifiex_deauthenticate_all()
      wifi: mwifiex: pass adapter to mwifiex_dnld_cmd_to_fw()
      wifi: mwifiex: simplify mwifiex_setup_ht_caps()
      wifi: mwifiex: deduplicate code in mwifiex_cmd_tx_rate_cfg()
      wifi: mwifiex: fix indention
      wifi: mwifiex: use priv index as bss_num
      wifi: mwifiex: fix MAC address handling
      wifi: mwifiex: drop driver internal AP/STA limit counting
      wifi: mwifiex: iterate over privs in mwifiex_process_assoc_resp()
      wifi: mwifiex: add missing locking
      wifi: mwifiex: make locally used function static
      wifi: mwifiex: fix multiple station handling
      wifi: mwifiex: make mwifiex_enable_hs() safe for multiple station mode
      wifi: mwifiex: add function to send command specific to the adapter
      wifi: mwifiex: pass adapter to host sleep functions
      wifi: mwifiex: associate tx_power to the adapter
      wifi: mwifiex: pass adapter to mwifiex_init_shutdown_fw()
      wifi: mwifiex: pass adapter to mwifiex_disable_auto_ds()
      wifi: mwifiex: make txpwr specific to adapter
      wifi: mwifiex: return error on unexpected bss_num
      wifi: mwifiex: coalesce rules are adapter specific
      wifi: mwifiex: do not use mwifiex_get_priv() in mwifiex_dnld_sleep_confirm_cmd()
      wifi: mwifiex: move rx_ant/tx_ant to adapter
      wifi: mwifiex: pass adapter to mwifiex_fw_dump_event()
      wifi: mwifiex: move common settings out of switch/case
      wifi: mwifiex: allow to set MAC address in add_virtual_intf()

 drivers/net/wireless/marvell/mwifiex/11n.c         |   2 -
 drivers/net/wireless/marvell/mwifiex/11n.h         |   4 +-
 .../net/wireless/marvell/mwifiex/11n_rxreorder.c   |  23 +-
 drivers/net/wireless/marvell/mwifiex/cfg80211.c    | 297 ++++-----------------
 drivers/net/wireless/marvell/mwifiex/cfp.c         |   4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c      | 123 +++++----
 drivers/net/wireless/marvell/mwifiex/debugfs.c     |   8 +-
 drivers/net/wireless/marvell/mwifiex/decl.h        |  10 -
 drivers/net/wireless/marvell/mwifiex/init.c        |  76 ++----
 drivers/net/wireless/marvell/mwifiex/join.c        |   3 +-
 drivers/net/wireless/marvell/mwifiex/main.c        | 120 +++------
 drivers/net/wireless/marvell/mwifiex/main.h        | 112 +++-----
 drivers/net/wireless/marvell/mwifiex/pcie.c        |  10 +-
 drivers/net/wireless/marvell/mwifiex/scan.c        |   2 -
 drivers/net/wireless/marvell/mwifiex/sdio.c        |   9 +-
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c     |  53 ++--
 drivers/net/wireless/marvell/mwifiex/sta_cmdresp.c |  70 ++---
 drivers/net/wireless/marvell/mwifiex/sta_event.c   |   3 +-
 drivers/net/wireless/marvell/mwifiex/sta_ioctl.c   |  60 ++---
 drivers/net/wireless/marvell/mwifiex/txrx.c        |  18 +-
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c     |   2 +-
 drivers/net/wireless/marvell/mwifiex/usb.c         |  18 +-
 drivers/net/wireless/marvell/mwifiex/util.c        |  48 ++--
 drivers/net/wireless/marvell/mwifiex/wmm.c         |  19 +-
 24 files changed, 365 insertions(+), 729 deletions(-)
---
base-commit: daaf0dd0398d5e93b7304f35184ca182ed583681
change-id: 20240820-mwifiex-cleanup-a2559d29e612

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


