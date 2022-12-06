Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A960E644264
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Dec 2022 12:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiLFLsa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Dec 2022 06:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLFLs2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Dec 2022 06:48:28 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D90DFE6
        for <linux-wireless@vger.kernel.org>; Tue,  6 Dec 2022 03:48:27 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NRJZ04b63zRpF7;
        Tue,  6 Dec 2022 19:47:36 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 6 Dec
 2022 19:48:25 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <kvalo@kernel.org>, <libertas-dev@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
CC:     <yangyingliang@huawei.com>
Subject: [PATCH 0/4] libertas/libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
Date:   Tue, 6 Dec 2022 19:46:05 +0800
Message-ID: <20221206114609.2006175-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
dev_kfree_skb_irq() under spin_lock_irqsave().

Yang Yingliang (4):
  libertas_tf: don't call kfree_skb() under spin_lock_irqsave()
  libertas: don't call kfree_skb() under spin_lock_irqsave() in
    process_cmdrequest()
  libertas: don't call kfree_skb() under spin_lock_irqsave() in
    lbs_stop_iface()
  libertas: don't call kfree_skb() under spin_lock_irqsave() in
    lbs_mac_event_disconnected()

 drivers/net/wireless/marvell/libertas/cmdresp.c   | 2 +-
 drivers/net/wireless/marvell/libertas/if_usb.c    | 2 +-
 drivers/net/wireless/marvell/libertas/main.c      | 2 +-
 drivers/net/wireless/marvell/libertas_tf/if_usb.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.25.1

