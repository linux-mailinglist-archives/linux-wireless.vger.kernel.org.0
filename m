Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81417203884
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jun 2020 15:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgFVN4q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jun 2020 09:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbgFVN4q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jun 2020 09:56:46 -0400
Received: from mxout013.mail.hostpoint.ch (mxout013.mail.hostpoint.ch [IPv6:2a00:d70:0:e::313])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DDCC061573
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2020 06:56:45 -0700 (PDT)
Received: from [10.0.2.46] (helo=asmtp013.mail.hostpoint.ch)
        by mxout013.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jnMP2-000Ew0-2J; Mon, 22 Jun 2020 15:22:24 +0200
Received: from [2a02:168:6182:1:4840:f038:bf12:aa10] (helo=ryzen2700.dss.husqvarnagroup.com)
        by asmtp013.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1jnMP1-0006GV-KD; Mon, 22 Jun 2020 15:22:23 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
From:   Reto Schneider <code@reto-schneider.ch>
To:     linux-wireless@vger.kernel.org
Cc:     Larry.Finger@lwfinger.net, Reto Schneider <code@reto-schneider.ch>
Subject: [PATCH 0/3] rtl8192cu: Fixes for leaks and deadlock
Date:   Mon, 22 Jun 2020 15:21:10 +0200
Message-Id: <20200622132113.14508-1-code@reto-schneider.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Issues have been found on a Realtek RTL8188CUS/Atmel AT91SAM9G25
(ARMv5) machine. Testing has been done on the same.

Reto Schneider (3):
  rtl8192cu: Fix deadlock
  rtl8192cu: Prevent leaking urb
  rtl8192cu: Free ieee80211_hw if probing fails

 drivers/net/wireless/realtek/rtlwifi/usb.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.20.1

