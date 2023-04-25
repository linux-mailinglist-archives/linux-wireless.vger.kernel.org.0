Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCE46EDAE2
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Apr 2023 06:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDYEPL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Apr 2023 00:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjDYEPJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Apr 2023 00:15:09 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81667AA8
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 21:15:08 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-187d9c2071fso3943601fac.1
        for <linux-wireless@vger.kernel.org>; Mon, 24 Apr 2023 21:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seqtechllc.com; s=google; t=1682396106; x=1684988106;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hbbI51bdQ3Q0/kLqloL1Uj7FBsbC577RXN2T4Dzhf4A=;
        b=gIoZpU9IoRVClqc7uD2+dLg9ewnOWwVqnSBp/Ta2G73lrW/QpgaGr9GZXeBvc2TM4y
         MmeXam6Q/7uqCOf/TIM3QO34J+SCnsPyhpnw9tNXkyGN9oiBV0Jtxxw2YOUybBdM3eYg
         BtfrFfKzeF73RiH4wGn4ja2xXJ96QceRfV9bRBsKNpGZKFrNioiCjAK9iBXhgyYRdHv1
         MsCyZlbcG6J+uprP3K4deZ8lV4P/4ls1EmNOrBGYtMbTVOH7FDtZ/XOQUiN0rkztvGI1
         YKetgxziym3VaKpC32oU6CGtd8jVTLuywC/cPGGIWcOtABPfkkImuHZj4ZdFyMy5DC2L
         PVdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682396106; x=1684988106;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hbbI51bdQ3Q0/kLqloL1Uj7FBsbC577RXN2T4Dzhf4A=;
        b=c1V8fwBkXlyayBXb8NzBn5YQCx1AydG+jEpsU0uLrKiDWzByTBzekJoxT1Qe0CesAI
         o/PpCoqxEeNilfBB1z0jqug9+T5tnSZBBdoiFRWA+6ZpArK5Q0bIMAwrp8x1LCKgod4/
         Jclb22scn0N2uq14WB/N2uQVaCEcWHcCXnWNuiqHQ3/QGfYxXA1D0v7bGZHCYUIsrgej
         67oC5W8WZUegHkbLEkZV+Dd4mD8Q7Ic0Zu9Cs2zdP834SLRUKxVvfYKw4t1otn0Q6ptT
         NOm/p4lFfXfvShy2AjsgBKxo0KvGXGyYGit9SKcnZaxUoXgYPCxsaUGav9j10/OxHrm+
         xRZA==
X-Gm-Message-State: AAQBX9dmQxpnEJUv7dfAuKo8RAfxQyIwc+tHeDN8EG1ljqStFsMstL3+
        dQCmLI9RLby2dtIP37rJzp+JwlJGieLfsbp4FCYNDU7/0oS4HdS+qwUqkOug1lDY17UoLZBKevl
        3dWt0dNrTvJResvTvzZi6zG4jh74+KsjDEsmjwSEU/1K1kaGKx6pjPc767nOXGW+WH6gUPxTUxX
        Os518KNSFMMpUBYkdjVCpBhyoM7zBvFJ4lJAok+BIafdNi/4UfB/lVZw==
X-Google-Smtp-Source: AKy350b1Z5mwvVMZOXSBL53fjlxX7oV/9nPbNkEW7DU4tXp/76XSqa4deRZwwfkpnM6w9mSEh5Wp4Q==
X-Received: by 2002:a05:6870:c18d:b0:172:7fc0:9188 with SMTP id h13-20020a056870c18d00b001727fc09188mr11237977oad.35.1682396106682;
        Mon, 24 Apr 2023 21:15:06 -0700 (PDT)
Received: from smtpclient.apple (ip72-210-108-150.tu.ok.cox.net. [72.210.108.150])
        by smtp.gmail.com with ESMTPSA id h2-20020a056870d34200b0018487819c58sm5218877oag.30.2023.04.24.21.15.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2023 21:15:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.500.231\))
Subject: Re: pull-request: wireless-next-2023-04-21
From:   Gregg Wonderly <greggwonderly@seqtechllc.com>
In-Reply-To: <e31dae6daa6640859d12bf4c4fc41599@realtek.com>
Date:   Mon, 24 Apr 2023 23:14:53 -0500
Cc:     Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92FFD14B-6BE0-4AC1-9281-A37508817A3B@seqtechllc.com>
References: <20230421104726.800BCC433D2@smtp.kernel.org>
 <20230421075404.63c04bca@kernel.org>
 <e31dae6daa6640859d12bf4c4fc41599@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
X-Mailer: Apple Mail (2.3731.500.231)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Could this be expressed in a /proc structure of files and directories?

Gregg Wonderly

> On Apr 24, 2023, at 9:41 PM, Ping-Ke Shih <pkshih@realtek.com> wrote:
>=20
>=20
>=20
>> -----Original Message-----
>> From: Jakub Kicinski <kuba@kernel.org>
>> Sent: Friday, April 21, 2023 10:54 PM
>> To: Kalle Valo <kvalo@kernel.org>
>> Cc: netdev@vger.kernel.org; linux-wireless@vger.kernel.org
>> Subject: Re: pull-request: wireless-next-2023-04-21
>>=20
>> On Fri, 21 Apr 2023 10:47:26 +0000 (UTC) Kalle Valo wrote:
>>> .../net/wireless/realtek/rtw89/rtw8851b_table.c    | 14824 =
+++++++++++++++++++
>>> .../net/wireless/realtek/rtw89/rtw8851b_table.h    |    21 +
>>=20
>> We should load these like FW, see the proposal outlined in
>> https://lore.kernel.org/all/20221116222339.54052a83@kernel.org/
>> for example. Would that not work?
>>=20
>=20
> That would work, and I think struct fields addr and val should be =
__le32.
> And, I have some draft ideas to handle some situations we will face:
>=20
> 1. upgrading to newer driver without built-in tables will break user =
space
>   if people don't download table file from linux-firmware.git.
>   Maybe, we can keep the built-in tables and support loading from =
files
>   for couple years at least.
>=20
> 2. c code can do changes along with these tables, so driver should do =
some
>   compatibility things for register version.=20
>=20
> 3. The file contains not only simple registers tables but also TX =
power tables
>   and power tracking tables. These tables are multiple dimensions, and
>   dimensions can be changed due to more channels are supported, for =
example.
>   To be backward compatible, we need to add conversion function from
>   v1, v2 ... to current.
>=20
> I will think further to make this change smooth.=20
>=20
> Ping-Ke
>=20

