Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03AC714DE55
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 17:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbgA3QEk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 11:04:40 -0500
Received: from mail-qk1-f174.google.com ([209.85.222.174]:34135 "EHLO
        mail-qk1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbgA3QEk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 11:04:40 -0500
Received: by mail-qk1-f174.google.com with SMTP id d10so3434885qke.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2020 08:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Mi3e5ntFbEBhiZe5AnvQk6GcNJdvUP7zgnEy+O+mv7M=;
        b=tvA41KrON4SkX9XCzbt7jCyPkdC95ZII8eHL7+Xrl6gzMipQVoFAIlA07UkXSRYxrE
         xWyraTr+BEfb8fy9UJH07DELOkd0oY0jIk+IvQQt6fwYgtBQiQf+JFsZA9/qdtXg+clg
         m2K+gu6Vb4tENglalDT5f3127sj+g/MQi5O3lkDgYJkwSqdHI2Ifng4i2WD8R06Y7jDs
         n8K+VpHOJN3V6AXly3CSWwdJsPan454DZWDjLP554e/mpFff/4NIcVlBt007HqzZDut8
         1ABk0ZuPDtUr9FXlMhNaOz2oJMHnbZOjP58mMXDWbbGOjMMJL9aac+p6ygxjtoLtrzxD
         mzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mi3e5ntFbEBhiZe5AnvQk6GcNJdvUP7zgnEy+O+mv7M=;
        b=Bylu+s6KCePWo1uclOYyv01xxOZ4OjgOgAANuNBhR3XYQNOnG4m8qbg9K+Ek5F5OHG
         kqv/w5T356B0Glld8nx1veE32LrOoKVIkavMv/2amlysxNqgu+2VyXcUX6mYVDD/ELkM
         WZyebVWtbmo5IdMKM+BGKcqLYTyEMyN5UO3aVtQfs7LA5kCoIwCXvWbE6qnxgViC+lF5
         WYu4WCWn3EsB8iv9vBPDOjQ3pzKYITzSPFPgxx22AXn128XpCMPZGSa6d5J51YqIPmhQ
         XmCya7A9xqZ0v+tQEEbb28oMkYznzZ7GydLaOAJgjGYruqY9wedoeuV9adzf+zQyd8dG
         hgLA==
X-Gm-Message-State: APjAAAVy1pOmwyTgQKyHIMtnAFVzCyy5VoapPutqm7cTZcO7RC2yXxKP
        mDBcge4LtNuFLouJqJUFjeg=
X-Google-Smtp-Source: APXvYqxvZF5O9yyDaYAPqoAD4BOies6imHbS/RYXcRNApj2H8zOD+y59di08Gc/TsSgENmmiZZH4Gg==
X-Received: by 2002:a05:620a:11a1:: with SMTP id c1mr6108034qkk.390.1580400259896;
        Thu, 30 Jan 2020 08:04:19 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id d26sm2878017qka.28.2020.01.30.08.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 08:04:18 -0800 (PST)
Message-ID: <1580400246.26012.88.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>, Ben Greear <greearb@candelatech.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 30 Jan 2020 11:04:06 -0500
In-Reply-To: <0c80b739-b190-1a33-47d1-a04692a948c7@nbd.name>
References: <1580323191.26012.48.camel@gmail.com>
         <2e80a485-892d-3b29-19c7-38a9caa14f4b@candelatech.com>
         <1580325769.26012.54.camel@gmail.com>
         <6bcff97c-3b9b-7fa9-5101-80aca367ff84@candelatech.com>
         <1580327314.26012.59.camel@gmail.com>
         <c8788984-3de0-b41c-e2a1-66b67d0674a6@candelatech.com>
         <1580395439.26012.75.camel@gmail.com>
         <0c80b739-b190-1a33-47d1-a04692a948c7@nbd.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-01-30 at 16:32 +0100, Felix Fietkau wrote:
> On 2020-01-30 15:43, Marlon Smith wrote:
> > 
> > So I did a few tests and got some pretty interesting results.
> > 
> > With the two devices connected to the access point and performing
> > slowly, I changed the MAC address of one of the devices (Just from
> > a B6
> > to a BA). Immediately, both devices began working properly!
> > 
> > Back to the original MAC address, I looked at my sniffer, and I do
> > not
> > see any evidence of one device acking another device's frames. With
> > one
> > device sitting idle and the other transferring data, I see high
> > numbers
> > of retransmitted frames, and then an eventual ack from the correct
> > device, but very little activity from the idle device. While this
> > is
> > happening, the device driver indicates that it is dropping lots of
> > duplicate received packets.
> Here's the cause and an approach for fixing it:
> 
> The MAC_BSSID_DW1 register configures the Multi-BSSID mode. It can be
> configured for 1, 2, 4 or 8 BSSIDs. This controls what MAC addresses
> the
> chip will respond to. The driver always sets it up for 8 BSSIDs.
> 
> The problem here is that the chip has a hardcoded pattern for how
> those
> BSSIDs are allocated:
> Depending on the number of BSSIDs, the lower 1, 2 or 3 bits are used
> to
> encode the BSS index. This means that when 8 BSSIDs are enabled, the
> lower 3 bits are effectively masked out on the MAC address filter
> that
> decides which frames to ACK. Because your MAC addresses are so close
> together, both devices try to ACK the same frames at the same time.
> This
> will not be visible in a sniffer, since they will be transmitting at
> the
> same time.
> 
> I'd say the first step in fixing this is to make the driver set
> MAC_BSSID_DW1_BSS_ID_MASK based on the MAC addresses of configured
> virtual interfaces. For older chips, this MAC address pattern cannot
> be
> fixed.
> 
> However, on at least RT3883, RT3352 and RT5350 (and thus most likely
> also RT5370), you can set BIT 21 in that register, which changes the
> pattern. With that bit set, the second interface only sets the local
> bit
> of the MAC address, and from the third interface on it adds (idx-
> 1)<<2
> to the first byte. That gets rid of the MAC address conflicts.
> 
> Hopefully someone familiar with the rt2x00 code will read this and
> write
> some patches :)
> 
> - Felix


Felix, this was exactly it. I set that bit and the problem disappeared.
Thank you so much!

Ben, your help was very much appreciated as well. Your suggestions
really helped narrow things down.

Is there a way I can help others who might come across this problem in
the future? Would filing a bug report help anyone out, even if just to
document this issue?

Thanks again both of you, you saved me countless hours of time here.

Marlon
