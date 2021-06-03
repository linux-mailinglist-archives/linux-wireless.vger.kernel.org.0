Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57864399C70
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 10:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbhFCIY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 04:24:28 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3404 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhFCIY1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 04:24:27 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Fwf1X6LXTz68F6
        for <linux-wireless@vger.kernel.org>; Thu,  3 Jun 2021 16:18:56 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:22:42 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:22:41 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/1] ssb: use DEVICE_ATTR_ADMIN_RW() helper macro
Date:   Thu, 3 Jun 2021 16:22:17 +0800
Message-ID: <20210603082218.11718-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

v1 --> v2:
Update commit message.


Zhen Lei (1):
  ssb: use DEVICE_ATTR_ADMIN_RW() helper macro

 drivers/ssb/pci.c    | 16 +++++++---------
 drivers/ssb/pcmcia.c | 16 +++++++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

-- 
2.26.0.106.g9fadedd


