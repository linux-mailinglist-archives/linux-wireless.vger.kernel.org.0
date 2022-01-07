Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BF487D26
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 20:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbiAGTfi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 14:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbiAGTfh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 14:35:37 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2A6C061574
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 11:35:37 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c71so14422432edf.6
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jan 2022 11:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=2PlKBmrcGuttnngbVWhKW0ZiQiBgEud1NQ6Y2MY3Cx8=;
        b=ZEDPBBx6+S3Qhe5QwONiBwNVEyLfHDwVydjvr8cVobB1aTMYL2Hu/a4NzPzepQ34Ig
         DGhynXq6RYuW82x93QZfei4xGpRjCUOs3kjqibxaRh1jF2DxaTBUIKyeJakGTV9pgs2e
         T+YwB26YPu+/joFSIJl4YaQ3K+YY66opB91WAz+qhNfjCVunokqqlrAsKZuy0YY1FsrV
         2mRgGaXZ/iYS3WpMpDz1Flh2rg7npONe7ip2I18YTQK9+z4tntpgLtD4uwIbk8MrhWWb
         96RvspxLioUlgSe+mkM7FCLf6D7X/XFhpdccjRPpskXpUuF7JOACauyOzk4Oy3vzEJj2
         2bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=2PlKBmrcGuttnngbVWhKW0ZiQiBgEud1NQ6Y2MY3Cx8=;
        b=hivI0kQB7t0Prv06na5lj1kK3T4v67Kf4FqXm6N4R6bUyXnLBYzhxTdv1TNx8qZhBV
         CxBSSguTfIvrUUL922+QAykwwdQDZFGMp01BgoD2ljbbEbAaHiKuOv/ZLzx15NsAwQoq
         5w/mEhpMihqmWsOdCSTrci/uINuncVosr4PXgctj5uRI4UyY5I4UazpD6E0WQ/QzKZPk
         Uod7OAjvtBjAGh6qj+QIV5SDRfgRkMCS8y05uZBwBn0tR93cdqQ0oOgwbz6YmCfEKOrY
         Tc+5/ftDyOHSKR1DSjQ1vu9/HQd/cmRUNDlPDd0YThTjqjMBgjepG8hqhnAyT83+I1Bx
         yz5Q==
X-Gm-Message-State: AOAM532LJ9m0QUtLn3sdS/dNibUPVOv4ZIOp4honZboRJDpV1EQgiRCF
        bWCwvw+v14cwGHBG/w37csgs5NGJruU=
X-Google-Smtp-Source: ABdhPJzxrgH+Dk9HK93FpBXjuPu/P4i53JFzJKjpJBnJHCPwXR7p0hcheQn4progI4wbnrbBodUjyw==
X-Received: by 2002:a17:907:1702:: with SMTP id le2mr331136ejc.603.1641584135769;
        Fri, 07 Jan 2022 11:35:35 -0800 (PST)
Received: from [192.168.254.53] ([50.45.187.22])
        by smtp.gmail.com with ESMTPSA id qk11sm779756ejc.110.2022.01.07.11.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:35:35 -0800 (PST)
Message-ID: <58ebff51d64d1ae6b01d85cff7bb9e137e19848a.camel@gmail.com>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   James Prestwood <prestwoj@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 07 Jan 2022 11:35:32 -0800
In-Reply-To: <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
         <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
         <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
         <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-01-06 at 23:01 +0100, Johannes Berg wrote:
> Hi Preston,
> 
> Ugh, sorry. I'm way behind on a whole bunch of emails (about 4 dozen
> to
> be honest) ... trying to catch up, but only so many hours a day.

No worries, thanks for getting to it :)

> 
> > So the use case here is to become provisioned with DPP, or discover
> > another P2P device. For example, you buy a light bulb, plug it in,
> > and
> > want to provision it. Going on channel for small amounts of time
> > can
> > only be detremental to the user experience since you are bound to
> > miss
> > these discovery type frames and delay the provisioning.
> 
> Right.
> 
> > As far as power goes, for at least the above use case, there really
> > isn't an argument. And its a stretch to find a use case of sitting
> > idle
> > as something that anyone wants to do at least for an unprovisioned
> > device that is looking to be configured.
> 
> Fair point.
> 
> > Would there even be a noticable difference in power usage between
> > the
> > two scenarios?
> > 
> >  - Sitting offchannel for 2 minutes
> >  - Issuing REMAIN_ON_CHANNEL repeatedly for 2 minutes
> 
> Probably not :)
> 
> > As far as cancelling CMD_SET_CHANNEL I totally agree. If a device
> > wants
> > to go idle for whatever reason that should definitely be possible.
> > I
> > think a timer could be avoided using SOCKET_OWNER. So if userspace
> > really 'forgets' (crashes or what have you) the device could still
> > be
> > brought to idle if that socket closes.
> 
> Oh, yeah, good point.
> 
> 
> However, looking at something like e.g. iwlwifi, there's no way to
> actually implement what you want, you can't, without a time event
> like
> one created by remain-on-channel, actually just "sit" on a channel.
> 
> So chances are that, even if we implement the API you'd like, it'd
> end
> up being optional and you'd have to support remain-on-channel usage
> like
> before, even for common devices like iwlwifi. (*)

Yes this is inevitable. But this method is really hit or miss honestly.
Each driver arbitrarily chooses its own duration, some as low as 500ms.
My specific iwlwifi card routinely locks up my entire system requring a
hard reboot when I repeatedly issue ROC OR will randomly not send the
ROC event (which I reported on the ML). But I digress.

> 
> At which point it's probably not really worth it? Emulating it in the
> driver by repeatedly issuing time events also seems like a bad idea,
> worse even than doing it in the application, since the application
> could
> at least try to synchronise it a bit with whatever it needs to be
> doing,
> whereas the driver can't do that at all.

If this is the case then sure, its just offloading the same nasty
procedure into the driver/FW. You know more than me about this topic
but I'm still trying to understand how this would differ much from AP
mode?

In my own mind I see SET_CHANNEL doing the same thing as START_AP, just
without sending out beacons/probes and the iftype being station. Maybe
this is an oversimplifation but it seems like the FW/driver *can* sit
on channel without some time constraint if it supports AP mode.

Thanks,
James

> 
> 
> (*) and I'm not even sure we can do anything else from a firmware
> perspective, or at least it'd probably be a complicated fw change
> 
> johannes


