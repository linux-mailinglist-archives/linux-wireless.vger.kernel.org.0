Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7915A2DC854
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 22:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgLPV3U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 16:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgLPV3U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 16:29:20 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528CEC061794
        for <linux-wireless@vger.kernel.org>; Wed, 16 Dec 2020 13:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=gM4mzDQAZcxGNqZanwnDYnrldSzhyh6gUPxR9GgdJ8k=; b=KxXTFgSzevXQy9TWcnddNogst8
        AImfnPpa1vk25JJoUAkK58O6vtAliteTNyV5FGyr8bZou0Gty3747Ts9aHgxAlPjuZRv2sifCtgnj
        T+A2FB9y3FlMzLssJAnHeWBAr1+6T+29RetPqDWN++iiiQvpz1u0N/PNoiZIJn0kPM4k=;
Received: from p4ff13815.dip0.t-ipconnect.de ([79.241.56.21] helo=nf.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kpeLP-0005Ql-WE; Wed, 16 Dec 2020 22:28:24 +0100
Subject: Re: [PATCH 1/7] net/fq_impl: bulk-free packets from a flow on
 overmemory
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
References: <20201216204316.44498-1-nbd@nbd.name>
 <400936f158c59a25758ca05503c271710100476f.camel@sipsolutions.net>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <99ee36a1-4e30-194f-5101-0dc3d4d30a46@nbd.name>
Date:   Wed, 16 Dec 2020 22:28:23 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <400936f158c59a25758ca05503c271710100476f.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-12-16 21:54, Johannes Berg wrote:
> On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
>> 
>> +static int fq_flow_drop(struct fq *fq, struct fq_flow *flow,
>> +			fq_skb_free_t free_func)
>> +{
>> +	unsigned int packets = 0, bytes = 0, truesize = 0;
>> +	struct fq_tin *tin = flow->tin;
>> +	struct sk_buff *skb;
>> +	int pending;
>> +
>> +	lockdep_assert_held(&fq->lock);
>> +
>> +	pending = min_t(int, 32, skb_queue_len(&flow->queue) / 2);
>> 
> 
> Why 32?
I guess I forgot got make it configurable. sch_fq_codel uses 64, but
that seemed a bit excessive to me.

- Felix
