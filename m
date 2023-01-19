Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68D0673C16
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 15:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjASOd5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 09:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjASOdL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 09:33:11 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF607ED4D
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:33:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mp20so6137524ejc.7
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 06:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VcPWjJPgl7HftJHud9CH91iS7Ep25TtN8lRguvZRh3U=;
        b=FNaUYX2hjH8/TSLCbBHsWDNEcIDYcbkKnFhfLADFnipZCgMz8P6KxXUYGhxgS76QcV
         W8ng1Xm410Rsxw2Se3l0teOM9qg/X5tvgLBx0j4r/prmoFNhgjq5hg9/cMGmH7gxT7gK
         RlqT9tg2KwjJZC3EjWeuKPDXmqx4xwrh2V/X6mwyC+wR/RaaQQ3H+WgZyg4q6aHxUCOs
         VsFVBLqMxUBNzI7MseJGYsbUs5Lm5MdluNDQ6+roEicSqrER4GuSfjDk5AGnBLdvJj7u
         8zFn4L4hJPiGIuQz89lDkWEnylJKS1w/eGrfZ9l+dNl167xDDVpbKKvYukjS0CT6RFmi
         vD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VcPWjJPgl7HftJHud9CH91iS7Ep25TtN8lRguvZRh3U=;
        b=JqIqn8SXjhIkqB8dTrSpu3BCzX71xAbSjtkyi9pwp7N/wyuXwA3yTo/R8u5dIGBsn8
         HBQQ1d5CO75ZWIKkIF7G4Cq0xslWoYBRGEhQrN22MgfRyi4xL6MFQDqtG8gIahkXkXvH
         TYUY6TR9NZ6A1Z5QUgXMCBwXsAvfB+PWNrslU3oNRXP5bU5s3hqviLopFlH4nwTdGUuO
         Rh3+PQEzfeH652caDvdOiEUDIj/3EmTiqkBHv7PyQklwn7bTJ5vJ0KFcAnLx1LsYr9ES
         7YFYYbLlwoARGVXXljNSblY0OXpLGBqQd1ypsYCxPr9Y//TVSc7fPsYxv+jCCgGjW5WI
         FljA==
X-Gm-Message-State: AFqh2krnxf8zRPgovDfYdyqiuCnL9qEykSZwlFSaynaCq6wPWB+mqUq3
        vp6raWaJdDKIcjMUNl+7O/95HtRq6Xc=
X-Google-Smtp-Source: AMrXdXuTf0tgryY05ZBVW++u45hkXCA8R049SP7UNW5mQJW+Gasx5Hpu4r7YC/+u/v8lOtiC5BDSYQ==
X-Received: by 2002:a17:906:cb95:b0:86a:addf:880a with SMTP id mf21-20020a170906cb9500b0086aaddf880amr10920859ejb.65.1674138789047;
        Thu, 19 Jan 2023 06:33:09 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f13d:5500:8810:952c:6d58:93ff])
        by smtp.gmail.com with ESMTPSA id kv23-20020a17090778d700b008699bacc03csm8996673ejc.14.2023.01.19.06.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:33:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
Date:   Thu, 19 Jan 2023 15:32:37 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <951FA42C-E52F-4FDB-AB73-AEF76435380C@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-6-jelonek.jonas@gmail.com>
 <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 12. Jan 2023, at 11:31, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
> On Tue, 2022-09-20 at 12:40 +0200, Jonas Jelonek wrote:
>> Enable RC_TABLE in hwsim for TPC support and replace the
>> ieee80211_tx_status_irqsafe calls with regular =
ieee80211_tx_status_ext
>> calls to be able to pass additional information, i.e., tx-power.
>> Add some variables, members and functions in both tx control and tx
>> status path to pass and process tx-power.
>>=20
>> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>> ---
>> drivers/net/wireless/mac80211_hwsim.c | 175 =
++++++++++++++++++++++++--
>> drivers/net/wireless/mac80211_hwsim.h |   1 +
>> 2 files changed, 168 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/drivers/net/wireless/mac80211_hwsim.c =
b/drivers/net/wireless/mac80211_hwsim.c
>> index df51b5b1f171..a56fb2505047 100644
>> --- a/drivers/net/wireless/mac80211_hwsim.c
>> +++ b/drivers/net/wireless/mac80211_hwsim.c
>> @@ -57,10 +57,15 @@ static bool paged_rx =3D false;
>> module_param(paged_rx, bool, 0644);
>> MODULE_PARM_DESC(paged_rx, "Use paged SKBs for RX instead of linear =
ones");
>>=20
>> -static bool rctbl =3D false;
>> +static bool rctbl =3D true;
>=20
> should we really change the default?
>=20
> Is there a netlink control to set it for newly created wiphys?
>=20
>> module_param(rctbl, bool, 0444);
>>=20
>> +static int tpc =3D 0;
>> +module_param(tpc, int, 0444);
>> +MODULE_PARM_DESC(tpc, "Support transmit power control (TPC) (0 =3D =
no,\
>> + 					1 =3D per packet, 2 =3D per mrr =
stage)");
>=20
> Not sure I like this either - I think we should probably create the
> wiphys dynamically for most features these days?

just to make sure I got it correctly: so you propose that these params, =
that are=20
currently done with module_param(), should be switched to a dynamic =
netlink approach,
or only for TPC and RCTBL for now?

As a first step I focused on providing a proof-of-concept implementation =
in hwsim for my
TPC proposal, implementing netlink to set tx power and other could be =
part of the next step.
Do you think this could be fine or do you propose something different?

(all other comments from your side I will fix in v3)

Jonas=
