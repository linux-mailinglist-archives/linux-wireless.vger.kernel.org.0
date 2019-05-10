Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06FE619942
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2019 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfEJIDx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 May 2019 04:03:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59201 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfEJIDw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 May 2019 04:03:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x4A83c3o021565, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtitcasv01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x4A83c3o021565
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NOT);
        Fri, 10 May 2019 16:03:38 +0800
Received: from localhost.localdomain (172.21.69.114) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.408.0; Fri, 10 May 2019 16:03:37 +0800
From:   <pkshih@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <Larry.Finger@lwfinger.net>, <linux-wireless@vger.kernel.org>,
        <colin.king@canonical.com>
Subject: [PATCH 0/4] rtlwifi: 8192de: Fix used uninitialized variables in power tracking
Date:   Fri, 10 May 2019 16:03:29 +0800
Message-ID: <20190510080333.3789-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.114]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

This issue is found by Coverity and repoerted by Colin Ian King. An array
ofdm_index[3] is never initialized.

In order to fix this issue, I refactor the code to be more readable, and
then I investigate the variable ofdm_index[] should be initialized as
the index corresponding to thermal value programmed in efuse.

The cckswing table in the last patch is used to adjust TX power. When I
check this function, the table is in little-endian order, but compare
with register value in cpu order. Then, fix it as well.

Ping-Ke Shih (4):
  rtlwifi: 8192de: Reduce indentation and fix coding style
  rtlwifi: 8192de: make tables to be 'static const'
  rtlwifi: 8192de: Fix used uninitialized variables in power tracking
  rtlwifi: 8192de: use le32 to access cckswing tables

 .../wireless/realtek/rtlwifi/rtl8192de/dm.c   | 695 +++++++++---------
 1 file changed, 330 insertions(+), 365 deletions(-)

-- 
2.21.0

