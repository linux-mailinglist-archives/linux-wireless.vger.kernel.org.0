Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E587E3BEE
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbjKGMLN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjKGMKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:10:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487B198A;
        Tue,  7 Nov 2023 04:09:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDBC433CA;
        Tue,  7 Nov 2023 12:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358968;
        bh=3cwRqHfHVTe9ImwN6Sd4/abfuPlQ7UDcvXHyTIcVNCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TBvoP9ZmFp/hPJsTQgUvIRsqJC43DJl3iz9IUF4sXi9VsLYC79pKVdszlZl0c0Ous
         AdT6q8k+FrxCa/nzBsNV3L0t0p4po1OblloTqCXN10qg2RMzRPntzOiFB0cE+OvQ0o
         8PUCfE2xSxOODZISVc+c2kGe6vWM90jTguiliho07oSeedppYDJ3n0PcUxeQ1C9gkD
         XF6JV1mPSs5lS/R5LuFofEnkCXeZtqhSKRJ0fpmvVG4HXJKWC0ejWp2Rl3Xs0XRXyc
         fQ0BVNDh2VrL4/3dbCqBsmpVK/onFoYBCYS3l4aOYJB5QI6A2XPi6nqtIdtzZ4GozB
         Y/64XfuJQ58Dg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Johannes Berg <johannes.berg@intel.com>,
        Sasha Levin <sashal@kernel.org>, johannes@sipsolutions.net,
        kvalo@kernel.org, nathan@kernel.org, ndesaulniers@google.com,
        linux-wireless@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.5 03/30] wifi: mac80211_hwsim: fix clang-specific fortify warning
Date:   Tue,  7 Nov 2023 07:08:18 -0500
Message-ID: <20231107120922.3757126-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107120922.3757126-1-sashal@kernel.org>
References: <20231107120922.3757126-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
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

[ Upstream commit cbaccdc42483c65016f1bae89128c08dc17cfb2a ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/virtual/mac80211_hwsim.c:18:
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

The compiler actually complains on 'mac80211_hwsim_get_et_strings()' where
fortification logic inteprets call to 'memcpy()' as an attempt to copy the
whole 'mac80211_hwsim_gstrings_stats' array from its first member and so
issues an overread warning. This warning may be silenced by passing
an address of the whole array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://lore.kernel.org/r/20230829094140.234636-1-dmantipov@yandex.ru
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 23307c8baea21..6dc153a267872 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -3170,7 +3170,7 @@ static void mac80211_hwsim_get_et_strings(struct ieee80211_hw *hw,
 					  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *mac80211_hwsim_gstrings_stats,
+		memcpy(data, mac80211_hwsim_gstrings_stats,
 		       sizeof(mac80211_hwsim_gstrings_stats));
 }
 
-- 
2.42.0

