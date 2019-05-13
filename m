Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6491B3EF
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727640AbfEMKYE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:24:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725980AbfEMKYD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:24:03 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67E3C208CA;
        Mon, 13 May 2019 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557743043;
        bh=uAmW4lkgyoXXVu7OEyGc79pNfqmPd12Lj52dDKXhFjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGdSSewsRyImU1lXUbcUIEjX9lfsfkhUUwcbTRIL1rYIw4MN/S+d43oPZOz2O4V5I
         SwVej4QUQsvM0lnayuLVEstrk6NOY+C1f2issENvgtDPU7FOEK7QldLodlOoH4E5nu
         xbuLZYNk7c3k6tpW7cfNTzRtJqG4FiglmGIP/4/g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH] mt76: mt76x02: fix edcca file permission
Date:   Mon, 13 May 2019 12:23:29 +0200
Message-Id: <0e4f22246404d095de2a7e28ddf7572ff71bdb05.1557742856.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557742856.git.lorenzo@kernel.org>
References: <cover.1557742856.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use 0600 as edcca file permission in mt76x02 debugfs

Fixes: 643749d4a82b ("mt76: mt76x02: disable ED/CCA by default")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
index f412c779d8e2..ffdba5ffc22d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_debugfs.c
@@ -157,7 +157,7 @@ void mt76x02_init_debugfs(struct mt76x02_dev *dev)
 	debugfs_create_u8("temperature", 0400, dir, &dev->cal.temp);
 	debugfs_create_bool("tpc", 0600, dir, &dev->enable_tpc);
 
-	debugfs_create_file("edcca", 0400, dir, dev, &fops_edcca);
+	debugfs_create_file("edcca", 0600, dir, dev, &fops_edcca);
 	debugfs_create_file("ampdu_stat", 0400, dir, dev, &fops_ampdu_stat);
 	debugfs_create_file("dfs_stats", 0400, dir, dev, &fops_dfs_stat);
 	debugfs_create_devm_seqfile(dev->mt76.dev, "txpower", dir,
-- 
2.20.1

