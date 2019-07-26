Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41DC276B0E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 16:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfGZOHl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 10:07:41 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:49628 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfGZOHl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 10:07:41 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hr0sl-0004Pa-Fy; Fri, 26 Jul 2019 16:07:39 +0200
Message-ID: <218afd33eda4410472c2a99624f81908cf535cb4.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: reject zero MAC address in add station
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Karthikeyan Periyasamy <periyasa@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 26 Jul 2019 16:07:38 +0200
In-Reply-To: <fd6e7a7e0746b861bbbd660bf54cc675@codeaurora.org>
References: <1563959770-21570-1-git-send-email-periyasa@codeaurora.org>
         <0cc7d0c578b60730e77ecd03e2df240dd1b393a0.camel@sipsolutions.net>
         <fd6e7a7e0746b861bbbd660bf54cc675@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-26 at 19:36 +0530, Karthikeyan Periyasamy wrote:
> > > Don't allow using a zero MAC address as the station
> > > MAC address. so validated the MAC address using
> > > is_valid_ether_addr.
> > 
> > Theoretically, all zeroes might have been a valid address at some 
> > point.
> > I see no reason not to reject it, but I'd like to know why you ended up
> > with this now??
> > 
> 
> Its a Wireless fuzz testing tool (codenomicon) which sends out different 
> types of frames to the AP. It actually tampers legitimate wireless 
> frames (Probe, Auth, Assoc, Data etc..) and will send to the AP. I 
> thought allowing a zero MAC address station is not a valid. so validated 
> the given MAC address. Just for curious, which case all zero address is 
> a valid MAC.

Well, it isn't really, but the OUI 00:00:00 *is* in fact assigned (or
was), and theoretically the vendor could assign it to a device.

We do assume basically everywhere that it's invalid though.

Was just wondering how you came across this really, I guess I'll add a
bit of text to the commit log and merge it.

johannes

