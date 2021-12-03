Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13854676B4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 12:48:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351894AbhLCLvd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 06:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbhLCLvb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 06:51:31 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5133C06173E
        for <linux-wireless@vger.kernel.org>; Fri,  3 Dec 2021 03:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Sz0zm1BKd38cDUh3PVnXGcZZKthFxNcwvpMn4XVmj/Q=;
        t=1638532087; x=1639741687; b=Tg/6rV/SZNyHnjJ/8WFKE7qUQ7lGt2GV2NvNifMGRAJcrSY
        WgNlmMC8ObRaAW+SY7Q7hemYURswM74uDUPS1Cejbr5LXD+zg9o6vDp6sgXo9Td4UhOX7tUA8JNl7
        g8qVKaO7G5xRBEAd515iEeWRymPl7+xERqFMq4i0Us9XSqet6GXbaph7vh3GbJkVPxg1+XH7jhpBe
        MebWsPR6d6t4HztkhmVLELUh9FVgrgiRZCNc5lpilqTjYp0F6FRv0SKN4nGCawDuRxGmAbItlJ20l
        G3N2fv6c2U44Ag6mzE+Hosrm5UaEkwL1lq9qDokKcHphqRbPazq0GFUDiqK256Iw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mt72r-006M6O-6a;
        Fri, 03 Dec 2021 12:48:05 +0100
Message-ID: <a59667158ce8499ae2d256dfcd34f20fe1307bdd.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: disable BSS color collision detection in case
 of no free colors
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Date:   Fri, 03 Dec 2021 12:48:04 +0100
In-Reply-To: <DM6PR02MB49375D43B73E14EC6B0E5754E96A9@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1638506507-21139-1-git-send-email-quic_ramess@quicinc.com>
         <3a4fc4398a5dfe03933de8d695a8b605d700a94b.camel@sipsolutions.net>
         <DM6PR02MB49375D43B73E14EC6B0E5754E96A9@DM6PR02MB4937.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2021-12-03 at 11:42 +0000, Rameshkumar Sundaram (QUIC) wrote:
> > > 
> > 
> > I'm not sure I like this mechanism - in ieee80211_start_ap() we
> > explicitly take
> > it from the parameters given via nl80211, so it feels the same
> > should be true
> > here. Why isn't it done that way?
> 
> This is because in this case only beacon will change and in
> nl80211_set_beacon()
> we don’t parse NL80211_ATTR_HE_BSS_COLOR attribute or do
> nl80211_calculate_ap_params()
> 

Yeah but we could change that? Why not?

johannes
