Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC8214D212
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 21:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgA2UtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 15:49:24 -0500
Received: from mail-qv1-f52.google.com ([209.85.219.52]:46141 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbgA2UtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 15:49:24 -0500
Received: by mail-qv1-f52.google.com with SMTP id y2so358645qvu.13
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 12:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FFhp+MTDGFRUEbZLOp2FoXozZ8qfMM/1xyGfVx88ALk=;
        b=Y7+foQGBl5EKby3WS2++EID5KswEKTKU7T2K13D4rmXmHFBz3XhB91r+SUBuz6OYEL
         sthVcb47T2JPzuyhhngHmPcEGOa5FAZFuVDCAD2Q4PCeI50wt2ZH9FTrE79teyaLGpGT
         Y0fH1NQv75ayTT6qcqH8nvZWGHsll3jVeScQIU5P83v+YolX6XW93vBB+aNHNyKVaMdp
         dnmDeaGuQvFHiikUOCYknAHK49mQc84SZEbWnkKJCzua1B3wKO9lijdHmVzXgJKXlEuq
         ZFJd3Gms8Qtj9v7nrkFdk+1pwSsnBs8xYbwHaS0i0KhdXuB0+cqZqssZAoY5yGiZWOEG
         oyNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FFhp+MTDGFRUEbZLOp2FoXozZ8qfMM/1xyGfVx88ALk=;
        b=EOVyz1qcSvonLqrZRV6i2tY3PerR4vStcjkNyn24knOYxFOFkimoZBmslNLrqGEeGU
         IyRgBDFZUeAbbTe//KWYoZBWMJFsbSRoo/cMNbXrMB/9dHzIlpGbmx2CHs27UTH0I+uG
         pcYPCZNKHtjNWMZnv6ptfyPvwPyKSpvaz7+UYxA0px0wRl2t6BSPR99r2Fhx9cgM7MY3
         LJPS8vbHE8AKJhSembtgg6oekylRB9/pLFQGPf46npUhmHLujJukVgFcVxsVFkJuKrfY
         MHwFw8Cj6ip6nkqPk1WwPd8pEv9MV54U9YlUWXc4Zxm/Tqh6h4CYin4897LKU7Yu2V4C
         P8sw==
X-Gm-Message-State: APjAAAVOBE5Lk62/XiS6zRo42wOasql/U5Jwz5Y6hZ1tyEsu1jCDXvME
        iqWPf/CihFYLJ+U8D3jQogRDxBVW
X-Google-Smtp-Source: APXvYqzjEPCs+Gj5j9fYyvv6eqLncLzsr/zqJ9sDpNBwppvFHLAWVYlbN8qrXTDehhU/U5Lx2YViFA==
X-Received: by 2002:a05:6214:c3:: with SMTP id f3mr982784qvs.226.1580330962291;
        Wed, 29 Jan 2020 12:49:22 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id 11sm1536050qko.76.2020.01.29.12.49.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:49:21 -0800 (PST)
Message-ID: <1580330950.26012.62.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 29 Jan 2020 15:49:10 -0500
In-Reply-To: <c8788984-3de0-b41c-e2a1-66b67d0674a6@candelatech.com>
References: <1580323191.26012.48.camel@gmail.com>
         <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
         <1580325769.26012.54.camel@gmail.com>
         <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
         <1580327314.26012.59.camel@gmail.com>
         <c8788984-3de0-b41c-e2a1-66b67d0674a6@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-29 at 12:01 -0800, Ben Greear wrote:
> On 1/29/20 11:48 AM, Marlon Smith wrote:
> > 
> > On Wed, 2020-01-29 at 11:27 -0800, Ben Greear wrote:
> > > 
> > > On 1/29/20 11:22 AM, Marlon Smith wrote:
> > > > 
> > > > 
> > > > On Wed, 2020-01-29 at 10:42 -0800, Ben Greear wrote:
> > > > > 
> > > > > 
> > > > > On 1/29/20 10:39 AM, Marlon Smith wrote:
> > > > > > 
> > > > > > 
> > > > > > 
> > > > > > Hi everyone,
> > > > > > 
> > > > > > I have two RT5370 devices connected to the same access
> > > > > > point.
> > > > > > Both
> > > > > > devices are very slow, but the instant I disconnect one
> > > > > > device,
> > > > > > the
> > > > > > other speeds up by a factor of 10.
> > > > > Out of curiosity, are both of the RT5370 used on the same
> > > > > client
> > > > > device?
> > > > > > 
> > > > > > 
> > > > > > Did you check that they have unique MAC addresses?
> > > > > > Thanks,
> > > > > Ben
> > > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > > 
> > > > > > The really strange part is that one device will perform
> > > > > > slowly
> > > > > > even
> > > > > > if
> > > > > > the other device is basically idle! I've confirmed this
> > > > > > with a
> > > > > > packet
> > > > > > sniffer.
> > > > > > 
> > > > > > I've been trying to do some debugging, and I've found that
> > > > > > when
> > > > > > both
> > > > > > devices are connected to the access point, they report a
> > > > > > large
> > > > > > number
> > > > > > of duplicate frames. I added some debug output
> > > > > > in ieee80211_rx_h_check_dup() to confirm that this only
> > > > > > happens
> > > > > > while
> > > > > > both devices are connected. The packet sniffer also shows a
> > > > > > large
> > > > > > number of retries while this is occurring.
> > > > > > 
> > > > > > Using backports 5.3-rc4 for this, but also tested on 4.14-
> > > > > > rc2.
> > > > > > 
> > > > > > I did post about this previously on this mailing list
> > > > > > (RT5370
> > > > > > performance issues), but I thought I'd post again with this
> > > > > > new
> > > > > > information and more descriptive title. I'm a little bit
> > > > > > stuck
> > > > > > on
> > > > > > this
> > > > > > for a while now, so any ideas are much appreciated.
> > > > > > 
> > > > > > Thanks!
> > > > > > 
> > > > > > Marlon
> > > > > > 
> > > > They are on separate devices, although the mac addresses are
> > > > close.
> > > > 70:F1:1C:2E:AF:B4 and
> > > > 70:F1:1C:2E:AF:B6.
> > > > 
> > > > However, I have a third device 70:F1:1C:2E:AF:BB which performs
> > > > well
> > > > and does not affect the performance of the other two.
> > > > 
> > > Have you tried a different AP?
> > > 
> > > And also tried using the exact same MAC addresses configured on a
> > > different
> > > radio (like ath9k)?
> > > 
> > > Thanks,
> > > Ben
> > > 
> > > 
> > I have tried a different access point in a different environment
> > but no
> > luck. I'll see if I can configure my laptop to use one of the
> > problematic devices' mac address.
> It might be tricky to determine, but if you can notice whether one of
> your station devices
> is (block-)acking the other's frames, that would be a good clue that
> it is a station
> side bug.  A carefully inspected sniff, especially if you can put
> sniffer near one station
> and far from the other and so use RSSI as a sorting factor, should
> allow you to determine
> this.
> 
> Thanks,
> Ben
> 
> 

I'll double check this, but I believe there is very little traffic from
the second station while the first station is (slowly) transferring
data. I think that means it's not likely that one device is acking the
other's frames?

I will test this though, and the mac address spoofing, and get back to
you tomorrow.

Really appreciate the help so far, thank you!
