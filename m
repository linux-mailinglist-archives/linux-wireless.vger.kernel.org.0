Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA5D33C7BE
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 21:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCOUb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 16:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhCOUbj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 16:31:39 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Mar 2021 13:31:39 PDT
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C0C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 13:31:39 -0700 (PDT)
Received: from [195.4.92.126] (helo=sub7.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1lLtlU-0008Oa-9C
        for linux-wireless@vger.kernel.org; Mon, 15 Mar 2021 21:24:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=justmail.de
        ; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I/VxGAPEiq8CcwrUtKtO4rwVj2NSZggF+c8E4Qn4/N8=; b=HgQU/RaAyBbvVhGJYBy3Btx3fL
        XPkRULGt2ljajAxkqOeP1js324XM2Av/XKxJ20ftFOeOdsHr+HQzw4EVwWXlOMBrxxKRhfLOoSJ19
        r8ZnVaaNyVs//EVLDDlU3f+5PXsF2wywnzhVTQQ/oQkj3v8pw1a1w7k4zldOz166deKUbYWj/nFim
        Mkd1AgGbqsDE5452mwKS1Z1c7JnScWXnB6ww7gDtfN324/AZuCSr1MUNQwPLTLqKtIdrhrPS/yh0M
        /8IpBFImoreWq9Pz+O1Z47dHltR+noDM9jKBSLQ6PQDCdthmbMt+bKilG3r258aEeG6jaueLhjoFr
        /YBYQCYg==;
Received: from p200300de57240600505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5724:600:5054:ff:fe15:ac42]:57532 helo=mail.maya.org)
        by sub7.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1lLtlU-0006oJ-78
        for linux-wireless@vger.kernel.org; Mon, 15 Mar 2021 21:24:36 +0100
Received: internal info suppressed
Subject: Re: RTL8821CE: CTRL-EVENT-BEACON-LOSS and connection loss
From:   Klaus Mueller <kmueller@justmail.de>
To:     linux-wireless@vger.kernel.org
References: <e0de2157-c06e-c327-e969-d32cb21daf40@justmail.de>
Message-ID: <731aad01-2999-e71c-90c0-345c5c6b0df4@justmail.de>
Date:   Mon, 15 Mar 2021 21:24:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <e0de2157-c06e-c327-e969-d32cb21daf40@justmail.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:5724:600:5054:ff:fe15:ac42!57532
X-FNSign: v=2 s=B748E26CAAE1DC610A91B6371BC7F8CF83E049E4C180337CAE2A2CAE1FFAED02
X-Scan-TS: Mon, 15 Mar 2021 21:24:36 +0100
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I retested the version from https://github.com/lwfinger/rtw88 on linux
5.10.16 - starting with the commits on Mar 9, 2021. It now seems to work
pretty fine even on 2.4 GHz / 40 MHz! Thanks to Realtek for their support!

Additional credit goes to Larry Finger, who thankfully provides this
additional source tree to make the progress of the driver accessible to
a lot more kernels than the actual one!

Thanks
Klaus



On 25.12.20 at 11:55 Klaus Mueller wrote:
> Hello!
> 
> I'm having a
> 04:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8821CE
> 802.11ac PCIe Wireless Network Adapter
>         Subsystem: AzureWave Device 3041
>         Flags: bus master, fast devsel, latency 0, IRQ 71
>         I/O ports at d000 [size=256]
>         Memory at f7600000 (64-bit, non-prefetchable) [size=64K]
>         Capabilities: [40] Power Management version 3
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>         Capabilities: [70] Express Endpoint, MSI 00
>         Capabilities: [100] Advanced Error Reporting
>         Capabilities: [148] Device Serial Number xxxx...
>         Capabilities: [158] Latency Tolerance Reporting
>         Capabilities: [160] L1 PM Substates
>         Capabilities: [170] Precision Time Measurement
>         Capabilities: [17c] Vendor Specific Information: ID=0003 Rev=1
> Len=054 <?>
> 
