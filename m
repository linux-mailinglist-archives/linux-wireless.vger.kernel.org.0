Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CB37E3B79
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Nov 2023 13:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjKGMHK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Nov 2023 07:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbjKGMHJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Nov 2023 07:07:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF8B0;
        Tue,  7 Nov 2023 04:07:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06254C433C8;
        Tue,  7 Nov 2023 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699358827;
        bh=sRiXMLpheY4QGeKZeXYbo4dw7/5A4/r9949x82S4fL8=;
        h=From:To:Cc:Subject:Date:From;
        b=Wrkfflj/ZDDo0HgAfjFbRik4Ai69sKRxUBqVIOF8UFRouppDqkbUNwe+OxuHTPFAk
         2AvjF13ffzV9zqrRKNGTWPDdvRpNsQREU6DxIfCl85oo++7c48cHotkNBMSP3bWMim
         HAn0LZC8d11TlsUUX3MDYUspF+bvZO7lagKGVhc+7v/axZ07n/Qpb2ozrRxxDA+g3M
         9QCOnxyFcQdtvtBFEeEBg39b4x9AMlPtImuq+U0PCsCYhoXfsWnDbs9Eoi6trKjMOK
         1spuUYU4ecae0QGr2YYEXLDggWXFClhUP9NtLzyBNGrMRP816nMLCusbl4+Lf0BF1J
         HoH0fs9qpnvKQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>,
        srini.raju@purelifi.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-wireless@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 01/31] wifi: plfxlc: fix clang-specific fortify warning
Date:   Tue,  7 Nov 2023 07:05:48 -0500
Message-ID: <20231107120704.3756327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

[ Upstream commit a763e92c78615ea838f5b9a841398b1d4adb968e ]

When compiling with clang 16.0.6 and CONFIG_FORTIFY_SOURCE=y, I've
noticed the following (somewhat confusing due to absence of an actual
source code location):

In file included from drivers/net/wireless/purelifi/plfxlc/mac.c:6:
In file included from ./include/linux/netdevice.h:24:
In file included from ./include/linux/timer.h:6:
In file included from ./include/linux/ktime.h:24:
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

The compiler actually complains on 'plfxlc_get_et_strings()' where
fortification logic inteprets call to 'memcpy()' as an attempt to copy
the whole 'et_strings' array from its first member and so issues an
overread warning. This warning may be silenced by passing an address
of the whole array and not the first member to 'memcpy()'.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230829094541.234751-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/purelifi/plfxlc/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/purelifi/plfxlc/mac.c b/drivers/net/wireless/purelifi/plfxlc/mac.c
index 94ee831b5de35..506d2f31efb5a 100644
--- a/drivers/net/wireless/purelifi/plfxlc/mac.c
+++ b/drivers/net/wireless/purelifi/plfxlc/mac.c
@@ -666,7 +666,7 @@ static void plfxlc_get_et_strings(struct ieee80211_hw *hw,
 				  u32 sset, u8 *data)
 {
 	if (sset == ETH_SS_STATS)
-		memcpy(data, *et_strings, sizeof(et_strings));
+		memcpy(data, et_strings, sizeof(et_strings));
 }
 
 static void plfxlc_get_et_stats(struct ieee80211_hw *hw,
-- 
2.42.0

