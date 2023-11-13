Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 329B87E9F7B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 16:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKMPFF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 10:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjKMPFE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 10:05:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7989D51
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 07:05:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42C94C433C8;
        Mon, 13 Nov 2023 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699887901;
        bh=cxxt0RjIfFF/CZhpHwC7zVqe2rTl2Bif9faDu5W+QQo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=YXPy9grA/RP4gMtMDyE9Xj44btD0R5Xy2oTYOU7P03GZ7MngwvlFRa6jyQ5TL9P4M
         5s6g4vkxg5uShUwBhspOZlzivnwWp2cXUu0Ka5tpRaEBUS+5TmmTFThQim6xAeKEMu
         1041lup5dheOQRc9VfWYVcilZWlUq4E+CkMRsbBuR4/uMLwK/eMB6eEEZXeF6C4KbX
         6qSssX5F+xgt7z9bosHgtA+fa898erKOh+FgmOyrVBl7ElckBWqu6ndTwlQUYtEd5h
         6ymtIcmv7M2XSsbVnYS7nSuRS38TXNIbNqMRSGhv3m6MGJrmyyqqNRNFTbdqDQ13jF
         C8J/Cr3vZuKog==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Baochen Qiang <quic_bqiang@quicinc.com>, <mhi@lists.linux.dev>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH RFC 4/8] wifi: ath11k: remove MHI LOOPBACK channels
References: <20231110102202.3168243-1-kvalo@kernel.org>
        <20231110102202.3168243-5-kvalo@kernel.org>
        <f56bce13-bba8-40d2-1dfc-210478ff63d6@quicinc.com>
        <e2ad1380-d55f-42bd-9f40-ef8aa6e0f105@quicinc.com>
        <818fddb9-b59e-7a6f-6605-2ba016d0db60@quicinc.com>
        <87msvhu4d5.fsf@kernel.org>
        <fb3709a6-95d2-711f-3ca1-0107fa159c62@quicinc.com>
Date:   Mon, 13 Nov 2023 17:04:58 +0200
In-Reply-To: <fb3709a6-95d2-711f-3ca1-0107fa159c62@quicinc.com> (Jeffrey
        Hugo's message of "Mon, 13 Nov 2023 07:26:46 -0700")
Message-ID: <87il65u21x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeffrey Hugo <quic_jhugo@quicinc.com> writes:

> On 11/13/2023 7:15 AM, Kalle Valo wrote:
>
>> Jeffrey Hugo <quic_jhugo@quicinc.com> writes:
>>=20
>>> On 11/11/2023 9:24 PM, Baochen Qiang wrote:
>>>
>>>> On 11/11/2023 12:54 AM, Jeffrey Hugo wrote:
>>>>> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>>>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>>>
>>>>>> There is no driver to match these two channels, so
>>>>>> remove them. This fixes warnings from MHI subsystem during suspend:
>>>>>>
>>>>>> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
>>>>>> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
>>>>>
>>>>> This feels like just masking a real issue.
>>>>>
>>>>> If LOOPBACK is not being consumed, then the channel should never go
>>>>> into the start state.=C2=A0 Why would we be trying to transition to t=
he
>>>>> reset state then?
>>>>>
>>>>> -Jeff
>>>> That is because, with patch 'bus: mhi: host: add new interfaces to
>>>> handle MHI channels directly' in this patch set, ath11k is able to
>>>> call mhi_unprepare_all_from_transfer(), which will reset all
>>>> channels.
>>>
>>> that implementation is flawed if it is causing this.  Looks like you
>>> never check to see if the channel was prepared in the first place.
>>>
>>> If you go fix that, then it looks like this change is not needed.
>> BTW what do these loopback channels do? I didn't notice any
>> difference
>> in the functionality so I'm wondering the reason for these.
>>=20
>
> The loopback channel is defined as a service where any data the host
> sends to the device is immediately sent back to the host, unmodified.
> The typical usecase is smoke test and performance profiling.

Thanks, good to know. We don't have any such functionality in ath11k
right now and if we ever do we can always add the channels back.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
