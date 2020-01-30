Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D19714DDC6
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2020 16:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgA3P1B (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jan 2020 10:27:01 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]:46100 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbgA3P1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jan 2020 10:27:00 -0500
Received: by mail-qk1-f172.google.com with SMTP id g195so3219284qke.13
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2020 07:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:date:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=RIl5isGRyg0OUfNiiDJ603XTuJh1TpO2ohuCwJnOvLo=;
        b=GUFWh4mD354dqt4IHjGmax55/AM3DO2xfmAdmCTJ6WonsRnqp4qoVqcSyfCdxQYZG+
         zqPoCwVRPz/k74VW94Beyp6erK/PIKJ83Bus54biO35fqykOmlUmymv9ZPkgA2Meg/Hk
         VGfWpXI/sLSvQHxnf6UqJnxxAwrwGXF6tKL2OwHB1uMB0XIaQEAvxpJXoh0ub3z+SMTv
         bh+C3azuvHE2Aq6j1FgmwN5/q+sIvxZhoYeO3CUIsvA9L4RiSHh27XZ37QrYbduyineK
         IYy5jEHLI4W6aVl2oZ4Ep3/JSUz4PVoaEGHAup0giPdCDzIo0yryNAlHU0p+yrzjSCY6
         i0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RIl5isGRyg0OUfNiiDJ603XTuJh1TpO2ohuCwJnOvLo=;
        b=rel6n5Z/tyWm7wy4ogHy9pHOCw2yRnou0dlJ9EeJs+XR3wBUyn9AF7c915ZIyjbzKz
         69zxHLqUuUItVGQfSI0JYftgdT45q22WPV9m8NY18aIvVRgaDxWYmPO428JX3fGdiYSF
         MZmEibwZpX4bhCgT6CYwBTSOOLXN+Hnia7QzSI9FmXBjCcMT23k/h5I8OUNgRLHgNVoY
         M+0C1mVBRn2ptKTi5aFIBZ4O54yKJ9QPG7fZ95MJ5RLuZa/1lMzbk3py5UXsa7IOjOHK
         XG4/DdX75e/sCp9xoMiv1iGaauDVotVpeigCEj6pDAEy1Q1XSZSJB/UrnqtOSIWPNQ+B
         Fv/A==
X-Gm-Message-State: APjAAAX3VtY2O2UNdV7+N8qjC2tDcBleumrc+3km5fIDKf0H5/QEt0wQ
        BTbC9EHsHPr/3GYbTu17/359Grqg
X-Google-Smtp-Source: APXvYqxHI45Vb7JYhFf0Tc+UvVKri0/B966y/WRL7MaELLWaMG092AjMBbm9SwZf4FZAWr6R3EIv3w==
X-Received: by 2002:ae9:e910:: with SMTP id x16mr5711773qkf.90.1580398019226;
        Thu, 30 Jan 2020 07:26:59 -0800 (PST)
Received: from [192.168.0.10] (dhcp-108-168-58-21.cable.user.start.ca. [108.168.58.21])
        by smtp.gmail.com with ESMTPSA id s26sm3167302qtq.22.2020.01.30.07.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jan 2020 07:26:58 -0800 (PST)
Message-ID: <1580398006.26012.81.camel@gmail.com>
Subject: Re: Strange performance issue when using two devices at once
From:   Marlon Smith <marlon.smith10@gmail.com>
To:     Jean-Pierre TOSONI <jp.tosoni@acksys.fr>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 30 Jan 2020 10:26:46 -0500
In-Reply-To: <AM0PR01MB43879C1D5C9FF8744B5ADDD1E4040@AM0PR01MB4387.eurprd01.prod.exchangelabs.com>
References: <1580323191.26012.48.camel@gmail.com>
         <AM0PR01MB43879C1D5C9FF8744B5ADDD1E4040@AM0PR01MB4387.eurprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-01-30 at 14:55 +0000, Jean-Pierre TOSONI wrote:
> Maybe you need to put some distance between the 3 devices.
> We experienced this kind of problem on radios close to each other
> (around 10cm).
> It was due to radio signals inducing themselves in the PCB of another
> nearby radio, causing the other radio to badly transmit and receive.
> 
> > 
> > -----Message d'origine-----
> > De : linux-wireless-owner@vger.kernel.org [mailto:linux-wireless-ow
> > ner@vger.kernel.org] De la part de
> > Marlon Smith
> > Envoyé : mercredi 29 janvier 2020 19:40
> > À : linux-wireless@vger.kernel.org
> > Objet : Strange performance issue when using two devices at once
> > 
> > Hi everyone,
> > 
> > I have two RT5370 devices connected to the same access point. Both
> > devices are very slow, but the instant I disconnect one device, the
> > other speeds up by a factor of 10.
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

Thanks for the reply Jean-Pierre. I just discovered this morning that
if I change the MAC address of one of the devices, they both perform
well. So I'm wondering if it is a driver issue.

However I will keep this in mind, as I often do have multiple devices
together in close proximity.
