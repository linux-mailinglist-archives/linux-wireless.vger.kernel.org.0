Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F8746F60
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2019 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfFOKBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 Jun 2019 06:01:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48164 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfFOKBJ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 Jun 2019 06:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0D5933082134;
        Sat, 15 Jun 2019 10:01:09 +0000 (UTC)
Received: from localhost (ovpn-204-44.brq.redhat.com [10.40.204.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1A1960C44;
        Sat, 15 Jun 2019 10:01:08 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     =?UTF-8?q?Tomislav=20Po=C5=BEega?= <pozega.tomislav@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Felix Fietkau <nbd@nbd.name>, Mathias Kresin <dev@kresin.me>
Subject: [PATCH v2 5/7] rt2800: do not nullify initialization vector data
Date:   Sat, 15 Jun 2019 12:00:58 +0200
Message-Id: <20190615100100.29800-6-sgruszka@redhat.com>
In-Reply-To: <20190615100100.29800-1-sgruszka@redhat.com>
References: <20190615100100.29800-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Sat, 15 Jun 2019 10:01:09 +0000 (UTC)
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
index 499e9afa0026..32a4b84e6e05 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800lib.c
@@ -1647,14 +1647,15 @@ static void rt2800_config_wcid_attr_cipher(struct rt2x00_dev *rt2x00dev,
 
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
@@ -6079,13 +6080,11 @@ static int rt2800_init_registers(struct rt2x00_dev *rt2x00dev)
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
2.20.1

