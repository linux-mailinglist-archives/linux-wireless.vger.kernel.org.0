Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAC665ACDD
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Jan 2023 03:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjABCjd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 21:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjABCjc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 21:39:32 -0500
Received: from out20-122.mail.aliyun.com (out20-122.mail.aliyun.com [115.124.20.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A19CDEF
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 18:39:27 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5725003|-1;BR=01201311R111S09rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.290647-0.00285302-0.7065;FP=18367113800495117735|1|1|1|0|-1|-1|-1;HT=ay29a033018047199;MF=aiden.leong@aibsd.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.QiPcClv_1672627163;
Received: from localhost.localdomain(mailfrom:aiden.leong@aibsd.com fp:SMTPD_---.QiPcClv_1672627163)
          by smtp.aliyun-inc.com;
          Mon, 02 Jan 2023 10:39:24 +0800
From:   Aiden Leong <aiden.leong@aibsd.com>
To:     linux-wireless@vger.kernel.org
Cc:     gregory.greenman@intel.com, kvalo@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        Aiden Leong <aiden.leong@aibsd.com>
Subject: [PATCH 0/2] iwlwifi: pcie: add support for AX101NGW 
Date:   Mon,  2 Jan 2023 10:37:55 +0800
Message-Id: <20230102023754.2868-1-aiden.leong@aibsd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1. A submodel of AX101 is not working, so I add support for it.
2. A simple bug was introduced 2 years ago. It affects the order of
config items in an array.

Aiden Leong (2):
  iwlwifi: pcie: add support for AX101NGW
  iwlwifi: pcie: add support for AX101NGW

 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.39.0

