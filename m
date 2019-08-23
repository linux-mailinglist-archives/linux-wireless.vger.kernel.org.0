Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81ED29AFE0
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 14:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388471AbfHWMsG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 08:48:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47238 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732009AbfHWMsG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 08:48:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AB11089ACA;
        Fri, 23 Aug 2019 12:48:05 +0000 (UTC)
Received: from localhost (unknown [10.43.2.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20E256CE58;
        Fri, 23 Aug 2019 12:48:04 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Mathias Kresin <dev@kresin.me>, Emil Karlson <jekarl@iki.fi>,
        Fredrik Noring <noring@nocrew.org>
Subject: [PATCH 5.3] rt2x00: clear up IV's on key removal
Date:   Fri, 23 Aug 2019 14:48:03 +0200
Message-Id: <1566564483-31088-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Fri, 23 Aug 2019 12:48:06 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After looking at code I realized that my previous fix
95844124385e ("rt2x00: clear IV's on start to fix AP mode regression")
was incomplete. We can still have wrong IV's after re-keyring.
To fix that, clear up IV's also on key removal.

Fixes: 710e6cc1595e ("rt2800: do not nullify initialization vector data")
Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index ecbe78b8027b..28e2de04834e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1654,13 +1654,18 @@ static void rt2800_config_wcid_attr_cipher(struct rt2x00_dev *rt2x00dev,
 
 	offset = MAC_IVEIV_ENTRY(key->hw_key_idx);
 
-	rt2800_register_multiread(rt2x00dev, offset,
-				  &iveiv_entry, sizeof(iveiv_entry));
-	if ((crypto->cipher == CIPHER_TKIP) ||
-	    (crypto->cipher == CIPHER_TKIP_NO_MIC) ||
-	    (crypto->cipher == CIPHER_AES))
-		iveiv_entry.iv[3] |= 0x20;
-	iveiv_entry.iv[3] |= key->keyidx << 6;
+	if (crypto->cmd == SET_KEY) {
+		rt2800_register_multiread(rt2x00dev, offset,
+					  &iveiv_entry, sizeof(iveiv_entry));
+		if ((crypto->cipher == CIPHER_TKIP) ||
+		    (crypto->cipher == CIPHER_TKIP_NO_MIC) ||
+		    (crypto->cipher == CIPHER_AES))
+			iveiv_entry.iv[3] |= 0x20;
+		iveiv_entry.iv[3] |= key->keyidx << 6;
+	} else {
+		memset(&iveiv_entry, 0, sizeof(iveiv_entry));
+	}
+
 	rt2800_register_multiwrite(rt2x00dev, offset,
 				   &iveiv_entry, sizeof(iveiv_entry));
 }
-- 
1.9.3

