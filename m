Return-Path: <linux-wireless+bounces-10913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909E2947563
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB9F1F218AE
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F0A149C69;
	Mon,  5 Aug 2024 06:39:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1578144D15
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 06:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722839977; cv=none; b=smZjG020rV/lldsxD9iUZchwNb5TdToGrgLVhFBWLFIKfy9C6UNGJFj2h8XgAQV7Mt0yuAcyzmAFCdSNTM9AK84NsyPIG4z2PsOS8SFaYd6e4awios6DpUvWRURq2ou/6NQ/z19lDgG5ngJ89Z0Cl/a6aaFYJktU1L8coGQhcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722839977; c=relaxed/simple;
	bh=Bc3+PFwcmWptmNKT5tJ+mNecn5ENAVBJsZGeMUTWOWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=l0IRIK5ceY7YdGbn6UpHdJqXPRuvcx5Y7WHOBHVGiJCrfi0q6EP0TF122Uax1S2wQ8hQwdzwHNynfymJYm6kimPQqAbdip2gYvWmdQblERByV8EuWxBxwQ/WJZk4X2qiDFFO8EnEAqTsb1pbKSE/8Nq8LzKYdyNzZophryPHqNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNI-00039C-Rg; Mon, 05 Aug 2024 08:39:20 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-004e47-LR; Mon, 05 Aug 2024 08:39:19 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sarNH-000M8i-1t;
	Mon, 05 Aug 2024 08:39:19 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v4 0/3] mwifiex: add support for WPA-PSK-SHA256
Date: Mon, 05 Aug 2024 08:39:12 +0200
Message-Id: <20240805-mwifiex-wpa-psk-sha256-v4-0-e1eee80508e6@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJBzsGYC/4XOwQ6CMAyA4VchOzuzdWyIJ9/DeNhckcYIZEPAE
 N7d4clEjce/Sb92ZhEDYWT7bGYBB4rUNinyTcbOtW0uyMmnZiAgF4U0/DZSRTjxsbO8i1ceawv
 acPBgy+qsnDCOpeUuYEXTCz6eUtcU+zY8XncGuU7/koPkggttsRCVKpxThw6by70PbUPT1iNb3
 QHereKnBclCp5XXYgfOwFdLvVmgflpq/Qu0NDtbSm/lh7UsyxPNCcpSWQEAAA==
To: Brian Norris <briannorris@chromium.org>, 
 Francesco Dolcini <francesco@dolcini.it>, Kalle Valo <kvalo@kernel.org>
Cc: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722839959; l=1265;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Bc3+PFwcmWptmNKT5tJ+mNecn5ENAVBJsZGeMUTWOWo=;
 b=3R1ZvcJ2SKfLWJVunNi+9XjTgYofH71m2KyxCp3AHAkL71pCm1frZYffSwowxL+HIJooyduHe
 kzrkFw+uh0iD5W+ZQtozhhcwU+cnIstivT4xGEpok2z92zz/QelARWB
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
Changes in v4:
- rebase on wireless-next
- fix typo in commit message (safe->save)
- Link to v3: https://lore.kernel.org/r/20240723-mwifiex-wpa-psk-sha256-v3-0-025168a91da1@pengutronix.de

Changes in v3:
- add patch to replace '=' with '|=' in the key_mgmt setting
- Link to v2: https://lore.kernel.org/r/20240717-mwifiex-wpa-psk-sha256-v2-0-eb53d5082b62@pengutronix.de

Changes in v2:
- set bss_config->protocol to zero to make the code clearer
- Link to v1: https://lore.kernel.org/r/20240716-mwifiex-wpa-psk-sha256-v1-0-05ae70f37bb3@pengutronix.de

---
Sascha Hauer (3):
      wifi: mwifiex: simplify WPA flags setting
      wifi: mwifiex: fix key_mgmt setting
      wifi: mwifiex: add support for WPA-PSK-SHA256

 drivers/net/wireless/marvell/mwifiex/fw.h      |  1 +
 drivers/net/wireless/marvell/mwifiex/uap_cmd.c | 35 ++++++++++----------------
 2 files changed, 14 insertions(+), 22 deletions(-)
---
base-commit: 420a549395c24bf9e4755f9fb220ce72b2f4f8bd
change-id: 20240716-mwifiex-wpa-psk-sha256-2d2a9fc3b06b

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


