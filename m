Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B23D1516F6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 09:24:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDIYS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 03:24:18 -0500
Received: from mail.monom.org ([188.138.9.77]:40024 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgBDIYS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 03:24:18 -0500
X-Greylist: delayed 581 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Feb 2020 03:24:17 EST
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 7EC345004A3;
        Tue,  4 Feb 2020 09:14:35 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.monom.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.2
Received: from localhost (b9168f78.cgn.dg-w.de [185.22.143.120])
        by mail.monom.org (Postfix) with ESMTPSA id 4F4E0500493;
        Tue,  4 Feb 2020 09:14:35 +0100 (CET)
Date:   Tue, 4 Feb 2020 09:14:35 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     JH <jupiter.hce@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        connman <connman@lists.01.org>
Subject: Re: Failed to can wifi Invalid Sched_scan parameters
Message-ID: <20200204081435.zhzqtsnrcgkzhpdw@beryllium.lan>
References: <CAA=hcWQuz9QTvbRJgFXBbYrB9RBmWajCJ=oD49DyEaLw91t2bQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=hcWQuz9QTvbRJgFXBbYrB9RBmWajCJ=oD49DyEaLw91t2bQ@mail.gmail.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi JH,

On Tue, Feb 04, 2020 at 04:00:54PM +1100, JH wrote:
> [23703.958751] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> Invalid Sched_scan parameters
> 
> Where is the WiFi driver? Please let me know if you need more debug information.

linux/drivers/net/wireless/marvell/mwifiex

> > I am running kernel 4.19.75 on iMX6, the WiFi was working most of
> > time, but from time to time, the connman could not get WiFi be
> > connected due to following error:
> >
> > [23703.958751] ieee80211 phy0: mwifiex_cfg80211_sched_scan_start :
> > Invalid Sched_scan parameters
> >
> > What does that error means, in which circumstance it occurred? How can
> > we prevent it?

The 'Invalid Sched_scan parameters' indicates, wpa_supplicant is
providing the wrong parameters. Best thing is to monitor between
wpa_supplicant and kernel the netlink messages. iwmon is an excellent
tool for this.

Thanks,
Daniel
