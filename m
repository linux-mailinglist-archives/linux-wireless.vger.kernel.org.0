Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B036F3F9818
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 12:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhH0KY3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 06:24:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244715AbhH0KY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 06:24:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF2EC061757
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 03:23:39 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z19so9156023edi.9
        for <linux-wireless@vger.kernel.org>; Fri, 27 Aug 2021 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=SmAD1nC+zt4juF4eWoWAOPe1SibFIExoLZaw9dRrAXc=;
        b=GxiFd20f4nXZDK8MoCvlkD22SDletpbnTxuzvyg8o8EbzUggTdWIRH/Nt63zmq2cw1
         0Je5otLIdMnUPgrAikGe9D8OTQ8iPcHSoz0ySyEgAt/IB0vm0/RCCGUEgK290vg16YhO
         B9/4i2dmP2qY0hbUzKp2Rk/MqFX/9HSvurgqzqJD6P1q39BOzBsvUI4XASXkhjTg1CWj
         CXYziQnMX6kLwD64S6+2Jh8zPJOsBDfUuIzaWlHsjcz/sj0+VWRohWgu6GsUd20ld5fG
         FpqgYxnVxY8wqtMIj1jFX4BEgVyLDZogg4uvztdFLDrG1nvvnCYNjn8wwHBSsH5Sie2r
         xixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SmAD1nC+zt4juF4eWoWAOPe1SibFIExoLZaw9dRrAXc=;
        b=uEVrc5HGMDL0xTHYUpHuelK0wkh48IFjEnJXUDH0ZW1nyOYnEoqZHFy/uvgyj6g643
         AqjGgMQ4NOw/q7Z2KNyTQ1tn8+H67Y7Y8IeAGaSKVqXOWaSS30rnh25a+GaqsH88+lqy
         /oLhv4XiLQWLarEl/g99d3HCyKVynoJ/OvcD+lCd2Fjs6CTs/9RBJTNCTMnchRVHBA6M
         hzFH2U7hgSbQsJuecmK9nrNzbAFufitYgi9wOhbuNEJh31R/auyDZ21UeiOKeYUB6S7C
         3FN3vgFTpWWnaf4CrZ6DI6LpOZ1salYeSZPhwCyhj4w2ZKAUOwJjUrseMMW1KBCj+Zkn
         iT/g==
X-Gm-Message-State: AOAM532fRu+EaYAdKCgywtwlkjUD+UK8CZpZ1RAJh7wJMKKRSMNcfw+Z
        IKHyQJPsKCOdxaHc88TrORuYtLLOQtBxE2gegZ1wV2sMTcH4xw==
X-Google-Smtp-Source: ABdhPJzcwG9sNM2OwTCaKHHpVIZNw2VSVilLSPnh/WduU73uz4YlwP48dX6bHMenTL36bc5vZRJvgtqt7rDot5W3AtU=
X-Received: by 2002:a05:6402:1702:: with SMTP id y2mr9187568edu.125.1630059818180;
 Fri, 27 Aug 2021 03:23:38 -0700 (PDT)
MIME-Version: 1.0
From:   Michael Johnson <mjohnson459@gmail.com>
Date:   Fri, 27 Aug 2021 11:23:27 +0100
Message-ID: <CACsRnHWa47zpx3D1oDq9JYnZWniS8yBwW1h0WAVZ6vrbwL_S0w@mail.gmail.com>
Subject: Delay sending packets after a wireless roam
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

I'm having an odd issue with wireless roaming whereby any time I roam
from one access point to another I start receiving packets almost
instantly but experience a delay of roughly 1 second before I can send
packets out. I think I've narrowed it down to somewhere kernel related
but I'm struggling to know where to look next.

Firstly, I started seeing this delay after upgrading from Ubuntu 16.04
(so 4.15 kernel) to 20.04 (tested with 5.4, 5.8 and 5.11) but I also
tested this on Kali 2021.2 (5.10).
I see the delay with intel (iwlwifi), qualcomm (ath10k), and realtek cards.
I've also used both iwd and wpa_supplicant, with and without
systemd-networkd and NetworkManager.
I've been using ICMP for testing but I've also tried a python script
for sending udp packets with the same result.

Here is the output of the simplest test that still shows the issue
(ping + tcpdump + iwd + 5.11.0-27-generic):
https://pastebin.com/92TKKktb

My naive tl;dr of that data is:

30.322638 - we start to roam which falls between icmp_seq=121 and icmp_seq=122.
30.415411 - roam is complete
30.424277 - iwd is sending and receiving neighbor reports over the link
31.358491 - an ARP request is sent out  (should the ARP cache be
cleared on a roam?)
31.367930 - ARP response
31.368009 - packets start being sent again as soon as we get the ARP response

Can anyone help me understand what might be happening between the
interface going "up" at 30.415411 and the ARP request at 31.358491
please?
Also, does anyone else see something in their environment?

Kind Regards,
Michael
