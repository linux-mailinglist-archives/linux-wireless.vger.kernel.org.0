Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E408B2D0517
	for <lists+linux-wireless@lfdr.de>; Sun,  6 Dec 2020 14:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLFNUy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 6 Dec 2020 08:20:54 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:45005 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgLFNUy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 6 Dec 2020 08:20:54 -0500
Received: from localhost (unknown [103.82.80.195])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id C5601240003;
        Sun,  6 Dec 2020 13:20:11 +0000 (UTC)
Date:   Sun, 6 Dec 2020 18:50:09 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, Ping-Ke Shih <pkshih@realtek.com>
Subject: Re: Realtek RTL8723BE throttling network speed
Message-ID: <20201206132009.rmz7ryw7bok2ihjx@yadavpratyush.com>
References: <20201203113120.mdbhyiqn5zgf37li@yadavpratyush.com>
 <a497f933-0809-1ab8-a064-1519142ceb05@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a497f933-0809-1ab8-a064-1519142ceb05@lwfinger.net>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 04/12/20 09:19PM, Larry Finger wrote:
> On 12/3/20 5:31 AM, Pratyush Yadav wrote:
> > Hi,
> > 
> > I have the Realtek RTL8723BE wireless network adapter on my laptop:
> > 
> >    $ lspci | grep -i wireless
> >    08:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE PCIe Wireless Network Adapter
> > 
> > running kernel version "5.9.10-arch1-1".
> > 
> > I am seeing some strange behavior on it for some time now. When I power
> > on my router and connect to it, I get the full download speed for about
> > an hour or so. After that the speed throttles to around 60-70 KB/s.
> > Other devices connected to the router continue work at full speed.
> > 
> > If I power cycle the router, it again works at full speed for about an
> > hour or two and then throttles back to around 60-70 KB/s.
> > 
> > Has anybody ever seen any problem like this? Any fixes for this? Or at
> > least any pointers to where I can start looking in the driver source?
> > 
> > Any help would be appreciated because this is quite annoying having to
> > restart the router every hour or so.
> 
> What router and software version?

It is from an obscure manufacturer called "SyroTech". I can't find any 
info on the software on the web or on the manual.
 
> Does unloading/reloading rtl8723be fix the problem without resetting the router?

No.
 
> I tried the rtl8723be connecting to a Netgear WNDR4500. The starting
> speedtest.net speeds of 45 Mbps down and 12 Mbps up were maintained for 10
> hours. The up speed is the maximum for my broadband connection. The
> interface had 2 disconnects for reason 3, but it reconnected automatically.

Turning off power saving in NetworkManager and loading rtl8723be with 
options "ips=0 swlps=0 fwlps=0" seems to have fixed the problem over a 
couple days of testing.
 
> Larry

-- 
Regards,
Pratyush Yadav
