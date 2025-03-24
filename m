Return-Path: <linux-wireless+bounces-20756-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4C2A6DB4C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 14:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A19B51890698
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 13:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0F6261366;
	Mon, 24 Mar 2025 13:24:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C790B25EFB9
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 13:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742822675; cv=none; b=QKKhZ4sx4i5lEWICSBm7N0T3MhdAD7ArTT+o39HYtlqAVEmSxNnj9AOA3E36FoEFUKGbQVJO+TMbpp9yypp8u5WwHSriZDRUoI/178BpOkRrJfcysLKh6k5t/c7mK8aDw5Knt+M3b+Vy9zd0KEv+eqHSYniWsLvyyz5n9sBYuHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742822675; c=relaxed/simple;
	bh=MxFbOX8Cs1Sy9jrRj60xk0ifXGCaWBeo/9SKCDM64ic=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z4mFDi89xWb9+SCJRWPU3MZTwKTKq8j849b9o1jgJ+Xu54i8miW0CKlKSkxzxuA1KvDT6bu+Jfx69O7/cy7+IrauFtpjXWNzPm6KLXq8npStNdUU8xkRbfL5I5nfYWBEEK+MLgDWZI/9+8z/It3xYtY3fymlP29H0M7RwLic2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhmm-0003sF-72; Mon, 24 Mar 2025 14:24:12 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhmk-001PyK-3D;
	Mon, 24 Mar 2025 14:24:11 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1twhml-004Vqr-11;
	Mon, 24 Mar 2025 14:24:11 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH wireless-next v5 00/10] mwifiex: cleanups
Date: Mon, 24 Mar 2025 14:24:01 +0100
Message-Id: <20250324-mwifiex-cleanup-1-v5-0-1128a2be02af@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPJc4WcC/33QwWrDMAwA0F8pPs/DluMk3Wn/MXZwbLkVdE6w0
 zSl5N8rAtsOM7tICElPoIcomAmLeDs8RMaFCo2JC/tyEP7s0gklBa4FKGhUD638ulEkXKW/oEv
 XSWo5WGWs76KLsRW8N2WMtO7mh7hRxguWIhOus/jk9pnKPOb7fnHR+9A/+KKlkrbFNvaoOPv3C
 dPpOucx0foacCcX+GWOuq8xwAwEZY+d7rtg6oz5YTSHGmOYMbpzrUcVgh2qTPPN8GNA15iGmcY
 ZGEAjWGv+MNu2PQENz6V6mwEAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lin <yu-hao.lin@nxp.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742822651; l=2914;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=MxFbOX8Cs1Sy9jrRj60xk0ifXGCaWBeo/9SKCDM64ic=;
 b=p6d2ToZVw8IAOz2e8VKe+nP/LB112DQOBIIu1CwQ/n2idXKoIdQTFN0ARvXC3EJWMFpe5CQiH
 2PxpTZOno8ECOYJQn6/zs/KGxEZGNEMsveFiuQnGaP1zNrPepQI9lgy
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This contains several cleanup patches for the mwifiex driver. I dropped
the MAC address fixing patch this time as it needs more discussion, but
the remaining patches sent here are nearly unchanged from v1 and should
be good to go.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
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
Sascha Hauer (10):
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

 drivers/net/wireless/marvell/mwifiex/cfg80211.c | 34 ++++--------
 drivers/net/wireless/marvell/mwifiex/cfp.c      |  4 +-
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 74 ++++++++-----------------
 drivers/net/wireless/marvell/mwifiex/init.c     | 18 ++----
 drivers/net/wireless/marvell/mwifiex/main.c     | 40 ++-----------
 drivers/net/wireless/marvell/mwifiex/main.h     | 11 +---
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  | 49 +++++-----------
 drivers/net/wireless/marvell/mwifiex/txrx.c     |  3 +-
 drivers/net/wireless/marvell/mwifiex/util.c     | 20 +------
 drivers/net/wireless/marvell/mwifiex/wmm.c      | 12 ++--
 10 files changed, 71 insertions(+), 194 deletions(-)
---
base-commit: 1794d7ab34d2221ac7eb921b171e75b856e10561
change-id: 20240826-mwifiex-cleanup-1-b5035c7faff6

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


