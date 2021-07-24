Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B72B3D4A52
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Jul 2021 23:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhGXVJ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Jul 2021 17:09:28 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:44042
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230343AbhGXVJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Jul 2021 17:09:25 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 240503F358
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627163395;
        bh=m3401JaeR7hF/iAuWRTaY4DOgJxinOQknlb5Rbk0RYA=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=iMw6cNKSAKr8nEOaP/CELlGoUsjsOW76upGW2t5VJHRDJkVwRPAKE+zwL0OJk5Xts
         9nOBtbKVkc4DrUDqsZ9JVOcmcWwKezUVQ+QFJszjSKSNHtGWOWO5A2wjEj9KVlmtNb
         Oagrp4mldV9hTM7LMhTLWFbCvF0AUwQLWoFbPURoKncIqLRQ6ceXYIfmOjdqKNdkS/
         l0+JOzwfjSxZT0FvXXfMO+hPX7ZQgNTN1JQwNOSk2/zI8uunfSnNpKpyJlhpngmL3z
         VNTmqVeqh8dyt+u8OBQ2L2jkv3doEDjo1/ksFEoggNBAaKqlaaB1rFK9HB1rCv5MSu
         FkejFJ6JuGutw==
Received: by mail-ed1-f70.google.com with SMTP id z15-20020a50f14f0000b02903aa750a46efso2819647edl.8
        for <linux-wireless@vger.kernel.org>; Sat, 24 Jul 2021 14:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3401JaeR7hF/iAuWRTaY4DOgJxinOQknlb5Rbk0RYA=;
        b=GneNuf3ZY9zrNBHYjiCzI0YhUpHHaZfuKCIP8DIROxf/0NRLQW8Ba5XlU2MSLy+hlv
         KgWJDRJ6GY46+zS3xdIfTCm85X4SH1wfFLYRJDcbHfCrfjNMeS8kCYLrfr5CyyUGMOUh
         adPA4MS4iMsRUQHJ5UbMdU4WpVtiwpcYV8Pq8P35ksE4fkDm+Vhl7QE88t5hvYeUzG7R
         b1b9G1B+G1mR/peEyUTXjdopiRV+l080QTi7eMsucsaOA3HXt/wftmtCTCzGJWaihEYC
         Y9ONxaki5D2onTuY+9nOFnnYEdF7wZcNf/ylMbUIRi5eEISRFaWY6q34f5GqhyvVVa+y
         lwkA==
X-Gm-Message-State: AOAM533Qf/x8pHevTXD7NClsjo/vRYBgXVhMLLvEJTwZNWmsnL4G6EmA
        onl2ewXLtITcVRiJo+mFyX82UJJJDfvkDt0zuYlOIK+4q4phIQtBK8pNSyV7U2Wb9mlHQqKSZrm
        G9HL/ww0ql8fhIzXBo1I/zGe9mDqd8nUMvtL6fb+KXPRG
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr6534942ejb.190.1627163394854;
        Sat, 24 Jul 2021 14:49:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgKzAQcpLMspzu45StHAw3RghPL4mRPttr3WZv3iPoIq6uG7G3+HUmNDkSk4ospeFMgRLHEw==
X-Received: by 2002:a17:907:216d:: with SMTP id rl13mr6534930ejb.190.1627163394731;
        Sat, 24 Jul 2021 14:49:54 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id s10sm12821908ejc.39.2021.07.24.14.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 14:49:54 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Bongsu Jeon <bongsu.jeon@samsung.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 10/12] nfc: constify nfc_hci_ops
Date:   Sat, 24 Jul 2021 23:49:26 +0200
Message-Id: <20210724214928.122096-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
References: <20210724214743.121884-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Neither the core nor the drivers modify the passed pointer to struct
nfc_hci_ops, so make it a pointer to const for correctness and safety.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/nfc/microread/microread.c | 2 +-
 drivers/nfc/pn544/pn544.c         | 2 +-
 drivers/nfc/st21nfca/core.c       | 2 +-
 include/net/nfc/hci.h             | 4 ++--
 net/nfc/hci/core.c                | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 151a0631ec72..8e847524937c 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -625,7 +625,7 @@ static int microread_event_received(struct nfc_hci_dev *hdev, u8 pipe,
 	return r;
 }
 
-static struct nfc_hci_ops microread_hci_ops = {
+static const struct nfc_hci_ops microread_hci_ops = {
 	.open = microread_open,
 	.close = microread_close,
 	.hci_ready = microread_hci_ready,
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index f4d09ebba5c8..c2b4555ab4b7 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -881,7 +881,7 @@ static int pn544_hci_disable_se(struct nfc_hci_dev *hdev, u32 se_idx)
 	}
 }
 
-static struct nfc_hci_ops pn544_hci_ops = {
+static const struct nfc_hci_ops pn544_hci_ops = {
 	.open = pn544_hci_open,
 	.close = pn544_hci_close,
 	.hci_ready = pn544_hci_ready,
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 675f8a342869..5e6c99fcfd27 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -912,7 +912,7 @@ static int st21nfca_hci_event_received(struct nfc_hci_dev *hdev, u8 pipe,
 	}
 }
 
-static struct nfc_hci_ops st21nfca_hci_ops = {
+static const struct nfc_hci_ops st21nfca_hci_ops = {
 	.open = st21nfca_hci_open,
 	.close = st21nfca_hci_close,
 	.load_session = st21nfca_hci_load_session,
diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
index 2daec8036be9..756c11084f65 100644
--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -118,7 +118,7 @@ struct nfc_hci_dev {
 
 	struct sk_buff_head msg_rx_queue;
 
-	struct nfc_hci_ops *ops;
+	const struct nfc_hci_ops *ops;
 
 	struct nfc_llc *llc;
 
@@ -151,7 +151,7 @@ struct nfc_hci_dev {
 };
 
 /* hci device allocation */
-struct nfc_hci_dev *nfc_hci_allocate_device(struct nfc_hci_ops *ops,
+struct nfc_hci_dev *nfc_hci_allocate_device(const struct nfc_hci_ops *ops,
 					    struct nfc_hci_init_data *init_data,
 					    unsigned long quirks,
 					    u32 protocols,
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index b33fe4ee1581..ff94ac774937 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -947,7 +947,7 @@ static const struct nfc_ops hci_nfc_ops = {
 	.se_io = hci_se_io,
 };
 
-struct nfc_hci_dev *nfc_hci_allocate_device(struct nfc_hci_ops *ops,
+struct nfc_hci_dev *nfc_hci_allocate_device(const struct nfc_hci_ops *ops,
 					    struct nfc_hci_init_data *init_data,
 					    unsigned long quirks,
 					    u32 protocols,
-- 
2.27.0

