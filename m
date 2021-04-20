Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA851364FB3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhDTBKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Apr 2021 21:10:55 -0400
Received: from smtp6.ctinetworks.com ([205.166.61.199]:51184 "EHLO
        smtp6.ctinetworks.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhDTBKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Apr 2021 21:10:55 -0400
X-Greylist: delayed 446 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Apr 2021 21:10:55 EDT
Received: from localhost (unknown [117.193.4.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: enometh@meer.net)
        by smtp6.ctinetworks.com (Postfix) with ESMTPSA id 40EDE842C1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Apr 2021 21:02:53 -0400 (EDT)
Date:   Tue, 20 Apr 2021 06:32:44 +0530 (IST)
Message-Id: <20210420.063244.1157699536418751229.enometh@meer.net>
To:     linux-wireless@vger.kernel.org
Subject: rtw88 strange killall behaviour with nm
From:   Madhu <enometh@meer.net>
X-Mailer: Mew version 6.8 on Emacs 28.0
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ctinetworks-Information: Please contact the ISP for more information
X-ctinetworks-MailScanner-ID: 40EDE842C1.AA35C
X-ctinetworks-VirusCheck: Found to be clean
X-ctinetworks-SpamCheck: 
X-ctinetworks-Watermark: 1619744577.36636@LRWVUdOypiz8Eo9+1lO3CA
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


I was using the rtw88 on (lspci: Realtek. RTL8822CE 802.11ac PCIe on a
Lenovo Thinkbook) fairly normally on gentoo (kernel 5.10.30) with
netifrc scripts.  Recently I tried to move the scripts to
networkmanager connection files.

1. With NM the WPA-PSK connection to my AP (dlink router - india)
keeps dropping (citing a CLASS2_FRAME_FROM_NONAUTH_STA error)

2. With a specific connection file - if I activate the connection with
nmcli conn activate the kernel apparently terminates all processes on
the system except the NetworkManager process. (For added fun this
crashes the drm video + keyboard if Xorg is running requiring a
powercycle)

How could this behaviour (all tasks being terminated) possibly happen?
Is it b related specifically to the rtw88 module?  Have you heard of
anything like this before?

[Other Issues I had were

3. occasional RIPs "purge skb(s) not reported by firmware"

4. RIPs when I try to run kismet which may be related to:

5. Usually I see only 2-3 APs from this card on linux. On a b43 driver
older laptop I can usually see 10-15 APs at the same time. I suspect
the kismet RIPS happen when processing these other APs
]

In any case I'm intrigued by the (2) kernel repeatably killing off all
my processes when nmcli fires up.  This is a bit hard to debug as
there is nothing helpful in dmesg afaict. (and syslog exits early)

How is this even possible. (Offhand I can't spot where nm is calling
killall)
