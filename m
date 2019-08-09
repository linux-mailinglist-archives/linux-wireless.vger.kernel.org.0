Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4989788120
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2019 19:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406976AbfHIRZY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Aug 2019 13:25:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39547 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfHIRZY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Aug 2019 13:25:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id t16so8815548wra.6
        for <linux-wireless@vger.kernel.org>; Fri, 09 Aug 2019 10:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4Vi2Ae41EjGx5uvSG0Bj7x8BoODLKGLWSBmAKUugHE=;
        b=da93S33/Oj5FOZwiNEStiRjZr5MOASB+Vm1LkW/nk75q9a5dEzwG27ehH/PbhOMl1r
         ahqJenDPWj9gjEtZJTbZL8dvGrWNhwAN8NlRmO9ctJS+dCctWZvSn1MPuOxGAu3yTESx
         02RuQRGAtgf/EFbtHBPoPQlLEoCeLe2cbl3p+ogMZUgHJ+uZX0oA3lNNtlfERcrJ+mRt
         1tf6CZtQjd6mVeRBwCn3GuE8n2TuNo+VtC//7iDDaia/tghQTZ5Pz3vfJ2VaKEoi7nSy
         seUzQOzLKspfx+ngnr5IfuzQFmcbikoAbw/hWNpCddK4UQ5VQXIs7RTqTUzqCrVd0r93
         MYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4Vi2Ae41EjGx5uvSG0Bj7x8BoODLKGLWSBmAKUugHE=;
        b=TpO9Ej7Md2EdjPAAJ0VFwaohhJj35w5hhMUUSz8vYuLqbmcDC2SWhtBctgTxUvTZLt
         Vu0I3jkT8NYpkok5prVXIM4AbZfsChgjGfw04o0k7Rwl9IrCvNiaULHdG8mRE/Tmr0aN
         e6utrbk5Vw1ZWyEbyGK2TboinpZDjdcCpiaAh1CPlqljmlt+7M5giHQzljWb7KmpkePR
         Fj9hJsmPOIPfvA+t39X6HLY9yk1+uPgnRCZZ7AD70rUJgLgWPhY7eTtZX4xN1ypHbqqe
         PiMH/TUM/nd2v4Zz4EtG2ezq3SQU8TCPgS3IA/mIhqOANgeeotXXZRrLwS5gIxtpean1
         soeA==
X-Gm-Message-State: APjAAAW6GguS0ZozuY6jNdYPUG0pJ/y3Fy8m9svtGFJVg7o1hFEwZRA8
        gsr3qIwKBjatf86tXevexd4=
X-Google-Smtp-Source: APXvYqwoemQJ3QTQYW/IFz92DYpHsNSsc4XsrM1IFsD0eSnfZ9gvt78hF0AxYusHBRQ7sqfyJU0ScQ==
X-Received: by 2002:adf:e883:: with SMTP id d3mr10521786wrm.330.1565371522002;
        Fri, 09 Aug 2019 10:25:22 -0700 (PDT)
Received: from localhost.localdomain ([5.171.105.77])
        by smtp.gmail.com with ESMTPSA id r16sm8473598wrc.81.2019.08.09.10.25.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 09 Aug 2019 10:25:21 -0700 (PDT)
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH] mt76: mt7603: remove unnecessary mcu queue initialization
Date:   Fri,  9 Aug 2019 19:25:15 +0200
Message-Id: <47cf5a23db2bba6ad271f9507aea60827f84aa59.1565370483.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Remove unnecessary mcu queue initialization in mt7603_dma_init since it
has been already done in mt76_mmio_init

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on 'mt76: move mt76_tx_tasklet in mt76 module'
https://patchwork.kernel.org/patch/11087345/
---
 drivers/net/wireless/mediatek/mt76/mt7603/dma.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
index b53d59c53c28..5c2c12289492 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/dma.c
@@ -170,9 +170,6 @@ int mt7603_dma_init(struct mt7603_dev *dev)
 
 	mt76_dma_attach(&dev->mt76);
 
-	init_waitqueue_head(&dev->mt76.mmio.mcu.wait);
-	skb_queue_head_init(&dev->mt76.mmio.mcu.res_q);
-
 	mt76_clear(dev, MT_WPDMA_GLO_CFG,
 		   MT_WPDMA_GLO_CFG_TX_DMA_EN |
 		   MT_WPDMA_GLO_CFG_RX_DMA_EN |
-- 
2.21.0

