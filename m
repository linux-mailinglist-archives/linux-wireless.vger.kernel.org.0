Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FA33F9498
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 08:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244219AbhH0Gy2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 02:54:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54337 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243114AbhH0Gy2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 02:54:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630047220; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=AJV7Q6czYcMi4KLMzcD/A2eh7WPmYMiRyUK5jnvafSk=;
 b=P93RGJmPXCkd1eHKn0f61qOBtaW86f5RrSfQmfji5+V0Nd9xgaYe/QPPFeTaH4Sf6BPYn3tS
 VRVuQazFabZyT280+HQOh6yphsXMHg9zDs/VkNuf+wBb2ar1irHfJsFmlvCviEc/jZVe3d0u
 YY55rh7PTnGCIzjz3Rp4YYpJYaE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 61288bd9d6653df767b1a707 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 06:53:13
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 230E8C43618; Fri, 27 Aug 2021 06:53:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9D753C4338F;
        Fri, 27 Aug 2021 06:53:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Aug 2021 14:53:12 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
 <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
 <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
Message-ID: <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-27 14:46, Johannes Berg wrote:
> On Fri, 2021-08-27 at 10:11 +0800, Wen Gong wrote:
>> > Also, if we're doing this anyway, then we can change
>> > the code above (perhaps as a separate patch) to not do
>> > cfg80211_find_ext_ie() but rather take it out of the parsed.
>> do you mean NOT use cfg80211_find_ext_ie()/cfg80211_find_ie() and 
>> still
>> use "struct ieee802_11_elems elems" here and
>> move this code to a separate function/patch?
> 
> Well, there's an existing place in this function that uses
> cfg80211_find_ext_ie(), and various uses of ieee80211_bss_get_ie(), so
> it feels like if we're going to do the full parsing, we should switch
> all the existing "look up an element" to also use the parsed data
> instead.
> 
> Not the other way around :)
ok.
so it ha 2 way to change, right?
1.
change ieee802_11_parse_elems() to ieee80211_bss_get_ie()

2.
still use ieee802_11_parse_elems(), and change others 
ieee80211_bss_get_ie()/cfg80211_find_ext_ie()
to use the result of ieee802_11_parse_elems()
> 
> johannes
