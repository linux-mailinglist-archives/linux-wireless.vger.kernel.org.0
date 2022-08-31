Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696275A8175
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Aug 2022 17:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiHaPj2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Aug 2022 11:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiHaPjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Aug 2022 11:39:23 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435ACD8E2A
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 08:39:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id bu22so18459969wrb.3
        for <linux-wireless@vger.kernel.org>; Wed, 31 Aug 2022 08:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=7AKoARXo4D2U2mZ+5qIvHpQRNSH57VG99vu5m4/Q91U=;
        b=iyJU16qiPLVDK4cz0VdfoK4O97jjk8D8tcHzro9G8wMrOmF7h2mJAHgAelNOwS1qLm
         Lst4yifv1vxcD4uDJSOslZo/wU3E+7w+2q/2i3t1XeX0zUoTWFNRWaFLI1JRaMT9mmTR
         AFtVuM3NZKp+8cuZqu5T4xk9AzlXay8hp8zteQkASZR8j21eoD7w/t1wSix5hbnXs13t
         PpD+GEMOAJUFp2WO144gg6cuASFcAIaBkwWUoHjA5dcrL4/seNJxp0knlASDSN8mqNf9
         UKfRQ73+oZf8ny6lYbZ2NcG2fWGcVUWjjBKiMtETuYGjCfzV11qbQMxFqfHqaLtaTZD1
         z9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=7AKoARXo4D2U2mZ+5qIvHpQRNSH57VG99vu5m4/Q91U=;
        b=yEWY1ZI08i+DdggXpJmFH35NDzSLJ2IOQn6dEKwl7LqKplsoTFG4FfaM7McEiATo1Z
         z8s/ARJw0wRbWWKA44BVULdQkGdBIRYaExUSN4NpE7oYZytIKwh7xuwDkZOuJitGtoKp
         G3Qea4QnqtOQAKfezKOT7SO81OsiP0ojAj1nQShcP7AmGgzQR+i0ItOScoRO8iqCc6p5
         nOjrslpL6vy2xrzewqFyOGOcobgpj8j/XMCDWXrskGpiROFO3uumN7TtNQDK6Nw86vKM
         FzRlqoxRo85NweOh7Yav65vGnBJ25SjqwkBEY2mOZdVLVKl4hBD4ThS7YV8XfZmtBXYl
         ye9A==
X-Gm-Message-State: ACgBeo0hHXbyMjG00PxTJXRxy2zc612yj3RWQ/bRN/9epWAWPNqO+jCL
        r47TZK6EvDa7SCd6C8GiCLU=
X-Google-Smtp-Source: AA6agR58zZbs8K3Aq24uWLNLtNKfkZab1RwpohGdVvMVaeFDQItfhSovu5A+bfUps5a/TP0cdL8Rqg==
X-Received: by 2002:adf:ab0e:0:b0:226:d4ed:840c with SMTP id q14-20020adfab0e000000b00226d4ed840cmr10036598wrc.111.1661960359509;
        Wed, 31 Aug 2022 08:39:19 -0700 (PDT)
Received: from smtpclient.apple (p200300c56f185400edcb108dfd391000.dip0.t-ipconnect.de. [2003:c5:6f18:5400:edcb:108d:fd39:1000])
        by smtp.gmail.com with ESMTPSA id q185-20020a1c43c2000000b003a5f783abb8sm2460207wma.30.2022.08.31.08.39.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Aug 2022 08:39:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <c9befe233be586eb2c949f7301784e948c3a6683.camel@sipsolutions.net>
Date:   Wed, 31 Aug 2022 17:39:17 +0200
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0EF20938-8E10-4846-B280-37054898441A@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <467218ec220ea6e36b4222efc5c46e4e350fe1ea.camel@sipsolutions.net>
 <CE871D89-B996-4D8B-8C65-7C53382C30D8@gmail.com>
 <7CFDCFCC-A369-4F41-90E1-A26591C20D92@gmail.com>
 <c9befe233be586eb2c949f7301784e948c3a6683.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3696.100.31)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 31. Aug 2022, at 16:22, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> Sorry I dropped out of the thread - busy with other stuff. I'll reply =
to
> other mails later.
>=20
>> I am working on the hwsim support right now, tpc support in hwsim=E2=80=
=99s
>> control path is implemented.
>> However I encountered a problem in the status path. Hwsim seems to
>> hand over to mac80211
>> tx-status asynchronously via ieee80211_tx_status_irqsafe only. There,
>> the skb is added to
>> ieee80211_local->skb_queue and then dequeued in
>> =E2=80=98ieee80211_tasklet_handler=E2=80=99 to be passed
>> to =E2=80=98ieee80211_tx_status=E2=80=99. For tx rates this is =
sufficient, but there
>> is no space left in=20
>> ieee80211_tx_info->status to pass the tx-power per packet.
>> Please correct me if I missed something in the code.
>>=20
>> My idea to solve this may be: to use the SKB extension (struct =
skb_ext
>> *extensions) to pass the=20
>> tx-power information (and maybe more) for each SKB. Could this be an
>> appropriate approach or=20
>> do I miss something here? Maybe someone who is much more aware of the
>> mac80211 layer=20
>> design does have a better idea for this?
>=20
> Is it even an issue to switch to ieee80211_tx_status_ext()? The =
context
> here looks OK, although it might lead to (too?) deep call stacks.
>=20
> I don't like the _irqsafe() versions anyway =E2=80=A6
>=20
> johannes

I am not sure about this _irqsafe() thing, just assumed there is/was a =
reason they
are used instead of the normal ones. Would definitely be the easier =
option to
have ieee80211_tx_status_ext() for this RFC and future extensions. I =
could have
a closer look into this, or someone else knows if this could cause an =
issue. Same
for call stack depth.

Greetings
Jonas=
