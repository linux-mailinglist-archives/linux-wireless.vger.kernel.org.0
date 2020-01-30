Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 862C714DCF6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgA3OoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 09:44:15 -0500
Received: from mail-qt1-f173.google.com ([209.85.160.173]:46926 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbgA3OoP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 09:44:15 -0500
Received: by mail-qt1-f173.google.com with SMTP id e25so2581450qtr.13
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2020 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=d46qu5uMLykp81I1kDLZmH6IB+XSg/49x0PWTySiPBM=;
        b=egHlBdyW/tBVIRrSN6R5rA4daA1evjOvkK/N1EYL6KdGDmsZmN5ijoOKPT1zyU4+bK
         MJ5jJm+pGIp6umBMj/haAd3oj+p7+B+FQaJTErg72zNHncxFfgcz1Z+5vDYf69XOjIhS
         rIUv5FMA+tYywnxj9QFlg9LXUQ/4ulKRnVNLQrRYpvja7SOvw/cYIlHYXNLwDJvjI4Lx
         sJlrOjf8r+zZfnRfvR/EgonIFb+Sw1UL7mH78Sa3LKvCqLxXhIBM0hWt9s98UeFVYn3N
         e7N86T3IKd3QuQwT9U8l7AOmwkVwk1HV7BT2+UhoCPgHGpbOcP2NzIMaHtuAi4zVi4Lu
         KY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d46qu5uMLykp81I1kDLZmH6IB+XSg/49x0PWTySiPBM=;
        b=ifwnKT27VnCLC5WrTQcEsL9rcdqxCrvJI5GCo7Q87QI60+qr3/8AVH9mUbj4Y1/b3R
         G0Ly/fnXE8PLasEqcegmGibfo5eCVTiLfhN956wDM5Nj1pyTY2RD4WZ5XlJkjRgiJkyE
         UVZ4rjJXQ75x8VZU408G8IO37u7fJ0JejLhyo5uG2QMkHxIcqpH3v4Teuvyi0l+h/LP4
         maRXj84RtE/XwBZrahmfljw7xur2SC6ajK8UEfSvyCCWV9vJaeY6qbyWAAWcLBCp2rC0
         DADzOn0UVUlG3EnaKKmlww/VoJxh7ZLfA0yaLVhOTdZ2yJzr81vN7sncibQtCfZKT6IT
         fRpg==
X-Gm-Message-State: APjAAAUlif4des8WLZgk71uLgevXaa6UIsl2QpogHI4Si4F2now2gk+c
        gETaq1WijFMrLTmZQ7zHKLDYa4Ba
X-Google-Smtp-Source: APXvYqzKSZOrzEuonrqMUgMdPTZTmxJIifMwxDtf87xnLh6ffXXYGGPNP6+4wxx9aDj5xfveK59PNw==
X-Received: by 2002:aed:34c1:: with SMTP id x59mr5318832qtd.236.1580395452396;
        Thu, 30 Jan 2020 06:44:12 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id h12sm3058416qtn.56.2020.01.30.06.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 06:44:11 -0800 (PST)
Message-ID: <1580395439.26012.75.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jan 2020 09:43:59 -0500
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

So I did a few tests and got some pretty interesting results.

With the two devices connected to the access point and performing
slowly, I changed the MAC address of one of the devices (Just from a B6
to a BA). Immediately, both devices began working properly!

Back to the original MAC address, I looked at my sniffer, and I do not
see any evidence of one device acking another device's frames. With one
device sitting idle and the other transferring data, I see high numbers
of retransmitted frames, and then an eventual ack from the correct
device, but very little activity from the idle device. While this is
happening, the device driver indicates that it is dropping lots of
duplicate received packets.
