Return-Path: <linux-wireless+bounces-786-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FE812C93
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 11:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D52E1C2106E
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Dec 2023 10:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5E3A8CD;
	Thu, 14 Dec 2023 10:13:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Dec 2023 02:13:31 PST
Received: from forward204c.mail.yandex.net (forward204c.mail.yandex.net [178.154.239.217])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D01106
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 02:13:31 -0800 (PST)
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward204c.mail.yandex.net (Yandex) with ESMTP id C399565E85
	for <linux-wireless@vger.kernel.org>; Thu, 14 Dec 2023 13:05:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:ae12:0:640:44d8:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTP id 43B4D60B3F;
	Thu, 14 Dec 2023 13:04:37 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id a4hoebBo7iE0-lC6GJWpu;
	Thu, 14 Dec 2023 13:04:36 +0300
X-Yandex-Fwd: 1
Authentication-Results: mail-nwsmtp-smtp-production-main-69.iva.yp-c.yandex.net; dkim=pass
Message-ID: <a0480e18-7b67-4e16-983e-c8f888c97261@16depo.xyz>
Date: Thu, 14 Dec 2023 13:04:36 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kirill Matvienko <me@16depo.xyz>
Subject: [wireless-regdb] [PATCH] Update regulatory info for Armenia (AM)
To: wens@kernel.org
Cc: wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
References: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
Content-Language: en-US
In-Reply-To: <411a77cb-47f1-2f97-76c6-939c024654b4@16depo.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Source:https://www.arlis.am/DocumentView.aspx?DocID=181829

Signed-off-by: Kirill Matvienko <me@16depo.xyz>

---
  db.txt | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/db.txt b/db.txt
index fdc2c13..0708039 100644
--- a/db.txt
+++ b/db.txt
@@ -80,8 +80,8 @@ country AL: DFS-ETSI

  country AM: DFS-ETSI
      (2402 - 2482 @ 40), (20)
-    (5170 - 5250 @ 20), (18)
-    (5250 - 5330 @ 20), (18), DFS
+    (5150 - 5350 @ 80), (100mW)
+    (5470 - 5875 @ 80), (100mW), NO-OUTDOOR,DFS

  country AN: DFS-ETSI
      (2402 - 2482 @ 40), (20)
-- 
2.34.1


