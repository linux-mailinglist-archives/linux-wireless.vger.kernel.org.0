Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22CFB47A6A
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 09:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbfFQHG4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 03:06:56 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:33758 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfFQHG4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 03:06:56 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hcljA-0000UW-Sh; Mon, 17 Jun 2019 09:06:53 +0200
Message-ID: <e13d86030df7a5222ee144d85bbeec400ed8fa07.camel@sipsolutions.net>
Subject: Re: [PATCH v3] {nl,mac}80211: allow 4addr AP operation on crypto
 controlled devices
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stefan Lippers-Hollmann <s.l-h@gmx.de>
Cc:     Tom Psyborg <pozega.tomislav@gmail.com>,
        Manikanta Pubbisetty <mpubbise@codeaurora.org>,
        linux-wireless@vger.kernel.org
Date:   Mon, 17 Jun 2019 09:06:51 +0200
In-Reply-To: <20190617070747.562b9388@mir> (sfid-20190617_070759_741392_4A382985)
References: <1557307533-5795-1-git-send-email-mpubbise@codeaurora.org>
         <fd3addc01fc3f5362dba5771ee82659cf01c195b.camel@sipsolutions.net>
         <c8484254-f4f7-9955-e3f8-8a423cc6c325@codeaurora.org>
         <CAKR_QV+dVx+LK1HyCo6CQZQ7ZX_u6ON0hEH5adNiJTB+XaP3WA@mail.gmail.com>
         <dc9039be42df8d241b14d4f673f3c472dc113991.camel@sipsolutions.net>
         <20190617070747.562b9388@mir> (sfid-20190617_070759_741392_4A382985)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-06-17 at 07:07 +0200, Stefan Lippers-Hollmann wrote:
> Hi
> 
> On 2019-06-12, Johannes Berg wrote:
> > On Thu, 2019-06-06 at 20:41 +0200, Tom Psyborg wrote:
> > > 
> > > Applying this patch instead of v1 broke WDS operation between two
> > > Litebeam AC Gen2 devices:
> > 
> > I'm confused, and not even sure which version I applied now.
> > 
> > Manikanta, can you please check this and which version I have and which
> > changes I might need?
> 
> I've tested (and left it running/ monitored) for two days without
> any problems between QCA9984 (ZyXEL nbg6817/ ipq8065, WDS-AP, affected
> before 33d915d9e8ce811d8958915ccd18d71a66c7c495 "{nl,mac}80211: allow
> 4addr AP operation on crypto controlled devices" went in) and AR9340
> (TP-Link TL-WDR3600/ AR9344, WDS-Client, not affected by this issue),
> both under current (~2 days old) OpenWrt master[1] (ipq806x/ ath79,
> respectively). This patch is working fine and fixes the previous
> problems with 4addr on ath10k (QCA9984).

"This patch" is v3 then, presumably? I just checked, and it looks like I
indeed applied v3.

So basically you're saying it works as affected, since you were
previously affected by the unavailability of 4addr interfaces on ath10k
hardware, which are now available, right?

Tom, I notice you're using a very old base kernel ("backports-4.19.32-
1") - are you sure you were even able to apply this patch correctly?

johannes

