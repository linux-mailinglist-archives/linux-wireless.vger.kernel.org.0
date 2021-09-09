Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213B3404CC0
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Sep 2021 14:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245058AbhIIL52 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Sep 2021 07:57:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240711AbhIILzb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Sep 2021 07:55:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4557613D0;
        Thu,  9 Sep 2021 11:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631187909;
        bh=S/mYC2aZPFp2a9cuahC+9ncNQUxRy7at7ImfNz5LxPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jaQ7NSxSW+thnSanFKHdaMbmtPpn1bbd2zg4NEjk1ez7DR7RWd8Tn+0xjEqrbjek1
         unep8s5ck8rEduWjPvzOHh+Ukz3XP0e+WtLa6zRmQll58GObE6QHgr9pTd/m73+SlU
         nfjenQvxSx7FcjuceGBoCYo1tsgCxcOBFK7bXWXEgN6ZJ5wJ7k+3x4ddeyLqL9SXNR
         jU29T36p6tIMHZFRDv9CURZtK+pJX9BwtKyfqnqhk77C4612e4zmzGuuA4ZEc+MKY6
         zqxBhLv7zII2eb9vu4dDPqicX7aM7uPptYaSJnkHOlT9F89JQL5NRtDPV2gyz8S8aI
         i7gX9o9pkJ1tg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        kernel test robot <lkp@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 186/252] rtw88: wow: build wow function only if CONFIG_PM is on
Date:   Thu,  9 Sep 2021 07:40:00 -0400
Message-Id: <20210909114106.141462-186-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit 05e45887382c4c0f9522515759b34991aa17e69d ]

The kernel test robot reports undefined reference after we report wakeup
reason to mac80211. This is because CONFIG_PM is not defined in the testing
configuration file. In fact, functions within wow.c are used if CONFIG_PM
is defined, so use CONFIG_PM to decide whether we build this file or not.

The reported messages are:
   hppa-linux-ld: drivers/net/wireless/realtek/rtw88/wow.o: in function `rtw_wow_show_wakeup_reason':
>> (.text+0x6c4): undefined reference to `ieee80211_report_wowlan_wakeup'
>> hppa-linux-ld: (.text+0x6e0): undefined reference to `ieee80211_report_wowlan_wakeup'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Link: https://lore.kernel.org/r/20210728014335.8785-4-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw88/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index c0e4b111c8b4..73d6807a8cdf 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -15,9 +15,9 @@ rtw88_core-y += main.o \
 	   ps.o \
 	   sec.o \
 	   bf.o \
-	   wow.o \
 	   regd.o
 
+rtw88_core-$(CONFIG_PM) += wow.o
 
 obj-$(CONFIG_RTW88_8822B)	+= rtw88_8822b.o
 rtw88_8822b-objs		:= rtw8822b.o rtw8822b_table.o
-- 
2.30.2

