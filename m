Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B005778B094
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjH1Mgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjH1MgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:36:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3C8E3
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B054F623BF
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901CBC433C9
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226169;
        bh=ap7ELHPcsKpIbztDtiVjajo3sLz1U9YQxCbYtS0y4/I=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Z/4fS12JL8f/A4iNc3kSsDsyFdfNkKULgMVCdy+pukWY8g6AEmyis8204gfZtD0Oc
         C6nCo3j2lZQOi/02NtebOIdiLObThXL9Lc76UrKBa7yjTFDcM0qsamQttSlyqnd9cv
         4GByZs2/NprEVHyPPeQt4pTRndvKqsnaD6uhPInTA8sbtRu4Pnkh+6xMhZ36H8DhbX
         KOoexmDKLmk1HXjCsIuqgCsbrMjTZAG4Nt9kZSySPGNO6lNlmSFRvJ9q0B7PSqEYR0
         qvyiqFRIyTFZQBPzK251UtCoKXvMqkPtYVU5nwXViAM26vwRg4+URjj2KzaVlZehQ7
         s0pnut5q/yL+g==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/5] MAINTAINERS: wifi: wl12xx: remove git tree
Date:   Mon, 28 Aug 2023 15:36:02 +0300
Message-Id: <20230828123603.87621-4-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828123603.87621-1-kvalo@kernel.org>
References: <20230828123603.87621-1-kvalo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luca's tree hasn't been used for 10 years so remove it.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 89381b63a81d..22187d5401cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21439,7 +21439,6 @@ L:	linux-wireless@vger.kernel.org
 S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl12xx
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/wl1251
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luca/wl12xx.git
 F:	drivers/net/wireless/ti/
 
 TIMEKEEPING, CLOCKSOURCE CORE, NTP, ALARMTIMER
-- 
2.39.2

