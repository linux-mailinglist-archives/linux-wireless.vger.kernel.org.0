Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83AAE39FA9
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 14:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFHM1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 08:27:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36713 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfFHM1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 08:27:00 -0400
Received: by mail-ed1-f68.google.com with SMTP id k21so3250536edq.3
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jun 2019 05:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:subject:openpgp:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=kpMmEIHUpzCA0Zg/8LxrR0IoBys9bGvwLKIkWlO1dMM=;
        b=bzYpF9cDkdSQskz7TkO980LFrkRh23TUNqFUR283rfBDUIA++GjiZaYyhYLwvnYB7I
         RCkI1E6RNzaMo+vvgw3iFJ7JNQGOrJzBb6MjuqFxik+WN2RHGGdKjaMpV3PWclBcCnrp
         bLOfTLviu7giM9XZ6CGuSijvj+18bcTGcH4Pw9xXqma5QrUcMts+Xst0Va3dBG3/+J6Y
         TCxDI/pMnfW3XTEFbfYvxkh4sdwN784qG5fcnPMNJJM+y+gDEDDJt93UIzJeHEtlDJNG
         mTUyRzRTnLIRJ5krefi9zzuRxSmrr1bqmhcwXrUz5xAboVe2d/2+OgWGLva59aSwQzho
         mmuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:openpgp:to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=kpMmEIHUpzCA0Zg/8LxrR0IoBys9bGvwLKIkWlO1dMM=;
        b=RTkN3HbA5zH14vD52WMmPBUalT5ZmXYbD6I6bTe8BKrvu1SUuMRYOkGeWIq+UCRu58
         h0y/wXOtN8kXBCK761jULAbaSCOkj3JlbXBzEgsS6DuCRe+0ggsueE2jVTXffBV08KD7
         0Zd9vuPpnJTZnYVd2Go6g3HiQ3eQ0FRkSt2Njhcwo7yR5L9ALJB2FUP/QforuBbz1Oyg
         A8lttLETqeYLS+7ruWurGUElI8NQQ9TQ0ux++lzVs4BLEMZtFNrjTo5K/jbIo7IvEyQW
         HwY6fJWp+zQVDOMhIzGHqzLfK5AEAd+lu8RaCOQCTCE/YpftDqRJ+3ZvE/trC46AvNSf
         +jRg==
X-Gm-Message-State: APjAAAXRS2XlugxzWs4EB0NbUoFCXVRNUizSPkl89FF81Te+0UCi4Fsr
        /aTI6ASIeNGQj0khXvxKYRtZTqMt
X-Google-Smtp-Source: APXvYqxheKVy82NAS7C/lGUTK+M7OPneIjfsckUNlAgaM1RAXCI/pU2GBi4kM2pVyc3uoIRlcfqSnA==
X-Received: by 2002:a17:906:6550:: with SMTP id u16mr28580767ejn.7.1559996818267;
        Sat, 08 Jun 2019 05:26:58 -0700 (PDT)
Received: from ?IPv6:2001:db8:4b:222::197? ([2a02:810a:8c0:6498:f580:d228:718:3e98])
        by smtp.gmail.com with ESMTPSA id i31sm1284405edd.90.2019.06.08.05.26.57
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Jun 2019 05:26:57 -0700 (PDT)
From:   "g.schlmm" <g.schlmm@googlemail.com>
X-Google-Original-From: "g.schlmm" <g.schlmm@gmail.com>
Subject: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
Openpgp: preference=signencrypt
To:     linux-wireless@vger.kernel.org
Message-ID: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
Date:   Sat, 8 Jun 2019 14:26:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: fr-CA
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

my RTL8822BE M.2 card is not working with linux 5.2rc3

the staging r8822be driver in linux 5.1 was working for this card

from dmesg:
> [    8.001186] rtw_pci 0000:04:00.0: rfe 3 isn't supported                                                             
> [    8.003870] rtw_pci 0000:04:00.0: failed to setup chip efuse info                                                   
> [    8.006405] rtw_pci 0000:04:00.0: failed to setup chip information 

lspci:
> 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>         Subsystem: Lenovo RTL8822BE 802.11a/b/g/n/ac WiFi adapter
>         Flags: fast devsel, IRQ 19
>         I/O ports at c000 [size=256]
>         Memory at 81200000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-b8-22-01
>         Capabilities: [158] Latency Tolerance Reporting
>         Capabilities: [160] L1 PM Substates
>         Kernel modules: rtwpci
