Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD81B6779A5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Jan 2023 11:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbjAWKzz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Jan 2023 05:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjAWKzy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Jan 2023 05:55:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6552CA10
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 02:55:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62FDAB80D29
        for <linux-wireless@vger.kernel.org>; Mon, 23 Jan 2023 10:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D01C433D2;
        Mon, 23 Jan 2023 10:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674471351;
        bh=ngpD5EseTABLJd0vL/U87OEOrZWVAoANQaC8NFuWfsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CjKFuJ5mGl0jp1lvRyChLD8A+Yk4ZV4quiAYfrGYi7+8A6es8H13XpWoGoC5qhbvN
         4/Y1hw9ki+LP5CMs5Zmum5NZb+wq2Y0LgtOILJkiNlpshkaWqjRn5BcLzmahxtbVza
         lbC2xyJin3Wgetmu8AGupDXsIPeL61+D0ULXi6tefUq4ZBQZMVnhehUhdqrqpXD8uE
         k0aNmuSDeBdHGX4SOhNUpHPSytfJa4YV4zcTtS807BdRkQNquew6M/EkJY/tLAoWFL
         00rC+9mwHRH6oA+Y4ggp1VQA2+ckW4fxC+jT9wQlwqEF6RYoKX5ouU7ygIP5VZ9DHH
         KTpNRQiq3UzEg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 2/2] wifi: mt76: remove __mt76_mcu_restart macro
Date:   Mon, 23 Jan 2023 11:55:29 +0100
Message-Id: <38bf65383048aaafe310d952c592d8ea5542ee9c.1674471203.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1674471203.git.lorenzo@kernel.org>
References: <cover.1674471203.git.lorenzo@kernel.org>
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
index 2efe4db63958..f4e13fbffc54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -888,7 +888,6 @@ extern struct ieee80211_rate mt76_rates[12];
 
 
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
-#define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
 #define mt76_set(dev, offset, val)	mt76_rmw(dev, offset, 0, val)
 #define mt76_clear(dev, offset, val)	mt76_rmw(dev, offset, val, 0)
-- 
2.39.1

