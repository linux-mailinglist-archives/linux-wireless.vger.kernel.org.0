Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A73F95DE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 10:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244550AbhH0ITR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 04:19:17 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52225 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244551AbhH0ITQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 04:19:16 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1630052308; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MAGYfx0QYX7S67RF9DlLdC59ix/pZDUbAAEsSRYUZeg=;
 b=DClJJkX/CGHEd5zUd5Kt9hCRQSrykMPTRoMODr+Ho0l8pVIf9OECqIEpzRy09RuyuW341pRz
 8RMDeYuBScIM8r3L0Z4JlilmPYrKbhdk//izhrb76XW+WR1++XuyIYRP/nYvobVMiozXPmWq
 sevMC/uMvoa1njlsATs8Zo5fOW0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61289fd3fc1f4cb692781292 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 27 Aug 2021 08:18:27
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AC624C4360C; Fri, 27 Aug 2021 08:18:27 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1CC53C4338F;
        Fri, 27 Aug 2021 08:18:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 27 Aug 2021 16:18:27 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 8/8] mac80211: save transmit power envelope element and
 power constraint
In-Reply-To: <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
References: <20210820122041.12157-1-wgong@codeaurora.org>
 <20210820122041.12157-9-wgong@codeaurora.org>
 <dfe27f657b4615369cf751d394f5cba75f5fdcc1.camel@sipsolutions.net>
 <25fcede26b99604a03d0b321b7120db4@codeaurora.org>
 <48ad47869e703cbef437378c508d6a5b64c160ae.camel@sipsolutions.net>
 <db22a4cb9a07e3845a50f436c7052feb@codeaurora.org>
 <0680b508a7864e02f55d763851f7460baa73b53f.camel@sipsolutions.net>
 <110489059796b17849d0f32fb5189828@codeaurora.org>
 <27680423e824dd67217cc6f1e62f9ac0a1af78f2.camel@sipsolutions.net>
Message-ID: <01d9e4eadbb0d87edbc026fc719858a3@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-08-27 15:38, Johannes Berg wrote:
> On Fri, 2021-08-27 at 15:12 +0800, Wen Gong wrote:
>> On 2021-08-27 14:55, Johannes Berg wrote:
>> > On Fri, 2021-08-27 at 14:53 +0800, Wen Gong wrote:
>> > > >
>> > > > Well, there's an existing place in this function that uses
>> > > > cfg80211_find_ext_ie(), and various uses of ieee80211_bss_get_ie(), so
>> > > > it feels like if we're going to do the full parsing, we should switch
>> > > > all the existing "look up an element" to also use the parsed data
>> > > > instead.
>> >
>> > > ok.
>> > > so it ha 2 way to change, right?
>> > > 1.
>> > > change ieee802_11_parse_elems() to ieee80211_bss_get_ie()
>> >
>> > No why?
>> >
>> > I think we should make a first patch (that doesn't add TPE yet) that
>> > changes the function to ieee80211_parse_elems() and removes all the
>> > ieee80211_bss_get_ie() / cfg80211_find_ext_ie() calls in favour of just
>> > parsing once, and then looking at the elements there.
>> >
>> > Then your TPE patch becomes trivial since the elems are already there?
>> this patch still needed, because the lower driver need the info.
>> and this patch is save the info to "struct ieee80211_bss_conf 
>> *bss_conf"
>> and
>> pass it to lower driver.
> 
> Of course, but you don't have to deal with parsing etc. in that patch
> then.
> 
yes.
then should I use "struct ieee802_11_elems elems = {0}" or "struct 
ieee802_11_elems *elems = kzalloc(sizeof(*elems))"
in the parsing patch?

> johannes
