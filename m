Return-Path: <linux-wireless+bounces-10289-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CC9338FF
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 10:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D9DF1C22B8D
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 08:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EBA2033A;
	Wed, 17 Jul 2024 08:30:33 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734BD3BBFB
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 08:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205033; cv=none; b=fUpD6ugkHCBYYGMjPpJO2tcE7I6h84BT7l3/ndY/Cf25OLdeambV3fyKMs4wUzpip6Cpuz2ROeMR2t/fdCm8UbE1joKNUBx8HW8hjEVuctxaKk7oUWMNZPyzxo3xOiFCCxROAfY0gu0mNzja/JCzD5u4e6pj8Ydj6RcmTox+lHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205033; c=relaxed/simple;
	bh=vnhJz+qopGyV0cpp7p6lrYBUbUHzeiKutuFCzmuCVWw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=C83INF+xiJGznDeCz/Yh2XbkyrwzH7vNsBRCg4vLMrAvgQCtUfdlhtyf+jz4OkcYNQNCLSAKtZ60TjNUKehbvI2fsUdPk6aWlm1tkCNXqENAOqjqSusIqa+Ahdn7lygfp7i47nNWk95BIeUSlk07PdlUyccJv+BFLO2jgtaA0X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-00030g-OI; Wed, 17 Jul 2024 10:30:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-000Ae9-6O; Wed, 17 Jul 2024 10:30:20 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sU03I-00COor-0M;
	Wed, 17 Jul 2024 10:30:20 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v2 0/2] mwifiex: add support for WPA-PSK-SHA256
Date: Wed, 17 Jul 2024 10:30:06 +0200
Message-Id: <20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA6Bl2YC/4WNQQ6CMBBFr0Jm7ZhSBKIr72FYtHQKE2NpWoQaw
 t2tXMDle8l/f4NIgSnCrdgg0MKRJ5dBngroR+UGQjaZQQp5EW3Z4Gtly5Rw9Qp9fGIclawblEa
 qq+0rLRoNeewDWU5H+NFlHjnOU/gcP0v5s3+TS4kCRa2oFbZqta7untzwnsPkOJ0NQbfv+xdgQ
 r/nwQAAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721205020; l=842;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=vnhJz+qopGyV0cpp7p6lrYBUbUHzeiKutuFCzmuCVWw=;
 b=qqrnxwxBg2Q8r//8JZShxy8i+w81UOEkV/mzHV6dnQMd06tx/t6DoV6j7J4g3yvHRm1pZaSH6
 fzDs/8ix13kCHBwpeV/egjP924PQQJfopG1GQo8Y6DNqD0sLzucw220
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org

This series adds support for the WPA-PSK AKM suite with SHA256 as hashing
method (WPA-PSK-SHA256)

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes in v2:
- set bss_config->protocol to zero to make the code clearer
- Link to v1: https://lore.kernel.org/r/20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de

---
Sascha Hauer (2):
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: add support for WPA-PSK-SHA256

 drivers/net/wireless/marvell/mwifiex/fw.h      |  1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 31 +++++++++-----------------
 2 files changed, 12 insertions(+), 20 deletions(-)
---
base-commit: 0c3836482481200ead7b416ca80c68a29cfdaabd
change-id: 20240716-mwifiex-wpa-psk-sha256-2d2a9fc3b06b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


