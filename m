Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEEE6EA795
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 11:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDUJxN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 05:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDUJxM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 05:53:12 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE99D9772
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 02:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Gw3Z1UuYa8vwz13PltM2dk9xXXE2d3syosEDMNs/io0=; b=CZH0L+/w1NHl/Z7+jNpeJZznRD
        ji8wMh3zvlboLCZ9tARmUA2YUlK+KL7R7+CqujJQR19uFynpF4Vz/QhvmO/vx6eGtUaBlDpAzp+ge
        ufNFmLiu8X9SZY/gA5gwHZyxjNPlyUAT2TIPQfED0qyCXXHazEFddgQwJL0fpQwlg3YY=;
Received: from p54ae9730.dip0.t-ipconnect.de ([84.174.151.48] helo=nf.local)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ppnRz-00H7Bc-4L; Fri, 21 Apr 2023 11:53:07 +0200
Message-ID: <c22ecc12-6841-e20b-0ee8-eec2e6d6e3e6@nbd.name>
Date:   Fri, 21 Apr 2023 11:53:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>,
        Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Cc:     Karthik M <quic_karm@quicinc.com>, linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
 <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
 <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
In-Reply-To: <ad5febda1c32c0d84aa8ac509fefc5b31a8b7ed4.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21.04.23 11:35, Johannes Berg wrote:
> To me, the first question is if there are potentially any users that are
> _relying_ on the current behaviour. This seems unlikely though, looking
> at the ~30 users, most sound like signal/rssi, packet sizes, etc.
> 
> So let's say with the bug found here that prompted this patch, chances
> are that there aren't any users that really want 0 to be special. I also
> can't even really think of a reason for wanting that.
> 
> 
> So then let's say we want to fix the existing code. I can think of these
> possible ways:
> 
>   * splitting off a bit for initialized from the unsigned long
>     (which at least for 64-bit should be OK since presumably most code
>      using this will run on 32-bit systems too)
>   * adding another value for it, e.g. making it u32 and adding a bool for
>     "first value"
>   * biasing the value, like Felix proposes, could be by 1 or -1 for
>     example
> 
> All of these have a memory cost, of course, though the first two are
> data and the second code, so for things like stations the code exists
> only once and the data multiple times. On 64-bit we can probably make
> the first two not have a data memory cost though.
> 
> As for biasing the value, couldn't that lead to a similar problem? It's
> clearly less likely that the end of the range is reached rather than
> zero, but still?
I don't see how it can reduce the range in any way, since the bias is 
added to the fractional part. A range reduction would seem to imply 
having an average value that's bigger than the maximum allowed shifted 
input (top bits cut off), and I don't think that's possible.

- Felix
