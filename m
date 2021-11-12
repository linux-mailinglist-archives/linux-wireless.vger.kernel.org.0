Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1C044EE9F
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 22:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhKLVc1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 16:32:27 -0500
Received: from lave.lost-in-the-void.net ([213.229.87.129]:35598 "EHLO
        lave.lost-in-the-void.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbhKLVc0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 16:32:26 -0500
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Nov 2021 16:32:26 EST
Received: from localhost (localhost [127.0.0.1])
        by lave.lost-in-the-void.net (Postfix) with ESMTP id 2A932902A0ED
        for <linux-wireless@vger.kernel.org>; Fri, 12 Nov 2021 21:21:25 +0000 (GMT)
Authentication-Results: lave.lost-in-the-void.net (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=lost-in-the-void.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        lost-in-the-void.net; h=user-agent:message-id:subject:subject:to
        :from:from:date:date:content-transfer-encoding:content-type
        :content-type:mime-version; s=dkim; t=1636752075; x=1637616076;
         bh=3MNwzIY0hAwWUuBR7Iyqn0F0eCXkww5hc+xksYR/rA4=; b=aFVDH9CuyHk2
        ufi1bbW8he4fwhFOVrt9PL833MpopmOaezvXNw4fY07pqvwltJxi36zkFJlyPiFT
        +09vpXNU/Wx/cMSlER4KmYUeNr/drlf/GSHeFNIdomLH/pZypIUXvZzYStizyA0k
        2KavoGzJP8Nehn8JrjPzLtbk+Ke+s2A=
X-Virus-Scanned: amavisd-new at lave.lost-in-the-void.net
Received: from lave.lost-in-the-void.net ([127.0.0.1])
        by localhost (lave.lost-in-the-void.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uSBbT5lJsYfk for <linux-wireless@vger.kernel.org>;
        Fri, 12 Nov 2021 21:21:15 +0000 (GMT)
Received: from lave.lost-in-the-void.net (localhost [127.0.0.1])
        by lave.lost-in-the-void.net (Postfix) with ESMTPSA id 94E4C902A0EB;
        Fri, 12 Nov 2021 21:21:13 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Nov 2021 21:21:13 +0000
From:   Robert W <rwbugreport@lost-in-the-void.net>
To:     xl@wp.pl
Cc:     linux-wireless@vger.kernel.org
Subject: Bug/Regression - Ralink RT2800 kernel deference issue since kernel
 5.14
Message-ID: <c07b4142fb725ed87a2cef530bae9ee7@lost-in-the-void.net>
X-Sender: rwbugreport@lost-in-the-void.net
User-Agent: Roundcube Webmail
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have recently tried to upgrade a system to run the 5.14 kernel and 
noticed that I was getting hangs on the system which seem to relate to 
this wireless dongle which I am running hostapd against to provide a 
small AP. Since that time kernel 5.15 was released and I have tested 
that kernel as well and the problem persists.  The issue sometimes 
occurs within an hour and other times it takes a few hours. I have tried 
to narrow down what is causing the issue.  I thought it might be a 
change elsewhere outside the mac80211/driver area so I tried to run the 
wireless backports 5.15-rc6 on top of the last stable kernel of 5.13 so 
as to have the smallest number of changes on the system. The backports 
crashes with the same error.  I have included below the netconsole 
output and the gdb of the kernel module in question. The capture was 
from when I was using the backports, but the error  is the same.  I hope 
the pastebins are okay to use on the list.  I did try to get some 
assistance on linux-wireless IRC and some one asked for the outputs I 
had for the information so I am reusing them here.

The following pastebin is the data sent to a netconsole instance.

https://pastebin.com/UxRrTtUh

The gdb debug of the kernel module suggests this section of code.

https://pastebin.com/iMzxWEVU

I am able to run further tests if required.  I am not a programmer, but 
I can usually apply code patches and build the resulting code. Please 
let me know if require any further information.

-- 
Robert
