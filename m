Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 410A9645D33
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Dec 2022 16:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLGPDY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Dec 2022 10:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiLGPCx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Dec 2022 10:02:53 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E5C3890
        for <linux-wireless@vger.kernel.org>; Wed,  7 Dec 2022 07:02:37 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NS0mQ05qxzJp6P;
        Wed,  7 Dec 2022 22:59:02 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 7 Dec
 2022 23:02:32 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <kvalo@kernel.org>, <libertas-dev@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH v2 0/4] libertas/libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 7 Dec 2022 23:00:04 +0800
Message-ID: <20221207150008.111743-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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
context or with interrupts being disabled. As the comment of
dev_kfree_skb_irq() says, kfree_skb() can be replaced with
dev_kfree_skb_irq().

v1 -> v2:
  Update commit messages.

Yang Yingliang (4):
  libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
  libertas/if_usb: don't call kfree_skb() under spin_lock_irqsave()
  libertas/main: don't call kfree_skb() under spin_lock_irqsave()
  libertas/cmdresp: don't call kfree_skb() under spin_lock_irqsave()

 drivers/net/wireless/marvell/libertas/cmdresp.c   | 2 +-
 drivers/net/wireless/marvell/libertas/if_usb.c    | 2 +-
 drivers/net/wireless/marvell/libertas/main.c      | 2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

