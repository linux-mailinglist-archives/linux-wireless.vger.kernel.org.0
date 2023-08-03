Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE576E3CF
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 10:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbjHCI7u (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Aug 2023 04:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234208AbjHCI7q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Aug 2023 04:59:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3EE53
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 01:59:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B405361CE1
        for <linux-wireless@vger.kernel.org>; Thu,  3 Aug 2023 08:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED3C7C433C7;
        Thu,  3 Aug 2023 08:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691053184;
        bh=FOUSVlS4DmqKvFMq4nd0pwUYJjTJ5rOsM1GI0RE2orc=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=fctF0RjbY9Hkwv7bfIm3oJ9/22/8OaasWld4SyX1ghA22QVdk+rii5Lc/Lonhxs5b
         tfrLikiOTFmKdDnRuhMSZROcLDdJQgfyaLc6jL/1WkiqRw0+UJzBOpk/h//IIptOtX
         +BGIf8bHQKUbBzx14JQ58TcYLU+ZMYmi5jeI1JcB5S2vR2etu7xo1+ROLLrjQ0J17U
         roVvrikvzFb6pU7jjp1rgYaXBpfnQMtm+ruwomxklode2q3oVWayNcXSzT8BVCJ9nY
         IO0hVoGUaeAdN9mKuCZKOvKWXLFMbRyR6ss6pI2cijF2lERphQGB7MP0BMlKHueVFg
         FNcn7kRjq/w9Q==
From:   Kalle Valo <kvalo@kernel.org>
To:     Aloka Dixit <quic_alokad@quicinc.com>
Cc:     Wen Gong <quic_wgong@quicinc.com>, <ath12k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Subject: Re: [PATCH v5 06/11] wifi: ath12k: prepare EHT peer assoc parameters
References: <20230725224034.14045-1-quic_alokad@quicinc.com>
        <20230725224034.14045-7-quic_alokad@quicinc.com>
        <293dd873-1d9d-afc0-a122-48dfe4bb0fde@quicinc.com>
        <333fd74a-4178-3cef-5748-62a14ba2da5a@quicinc.com>
        <47396ec0-a0b3-8275-b29d-9ed72a9922cf@quicinc.com>
        <eac30246-1360-2854-3f53-28bdf5a24e24@quicinc.com>
Date:   Thu, 03 Aug 2023 11:59:40 +0300
In-Reply-To: <eac30246-1360-2854-3f53-28bdf5a24e24@quicinc.com> (Aloka Dixit's
        message of "Thu, 27 Jul 2023 09:59:14 -0700")
Message-ID: <87v8dwtsar.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Aloka Dixit <quic_alokad@quicinc.com> writes:

> On 7/26/2023 10:48 PM, Wen Gong wrote:
>
>> On 7/27/2023 12:38 AM, Aloka Dixit wrote:
>>> On 7/25/2023 8:43 PM, Wen Gong wrote:
>>>> On 7/26/2023 6:40 AM, Aloka Dixit wrote:
>>>> [...]
>>>>> +
>>>>> +static void ath12k_peer_assoc_h_eht(struct ath12k *ar,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ieee80211_vif *vif,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ieee80211_sta *sta,
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ath12k_wmi_peer_ass=
oc_arg *arg)
>>>>> +{
>>>>> +
>>>> This is the IEs of my AP below, then it will still entered into
>>>> this branch for my ath12k station mode.
>>>> sta->deflink.eht_cap and sta->deflink.he_cap is copied from peer
>>>> remote, for ath12k station mode, peer
>>>> remote is the AP. The field only_20mhz is only valid when the IEs
>>>> is from a station which only support
>>>> 20 MHz.
>>>>
>>>> I think the flag from_ap should be added here as well as function
>>>> ieee80211_eht_mcs_nss_size().
>>>>
>>>> Please correct me if wrong.
>>>>
>>>
>>> Okay, can you fix this in a follow-up patch?
>>> I don't have a device to test the station mode to verify a fix.
>>> Thanks.
>> The fix patch is simple like this (I have verified OK), you can
>> merge it to your patch.=F0=9F=98=81
>> It is to not use only_20mhz when ath12k is station mode.

Wen, please submit a follow-up patch which explains the situation
clearly. The reasoning for your change is not obvious for me. Also
consider if there should be a comment in the code.

> Every time I re-base the series I have to test, add cover-letter,
> change-log in 11 patches.

BTW you don't need to add a changelog on every patch. IMHO it's a lot
easier for everyone if all the changes are listed in the cover letter,
no need repeat that information in individual patches.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
