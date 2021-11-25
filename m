Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBE45E30F
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Nov 2021 23:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244774AbhKYWqG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 Nov 2021 17:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244180AbhKYWoE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 Nov 2021 17:44:04 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF5F5C06175E;
        Thu, 25 Nov 2021 14:39:14 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id g9so3788324qvd.2;
        Thu, 25 Nov 2021 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mKEHkuEY6JKO2Lf5S2bk0vEKACBdfzK1NLsInC3tTco=;
        b=b5zWW42WUaDmRfaoFGxjh0jqJ8aJApjPOFN2afaSyEhMOkjyq7wsICOezf/gVz+AI8
         ZCqNqqczM7xjI6H1mHQZOWtuLypKj0MdqBAf/Ie9muR7tjN11uzWwTBqASuqa+UR/Bfv
         eATHiJfp5sJMTfXP59J2i2XlWCCyXmOkeFBXrLZ0llggqjjEzm1VGwmc4sLDfuVj0xrD
         9u/BeEsjFsdITBYHPyuBZK5R64CXDZR6QQklnrlPkH/B31vnyNoTbYT5pz2CqcRTf1GQ
         4kOQ8es2eEK1f8nCb5+qIcQihO2i9YDgKEizk7Afb8OCi34dRKdaylbSgJbylEhtJDUq
         QEIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mKEHkuEY6JKO2Lf5S2bk0vEKACBdfzK1NLsInC3tTco=;
        b=nSGfSqqcEYbjoYgdAonL74z9ZxBPy2rwQg30Ux0InFHEmhm5qzCAjURCESADOaDNSB
         2l7y+GFOaKHcr1P6zw0KZul5kN/0YKOpAiFjPVaJYPjwOpv/oDGtYNqHUF0lfOiXCcc/
         s40bRfW3tQDZhzCoTJsEsSwXG8cjqmyAW+b+klDsNKn58juglZkEmtdtat4zQ+IOOpcF
         ZrLHwzbVBnVzx6DZtx7yEYDZIHunZpv8VfwfeQK77p7sio+aavrbSWN+bUfXs553LZig
         Ef0+LzrVn2SSll/6J07jvKn6it5c4udV5gz+N7OqgTLXHn6flgqP2gs1mPFWAjpLlPIU
         yVAg==
X-Gm-Message-State: AOAM532tC0dK4eJefiPtVnL78bNhdilydQqE2W+3S+aM6PH9t4qABfM3
        T4gWdJ1CG5zq/A9BZmph+gQzw5jUHQNBVWeyKNVyIdfE4RyvXQ==
X-Google-Smtp-Source: ABdhPJz1nuZYs0+y9KaFEH2jK0iQ7nlGz6lEfMTYNQFZ76+T2unUdBBLgVAy3FLHZy79aqU/sd4G59SDbVQ2HSO3SmU=
X-Received: by 2002:a05:6214:dc4:: with SMTP id 4mr21284780qvt.45.1637879953680;
 Thu, 25 Nov 2021 14:39:13 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsODP8ze_mvzfJKcRYxuS-esVgHXAvDXS5KN3xFUN6bWgA@mail.gmail.com>
 <CABXGCsMc1_-s5vVv=XVuMJaAtntrfHpCeT3h7wKkK71NuY-izw@mail.gmail.com>
In-Reply-To: <CABXGCsMc1_-s5vVv=XVuMJaAtntrfHpCeT3h7wKkK71NuY-izw@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Fri, 26 Nov 2021 03:39:03 +0500
Message-ID: <CABXGCsMJOfGU8axS4FdGfPCgcPL5iuedpZxa4PETSyFHDckOAg@mail.gmail.com>
Subject: Re: [Bug] Driver mt7921e cause computer reboot.
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-wireless@vger.kernel.org>,
        objelf@gmail.com, lorenzo@kernel.org, Soul.Huang@mediatek.com,
        nbd@nbd.name
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 5 Oct 2021 at 01:40, Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>

With recent kernel 5.16.0-0.rc2 commit 5d9f4cf36721 the behavior has
been changed for the better, but the WiFi adapter still works with
bugs.

Now spontaneous endless reboots do not occur. But if I restart the
laptop instead of shutting down, then the next time I boot, the WiFi
adapter disappears. In order for the WiFi adapter to appear again, it
needs to turn off the laptop and then turn on. Can this be somehow
fixed?
lspci output after reboot and boot after shutdown is different:

After reboot:
Subsystem: AzureWave Device 4680
Flags: fast devsel, IRQ 84, IOMMU group 14
Memory at fc30300000 (64-bit, prefetchable) [size=1M]
Memory at fc30400000 (64-bit, prefetchable) [size=16K]
Memory at fc30404000 (64-bit, prefetchable) [size=4K]
Capabilities: [80] Express Endpoint, MSI 00
Capabilities: [e0] MSI: Enable- Count=1/32 Maskable+ 64bit+
Capabilities: [f8] Power Management version 3
Capabilities: [100] Vendor Specific Information: ID=1556 Rev=1 Len=008 <?>
Capabilities: [108] Latency Tolerance Reporting
Capabilities: [110] L1 PM Substates
Capabilities: [200] Advanced Error Reporting
Kernel modules: mt7921e

After shutdown:
05:00.0 Network controller: MEDIATEK Corp. Device 7961
Subsystem: AzureWave Device 4680
Flags: bus master, fast devsel, latency 0, IRQ 85, IOMMU group 14
Memory at fc30300000 (64-bit, prefetchable) [size=1M]
Memory at fc30400000 (64-bit, prefetchable) [size=16K]
Memory at fc30404000 (64-bit, prefetchable) [size=4K]
Capabilities: [80] Express Endpoint, MSI 00
Capabilities: [e0] MSI: Enable+ Count=1/32 Maskable+ 64bit+
Capabilities: [f8] Power Management version 3
Capabilities: [100] Vendor Specific Information: ID=1556 Rev=1 Len=008 <?>
Capabilities: [108] Latency Tolerance Reporting
Capabilities: [110] L1 PM Substates
Capabilities: [200] Advanced Error Reporting
Kernel driver in use: mt7921e
Kernel modules: mt7921e

Screen of a visual comparison of lspci in meld: https://postimg.cc/642NKJ5Y

-- 
Best Regards,
Mike Gavrilov.
