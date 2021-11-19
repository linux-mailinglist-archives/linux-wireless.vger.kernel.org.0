Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3107E457612
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 18:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbhKSRvC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 12:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhKSRvC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 12:51:02 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B9B8C061574
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 09:48:00 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id g28so9265769pgg.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Nov 2021 09:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=w3R4jn+JdyCfriDU43U28OD+pROp2EMN2+zPCusor3Y=;
        b=q1eWRcci6etFnPPGScqu02Dj1ArGxTorDZZDZH6odJl28AIujF1OqoTjljdddjynk7
         d3vuljcSjpl0uxUD/p0vHIHOg/KqHCNNC3pjfnYbreI/KLdNGQgKz4S7TXi771Ay+KoB
         s2JmqgpO8sdU8ncG3CyxA5NSscq7t/oONDaAOL84JZH65++QGv49FMDh91W8AnrFjyQo
         Yoe19pE9tu5B6z5G58hC0swbwMu6BSsXZQQeJvvTkh6hraWFK4LARWe/LzIIOrebY98z
         13uOXEO/RDtc+KBR3K/WGZ5DidWdLnBCtq2AWYGvUrfIUFTe2Swu2OR2B9TwanrYIaCq
         4cQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=w3R4jn+JdyCfriDU43U28OD+pROp2EMN2+zPCusor3Y=;
        b=SvHPkoGkZEbwEHt1vlOz9Nh2ei3RXeUghwZ1El7CBMY64AI0USSuzaeuF7Oht9ytL9
         d8Oo2rW0UFnzKiUeoTberJlHsGeO3uND67KxLGLX2U+CROXFLFz4+q+B10OUnSrzGkLC
         bqivw6MSaU3207x0pEdFK7N8xttMIx5uAqf0EFEMcL7F85FOsHIezZbNy4AUngs1UZki
         HmmJ/z9M2fcWESePlBVLmj+w1aT0dEWFsE5KPsnWBpoGYiTq05s+wV86cy7lvLp95NWS
         4lzwQMI5GRNdOm9+/6qMzQxBLAoFKukgAGGcwo7nX/0EFHj9LVb/tdDQDDQuVBVkKtYG
         hOdw==
X-Gm-Message-State: AOAM532K5WQe09NliruatZ+6SZIS3C2vESLcM/AnRoNiq4xpwb65HMXF
        /zngDB1XeGMxEi4ebsEGBSVjkySsGHA=
X-Google-Smtp-Source: ABdhPJwnRub92y/tTZ3QLQ0mFarCsj+DetAMA5g+W1ZMRdAyL2e3xOfVaa0YaWzl8t6g38i7yIwDFg==
X-Received: by 2002:a63:d605:: with SMTP id q5mr18810600pgg.109.1637344080005;
        Fri, 19 Nov 2021 09:48:00 -0800 (PST)
Received: from [192.168.254.58] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id il13sm12635111pjb.52.2021.11.19.09.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 09:47:59 -0800 (PST)
Message-ID: <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 19 Nov 2021 09:43:25 -0800
In-Reply-To: <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
         <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On Fri, 2021-11-19 at 09:31 +0100, Johannes Berg wrote:
> On Thu, 2021-11-18 at 16:11 -0800, James Prestwood wrote:
> > Hi,
> > 
> > I see CMD_SET_CHANNEL is only supported for AP-type iftypes (AP,
> > P2P_GO, etc). While this definitely makes sense in most cases,
> > protocols like p2p/dpp require going off channel for an
> > undetermined
> > amount of time.
> > 
> > I could go into the exact scenarios but in short your
> > REMAIN_ON_CHANNEL
> > could end at very inconvenient times.
> > 
> > Specifically when a station is not associated to any AP is there
> > any
> > harm in allowing CMD_SET_CHANNEL? Is this purely a software
> > limitation
> > or do drivers not allow this?
> > 
> > If this sounds reasonable (and possible)
> 
> I don't think this *works* because you don't have a way to say "I
> want
> to now go back to idle". And sitting on a channel arbitrarily can
> consume quite a bit of power.
> 
> So you'd have to add an API to cancel it again, but then
> realistically
> we'd probably want to be able to cancel it if userspace forgets (ie.
> give it a timeout), at which point it's basically equivalent to a
> longer-than-you-needed remain-on-channel that you cancel after you're
> done?

So the use case here is to become provisioned with DPP, or discover
another P2P device. For example, you buy a light bulb, plug it in, and
want to provision it. Going on channel for small amounts of time can
only be detremental to the user experience since you are bound to miss
these discovery type frames and delay the provisioning.

As far as power goes, for at least the above use case, there really
isn't an argument. And its a stretch to find a use case of sitting idle
as something that anyone wants to do at least for an unprovisioned
device that is looking to be configured.

Would there even be a noticable difference in power usage between the
two scenarios?

 - Sitting offchannel for 2 minutes
 - Issuing REMAIN_ON_CHANNEL repeatedly for 2 minutes

As far as cancelling CMD_SET_CHANNEL I totally agree. If a device wants
to go idle for whatever reason that should definitely be possible. I
think a timer could be avoided using SOCKET_OWNER. So if userspace
really 'forgets' (crashes or what have you) the device could still be
brought to idle if that socket closes.

Thanks,
James


> 
> johannes


