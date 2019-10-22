Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A138BE01B9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2019 12:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfJVKMj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Oct 2019 06:12:39 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38296 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbfJVKMj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Oct 2019 06:12:39 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9MACW9D019308, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9MACW9D019308
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 22 Oct 2019 18:12:32 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 22 Oct 2019 18:12:31 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v3 0/2] rtw88: update regulatory settings
Date:   Tue, 22 Oct 2019 18:12:27 +0800
Message-ID: <20191022101229.26044-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Set regulatory according to hints from kernel, and allows to
report WW country code, by wiphy_apply_custom_regulatory().

Also add a Kconfig to let user to config if
NL80211_REGDOM_SET_BY_USER is allowed. Refer to the commit
log for more details

v2 -> v3
  * split patch set for further discussion


Tzu-En Huang (2):
  rtw88: add regulatory process strategy for different chipset
  rtw88: support dynamic user regulatory setting

 drivers/net/wireless/realtek/rtw88/Kconfig | 10 ++++
 drivers/net/wireless/realtek/rtw88/main.c  |  6 ++-
 drivers/net/wireless/realtek/rtw88/main.h  |  1 +
 drivers/net/wireless/realtek/rtw88/regd.c  | 61 ++++++++++++++++++----
 4 files changed, 65 insertions(+), 13 deletions(-)

-- 
2.17.1

