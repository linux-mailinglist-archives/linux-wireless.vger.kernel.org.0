Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA0714D127
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2020 20:23:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA2TXD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Jan 2020 14:23:03 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:37354 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgA2TXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Jan 2020 14:23:03 -0500
Received: by mail-qk1-f182.google.com with SMTP id 21so420978qky.4
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2020 11:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=yVPwCZou2x7KcgTyD/o2JIHV/9f6QyHEWgD9za61bSI=;
        b=ptEOB2657hNO1ogcR9cKLvjnUT166iN7VMcmS9PdR1TmYpbgpAB+sf2Q5izEkjWGMw
         u2RIXpt0sU9q7EducLYS0IdR+FyZT4mRuCyNkQ9xJQc+IDHvkj45cB4XoCKFP86WLIY/
         iXUceO9llDDV/dLSWe4MV5xV/HsLEs7UPot6g0QrJLrdTIiKHwlJmBYcQALJspsTnb7h
         Aes2gcH7rmH0MVx3iaAZPd/ORrpaWMJg05vtkFN/wp8hn36gtyXfm+YW2ns8+bs66yc+
         wAnFRwPlU8gVFbdu1ysaR/hOu5DSClh+umBgisLmjtDGWw5q43xZV2KwD7svk+7CHDmY
         /RhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yVPwCZou2x7KcgTyD/o2JIHV/9f6QyHEWgD9za61bSI=;
        b=LE7X3eeE45SS7e0554DZcBki22Lp+JWrOp7g+vz5lAg+n84r72XlMOD7tEWb3vgYLE
         sIESWKOkkxirfFznsNShte161hrP3ZEdbUDUxYk7fUy1pPg1SKu+otcIQEFkSkI19uoL
         kyYCFZoOx0pasFOKEE/7/VGNKHf4sSanT/+DTF8bcwvYmSRoCY99AQfX0MzyBge+7Z8s
         9nlZYVMY0Ob21kH92XXulTaqfzJ7HVv6Zx+nzyeOit3Damb7UM4Hgn3pPL/Z7mWBUFXr
         NixkvGjrQ3BMYJN9hkGVoXrH8N1nKYVjtAm0njIykeJL1xQabccG0DR5maKKggKXvOlU
         YS9Q==
X-Gm-Message-State: APjAAAX6mpYVHJb+bmTSZ3lfvGOAH+4ABNWxs1czUmasdfmuYGWZ78Re
        yqvytZgcD7M33RJAESV78u44VGcG
X-Google-Smtp-Source: APXvYqzHhoj2o/wnhST7vqFBBo5bziCdYvoYbfN2Jci1kxSdjBypgpC5xMlXdaeIiwmseWkixnyquQ==
X-Received: by 2002:a37:8e45:: with SMTP id q66mr1334631qkd.129.1580325782137;
        Wed, 29 Jan 2020 11:23:02 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id h12sm1552695qtn.56.2020.01.29.11.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 11:23:01 -0800 (PST)
Message-ID: <1580325769.26012.54.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Wed, 29 Jan 2020 14:22:49 -0500
In-Reply-To: <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
References: <1580323191.26012.48.camel@gmail.com>
         <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2020-01-29 at 10:42 -0800, Ben Greear wrote:
> On 1/29/20 10:39 AM, Marlon Smith wrote:
> > 
> > Hi everyone,
> > 
> > I have two RT5370 devices connected to the same access point. Both
> > devices are very slow, but the instant I disconnect one device, the
> > other speeds up by a factor of 10.
> Out of curiosity, are both of the RT5370 used on the same client
> device?
> > Did you check that they have unique MAC addresses?
> > Thanks,
> Ben
> > > 
> > 
> > The really strange part is that one device will perform slowly even
> > if
> > the other device is basically idle! I've confirmed this with a
> > packet
> > sniffer.
> > 
> > I've been trying to do some debugging, and I've found that when
> > both
> > devices are connected to the access point, they report a large
> > number
> > of duplicate frames. I added some debug output
> > in ieee80211_rx_h_check_dup() to confirm that this only happens
> > while
> > both devices are connected. The packet sniffer also shows a large
> > number of retries while this is occurring.
> > 
> > Using backports 5.3-rc4 for this, but also tested on 4.14-rc2.
> > 
> > I did post about this previously on this mailing list (RT5370
> > performance issues), but I thought I'd post again with this new
> > information and more descriptive title. I'm a little bit stuck on
> > this
> > for a while now, so any ideas are much appreciated.
> > 
> > Thanks!
> > 
> > Marlon
> > 

They are on separate devices, although the mac addresses are close.
70:F1:1C:2E:AF:B4 and
70:F1:1C:2E:AF:B6.

However, I have a third device 70:F1:1C:2E:AF:BB which performs well
and does not affect the performance of the other two.
