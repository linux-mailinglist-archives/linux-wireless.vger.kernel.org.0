Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA39B691B41
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Feb 2023 10:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231806AbjBJJ1J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Feb 2023 04:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjBJJ1H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Feb 2023 04:27:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE1234020
        for <linux-wireless@vger.kernel.org>; Fri, 10 Feb 2023 01:27:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1pQPgI-0003Uo-2u; Fri, 10 Feb 2023 10:26:58 +0100
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pQPg9-003w5z-LF; Fri, 10 Feb 2023 10:26:50 +0100
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1pQPg9-002tIB-Tw; Fri, 10 Feb 2023 10:26:49 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-wireless@vger.kernel.org
Cc:     Neo Jou <neojou@gmail.com>, Hans Ulli Kroll <linux@ulli-kroll.de>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        Kalle Valo <kvalo@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        kernel@pengutronix.de, Alexander Hochbaum <alex@appudo.com>,
        Da Xue <da@libre.computer>, Po-Hao Huang <phhuang@realtek.com>,
        Andreas Henriksson <andreas@fatal.se>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 0/2] wifi: rtw88: USB fixes
Date:   Fri, 10 Feb 2023 10:26:40 +0100
Message-Id: <20230210092642.685905-1-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-wireless@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This series addresses issues for the recently added RTW88 USB support
reported by Andreas Henriksson and also our customer.

The hardware can't handle urbs that have a size of multiple of the
bulkout_size (usually 512 bytes). The symptom is that the hardware
stalls completely. The issue can be reproduced by sending a suitably
sized ping packet from the device:

ping -s 394 <somehost>

(It's 394 bytes here on a RTL8822CU and RTL8821CU, the actual size may
differ on other chips, it was 402 bytes on a RTL8723DU)

Other than that qsel was not set correctly. The sympton here is that
only one of multiple bulk endpoints was used to send data.

Sascha

Sascha Hauer (2):
  wifi: rtw88: usb: Set qsel correctly
  wifi: rtw88: usb: Fix urbs with size multiple of bulkout_size

 drivers/net/wireless/realtek/rtw88/tx.h  |  2 ++
 drivers/net/wireless/realtek/rtw88/usb.c | 36 +++++++++++++++---------
 2 files changed, 25 insertions(+), 13 deletions(-)

-- 
2.30.2

