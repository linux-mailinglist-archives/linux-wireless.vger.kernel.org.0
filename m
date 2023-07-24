Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF6F475F3BB
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbjGXKp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjGXKp5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1597F3
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8F0061077
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD520C433C8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195556;
        bh=UjZZIclHthN9Uqzo+RiTwTxdcH+GWsORUIKq1XKJ5Q0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=a2LPHWSH4alG7xAcjXIK63yViDTjDjbTbXu5zBH3uvqWNnmngQW1pCG6q+2VLsr6T
         RxIpW8v9tC9BgL5qOAVBVqfAz21FcN19aj0Mm19qA8bkQv7fsPcXL83n5KMmyuCVT8
         ThBpi4gcr3bl3FHUSTIw7fmN+CNcnAnoO6gRUFPd0gnaqTgNuq5gXWEOfWTW6Ng9H8
         ZdGFDDDkeOCcGPTehLDYoYacQYutYZmH1j9larM6wVujfXfZhPz9OSX/+vynhsvl3h
         V4rX3nVWuA/dmN12xXX05aQqWn556k/XYi8DmYZnpSVlEyIuUStz7d8BMwwVlz3go4
         8ZkhEIOJW+RlA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 7/9] MAINTAINERS: wifi: mark zd1211rw as orphan
Date:   Mon, 24 Jul 2023 13:45:45 +0300
Message-Id: <20230724104547.3061709-8-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724104547.3061709-1-kvalo@kernel.org>
References: <20230724104547.3061709-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Last activity from Ulrich is from 2007 so mark the driver orphan.

Remove the zd1211-devs list, I doubt anyone uses it anymore. The webpage seems
to be down so remove that as well.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bfb423f5f4c3..4e275c077608 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23512,11 +23512,8 @@ S:	Maintained
 F:	mm/zbud.c
 
 ZD1211RW WIRELESS DRIVER
-M:	Ulrich Kunitz <kune@deine-taler.de>
 L:	linux-wireless@vger.kernel.org
-L:	zd1211-devs@lists.sourceforge.net (subscribers-only)
-S:	Maintained
-W:	http://zd1211.ath.cx/wiki/DriverRewrite
+S:	Orphan
 F:	drivers/net/wireless/zydas/zd1211rw/
 
 ZD1301 MEDIA DRIVER
-- 
2.39.2

