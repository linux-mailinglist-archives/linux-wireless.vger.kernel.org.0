Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F432F9524
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jan 2021 21:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbhAQUcU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 17 Jan 2021 15:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730254AbhAQUcS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 17 Jan 2021 15:32:18 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90258C061573
        for <linux-wireless@vger.kernel.org>; Sun, 17 Jan 2021 12:31:36 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 6so7255587wri.3
        for <linux-wireless@vger.kernel.org>; Sun, 17 Jan 2021 12:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LZAkrW2GaOmYJY0cBuwNbHMnIhbHp8r9sGi6wYfzRc0=;
        b=AtqLF0lD7ZhC1en73Gm/YzTq/C3i4SZFMYnsQs75Brpu6C+XpVn+t1ZwQ3vswEuuUr
         PiBzWazn0s4pk81ee9etn1ILJ508lbigatR99a+lxNB+f42aVFZDYRl2b52aN0C/Jdk6
         432NLRqiHgpGVlNYpqLTBPTDP/8Va0N7L7GT+uVK/H4nuVlpAS3EoIMmk93xvnydaP9Z
         AXEpL4aGNQhQhcUoPbxd7lhWoGatjVznZTLKjC66ooZGpCw9MOjQjXkTwMqpQRLjZjht
         Ch4JTQ3SeUViUjNKsjr0yAgWRcJgs6XCWgOuD5fy8ELDTmrnn4g0c3azJlhYkM1l2YLf
         ofog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LZAkrW2GaOmYJY0cBuwNbHMnIhbHp8r9sGi6wYfzRc0=;
        b=SZhImBzWKV8xZbLCd1jEnI7rDd3ojNT7KZ8Hf1KnoiocD4JvCIe7Y0l2FySMsyY6HK
         m2BurDEX4bYa5QYEWwDHMZ3UejFJdjSWqXwZKn+3tvyHP7fTWb8ocJcWSetSjBtcmZPa
         wO859J0IZ0s42lVzCzp5akN0Fg8V1X1517t0v8zvWB7ChBPqXiCeXB71MIgG3RCFAg9m
         J3awqYPYLL4YQ2r+rz8AlgaJic/BXIvzcH5AbF/zyQ8Uh4LK3Q6hQGoisYuAN1pKTQBq
         4NFMK1oQdfW6uesylh2R+JyDTdP3s0+ue0cHqEOJ/YxIoCPu3jn0g7hzjU541D674Ubl
         FaAw==
X-Gm-Message-State: AOAM5336vqY24OoGsz4wTiGOV7R9HZJUfqwlDAZtgG+uiDNb4fiRqvXF
        zT9dPigONRgsT3M/RpVRYd8=
X-Google-Smtp-Source: ABdhPJymSVXRwigEunLAlOFM5hXprF8JLbBMLyLT4KhhZDgDw1lVMRfcQ4q73tZt50GrY+3aZVptkg==
X-Received: by 2002:a05:6000:1d2:: with SMTP id t18mr22660086wrx.412.1610915494756;
        Sun, 17 Jan 2021 12:31:34 -0800 (PST)
Received: from medion (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id u13sm25188212wrw.11.2021.01.17.12.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jan 2021 12:31:33 -0800 (PST)
From:   Alex Dewar <alex.dewar90@gmail.com>
X-Google-Original-From: Alex Dewar <alex.dewar@gmx.co.uk>
Date:   Sun, 17 Jan 2021 20:29:36 +0000
To:     Geoffrey Mon <mail@geofbot.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>, linux-wireless@vger.kernel.org
Subject: Re: How to port rtl8xxxu to new device...?
Message-ID: <20210117202936.oqdqcnzbui3nhjyn@medion>
References: <20210117175533.ya3wcb6yyqfgwiln@medion>
 <20210117191434.GA688839@jumping-cholla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210117191434.GA688839@jumping-cholla>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jan 17, 2021 at 02:14:34PM -0500, Geoffrey Mon wrote:
> On Sun, Jan 17, 2021 at 05:55:33PM +0000, Alex Dewar wrote:
> > Hi all,
> >
> > I'm currently trying to port the rtl8xxxu driver to RTL8822u chips (one
> > of which I own), but I'm finding it hard to figure out where to start
> > and I figured that some wiser minds could maybe help steer me in the
> > right direction.
> >
> Hi Alex,
> 
> I am not very knowledgeable since I've only just started looking into adding
> support for some older Realtek USB adapters, but another starting point for
> adding rtl8822bu support might be the rtw88 driver, which is specifically
> built for rtl88xx chips and which has support for rtl8822be (which uses PCIe);
> in principle a lot of code can be shared between 8822b{e,u}. However, although
> rtw88 includes some structure to support USB devices in the future, this support
> hasn't been added yet. There is at least one project[0] that I've come across
> trying to add that support. I'm not sure how active this project is but it does
> look like they have some work in progress for rtl8822bu.

This was really helpful. Thanks!

The project seems somewhat up to date (although I did get a hard lockup
when I tried to use it...), but it definitely seems a useful avenue to
go down.

Best,
Alex

> 
> Best,
> Geoffrey
> 
> [0] https://github.com/ulli-kroll/rtw88-usb
