Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C7E30041C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 14:26:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbhAVNZ1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Jan 2021 08:25:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727474AbhAVNZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Jan 2021 08:25:08 -0500
X-Greylist: delayed 369 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jan 2021 05:23:59 PST
Received: from mout2.freenet.de (mout2.freenet.de [IPv6:2001:748:100:40::2:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD0C06174A;
        Fri, 22 Jan 2021 05:23:59 -0800 (PST)
Received: from [195.4.92.127] (helo=sub8.freenet.de)
        by mout2.freenet.de with esmtpa (ID andihartmann@freenet.de) (port 25) (Exim 4.92 #3)
        id 1l2wJs-00044u-E8; Fri, 22 Jan 2021 14:17:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
         s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IbMstFtbXqogcXKJEinAP0ZRvVkWbwBJKwmP5EKGYA4=; b=dATLghVEJ4jQPH6metsMvbuze2
        MUOGG/NAMg6BzGLIFcv6dg8cva8Mz/yB8HRxA8GqoTQpUR99cgJZzdWIcx8DBDCDAt4KUySqfJ02w
        FOSJmXr1KngMRI1WhwMfPUcqvk3fDTTkVKrnL9B/U0YT6R4vBs1pDwqVi7QRT22qIsPSD/QGybYqg
        1p7Ye5uFojp7Mu7dRXNhtmC/nriSewqYhqMQbtDOI7AJhQcDuNV+HKPWEskXl/EkTbIlo5Vq6H/4X
        tGlIR2UlajAdI9aLIxYFtnjTI6al6iz93f4+YBfZqvWZ9riT1oAcdGYBGNdOK1UTStZAVqY/t7NVY
        me5xpKqA==;
Received: from p200300de573c8400505400fffe15ac42.dip0.t-ipconnect.de ([2003:de:573c:8400:5054:ff:fe15:ac42]:45220 helo=mail.maya.org)
        by sub8.freenet.de with esmtpsa (ID andihartmann@freenet.de) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (port 465) (Exim 4.92 #3)
        id 1l2wJs-0004YC-Aa; Fri, 22 Jan 2021 14:17:44 +0100
Received: internal info suppressed
To:     Greg KH <greg@kroah.com>, stf_xl@wp.pl
Cc:     linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Bernhard <bernhard.gebetsberger@gmx.at>
References: <20210122104342.12451-1-stf_xl@wp.pl> <YAq9bt6q9dfk4F+F@kroah.com>
From:   Andreas Hartmann <andihartmann@freenet.de>
Subject: Re: [PATCH] usb, xhci, rt2800usb: do not perform Soft Retry
Message-ID: <b0025964-490d-d8a0-f9af-f916d44e4f52@maya.org>
Date:   Fri, 22 Jan 2021 14:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAq9bt6q9dfk4F+F@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originated-At: 2003:de:573c:8400:5054:ff:fe15:ac42!45220
X-FNSign: v=2 s=DB3EE7F2275B79DC4C532525FDF68072D8ED62B62D18774C99C4288F892EA0D0
X-Scan-TS: Fri, 22 Jan 2021 14:17:44 +0100
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 22.01.21 at 12:56 Greg KH wrote:
> On Fri, Jan 22, 2021 at 11:43:42AM +0100, stf_xl@wp.pl wrote:
>> From: Stanislaw Gruszka <stf_xl@wp.pl>
>>
>> Since f8f80be501aa ("xhci: Use soft retry to recover faster from transaction
>> errors") on some systems rt2800usb devices are unable to operate. Looks
>> that due to firmware or hardware limitations of those devices, they
>> require full recovery from USB Transaction Errors.
>>
>> To avoid the problem add URB transfer flag, that restore pre f8f80be501aa
>> xhci behaviour when the flag is set. For now only add it only to rt2800usb
>> driver.
> 
> This feels like a really heavy hammer, to add a xhci flag for a single
> broken device.
> 
> Are you sure this is really needed?  What does this device do on other
> operating systems, do they have such a quirk for their host controller
> driver?
> 
> Or is this due to the specific host controller device hardware?  Should
> this be a xhci quirk for a specific pci device instead?

Well, rt2800usb USB implementation does have a lot of potential for optimization 
since the very beginning (current throughput comparison 2 MiB/s vs 13 MiB/s with 
the original driver e.g.). That's why I'm using until today a self patched version 
(it's bound to cfg80211 meanwhile) of the original driver (rt5572sta), which 
doesn't have those problems at all. From my point of view, the goal should be to 
solve the real reason for the problem. The original driver works much better 
(leastwise here) and doesn't show this problem at all!

But anyway, there is from my point of view a basic problem with xhci_hcd, which 
just seems not to be completely backward compatible to existing USB 2 drivers (see 
https://marc.info/?l=linux-usb&m=161130327411612&w=2) if the device is plugged to 
an USB 3.x interface.



Thanks
Andreas
