Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C252C1E67BC
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 18:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405208AbgE1QtB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 12:49:01 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:49673 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405159AbgE1Qs7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 12:48:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 07EFDBE1;
        Thu, 28 May 2020 12:48:58 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute3.internal (MEProxy); Thu, 28 May 2020 12:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airpost.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to
        :subject:content-type; s=fm3; bh=MYakJBv3Mk+QdVSuGJgM1XQzJ06UsXb
        do+4aXFHiC54=; b=Ikl//HId4yQzIDkyFpFM0dSipob8qD47xxp79OgH1x0nxs0
        IdP7mRX9/UA34u5xmI7Nu1OZo+0uF3h1BP1+ZjBrRXye6NtRThrXwHHv3vNd1N50
        rAq9lbxGg+FG8bp7ecpmV9jyQ+p32c5v4rt16pHFNqesP1gbDUoYQ/UsnWnxHEpl
        XY3DKEXzk28tOsv47KYyFos3dI1kFpfLeBe03DmcvzDudKyq8sZxJQghvBcSK5IA
        bQ0EYIt7UGya9npKZ720yU5D31EDFCD2PCi/FXMLL9A1M4iMU+LreiPIsB73ahwC
        JV5LGkoG2HfEDrlTWPu5iC+0CJ3JYquwBxkjiVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=MYakJB
        v3Mk+QdVSuGJgM1XQzJ06UsXbdo+4aXFHiC54=; b=Mzkk2OwjKNh4tOflxGYF8N
        sRMqPqwPUfWIEKzUwBA6kFGFKbedWn70N+IWxLny//+sDnTJXVTVpVcJyJHpDO+j
        oDSO33g1d3DISbUfmu+mkOOVaTSOAujqiLjcOWl8ixrlKV2VAqzXQRxy30Kw4uRM
        LQnEILIyAdWBibRRfIAAQN1VQ10AKUR7FceQ69S9j4dHuCKKCzvuLY0tbDjLtJ8n
        cZE+FWXmNqG7tV9+dRC6syzmBiuJkj7NYr2e7MTJ/Ou1WaGVkwBk2DJXaWXtxRo+
        1DbX2Kh3FuGjBGfl+f8Cm/jVe/NlcJ3FYdp2f2Ov90AmSLYgaCvYIJ66Aznpozfw
        ==
X-ME-Sender: <xms:euvPXjuJlfwQKSZv3kPHLmqeATYcKQ58ez_2pLVx1lz8XynYKXALqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedruddviedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdeurhhu
    nhhoucffrghnthgrshdfuceofihirhgvlhgvshhssegurghnthgrshdrrghirhhpohhsth
    drnhgvtheqnecuggftrfgrthhtvghrnhepteeukeejvefhgefgvdegfeevfffhleetfeff
    tdduueehudeufeefjedvveegjeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepfihirhgvlhgvshhssegurghnthgrshdrrghirhhpohhsthdr
    nhgvth
X-ME-Proxy: <xmx:euvPXkeMUNmUnNfOE-leWHCVdNs0HgS9ojXT9hgNce1LWBtdxLmyBw>
    <xmx:euvPXmzcJ8AmSCFWY_1--MNG7OHiOXUP_DLR_5bkD8hUXRDW6Blb0g>
    <xmx:euvPXiNOdcGklSi8o8vaMOQfvUqkq4MIyZgQdGxNQnrcmepvTPkVOw>
    <xmx:euvPXmLAWXaDk55vp3XgdW-zm65BAyANojaCxOg43_9L9N38HDrw_w>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5C841E00A9; Thu, 28 May 2020 12:48:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-dev0-504-g204cd6f-fm-20200527.002-g204cd6f2
Mime-Version: 1.0
Message-Id: <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
In-Reply-To: <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
References: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
 <(sfid-20200528_174911_413757_32DBA783)>
 <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
Date:   Thu, 28 May 2020 12:48:26 -0400
From:   "Bruno Dantas" <wireless@dantas.airpost.net>
To:     "Johannes Berg" <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: iwlist scanning: how to exclude old scan results from output?
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> You should use 'iw' instead of 'iwlist', which does have options for
> flushing the cache.

Thank you, Johannes.

I tried  iw  but it has the same issue (the "AndroidAP-bd" SSID is non-existent because my phone is physically turned off, but it shows up in the output):

$ sudo iw dev wlan0 scan flush
...
	TSF: 42037885 usec (0d, 00:00:42)
	freq: 2412
	beacon interval: 100 TUs
	capability: ESS Privacy ShortSlotTime (0x0411)
	signal: -31.00 dBm
	last seen: 11447 ms ago
	Information elements from Probe Response frame:
	SSID: AndroidAP-bd
	Supported rates: 1.0* 2.0* 5.5* 11.0* 18.0 24.0 36.0 54.0 
	DS Parameter set: channel 1
	ERP: <no flags>
	Extended supported rates: 6.0 9.0 12.0 48.0 
	RSN:	 * Version: 1
...

Am I not issuing the appropriate  iw  command?
