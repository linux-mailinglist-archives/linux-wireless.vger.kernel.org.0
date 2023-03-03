Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C026A91D4
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Mar 2023 08:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCCHml (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Mar 2023 02:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCHmk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Mar 2023 02:42:40 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A814980
        for <linux-wireless@vger.kernel.org>; Thu,  2 Mar 2023 23:42:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so6774847edy.8
        for <linux-wireless@vger.kernel.org>; Thu, 02 Mar 2023 23:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aj8kjdQPw/YsJiV+92+TdB1/h3eWFYLUKvsS6LssWVo=;
        b=ZeO6wyDMbDD51f9W51LF8klhNs6YHI/aJzpEjD3dToxQ/wSpvC/4JtjTeATxMkh0Lb
         FvZa9+rbsVEO3MFHlaQhagXS3IV45BYQ2hmh7/w35iaeyplfOreOw8mFTPYGv0iP+3yx
         VXeAxCUTuKsNBjoMf/tiAK02SCOsAM+KNqKosL6YX9nYeN4PW19eb1gX18xIpbNQijB2
         TJde0THN3wbAdgHL+baHUzlEkBCgdl0EMD/tK70v0S7bxQ6H5zHAFW315W2NwXlYom24
         5cKCMkdRRRrZ/TP0lmq0ydWfKlOfu667rGpHc4NnfmzanF4QB6V5U0q7o5+CbcX66ffN
         Fvjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj8kjdQPw/YsJiV+92+TdB1/h3eWFYLUKvsS6LssWVo=;
        b=kFXtbb82V2K739SZ6MkBVl6tuZdqI5DBVwXwFR2nJGK2NzQWq2xtQ+grXAaAZ0T/eR
         IMjKRJcAq/Qq3bxc4NV1PhpQL4XsJXck4FodcD8egB8rKo1z/SJotHj6jIIHDeCGtdLo
         lyzNCtQ78oF6Lzb7PA24+9k0aT7AP3aJowqJ1lpmJduIcqarUSo2UgnZ6tP3wUwgE6mT
         q0/mHvvt+alPHcD6SwgnyXbcGSi7GTSVnO66slZLvdh7a1iD44VmVdbBoNqhVAZVjjxO
         cxwbDXVf/JsFUQHXq7LTwgsh4ueJhxRQwHO/c1mOYN7kDkQMifliLNDxGIkbwv5IK7yl
         JdjA==
X-Gm-Message-State: AO0yUKXTAUOBTu4a6vVRUm3D3Atmq8nXjPh7sDNNx85zEZ+Btjh1NTc7
        wlC/txdtEMqS092Bw3jBMmw=
X-Google-Smtp-Source: AK7set8PjLF21F8zpsnUa+LYymTVDFY2Kj7Z1FF3QFI3QbtNtHHmAM5WdbhCJS69qtPnsgLrEJBPXw==
X-Received: by 2002:a17:907:5cb:b0:8b1:3a23:8ec7 with SMTP id wg11-20020a17090705cb00b008b13a238ec7mr825632ejb.43.1677829357944;
        Thu, 02 Mar 2023 23:42:37 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f12d:d100:5541:da85:4cc7:7df9])
        by smtp.gmail.com with ESMTPSA id u23-20020a50c057000000b004c19f1891fasm817972edd.59.2023.03.02.23.42.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Mar 2023 23:42:37 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <386f10e09c17b871df1c86ebc0c2af52938c6fb6.camel@sipsolutions.net>
Date:   Fri, 3 Mar 2023 08:42:06 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <08F35885-A18C-49C5-B5F5-9FC8F4BBD401@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-6-jelonek.jonas@gmail.com>
 <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
 <951FA42C-E52F-4FDB-AB73-AEF76435380C@gmail.com>
 <3e269bce8d73577fb1183697655d6ad66edf866f.camel@sipsolutions.net>
 <195E1629-BC72-4968-8E61-860C80F58D8B@gmail.com>
 <386f10e09c17b871df1c86ebc0c2af52938c6fb6.camel@sipsolutions.net>
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


> On 28. Feb 2023, at 18:41, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Thu, 2023-01-26 at 15:26 +0100, Jonas Jelonek wrote:
>>>=20
>>> However, I think that for new parameters, there's really no good
>>> reason
>>> to provide module parameters, since the test scripting etc. can
>>> dynamically create wiphys with the necessary capabilities. Even the
>>> hostap/hwsim tests can and do already do that :)
>>=20
>> =46rom what I=E2=80=99ve seen there is no dynamic parameter for RCTBL =
yet but I
>> can combine
>> this with my additional TPC parameter. Then this can be set via
>> netlink.
>=20
> Fair enough, but yeah, I think we should move to that.
>=20
>>> We already have netlink support for setting per-station TX power
>>> which I guess this should then listen to? See
>>> NL80211_ATTR_STA_TX_POWER_SETTING
>>> and NL80211_ATTR_STA_TX_POWER etc. I think it's not supported in
>>> mac80211, but probably could easily be after your patches?
>>=20
>> I guess that can be part of some follow-up patches after these =
patches
>> here are upstream.
>> I would agree that this should somehow listen to the mentioned
>> attributes then.
>=20
> OK.
>=20
>> We want to do joint RC and TPC in minstrel, and to allow fine-grained
>> TPC as it is already possible with RC. Minstrel will also be adjusted =
in
>> one of the next steps.
>> This RFC basically should =E2=80=9Cprepare=E2=80=9D mac80211 to be =
used for fine-
>> grained TPC. I think, driver support and Minstrel support should be =
the
>> next steps after the structures are fixed.
>> But I include hwsim here to have at least a test-case. Hope you get
>> what I mean :)
>=20
> Yep, seems good.
>=20
> I'm slightly worried we'll add this and never get to do the minstrel
> part, but hey.

This is also part of our research so we are going to either implement =
TPC in
minstrel or export this to user space. Our research also includes =
looking at
doing RC + TPC in user space with more advanced algorithms.

> Also, most modern devices no longer even use minstrel, so is it even
> worth doing at all from that perspective? What's in it for the users
> who've been using their devices for years (since newer devices in the
> past few years haven't used it, I think) without it?
>=20
> johannes

Our goal and hope is that, we explore that and then can show some =
benefits of
more advanced RC and TPC algorithm, so vendors like Atheros and Mediatek
may again expose the MRR capabilities to the mac80211 layer with future
chips. Afaik, the last Mediatek chips supporting mrr rate setting are =
mt76xx, which
I guess are still pretty common, so we are doing our work on still =
relevant hardware.

After having a short look at the driver code, it seems like more recent =
chips (in
particular Mediatek) at least kept support for controlling the TX power =
per packet.
I am not sure if it could be a good idea to split that up, not having TX =
power in the
RC table but somehow separate. Then you would be able to do TPC without =
RC.

Jonas

