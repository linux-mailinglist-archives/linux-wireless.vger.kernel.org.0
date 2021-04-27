Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4450B36BCF1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 03:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbhD0BfV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 26 Apr 2021 21:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhD0BfU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 26 Apr 2021 21:35:20 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D794C061574
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 18:34:38 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id m13so58281572oiw.13
        for <linux-wireless@vger.kernel.org>; Mon, 26 Apr 2021 18:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b5IHUMMA8YyX+EDMB8DL8yA0hxc+/1tZzUdJKwabg14=;
        b=LGaEdfibwrkNJo9L6qIupDl2n7do470E2jt3+ZSmMIwga3LoGS1VFpHOEWCMU1bqyO
         nlEorzcPgZO1x1rt5PIkQkGonjx5g0BRNc8k8M77Poh5yBge6isAq+JAB1c5g5tgRZ/u
         WKb2qUSKWkBj3oO0TFsrqrKXQZUDcgk9v4k6DExczXLKEgXORnuvHYrRXx/DB0p7h76+
         xiWUL9+UUn6Fd1ez9ruGRshRIXce8C37p1oDtA3A7Xvxn98lwJKsRIFrb8DxtUoA2gag
         /Tf0boDs9FZ387MFIp3xBPscVHy8tjBvluje38bMjAnta6M2lQWNLnpomLGhrvQ4crSO
         c1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b5IHUMMA8YyX+EDMB8DL8yA0hxc+/1tZzUdJKwabg14=;
        b=IqsWKVXKGaP0RgqmqFyaO9oXLhqtrXillkSh1d2Nz9JUjx4YHZaEnQHcsNnJAQ+CTW
         tufyfvj4w6MifUY5dwF25mwARDmEnuepdmQja7xwOqEdkiYh8n+PwBjar0+5BVEyniN6
         G44VKH34NRfw6sxwFgC9XfbUpyzhxPpCq+gyN/GY+Ixq+vTths/RDjeCf5suWzhlqU6X
         TouqVT2IF7mAK3ASCDmuw1JTzYpj2N01ekU4qd5AJcHBO4XSvHq3vops2fQ2cQiSVmdM
         oYXczI2FI8TPzXDlIZ/61npJmhcMcVaz4HtKIDRIr1dRO7JYWLGs/ZV6BDhKaswcW0zg
         aPpw==
X-Gm-Message-State: AOAM533Gw4uIbNRzOVoILgJiJEc7+gdcSPoTT8dO91GZypGzk6PM86xL
        lbMf4uVSZJDlKh4UkyHMMj1ye9dDs+xJLZLvkDg=
X-Google-Smtp-Source: ABdhPJywlrNN/QnbdC5H5R+qVxiBU+4WBVHt3n6UclS4aKgbvC642jFPeT3c98gR1cGp4Rqx9oBwT82TVaoSfz8kYAM=
X-Received: by 2002:a05:6808:b3b:: with SMTP id t27mr1410624oij.50.1619487277095;
 Mon, 26 Apr 2021 18:34:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:2103:0:0:0:0 with HTTP; Mon, 26 Apr 2021 18:34:36
 -0700 (PDT)
In-Reply-To: <6dd2cb8b-5540-a410-92d8-f329be98327b@redhat.com>
References: <20210201152956.370186-2-hdegoede@redhat.com> <20210426183406.13055-1-youling257@gmail.com>
 <6dd2cb8b-5540-a410-92d8-f329be98327b@redhat.com>
From:   youling 257 <youling257@gmail.com>
Date:   Tue, 27 Apr 2021 09:34:36 +0800
Message-ID: <CAOzgRdZF2WyRmGRv=+PehmSbfKDhPp-WYPcLbsuRR92qxmq+bw@mail.gmail.com>
Subject: Re: [PATCH 1/1] staging: rtl8723bs: Move wiphy setup to after reading
 the regulatory settings from the chip
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     gregkh@linuxfoundation.org, johannes.berg@intel.com,
        linux-wireless@vger.kernel.org, ross.schm.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

rtl8723bs v5.2.17 is a external module, i not use staging/rtl8723bs
driver, rtl8723bs v5.2.17 support build with linux kernel 5.12.
How to porting "staging: rtl8723bs: Move wiphy setup to after reading
the regulatory =E2=80=A6" to my rtl8723bs v5.2.17 ?
my rtl8723bs v5.2.17, there are no such codes.

	/* 3 1. init network device data */
	pnetdev =3D rtw_init_netdev(padapter);
	if (!pnetdev)
		goto free_adapter;

	SET_NETDEV_DEV(pnetdev, dvobj_to_dev(dvobj));

	padapter =3D rtw_netdev_priv(pnetdev);

	rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));

2021-04-27 2:43 GMT+08:00, Hans de Goede <hdegoede@redhat.com>:
> Hi Youling,
>
> On 4/26/21 8:34 PM, youling257 wrote:
>> Hello, "cfg80211: Save the regulatory domain when setting custom
>> regulatory" "cfg80211: Save the regulatory domain with a lock" cause
>> rtl8723bs not work problem.
>> I see upstream rtl8723bs driver "staging: rtl8723bs: Move wiphy setup
>> to after reading the regulatory" "staging: rtl8723bs: fix wireless
>> regulatory API misuse" fix problem.
>>
>> I use rtl8723bs v5.2.17.1_26955.20180307_COEX20180201-6f52 driver, no
>> the "rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));"
>>
>> https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_=
dep/linux/ioctl_cfg80211.h#L234
>> int rtw_wdev_alloc(_adapter *padapter, struct wiphy *wiphy);
>>
>> https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/=
include/ioctl_cfg80211.h#L91
>> int rtw_wdev_alloc(struct adapter *padapter, struct device *dev);
>>
>> https://github.com/torvalds/linux/blob/master/drivers/staging/rtl8723bs/=
os_dep/sdio_intf.c#L333
>> https://github.com/youling257/rockchip_wlan/blob/v5.2.17.1/rtl8723bs/os_=
dep/linux/sdio_intf.c#L645
>>
>> I want to fix rtl8723bs v5.2.17 not work problem, can you help me?
>
> I'm not sure what your problem exactly is. If your kernel contains the
>
> 51d62f2f2c50 ("cfg80211: Save the regulatory domain with a lock")
>
> Commit then you also need to backport (in the listed order):
>
> 81f153faacd0 ("staging: rtl8723bs: fix wireless regulatory API misuse")
> 50af06d43eab ("taging: rtl8723bs: Move wiphy setup to after reading the
> regulatory settings from the chip")
>
> Which you seem to have already figured out ?
>
> To keep the rtk8723bs driver working your kernel should either contain al=
l 3
> mentioned commits,
> or it should contain none of them.
>
> Regards,
>
> Hans
>
>
>
