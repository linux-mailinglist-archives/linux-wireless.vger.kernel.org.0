Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB77885CB2
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731281AbfHHIWx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 04:22:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32921 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731677AbfHHIWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 04:22:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x788MZMH001614, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x788MZMH001614
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 8 Aug 2019 16:22:36 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 16:22:35 +0800
From:   <yhchuang@realtek.com>
To:     <jwboyer@kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-wireless@vger.kernel.org>,
        <Larry.Finger@lwfinger.net>, <briannorris@chromium.org>,
        <arend.vanspriel@broadcom.com>
Subject: [PATCH v3 0/3] rtw88: update 8822c firmware files
Date:   Thu, 8 Aug 2019 16:22:26 +0800
Message-ID: <1565252549-25524-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Update 8822c firmware image, and add wowlan firmware.
Also add a README to describe its usage.

Yan-Hsuan Chuang (3):
  rtw88: RTL8822C: update rtw8822c_fw.bin to v7.3
  rtw88: RTL8822C: add WoW firmware v7.3
  rtw88: add a README file

 WHENCE                    |   1 +
 rtw88/README              |  28 ++++++++++++++++++++++++++++
 rtw88/rtw8822c_fw.bin     | Bin 184640 -> 189152 bytes
 rtw88/rtw8822c_wow_fw.bin | Bin 0 -> 138720 bytes
 4 files changed, 29 insertions(+)
 create mode 100644 rtw88/README
 create mode 100755 rtw88/rtw8822c_wow_fw.bin

-- 
2.7.4

