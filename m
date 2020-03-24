Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EC681906CD
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 08:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCXHw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 03:52:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57968 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgCXHw1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 03:52:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 02O7qJtp025524, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 02O7qJtp025524
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Mar 2020 15:52:20 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 15:52:19 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 24 Mar 2020 15:52:19 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <tehuang@realtek.com>
Subject: [PATCH v6 0/2] rtw88: update regulatory settings
Date:   Tue, 24 Mar 2020 15:52:14 +0800
Message-ID: <20200324075216.22553-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patchset applies regulatory rules for Realtek's chip set.

Some of the modules are programmed country-specific code in the efuse.
And for this kind of modules, driver doesn't want the regulatory to be
changed, so the driver tends to not listen to the regulatory hint that
is notified by the stack. Otherwise if the modules are not programmed
to a country-specific code, then the world-wide (WW) settings will be
adopted. If the regulatory is WW, the driver will apply the settings
notified by the stack.

If anyone wants to allow regulatory being set from user-space tools
(ex: iw reg set), a compile option flag RTW88_REGD_USER_REG_HINTS
should be set to allow regulatory hist from user.

Also add "Adaptivity" support for some special country codes, because
they have to stop TX immediately if there's any energy detected.


v2 -> v3
  * split patch set for further discussion

v3 -> v4
  * squash patch set, since nobody has different idea for it
  * "rtw88: add regulatory process strategy for different chipset" and
    "rtw88: support dynamic user regulatory setting" are squashed
  * modify the commit log to better describe it
  * add a new patch for adaptivity support "rtw88: add adaptivity
    support for EU/JP regulatory"

v4 -> v5
  * check return value of kstrtobool()

v5 -> v6
  * remove custom world-wide, use stack world-wide
  * surface err codes by printing logs
  * fix incorrect debugfs set parameter for edcca enable


Tzu-En Huang (2):
  rtw88: add regulatory process strategy for different chipset
  rtw88: add adaptivity support for EU/JP regulatory

 drivers/net/wireless/realtek/rtw88/Kconfig    | 10 +++
 drivers/net/wireless/realtek/rtw88/debug.c    | 40 ++++++++++
 drivers/net/wireless/realtek/rtw88/main.c     |  6 +-
 drivers/net/wireless/realtek/rtw88/main.h     | 32 ++++++++
 drivers/net/wireless/realtek/rtw88/phy.c      | 60 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.h      |  2 +
 drivers/net/wireless/realtek/rtw88/reg.h      |  2 +
 drivers/net/wireless/realtek/rtw88/regd.c     | 75 ++++++++++++++++---
 drivers/net/wireless/realtek/rtw88/regd.h     |  2 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 41 ++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822b.h |  6 ++
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 45 +++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8822c.h |  2 +
 13 files changed, 311 insertions(+), 12 deletions(-)

-- 
2.17.1

