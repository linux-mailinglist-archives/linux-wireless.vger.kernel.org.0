Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF36C89CD
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Mar 2023 02:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjCYBKB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Mar 2023 21:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCYBKA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Mar 2023 21:10:00 -0400
X-Greylist: delayed 313 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 18:09:58 PDT
Received: from forward103o.mail.yandex.net (forward103o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A77271F
        for <linux-wireless@vger.kernel.org>; Fri, 24 Mar 2023 18:09:57 -0700 (PDT)
Received: from forward204a.mail.yandex.net (forward204a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d204])
        by forward103o.mail.yandex.net (Yandex) with ESMTP id C2B3210A8982
        for <linux-wireless@vger.kernel.org>; Sat, 25 Mar 2023 04:04:42 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:170e:0:640:d60c:0])
        by forward204a.mail.yandex.net (Yandex) with ESMTP id E270C42322;
        Sat, 25 Mar 2023 04:04:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id b429bIKDdGk0-UgqGVDXw;
        Sat, 25 Mar 2023 04:04:38 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-64.vla.yp-c.yandex.net; dkim=pass
Message-ID: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
Date:   Sat, 25 Mar 2023 04:04:37 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
From:   Kirill <me@16depo.xyz>
Subject: [wireless-regdb] [PATCH] Update regulatory info for Russia (RU) on
 6GHz
To:     sforshee@kernel.org
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Update regulatory info for Russia on 6GHz in
  accordance with current regulatory rules.

Source: https://docs.cntd.ru/document/1300597464?section=text

Signed-off-by: Kirill Matvienko <me@16depo.xyz>
---
  db.txt | 3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/db.txt b/db.txt
index 915a3b9..7f338b2 100644
--- a/db.txt
+++ b/db.txt
@@ -1500,11 +1500,12 @@ country RS: DFS-ETSI
  	# 60 GHz band channels 1-4, ref: Etsi En 302 567
  	(57000 - 66000 @ 2160), (40)

-# Source: https://docs.cntd.ru/document/902048009?section=text
+# Source: https://docs.cntd.ru/document/1300597464?section=text
  country RU: DFS-ETSI
  	(2400 - 2483.5 @ 40), (20)
  	(5150 - 5350 @ 160), (100 mW), NO-OUTDOOR, DFS
  	(5650 - 5850 @ 160), (100 mW), NO-OUTDOOR, DFS
+	(5925 - 6425 @ 160), (100 mW), NO-OUTDOOR
  	# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order 
№129_22042015.pdf
  	(57000 - 66000 @ 2160), (40), NO-OUTDOOR

-- 
2.34.1
