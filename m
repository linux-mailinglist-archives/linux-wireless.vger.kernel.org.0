Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B8B4206E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2019 11:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407424AbfFLJNj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jun 2019 05:13:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39084 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730381AbfFLJNj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jun 2019 05:13:39 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C74A30C0DCD;
        Wed, 12 Jun 2019 09:13:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABB8A2719B;
        Wed, 12 Jun 2019 09:13:31 +0000 (UTC)
Date:   Wed, 12 Jun 2019 11:13:30 +0200
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     "g.schlmm" <g.schlmm@googlemail.com>
Cc:     linux-wireless@vger.kernel.org, yhchuang@realtek.com
Subject: Re: rtw88: M.2 RTL8822BE not working - rfe 3 isn't supported
Message-ID: <20190612091330.GC2965@redhat.com>
References: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0159a8-a83e-cef3-fd32-4928a2301719@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 12 Jun 2019 09:13:39 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Cc Tony 

On Sat, Jun 08, 2019 at 02:26:51PM +0200, g.schlmm wrote:
> my RTL8822BE M.2 card is not working with linux 5.2rc3
> 
> the staging r8822be driver in linux 5.1 was working for this card
> 
> from dmesg:
> > [    8.001186] rtw_pci 0000:04:00.0: rfe 3 isn't supported                                                             
> > [    8.003870] rtw_pci 0000:04:00.0: failed to setup chip efuse info                                                   
> > [    8.006405] rtw_pci 0000:04:00.0: failed to setup chip information 
> 
> lspci:
> > 04:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTL8822BE 802.11a/b/g/n/ac WiFi adapter
> >         Subsystem: Lenovo RTL8822BE 802.11a/b/g/n/ac WiFi adapter
> >         Flags: fast devsel, IRQ 19
> >         I/O ports at c000 [size=256]
> >         Memory at 81200000 (64-bit, non-prefetchable) [size=64K]
> >         Capabilities: [40] Power Management version 3
> >         Capabilities: [50] MSI: Enable- Count=1/1 Maskable- 64bit+
> >         Capabilities: [70] Express Endpoint, MSI 00
> >         Capabilities: [100] Advanced Error Reporting
> >         Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-b8-22-01
> >         Capabilities: [158] Latency Tolerance Reporting
> >         Capabilities: [160] L1 PM Substates
> >         Kernel modules: rtwpci
