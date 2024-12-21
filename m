Return-Path: <linux-wireless+bounces-16696-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB29FA0AB
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 13:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2D518874DC
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Dec 2024 12:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16FD71F37A8;
	Sat, 21 Dec 2024 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b="vRS+dlEE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.eurecom.fr (smtp.eurecom.fr [193.55.113.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A1C1F8EEE;
	Sat, 21 Dec 2024 12:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.55.113.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734785111; cv=none; b=KtcM9ljqc3ouGta/BUHsjWDjccwmUHGtoi08ID0pGbVBEmhiBJ5k+rNdHNq4kKrDx74np1pQpFRFnUeWr5X6zV6yTqrEvBv8ZLdtieASRub5/mhjdz9d0cNCsdqZtMTnBg0unWZohcfOVrVO5ds/dMwEJpR+DI/y/LC5Eyniu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734785111; c=relaxed/simple;
	bh=kBniuSemJwine9YgCommCjTTNhZ3R3gt4QvlzZXqx6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I87JFG6UMHHj9UXsZAW11tfnXuU5Jw42pGMIe74yXw+RWTKNcV6K+ddBFsyjtT4dOUHU1yS1ZfOQeUbUwPZzdiDjfgsmdKV5mk1R8T8rPfQCBUELH+1CiyMtfQjQTciO1KZOJpMNtY8bHvTzyWkLZbOjDv0zdqSNivRbwVHkgzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=eurecom.fr; dkim=pass (1024-bit key) header.d=eurecom.fr header.i=@eurecom.fr header.b=vRS+dlEE; arc=none smtp.client-ip=193.55.113.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eurecom.fr
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=eurecom.fr; i=@eurecom.fr; q=dns/txt; s=default;
  t=1734785109; x=1766321109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kBniuSemJwine9YgCommCjTTNhZ3R3gt4QvlzZXqx6U=;
  b=vRS+dlEEkezhQvMzJieERD+NEqlB7kexz1un2LJmQqNM/1cZfeXLXVzC
   1aU/vj4uLP9jLkR6GPI5cbKHLONArqNPIkjqbAuJgdUZlan69pv1/1jTI
   pI3M4wTQUuK6CrRjmygrisuk0dlBhwuXQ+ow9u5+hHhxLhGti8dY7Ipq7
   w=;
X-CSE-ConnectionGUID: +qc0XaWRRGaWb3StuwkT4A==
X-CSE-MsgGUID: VYMoo59ERSyXN6Vlm2YDxg==
X-IronPort-AV: E=Sophos;i="6.12,253,1728943200"; 
   d="scan'208";a="28286106"
Received: from waha.eurecom.fr (HELO smtps.eurecom.fr) ([10.3.2.236])
  by drago1i.eurecom.fr with ESMTP; 21 Dec 2024 13:45:08 +0100
Received: from localhost.localdomain (88-183-119-157.subs.proxad.net [88.183.119.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtps.eurecom.fr (Postfix) with ESMTPSA id 069C42512;
	Sat, 21 Dec 2024 13:45:07 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Kalle Valo <kvalo@kernel.org>
Subject: [PATCH 1/2] rt2x00: Remove unusued value
Date: Sat, 21 Dec 2024 13:39:32 +0100
Message-ID: <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coverity-ID: 1525307
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index 60c2a12e9d5e..e5f553a1ea24 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -8882,13 +8882,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
 
 	for (ch_idx = 0; ch_idx < 2; ch_idx = ch_idx + 1) {
 		if (ch_idx == 0) {
-			rfval = rfb0r1 & (~0x3);
 			rfval = rfb0r1 | 0x1;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
-			rfval = rfb0r2 & (~0x33);
 			rfval = rfb0r2 | 0x11;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
-			rfval = rfb0r42 & (~0x50);
 			rfval = rfb0r42 | 0x10;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
 
@@ -8901,13 +8898,10 @@ static void rt2800_rxiq_calibration(struct rt2x00_dev *rt2x00dev)
 
 			rt2800_bbp_dcoc_write(rt2x00dev, 1, 0x00);
 		} else {
-			rfval = rfb0r1 & (~0x3);
 			rfval = rfb0r1 | 0x2;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 1, rfval);
-			rfval = rfb0r2 & (~0x33);
 			rfval = rfb0r2 | 0x22;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 2, rfval);
-			rfval = rfb0r42 & (~0x50);
 			rfval = rfb0r42 | 0x40;
 			rt2800_rfcsr_write_bank(rt2x00dev, 0, 42, rfval);
 
-- 
2.47.1


