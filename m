Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFDA82333B8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 16:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgG3OC1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 10:02:27 -0400
Received: from mail.as201155.net ([185.84.6.188]:25438 "EHLO mail.as201155.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3OC0 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 10:02:26 -0400
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:52254 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k198X-0006v1-19; Thu, 30 Jul 2020 16:02:21 +0200
X-CTCH-RefID: str=0001.0A782F19.5F22D2ED.0062,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=PnL8697EkqW8pP7JGqouvhW73YQ5luyELQzYm1MDrkY=;
        b=VYNVSGdexgt/L3Ws4iSHAPTT7F63ZH/LqWUEDMNWctOnspJbL79gzj/ztWpKtYl8dixlUQBJn3bdbl+pWwv4bvZwTlg8C606ZVMnn7Y3sXkZ4Ivxk7i2QniMgzdWtkwcL4ybOY0eDY5RQW7JoZOFyYmod31KEF+HHPr7E+LzBLk=;
Subject: Re: [RFC] mac80211: add a function for running rx without passing
 skbs to the stack
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
References: <20200725185554.17346-1-nbd@nbd.name>
 <c1b2a6583245560952db0cde3e3d6ff9db4cbd5a.camel@sipsolutions.net>
 <801c3763d82b86268797fdc75040ce75@codeaurora.org>
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
Message-ID: <b7943d1e-0e1e-c72e-14c6-c783058f089a@dd-wrt.com>
Date:   Thu, 30 Jul 2020 16:02:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <801c3763d82b86268797fdc75040ce75@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Received:  from [2a01:7700:8040:300:9ce9:cf1b:d735:dc62]
        by webmail.newmedia-net.de with esmtpsa (TLSv1:AES128-SHA:128)
        (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1k198X-0000qu-03; Thu, 30 Jul 2020 16:02:21 +0200
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


Am 29.07.2020 um 03:47 schrieb Rajkumar Manoharan:
> On 2020-07-25 12:14, Johannes Berg wrote:
>>> +void ieee80211_rx_napi(struct ieee80211_hw *hw, struct 
>>> ieee80211_sta *pubsta,
>>> +               struct sk_buff *skb, struct napi_struct *napi)
>>> +{
>>> +    struct sk_buff_head list;
>>> +
>>> +    __skb_queue_head_init(&list);
>>> +
>>> +    /*
>>> +     * key references and virtual interfaces are protected using RCU
>>> +     * and this requires that we are in a read-side RCU section during
>>> +     * receive processing
>>> +     */
>>> +    rcu_read_lock();
>>> +    ieee80211_rx_list(hw, pubsta, skb, &list);
>>> +    rcu_read_unlock();
>>> +
>>> +    while ((skb = __skb_dequeue(&list)) != NULL)
>>
>> I'd drop the != NULL, but no strong feelings :)
>>
>>> +        if (napi)
>>> +            napi_gro_receive(napi, skb);
>>> +        else
>>> +            netif_receive_skb(skb);
>>
>> Nit: I'd prefer braces on the loop, just makes it nicer to read IMHO.
>>
>> OTOH, the !napi case should use netif_receive_skb_list(), no?
>>
>> Given the discussion, it also seems a bit odd to add more work for NAPI
>> poll where we process one by one ... But I see why you did that, and I
>> guess it's not actually that much more work.
>>
> IIUC Sebastian mentioned that threadable NAPI approach is helping in 
> load balancing
> with minor check for dummy netdev for wireless drivers. Does this 
> change improve
> the latency in both threaded and non-threaded modes?
check also for felix's last variant. he made a different patch based on 
workq's
i'm testing this variant now on various platforms including a patched 
ath10k driver
next step would be just to change other wifi drivers for the same 
concept. just a few are using napi at all (mt76, ath10k and iwlwifi)
>
> -Rajkumar
>
