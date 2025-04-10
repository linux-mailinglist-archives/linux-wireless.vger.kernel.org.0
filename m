Return-Path: <linux-wireless+bounces-21384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667AA840A9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 12:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6AD16A91A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Apr 2025 10:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A792280CFB;
	Thu, 10 Apr 2025 10:28:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7381280CE5
	for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 10:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280931; cv=none; b=Tuw8zfpoLaiRZ3ikUZyLn4df96Wag0LARE6i78UcjxsRf1gBLaYUaAO8OXSzEdLOcdAkWo80SKnd4JGzaPAEYVixnkKEWa4KtzEbsFBIB1j4cD2Pl4L+ClLA0OjzFnUU4V7ryaKqqbI7aLuwt2dIqRvnqJtY3AZy0A7RDIyfrtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280931; c=relaxed/simple;
	bh=px6vydZfMizeaqJWazOqRwTB7+QNMQOwwqr1vjLz1kY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AeCYa6DTX05PUXfvxRplh2h2hau9O76BUZvqgwaNqZ+Tq1LE9hIl5dt+CPPKE5i+spSoeBqiQp4cuJapbXj1lsmg9Mx0sgZwsajGcoch6FNEehSABTtJja2JRkGK6/siWVwztR2N2HdgslhEV/USQ86+GTJr0xdy3Sh/2b3+ajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-0003Qz-Io; Thu, 10 Apr 2025 12:28:47 +0200
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-004Fob-15;
	Thu, 10 Apr 2025 12:28:47 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1u2p9L-002cFD-0q;
	Thu, 10 Apr 2025 12:28:47 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/4] wifi: mwifiex: drop asynchronous init waiting code
Date: Thu, 10 Apr 2025 12:28:42 +0200
Message-Id: <20250410-mwifiex-drop-asynchronous-init-v1-0-6a212fa9185e@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFqd92cC/x3NMQ6DMAxA0asgz1hKAqiiV6kYInCKhzrIBkqFu
 DtRx7f8f4KRMhk8qxOUdjbOUuDrCsY5ypuQp2IILnSu9Q4/X05MB06aF4z2k3HWLHkzZOEVo0+
 haXrXd/EBJbIoJT7+g9dwXTeBScjwcAAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744280927; l=1239;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=px6vydZfMizeaqJWazOqRwTB7+QNMQOwwqr1vjLz1kY=;
 b=jqpueZK5XG8GgQCAVSvDuThzRADMGHjQKadneHDuefcyrv1da4zNH8htXwtnGbYL0MsMUxusA
 eOFlV25ALPxDHha0PhiMXDEqO/iY6IAq9c+AACmGkWCtXbzTjtIjxNC
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This is a spin-off from my mwifiex cleanup series. I have split the
original single patch into a series which hopefully makes the changes
easier to follow and verify.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (4):
      wifi: mwifiex: remove unnecessary queue empty check
      wifi: mwifiex: let mwifiex_init_fw() return 0 for success
      wifi: mwifiex: drop asynchronous init waiting code
      wifi: mwifiex: remove mwifiex_sta_init_cmd() last argument

 drivers/net/wireless/marvell/mwifiex/cfg80211.c |  8 ++++----
 drivers/net/wireless/marvell/mwifiex/cmdevt.c   | 16 ----------------
 drivers/net/wireless/marvell/mwifiex/init.c     | 21 ++++++++-------------
 drivers/net/wireless/marvell/mwifiex/main.c     | 19 ++++---------------
 drivers/net/wireless/marvell/mwifiex/main.h     |  8 +-------
 drivers/net/wireless/marvell/mwifiex/sta_cmd.c  |  8 +-------
 drivers/net/wireless/marvell/mwifiex/util.c     | 18 ------------------
 7 files changed, 18 insertions(+), 80 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250410-mwifiex-drop-asynchronous-init-a1f2339095a7

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


