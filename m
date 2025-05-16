Return-Path: <linux-wireless+bounces-23069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F27AAB985E
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 11:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE6AB7A2CEE
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 09:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F7C224223;
	Fri, 16 May 2025 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=etylix.me header.i=@etylix.me header.b="TIpUGNmv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward202d.mail.yandex.net (forward202d.mail.yandex.net [178.154.239.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5EB1A704B
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 09:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747386594; cv=none; b=SGb2PkbnIYWTX0D59s4lARTllX7OekBGn82/CeMWuHFDXWeQmsrpcrJr/9UaRKCX9/PlFok0mY104Y5TQVXTVYeMX7zzjSdazilbQmj+UKn5eWQ1BLvSxHUcBdUySOh0HZEx48FSQZYChF+PR8T0xowGRBtJYqAmbcK69ul/HAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747386594; c=relaxed/simple;
	bh=9C33aEa5++LNlQ/TNwAjp8rTDVdNw0xI6+APNbsLDOM=;
	h=From:To:Cc:Subject:MIME-Version:Date:Message-Id:Content-Type; b=IXX3QgFnjqi4SewqdCF+LRTV4dvkuQtmNFbwoFgsBxCLONCDsz2cyRZnrn+dWMhXPMJsGRUWMZ9HYv/+OCH8xocBN4umoNDKORI7P1IGUg62gXwTjTUl/3KN9e3S7jWflXKlE2TKXF4Fo9Adr8KAkrswToauDfrl5O8Xm+IvJ1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etylix.me; spf=pass smtp.mailfrom=etylix.me; dkim=pass (1024-bit key) header.d=etylix.me header.i=@etylix.me header.b=TIpUGNmv; arc=none smtp.client-ip=178.154.239.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=etylix.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etylix.me
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward202d.mail.yandex.net (Yandex) with ESMTPS id 433FB66860
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:02:27 +0300 (MSK)
Received: from mail-nwsmtp-mxback-production-main-39.klg.yp-c.yandex.net (mail-nwsmtp-mxback-production-main-39.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:4784:0:640:7e86:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id 49F0A60B04;
	Fri, 16 May 2025 12:02:19 +0300 (MSK)
Received: from mail.yandex.com (2a02:6b8:c43:bc8:0:640:a01e:0 [2a02:6b8:c43:bc8:0:640:a01e:0])
	by mail-nwsmtp-mxback-production-main-39.klg.yp-c.yandex.net (mxback/Yandex) with HTTPS id I2FWFo3L2Sw0-13Witsxj;
	Fri, 16 May 2025 12:02:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etylix.me; s=mail;
	t=1747386138; bh=0Kx9ib+Ofl/vDR5bndogDZ9PCi/VQn+K6y2Dhv2ezE4=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=TIpUGNmvWCVH3lL94cjU2+gunftQQK65xI5513cPLxWSskZfNrA81GMfoQFeN4Pzo
	 q4Nj3iYT+EGAcn1aXsQ/27ZHw/B17leUOtfjoPxTFue9MS8a87wRot0KK7IzV2/vkS
	 w+EplfpQvtENn9AlBzkgN5yBioQQffgTzJbJ5P3k=
Authentication-Results: mail-nwsmtp-mxback-production-main-39.klg.yp-c.yandex.net; dkim=pass header.i=@etylix.me
Received: by mail-sendbernar-production-main-36.klg.yp-c.yandex.net with HTTP;
	Fri, 16 May 2025 12:02:18 +0300
From: Duy Hoang <duy@etylix.me>
To: linux-wireless@vger.kernel.org
Cc: wireless-regdb@lists.infradead.org
Subject: [PATCH v2] wireless-regdb: Update regulatory info for Vietnam (VN) for 2025
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Fri, 16 May 2025 16:02:18 +0700
Message-Id: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
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
  - 100 mW (20 dBm)
  - DFS/TPC
* 5470 - 5725 MHz
  - 500 mW (27 dBm)
  - DFS/TPC
* 5725 - 5850 MHz
  - 1000 mW (30 dBm)
* 5925 - 6425 MHz
  - LPI
    * 200 mW (23 dBm)
    * Indoor only
  - VLP
    * 25 mW (14 dBm)
    * Indoor and outdoor
* 57000 - 66000 MHz
  - 10000 mW

[1] https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.pdf
[2] https://mic.gov.vn/van-ban-phap-luat/25099.htm

Signed-off-by: Hoang Pham Anh Duy <duy@etylix.me>
---
Patch v2:
  - Since Linux does not support TPC, reduce 5250 - 5350 MHz to 100 mW and 5470 - 5725 MHz to 500mW
  - Add AUTO-BW for 6GHz band
  - Add 60GHz
---
 db.txt | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e331d4f..4e9539b 100644
--- a/db.txt
+++ b/db.txt
@@ -2001,12 +2001,17 @@ country VI: DFS-FCC
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
+	(5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
+	(5470 - 5725 @ 80), (500 mW), DFS, AUTO-BW
+	(5725 - 5850 @ 80), (1000 mW), AUTO-BW
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
+	(57000 - 66000 @ 2160), (10000 mW), NO-OUTDOOR
 
 # Source:
 # http://www.trr.vu/attachments/category/130/GURL_for_Short-range_Radiocommunication_Devices2.pdf
-- 
2.46.0.windows.1

