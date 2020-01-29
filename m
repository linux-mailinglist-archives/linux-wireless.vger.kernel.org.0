Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE68914D154
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 20:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgA2Tss (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 14:48:48 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:41606 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgA2Tsr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 14:48:47 -0500
Received: by mail-qk1-f181.google.com with SMTP id s187so478503qke.8
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 11:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=slc3rWpEf3WGPbJ6YA984NeYUtj+x1rmoMByNZMYNcM=;
        b=obTWgWhkdWWKXC+hcBpIfb2/ReJ2ZeiPAlMweFC3IBzDdYii27Pg5bVWbSjNVz+tDM
         Vl26u1EhsdlG2HzKXaJeKC5/86yaIFWyAJxIovF2QI0GPFSh4mHwkXAabgTjoIwYiFkB
         CcH8AvZV4OjuaEX7yJUisOzB5FooY4dVkvnF7LmoHWB+G/c24mQ8a5V48jaoQ+izBm56
         uIMccTRzRu5zfk1g7H3CIoGRMBMinq66IXSybayzfadZ+Nf6B1d1awi5aklx8DRm15Na
         A6eoqAF18M+uZOd3NSOG3wiTDe+vpA9VBj+OnW6R0bKzpL29QDYZlqt99i8fuuGh0l6R
         L+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=slc3rWpEf3WGPbJ6YA984NeYUtj+x1rmoMByNZMYNcM=;
        b=OSBUUBsUwKDeGcAO53yll9eZJpbPaGbojOLcz8oHYCBHim0WmFO5xo+kSJONSmUdXn
         W7JAuCxwbnmjfvtGZLZhpmhhKSOBRxSaZUa5vbasvMG70liK/FASW4YydCxAJpyc/pdu
         BJJRCLqv3cE4yuwECI+kCYFyrnMA4wi0gOqAE65l8iyaBgrNfFaKEJUEvP0cRXep8FEW
         CXgvUL9mGvQBe7F0mW7DPIkj5hTtgkjzwMjp10j9NNBVbFKnZlON9kx+TbvSoleykIni
         zJYnCqKp83v4scg4MUYWu8ZLsEu1wDlONEHGOdzU5NzuRdT0n8nhEVmGWRxNEFrMAinC
         0rYw==
X-Gm-Message-State: APjAAAUhBB0py5p/9fNO1w3UVjQcjt9OrNr4/odQSpEVbEmht1VHIE6c
        Ey0vFIvqeB1Pv6gYVWtsMb6nW0zU
X-Google-Smtp-Source: APXvYqwjhjXU+pqz2arMHdthwDBJZZ6aN3n07VdwxlebTqnWv8kpCDuZj/tjytJMrLrt3ai1Q4M+AA==
X-Received: by 2002:a37:a390:: with SMTP id m138mr1380715qke.23.1580327326591;
        Wed, 29 Jan 2020 11:48:46 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id o17sm1561199qtq.93.2020.01.29.11.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:48:45 -0800 (PST)
Message-ID: <1580327314.26012.59.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 29 Jan 2020 14:48:34 -0500
In-Reply-To: <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
References: <1580323191.26012.48.camel@gmail.com>
         <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
         <1580325769.26012.54.camel@gmail.com>
         <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-29 at 11:27 -0800, Ben Greear wrote:
> On 1/29/20 11:22 AM, Marlon Smith wrote:
> > 
> > On Wed, 2020-01-29 at 10:42 -0800, Ben Greear wrote:
> > > 
> > > On 1/29/20 10:39 AM, Marlon Smith wrote:
> > > > 
> > > > 
> > > > Hi everyone,
> > > > 
> > > > I have two RT5370 devices connected to the same access point.
> > > > Both
> > > > devices are very slow, but the instant I disconnect one device,
> > > > the
> > > > other speeds up by a factor of 10.
> > > Out of curiosity, are both of the RT5370 used on the same client
> > > device?
> > > > 
> > > > Did you check that they have unique MAC addresses?
> > > > Thanks,
> > > Ben
> > > > 
> > > > > 
> > > > > 
> > > > The really strange part is that one device will perform slowly
> > > > even
> > > > if
> > > > the other device is basically idle! I've confirmed this with a
> > > > packet
> > > > sniffer.
> > > > 
> > > > I've been trying to do some debugging, and I've found that when
> > > > both
> > > > devices are connected to the access point, they report a large
> > > > number
> > > > of duplicate frames. I added some debug output
> > > > in ieee80211_rx_h_check_dup() to confirm that this only happens
> > > > while
> > > > both devices are connected. The packet sniffer also shows a
> > > > large
> > > > number of retries while this is occurring.
> > > > 
> > > > Using backports 5.3-rc4 for this, but also tested on 4.14-rc2.
> > > > 
> > > > I did post about this previously on this mailing list (RT5370
> > > > performance issues), but I thought I'd post again with this new
> > > > information and more descriptive title. I'm a little bit stuck
> > > > on
> > > > this
> > > > for a while now, so any ideas are much appreciated.
> > > > 
> > > > Thanks!
> > > > 
> > > > Marlon
> > > > 
> > They are on separate devices, although the mac addresses are close.
> > 70:F1:1C:2E:AF:B4 and
> > 70:F1:1C:2E:AF:B6.
> > 
> > However, I have a third device 70:F1:1C:2E:AF:BB which performs
> > well
> > and does not affect the performance of the other two.
> > 
> Have you tried a different AP?
> 
> And also tried using the exact same MAC addresses configured on a
> different
> radio (like ath9k)?
> 
> Thanks,
> Ben
> 
> 

I have tried a different access point in a different environment but no
luck. I'll see if I can configure my laptop to use one of the
problematic devices' mac address.
