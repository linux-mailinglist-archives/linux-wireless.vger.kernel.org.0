Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9D4A64DE
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 11:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfICJO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 05:14:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42349 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfICJO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 05:14:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x839EDMs027794, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x839EDMs027794
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:14:13 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Sep 2019 17:14:12 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <jano.vesely@gmail.com>,
        <linux@endlessm.com>, <briannorris@chromium.org>,
        <gojun077@gmail.com>, <drake@endlessm.com>, <davem@davemloft.net>,
        <jian-hong@endlessm.com>
Subject: [PATCH rebased 0/2] rtw88: pci: interrupt routine improvement
Date:   Tue, 3 Sep 2019 17:14:05 +0800
Message-ID: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

This patch set includes two patches to improve PCI interrupt routine.
One is to reduce HW IRQ time, the other is to enable MSI.

The patches can be found at:
https://patchwork.kernel.org/patch/11114043/
https://patchwork.kernel.org/patch/11126007/

They were rebased properly to resolve conflicts.


Jian-Hong Pan (1):
  rtw88: pci: Move a mass of jobs in hw IRQ to soft IRQ

Yu-Yen Ting (1):
  rtw88: pci: enable MSI interrupt

 drivers/net/wireless/realtek/rtw88/pci.c | 70 +++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 6 deletions(-)

-- 
2.7.4

