Return-Path: <linux-wireless+bounces-11119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7580994B98B
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 11:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B321F21B1C
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 09:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499CE14659F;
	Thu,  8 Aug 2024 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVWZtWQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE92575F
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723108592; cv=none; b=CMVed73SGGpezZlW/r0Qi/gRIE4TGcrfvilhMikJAWI3E+jmDFwzdyhPDyar3WXYjQvQBNNm2DYwhTfuHDMHHaEQg13arVejSsL9YvFviFtIAAUca/e9JLbarD9lYW7kOOFGmyftj+APWHdH7CIbSiVrQmrtCc89Vuo5lqJjOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723108592; c=relaxed/simple;
	bh=1asTwMFHGcZEwP0gWoT8JYjTyYPyyjcxr5sq/S1Ki+o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qUt4Yg8j6hNBaU9iV+3gNMWyDomfsCaXjtRh8GbQccA/BKZw1FFyhB9FcyozvW1dnZn1FbRzNhuckJpBOYtujSKIoVhJGQlZMNkK080mcJvhuWiQ1qOWt8KzAVI8bl8G6bGZrX7qU2fZFQE0JcCJapu5ow0Dv2uG1U8qSPtvyus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVWZtWQu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc692abba4so6736255ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 08 Aug 2024 02:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723108590; x=1723713390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eocFVHN/6ohwo4QNwzLA+WaIXfVG93HZGXc2CcAdhoY=;
        b=WVWZtWQu8X+1bBqYVQydrGKtikj9vMfBv9amvKyHIzznUYE0zUH9hlRj8hx3rY0sDO
         EJ2MAejLWYVvkU7Eo1iH82ecJ+ZLFKlHcXemG5Mz8pA52MHfLcrLEmUj0qHsasi6fpjX
         k6Xt7tEkvjaEnZLlE3bxIILnpBD92HxraEzInQIFmqss1QznudgqarWixo7YwlvUjjA1
         kjM4hL2zC3izwmRLzaW0+uymhDPEsazp3og+xH7RZKrEAcad+2n4fyWIz77K8kHBUhhz
         kLA2W2b8XjH+bEfWkys6sm9AQa/2R8CbGcK+FbkCHEgGT9pRLixZ9d8rSjEpBO1Xs+jV
         TX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723108590; x=1723713390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eocFVHN/6ohwo4QNwzLA+WaIXfVG93HZGXc2CcAdhoY=;
        b=ZTO5j/LTvhloKrEflxKMMranpa8xQNQ1eN7XK8Hz3QRfveAtBQigNpjMlrC3KOubwW
         BXzhaXwpHFkAkLrzDs7d5JvajVLjaTZcSnjiIUWe4o/nzXhmwJCYdw6XKyYt/VZWr5/p
         V2u3cBnlyEX/7qhu05T40LsJcRCEAOkyUuItx0PR+/H0hhwLN4p+gt/wXUpQt0S3EdDg
         /ldlcGaYB17c2BU8CT1Tpw2CVFE9xv2LtryA5+8Q7tkYT/VzYotvSrv2xZ1DjA3XsQF/
         o7ywHltxpZ6G9zfNIvm8aoZVmDiePgO60sJ+Tm3u2RImKOxNfCRfCwextHstRoODsgLs
         NE9Q==
X-Gm-Message-State: AOJu0YylFoC7W38FHesqLdw3IiQIm9r6vYr27VGEZcdPEN1gHsvOjqmN
	HPHi38Q73gGn1QYd+idcRe9X/c8a7tcb8kSftgSvU5kZ6qwS+rxm
X-Google-Smtp-Source: AGHT+IEiALhZ9IsdsFXvmR7fuhNOIyJLqVpzCC2cecEB0t8OyK65LJUJuPKbRgbkhIUV4oFUIBf5ww==
X-Received: by 2002:a17:902:d505:b0:1fd:a360:446f with SMTP id d9443c01a7336-200953e2db2mr16231755ad.65.1723108589666;
        Thu, 08 Aug 2024 02:16:29 -0700 (PDT)
