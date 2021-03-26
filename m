Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59634B18E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCZVx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 17:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZVxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 17:53:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C65C0613AA
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MngQf5KHu6+ug9LH4Hz5GZZZKR+KxYngAx5ubI/wuLI=; b=NxRZU2CKYEPoOvnqzWLmIIYoKY
        li6eUgogvD8LeRdiIeK2Z1HaOAWXlOq8Dxyp7Z/C2yscOLAIBKLywHt2hPbNpU5W6u/Kqq65T1WjH
        yFH9mu0iuqd+EeOni9soc4nrrS5WvT4AIzy+wDfkufFlXfNswpJP9mNYoes5Ral0EhVE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPuOS-0004rO-PZ; Fri, 26 Mar 2021 22:53:24 +0100
Subject: Re: [PATCH 1/3] mt76: mt7615: 0-terminate firmware log messages
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20210326205505.74383-1-nbd@nbd.name>
 <249e2022c17f2555445061e533353ccd6f9e9b60.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <a1aeb214-cb3a-0c7b-1a6a-7b538d86d985@nbd.name>
Date:   Fri, 26 Mar 2021 22:53:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <249e2022c17f2555445061e533353ccd6f9e9b60.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-03-26 22:09, Johannes Berg wrote:
>> 
>> +	skb->data[skb->len] = 0;
>>  	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
>>  }
>> 
> 
> Are you sure there's always enough space to write to the skb? Following
> the code up I'm not even sure it's always a linear skb :-)
> 
> Might be safer/better to do
> 
> 	wiphy_info(..., "%s: %*s", type, skb->len - sizeof(*rxd),
> data);
> 
> instead?
Maybe it does trust the firmware too much. I'll send a v2 based on your
suggestion.

Thanks,

- Felix

