Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B273AC356D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 15:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfJANUD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 09:20:03 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:38553 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387798AbfJANUD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 09:20:03 -0400
Received: by mail-lf1-f48.google.com with SMTP id u28so9859019lfc.5
        for <linux-wireless@vger.kernel.org>; Tue, 01 Oct 2019 06:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kY76e5WD0CssW8r0BmuBY1TGpX7C1ErJsqDgfRM4JrU=;
        b=ZyTIcK1SL3MuXtwH2WO/Mw1HUAJPGvzz1SqZgjqqSzelNPVpPtL/9HD35aFxUnjVkb
         m+jXt35Lo3fWuuYGkn/zGfwa8NRYGWsKf7S1zMBABydxrrZzdtoCGKhiwr759yn5LuHs
         bo/FmC3VErRr7ipMRDbHKzu+p4i2YV2mDraa9Tn6sEXqd91zcppR6UXacPtmHpusfpWj
         T2VPIH+78P40mnE4iRn4VaplnfWuxBEtKFghn2Nmn+u4yaSdk5bzgY98ncNg7Eq7tWTi
         ZuaA37ivgt4wbayUit06iqyYz6VfSGVR5I+PKYP5EczwmIM9IjKmmjMGM53SlaNjuI3P
         piYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kY76e5WD0CssW8r0BmuBY1TGpX7C1ErJsqDgfRM4JrU=;
        b=GzfXWft2JNuCD+WvrNs7Eh8zqhSZAPq8Upwqu+vjbxKqLFGE43fQQx00mH9ij805cP
         +x2m3i3lhDcEJPCmKAw72yeR1/MOX3qzkHO9DwLOMnHaa/UANEo3Zh9vfjnQr2BWvEJ4
         WIcjxv4Ov2pKV6xJA7im23mDhZB8u+ZL6dIas5k5wzKkNzB7VwL2j1SE5vDa1/m6YMqj
         IQ7ionoBCh7MXAD54hgthtitzGTs7ydaCp4jtmaTEgefTdomWrt0mlGCHoggPdYIQmoj
         6dCyJ41yldznuhZ55nvVr/La0O/JybNRZQDgZ9iEEXSqD1437Kn+utSePvH89LR8Hdpa
         6egg==
X-Gm-Message-State: APjAAAWVDcBIBdl2WF/bFRB0/r9PuP5ARRGA97NBid2N9R4ss0yuBpNx
        DQm1tY04cLEt3ic8IKkmJXvBnc0yRTdxQlGrui7KT/brk2U=
X-Google-Smtp-Source: APXvYqz5FWpsmwq4LGsUzE8eiNe6/ob2AVIbcwu3MDdqAUki4/J4vkXZZ2iFdn2p1qIoem5UAEXJVYQTG7qmeQLrBpc=
X-Received: by 2002:a19:7715:: with SMTP id s21mr14386313lfc.98.1569936000877;
 Tue, 01 Oct 2019 06:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
 <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
 <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com>
 <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
 <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com> <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
In-Reply-To: <df3b53f157e113e309360ed40b1f36b9f08f4d8c.camel@sipsolutions.net>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Tue, 1 Oct 2019 10:19:49 -0300
Message-ID: <CAK8U23YMeFcQPLfWTMijyJaiX1V+NO9FWmq70nhS+bLVNxFYkg@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Krishna Chaitanya <chaitanya.mgit@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Do they also have the same version of wmediumd?

Yes, they have the same version. As you can also see through the
video, I only change the kernel and all the packages have the same
version. I also tried to check the latest commits of mac80211_hwsim,
but haven't found a reason for the problem yet.
