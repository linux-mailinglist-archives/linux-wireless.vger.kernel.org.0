Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C10C31F44B
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfEOMYs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:24:48 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:9723 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfEOMYr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 08:24:47 -0400
X-Greylist: delayed 2025 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 08:24:46 EDT
Received: from bsmtp7.bon.at (unknown [192.168.181.105])
        by bsmtp8.bon.at (Postfix) with ESMTPS id 453tDQ0VvQz5vN9
        for <linux-wireless@vger.kernel.org>; Wed, 15 May 2019 13:51:02 +0200 (CEST)
Received: from [10.2.1.2] (81.89.61.168.host.vnet.sk [81.89.61.168])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 453tDN0vbrz5tl9;
        Wed, 15 May 2019 13:51:00 +0200 (CEST)
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
To:     seth.forshee@canonical.com
From:   Vladimir Koutny <vladimir.koutny@streamunlimited.com>
Subject: [PATCH] wireless-regdb: Update regulatory rules for Japan (JP) on
 5GHz
Openpgp: preference=signencrypt
Message-ID: <82a15f3c-fe0c-a5dc-9846-13b3efb01f0d@streamunlimited.com>
Date:   Wed, 15 May 2019 13:50:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

According to multiple sources channels 8-16 (5030-5090MHz) were only
allowed in Japan until Nov-30, 2017 (later extended to Nov-30, 2018).

https://www.tele.soumu.go.jp/j/adm/system/trunk/wimax/5ghz/index.htm
http://www.dspr.co.jp/wp/wp-content/uploads/2017/10/The-expiration-date-of-some-frequency-of-the-5GHz-band-radio-access-system_eng.pdf

Signed-off-by: Vladimir Koutny <vladimir.koutny@streamunlimited.com>

---
 db.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/db.txt b/db.txt
index 4fb1948..7e10d0d 100644
--- a/db.txt
+++ b/db.txt
@@ -658,7 +658,6 @@ country JP: DFS-JP
 	(2402 - 2482 @ 40), (20)
 	(2474 - 2494 @ 20), (20), NO-OFDM
 	(4910 - 4990 @ 40), (23)
-	(5030 - 5090 @ 40), (23)
 	(5170 - 5250 @ 80), (20), AUTO-BW
 	(5250 - 5330 @ 80), (20), DFS, AUTO-BW
 	(5490 - 5710 @ 160), (23), DFS
-- 
2.11.0

