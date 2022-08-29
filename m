Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85ECC5A5011
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiH2PTy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiH2PTw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:19:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1481121
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:19:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c7so3941817wrp.11
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=/bmC2sGXr3eAFuoiUJYx9l6wZp52JNSwjnT6lu4TLTU=;
        b=DB3P5cD+fAAC+R92BiAiXIqperLEM6Jk3ZLqpOGqqfqKCuzNvWPgqA3RIeyYXS7NVq
         /ElZxtTRArUgZG4NJnMfp62epIz4iYlUR5o2Uy43rdTfB4UopzLWlRFlZhHH1SpqJOr5
         NmpHBueraORxhRyPxYk2E9BTfhdvmqMCPtrdGvz/bdAHR2SuUQdwHQwV2oYNErF4LxYQ
         SyP1iaduGycxMmAbl8S/nY299nlmnNg76/CExRxdO9pGn9uVnKd9BrE7PjvQmjjUy1Ak
         VdJqiVb9LR+9DphGrMPa3dpMdFe3LwYMKlv11G89lWv3hHLU/UHIGKBoRonBoR1SDzrw
         4xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=/bmC2sGXr3eAFuoiUJYx9l6wZp52JNSwjnT6lu4TLTU=;
        b=rspmQJAoMSozbPS7UV5UL+tQmViRzJbyYHvs9CDl5uzbNmeIAO3qHwW3fQ0n/YGm7p
         XUqqa23zAkmHfwtH08DJCXTTC0rtIXRFSampQWW+HI60EuNMjSy5tkViSJjMAUKkhEc/
         YefkAYmNnmwwZ1D3O/D3Jc8RRfmywgNxPLz7GbW5kruarJTOYpfJUkW0ydvC9q8PUyeM
         A3zTnOsQxw1LldqeU3MBxjTuBV7jYyNZikIdFoJqJ+CI2cc8Z7kJ1rykq8wlXA/L+Iuq
         O3AqD14IJfIvwkTSwy9qZyCcjq7kEtau0BO7zt1Z8LEPBTXS4K2jG0MYVvwO3xPk6j2R
         fQ4w==
X-Gm-Message-State: ACgBeo0DatxbWuognt6awp3oqs/9EYSXRtqZQ/Q4AMloFwiZL+tAngMB
        l7nxHvTJNH1plJ5X/cNeuNI=
X-Google-Smtp-Source: AA6agR6foPnejju4PSvX8xsaSKfZUDqqlBuIOuCdFgEuMyx9RuY7ArwNKB9On10Er+rW3rb5+SxSgQ==
X-Received: by 2002:a05:6000:186f:b0:226:e045:aee with SMTP id d15-20020a056000186f00b00226e0450aeemr552217wri.677.1661786387305;
        Mon, 29 Aug 2022 08:19:47 -0700 (PDT)
Received: from smtpclient.apple (p200300c56f18a60054f4ba7ca0871a5f.dip0.t-ipconnect.de. [2003:c5:6f18:a600:54f4:ba7c:a087:1a5f])
        by smtp.gmail.com with ESMTPSA id a12-20020a05600c348c00b003a5bd5ea215sm9807832wmq.37.2022.08.29.08.19.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 08:19:46 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <50d80bebabe0ce2413af89af7bf45321ac7f0d6b.camel@sipsolutions.net>
Date:   Mon, 29 Aug 2022 17:19:45 +0200
Cc:     =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D322E049-6B08-402D-AB95-982363369028@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
 <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
 <8867d4a7552fc036da51ef5451ead1fd4df7f139.camel@sipsolutions.net>
 <50d80bebabe0ce2413af89af7bf45321ac7f0d6b.camel@sipsolutions.net>
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

Good point, definitely makes sense.

Would this be sufficient as an implementation for this RFC?

Greetings
Jonas

> On 29. Aug 2022, at 16:52, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Mon, 2022-08-29 at 16:52 +0200, Johannes Berg wrote:
>> On Mon, 2022-08-29 at 16:51 +0200, Thomas H=C3=BChn wrote:
>>>>>=20
>>>>> Compile-Tested: current wireless-next tree with all flags on
>>>>> Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
>>>>>       Kernel 5.10.137
>>>>>=20
>>>>=20
>>>> That seems just a little old? Not sure I'd trust that given the =
major
>>>> changes in the tree recently?
>>>=20
>>> Good point, we can test this with 5.15.63 by enabling the OpenWrt =
testing kernel =E2=80=A6 would that be ok ?
>>>=20
>>=20
>> Well a lot of major changes just happened 5.19 -> 6.0, so something =
more
>> recent would be better?
>>=20
>=20
> Maybe you could add support in hwsim?
>=20
> johannes

