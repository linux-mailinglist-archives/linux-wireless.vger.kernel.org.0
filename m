Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB22E7AA1F3
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjIUVLA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbjIUVFN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:05:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B017EA3B
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 10:37:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1C5C36AF1;
        Thu, 21 Sep 2023 10:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293047;
        bh=IPe5TSQAv2UTclbOLSu6Yjl5/f+ADH5J1nd/VG0Qoco=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HIWE7Dl2M/tiP0mXI7MYPKuxD5eDoaHESu03PQoqbwLfCXgSXsn6zNUpKvCG0PNRU
         rQPH86vs2oC9hNjjI5AJqK7A0R0RUPmYmnhgz5R+BEBOBzRKhA6pGWvOI8vaoSpqsV
         uK3aX2RKkfoyjNjxz4DaB4n/RKcKDW0wUb3FsMTPoFlv2Gf49kB+c5caN/t+5BhJAa
         Y6yO8LMg5txm+km/W+jmjggUCLZjsvcAfTWUuqe18KDILvllBanEubAEGkW1UYZg9o
         7CaUFHrhsX79Xmv+bkkfmskREGAE+TuKjrLQJIqVQmCdjR8Z9MUKsKpx+2d1oS4MtW
         yvONxdSqZzJfQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com,
        shayne.chen@mediatek.com, Bo.Jiao@mediatek.com,
        sujuan.chen@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH 6/9] wifi: mt76: increase MT_QFLAG_WED_TYPE size
Date:   Thu, 21 Sep 2023 12:43:35 +0200
Message-ID: <75d8f3f75ef86fdf37feeb4ce1c6d5c6d2f2a741.1695292502.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695292502.git.lorenzo@kernel.org>
References: <cover.1695292502.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to introduce WED support for mt7996

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 61b8d082cd0c..b49a0ed5d23f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -29,8 +29,8 @@
 #define MT76_TOKEN_FREE_THR	64
 
 #define MT_QFLAG_WED_RING	GENMASK(1, 0)
-#define MT_QFLAG_WED_TYPE	GENMASK(3, 2)
-#define MT_QFLAG_WED		BIT(4)
+#define MT_QFLAG_WED_TYPE	GENMASK(4, 2)
+#define MT_QFLAG_WED		BIT(5)
 
 #define __MT_WED_Q(_type, _n)	(MT_QFLAG_WED | \
 				 FIELD_PREP(MT_QFLAG_WED_TYPE, _type) | \
-- 
2.41.0

