Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C833BACEE
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Jul 2021 13:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDLpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Jul 2021 07:45:30 -0400
Received: from deferred-out-cluster.livemail.co.uk ([213.171.216.210]:43686
        "EHLO fwd-out.cmp.livemail.co.uk" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229492AbhGDLpa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Jul 2021 07:45:30 -0400
X-Greylist: delayed 565 seconds by postgrey-1.27 at vger.kernel.org; Sun, 04 Jul 2021 07:45:30 EDT
Received: from localhost (unknown [127.0.0.1])
        by fwd-out.cmp.livemail.co.uk (Postfix) with ESMTP id D282B1FE41F
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jul 2021 11:33:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at deferred-out-02.cmp.livemail.co.uk
Received: from fwd-out.cmp.livemail.co.uk ([127.0.0.1])
        by localhost (deferred-out-02.cmp.livemail.co.uk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9QA8-LEEtsBt for <linux-wireless@vger.kernel.org>;
        Sun,  4 Jul 2021 12:33:30 +0100 (BST)
Received: from smtp.livemail.co.uk (smtp-auth-out-02.cmp.livemail.co.uk [10.44.166.51])
        by fwd-out.cmp.livemail.co.uk (Postfix) with ESMTP id 11653CB0F9
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jul 2021 12:33:30 +0100 (BST)
Received: from [192.168.0.46] (cpc104550-craw8-2-0-cust247.16-3.cable.virginm.net [82.45.190.248])
        (Authenticated sender: d@nielclark.com)
        by smtp.livemail.co.uk (Postfix) with ESMTPSA id 7D8CCC5A26
        for <linux-wireless@vger.kernel.org>; Sun,  4 Jul 2021 12:33:28 +0100 (BST)
To:     linux-wireless@vger.kernel.org
From:   Dan Clark <D@nielClark.com>
Subject: Make Issues
Message-ID: <3b25cb09-02f8-c35e-c564-f3abac4d6a32@nielClark.com>
Date:   Sun, 4 Jul 2021 12:33:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear L. W. Finger,

I'm a new Linux user and I'm trying to follow your rtw89 guide to 
install the code for my Realtek 8852AE WiFi drivers.

When running the make command i run into issues, I've included the 
terminal output so far. Any advice on how to proceed or about what I may 
be doing wrong?

Thanks in advance,

Dan


dan@Legion-5-15ACH6H:~$ git clone https://github.com/lwfinger/rtw89.git 
-b v5
Cloning into 'rtw89'...
remote: Enumerating objects: 364, done.
remote: Counting objects: 100% (364/364), done.
remote: Compressing objects: 100% (219/219), done.
remote: Total 364 (delta 250), reused 250 (delta 142), pack-reused 0
Receiving objects: 100% (364/364), 1.17 MiB | 2.13 MiB/s, done.
Resolving deltas: 100% (250/250), done.
dan@Legion-5-15ACH6H:~$ cd rtw89
dan@Legion-5-15ACH6H:~/rtw89$ make
make -C /lib/modules/5.11.0-22-generic/build M=/home/dan/rtw89 modules
make[1]: Entering directory '/usr/src/linux-headers-5.11.0-22-generic'
   CC [M]  /home/dan/rtw89/core.o
   CC [M]  /home/dan/rtw89/debug.o
   CC [M]  /home/dan/rtw89/mac80211.o
   CC [M]  /home/dan/rtw89/mac.o
   CC [M]  /home/dan/rtw89/phy.o
   CC [M]  /home/dan/rtw89/fw.o
   CC [M]  /home/dan/rtw89/rtw8852a.o
   CC [M]  /home/dan/rtw89/rtw8852a_table.o
   CC [M]  /home/dan/rtw89/rtw8852a_rfk.o
   CC [M]  /home/dan/rtw89/rtw8852a_rfk_table.o
   CC [M]  /home/dan/rtw89/cam.o
   CC [M]  /home/dan/rtw89/efuse.o
   CC [M]  /home/dan/rtw89/regd.o
   CC [M]  /home/dan/rtw89/coex.o
   CC [M]  /home/dan/rtw89/ps.o
   CC [M]  /home/dan/rtw89/sar.o
   CC [M]  /home/dan/rtw89/ser.o
   CC [M]  /home/dan/rtw89/util.o
   LD [M]  /home/dan/rtw89/rtw89core.o
   CC [M]  /home/dan/rtw89/pci.o
/home/dan/rtw89/pci.c:598:18: warning: ‘struct rtw89_pci_isrs’ declared 
inside parameter list will not be visible outside of this definition or 
declaration
   598 |           struct rtw89_pci_isrs *isrs)
       |                  ^~~~~~~~~~~~~~
/home/dan/rtw89/pci.c: In function ‘rtw89_pci_recognize_intrs’:
/home/dan/rtw89/pci.c:600:6: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   600 |  isrs->halt_c2h_isrs = rtw89_read32(rtwdev, R_AX_HISR0) & 
rtwpci->halt_c2h_intrs;
       |      ^~
/home/dan/rtw89/pci.c:601:6: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   601 |  isrs->isrs[0] = rtw89_read32(rtwdev, R_AX_PCIE_HISR00) & 
rtwpci->intrs[0];
       |      ^~
/home/dan/rtw89/pci.c:602:6: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   602 |  isrs->isrs[1] = rtw89_read32(rtwdev, R_AX_PCIE_HISR10) & 
rtwpci->intrs[1];
       |      ^~
/home/dan/rtw89/pci.c:604:40: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   604 |  rtw89_write32(rtwdev, R_AX_HISR0, isrs->halt_c2h_isrs);
       |                                        ^~
/home/dan/rtw89/pci.c:605:46: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   605 |  rtw89_write32(rtwdev, R_AX_PCIE_HISR00, isrs->isrs[0]);
       |                                              ^~
/home/dan/rtw89/pci.c:606:46: error: invalid use of undefined type 
‘struct rtw89_pci_isrs’
   606 |  rtw89_write32(rtwdev, R_AX_PCIE_HISR10, isrs->isrs[1]);
       |                                              ^~
/home/dan/rtw89/pci.c: In function ‘rtw89_pci_enable_intr’:
/home/dan/rtw89/pci.c:612:29: error: ‘RTW89_PCI_FLAG_DOING_RX’ 
undeclared (first use in this function)
   612 |  if (exclude_rx || test_bit(RTW89_PCI_FLAG_DOING_RX, 
rtwpci->flags))
       |                             ^~~~~~~~~~~~~~~~~~~~~~~
/home/dan/rtw89/pci.c:612:29: note: each undeclared identifier is 
reported only once for each function it appears in
/home/dan/rtw89/pci.c:612:60: error: ‘struct rtw89_pci’ has no member 
named ‘flags’
   612 |  if (exclude_rx || test_bit(RTW89_PCI_FLAG_DOING_RX, 
rtwpci->flags))
       | ^~
/home/dan/rtw89/pci.c: In function ‘rtw89_pci_interrupt_threadfn’:
/home/dan/rtw89/pci.c:634:24: error: storage size of ‘isrs’ isn’t known
   634 |  struct rtw89_pci_isrs isrs;
       |                        ^~~~
/home/dan/rtw89/pci.c:634:24: warning: unused variable ‘isrs’ 
[-Wunused-variable]
/home/dan/rtw89/pci.c: In function ‘rtw89_pci_ops_start’:
/home/dan/rtw89/pci.c:1180:12: error: ‘RTW89_PCI_FLAG_DOING_RX’ 
undeclared (first use in this function)
  1180 |  clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
       |            ^~~~~~~~~~~~~~~~~~~~~~~
/home/dan/rtw89/pci.c:1180:43: error: ‘struct rtw89_pci’ has no member 
named ‘flags’
  1180 |  clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
       |                                           ^~
/home/dan/rtw89/pci.c: In function ‘rtw89_pci_napi_poll’:
/home/dan/rtw89/pci.c:2792:10: error: ‘RTW89_PCI_FLAG_DOING_RX’ 
undeclared (first use in this function)
  2792 |  set_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
       |          ^~~~~~~~~~~~~~~~~~~~~~~
/home/dan/rtw89/pci.c:2792:41: error: ‘struct rtw89_pci’ has no member 
named ‘flags’
  2792 |  set_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
       |                                         ^~
/home/dan/rtw89/pci.c:2803:44: error: ‘struct rtw89_pci’ has no member 
named ‘flags’
  2803 |   clear_bit(RTW89_PCI_FLAG_DOING_RX, rtwpci->flags);
       |                                            ^~
make[2]: *** [scripts/Makefile.build:287: /home/dan/rtw89/pci.o] Error 1
make[1]: *** [Makefile:1848: /home/dan/rtw89] Error 2
make[1]: Leaving directory '/usr/src/linux-headers-5.11.0-22-generic'
make: *** [Makefile:52: all] Error 2

