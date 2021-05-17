Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B03038266F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 May 2021 10:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbhEQIQE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 May 2021 04:16:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3003 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbhEQIQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 May 2021 04:16:03 -0400
Received: from dggems702-chm.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FkBgz272MzmVxd;
        Mon, 17 May 2021 16:12:31 +0800 (CST)
Received: from dggema704-chm.china.huawei.com (10.3.20.68) by
 dggems702-chm.china.huawei.com (10.3.19.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:45 +0800
Received: from localhost.localdomain (10.67.165.2) by
 dggema704-chm.china.huawei.com (10.3.20.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Mon, 17 May 2021 16:14:45 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yang Shen" <shenyang39@huawei.com>
Subject: [PATCH 00/11] Rid W=1 warnings in wireless
Date:   Mon, 17 May 2021 13:01:30 +0800
Message-ID: <20210517050141.61488-1-shenyang39@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema704-chm.china.huawei.com (10.3.20.68)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a set to fully clean drivers/net/wireless.

Yang Shen (11):
  net: ath: ath5k: Fix wrong function name in comments
  net: ath: Fix wrong function name in comments
  net: ath: wil6210: Fix wrong function name in comments
  net: broadcom: brcmfmac: Demote non-compliant kernel-doc headers
  net: intel: ipw2x00: Fix wrong function name in comments
  net: intel: iwlwifi: Demote non-compliant kernel-doc headers
  net: marvell: libertas_tf: Fix wrong function name in comments
  net: realtek: rtlwifi: Fix wrong function name in comments
  net: rsi: Fix missing function name in comments
  net: ti: wl1251: Fix missing function name in comments
  net: ti: wlcore: Fix missing function name in comments

 drivers/net/wireless/ath/ath5k/pcu.c                    | 2 +-
 drivers/net/wireless/ath/hw.c                           | 2 +-
 drivers/net/wireless/ath/wil6210/interrupt.c            | 2 +-
 drivers/net/wireless/ath/wil6210/wmi.c                  | 6 +++---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c  | 2 +-
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c | 2 +-
 drivers/net/wireless/intel/ipw2x00/ipw2100.c            | 8 ++++----
 drivers/net/wireless/intel/iwlwifi/mvm/rfi.c            | 4 ++--
 drivers/net/wireless/marvell/libertas_tf/if_usb.c       | 2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8192cu/mac.c    | 4 ++--
 drivers/net/wireless/rsi/rsi_91x_mgmt.c                 | 4 ++--
 drivers/net/wireless/ti/wl1251/cmd.c                    | 8 ++++----
 drivers/net/wireless/ti/wlcore/cmd.c                    | 6 +++---
 13 files changed, 26 insertions(+), 26 deletions(-)

--
2.17.1

