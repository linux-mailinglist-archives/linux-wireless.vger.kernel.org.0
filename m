Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101FF7E3B8C
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjKGMHf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbjKGMH0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:07:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC810D8;
        Tue,  7 Nov 2023 04:07:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9EFC433CA;
        Tue,  7 Nov 2023 12:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358842;
        bh=2reg47psDXTY8h8BcqnE/3wl0uFfvugAdjPj/GA3lDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kLWXh4CtinxYntMxw9dHvlGU2e5Ht0fQ3qpp7jO5U6gpZZHQSW4ja4+Gpck9bGH2F
         yFLA2pQipeQiOd7LHL99wbP9Ll+26AWQo0ysy5TxRNAdPpUvSmaKvunR+aZ2YB/tb/
         /csKf3+rL27RDaWRkTphjK2nwTp5N4TxasCBme8kTEhfZCdNNkPIghS4ZhdaXFJ0/i
         +0dbk0hcvNtND7zkvjZUhhtA3BjjqdgTRqsFnv5JSkd1gu6rVWPbUemFskpGAxYbk8
         TiyPCpEyilf38U0JeIKUZ5HrY+UE/MZW7SPxzv/p7yV+Y+tS9Bm10NYWrnj0cQACM5
         ySPEg8bUqDCOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, kvalo@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 07/31] wifi: ath9k: fix clang-specific fortify warnings
Date:   Tue,  7 Nov 2023 07:05:54 -0500
Message-ID: <20231107120704.3756327-7-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120704.3756327-1-sashal@kernel.org>
References: <20231107120704.3756327-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6
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

[ Upstream commit 95f97fe0ac974467ab4da215985a32b2fdf48af0 ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/ath/ath9k/debug.c:17:
In file included from ./include/linux/slab.h:16:
In file included from ./include/linux/gfp.h:7:
In file included from ./include/linux/mmzone.h:8:
In file included from ./include/linux/spinlock.h:56:
In file included from ./include/linux/preempt.h:79:
In file included from ./arch/x86/include/asm/preempt.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/x86/include/asm/thread_info.h:53:
In file included from ./arch/x86/include/asm/cpufeature.h:5:
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

In file included from drivers/net/wireless/ath/ath9k/htc_drv_debug.c:17:
In file included from drivers/net/wireless/ath/ath9k/htc.h:20:
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

The compiler actually complains on 'ath9k_get_et_strings()' and
'ath9k_htc_get_et_strings()' due to the same reason: fortification logic
inteprets call to 'memcpy()' as an attempt to copy the whole array from
it's first member and so issues an overread warning. These warnings may
be silenced by passing an address of the whole array and not the first
member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Acked-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230829093856.234584-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath9k/debug.c         | 2 +-
 drivers/net/wireless/ath/ath9k/htc_drv_debug.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/debug.c b/drivers/net/wireless/ath/ath9k/debug.c
index 9bc57c5a89bfe..a0376a6787b8d 100644
--- a/drivers/net/wireless/ath/ath9k/debug.c
+++ b/drivers/net/wireless/ath/ath9k/debug.c
@@ -1293,7 +1293,7 @@ void ath9k_get_et_strings(struct ieee80211_hw *hw,
 			  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_gstrings_stats,
+		memcpy(data, ath9k_gstrings_stats,
 		       sizeof(ath9k_gstrings_stats));
 }
 
diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
index c549ff3abcdc4..278ddc713fdc2 100644
--- a/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
+++ b/drivers/net/wireless/ath/ath9k/htc_drv_debug.c
@@ -423,7 +423,7 @@ void ath9k_htc_get_et_strings(struct ieee80211_hw *hw,
 			      u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *ath9k_htc_gstrings_stats,
+		memcpy(data, ath9k_htc_gstrings_stats,
 		       sizeof(ath9k_htc_gstrings_stats));
 }
 
-- 
2.42.0

