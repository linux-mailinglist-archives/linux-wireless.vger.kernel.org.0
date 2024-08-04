Return-Path: <linux-wireless+bounces-10888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F9946CBD
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 08:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB7B1C20A2B
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Aug 2024 06:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998A2B67E;
	Sun,  4 Aug 2024 06:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="eR0T9x1A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA092138C;
	Sun,  4 Aug 2024 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722753254; cv=none; b=nvW+oTy1MZbEZ+C/OwwWT4ZQpumi/Y9nZnBjmXqNoQuwopUy2gNZRDM1g7mULU0X39A7nZqTV+D6kDOd9P0TbGb74YfWeuD3YJDSDOu6PuaLCro8lllT7LlRclMbS68oPgOSEdsDlex0Gf7KeGVOvakQuEQK1IgcXYUzscZ4awg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722753254; c=relaxed/simple;
	bh=65y8B3iOvbetXk0kCT+W0L47KQRUbVSELQc0VBU7qyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYjr/XLHuZoT5NgT6NbWxpOUlBqB2IbTh+htIUZnQiLqlX0riNoFjsmzYrLpRZlVV89kV42MuziFhIcz14SWm6BA7/Hg9DCvAhscepeJRf9KTWRXET58CeghE8JNjWQbNISSBtCqhzgNgd2L14AbHeiU8yufBQCd7uKFAQ9Mhno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=eR0T9x1A; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id aUnWsRt8sxIAraUnXsg7vi; Sun, 04 Aug 2024 08:32:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722753176;
	bh=ICKtRqwRMeEcPWDeXOzQTCYIugTLoMTz+BaFN8kw9aI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eR0T9x1A9eBKugJ1m+0ckxVIsfZK/MVtLvgZbkLKaoza8T2G4hPnRSt95UQ9BCPC5
	 isKyThLcLhp0n68XRz3xuxfgkc9NnVEHMhnfX8rf24lErlbGRECnB+IXkvGk9AiFKs
	 qTxgCkCocn8ckumvG4K4wv83nKGuhou+ElRX61zp+Tsm3xuCF7oTD75I5f+zc4fwS4
	 kXYKQk4sG3gNZcclJPC+SfZSNrtHL/+NLbzh5MJbetlWM1wuLJpwfj56C78w1MFray
	 CnvuKm1JZ56ZaN1t6Ov63NSH3xgm59JrYROlrAHrVbUquc1PwVFiFOxEgx49P/wMnk
	 tWjddY1m1QMZg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 04 Aug 2024 08:32:56 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-wireless@vger.kernel.org,
	b43-dev@lists.infradead.org
Subject: [PATCH v2] wifi: b43: Constify struct lpphy_tx_gain_table_entry
Date: Sun,  4 Aug 2024 08:32:44 +0200
Message-ID: <e33bc9e6dff4a5b6cd8d0ab5399aa1abac5bef9d.1722753127.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

'struct lpphy_tx_gain_table_entry' are not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increase overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  16481	   6232	      0	  22713	   58b9	drivers/net/wireless/broadcom/b43/tables_lpphy.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  22305	    395	      0	  22700	   58ac	drivers/net/wireless/broadcom/b43/tables_lpphy.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested-only.

lpphy_write_gain_table() and lpphy_write_gain_table_bulk() could also be
made static and removed from tables_lpphy.h, but without knowing the reason
why it is done this way, I've preferred to leave it as-is.

Changes in v2:
  - remove unrelated and un-needed constification   [Michael Büsch]
  - update numbers in the commit log

v1: https://lore.kernel.org/all/38528f48c8069187823b774a6b2a53088f6c9599.1721161231.git.christophe.jaillet@wanadoo.fr/
---
 .../net/wireless/broadcom/b43/tables_lpphy.c  | 20 +++++++++----------
 .../net/wireless/broadcom/b43/tables_lpphy.h  |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/tables_lpphy.c b/drivers/net/wireless/broadcom/b43/tables_lpphy.c
