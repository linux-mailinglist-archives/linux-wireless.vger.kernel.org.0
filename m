Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1109E2344DA
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jul 2020 13:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbgGaLuY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jul 2020 07:50:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732638AbgGaLuY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jul 2020 07:50:24 -0400
Received: from lore-desk.redhat.com (unknown [151.48.137.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79A432074B;
        Fri, 31 Jul 2020 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596196224;
        bh=Vz53n9jW7TVbpZZJJwpN10G9OhbubZC0zA7zOcby55I=;
        h=From:To:Cc:Subject:Date:From;
        b=ZqTSJ2HUTTBXkU7pWWumGnXDdDWmLC+yb0AfxcLPjZJonRHknCwQ8dAAUpUpsZNrH
         MP4jCE2XC3sFq9dJbTj+I7fj2Nd74vkYxA1iWGcS6f6c8647CWQPhRvIIPdzpLDEpw
         zA9GElCF5quN26UGe7hsS3yHTdh6ejhrQYb6Lw/Y=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt76s: get rid of unused variable
Date:   Fri, 31 Jul 2020 13:50:14 +0200
Message-Id: <587e2af26bcc2f884135af62305f523f8652a874.1596195707.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Remove unused state variable in mt76_sdio structure

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index d44a35463197..a06f8f5abeb2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -459,8 +459,6 @@ struct mt76_sdio {
 
 	struct work_struct stat_work;
 
-	unsigned long state;
-
 	struct sdio_func *func;
 
 	struct {
-- 
2.26.2

