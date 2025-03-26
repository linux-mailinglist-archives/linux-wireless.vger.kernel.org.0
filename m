Return-Path: <linux-wireless+bounces-20847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99915A7167A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 13:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E22B1791F8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AC436124;
	Wed, 26 Mar 2025 12:19:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1213A1E1DFF
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742991543; cv=none; b=UqPX/XCg1UqGLONua9mzN6XnSoTQ+hIcLC6QHeSLn3bp8NBctlPyeyvtjgE4EKrBWjfO+2zQ33JqZrWrqXKL+FNlH91XkJE8ckNPlyjP4l/3ljPDLgM+3jhsWZn0bIhmPewc87ouYmCjfQ6P7E72xx+dZ63SRuNdVtwgdJ3R6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742991543; c=relaxed/simple;
	bh=XC+qboCsiOOjLMsuFgsRa+8+JW7ckO4azwS4iUwWNS8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LSgudMZ+nrOSvJH7jRFttwALwgqgOYL/s6L6rTFfawFwQI2r4qh7UyjaBhTYNYjo2vugusv4pBmNJ+fSJYqsLLNjbsA5aAtMoBuGqRb8Pg6iIMCz8Xxlpd4/VXb/FnhJIxbwPlsmLFl9N309rGiKxQU2rNFVDMmLwjiE6xWkZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-0005sh-HM; Wed, 26 Mar 2025 13:18:35 +0100
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiM-001kIr-2N;
	Wed, 26 Mar 2025 13:18:35 +0100
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1txPiN-000aOn-0C;
	Wed, 26 Mar 2025 13:18:35 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH do not merge 0/4] wifi: mwifiex: add iw61x support
Date: Wed, 26 Mar 2025 13:18:30 +0100
Message-Id: <20250326-mwifiex-iw61x-v1-0-ff875ed35efc@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJbw42cC/x2MwQqAIBAFfyX2nGCKRf1KdKhcaw9paKQQ/nvWa
 ZiB9x4I6AkDDNUDHm8K5GyRpq5g3We7ISNdHAQXikvRsiOSIUyMYtsktvSq44uRvJMKyub0aCj
 9fyNo9yXrrg8H+g1hyvkFda0LRXMAAAA=
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mmc@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742991515; l=1915;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=XC+qboCsiOOjLMsuFgsRa+8+JW7ckO4azwS4iUwWNS8=;
 b=Pv6fTiWkqhq7BhJ8zpUKkrzmH1XGDqzV5/57BO539EM4DVkMssQAcI6vgtidNdMqxtCR5dUOQ
 kTWySoIPPBLDdYYCQbladHXHxUSAaIvo9keP7u7bx3YoYsWc58P7Ous
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This series adds iw61x support to the mwifiex driver. It works for me,
but is not yet ready to be merged. Some people showed interest in it, so
I am sending it here.

All testing and review feedback appreciated.

During startup I get these messages:

[   12.078010] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
[   12.078018] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0xff
[   12.078024] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x23e
[   12.078029] mwifiex_sdio mmc1:0001:1: Unknown GET_HW_SPEC TLV type: 0x25c

Not sure what these are about, I can't see these handled in the
downstream mwifiex driver as well. Could also be there is some parsing
error. Nevertheless the driver seems to work.

The series applies to v6.14, but should apply to my mwifiex cleanup
series as well.

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Sascha Hauer (4):
      wifi: mwifiex: release firmware at remove time
      wifi: mwifiex: handle VDLL
      wifi: mwifiex: wait longer for SDIO card status
      wifi: mwifiex: add iw61x support

 drivers/net/wireless/marvell/mwifiex/cmdevt.c    | 86 ++++++++++++++++++++++++
 drivers/net/wireless/marvell/mwifiex/fw.h        | 16 +++++
 drivers/net/wireless/marvell/mwifiex/main.c      |  9 +--
 drivers/net/wireless/marvell/mwifiex/main.h      |  4 ++
 drivers/net/wireless/marvell/mwifiex/sdio.c      | 81 +++++++++++++++++++++-
 drivers/net/wireless/marvell/mwifiex/sdio.h      |  3 +
 drivers/net/wireless/marvell/mwifiex/sta_event.c |  4 ++
 drivers/net/wireless/marvell/mwifiex/uap_event.c |  4 ++
 include/linux/mmc/sdio_ids.h                     |  3 +
 9 files changed, 205 insertions(+), 5 deletions(-)
---
base-commit: 1e26c5e28ca5821a824e90dd359556f5e9e7b89f
change-id: 20250326-mwifiex-iw61x-b9570bf30735

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


