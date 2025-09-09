Return-Path: <linux-wireless+bounces-27194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5FCB507F9
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A67616A4F5
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 21:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81AD2236EE;
	Tue,  9 Sep 2025 21:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="N4vrECvh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E0A1C68F;
	Tue,  9 Sep 2025 21:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452841; cv=none; b=NkCaVSbRsqBeSJ6ebdPTOpbIQkaQmbKvYM+PHvkGxKFuBKzoL/aPAGH+7vfJoW6SKMXK6M1N5sZeED4PtXBA4AHIrIdij+nSLbviaTee1oduuSQRrVkhvk1sGLXsemOkUdxksdLjuwrVjuA3mufEHuc0YaiE6+9fz5jaoN+q4pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452841; c=relaxed/simple;
	bh=9pkNsjM+7U141mU4y8J+TOh3saFNJU2p+mbbgMx1efc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u2tmDPWxINm1pTkTYMHde7TRsFUFdsTn8YL914lf6yDk6Btqd/6lf7npLIf9wBz1SLqRkeTjRdDzkmXgbXUwJEdJVOwxV+TDMua2xjT9mssO/T7P48lZQ1oApokLCEqWqoyo5gDnfUKuwdQBBQ61CErXW9ymekkK5HdpJhFU634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=N4vrECvh; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1757452389; bh=9pkNsjM+7U141mU4y8J+TOh3saFNJU2p+mbbgMx1efc=;
	h=From:To:Cc:Subject:Date:From;
	b=N4vrECvhOOordgqYN3J47ijQR+8LEqkAadjSB22Q2aQ4RMjPFRXppoJE56K11B8k2
	 FCBm8gJKyZ7MQgPlcMOhspOjdV6i92zyjsbCAr9R09yl5xlnTqdbKpWiyWZHjm8xjC
	 w+IyqJ3czc6g1KP0jPk3mNsqstIKqIL7dmCCGWTk=
From: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
To: linux-kernel@vger.kernel.org
Cc: Ondrej Jirman <megi@xff.cz>,
	Ping-Ke Shih <pkshih@realtek.com>,
	linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89))
Subject: [PATCH] net: wireless: rtw89: Sleep while waiting for firmware init
Date: Tue,  9 Sep 2025 23:12:51 +0200
Message-ID: <20250909211255.1486851-1-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ondrej Jirman <megi@xff.cz>

This avoids RCU stalls caused by waiting up to 400ms for firmware init.

Signed-off-by: Ondrej Jirman <megi@xff.cz>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 16e59a4a486e..2c034b764a0a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -109,9 +109,9 @@ int rtw89_fw_check_rdy(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type
 	u8 val;
 	int ret;
 
-	ret = read_poll_timeout_atomic(mac->fwdl_get_status, val,
-				       val == RTW89_FWDL_WCPU_FW_INIT_RDY,
-				       1, FWDL_WAIT_CNT, false, rtwdev, type);
+	ret = read_poll_timeout(mac->fwdl_get_status, val,
+				val == RTW89_FWDL_WCPU_FW_INIT_RDY,
+				1, FWDL_WAIT_CNT, false, rtwdev, type);
 	if (ret) {
 		switch (val) {
 		case RTW89_FWDL_CHECKSUM_FAIL:
-- 
2.51.0


