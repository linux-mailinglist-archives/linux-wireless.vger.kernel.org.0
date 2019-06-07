Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB403893D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2019 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfFGLlL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jun 2019 07:41:11 -0400
Received: from a1i1011.smtp2go.com ([43.228.187.243]:35941 "EHLO
        a1i1011.smtp2go.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfFGLlL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jun 2019 07:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=smtpservice.net; s=mb6cr0.a1-4.dyn; x=1559908571; h=Feedback-ID:
        X-Smtpcorp-Track:Message-ID:Date:Subject:To:From:Reply-To:Sender:
        List-Unsubscribe; bh=0Ih6U0sieyG0KNDet+AoFWTIELVRBrimO0YKVl7KyRU=; b=syLp10tw
        Nt5HvX0LgJy3Q6lqnxtf/21EcUA3PGs4lmHJiI3DYbAglPAPXDWS7BeaY+AP/OQjsrc7OVUOSeuLX
        +q8BwvhFvO9l540KdZzFo761kznmlA394VKaiWhSsbQP7c+Gz/hlIWgMKkND9hc+Rdth+OzVtPgPN
        teOZE4EHUHyILg70TlZpbPANYZ8ytrRU5REtYh0qqXqGxgWnGl6elWSlpHCELrTJBLF2u8mjyc55N
        XUoSQvXk5bKSli8rC3gTjDG+H0MzqIs7hZnfmjD9b7pSFiR/RoSl1B6ZiB/F8uW3ulS2dFgJb+puw
        NLbCiWe1Nx+EY/R5lx/BnNCuYg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=balki.me; i=@balki.me; 
 q=dns/txt; s=s521451; t=1559907671; h=from : subject : to : message-id 
 : date; bh=0Ih6U0sieyG0KNDet+AoFWTIELVRBrimO0YKVl7KyRU=; 
 b=K2wsVxncz2RHQIRJqHkNCtps6RRqikrULgJ+V0fKiUNTsgTe2wLWRpxYib4HAyUHxXRzCG
 /eRu/qL5K0lkdnatwGBu362WLluQc2SOL8mdRQOjhJRxPloqXeM+uiL9nzX3iA+uGQk6WqMK
 JGKHg44748fKmrzy9HivI1W0lQFgCe4KHU0s92tsXkmDbc/+8/oaql4g68s1JL8QShZZe8iP
 VWy6H9MqNJsZbkCMhAn9fs3b3RoX8a+tYpbHi+27qRiACGPltXRtt/vFpK4SzP/TSVqBk+Ef
 6Uu2hsr+Bdt0l8E9NcT/rMd2/vN9DA4kwTE5oa5IAUawAqN0zQrcJN3A==
Received: from [10.45.33.53] (helo=SmtpCorp)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hZDF4-4pkTJb-Gw; Fri, 07 Jun 2019 11:41:06 +0000
Received: from [10.135.23.123] (helo=zadesk.localnet)
 by smtpcorp.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92-S2G) (envelope-from <linux-wireless-list@balki.me>)
 id 1hZDF3-rlZGmU-LX; Fri, 07 Jun 2019 11:41:05 +0000
From:   Balakrishnan Balasubramanian <linux-wireless-list@balki.me>
To:     Emmanuel Grumbach <egrumbach@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: iwlwifi module crash
Date:   Fri, 07 Jun 2019 07:41:02 -0400
Message-ID: <2696773.yqXG4m880n@zadesk>
In-Reply-To: <CANUX_P0=F4-Q5Drhcpk6-y7F7Ub3omQk=Pg6wh3pv=pLc9YHWQ@mail.gmail.com>
References: <2455026.F8Aexx8IWb@zadesk>
 <CANUX_P0=F4-Q5Drhcpk6-y7F7Ub3omQk=Pg6wh3pv=pLc9YHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Smtpcorp-Track: 1hZDF3r_ZGXlLb.Ao1ToiGDB
Feedback-ID: 521451m:521451aMgsuo0:521451sZ9B4uoj52
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> This is because the device is removed from the PCI bus. Nothing from
> iwlwifi side can be done.

I am sure the device is not physically disturbed. If that was the case, should it not stay down when restarting the system?

> If that happens upon suspend / resume, I know there are been fixes in
> PCI bus driver.

To my knowledge I have disabled all power/suspend features and I don't see releated logs in journal except the below. Not sure if relevant.

    Jun 03 21:33:14 zadesk kernel: wlan0: Limiting TX power to 14 (17 - 3) dBm as advertised by d4:5d:df:25:ee:90

Is there a way to restart the module safely without restarting the system?

Regards,
Bala


On Friday, June 7, 2019 5:25:41 AM EDT Emmanuel Grumbach wrote:
> On Fri, Jun 7, 2019 at 5:22 AM Balakrishnan Balasubramanian
> 
> <linux-wireless-list@balki.me> wrote:
> > I am using iwd demon for wifi. Once a while I loose connectivity.
> > Restarting the demon does not help. But once I restart the system, it
> > starts working fine. Attaching stack trace from journal.
> 
> This is because the device is removed from the PCI bus. Nothing from
> iwlwifi side can be done.
> If that happens upon suspend / resume, I know there are been fixes in
> PCI bus driver. If not, check that the device sits correctly in its
> socket.
> 
> > Regards,
> > Bala
> > 
> > 
> > ---------- Forwarded message ----------
> > From: Denis Kenzior <denkenz@gmail.com>
> > To: Balakrishnan Balasubramanian <iwd-lists@balki.me>, iwd@lists.01.org
> > Cc:
> > Bcc:
> > Date: Thu, 06 Jun 2019 18:07:40 -0500
> > Subject: Re: iwd crashes randomly
> > Hi Bala,
> > 
> > On 06/06/2019 06:00 PM, Balakrishnan Balasubramanian wrote:
> > > Sometimes after a week and sometimes after two days. Once crashed,
> > > restarting the service does not help. Had to restart the computer.
> > > Attaching stack trace from journal.
> > 
> > That implies that your kernel is crashing, not iwd.  The attached log
> > shows a kernel stack trace somewhere inside iwlwifi module.  I would
> > post this trace to linux-wireless@vger.kernel.org.
> > 
> > If you have an associated iwd backtrace, then certainly post this here,
> > but if the kernel module is crashing, there isn't much we can do.
> > 
> > Regards,
> > -Denis




