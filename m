Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B55C78B08F
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Aug 2023 14:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjH1MgS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Aug 2023 08:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjH1MgK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Aug 2023 08:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A30107
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 05:36:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74D0C64702
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 846BDC433C7
        for <linux-wireless@vger.kernel.org>; Mon, 28 Aug 2023 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693226166;
        bh=bFgs2G1XxI6Agl+rrOb3EsjmqPAbvojz+WfNk2bVDI4=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LJcqhGg0LOX+Ow7sd4m9JRVHLvbHhLAkjxiiahCzu2qvEFz9wb02zZUJYdMIfaekl
         mPqT3iPsELMl7GudKlWT1ZQskF4vXt8gxplY7wrVkhSChTizBykcNINvvAWKPGOmMl
         Ji2fOPDFCeuHHiLdEy1V11vDKPxyK20BeuDsK4M8UR6aS2vgwYosrppb4fKPGGdAo2
         gdQBHiKwKHXowwnvXQy9u4a66Fo0lY/+gzDDW7iWsDuNrwQ3aDBAhWWKrWY4bl/hsH
         lSLjaE3tP3KMhclG86417OG1FpLPHUfo/IM1C/wrprNSRJeUunegxpPtUIbcUks71+
         /noo9rluw0XhQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/5] MAINTAINERS: wifi: rtlwifi: remove git tree
Date:   Mon, 28 Aug 2023 15:36:00 +0300
Message-Id: <20230828123603.87621-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828123603.87621-1-kvalo@kernel.org>
References: <20230828123603.87621-1-kvalo@kernel.org>
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

Linville's tree hasn't been used for something like 10 years so remove it.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 98bda710773d..9672866792e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18015,7 +18015,6 @@ REALTEK WIRELESS DRIVER (rtlwifi family)
 M:	Ping-Ke Shih <pkshih@realtek.com>
 L:	linux-wireless@vger.kernel.org
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-testing.git
 F:	drivers/net/wireless/realtek/rtlwifi/
 
 REALTEK WIRELESS DRIVER (rtw88)
-- 
2.39.2

