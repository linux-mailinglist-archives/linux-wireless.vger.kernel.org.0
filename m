Return-Path: <linux-wireless+bounces-21741-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0AA93E5C
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 21:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D730464D49
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 19:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CC21CC64;
	Fri, 18 Apr 2025 19:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=etylix.me header.i=@etylix.me header.b="5ZUImbyP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward401d.mail.yandex.net (forward401d.mail.yandex.net [178.154.239.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A3E217654
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 19:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745005272; cv=none; b=DVSh6/DS4WcyABF33AghQmFEi97S6OJrPGGbCx1WNOlV1arzs5Z8rWoMyxjr2CgpBuAS1Cx74XkVAhOoCKTBc2QM3yqKo2L/cX8FenVACYGEeYalmYnMtPlSwsUg8Q2352neARnRb3z+1EVpgVo0OOCvdb683lPqMRAEx2uT54U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745005272; c=relaxed/simple;
	bh=1dVeZmkYilsLt/NacfA2GqrKH0eFxeZeegPp2+b4q54=;
	h=From:To:Cc:Subject:MIME-Version:Date:Message-Id:Content-Type; b=VudSBC595jYWZVjxQX0q8Pg9ZQOSYg3kvKpa3TZdlXwUUGkMxZ+RSw2zaz41bSj73ac7OAAcvfpsSROnD15gbnsg8IqWGp/VnGF7RM+C6jhtpwqSI3h75s3JzeKJ3qKSYR2+Ub9qLxfdL7Q5L76JowdFWRGJmjp8LvniIsu6Mig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etylix.me; spf=pass smtp.mailfrom=etylix.me; dkim=pass (1024-bit key) header.d=etylix.me header.i=@etylix.me header.b=5ZUImbyP; arc=none smtp.client-ip=178.154.239.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etylix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etylix.me
Received: from mail-nwsmtp-mxback-production-main-46.klg.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-46.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:7cf:0:640:f67c:0])
	by forward401d.mail.yandex.net (Yandex) with ESMTPS id 26F66627AE;
	Fri, 18 Apr 2025 22:35:30 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c43:4b0f:0:640:cb38:0 [2a02:6b8:c43:4b0f:0:640:cb38:0])
	by mail-nwsmtp-mxback-production-main-46.klg.yp-c.yandex.net (mxback/Yandex) with HTTPS id HYQFXn0L2Cg0-oPnIjwbU;
	Fri, 18 Apr 2025 22:35:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etylix.me; s=mail;
	t=1745004929; bh=Gqf9MNMQv1izUarlmFAo3gQSnimgXjxG/3jtSrbUYSA=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=5ZUImbyPVAolIyFTCGMlPiUQl4kj3QeNnHxaBsjOcQ3amWEYbZJl7017NgVgcl8Tf
	 kOdP0mdPAPQpTJ4aB5wfJgIsgPAxrnzHieXYZ4VERollau2DE1qPJgO0WQiyOSfz0t
	 0ZMDbOLSfa4Ai95ruiTea3amNQsdBQc+bGs7WAyI=
Authentication-Results: mail-nwsmtp-mxback-production-main-46.klg.yp-c.yandex.net; dkim=pass header.i=@etylix.me
Received: by mail-sendbernar-production-main-32.klg.yp-c.yandex.net with HTTP;
	Fri, 18 Apr 2025 22:35:29 +0300
From: Duy Hoang <duy@etylix.me>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Vietnam (VN) for 2025
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Sat, 19 Apr 2025 02:35:29 +0700
Message-Id: <2199341745004929@mail-sendbernar-production-main-32.klg.yp-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

According to [1] and [2]:
- Update frequency range to match with Circular
- Update units from dBm to mW to match values listed in Circular
- Add AUTO-BW flags to allow the use of 160 MHz based on other rules
- Update to allow use of 6 GHz band

Detail:
* 2400 - 2483.5 MHz
  - 200 mW (23 dBm)
* 5150 - 5250 MHz
  - 200 mW (23 dBm)
  - Indoor only
* 5250 - 5350 MHz
  - 200 mW (23 dBm)
  - DFS
* 5470 - 5725 MHz
  - 1000 mW (30 dBm)
  - DFS
* 5725 - 5850 MHz
  - 1000 mW (30 dBm)
* 5925 - 6425 MHz
  - LPI
    * 200 mW (23 dBm)
    * Indoor only
  - VLP
    * 25 mW (14 dBm)
    * Indoor and outdoor

[1] https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.pdf
[2] https://mic.gov.vn/van-ban-phap-luat/25099.htm

Signed-off-by: Hoang Pham Anh Duy <duy@etylix.me>
---
 db.txt | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e331d4f..eb882de 100644
--- a/db.txt
+++ b/db.txt
@@ -2001,12 +2001,16 @@ country VI: DFS-FCC
 	(5490 - 5730 @ 160), (24), DFS
 	(5735 - 5835 @ 80), (30)
 
+# Source:
+# https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.pdf
+# https://mic.gov.vn/van-ban-phap-luat/25099.htm
 country VN: DFS-FCC
-	(2402 - 2482 @ 40), (20)
-	(5170 - 5250 @ 80), (17)
-	(5250 - 5330 @ 80), (24), DFS
-	(5490 - 5730 @ 80), (24), DFS
-	(5735 - 5835 @ 80), (30)
+	(2400 - 2483.5 @ 40), (200 mW)
+	(5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
+	(5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW
+	(5470 - 5725 @ 80), (1000 mW), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (1000 mW), AUTO-BW
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
 
 # Source:
 # http://www.trr.vu/attachments/category/130/GURL_for_Short-range_Radiocommunication_Devices2.pdf
-- 
2.46.0.windows.1

