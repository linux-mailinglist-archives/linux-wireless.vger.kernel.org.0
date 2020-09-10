Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2FB4265299
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 23:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgIJOZr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 10:25:47 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730687AbgIJOK1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 10:10:27 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9BDF0119B9120C91DC7B;
        Thu, 10 Sep 2020 22:09:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 22:09:47 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@codeaurora.org>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 0/3] rtlwifi: rtl8723ae: fix comparison pointer to bool warning
Date:   Thu, 10 Sep 2020 22:16:39 +0800
Message-ID: <20200910141642.127006-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zheng Bin (3):
  rtlwifi: rtl8723ae: fix comparison pointer to bool warning in rf.c
  rtlwifi: rtl8723ae: fix comparison pointer to bool warning in trx.c
  rtlwifi: rtl8723ae: fix comparison pointer to bool warning in phy.c

 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/phy.c | 8 ++++----
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/rf.c  | 4 ++--
 drivers/net/wireless/realtek/rtlwifi/rtl8723ae/trx.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

--
2.26.0.106.g9fadedd

