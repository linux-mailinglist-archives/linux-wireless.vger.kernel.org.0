Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2716B7E9E56
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Nov 2023 15:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKMOPK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Nov 2023 09:15:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjKMOPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Nov 2023 09:15:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853FCD4C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Nov 2023 06:15:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F321EC433C8;
        Mon, 13 Nov 2023 14:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699884906;
        bh=y1OMZ6z7efDhKj1vsokZwE/dfo0DW7No+kNt4zr/hMA=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=W6ijUz7t8wqqkvA4nNp8oJE1agaJUXkRQBBsP8k1HL8FXbHJAT7DbjYYosBg2Rj+r
         wsOed5P5VP1NobrIAd32YKDp77ZwSdWv0qtg1IeBcOy6Est+KeI9qIGxoXkQd+lqSe
         Rhhy8QboGRBOzxmeVy103L8BEVNmMkEzKw0JeB1ZYXZNrplw3b2jvv7wKlnR5ccr3d
         l8/CK0E34OOiH57X7Wjz/q/OpLq+a3Z9TP42z27CSnHuculfzcEgTVGyXq6VjKoTVl
         JtVRKkWMyIFmHqaOYxrGmM3Wz40d3l3vzseWNI1lou0aFZS1u93HDZV6g6ukXYOalr
         12WXmxxiowGHQ==
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
Date:   Mon, 13 Nov 2023 16:15:02 +0200
In-Reply-To: <818fddb9-b59e-7a6f-6605-2ba016d0db60@quicinc.com> (Jeffrey
        Hugo's message of "Sun, 12 Nov 2023 09:15:40 -0700")
Message-ID: <87msvhu4d5.fsf@kernel.org>
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

> On 11/11/2023 9:24 PM, Baochen Qiang wrote:
>
>> On 11/11/2023 12:54 AM, Jeffrey Hugo wrote:
>>> On 11/10/2023 3:21 AM, Kalle Valo wrote:
>>>> From: Baochen Qiang <quic_bqiang@quicinc.com>
>>>>
>>>> There is no driver to match these two channels, so
>>>> remove them. This fixes warnings from MHI subsystem during suspend:
>>>>
>>>> mhi mhi0_LOOPBACK: 1: Failed to reset channel, still resetting
>>>> mhi mhi0_LOOPBACK: 0: Failed to reset channel, still resetting
>>>
>>> This feels like just masking a real issue.
>>>
>>> If LOOPBACK is not being consumed, then the channel should never go
>>> into the start state.=C2=A0 Why would we be trying to transition to the
>>> reset state then?
>>>
>>> -Jeff
>> That is because, with patch 'bus: mhi: host: add new interfaces to
>> handle MHI channels directly' in this patch set, ath11k is able to
>> call mhi_unprepare_all_from_transfer(), which will reset all
>> channels.
>
> that implementation is flawed if it is causing this.  Looks like you
> never check to see if the channel was prepared in the first place.
>
> If you go fix that, then it looks like this change is not needed.

BTW what do these loopback channels do? I didn't notice any difference
in the functionality so I'm wondering the reason for these.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
