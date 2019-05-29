Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39D5E2D70D
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2019 09:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfE2Hyz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 03:54:55 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37188 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbfE2Hyz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 03:54:55 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4T7soVv005538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4T7soVv005538
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Wed, 29 May 2019 15:54:50 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Wed, 29 May 2019 15:54:50 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 00/11] rtw88: power index setting routine updates and fixes
Date:   Wed, 29 May 2019 15:54:36 +0800
Message-ID: <1559116487-5244-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set updates the power index setting routine for rtw88.

The first commit "rtw88: resolve order of tx power setting routines"
is to reorder the functions to not to expose some functions used
internally.

The following commits:
    "rtw88: do not use (void *) as argument"
    "rtw88: unify prefixes for tx power setting routine"
    "rtw88: remove unused variable"

are minor refinements to make the routine look better.

The following commits:
    "rtw88: fix incorrect tx power limit at 5G"
    "rtw88: choose the lowest as world-wide power limit"
    "rtw88: correct power limit selection"
    "rtw88: update tx power limit table to RF v20"
    "rtw88: remove all RTW_MAX_POWER_INDEX macro"

are fixes to get correct tx power index, also update the power
limit table to the latest.

The following commits:
    "rtw88: refine flow to get tx power index"
    "rtw88: debug: dump tx power indexes in use"

add a debugfs entry to dump power index by rate, by limit and by base.
This is useful for us to check if correct power indexes are used.


Tzu-En Huang (1):
  rtw88: remove all RTW_MAX_POWER_INDEX macro

Yan-Hsuan Chuang (6):
  rtw88: resolve order of tx power setting routines
  rtw88: do not use (void *) as argument
  rtw88: unify prefixes for tx power setting routine
  rtw88: remove unused variable
  rtw88: fix incorrect tx power limit at 5G
  rtw88: choose the lowest as world-wide power limit

Zong-Zhe Yang (4):
  rtw88: correct power limit selection
  rtw88: update tx power limit table to RF v20
  rtw88: refine flow to get tx power index
  rtw88: debug: dump tx power indexes in use

 drivers/net/wireless/realtek/rtw88/debug.c         |  112 ++
 drivers/net/wireless/realtek/rtw88/main.c          |   26 +-
 drivers/net/wireless/realtek/rtw88/main.h          |   27 +-
 drivers/net/wireless/realtek/rtw88/phy.c           | 1298 +++++++++++---------
 drivers/net/wireless/realtek/rtw88/phy.h           |   18 +-
 drivers/net/wireless/realtek/rtw88/regd.c          |   69 +-
 drivers/net/wireless/realtek/rtw88/regd.h          |    4 +
 .../net/wireless/realtek/rtw88/rtw8822c_table.c    |  799 +++++++++++-
 8 files changed, 1653 insertions(+), 700 deletions(-)

-- 
2.7.4

