Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51506468386
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 10:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384446AbhLDJWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 04:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354954AbhLDJWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 04:22:11 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D00C061751
        for <linux-wireless@vger.kernel.org>; Sat,  4 Dec 2021 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=U1TyTZaP4erwVm2TsxvENRYqAyJ5hG1omoac8AK0j4o=; b=eLywOJinH4EAdvWZjJgzSeX7TZ
        Swu98l+9WWr32OszT4DrWWw5tOeS8U1eTwnU5aGbTRKay28yl80y9QLxs0mZJ3snUUuOmeUFJvuwM
        E6eluemrcQ3F/hCDi6ThWlCdwVxnUJj6uKdV4FQ9xfGlK6u2BVFGZENpZ1JBNk75Koxs=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mtRBs-00053G-E5; Sat, 04 Dec 2021 10:18:44 +0100
Message-ID: <35940119-ae70-b040-5645-9a90cb8f9046@nbd.name>
Date:   Sat, 4 Dec 2021 10:18:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC] mac80211: Mesh Fast xmit support
Content-Language: en-US
To:     Sriram R <srirrama@qti.qualcomm.com>,
        "Sriram R (QUIC)" <quic_srirrama@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
References: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
 <accc06d7-8472-77d4-6d90-1d40565989aa@nbd.name>
 <SN6PR02MB4334A1D49795C50D341BB1D6F76B9@SN6PR02MB4334.namprd02.prod.outlook.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <SN6PR02MB4334A1D49795C50D341BB1D6F76B9@SN6PR02MB4334.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-04 10:14, Sriram R wrote:
>> -----Original Message-----
>> From: Felix Fietkau <nbd@nbd.name>
>> Sent: Saturday, December 4, 2021 1:55 PM
>> To: Sriram R (QUIC) <quic_srirrama@quicinc.com>; linux-
>> wireless@vger.kernel.org
>> Cc: johannes@sipsolutions.net
>> Subject: Re: [RFC] mac80211: Mesh Fast xmit support
>> 
>> WARNING: This email originated from outside of Qualcomm. Please be wary
>> of any links or attachments, and do not enable macros.
>> 
>> On 2021-12-04 03:04, Sriram R wrote:
>> > Support Fast xmit for mesh device types by caching the header
>> > corresponding to the ethernet DA and reusing the cached header (mac,
>> > mesh, llc) everytime the packet is intended for that DA.
>> >
>> > This will avoid multiple path table lookups during header generation
>> > for a mesh packet tx.
>> >
>> > Freshness of the header is verified by identifying change in mesh
>> > paths before using the header and corresponding changes to the header
>> > and cache entry is done on the fly.
>> >
>> > Mutable fields of the header such as eth SA, tid, mesh SN, PN are
>> > updated for each xmit.
>> >
>> > Each cache entry is about 100Bytes, least used/expired entries are
>> > periodically removed when cache gets almost full.
>> > Currently the size is set to 50 entries.
>> >
>> > Driver needs to advertise NL80211_EXT_FEATURE_MESH_FAST_XMIT
>> > to enable this support and setup this cache.
>> Thanks for working on this! I will likely take a closer look at it soon.
>> One quick question: does this impose any extra requirements on the driver,
>> or why does the driver need to advertise support for this?
> Hi Felix,
> 
>   There is no requirement from driver/hw as such and this has similar
> requirement as IEEE80211_HW_SUPPORT_FAST_XMIT being enabled from driver.
> But I was not sure if adding ~5KB (50 entries x ~100Bytes) by default
> was acceptable for those drivers which already enabled FAST_XMIT.
> Hence added this extra control from driver to enable this feature for this RFC.
> Kindly suggest if other alternatives could be taken up.
I think 5 KB memory use is very small compared to the memory used for 
packets and other data. If this is only about memory use, it also 
doesn't make much sense to me for the driver to decide if this is going 
to be used.
My suggestion would be to not introduce an extra capability and simply 
enable it if fast-xmit is supported.
Maybe it would make sense to allow the user to configure this, because 
some networks might benefit from a larger cache.

- Felix
