Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8773B5F09E2
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Sep 2022 13:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiI3LTh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 30 Sep 2022 07:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbiI3LTB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 30 Sep 2022 07:19:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E744684A
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 04:06:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 615C3B82796
        for <linux-wireless@vger.kernel.org>; Fri, 30 Sep 2022 11:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4ECC433D6;
        Fri, 30 Sep 2022 11:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664535982;
        bh=RS6u7/s9E3KJmKrDVnrR+reGmDLlBgluzyRRImCz0C0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=oiKco4+X0ejzBFEzuQqExQSQ9jMy0tzxDYctehdBGuzQG9mF7rfQlqGAxF8FsINyC
         DYdBt0qClUMGxVq4nMmoxrk5N3+i7kdAp/DH/yEa09ZZ15mnKstza1FYmG0i1sARZQ
         7Wr27FMZKRF4F1ehHGqVriwuUk9sb/a/RvFD3OTGSoLsaGEmhUDA4/h3/v0a5fyJhU
         wNrv7l8/GupF4RKBgzE/eY4ig2aSQXjp88+RK8iS48PePcht8NhF71BzEcbDAbIenw
         wjXhbPWX+qvZmP+iLF/396QiY2kEjY3jszth6AnpYa85ssivtoA8SDI5VxmfeNy8f0
         rNwHeBMQ2u60Q==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 81A2264E248; Fri, 30 Sep 2022 13:06:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Alexander Wetzel <alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] wifi: mac80211: Use internal TX queues for all drivers
In-Reply-To: <4496641c-9f7d-a61e-78af-35e9bb7c3a40@wetzel-home.de>
References: <20220926161303.13035-1-alexander@wetzel-home.de>
 <87wn9ml0no.fsf@toke.dk>
 <4496641c-9f7d-a61e-78af-35e9bb7c3a40@wetzel-home.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 30 Sep 2022 13:06:19 +0200
Message-ID: <87v8p5jf4k.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Alexander Wetzel <alexander@wetzel-home.de> writes:

> <resend to all, sorry for duplicates >
>
> On 29.09.22 16:23, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>
> [...]
>>> diff --git a/net/mac80211/trace.h b/net/mac80211/trace.h
>>> index 9f4377566c42..cde169038429 100644
>>> --- a/net/mac80211/trace.h
>>> +++ b/net/mac80211/trace.h
>>> @@ -2301,37 +2301,6 @@ TRACE_EVENT(drv_tdls_recv_channel_switch,
>>>   	)
>>>   );
>>>=20=20=20
>>> -TRACE_EVENT(drv_wake_tx_queue,
>>> -	TP_PROTO(struct ieee80211_local *local,
>>> -		 struct ieee80211_sub_if_data *sdata,
>>> -		 struct txq_info *txq),
>>> -
>>> -	TP_ARGS(local, sdata, txq),
>>> -
>>> -	TP_STRUCT__entry(
>>> -		LOCAL_ENTRY
>>> -		VIF_ENTRY
>>> -		STA_ENTRY
>>> -		__field(u8, ac)
>>> -		__field(u8, tid)
>>> -	),
>>> -
>>> -	TP_fast_assign(
>>> -		struct ieee80211_sta *sta =3D txq->txq.sta;
>>> -
>>> -		LOCAL_ASSIGN;
>>> -		VIF_ASSIGN;
>>> -		STA_ASSIGN;
>>> -		__entry->ac =3D txq->txq.ac;
>>> -		__entry->tid =3D txq->txq.tid;
>>> -	),
>>> -
>>> -	TP_printk(
>>> -		LOCAL_PR_FMT  VIF_PR_FMT  STA_PR_FMT " ac:%d tid:%d",
>>> -		LOCAL_PR_ARG, VIF_PR_ARG, STA_PR_ARG, __entry->ac, __entry->tid
>>> -	)
>>> -);
>>> -
>>>   TRACE_EVENT(drv_get_ftm_responder_stats,
>>>   	TP_PROTO(struct ieee80211_local *local,
>>>   		 struct ieee80211_sub_if_data *sdata,
>>> @@ -3026,6 +2995,37 @@ TRACE_EVENT(stop_queue,
>>>   	)
>>>   );
>>>=20=20=20
>>> +TRACE_EVENT(wake_tx_queue,
>>=20
>> I know tracepoints are technically not considered API, but that doesn't
>> mean we *have* to break them if there's no reason to. And since the
>> actual contents is the same, how about keeping the old name as an alias
>> for this?
>>=20
>
> I don't understand what we would gain by an alias.
> For me it looks like an alias would just be confusing and never be used...
>
> Or why would anyone want to make additional calls to=20
> trace[_drv]_wake_tx_queue() on top what we have in the patch?
>
> I initially also considered to simply keep trace_drv_wake_tx_queue().=20
> (But that looked to be misleading.) If there is some reason to keep the=20
> old name I would just switch back to trace_drv_wake_tx_queue().

Well, the tracepoint is something that is read from userspace by
programs that want to trace the stack. The current one lives in
/sys/kernel/tracing/events/mac80211/drv_wake_tx_queue/

So if you rename it, any debug/tracing tooling that uses this will have
to be updated to use the new name. Which is not an ABI problem per se
(we exempt tracepoints from that), but it's also annoying if anyone *is*
actually using that tracepoint, so no reason to break things unless
there's really a compelling reason to...

I also thought the tracing subsystem had an alias mechanism built-in to
handle this sort of thing, but I think I may be misremembering this part.

> But when we are discussing that code anyhow, there is another related iss=
ue:
> I was not sure if it's ok to keep the renamed wake_tx_queue trace call=20
> in the old position. (In the section otherwise only having driver=20
> calls.) Having a better structured file did seem more desirable than a=20
> shorter patch, so I moved it.

I think I would lean towards just keeping it in the old position with
the old name for the reasons outlined above... This is not an incredibly
strong opinion, though, so if anyone has stronger opinions in the other
direction I can probably be convinced ;)

-Toke
