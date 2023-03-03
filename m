Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44BE56A91EA
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 08:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjCCHrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 02:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjCCHri (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 02:47:38 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDB1559F0
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 23:47:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id u9so6945648edd.2
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2GCLvOfV3o1z4+cPjzFkU7PaPl/lTR6YLqHM5Ks0Ng=;
        b=E4zlY7DmkdS2lX1Qjsf3I4UvU56f509peiw7WXLHMGF53RKMAR8w5AtaEPH5vhaJWq
         C2qb5kVSY9VSQyLFRnrp3zz4ULbV9UpYAn7rozWHaR1V5sXyA0EOSHsRkIyoN0955qZp
         NleGcIObW5LIGOOYSv6ejwZDsXmleCBrwd3m5qv6JS6yvnu6UMzZ2couOSl+c3FAh0FZ
         4+ETAXp8t0bCVH5KxabofYc/NcTcNp/EDgbEgnWFzDONfNHKMusJDzCZn/2VxwlVj2UU
         gsGR9dr6EQCe1hXQSV6tGXnaYUvSLQ4sIranAKx9X6lswRxnj6PVDL3+1P4oL2eBaMsS
         0W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2GCLvOfV3o1z4+cPjzFkU7PaPl/lTR6YLqHM5Ks0Ng=;
        b=034M9xlQ5YQGW5dAddE+fhp7OQUiwYnK9QLYwGkgqcNYwr90CoIsEmy2OHsOFLwoEd
         j42HqzNxF2ojB4mTMLWNp1aC0HjKRv15UeB+MPmgeY584VVzhzfWfUxXSp8ipNT3waI/
         vHVpyr6EiNnO3Ve0lzCU4OJRkFiT+W278hyomVxOhnDa5LLkiP+zJ+GBP+/23+0KEH6x
         u6A87U8ZfmHGDfYHvwwzoMQkCHojSwX0zciezBiTnZGxrXf2HnQxtN8FSW6vD/yvRtZG
         P8mDD63Lp7wxeLsBMeKLyfljyoUxV0tM5fEDL3p6Fso1baUd+vIfEkT7BRZh8FM4kouo
         xW5w==
X-Gm-Message-State: AO0yUKUXh1xZmGaO7cvrF44kkMS1KjTosCvns57X/66uzq1wIUHjVZpx
        WqAKGQotYGfd/VFiznL/Kqk=
X-Google-Smtp-Source: AK7set+7l/LyTQClpKdoT/NEfne0kGeOEXw+UA243WhIO7Y34Hds1oKQSLKurx0ugdgE21CAxlnzNA==
X-Received: by 2002:a17:907:20aa:b0:878:814d:bc99 with SMTP id pw10-20020a17090720aa00b00878814dbc99mr669907ejb.66.1677829640200;
        Thu, 02 Mar 2023 23:47:20 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f12d:d100:5541:da85:4cc7:7df9])
        by smtp.gmail.com with ESMTPSA id hy3-20020a1709068a6300b008e57b5e0ce9sm651269ejc.108.2023.03.02.23.47.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:47:19 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <12fce295c582793e662ca322b0d3ae3b461ddb24.camel@sipsolutions.net>
Date:   Fri, 3 Mar 2023 08:46:49 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE583386-CD66-4A60-B0AC-6E88968288D7@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-6-jelonek.jonas@gmail.com>
 <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
 <03B7A24C-D6E2-4DBB-B52D-6174539BB781@gmail.com>
 <12fce295c582793e662ca322b0d3ae3b461ddb24.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 28. Feb 2023, at 18:44, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Thu, 2023-01-26 at 17:53 +0100, Jonas Jelonek wrote:
>>>=20
>>> On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
>>>> @@ -4846,16 +4989,32 @@ static int
>>>> hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
>>>>=20
>>>> tx_attempts =3D (struct hwsim_tx_rate *)nla_data(
>>>>     info->attrs[HWSIM_ATTR_TX_INFO]);
>>>> + tx_attempts_flags =3D (struct hwsim_tx_rate_flag *)nla_data(
>>>> +     info->attrs[HWSIM_ATTR_TX_INFO_FLAGS]);
>>>> + sta =3D (struct ieee80211_sta *)txi->rate_driver_data[1];
>>>=20
>>> That seems dangerous - what if the STA was freed already? You don't
>>> walk
>>> the pending list or something if the STA goes away.
>>=20
>> Yes, I see. Is it in general a bad idea to take the sta reference =
from
>> ieee80211_control, put
>> it in rate_driver_data and use it for tx-status? I guess I should =
pass
>> sta to tx_status_ext whenever
>> possible because it is used for several statistics.
>=20
> Well you have to think about the lifetime. In most cases you do a =
lookup
> of the STA (under RCU) etc. but=20
>=20
>> I could think of two ways:
>> - add NULL checks for the case that the sta pointer might be freed as
>> you said
>=20
> How would that pointer even go NULL though? The pointer would remain,
> but the STA can be freed, no?

Yes, you=E2=80=99re right. Sorry, I mixed that up somehow.

>=20
>> - get sta by using, e.g., sta_info_get_by_addrs to get the sta if it
>> is available. However, this always
>> loops through the sta list. Might be a performance issue?
>=20
> It should use the hashtable?
>=20
>> Or do you suggest something different?
>=20
> Well you could keep it here and walk the list of queued skbs (?) when =
a
> STA is removed, and kill them all at that point, or something. Not =
sure
> it's worth it vs. the hash table lookup, this is just hwsim after all.
>=20
> johannes

That=E2=80=99s also correct. Sorry, I didn=E2=80=99t have a deeper look =
into this function at the
time of writing. So I guess I will stick to this for now.

Jonas


