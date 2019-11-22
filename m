Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 738E0107256
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfKVMpU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 07:45:20 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:44926 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfKVMpU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 07:45:20 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iY8JK-0003R9-DV; Fri, 22 Nov 2019 13:45:18 +0100
Message-ID: <71e7fef40c048be83c92c60fbf4166ec41a6a018.camel@sipsolutions.net>
Subject: Re: [EXT] Re: [PATCH v2 0/2] add Wide Band Scan support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sathishkumar Muruganandam <murugana@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Fri, 22 Nov 2019 13:45:17 +0100
In-Reply-To: <2354c9e9f86b2207d6828b45e4055191@codeaurora.org>
References: <1572869374-9635-1-git-send-email-murugana@codeaurora.org>
         <53d45563803b3f96be0d53731408cc3af028c510.camel@sipsolutions.net>
         <00d301d593c2$bd37d8f0$37a78ad0$@codeaurora.org>
         <867302d58d3183ce7e2c7afa846027a787579b87.camel@sipsolutions.net>
         <6ea305b2ac09c340181623a23cf4180b@codeaurora.org>
         <aa0257b408dc7ad6d5f457ac611e76059549737b.camel@sipsolutions.net>
         <2354c9e9f86b2207d6828b45e4055191@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2019-11-14 at 18:03 +0530, Sathishkumar Muruganandam wrote:
> On 2019-11-14 12:08, Johannes Berg wrote:
> > On Mon, 2019-11-11 at 13:27 +0530, Sathishkumar Muruganandam wrote:
> > > > How is this related to scanning? It sounds to me like you're just
> > > > (ab)using scan as a somewhat convenient "do some channel hopping" API
> > > > ...
> > > > 
> > > 
> > > Whether this can be used under "iw offchannel" with
> > > NL80211_CMD_REMAIN_ON_CHANNEL?
> > 
> > Are you asking if I would accept wide
> > channel extensions to R-O-C?
> 
> Yes, adding bandwidth config to existing command.
> 
> Something like this,
> 
> iw offchannel <freq> [HT40+|HT40-|80MHz] <duration>
> 
> > Still I guess I'd like to see an actual reason for it.
> 
> Wide band scan is actually moving to a off-channel for a
> specified duration to capture 40, 80Mhz data frames.
> 
> So, I hope offchannel would accommodate this extension.

That certainly makes more sense to me than scan, but it'd *still* be
good to come up with use cases for supporting it and have that in the
commit details.

johannes

