Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADDE83887E5
	for <lists+linux-wireless@lfdr.de>; Wed, 19 May 2021 08:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238358AbhESHAQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 May 2021 03:00:16 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3022 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhESHAQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 May 2021 03:00:16 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FlNt54fmVzNywS;
        Wed, 19 May 2021 14:55:25 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:55 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 19 May 2021 14:58:55 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tanghui20@huawei.com>
Subject: [PATCH 0/3] net: wireless: remove leading spaces before tabs
Date:   Wed, 19 May 2021 14:55:42 +0800
Message-ID: <1621407345-10625-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are a few leading spaces before tabs and remove it by running the
following commard:

	$ find . -name '*.c' | xargs sed -r -i 's/^[ ]+\t/\t/'

Hui Tang (3):
  net: libertas: remove leading spaces before tabs
  rt2x00: remove leading spaces before tabs
  net: ti: remove leading spaces before tabs

 drivers/net/wireless/marvell/libertas/main.c   | 2 +-
 drivers/net/wireless/ralink/rt2x00/rt2800lib.c | 2 +-
 drivers/net/wireless/ti/wlcore/main.c          | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

--
2.8.1

