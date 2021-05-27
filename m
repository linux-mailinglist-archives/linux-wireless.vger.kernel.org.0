Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5980D392C42
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 13:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236311AbhE0LDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 07:03:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:40870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236286AbhE0LDR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 07:03:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A87B860241;
        Thu, 27 May 2021 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622113304;
        bh=8Z0CdVOtoIw+TSIWR2LltQNybLKwdxYvoJow19xmeJ0=;
        h=From:To:Cc:Subject:Date:From;
        b=SdZ9X0LEP4LwZ6X+j/iWSHkOQXOHqga2GDL6zUDnXQfpEZ1vqUxTChOVYcxqHQLY+
         5porLRD0e7UtTJcIHsIjlOAmzp60Q5al2xhF2js6dBxcVCGxrOSDuzoQB4HDI7nzJT
         7RNPzalRaFI2+OgJKs8vCd5VMlxY6Q09mQNeex1jxmrVMVxZzbZKEXEpgYQMNQ9KrS
         1BI+//5xlyvkxJz2igWBGXDBsEbE5uW5o/4oEiohEyk2kOz1uBHaV2n7mReR7Rz/Zp
         OrIbbSl7kidyKZBrQ0j4anr7P8fB3SYH6OM5FEgQPiSXp/3pi6KhW/uW7LZA2FAIBH
         Si0ieH+SmbzEw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: remove useless if condition in mt7615_add_interface()
Date:   Thu, 27 May 2021 13:01:24 +0200
Message-Id: <bf3655dfa561908153b35483c360ec7d71f88d48.1622113221.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get rid of unnecessary if condition in mt7615_add_interface routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 2627211aa34e..b809d5327089 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -241,8 +241,6 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 	}
 
 	ret = mt7615_mcu_add_dev_info(phy, vif, true);
-	if (ret)
-		goto out;
 out:
 	mt7615_mutex_release(dev);
 
-- 
2.31.1

