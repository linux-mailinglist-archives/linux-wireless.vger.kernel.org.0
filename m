Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63E12DC821
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 22:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgLPVHN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 16:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgLPVHM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 16:07:12 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C19C061794
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 13:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mSOw54gPX97YixvYsIkR+2jdF6HyygioNWN/oF7rb58=; b=GiiGiqJ4Qygn3BHjC2RKoa6WCn
        7a+0f9M2+t0PnGt+jKJCV9qcLAi5zygu9LK0Ck6a46GTyfXYYnpSXTW17KQpnrtd6imF9+V0h4akv
        ua3No2CUyAWgRvUvN6Ot3sVPEUDpLFIWbm/ZuzL7zMfFq1RzWleKz6ZNVPom1UC5kYU4=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpe00-00045Q-3T; Wed, 16 Dec 2020 22:06:16 +0100
Subject: Re: [PATCH 7/7] mac80211: add rx decapsulation offload support
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20201216204316.44498-1-nbd@nbd.name>
 <20201216204316.44498-7-nbd@nbd.name>
 <a8c30051bd1e7a5efbb98d391eb46959d046a941.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <d99bc7a7-4fcc-bbf6-b7d8-af9456383a9d@nbd.name>
Date:   Wed, 16 Dec 2020 22:06:15 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <a8c30051bd1e7a5efbb98d391eb46959d046a941.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2020-12-16 22:04, Johannes Berg wrote:
> Wait, another thing:
> 
>> +++ b/net/mac80211/iface.c
>> @@ -798,10 +798,21 @@ static bool ieee80211_set_sdata_offload_flags(struct ieee80211_sub_if_data *sdat
>>  		flags &= ~IEEE80211_OFFLOAD_ENCAP_ENABLED;
>>  	}
>>  
>> +	if (ieee80211_hw_check(&local->hw, SUPPORTS_RX_DECAP_OFFLOAD) &&
>> +	    ieee80211_iftype_supports_encap_offload(sdata->vif.type)) {
>> +		flags |= IEEE80211_OFFLOAD_DECAP_ENABLED;
> 
> Why does decap depend on encap here?
Supported for the same types, I didn't feel like duplicating the
function. I guess I could rename it to
ieee80211_iftype_supports_hdr_offload to make it more clear.

- Felix
