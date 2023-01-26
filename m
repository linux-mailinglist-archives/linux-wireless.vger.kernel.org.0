Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87DB67D22E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jan 2023 17:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAZQyY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Jan 2023 11:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjAZQyW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Jan 2023 11:54:22 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F535DC24
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 08:54:11 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vw16so6633284ejc.12
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jan 2023 08:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMqgyELLnC0C+2WUX5iqsLgbeN4/cYRY4wYf6RxgQL4=;
        b=DDmo9TGH0CWqvG2i//66W5nWHgVVuSWRsww7irkO0X77Klq4iYWeJD708lVLn6LhIj
         dM/8VJS45daXSZL5g76jWmlGHCjzQFWZxWCzzFoFhb3WhAQJ1vm73mzAn9ZGkAUGL6PC
         OLcT9NXE/Klhjmwhx0tIIBiKR7b+RRc6j3twae68a6XcSHA8vwQ93VApxzv3JOi2LRWG
         yF08KlsoSKGlOM8G+ON0AmcmOtOxf/ck9afGj+2Aj8Z/p0Pyj0SsGeICvL1wOLGByVvP
         4P65OePkDki6o0E0VyTEMTrDy6wtWFTULYBjjmf+NVQwr0sHWk9976oLZxpdV8wBAwo2
         AvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMqgyELLnC0C+2WUX5iqsLgbeN4/cYRY4wYf6RxgQL4=;
        b=OD0WX1Xygwm6ZY+/Xwsye/ZR83wGHYp7/wOoo4FtS52k02eQWKvdBTL+/8xxrya8PD
         RApz3ZziT4y1DY7JbCWhSTtrO4s3pE0wFgJJHWf6Xe9bpHIGIFi9VNIXJzlmxZJ923l4
         C17dX8EDM4tY3RZT6CNXDxOwyuCmEVT7yMbL67i5ycRyBG8EuMi5nw/y1uwmiLAsobkp
         Qg6qKy9FTkt7l2DPySxDptF47HCzmErTcceLnjM9Tu+111v7Pf7hQsFXXvj+pc4GaRVu
         3Zj201XuVj5PPTEWrOmOtlyf00c/4rXxKUDQzLi0ywOmQiyr7vkPk2xPshSHCcxXhn3G
         7W4w==
X-Gm-Message-State: AFqh2kppTxGjMV62bQy/SEfHG1iKjlezX9Ryj3IRl0F7kWfjRnyst8VP
        ItTrjHNp398VstrzkfiZvyE=
X-Google-Smtp-Source: AMrXdXvu6vQzi1nOC04Hd6ucVIwPHKaiX+xCedPf+mppYlWXdGAkUCKWCtAbaOFHkNlHDKdRgvdIKg==
X-Received: by 2002:a17:906:8618:b0:877:5772:25f with SMTP id o24-20020a170906861800b008775772025fmr33705722ejx.60.1674752049274;
        Thu, 26 Jan 2023 08:54:09 -0800 (PST)
Received: from smtpclient.apple ([2001:9e8:f12f:c200:289e:467c:f188:afa6])
        by smtp.gmail.com with ESMTPSA id bj14-20020a170906b04e00b00878a8937009sm110975ejb.199.2023.01.26.08.54.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jan 2023 08:54:08 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [RFC v2 5/6] mac80211_hwsim: add TPC per packet support
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <5d15d193c76dcc2cbd59b26912973e3bce34c776.camel@sipsolutions.net>
Date:   Thu, 26 Jan 2023 17:53:37 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <03B7A24C-D6E2-4DBB-B52D-6174539BB781@gmail.com>
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
>> @@ -4846,16 +4989,32 @@ static int =
hwsim_tx_info_frame_received_nl(struct sk_buff *skb_2,
>>=20
>> tx_attempts =3D (struct hwsim_tx_rate *)nla_data(
>>       info->attrs[HWSIM_ATTR_TX_INFO]);
>> + tx_attempts_flags =3D (struct hwsim_tx_rate_flag *)nla_data(
>> +     info->attrs[HWSIM_ATTR_TX_INFO_FLAGS]);
>> + sta =3D (struct ieee80211_sta *)txi->rate_driver_data[1];
>=20
> That seems dangerous - what if the STA was freed already? You don't =
walk
> the pending list or something if the STA goes away.

Yes, I see. Is it in general a bad idea to take the sta reference from =
ieee80211_control, put
it in rate_driver_data and use it for tx-status? I guess I should pass =
sta to tx_status_ext whenever
possible because it is used for several statistics.

I could think of two ways:
- add NULL checks for the case that the sta pointer might be freed as =
you said
- get sta by using, e.g., sta_info_get_by_addrs to get the sta if it is =
available. However, this always
loops through the sta list. Might be a performance issue?

Or do you suggest something different?

Jonas

