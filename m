Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFF73877B1
	for <lists+linux-wireless@lfdr.de>; Tue, 18 May 2021 13:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348549AbhERLbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 18 May 2021 07:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbhERLbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 18 May 2021 07:31:36 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C19C061573
        for <linux-wireless@vger.kernel.org>; Tue, 18 May 2021 04:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=whqA0v/ee6m/c1Tesp+ly9pYJeUOQyDUfupSpC263z8=; b=TLDvNsLGRFUJ+IhkZPxZaDZCVh
        2tqw7+mrlrhBklrpq2iTd+YA/IN8vknx6NETeK6Z119Il/zTMlqqTJMdbWFfhspjclaR9tLJd5qpu
        b8pphq+G3nBzgRrBEVAY97DdW0x9ItWiI63Jirw/cMmaCLvqi910Lnc3TA1l8XBhqYvw=;
Received: from p54ae9ff2.dip0.t-ipconnect.de ([84.174.159.242] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lixvV-00083s-6K; Tue, 18 May 2021 13:30:17 +0200
Subject: Re: [PATCH 1/2] mac80211: do not use low data rates for data frames
 with no ack flag
To:     Johannes Berg <johannes@sipsolutions.net>,
        Philipp Borgers <borgers@mi.fu-berlin.de>
Cc:     linux-wireless@vger.kernel.org
References: <20210518110755.43077-1-borgers@mi.fu-berlin.de>
 <f80ba91c-88d4-3064-6861-5f9510b4fb69@nbd.name>
 <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <eaf54a94-5d8d-13e2-61e5-23b152fcd3b6@nbd.name>
Date:   Tue, 18 May 2021 13:30:14 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <b42014d8bfbb6b58fc25656effada37aac066a85.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-05-18 13:19, Johannes Berg wrote:
> On Tue, 2021-05-18 at 13:17 +0200, Felix Fietkau wrote:
>> 
>> Frames with IEEE80211_TX_CTL_HW_80211_ENCAP set have no 802.11 header,
>> so please change the check something like this:
>> 
>> 	if ((info->flags & IEEE80211_TX_CTL_NO_ACK) &&
>> 	    ((info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
>> 	     ieee80211_is_data(hdr->frame_control)))
> 
> Maybe we should consider some kind of inline helper?
> 
> static inline bool ieee80211_is_tx_data(struct sk_buff *skb)
> {
> 	... *info = ...
> 	... *hdr = (void *)skb->data;
> 
> 	return (info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP) ||
>                ieee80211_is_data(hdr->frame_control);
> }
> 
> 
> or so?
Yes, I think that's a good idea. There will definitely be more places
that need this.

- Felix
