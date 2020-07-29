Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA47C231768
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jul 2020 03:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgG2Br7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Jul 2020 21:47:59 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:39428 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730328AbgG2Br7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Jul 2020 21:47:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595987278; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=5xRi5eAfB+i5FB7oFrSlukKbnt1jfbHChiGR6YfjEjQ=;
 b=OMTTWnuwaGE9Xg4FqntHEdEhgtJ+bCiMl8ARUFOEKTnY6Wv8Z8wPYAf82Dk4733dDpJCOMjW
 nGK2mCRmBFKk1Tsp59WL3BHM9oqHANTOq79sn+UQuC2ESobZI33+C+fgzSaVf0XQgixJLLK5
 JSoPTO4Q8vfF66+OwYNoGF9JUcY=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f20d5337ab15087eb672dae (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 29 Jul 2020 01:47:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 180D8C43391; Wed, 29 Jul 2020 01:47:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AB6C0C433C9;
        Wed, 29 Jul 2020 01:47:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Jul 2020 18:47:30 -0700
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Felix Fietkau <nbd@nbd.name>, linux-wireless@vger.kernel.org,
        linux-wireless-owner@vger.kernel.org
Subject: Re: [RFC] mac80211: add a function for running rx without passing
 skbs to the stack
In-Reply-To: <c1b2a6583245560952db0cde3e3d6ff9db4cbd5a.camel@sipsolutions.net>
References: <20200725185554.17346-1-nbd@nbd.name>
 <c1b2a6583245560952db0cde3e3d6ff9db4cbd5a.camel@sipsolutions.net>
Message-ID: <801c3763d82b86268797fdc75040ce75@codeaurora.org>
X-Sender: rmanohar@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-07-25 12:14, Johannes Berg wrote:
>> +void ieee80211_rx_napi(struct ieee80211_hw *hw, struct ieee80211_sta 
>> *pubsta,
>> +		       struct sk_buff *skb, struct napi_struct *napi)
>> +{
>> +	struct sk_buff_head list;
>> +
>> +	__skb_queue_head_init(&list);
>> +
>> +	/*
>> +	 * key references and virtual interfaces are protected using RCU
>> +	 * and this requires that we are in a read-side RCU section during
>> +	 * receive processing
>> +	 */
>> +	rcu_read_lock();
>> +	ieee80211_rx_list(hw, pubsta, skb, &list);
>> +	rcu_read_unlock();
>> +
>> +	while ((skb = __skb_dequeue(&list)) != NULL)
> 
> I'd drop the != NULL, but no strong feelings :)
> 
>> +		if (napi)
>> +			napi_gro_receive(napi, skb);
>> +		else
>> +			netif_receive_skb(skb);
> 
> Nit: I'd prefer braces on the loop, just makes it nicer to read IMHO.
> 
> OTOH, the !napi case should use netif_receive_skb_list(), no?
> 
> Given the discussion, it also seems a bit odd to add more work for NAPI
> poll where we process one by one ... But I see why you did that, and I
> guess it's not actually that much more work.
> 
IIUC Sebastian mentioned that threadable NAPI approach is helping in 
load balancing
with minor check for dummy netdev for wireless drivers. Does this change 
improve
the latency in both threaded and non-threaded modes?

-Rajkumar
