Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833DB6EA9D6
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 14:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjDUMA7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 08:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjDUMA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 08:00:57 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841B83FD
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 05:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QO89fD4TotbVtfWNP8SezfNFANvMgDjHV6/iRQbAFTM=; b=dDmAK4vEsvhjIxEGeNtklrxgvs
        DDqnFDGUBfsHzLiH1qbbToM+lBsdu3HdUlShHIdDkSYogY1rPekjHONFgMI9o7YHIoxYQU6ClkTEf
        kQBXuTx+rRx0KztmOOONNYpgHjV7CYm5GNe2AAdgM2E/bPY0od/fFYuk8JNeM+QY/YjQ=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1pppRZ-00H9RZ-Qv; Fri, 21 Apr 2023 14:00:49 +0200
Message-ID: <3a4bcfc7-1bd3-b2a0-5341-3aec0f5e44b4@nbd.name>
Date:   Fri, 21 Apr 2023 14:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Cc:     Karthik M <quic_karm@quicinc.com>, linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
 <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
 <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
 <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
 <f562b221-b702-21ac-eedf-3a428e29844d@uni-rostock.de>
 <5e9323647bfc25cf4e09f107348a4e79e9d5c371.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <5e9323647bfc25cf4e09f107348a4e79e9d5c371.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21.04.23 13:13, Johannes Berg wrote:
> On Fri, 2023-04-21 at 12:34 +0200, Benjamin Beichler wrote:
>> > > 
>> > > So then let's say we want to fix the existing code. I can think of these
>> > > possible ways:
>> > > 
>> > >   * splitting off a bit for initialized from the unsigned long
>> > >     (which at least for 64-bit should be OK since presumably most code
>> > >      using this will run on 32-bit systems too)
>> > >   * adding another value for it, e.g. making it u32 and adding a bool 
>> > > for
>> > >     "first value"
>> > >   * biasing the value, like Felix proposes, could be by 1 or -1 for
>> > >     example
>> You forgot the possibility to introduce a separate init function, which 
>> boils down to a shift with an assignment statement for code, and no 
>> further data memory cost. Even simply extending the current init 
>> function (which simply always set 0) would be enough.
> 
> Sort of. Yeah I should've mentioned it, but that means you actually have
> to know the first value, and track "first time usage" separately in the
> user code.
> 
> Or you init to something useful at the first value, e.g. saying for
> signal strength "let's assume -45dBm average if we don't know". That
> doesn't seem very practical?
> 
> The behaviour of "first value inserted will init" seems sensible.
> 
>> > > As for biasing the value, couldn't that lead to a similar problem? It's
>> > > clearly less likely that the end of the range is reached rather than
>> > > zero, but still?
>> > I don't see how it can reduce the range in any way, since the bias is
>> > added to the fractional part. A range reduction would seem to imply
>> > having an average value that's bigger than the maximum allowed shifted
>> > input (top bits cut off), and I don't think that's possible.
>> > 
>> It does not reduce the range, but it does not matter whether your 
>> internal state is 0 or 2^(-precision), the non-intuitive behavior stays 
>> the same.
> 
> OK I was sort of handwaving ... :-)
> 
> To have a problem, basically the +1 has to overflow the value, so that
> we think that the next time around we should init, rather than add.
> 
> That means the existing average has to be 0xffff'ffff (let's take 32
> bits, its easier to type). Clearly that can't happen on the first time
> since then the precision bits are all 0.
> 
> But I think Felix is right (thought not sure about the reasoning) and
> that cannot happen, because the add calculation does a ">>weight_rcp"
> shift at the end, so there are always some top bits that are non-zero,
> and _weight_rcp has to be a power of two. Now, 1 is a power of two, but
> that'd be really stupid, and nobody is using it ... So I think if we
> prohibit 1 for that, we're fine?
> 
> Btw, Felix, shouldn't your patch have said "bool init = !internal"?

No, 'internal' is the correct value. The name is confusing though - I 
intended it to be short for 'initalized', but it should probably be 
renamed to 'valid' or something like that.

- Felix
