Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9245A790AA0
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Sep 2023 05:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235606AbjICDCh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 2 Sep 2023 23:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjICDCg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 2 Sep 2023 23:02:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4A16110
        for <linux-wireless@vger.kernel.org>; Sat,  2 Sep 2023 20:02:31 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Rdc0S3z3QztRrs;
        Sun,  3 Sep 2023 10:58:32 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sun, 3 Sep
 2023 11:02:27 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <gregory.greenman@intel.com>, <kvalo@kernel.org>,
        <briannorris@chromium.org>, <nbd@nbd.name>, <lorenzo@kernel.org>,
        <ryder.lee@mediatek.com>, <shayne.chen@mediatek.com>,
        <sean.wang@mediatek.com>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <avraham.stern@intel.com>, <johannes.berg@intel.com>,
        <emmanuel.grumbach@intel.com>, <trix@redhat.com>,
        <dmantipov@yandex.ru>, <christophe.jaillet@wanadoo.fr>,
        <yangyang@marvell.com>, <linville@tuxdriver.com>,
        <rramesh@marvell.com>, <akarwar@marvell.com>,
        <nishants@marvell.com>, <linux-wireless@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH wireless-next v2 0/3] wifi: Drop unnecessary error checks for debugfs_create_dir()
Date:   Sun, 3 Sep 2023 11:02:13 +0800
Message-ID: <20230903030216.1509013-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

debugfs_create_dir() returns ERR_PTR and never returns NULL.

As Russell suggested, this patch set removes the error checking for
debugfs_create_dir(). This is because the DebugFS kernel API is developed
in a way that the caller can safely ignore the errors that occur during
the creation of DebugFS nodes. The debugfs APIs have a IS_ERR() judge in
start_creating() which can handle it gracefully. So these checks are
unnecessary.

Changes in v2:
- Update the subject prefix from net to wireless-next as suggested.
- Remove the err check instead of using IS_ERR to replace NULL check.
- Update the commit message and title.

Jinjie Ruan (3):
  wifi: iwlwifi: mei: Drop unnecessary error check for
    debugfs_create_dir()
  mwifiex: debugfs: Drop unnecessary error check for
    debugfs_create_dir()
  wifi: mt76: Drop unnecessary error check for debugfs_create_dir()

 drivers/net/wireless/intel/iwlwifi/mei/main.c  | 3 ---
 drivers/net/wireless/marvell/mwifiex/debugfs.c | 3 ---
 drivers/net/wireless/mediatek/mt76/debugfs.c   | 2 --
 3 files changed, 8 deletions(-)

-- 
2.34.1

