Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280774B1541
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Feb 2022 19:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241648AbiBJSaf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Feb 2022 13:30:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiBJSad (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Feb 2022 13:30:33 -0500
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99B3CED
        for <linux-wireless@vger.kernel.org>; Thu, 10 Feb 2022 10:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
        References:In-Reply-To:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=RnejDyICd41o3AsAHHyokRD1qRwr65iyd0n+lZytnKI=; b=HKPfcWvRpi+P4dnYZw4eJmH4ku
        wN2DeGGMG3jqOt4lhty/liR1vGlKPgvULddDzNhI2wfnVKv7hwsBVxwLvsjYUTPxEWGYskSWSVxNA
        0LrQ3JtIRt7KYVL13WbaMYpAYEVWlb8kv6KHPdNJQAyjJdUt2ag5R38jDkOlzfSw4NHJX2peAhf4/
        c9lWVjMcWWp8LGiQU3kiQJ9TCS5HfUKzT3g23Vp+qLTdrLcqIgHXpzfVNr34cDtH71phYws69oIhm
        MQ2mlvByaUIYwLE7ItVTyemXoQjAKZtM0RW1d7fDSH3heGL7SRFoNJrxWxQ/5s3e982jelb43TpQK
        ZBjiL/LA==;
Received: from [199.119.233.246] (port=15398 helo=dummy.faircode.eu)
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nIEDD-0002iA-Jn; Fri, 11 Feb 2022 05:30:32 +1100
Date:   Thu, 10 Feb 2022 18:30:27 +0000 (UTC)
From:   James <bjlockie@lockie.ca>
To:     =?UTF-8?Q?Gabriel_F=C3=A9ron?= <g@leirbag.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Message-ID: <0c54c718-4a05-4c30-af31-c5a13698ec77@lockie.ca>
In-Reply-To: <MvZhCUx--3-2@leirbag.net>
References: <MvV0sOB--3-2@leirbag.net> <ffa205c1-710b-44a3-8c05-7a53767472fd@lockie.ca> <MvXu039--3-2@leirbag.net> <d13300bc-4213-4e7e-bb74-4c219ea8025f@lockie.ca> <MvZhCUx--3-2@leirbag.net>
Subject: Re: Disconnection every 10 minutes with mt7921e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <0c54c718-4a05-4c30-af31-c5a13698ec77@lockie.ca>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's an in-kernel driver so it should be stable.
Maybe downgrade to the latest release kernel.

No problem about not replying to the list
I'll readd the list.

Feb. 10, 2022 12:36:07 Gabriel F=C3=A9ron <g@leirbag.net>:

> I've tried already, but it didn't work. There's also generally loads of p=
roblems with either the driver or the firmware, like panic on reboots or ev=
en sometimes the device is not detected and you need to do a cold boot.
>=20
> Anyways, first time I posted to a mailing list and I ended up answering t=
o you only, sorry for that :)
>=20
> Cheers!
> 10 Feb 2022, 16:12 by bjlockie@lockie.ca:
>=20
>> Maybe turn off power saving?
>> I don't know how but I think "modinfo mt76" will show the parameters.
>> Googling will help. :-)
>>=20
>> Feb. 10, 2022 04:12:48 Gabriel F=C3=A9ron <g@leirbag.net>:
>>=20
>>> In my case, I don't think so. I tried with a Intel ac9260 and don't hav=
e the problem. This is also with a regular household AP that's basically ev=
erywhere in Germany (FritzBox) and no other devices have similar issues - I=
 could be wrong, though.
>>>=20
>>> Feb 9, 2022, 23:48 by bjlockie@lockie.ca:
>>>=20
>>>> I also get disconnected (by AP) reason: 2: Previous authentication no =
longer valid but on an Intel ax200 (built in my Intel laptop) but networkma=
nager reconnects.
>>>> I wonder if it is problem with the infrastructure.
>>>>=20
