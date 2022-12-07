Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C5645406
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 07:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiLGGbM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 01:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLGGbJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 01:31:09 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE695986A
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 22:31:07 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRnTN44yzzJqJL;
        Wed,  7 Dec 2022 14:30:16 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 14:30:35 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH v2 0/3] wifi: rtlwifi: don't call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 7 Dec 2022 14:28:20 +0800
Message-ID: <20221207062823.3474551-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It is not allowed to call kfree_skb() from hardware interrupt
context or with interrupts being disabled. This patchset is
trying to add all skb to a free list, then free them after
spin_unlock_irqrestore() at once.

v1 -> v2:
  change subject prefix to "wifi: rtlwifi: ..."

Yang Yingliang (3):
  wifi: rtlwifi: rtl8821ae: don't call kfree_skb() under
    spin_lock_irqsave()
  wifi: rtlwifi: rtl8188ee: don't call kfree_skb() under
    spin_lock_irqsave()
  wifi: rtlwifi: rtl8723be: don't call kfree_skb() under
    spin_lock_irqsave()

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c | 6 +++++-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 6 +++++-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.25.1

