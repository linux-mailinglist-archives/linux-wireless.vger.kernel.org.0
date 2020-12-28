Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87DF72E6C1D
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Dec 2020 00:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbgL1Wzp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 17:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgL1ThG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 14:37:06 -0500
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546F4C0613D6
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 11:36:26 -0800 (PST)
Received: by mail-vk1-xa33.google.com with SMTP id s13so2511906vkb.11
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 11:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ne+ItwOWVE9qaYXGHf01QVJb+H1Ydh4RijcEekKqQUE=;
        b=S6Hg0P/tUh3DeE/vI1wd8jsTLLjGvfOVAlhYp1UkDzRppgg3azJf1rN27giL/DAcUc
         sChUxiHCXNXiJakPFEpkAC7LokBOTezB0coktwZLRiKPRrUGHWrKHgzyacWCkmNkpggI
         /qjmYoV4EUAZIwWVvb+Qlsg+44yhFjdiB0eyh2bSsU9G6dyKDADtFekiQGRKbcaepj3O
         SksTnk9NRSXjtBZL5QNkRZb/fj26D3y81FUi6mmaUz4wzezq4poGk9Ko4sqYrsBQS6rt
         hBEasiBKKTE/yKjDHJzma9xoUv6VHWelh4q+O6S9oXRrsXWtjkLVLMRxshOXgzi8ZGsz
         3mVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ne+ItwOWVE9qaYXGHf01QVJb+H1Ydh4RijcEekKqQUE=;
        b=rbzGzVf6H3EJQx/fmEaYGMBxE5tBSr1HgYtvf3aX5yGmDQwhpjjc5mp4AF59FilUNH
         t/RFhKlGxw+22YYxdHyWb1ItWITR3Fp4+Wf3mEHznjD0hIJXr3O4U7MpzzKakTFc7ieY
         /s8qxKRJVLimFQNsP61NVUOR5ZWgejU7ccXRVp2cn1PmDLk6dwlaTkQWgH+lvhwGFJ7P
         Y9W4dfoLdwZkZX+MS95Hol5JoC2AOtAn0mVV8m1V0fhGYk5O61L+xH96cdtKHwNflxxB
         4qpCuRgkUJTLJDDvQt8z4t9hrJKZRV4PtedQOuG2GuOJJWOmuBhypRQ7oOL4P01jKu6D
         QhOw==
X-Gm-Message-State: AOAM533iznV/Lm6fYfuC7ea46/sf94mRGeeOF3v+puirSgYQvmo7DPE/
        8IFu5CaPMJ7aOSaPqDTsYdcY3Qrq9exZwZEtIkQ=
X-Google-Smtp-Source: ABdhPJwjflbU9+u95LbtgxhDnbISubNAVQ8qXtqnzwIBUOpcanWuFR/ezU50uWH7fnL9fLTdQMVmhWl6XysSonoEVnc=
X-Received: by 2002:ac5:c943:: with SMTP id s3mr30867816vkm.21.1609184185340;
 Mon, 28 Dec 2020 11:36:25 -0800 (PST)
MIME-Version: 1.0
References: <CAPZXPQdpcvjCBqzCGt55Fz0iAx6Dn3MB7hMfzPgoeejK6-AYQg@mail.gmail.com>
In-Reply-To: <CAPZXPQdpcvjCBqzCGt55Fz0iAx6Dn3MB7hMfzPgoeejK6-AYQg@mail.gmail.com>
From:   Emmanuel Grumbach <egrumbach@gmail.com>
Date:   Mon, 28 Dec 2020 21:36:15 +0200
Message-ID: <CANUX_P3h-qB11SSOvu7S_eyPKcxx2z1bDweb1Up0WNMk1kqCkg@mail.gmail.com>
Subject: Re: AP support in iwl4965
To:     =?UTF-8?Q?Martin=2D=C3=89ric_Racine?= <martin-eric.racine@iki.fi>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Dec 28, 2020 at 6:51 PM Martin-=C3=89ric Racine
<martin-eric.racine@iki.fi> wrote:
>
> (non-subscriber, please CC me in replies)
> Greetings,
>
> I was wondering whether there's any plan to implement AP support in iwl49=
65?

Well... This device is ... 14 years old or so? So, I guess the answer
is easy. No.

>
> Given how this is MIMO-capable multi-channel chipset (2.4/5GHz,
> 2x3:2), being able to use it as an access point with hostapd would be
> desirable.
>
> Cheers!
> Martin-=C3=89ric
