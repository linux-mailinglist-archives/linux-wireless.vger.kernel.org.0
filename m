Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C282DD11A
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Dec 2020 13:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLQMKz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Dec 2020 07:10:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40528 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726533AbgLQMKx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Dec 2020 07:10:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608206966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9NuUog3n8t1rMoDZI0xMlqDyO0CLx8FI8sn63mGxl0w=;
        b=ak3vvOdGOwnPzzMKsiEgrFqwRPkYWpMleAgFpKSOaIUB/Is9n9L62T9tExnbRQ/T0FpzoD
        ZpVT4X4tvbRFAH3NKt1f918Ub+ZGKPTeK7TgAKjVWyST+xZ0KWUWWAdDVeI+83/QeCozfo
        zl3D4cb1r6T4jA4E6789mdbz2X7r3FU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-LTOXF9-yOOCCEps4IRLX-w-1; Thu, 17 Dec 2020 07:09:24 -0500
X-MC-Unique: LTOXF9-yOOCCEps4IRLX-w-1
Received: by mail-ed1-f69.google.com with SMTP id z20so13267252edl.21
        for <linux-wireless@vger.kernel.org>; Thu, 17 Dec 2020 04:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9NuUog3n8t1rMoDZI0xMlqDyO0CLx8FI8sn63mGxl0w=;
        b=C12EOXvbZX7AxrqhrpOeOmqlgGFcyWfw6beneUpcPV33SggesGU1KD3+l2MtiN034b
         XChGS0yAlQC/Ek4Ck4K5kOtZLmGVixqqUEOy7NLJss37JgAaqLZJoTN3y0AHUlyJYXqd
         TjB3dNeMoo5yc2A8JdedLLLfKgn1qShGgwrnFwyv2ybvXYYGgo/pa17PIENPhybzqH6P
         +VvWFW9ToMMPJI0IO8+w8rdDgjaMhan56/03c96hvLsyv/Xc9KhSMruWcA+OlQIfDVnG
         K40foCQvW/GdxK65Jv684J4xQz6/p4Uw7kOS5AYFzuZn7coJxEaDFYzhKAP1X5daFKBE
         OgwQ==
X-Gm-Message-State: AOAM533qSJvNh/GQ3AG9mcSQwfJ55VgWFea9fKfAoa5JMWzzyFObTpGf
        iPUDJV4uBxgvhHe6aTXU8JXWcLEoRm4guCkndWTtSTMGaWxr9qrM/XkME0wjbe39sZKCdPcoUFe
        s3oI+AGFSUixY20cTgxkcGH4DFWc=
X-Received: by 2002:a50:d2d2:: with SMTP id q18mr37935154edg.346.1608206963457;
        Thu, 17 Dec 2020 04:09:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1Y2Wj2Gc7KKfWRW7MnHBgVP+NfABsEH4sCev6Rnw8rnDKC4yVJrOl0/tu8spT8xatRiylug==
X-Received: by 2002:a50:d2d2:: with SMTP id q18mr37935145edg.346.1608206963309;
        Thu, 17 Dec 2020 04:09:23 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id b14sm7246732edf.34.2020.12.17.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 04:09:22 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3C44B1802A7; Thu, 17 Dec 2020 13:09:22 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/7] net/fq_impl: bulk-free packets from a flow on
 overmemory
In-Reply-To: <99ee36a1-4e30-194f-5101-0dc3d4d30a46@nbd.name>
References: <20201216204316.44498-1-nbd@nbd.name>
 <400936f158c59a25758ca05503c271710100476f.camel@sipsolutions.net>
 <99ee36a1-4e30-194f-5101-0dc3d4d30a46@nbd.name>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 17 Dec 2020 13:09:22 +0100
Message-ID: <877dpgbpn1.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> writes:

> On 2020-12-16 21:54, Johannes Berg wrote:
>> On Wed, 2020-12-16 at 21:43 +0100, Felix Fietkau wrote:
>>> 
>>> +static int fq_flow_drop(struct fq *fq, struct fq_flow *flow,
>>> +			fq_skb_free_t free_func)
>>> +{
>>> +	unsigned int packets = 0, bytes = 0, truesize = 0;
>>> +	struct fq_tin *tin = flow->tin;
>>> +	struct sk_buff *skb;
>>> +	int pending;
>>> +
>>> +	lockdep_assert_held(&fq->lock);
>>> +
>>> +	pending = min_t(int, 32, skb_queue_len(&flow->queue) / 2);
>>> 
>> 
>> Why 32?
> I guess I forgot got make it configurable. sch_fq_codel uses 64, but
> that seemed a bit excessive to me.

I'm not sure it's worth a configuration knob. It's basically an
arbitrary choice anyway, and only kicks in when an unresponsive flows
keeps flooding a queue to the point of overflow (if it's many smaller
flows the "never drop more than half a flow's backlog" should keep it
from being excessive).

This (hopefully) only happens relatively rarely and hitting it with a
really big hammer is the right thing to do in such a case to keep the
box from falling over. Not sure if 32 or 64 makes much difference; guess
it depends on the CPU-to-bandwidth ratio of the particular machine.

-Toke

