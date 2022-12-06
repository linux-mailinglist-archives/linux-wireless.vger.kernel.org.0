Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFF0644463
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 14:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiLFNQU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 08:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiLFNPv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 08:15:51 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3004B286D0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 05:15:05 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRLQ34Hv1zqSq9;
        Tue,  6 Dec 2022 21:10:51 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 21:15:00 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH resend 0/3] rtlwifi: don't call kfree_skb() under spin_lock_irqsave()
Date:   Tue, 6 Dec 2022 21:12:46 +0800
Message-ID: <20221206131249.2181693-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

Yang Yingliang (3):
  rtlwifi: rtl8821ae: don't call kfree_skb() under spin_lock_irqsave()
  rtlwifi: rtl8188ee: don't call kfree_skb() under spin_lock_irqsave()
  rtlwifi: rtl8723be: don't call kfree_skb() under spin_lock_irqsave()

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c | 6 +++++-
 drivers/net/wireless/realtek/rtlwifi/rtl8723be/hw.c | 6 +++++-
 drivers/net/wireless/realtek/rtlwifi/rtl8821ae/hw.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

-- 
2.25.1

