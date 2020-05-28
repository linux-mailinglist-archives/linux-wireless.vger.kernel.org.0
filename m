Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013781E69DC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 20:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406067AbgE1S6S (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 14:58:18 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40745 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406064AbgE1S6Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 14:58:16 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1D6B8B6B;
        Thu, 28 May 2020 14:58:15 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 28 May 2020 14:58:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=/i831MEK28rD0RNoTzVF9b3Ku6pEQpH
        Zzp6bEOgI2Bc=; b=R3HTdCum/nzg0+lE0Q73gt3OBVCvo9jAaH+okALlsy8XLrQ
        s1FXAsZjCcD5TIAOWEMHIRRqjq76TvtrxCSgvTpVfEMBuAy51iYzCuhm1J1Nq0Ku
        Rd2dqtOHh4yoyq4HFaJhaiDeTi+BlmMq4jLnaZeZsMK4uxwqbU2QgrJDJW025JyN
        5dXtIf8y+Og1nwq6V9UcNNsIRq9G370XrnvtTs4zGkuQakryoZs1IWRcJzjH9y99
        FA8fFcWBkAaV78NkzS6LBG8q6lKa0gtdwH85Ub5O+Ika8qVlWTgSVaSpGh4VKImz
        Jbrcgj4/tvGss8FlaEAHw0KuwmeXzdKGR0Cdjkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/i831M
        EK28rD0RNoTzVF9b3Ku6pEQpHZzp6bEOgI2Bc=; b=FrMmL4nmKQ363guO4Buy71
        02uJNfiBcDiBsx29hczPKEPTPeln5Xh9NAMO72foUHcxyz1aGasZJ8m8+Tyjfi51
        GNE5JunkWn+rJmI4z+nrhd2Ti70cxgdtxD/5Zx/RTqmWaaE9m3Qbxrkur5oklasO
        8j5rjWH/EqJUrmeAn05BYwQ+yz1OL1P4de0xmyFbGHQdENyGglfKwpVr1IJcZACg
        3oVg2hwiX++MgJy0yim38KxwGAE8zGsIsmObFAZbPtieW34TPm9KdqJE+liuQVzs
        HrisDHI/QHjdzArNotSKWHmCPzAXIbeG/HNRx+5pvjz4EGE/3q+g3qHr4cOkxSWw
        ==
X-ME-Sender: <xms:xgnQXtGVTMT0yYRwcG2ZFMg_INfb4_XDZYzVELiEz9CLppFnXoX7-Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddviedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdeurhhu
    nhhoucffrghnthgrshdfuceofihirhgvlhgvshhssegurghnthgrshdrrghirhhpohhsth
    drnhgvtheqnecuggftrfgrthhtvghrnhepteeukeejvefhgefgvdegfeevfffhleetfeff
    tdduueehudeufeefjedvveegjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfihirhgvlhgvshhssegurghnthgrshdrrghirhhpohhsthdr
    nhgvth
X-ME-Proxy: <xmx:xgnQXiWs1wXVvx8aIbsyhXbfXIOrT9-XuTYrXt-vWYN43sxU0ZXUBQ>
    <xmx:xgnQXvLh-QB_aWI-I6T5I1UQ573Bx2Y2HibCF3Z6jdQ_TznHc6PNBw>
    <xmx:xgnQXjEMYFcqJj8RRyZ6-GkaqgjAeiAzqGA8xmngY80pUvbh4G4y3g>
    <xmx:xgnQXriJceGKp2_OI423KmOufEerESQlH7ttgWW5nzJvmIogubAdJQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 574C6E00BF; Thu, 28 May 2020 14:58:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-504-g204cd6f-fm-20200527.002-g204cd6f2
Mime-Version: 1.0
Message-Id: <f78191c6-3093-4d97-a959-068dce1da552@www.fastmail.com>
In-Reply-To: <7406af4a9e852d99735e1b1af63deed2f0c5d703.camel@sipsolutions.net>
References: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
 <(sfid-20200528_174911_413757_32DBA783)>
 <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
 <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
 <7406af4a9e852d99735e1b1af63deed2f0c5d703.camel@sipsolutions.net>
Date:   Thu, 28 May 2020 14:57:54 -0400
From:   "Bruno Dantas" <wireless@dantas.airpost.net>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: iwlist scanning: how to exclude old scan results from output?
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Does it go away if you wait long enough for the "last seen" to go above
> 30 seconds (30000ms)? You should use "iw wlan0 scan dump" (no need for
> sudo, and don't scan again) to check.
> 
> Because if not, then there's a bug in the references, and the entry is
> just being kept alive by ... something. Did you previously connect to
> it? Does it also happen if you never connect? Then I guess we'll need to
> know what the kernel version is too. :)

Yes, it goes way if I wait 30 seconds. Whether I had connected to the hotspot or not makes no difference. Kernel version is 5.4.3.

I thought discovering *currently-available* hotspots would be a common need. I'm a bit surprised that getting this information is tricky.

Like I said, reloading the wireless interface's kernel module does the trick. I was just hoping that there'd be a more elegant solution. Thanks for the help, anyway.

