Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F013D46835D
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Dec 2021 09:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384283AbhLDI2x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Dec 2021 03:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384278AbhLDI2w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Dec 2021 03:28:52 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DF2C061751
        for <linux-wireless@vger.kernel.org>; Sat,  4 Dec 2021 00:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=roIc1b+dd3UO9fqbLwyuZCLmiV7fx47igl8x6sh2q2A=; b=KMvZolzYjpXjncC16A5xj1comm
        KsJBpcMhM4CZdV//NJyElKEmTgP1RHNkRKwLAHS52XbWlNAoZq3qVtuvpUQOPVCDcWZrninAWthpa
        4u4RHOZBLnzqplAtWw29V8kRViRKciEd4rDqeqT76GBCmuqvM84HPqTexGZNa83z6Cks=;
Received: from p54ae911a.dip0.t-ipconnect.de ([84.174.145.26] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1mtQMG-0003Nf-Hx; Sat, 04 Dec 2021 09:25:24 +0100
Message-ID: <accc06d7-8472-77d4-6d90-1d40565989aa@nbd.name>
Date:   Sat, 4 Dec 2021 09:25:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [RFC] mac80211: Mesh Fast xmit support
Content-Language: en-US
To:     Sriram R <quic_srirrama@quicinc.com>,
        linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net
References: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
From:   Felix Fietkau <nbd@nbd.name>
In-Reply-To: <1638583489-6518-1-git-send-email-quic_srirrama@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-12-04 03:04, Sriram R wrote:
> Support Fast xmit for mesh device types by caching the
> header corresponding to the ethernet DA and reusing
> the cached header (mac, mesh, llc) everytime the packet
> is intended for that DA.
> 
> This will avoid multiple path table lookups during header
> generation for a mesh packet tx.
> 
> Freshness of the header is verified by identifying change
> in mesh paths before using the header and corresponding
> changes to the header and cache entry is done on the fly.
> 
> Mutable fields of the header such as eth SA, tid, mesh SN,
> PN are updated for each xmit.
> 
> Each cache entry is about 100Bytes, least used/expired entries
> are periodically removed when cache gets almost full.
> Currently the size is set to 50 entries.
> 
> Driver needs to advertise NL80211_EXT_FEATURE_MESH_FAST_XMIT
> to enable this support and setup this cache.
Thanks for working on this! I will likely take a closer look at it soon.
One quick question: does this impose any extra requirements on the 
driver, or why does the driver need to advertise support for this?

- Felix
