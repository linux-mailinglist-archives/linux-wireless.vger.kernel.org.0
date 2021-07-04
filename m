Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992463BAD7A
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jul 2021 16:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhGDOoa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jul 2021 10:44:30 -0400
Received: from mail.thinkpuffy.com ([198.13.45.55]:20008 "EHLO
        mail.thinkpuffy.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhGDOo1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jul 2021 10:44:27 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jul 2021 10:44:27 EDT
Received: from localhost (www.thinkpuffy.com [local])
        by www.thinkpuffy.com (OpenSMTPD) with ESMTPA id 59a2bf88
        for <linux-wireless@vger.kernel.org>;
        Sun, 4 Jul 2021 23:35:10 +0900 (JST)
Date:   Sun, 4 Jul 2021 23:35:10 +0900
From:   Doug Brewer <brewerdoug@gmail.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: rtw89: product id 0xa85a support on Linux?
Message-ID: <20210704143510.GA5787@www.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

The HP Laptop 15s-eq2028ur have a Realtek 802.11ax device. lspci -n shows

01:00.0 Network controller [0280]: Realtek Semiconductor Co., Ltd. Device [10ec:
a85a]

I tried pkshih's rtw89 patchsets [1] and added PID to rtw89_pci_id_table.
Scanning works but cannot connect to access points.
dmesg shows like (hiding MAC address):

rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0, type 1
rtw89_pci 0000:01:00.0: Firmware version 0.13.8.0, cmd version 0, type 3
rtw89_pci 0000:01:00.0: chip rfe_type is 1                
wlan0: authenticate with xx:xx:xx:xx:xx:xx
wlan0: send auth to xx:xx:xx:xx:xx:xx (try 1/3)
wlan0: authenticated
wlan0: associate with xx:xx:xx:xx:xx:xx (try 1/3)
wlan0: RX AssocResp from xx:xx:xx:xx:xx:xx (capab=0x411 status=0 aid=1)
wlan0: associated
rtw89_pci 0000:01:00.0: c2h reg timeout
rtw89_pci 0000:01:00.0: FW does not process h2c registers
rtw89_pci 0000:01:00.0: timed out to flush queues

rtw89 will be the driver to support this wifi model? Thanks.

[1] https://www.spinics.net/lists/linux-wireless/msg212019.html

BR,
Doug.