Received: from localhost.localdomain (59-124-166-19.hinet-ip.hinet.net. [59.124.166.19])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-1ff59179793sm119948565ad.200.2024.08.08.02.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 02:16:29 -0700 (PDT)
From: Ping-Ke Shih <pkshih@gmail.com>
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org,
	wireless-regdb@lists.infradead.org
Subject: [PATCH] wireless-regdb: Update regulatory info for Guatemala (GT) for 2020
Date: Thu,  8 Aug 2024 17:16:11 +0800
Message-Id: <20240808091611.57112-1-pkshih@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

Superintendence of Telecommunications of Guatemala released NATIONAL TABLE
OF ATTRIBUTION OF FREQUENCIES RADIO ELECTRICS on 2020 [1] on page [2].

* GTM-30
  - 2,400.0 - 2,483.5 MHz, 500 mW (26.99 dBm)

* GTM-45
  indoor operation
  - 5,150 - 5,350 MHz, 200 mW (23.01 dBm)
  - 5,470 - 5,725 MHz, 250 mW (23.98 dBm)
  - 5,725 - 5,850 MHz, 500 mW (26.99 dBm)

* GTM-51
  indoor environments
  - 5,925 - 6,425  200 mW (23.01 dBm)
  - 6,425 - 6,525  200 mW (23.01 dBm)
  - 6,525 - 6,875  150 mW (21.76 dBm)
  - 6,875 - 7,125  150 mW (21.76 dBm)

* GTM-40
  used mainly inside buildings
  - 57 - 66 GHz 20 mW (13.1 dBm)

[1] https://sit.gob.gt/download/9685/tabla-nacional-de-atribucion-de-frecuencias/01WRXSS3QHSADNOSHDZ5HIWXE4TFFW3YIU/4.%20Tabla%20Nacional%20Atribuci%C3%B3n%20Frecuencias%20(Pies%20de%20P%C3%A1gina)
[2] https://sit.gob.gt/gerencia-de-frecuencias/frecuencias/tabla-nacional-de-atribucion-de-frecuencias/

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 db.txt | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/db.txt b/db.txt
index e46beae64ca4..c0b8ea54c9d5 100644
--- a/db.txt
+++ b/db.txt
@@ -779,11 +779,18 @@ country GR: DFS-ETSI
 	# 60 GHz band channels 1-4 (ETSI EN 302 567)
 	(57000 - 66000 @ 2160), (40)
 
-country GT: DFS-FCC
-	(2402 - 2472 @ 40), (30)
-	(5170 - 5250 @ 80), (17), AUTO-BW
-	(5250 - 5330 @ 80), (23), DFS, AUTO-BW
-	(5735 - 5835 @ 80), (30)
+# Source:
+# https://sit.gob.gt/download/9685/tabla-nacional-de-atribucion-de-frecuencias/01WRXSS3QHSADNOSHDZ5HIWXE4TFFW3YIU/4.%20Tabla%20Nacional%20Atribuci%C3%B3n%20Frecuencias%20(Pies%20de%20P%C3%A1gina)
+country GT:
+	(2400 - 2483.5 @ 40), (500 mW)
+	(5150 - 5350 @ 80), (200 mW), NO-OUTDOOR
+	(5470 - 5725 @ 160), (250 mW), NO-OUTDOOR
+	(5725 - 5850 @ 160), (500 mW), NO-OUTDOOR
+	(5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
+	(6425 - 6525 @ 320), (200 mW), NO-OUTDOOR
+	(6525 - 6875 @ 320), (150 mW), NO-OUTDOOR
+	(6875 - 7125 @ 320), (150 mW), NO-OUTDOOR
+	(57000 - 66000 @ 2160), (20 mW), NO-OUTDOOR
 
 country GU: DFS-FCC
 	(2402 - 2472 @ 40), (30)
-- 
2.25.1


