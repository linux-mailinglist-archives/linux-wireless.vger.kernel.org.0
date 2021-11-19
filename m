Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F40456BB1
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 09:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbhKSIew (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 03:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhKSIev (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 03:34:51 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8802EC061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 00:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=s/szsktVZIkmXcxmmuot84sy9JZdEWq/1m0i5Lod250=;
        t=1637310710; x=1638520310; b=WguTdVSRZe2MH2LU3BeUHWJZKnDDZneCcCmGT0A4JBXWf4f
        pxE+aip4jy7XUl17VDhcvTwBz4cKXvbxeffp1blAc1Ag5I+KHbyeTYJMKqiymFwWShn5QNPZzbmsk
        m+cnxunCkB5fu9tJbVOWBlc9a5yjRGVG1ajrdYeFMxn4mMpkrKHZ497UhS6W+MC26uNO5JrHwImXY
        X29huRQWXR38NtXE4BN1K3LfXbkZSu+S4+6UqtM0VXQ/7jzKqJ7EyA2HrTvJjr3vp1mCgsgdYYd94
        t15egrhZ92orS7EVAlE6Aw/I/apeREBZkKv9VTKHFibS/+IgEAmvY0nnl6/L84GQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mnzJD-00HNEm-Pz;
        Fri, 19 Nov 2021 09:31:47 +0100
Message-ID: <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 09:31:47 +0100
In-Reply-To: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-11-18 at 16:11 -0800, James Prestwood wrote:
> Hi,
> 
> I see CMD_SET_CHANNEL is only supported for AP-type iftypes (AP,
> P2P_GO, etc). While this definitely makes sense in most cases,
> protocols like p2p/dpp require going off channel for an undetermined
> amount of time.
> 
> I could go into the exact scenarios but in short your REMAIN_ON_CHANNEL
> could end at very inconvenient times.
> 
> Specifically when a station is not associated to any AP is there any
> harm in allowing CMD_SET_CHANNEL? Is this purely a software limitation
> or do drivers not allow this?
> 
> If this sounds reasonable (and possible)

I don't think this *works* because you don't have a way to say "I want
to now go back to idle". And sitting on a channel arbitrarily can
consume quite a bit of power.

So you'd have to add an API to cancel it again, but then realistically
we'd probably want to be able to cancel it if userspace forgets (ie.
give it a timeout), at which point it's basically equivalent to a
longer-than-you-needed remain-on-channel that you cancel after you're
done?

johannes
