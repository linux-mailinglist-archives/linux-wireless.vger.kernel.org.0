Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE0775F3BA
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 12:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjGXKp6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 06:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjGXKp6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 06:45:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B2CE6
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 03:45:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83A766106D
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89186C433C7
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690195556;
        bh=WItjbki57ts7uKnqyzeLuOi9lonuvZyP/NrQXdbHsQg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MH+DU+cWMQ36WAESw0djZ1st2VMv1VcsAkQ02j5D0P2LWigdoIO814KBtgbxJZs4s
         tMrxwQGetQUGOcDECHqAljDzRsSDvQxfNJv77+dQ8WaHy71EQ3PvcR0Gl3r2iQTPD+
         pygp6y92zCTqT9qKBfyQPku4GDkRXEkK6jclis5pCYEMyivYIJOTqz5atAffHjCIxI
         dRU2JwLNMjHWLuX0jNp2SpW/H77PtwjBt2IlualeQp6lRHCae0ejLz3S+Lo2G2xlsR
         1vfHjs1Sin1e/spkRsYnh+1QdClW7HGRZUURx3TXRpg+eEVLk7Rn9rn48ajSZqPVel
         b+F4A02EZWjsA==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 8/9] MAINTAINERS: wifi: mark b43 as orphan
Date:   Mon, 24 Jul 2023 13:45:46 +0300
Message-Id: <20230724104547.3061709-9-kvalo@kernel.org>
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

There's no maintainer for b43 so mark it as orphan.

Signed-off-by: Kalle Valo <kvalo@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e275c077608..a6538fd53887 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3391,7 +3391,7 @@ F:	drivers/media/radio/radio-aztech*
 B43 WIRELESS DRIVER
 L:	linux-wireless@vger.kernel.org
 L:	b43-dev@lists.infradead.org
-S:	Odd Fixes
+S:	Orphan
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/b43
 F:	drivers/net/wireless/broadcom/b43/
 
-- 
2.39.2

