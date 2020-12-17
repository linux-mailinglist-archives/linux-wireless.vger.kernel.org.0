Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 876972DD196
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 13:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLQMk4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 07:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgLQMkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 07:40:55 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CDAC061794
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 04:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:Subject:From:References:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VBRAOeYnTsb9SYg0ukbj8B283FFx2VaOi/KeOyO1Tpc=; b=jbAcwdEfmrtLXBErYsaHGEnmaa
        g04AlrLTSiod6GvvrfQDzuvtWVobkPYYIouvmMQGiR6gPN0T2yw1Ty9gsOISv6nRecLSmXpN33bSQ
        OpdW+kOTrvrywYtfmmH5F1FAIFhO4rGrCfIsoZwnCjMXlz55t6OGg/vUiJSPeE6zBjOY=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpsZp-0001xr-ND; Thu, 17 Dec 2020 13:40:13 +0100
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-4-nbd@nbd.name>
 <3980921a9276b9d38b12651e40590118f1d65609.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH 4/7] net/fq_impl: do not maintain a backlog-sorted list of
 flows
Message-ID: <59a58091-9fbc-4150-b839-bbc8e5e63f00@nbd.name>
Date:   Thu, 17 Dec 2020 13:40:13 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <3980921a9276b9d38b12651e40590118f1d65609.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-16 21:59, Johannes Berg wrote:
> On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
>> 
>> +	u32 *flows_bitmap;
> 
>> +	fq->flows_bitmap[idx / 32] &= ~BIT(idx % 32);
> 
>> +	for (base = 0; base < fq->flows_cnt; base += 32) {
>> +		u32 mask = fq->flows_bitmap[base / 32];
> 
> This all seems a little awkward, why not use unsigned long * and
> <linux/bitops.h>?
> 
> The &=~ BIT() thing above is basically __clear_bit() then, the loops
> later are basically for_each_set_bit() if I'm reading things right.
I guess I can simplify this some more. I think I avoided
for_each_set_bit for performance reasons to keep things inline in the
loop, but I'm not sure how much that matters in practice.

- Felix
