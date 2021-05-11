Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A674237AFA2
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 21:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEKTwx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 15:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhEKTwt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 15:52:49 -0400
X-Greylist: delayed 335 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 May 2021 12:51:42 PDT
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8671FC061574
        for <linux-wireless@vger.kernel.org>; Tue, 11 May 2021 12:51:41 -0700 (PDT)
Received: from [195.4.92.119] (helo=sub0.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1lgYKP-00017h-3C; Tue, 11 May 2021 21:46:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=01019freenet.de; s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2mAdybFIkBziYkhDo+VUIjlPsCE6UYN8s/iDPFowvyc=; b=h/M5u/nFgjicwdsJ9065IUR3q4
        XGBIGuNVep5QtPTecf5mIdMctAsPzU3AXtVZBJkONxy6ziP+RfgjVI1/4MRShXsG7Wfjx3osJN7QD
        e4Fz8wsuk6FC+j/E0CzasuLUvpnaOHsKUF/IYlTMv8iBbeX7kjkeqv5cPHJWk/ab0JqkJEQkfzdhn
        m3P8kdC6HKEqvsKRnWFdzEGvobRFNceqoQb4JSdopU/X7QpOJ6SNbhAmPpPJN6xoxGizO04sjztHB
        l3bwIYgM49+D89QMbHxXfuRGKPDgj6H/4grfJXaraV1qkdjUFL2FmouHDS54i5cHBa27PWfu2erdQ
        vIfoTbtA==;
Received: from p200300de57315c00505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:5731:5c00:5054:ff:fe15:ac42]:42182 helo=mail.maya.org)
        by sub0.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256) (port 465) (Exim 4.92 #3)
        id 1lgYKP-0001aA-0k; Tue, 11 May 2021 21:46:01 +0200
Received: internal info suppressed
Subject: Re: rtw88: Guaranteed system freeze with RTL8821CE with RFE 2 type
To:     rtl8821cerfe2 <rtl8821cerfe2@protonmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <vWuRjLpNOkVGXHNeCL6phN5YDcd6Oljm1WgEMO4vA9aufK8MxzN5itvDnRjPBWHZN0geAbRLAzgIj36kAiNtdHh5vg2RjUH_TzuqZ7WSYeE=@protonmail.com>
 <65c86fe7-f1f1-445f-40c2-25ceaa4e4fb6@lwfinger.net>
 <1jmF9EMZn2ywrHSGrNCzOUSAzllw9ox-Da2zfbSTnTULlX8Ha8F211TfKuxITBBtkfxiU_R0w7zUeFLdtDj4ejp6qPnCIhFj2U-rsCVNlMg=@protonmail.com>
 <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
From:   Andreas Hartmann <andihartmann@01019freenet.de>
Message-ID: <17cc8de6-7e39-8734-260d-2336c8417da0@01019freenet.de>
Date:   Tue, 11 May 2021 21:45:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <Qg7Ae-IznoeEC_X2m_4XXKRlM-yT3O7dzdbZ0egHTsdEaA0uILKZ0uBymFMrN7aI38rz-ZTKSxTDUAU4tKJPIntXELdx9Rd0MIU5sSG_VCI=@protonmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originated-At: 2003:de:5731:5c00:5054:ff:fe15:ac42!42182
X-FNSign: v=2 s=6C8FDD92DD5130814199D9E5A4754F4206AAEB7C468C46DFA18B5FFBC09A745E
X-Scan-TS: Tue, 11 May 2021 21:46:01 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

I'm using probably the same device and the same modules here from
Larry's repository. They are working perfectly - much better then any
other existing modules. Absolutely stable and good throughput on even
bad radio conditions.

My device:
04:00.0 0280: 10ec:c821
        Subsystem: 1a3b:3041
        Flags: bus master, fast devsel, latency 0, IRQ 76
        I/O ports at d000 [size=256]
        Memory at f7600000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] Power Management version 3
        Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Capabilities: [70] Express Endpoint, MSI 00
        Capabilities: [100] Advanced Error Reporting
        Capabilities: [148] Device Serial Number 00-e0-4c-ff-fe-c8-21-01
        Capabilities: [158] Latency Tolerance Reporting
        Capabilities: [160] L1 PM Substates
        Capabilities: [170] Precision Time Measurement
        Capabilities: [17c] Vendor Specific Information: ID=0003 Rev=1
Len=054 <?>
        Kernel driver in use: rtw_8821ce
        Kernel modules: rtw_8821ce

on Linux 5.10.27 / self build

I saw you're using network manager - I'm using just wpa_supplicant
(EAPTLS) - nothing else. Maybe that's the problem?
One more thing: I'm on 2.4 GHz / 40 MHz.


Thanks
Andreas
