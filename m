Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7262B486D02
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jan 2022 23:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244683AbiAFWBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Jan 2022 17:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244436AbiAFWBI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Jan 2022 17:01:08 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B70C061245
        for <linux-wireless@vger.kernel.org>; Thu,  6 Jan 2022 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/u4upP35T+RKCq1mwFX/UA9HvlsCqpYBdd3MaTVWEGo=;
        t=1641506468; x=1642716068; b=Oce5CGb+b3djp3UUnqa33+02/l6pFeLT+bHRiA1GQ5s8cKW
        llFKFRLNoP3GNylmyIafceWLKL8KYGvdDD2nMW6Tu8m/P6+wabuNjbxi+aMQ6l5qkk0veogWuT3Xn
        w00m9s0b7AQ/ARFc8JQnqcSyXYWw3JQ62H+xyBn3RnH3NaCDAHR3tNIock8GRldmL3tyktIdP8R70
        z8GOr0S0ZxAf0rUmCDk6CRfkHTAfL/dojElc/JBxndCFwyZqlz9Vr/nLjwGGfjTS2jva1/T3pje4m
        Xn5tny6vBaYnG88hfGuKeMPZ+8Oj8HU5hNr72nFV+XSKyr3BM/mtR7LP/iInWHXA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1n5aok-002gGi-5r;
        Thu, 06 Jan 2022 23:01:06 +0100
Message-ID: <d8250f97a2be736736374974095f219d858acb1e.camel@sipsolutions.net>
Subject: Re: Adding CMD_SET_CHANNEL for station iftypes
From:   Johannes Berg <johannes@sipsolutions.net>
To:     James Prestwood <prestwoj@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 06 Jan 2022 23:01:05 +0100
In-Reply-To: <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
References: <2b18f86924c3d64437aa139f6401ee2e7705eeb0.camel@gmail.com>
         <47ba74aa23a5c4fb42660d5b40e974c24acf24bf.camel@sipsolutions.net>
         <91d38c40a62100dc6355c98e85b8b793ed8890df.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Preston,

Ugh, sorry. I'm way behind on a whole bunch of emails (about 4 dozen to
be honest) ... trying to catch up, but only so many hours a day.

> So the use case here is to become provisioned with DPP, or discover
> another P2P device. For example, you buy a light bulb, plug it in, and
> want to provision it. Going on channel for small amounts of time can
> only be detremental to the user experience since you are bound to miss
> these discovery type frames and delay the provisioning.

Right.

> As far as power goes, for at least the above use case, there really
> isn't an argument. And its a stretch to find a use case of sitting idle
> as something that anyone wants to do at least for an unprovisioned
> device that is looking to be configured.

Fair point.

> Would there even be a noticable difference in power usage between the
> two scenarios?
> 
>  - Sitting offchannel for 2 minutes
>  - Issuing REMAIN_ON_CHANNEL repeatedly for 2 minutes

Probably not :)

> As far as cancelling CMD_SET_CHANNEL I totally agree. If a device wants
> to go idle for whatever reason that should definitely be possible. I
> think a timer could be avoided using SOCKET_OWNER. So if userspace
> really 'forgets' (crashes or what have you) the device could still be
> brought to idle if that socket closes.

Oh, yeah, good point.


However, looking at something like e.g. iwlwifi, there's no way to
actually implement what you want, you can't, without a time event like
one created by remain-on-channel, actually just "sit" on a channel.

So chances are that, even if we implement the API you'd like, it'd end
up being optional and you'd have to support remain-on-channel usage like
before, even for common devices like iwlwifi. (*)

At which point it's probably not really worth it? Emulating it in the
driver by repeatedly issuing time events also seems like a bad idea,
worse even than doing it in the application, since the application could
at least try to synchronise it a bit with whatever it needs to be doing,
whereas the driver can't do that at all.


(*) and I'm not even sure we can do anything else from a firmware
perspective, or at least it'd probably be a complicated fw change

johannes
