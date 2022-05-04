Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C75B4519E76
	for <lists+linux-wireless@lfdr.de>; Wed,  4 May 2022 13:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239632AbiEDLvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 May 2022 07:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbiEDLvU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 May 2022 07:51:20 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9453E5F91
        for <linux-wireless@vger.kernel.org>; Wed,  4 May 2022 04:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=/YhHlU416mXxVS2uu0nKAKDOzg4gDRQYAT19TdBjKa4=;
        t=1651664864; x=1652874464; b=LueaqP8Q/NxvMyv5kmnHWPdYpCkJRTmCv/g0qQcUNsR5NYp
        iDH5gqxBd1qjAOJLUNt00iz99K5GVflJUqh2pZq7+HjD9W/w2zeynwTauIz158bM4SnqvaUr5yq7h
        L+4vrD/fdW7jw8eqrHa1VXwb2tebi1LEKbOTe66h3iPQXb5CES8mHNvKbv+ZMrS+c8BtoCjsP4hD7
        52Hk0gpwLZ/YbnQy6wBBc5rXtNeF1yIcpS/8FvYv06tvBsPAJ0ZSP75TYhka7BACVTEwZYy6WRnBp
        KbgCbRYAmpzGMhAjsQQEFNp0SUUL9WUg1ysKAa/ASBHCkrVL7f5oOE+rj8qpuJ2Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nmDTq-0021OS-Rr;
        Wed, 04 May 2022 13:47:42 +0200
Message-ID: <7b53ed63ab1d50c9c7d7dd3e8597050c9e233944.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] mac80211: add support to configure 6GHz non-ht
 duplicate transmission
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Rameshkumar Sundaram (QUIC)" <quic_ramess@quicinc.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
Date:   Wed, 04 May 2022 13:47:42 +0200
In-Reply-To: <DM6PR02MB49379E377E3E7940540DF587E9F09@DM6PR02MB4937.namprd02.prod.outlook.com>
References: <1644914581-21682-1-git-send-email-quic_ramess@quicinc.com>
         <1644914581-21682-2-git-send-email-quic_ramess@quicinc.com>
         <a517835c51a5eaf00e87fdaaef47546f70ff0d42.camel@sipsolutions.net>
         <DM6PR02MB4937C53041172E9A52846A0BE9169@DM6PR02MB4937.namprd02.prod.outlook.com>
         <a537c6e02afbfa26eec2a54dbd8bc649f77ae3a3.camel@sipsolutions.net>
         <DM6PR02MB493734ADBBC6C996845B9EF3E9179@DM6PR02MB4937.namprd02.prod.outlook.com>
         <babc75d310031f9f92736d5da65679ca50542849.camel@sipsolutions.net>
         <DM6PR02MB49379E377E3E7940540DF587E9F09@DM6PR02MB4937.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, 2022-04-17 at 14:30 +0000, Rameshkumar Sundaram (QUIC) wrote:
> > 
> > Well, I was thinking it would reasonably come with the beacon rate,
> > i.e.
> > as a new attribute like NL80211_TXRATE_DUP?
> Sorry not getting this, you mean hostapd would need to send new set of
> rates for this configuration ?
> The expectation is that user-space will set this bit in HE oper IE
> only if legacy rates are present in beacon or basic rates.
> 

?

I don't understand.

The point is - you're setting the bit in the beacon that indicates "I'm
transmitting it as duplicate", right?

But you're also using that bit to actually configure it to do (non-HT)
duplicate transmissions.

But fundamentally, those two things aren't really related, are they? Why
shouldn't you be - at least theoretically - be able to configure it for
duplicate transmission (or not) regardless of the bit in the beacon?

To me it seems "do duplicate transmission" is a property of the *rate*
you want to use to transmit, not really necessarily a property of the
*content* of the frame you're transmitting.

johannes
