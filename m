Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7F157E76
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2019 10:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfF0Io7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Jun 2019 04:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfF0Io7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Jun 2019 04:44:59 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8270206E0;
        Thu, 27 Jun 2019 08:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561625098;
        bh=zupj83VeBWs8AJtryw22/IFPFwGeTZtgLKbadmKHB4s=;
        h=From:To:Cc:Subject:Date:From;
        b=UDn0nvc3FgoFfnWh12HnKrMXLC0AVzNJg8OMwdqsNp+OvGht86I446hxpFVUVQjuc
         AL21VfkkgUX+oP2rilMqsn9vlYsygvHyujB4VlFj5LNFPyN1lZtH0A5Yv4XXnsXx7t
         2zYFYp9TaC1K5YAN+4cszikIrd/HuLFNOLQM7IG8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: fix sparse warnings: incorrect type in assignment (different base types)
Date:   Thu, 27 Jun 2019 10:44:49 +0200
Message-Id: <c54c42d84d4cc45e7a1cc6ff96402781d7cfd693.1561624954.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warning in mt7615_mcu_bss_info_ext_header:
drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:728:30: sparse: sparse:
incorrect type in assignment (different base types)
drivers/net/wireless/mediatek/mt76/mt7615/mcu.c:728:30: sparse:
expected restricted __le32 [usertype] mbss_tsf_offset

Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 04b8e65922f6 ("mt76: add mac80211 driver for MT7615 PCIe-based chipsets")
Fixes: 7339fbc0caa5 ("mt7615: mcu: do not use function pointers whenever possible")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index cee168b9f047..bf23e796bc06 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -757,7 +757,7 @@ mt7615_mcu_bss_info_ext_header(struct mt7615_vif *mvif, u8 *data)
 /* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
 #define BCN_TX_ESTIMATE_TIME (4096 + 20)
 	struct bss_info_ext_bss *hdr = (struct bss_info_ext_bss *)data;
-	int ext_bss_idx;
+	int ext_bss_idx, tsf_offset;
 
 	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
 	if (ext_bss_idx < 0)
@@ -765,7 +765,8 @@ mt7615_mcu_bss_info_ext_header(struct mt7615_vif *mvif, u8 *data)
 
 	hdr->tag = cpu_to_le16(BSS_INFO_EXT_BSS);
 	hdr->len = cpu_to_le16(sizeof(struct bss_info_ext_bss));
-	hdr->mbss_tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
+	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
+	hdr->mbss_tsf_offset = cpu_to_le32(tsf_offset);
 }
 
 int mt7615_mcu_set_bss_info(struct mt7615_dev *dev,
-- 
2.21.0