index 71a7cd8dc787..fb70a1e3544b 100644
--- a/drivers/net/wireless/broadcom/b43/tables_lpphy.c
+++ b/drivers/net/wireless/broadcom/b43/tables_lpphy.c
@@ -1066,7 +1066,7 @@ static const u32 lpphy_papd_mult_table[] = {
 	0x00036963, 0x000339f2, 0x00030a89, 0x0002db28,
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev0_nopa_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev0_nopa_tx_gain_table[] = {
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 152, },
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 147, },
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 143, },
@@ -1197,7 +1197,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev0_nopa_tx_gain_table[] = {
 	{ .gm = 7, .pga = 11, .pad = 6, .dac = 0, .bb_mult = 71, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev0_2ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev0_2ghz_tx_gain_table[] = {
 	{ .gm = 4, .pga = 15, .pad = 9, .dac = 0, .bb_mult = 64, },
 	{ .gm = 4, .pga = 15, .pad = 9, .dac = 0, .bb_mult = 62, },
 	{ .gm = 4, .pga = 15, .pad = 9, .dac = 0, .bb_mult = 60, },
@@ -1328,7 +1328,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev0_2ghz_tx_gain_table[] = {
 	{ .gm = 4, .pga = 4, .pad = 2, .dac = 0, .bb_mult = 72, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev0_5ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev0_5ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 99, },
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 96, },
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 93, },
@@ -1459,7 +1459,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev0_5ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 11, .pad = 6, .dac = 0, .bb_mult = 60, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev1_nopa_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev1_nopa_tx_gain_table[] = {
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 152, },
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 147, },
 	{ .gm = 7, .pga = 15, .pad = 14, .dac = 0, .bb_mult = 143, },
@@ -1599,7 +1599,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev1_nopa_tx_gain_table[] = {
 	{ .gm = 7, .pga = 11, .pad = 6, .dac = 0, .bb_mult = 71, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev1_2ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev1_2ghz_tx_gain_table[] = {
 	{ .gm = 4, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 90, },
 	{ .gm = 4, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 88, },
 	{ .gm = 4, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 85, },
@@ -1730,7 +1730,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev1_2ghz_tx_gain_table[] = {
 	{ .gm = 4, .pga = 10, .pad = 6, .dac = 0, .bb_mult = 60, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev1_5ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev1_5ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 99, },
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 96, },
 	{ .gm = 7, .pga = 15, .pad = 15, .dac = 0, .bb_mult = 93, },
@@ -1861,7 +1861,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev1_5ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 11, .pad = 6, .dac = 0, .bb_mult = 60, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev2_nopa_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev2_nopa_tx_gain_table[] = {
 	{ .gm = 255, .pga = 255, .pad = 203, .dac = 0, .bb_mult = 152, },
 	{ .gm = 255, .pga = 255, .pad = 203, .dac = 0, .bb_mult = 147, },
 	{ .gm = 255, .pga = 255, .pad = 203, .dac = 0, .bb_mult = 143, },
@@ -1992,7 +1992,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev2_nopa_tx_gain_table[] = {
 	{ .gm = 255, .pga = 111, .pad = 29, .dac = 0, .bb_mult = 64, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev2_2ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev2_2ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 99, .pad = 255, .dac = 0, .bb_mult = 64, },
 	{ .gm = 7, .pga = 96, .pad = 255, .dac = 0, .bb_mult = 64, },
 	{ .gm = 7, .pga = 93, .pad = 255, .dac = 0, .bb_mult = 64, },
@@ -2123,7 +2123,7 @@ static struct lpphy_tx_gain_table_entry lpphy_rev2_2ghz_tx_gain_table[] = {
 	{ .gm = 7, .pga = 13, .pad = 52, .dac = 0, .bb_mult = 64, },
 };
 
-static struct lpphy_tx_gain_table_entry lpphy_rev2_5ghz_tx_gain_table[] = {
+static const struct lpphy_tx_gain_table_entry lpphy_rev2_5ghz_tx_gain_table[] = {
 	{ .gm = 255, .pga = 255, .pad = 255, .dac = 0, .bb_mult = 152, },
 	{ .gm = 255, .pga = 255, .pad = 255, .dac = 0, .bb_mult = 147, },
 	{ .gm = 255, .pga = 255, .pad = 255, .dac = 0, .bb_mult = 143, },
@@ -2392,7 +2392,7 @@ void lpphy_write_gain_table(struct b43_wldev *dev, int offset,
 }
 
 void lpphy_write_gain_table_bulk(struct b43_wldev *dev, int offset, int count,
-				 struct lpphy_tx_gain_table_entry *table)
+				 const struct lpphy_tx_gain_table_entry *table)
 {
 	int i;
 
diff --git a/drivers/net/wireless/broadcom/b43/tables_lpphy.h b/drivers/net/wireless/broadcom/b43/tables_lpphy.h
index 62002098bbda..1971ccccabf8 100644
--- a/drivers/net/wireless/broadcom/b43/tables_lpphy.h
+++ b/drivers/net/wireless/broadcom/b43/tables_lpphy.h
@@ -36,7 +36,7 @@ struct lpphy_tx_gain_table_entry {
 void lpphy_write_gain_table(struct b43_wldev *dev, int offset,
 			    struct lpphy_tx_gain_table_entry data);
 void lpphy_write_gain_table_bulk(struct b43_wldev *dev, int offset, int count,
-				 struct lpphy_tx_gain_table_entry *table);
+				 const struct lpphy_tx_gain_table_entry *table);
 
 void lpphy_rev0_1_table_init(struct b43_wldev *dev);
 void lpphy_rev2plus_table_init(struct b43_wldev *dev);
-- 
2.45.2


