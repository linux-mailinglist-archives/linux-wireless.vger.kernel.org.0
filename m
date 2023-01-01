Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778BE65A9E0
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAALyA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjAALx7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:59 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEF96156
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9F6A9CE0954
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CE9C433F1;
        Sun,  1 Jan 2023 11:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574033;
        bh=AEbuJ9nDqKtvdaIge4xzygqXgXaP+eiH1QtFrkLMrEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CF4dw3b+Fq7uAgJPrhEKwcJWXpI1lf1dakp0oA9a1cCshU9oeIDjPYg4S3r7UWj6c
         IxLGVtGsW8Ic2+Nax6cd4i7C6Xlve+fEekRwPLTfqUirzaA+hUF1hZ8opHoyPyPbo1
         ++XV2wjVaZ1NUZmOpSlvLvU9A9mEZe0hfE0VQJ6/ByQI+rmNcJde2Xiiq6CImdrIsj
         ogF/Sy/v3k7bXKaIIrWdowvWNq6xBaRjDHEnlXO5PSpd9FFcv27Nhuc7Rg1jgV3bHK
         OEsPxf9/heHXMvUToGPWkS0SJ/HwSfXl8XQgD5Irpn2iHnpaoAUu51z2CmvodS3jMA
         1z0Fdo7SeCyuQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] wifi: mt76: remove __mt76_mcu_restart macro
Date:   Sun,  1 Jan 2023 12:53:23 +0100
Message-Id: <7764276e47d5e30ec9fbac619653abbd888a3e4a.1672573894.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672573894.git.lorenzo@kernel.org>
References: <cover.1672573894.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

__mt76_mcu_restart is no longer used

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index f351a37c47f7..4f808b676954 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -888,7 +888,6 @@ extern struct ieee80211_rate mt76_rates[12];
 
 
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
-#define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
 #define mt76_set(dev, offset, val)	mt76_rmw(dev, offset, 0, val)
 #define mt76_clear(dev, offset, val)	mt76_rmw(dev, offset, val, 0)
-- 
2.38.1

