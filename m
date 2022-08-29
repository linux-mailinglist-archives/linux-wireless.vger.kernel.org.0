Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EBD5A4FF7
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiH2PPV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 11:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH2PPS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 11:15:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FC222B09
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:15:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m16so10573427wru.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 08:15:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc;
        bh=eb2xK2TBGaxA7bJGLTWxFduzhGTgxUYFBG2Zb62+v5g=;
        b=XupocN2NjVgSM1fkDjok8aOC1aONvGZeYuZXROn9vjVBeMDiOZGJEqGk5DsVvxIxWK
         +CEXaJY6olOFy49C/SS3MTa9in7ZOJxTP0gxvGx/LdHr4I4GnMxDh50u3Q0AupCzstm3
         NPPj2oZhnSTRILO5Vh/uyjKLNdVQ/L6QmxxIlPirnLGOoxi/NXT6q+LdvGNDnCUo/9zJ
         ggw7XPHvi5YQDWw+eZTA4F06rc/LNHoLfzumlqB/x69crfLrkTzaCwQWTbT/P2UHXFdh
         seMEF5hWOnMwAFdlkszxzjFoi1GWcDZhXFGmsiLKS1HvQ1hw5gM1+mK+tpolBIiOv8Np
         Do6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc;
        bh=eb2xK2TBGaxA7bJGLTWxFduzhGTgxUYFBG2Zb62+v5g=;
        b=JW22RnOhk1ksBsi+lLS5Ojq0VrsrKualZvweESuuIK0jOuxmt3/ctnjd9PBz96X8Vw
         C5vFRNqRAJtePc3yfb0vJg3qY6U+1ScCnKZxQsq0IFzMGqNeieTRy1+QwZizwd4ZTkEx
         Y3B0/i0Da7DkPP15Rt7WY/mYOCp7nMYtIt5Cd4HcRMT+PhTq76BpSKyItlc19AaDoMb2
         eabDVfSCP4BmF3KL9BkLfFWBb/NuMU6RPbte2he23rZk1IoeIfZjvHo9Z5/XTggusgod
         NdK7X8q6TuvQcPX812DQwy062XYdV55BHR4ZDeYwQH3vW/SCs44CbUIld378isAfzMqQ
         Cl1w==
X-Gm-Message-State: ACgBeo0KADbsS5mwLCHJhk8PCmxq9aeMHvthOAf4PJVUPkmDQeiu+2V6
        Vs2L0imat5YMr8Fet4RO32w=
X-Google-Smtp-Source: AA6agR7XlCH+fyJFhjmhvgZktjQlirm6zNvN3F1MNqA/a7IX2u3113rAHgZ9QhzOCUP9Nyh8NUcmEQ==
X-Received: by 2002:a5d:5955:0:b0:226:dac4:a713 with SMTP id e21-20020a5d5955000000b00226dac4a713mr3151087wri.245.1661786116352;
        Mon, 29 Aug 2022 08:15:16 -0700 (PDT)
Received: from smtpclient.apple (p200300c56f18a60054f4ba7ca0871a5f.dip0.t-ipconnect.de. [2003:c5:6f18:a600:54f4:ba7c:a087:1a5f])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600c2cc400b003a502c23f2asm9665407wmc.16.2022.08.29.08.15.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Aug 2022 08:15:15 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.100.31\))
Subject: Re: [RFC 0/4] mac80211: add TPC support in control path
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <8867d4a7552fc036da51ef5451ead1fd4df7f139.camel@sipsolutions.net>
Date:   Mon, 29 Aug 2022 17:15:14 +0200
Cc:     =?utf-8?Q?Thomas_H=C3=BChn?= <thomas.huehn@hs-nordhausen.de>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "nbd@nbd.name" <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E8EFC16-0702-4F02-8574-23DBE37C97C7@gmail.com>
References: <20220829144147.484787-1-jelonek.jonas@gmail.com>
 <5175b7f95442eff1f8e899feee3d3aeb330fb61e.camel@sipsolutions.net>
 <5AA24131-A7E9-451D-97AB-97D925B2A53A@hs-nordhausen.de>
 <8867d4a7552fc036da51ef5451ead1fd4df7f139.camel@sipsolutions.net>
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

I compile-tested with up-to-date wireless-next, should be 6.0?
Is this sufficient?

The changes in mac80211 regarding status path from me that were part of =
5.19
were manually included in my OpenWrt test, other changes not. We can =
definitely
try with the OpenWrt testing kernel as Thomas mentioned.

Greetings
Jonas

> On 29. Aug 2022, at 16:52, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Mon, 2022-08-29 at 16:51 +0200, Thomas H=C3=BChn wrote:
>>>>=20
>>>> Compile-Tested: current wireless-next tree with all flags on
>>>> Tested-on PCEngines APU with ath9k WiFi device on OpenWrt Linux
>>>>       Kernel 5.10.137
>>>>=20
>>>=20
>>> That seems just a little old? Not sure I'd trust that given the =
major
>>> changes in the tree recently?
>>=20
>> Good point, we can test this with 5.15.63 by enabling the OpenWrt =
testing kernel =E2=80=A6 would that be ok ?
>>=20
>=20
> Well a lot of major changes just happened 5.19 -> 6.0, so something =
more
> recent would be better?
>=20
> johannes

