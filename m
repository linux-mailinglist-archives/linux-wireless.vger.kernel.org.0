Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC603EDA81
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Aug 2021 18:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhHPQFP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Aug 2021 12:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhHPQFM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Aug 2021 12:05:12 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9714C061796
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 09:04:40 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id cn28so15340458edb.6
        for <linux-wireless@vger.kernel.org>; Mon, 16 Aug 2021 09:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Hzt3e9rBXXN9Nwtyr7KmAYP8oeshlFfBjg3s9GeGX0U=;
        b=HPAxhL7oGNFPL9AdGbAp9Bmu+qOv1Z3eLr/j66DBPkN6XBev947q1Dw2986ywIgyeS
         5WC0NK37GVf60lEkl3GNOi0uykKzf0ZPoAbDMDzkbZOLVXNx+rS+aD9a3BYcdh8jqOq/
         szkKDRfDeWs5RwLlHhwX5H+X48+vEqu8hIyOvLpoXM4tho+aNFm3OEGgI9WPTfvWDiet
         ejstpXX3luDzy60aFIC3J9Cklz9jHycXp/bxIQwHQbjqFk3u5AQ7+snyz5s69gPBgwsz
         C9jCG8o1N7JsEfj7Hp/Olf6WC3hMz7hTziNw1WzrjbaKojIUmFizzFIDmX0ZOl2W3nLP
         3X0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Hzt3e9rBXXN9Nwtyr7KmAYP8oeshlFfBjg3s9GeGX0U=;
        b=mY4pLfNGqdCf/vu5HmzaeLsy1sNsYGaN4XN0GLqeWSYtSbI2pN522TSEynYDjV1EjW
         JjG14m/HL3Un8+9dZd5a2X83st77nxGMuaEYFWA7CSlCYSBvtwn8sZCs7W1Ghz4IQhPV
         tL50vgwwEYrT1ObhuvwTjuQ9ZXLw367xSCOvvOx5wAVm/cVnJeBgdqdLgPyKwjlV3sjU
         TuDhNZze6kxnZjCnIZKFgere3PLysjOEya+TCjdFEAr6Hev+aHWpgh0qCvlhOUq8GPYx
         gDmMGgK//yy2SvTFWAqP0leFSW8JBJPv0QRrHHayGp5nqP9gtPw/nT/oG379dmIhiGwJ
         809Q==
X-Gm-Message-State: AOAM5324BIIlLlgyxueCnSH1wCCxHzRaiKXbPsoFs72nysSGqcpVPchp
        5kG1DcIbv2riyL8BGPerJfLeGtmp3tMNIEmaLwY=
X-Google-Smtp-Source: ABdhPJyTrZg2NNkgISiLVQBZ3waGO/WR3NGjm5XpFrsJTREerGuOhdrybD2dfFv6ZWgxIKQguwzV52ZPLajvm4Q5fFg=
X-Received: by 2002:a05:6402:1a25:: with SMTP id be5mr21180378edb.303.1629129879525;
 Mon, 16 Aug 2021 09:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAAZjYunwQ5UtjJuvrBNWU9qTf72WMRjoaYD+mgn7OaqmXXZ+fw@mail.gmail.com>
 <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
In-Reply-To: <aa62f2ff1ae79089d63f25c3b215f7ed7196ae15.camel@sipsolutions.net>
From:   Milo Garcia <ing.eagm@gmail.com>
Date:   Mon, 16 Aug 2021 18:04:28 +0200
Message-ID: <CAAZjYumZQJud7y0nVXhO5RLCrx=MF3hLEv9T7U0bAWw=63WoKw@mail.gmail.com>
Subject: Re: iwlwifi: OFMDA Sniffer not capturing actual data
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> What exactly are you seeing?
https://imgur.com/N7DdDS3

I was expecting to see the data in the RU but Wireshark only shows
packet length of 86 bytes

El lun, 16 ago 2021 a las 17:44, Johannes Berg
(<johannes@sipsolutions.net>) escribi=C3=B3:
>
> On Mon, 2021-08-16 at 17:34 +0200, Milo Garcia wrote:
> >
> > I am able to see HE_MU packets but they don't contain the actual data
> > in the RUs. Wireshark says "NOT CAPTURED BY CAPTURE SOFTWARE"
>
> That *should* work, for the AID you specified.
>
> What exactly are you seeing?
>
> johannes
>
