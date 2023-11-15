Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E497E3D00
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:24:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234412AbjKGMYz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbjKGMYn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:24:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245A55B83;
        Tue,  7 Nov 2023 04:13:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1FEC43395;
        Tue,  7 Nov 2023 12:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699359223;
        bh=2KCPMisBXDU4LoMU8mGqNJX9Y0yd8sOSrc0b5LukUqs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPsd3O93UTCUeuXNW2hpxcPicWp1iij0OHHMdQRMdE7PKpmQ8Y1K1BJkEOzw922aC
         5gIZnA04cXTX7yoheftP67pU1EFaIK96LL8wpQA2LBp+E8Mq1K6rMRCN3UvXds75kh
         icucHJIqxGTgUByCn27eP4/dUChcsf+KsRN7Rp7Z4+ewUcc71shBj103nipcC9zSeV
         HnpEiNvgLHM8lebyV6GesxWvlkl58qm32x6wASogNtHZXoMSfrqhJLhX31k9Ib/hEw
         IrDzmp5prRSNQ+LGnoHA0s8MJnNAXb63Vf/vRjmQHs5PqeDtYFiZI1YkC90Vis7Kxd
         ZlrFjVlqpetLg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 4.14 3/4] wifi: ath10k: fix clang-specific fortify warning
Date:   Tue,  7 Nov 2023 07:13:33 -0500
Message-ID: <20231107121337.3759240-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107121337.3759240-1-sashal@kernel.org>
References: <20231107121337.3759240-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.328
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

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit cb4c132ebfeac5962f7258ffc831caa0c4dada1a ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/ath/ath10k/debug.c:8:
In file included from ./include/linux/module.h:13:
In file included from ./include/linux/stat.h:19:
In file included from ./include/linux/time.h:60:
In file included from ./include/linux/time32.h:13:
In file included from ./include/linux/timex.h:67:
In file included from ./arch/x86/include/asm/timex.h:5:
In file included from ./arch/x86/include/asm/processor.h:23:
In file included from ./arch/x86/include/asm/msr.h:11:
In file included from ./arch/x86/include/asm/cpumask.h:5:
In file included from ./include/linux/cpumask.h:12:
In file included from ./include/linux/bitmap.h:11:
In file included from ./include/linux/string.h:254:
./include/linux/fortify-string.h:592:4: warning: call to '__read_overflow2_field'
declared with 'warning' attribute: detected read beyond size of field (2nd
parameter); maybe use struct_group()? [-Wattribute-warning]
                        __read_overflow2_field(q_size_field, size);

The compiler actually complains on 'ath10k_debug_get_et_strings()' where
fortification logic inteprets call to 'memcpy()' as an attempt to copy
the whole 'ath10k_gstrings_stats' array from it's first member and so
issues an overread warning. This warning may be silenced by passing
an address of the whole array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230829093652.234537-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath10k/debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 22003895f8548..591d0b9c0be3c 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -1411,7 +1411,7 @@ void ath10k_debug_get_et_strings(struct ieee80211_hw *hw,
 				 u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath10k_gstrings_stats,
+		memcpy(data, ath10k_gstrings_stats,
 		       sizeof(ath10k_gstrings_stats));
 }
 
-- 
2.42.0

