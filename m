Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083337115AE
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 20:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242433AbjEYSn4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242270AbjEYSnl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:43:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CEF10F6;
        Thu, 25 May 2023 11:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 636EA60FAF;
        Thu, 25 May 2023 18:38:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71968C433D2;
        Thu, 25 May 2023 18:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039905;
        bh=ODzEe5MTMPERDf+zXbuLdOTQOBegDNhuK6ZJ0a/0Ze4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U9DY5M6ck3E5ag8RQsklK387inW7/k7EosKM7/KldBmfyETn7d8fJhzqXZo8Y+NJu
         pDIKrhuuziFYGTtrSPlUajFvVwTWEP1ICWtqMLpZCriZhweaSIsIkdBCs0jwXY1l58
         Se0gK4uaJboG0o39Ozi0djhyOaMlOVr5s9Hgs1oe5cbhGnVuHBrXVUAMmPN3sbjxPr
         FoF+4cKgrvA8lQn1IwViQlUN+ktfSDQqFiLthXr0Cm64QbbNdw7mzz2F2AS+btlpH+
         vz/krsqNtsZ5mIHovEwSN6FIUdazmT4JG+14JWTnkVmN2DjJB6mZ20uQP2a1ae9Wa3
         XFGER8nbTBwYA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?q?Michael=20B=C3=BCsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.1 44/57] wifi: b43: fix incorrect __packed annotation
Date:   Thu, 25 May 2023 14:35:54 -0400
Message-Id: <20230525183607.1793983-44-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
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

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit 212457ccbd60dba34f965e4ffbe62f0e4f970538 ]

clang warns about an unpacked structure inside of a packed one:

drivers/net/wireless/broadcom/b43/b43.h:654:4: error: field data within 'struct b43_iv' is less aligned than 'union (unnamed union at /home/arnd/arm-soc/drivers/net/wireless/broadcom/b43/b43.h:651:2)' and is usually due to 'struct b43_iv' being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

The problem here is that the anonymous union has the default alignment
from its members, apparently because the original author mixed up the
placement of the __packed attribute by placing it next to the struct
member rather than the union definition. As the struct itself is
also marked as __packed, there is no need to mark its members, so just
move the annotation to the inner type instead.

As Michael noted, the same problem is present in b43legacy, so
change both at the same time.

Acked-by: Michael Büsch <m@bues.ch>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Tested-by: Larry Finger <Larry.Finger@lwfinger.net>
Link: https://lore.kernel.org/oe-kbuild-all/202305160749.ay1HAoyP-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230516183442.536589-1-arnd@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/b43/b43.h             | 2 +-
 drivers/net/wireless/broadcom/b43legacy/b43legacy.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/b43.h b/drivers/net/wireless/broadcom/b43/b43.h
index 9fc7c088a539e..67b4bac048e58 100644
--- a/drivers/net/wireless/broadcom/b43/b43.h
+++ b/drivers/net/wireless/broadcom/b43/b43.h
@@ -651,7 +651,7 @@ struct b43_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 
diff --git a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
index 6b0cec467938f..f49365d14619f 100644
--- a/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
+++ b/drivers/net/wireless/broadcom/b43legacy/b43legacy.h
@@ -379,7 +379,7 @@ struct b43legacy_iv {
 	union {
 		__be16 d16;
 		__be32 d32;
-	} data __packed;
+	} __packed data;
 } __packed;
 
 #define B43legacy_PHYMODE(phytype)	(1 << (phytype))
-- 
2.39.2

