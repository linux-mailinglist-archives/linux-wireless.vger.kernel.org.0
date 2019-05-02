Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEE5D11618
	for <lists+linux-wireless@lfdr.de>; Thu,  2 May 2019 11:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEBJHO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 May 2019 05:07:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726191AbfEBJHO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 May 2019 05:07:14 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4139A308339F;
        Thu,  2 May 2019 09:07:14 +0000 (UTC)
Received: from localhost (ovpn-204-54.brq.redhat.com [10.40.204.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 87A6654FDF;
        Thu,  2 May 2019 09:07:12 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH 5/7] rt2800: do not nullify initialization vector data
Date:   Thu,  2 May 2019 11:06:59 +0200
Message-Id: <1556788021-6531-7-git-send-email-sgruszka@redhat.com>
In-Reply-To: <1556788021-6531-1-git-send-email-sgruszka@redhat.com>
References: <1556788021-6531-1-git-send-email-sgruszka@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 02 May 2019 09:07:14 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

If we restart hw we should keep existing IV (initialization vector)
otherwise HW encryption will be broken after restart.

Also fix some coding style issues on the way.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
index c3409578bf97..44c1057542a2 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1650,14 +1650,15 @@ static void rt2800_config_wcid_attr_cipher(struct rt2x00_dev *rt2x00dev,
 
 	offset = MAC_IVEIV_ENTRY(key->hw_key_idx);
 
-	memset(&iveiv_entry, 0, sizeof(iveiv_entry));
+	rt2800_register_multiread(rt2x00dev, offset,
+				  &iveiv_entry, sizeof(iveiv_entry));
 	if ((crypto->cipher == CIPHER_TKIP) ||
 	    (crypto->cipher == CIPHER_TKIP_NO_MIC) ||
 	    (crypto->cipher == CIPHER_AES))
 		iveiv_entry.iv[3] |= 0x20;
 	iveiv_entry.iv[3] |= key->keyidx << 6;
 	rt2800_register_multiwrite(rt2x00dev, offset,
-				      &iveiv_entry, sizeof(iveiv_entry));
+				   &iveiv_entry, sizeof(iveiv_entry));
 }
 
 int rt2800_config_shared_key(struct rt2x00_dev *rt2x00dev,
@@ -6082,13 +6083,11 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
 	 * ASIC will keep garbage value after boot, clear encryption keys.
 	 */
 	for (i = 0; i < 4; i++)
-		rt2800_register_write(rt2x00dev,
-					 SHARED_KEY_MODE_ENTRY(i), 0);
+		rt2800_register_write(rt2x00dev, SHARED_KEY_MODE_ENTRY(i), 0);
 
 	for (i = 0; i < 256; i++) {
 		rt2800_config_wcid(rt2x00dev, NULL, i);
 		rt2800_delete_wcid_attr(rt2x00dev, i);
-		rt2800_register_write(rt2x00dev, MAC_IVEIV_ENTRY(i), 0);
 	}
 
 	/*
-- 
2.7.5

