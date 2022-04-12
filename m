Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354F4FCF11
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 07:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiDLFtZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 01:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiDLFtY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 01:49:24 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECBD28E21
        for <linux-wireless@vger.kernel.org>; Mon, 11 Apr 2022 22:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=VACJvKC+ig7X2hKJgeIzf7jrPaefSe0Bku4h73c4t1c=;
        t=1649742426; x=1650952026; b=GJ4avZyH6tSwj7VEBPtcMJjP50VE71l/C6pF4f8uuhHayJ2
        U+k3AlErVKXwnowa3+w/XrjkSiIXEyBdAgtchJTs6nsNYJeKe3d04paPrmG1+A3gQG3M63V9mk0Y/
        Y0KeI/FFzwRTGAWNdrhMKvw/5SCHQy4g35T8QfJ6TMBqV46E74jTbbL+tVKu8qfHXpYOY/2hqHoy+
        il1BW7anG6ksqssXCaBhHcPsfvhRP9wwP8n8QkCFKq3mnyyDdmiuOJoBtpooABspd2o4FstNfDcRh
        hbAQzYHM2YwZjDHIjmmoBH1Seyj4v3DQZOUa2pgZBNSeHGR1LmVglRMpbJJ69ocA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ne9Ml-008lfC-IA;
        Tue, 12 Apr 2022 07:47:03 +0200
Message-ID: <da208535ec78e867f3b1d881cd5784bdaea1b1c2.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: consider Order bit to fill CCMP AAD
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Pkshih <pkshih@realtek.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Tue, 12 Apr 2022 07:47:02 +0200
In-Reply-To: <1170e4f5f399431e88b8304e9b606170@realtek.com>
References: <20220324004816.6202-1-pkshih@realtek.com>
         <e90e6249a7330cd60434d184d358694785e465e7.camel@sipsolutions.net>
         <1170e4f5f399431e88b8304e9b606170@realtek.com>
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

On Tue, 2022-04-12 at 00:37 +0000, Pkshih wrote:
> > 
> > That seems fine, though not sure it's actually _relevant_ - how
> > would we
> > possibly generate such frames in mac80211?
> 
> I suddenly meet this case, because hardware decryption isn't
> configured properly
> during development, so it falls into software decryption. The received
> packets
> can possibly contain HTC.

Haha, right. I'm an idiot I guess, why did I not think of RX?

> After I fix my driver, I don't need this, but I think it is worth to
> have
> this patch.

OK. But I guess that means no hurry.
> > 
> > Oh, I see - again you're worried about IEEE80211_HT_CTL_LEN I guess?
> > 
> > Maybe just subtract that again?
> 
> Yes, we can subtract length from ieee80211_hdrlen().
> But, this function is called in data path that means every packet can
> use it.
> Is it reasonable to += IEEE80211_HT_CTL_LEN in ieee80211_hdrlen() and
> -= IEEE80211_HT_CTL_LEN right after leaving ieee80211_hdrlen() if the
> packet is
> ieee80211_has_order()?

Yeah, thinking about that, I guess you're right. Maybe we can express
the 22 a bit better (some headerlen - 2 with a comment?), but I can look
at that when I apply the patch.

Thanks!

johannes
