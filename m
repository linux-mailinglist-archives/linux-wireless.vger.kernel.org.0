Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D6647A192
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Dec 2021 18:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbhLSRlA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 19 Dec 2021 12:41:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLSRlA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 19 Dec 2021 12:41:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39352C061574
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 09:41:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D576E60ED0
        for <linux-wireless@vger.kernel.org>; Sun, 19 Dec 2021 17:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F37C36AE7;
        Sun, 19 Dec 2021 17:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639935658;
        bh=BmgZk5Dhvp5e/Y3OqfegXCAtj1rGO0b4BmgzqKoL5kU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RgZRgtpIANlSrBxa11HCfMmvBXlvxSq3mJvgZGWQ6YTuzVIaZ8yMPGTg40VH1Nm3M
         +WZjYCT+ujN/K1bUkO7KG4Dnb9jnPzmBWwuE8+Qc3hHEjsR8OPcq2x7ZioLLqTkykb
         dcIav8CrY6EBmu2Jyye117TrXJa/f1sZh1h3ba5DEq9BtXK+nCXAZ4nVGddYvDou0J
         Lc7uasU/ndYaKLJctyewpMSmWIULJ1WkIaglVI4vaMvjHRdvkmxWPFJSx3gfUh10U1
         381lN0rIVVMUPF8RvevFEx2kDsFEwT17QzE3WbbrgYMMCBGv+w9SgWmvqOusGHbBED
         cy8/zUvsWhSAQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH v2 1/9] mt76: connac: fix sta_rec_wtbl tag len
Date:   Sun, 19 Dec 2021 18:40:06 +0100
Message-Id: <fe6da0f881348f932fe5ccd0653dc537f1675727.1639935477.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639935477.git.lorenzo@kernel.org>
References: <cover.1639935477.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7915 driver, fix tag len error for sta_rec_wtbl, which
causes fw parsing error for the tags placed behind it.

Fixes: d0e274af2f2e4 ("mt76: mt76_connac: create mcu library")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index f79e3d5084f3..5664f119447b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -310,7 +310,7 @@ mt76_connac_mcu_alloc_wtbl_req(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	}
 
 	if (sta_hdr)
-		sta_hdr->len = cpu_to_le16(sizeof(hdr));
+		le16_add_cpu(&sta_hdr->len, sizeof(hdr));
 
 	return skb_put_data(nskb, &hdr, sizeof(hdr));
 }
-- 
2.33.1

