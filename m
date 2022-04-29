Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC925144E3
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 10:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356024AbiD2I6m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 04:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236950AbiD2I6l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 04:58:41 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723B97E599
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 01:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lInfDLQPDNvmiNjSt4dCXhInvmMvf1Gg9CeU6xoqgGI=;
        t=1651222523; x=1652432123; b=o2f3W2vEXy9h0+ATxEKuqrDkgWETOqiO1H9Nnhk454Nmve5
        jWszAEp0A28EoxKQrcZ92ib9Mgr1PMIitZ2BYCY2836nkVHFFNKHT6a+2gqJC7S6BuBoFep3/iVkk
        yX9DTWHti+x3lM83F2W45vVls8PbaaKnCrtbhuG8CZdlV7Jb/N1YoFYNIyggjbnydCGBtNNJIpycE
        8YF1kcBXxUG/XAYfB/zDwWbmd2A9lD8uUZ2YlMvD/cFLFSHtvW28XxO3DUgot2L4ETHIoDZMiNtCD
        HVSaMtJJaq4nFgRZstAghvGaCcFHkoFaXPGO4KL79O69hL5svtwnmshJxDKNGGiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nkMPH-00Gs4E-2m;
        Fri, 29 Apr 2022 10:55:19 +0200
Message-ID: <93af93c7f3b9454fd733ba8f3466fb5d01d629b2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] cfg80211: do some rework towards MLO link APIs
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jouni Malinen <j@w1.fi>
Cc:     Vasanthakumar Thiagarajan <quic_vthiagar@quicinc.com>,
        linux-wireless@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:55:17 +0200
In-Reply-To: <20220428170729.GA13599@w1.fi>
References: <20220414145522.116716-1-johannes@sipsolutions.net>
         <f137ca7f-8b59-3368-c666-247f83d80383@quicinc.com>
         <6b40798e349d11e495a6df20ecba479a8357dad2.camel@sipsolutions.net>
         <ff39ff9b6b1a6619ab30118e8a76b43ad2b9a715.camel@sipsolutions.net>
         <20220428170729.GA13599@w1.fi>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2022-04-28 at 20:07 +0300, Jouni Malinen wrote:
> There are use cases where over-the-air Link ID is used and other cases
> where it is more appropriate to identify the local link based on the
> band (or subband, etc.) in a manner that is valid over one or multiple
> associations.

Do you have an example for the latter? I haven't really come up with one
yet.

> It might actually make more sense to come up with two
> nl80211 attributes for identifying a link based on either the
> over-the-air Link ID (which is valid only during an association and can
> change whenever roaming occurs) or the internal identifier for a link.

That makes a lot of sense.

> This would allow nl80211 commands to use only one of the possible ways
> of identifying link so that user space components would not need to know
> or care about the mapping and would just use the variant that is easier
> for the particular case. 
> 

Right. Though in many cases that would have to get pushed down to the
driver, and that'd mean drivers have to be aware of all those possible
ways too? I'm not sure cfg80211 always has enough information to resolve
to one particular way of identifying, especially with roaming offload
etc. where you might actually need to push some identifying attribute
like the BSSID down to firmware?

Anyway, I guess that means we can put the link ID into a small struct or
something for the APIs, so we can extend it more easily later.

I'm not sure I can reasonably come up with all the possible ways to do
this in the initial work here. In fact, I'm wondering if I shouldn't
just focus on client with AUTH/ASSOC (not CONNECT) and AP for now, so we
can get something started...

> For nl80211 event messages, both attributes
> could be included since the driver and/or cfg80211 would know the
> mapping and could fill in both options so that the user space components
> would not need to be aware of the full mapping.

Assuming we have all the data, yes.

> In addition, there seems to still be some open discussion on how various
> Management frames are targeting specific links and that might even
> result in there being a protocol mechanism for targeting a subset of the
> available links, i.e., not all of MLD but one or more links. I'm not
> sure whether this would need anything particular in nl80211 since we
> could always send multiple copies of the command/event (one per link),
> but it might also be convenient to be able to use an array of the
> over-the-air and/or internal identifiers for the links.

Indeed. I'm not sure using multiple commands would be OK since in the
case of multiple, it might require them having the same seqno just like
multicast data frames? But I'm not sure what the spec is doing here now
:)

johannes
