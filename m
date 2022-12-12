Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162E164A80B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 20:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiLLTTu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 14:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiLLTTt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 14:19:49 -0500
Received: from titan.fastwww.net (titan.fastwww.net [15.235.10.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBD0B92
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 11:19:43 -0800 (PST)
Comment: DomainKeys? See http://domainkeys.sourceforge.net/
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=default; d=lockie.ca;
  b=Hwmj2QWXtHO98DJPQZOnQfkTtYl7gPPFbzhe2kovrg4ZQz5fYQdRMq2o7P5YtBdJybnaF09ZjcnkS16tD0WtIYr4a1STOfV7r0tDZeWdxp7i4sIC/H9f1Vwk3RRaMyZl3SBMJpfdw2RZ2WVayYzmpHw2Kv1FJfdu3BQCeFChfbq+90Yjd9zMz9kd//oVmjPz/1kLl0Q4+XzfFnVWhvGwVjulpgt9ZUE0vSsr3oYfGzkKrdmJPimDvxbS//3wvU1e0qi2rAzybCPD5VgmF3+4CMzblSo5D3KXZwc4ky6R8/LFW8V0lRGOdPd59/KJjNj17u5ugEqWg1H2gl6YYHPyYQ==;
  h=Received:Received:Received:Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Correlation-ID;
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=lockie.ca; h=date:from:to
        :cc:message-id:in-reply-to:references:subject:mime-version
        :content-type:content-transfer-encoding; s=default; bh=vjRZOlPbG
        eNrlXc60+ZOGkAGSpI=; b=wf3VBMTyn8v1OOPQG+QNWRfMS6mt0ydk3acVVxF1g
        umnl6WraPgLyy34oNIebPGojsh3zT6+3mjAlf6j4AQoJD/HrstU5WgdHpr5ndStX
        Ls5DiSxH0HjEnxD1VkB7y5T5aFvZe2Vla7N3TQcqWjY78dFqZ/KPIYBM9sQd1zle
        jE6d2LMGOo1XuaoM6Fy1+YCWJoqawbvGdULRKADBNW1mSSs6BCqRJ7o4d+Ku+npn
        JlBFzdVTcYOKExTxK+9JB4v4iGK3umrUvs62ErrNZimqEaMK49a307QCZN7DyTI+
        CY66D2UxSiEwtgiTzUtswEWUq46zpfy4jvqWOGDWay4KA==
Received: (qmail 24918 invoked by uid 108); 12 Dec 2022 19:19:41 +0000
Received: from unknown (HELO titan.fastwww.net) (127.0.0.1)
  by titan.fastwww.net with SMTP; 12 Dec 2022 19:19:41 +0000
Received: from dummy.faircode.eu ([76.75.122.26])
        by titan.fastwww.net with ESMTPSA
        id Nvz7M81+l2NUYQAApSktOw
        (envelope-from <bjlockie@lockie.ca>); Mon, 12 Dec 2022 19:19:41 +0000
Date:   Mon, 12 Dec 2022 14:19:39 -0500 (EST)
From:   James <bjlockie@lockie.ca>
To:     Joshua Richenhagen <richenhagen@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Message-ID: <27bdcf85-ed2f-40f6-a285-76879a8fbc6a@lockie.ca>
In-Reply-To: <CAJZ9B5tdZxqBG8pZhEKdzfaNqrR=8jGdNuMXJ7cYCitL7eatKw@mail.gmail.com>
References: <CAJZ9B5tdZxqBG8pZhEKdzfaNqrR=8jGdNuMXJ7cYCitL7eatKw@mail.gmail.com>
Subject: Re: Realtek 1d3e:c826 not working
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <27bdcf85-ed2f-40f6-a285-76879a8fbc6a@lockie.ca>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

https://askubuntu.com/questions/1412450/network-driver-for-realtek-10ecb852

Dec. 12, 2022 11:43:59 Joshua Richenhagen <richenhagen@gmail.com>:

> Hello,
>=20
> on my new Xiaomi Book Pro 14 Ryzen with Realtek b852 using newest
> kernel Linux 6.1 Wifi is not recognized at all. Is the PCIe device ID
> missing in the rtw89 driver?
>=20
> 01:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b852
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Device 1d3e:c826
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Flags: fast devsel, IRQ 255, I=
OMMU group 11
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 I/O ports at 2000 [disabled] [=
size=3D256]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Memory at c0900000 (64-bit, no=
n-prefetchable) [disabled] [size=3D1M]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Manag=
ement version 3
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable=
- Count=3D1/1 Maskable- 64bit+
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [70] Express End=
point, MSI 00
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced E=
rror Reporting
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [148] Device Ser=
ial Number 00-e0-4c-ff-fe-88-52-01
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [158] Latency To=
lerance Reporting
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [160] L1 PM Subs=
tates
>=20
> Kinds regards
> Joshua Richenhagen
