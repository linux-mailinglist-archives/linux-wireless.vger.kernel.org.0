Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21F3EC2864
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2019 23:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730876AbfI3VPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Sep 2019 17:15:52 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:36480 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbfI3VPw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Sep 2019 17:15:52 -0400
Received: by mail-lj1-f180.google.com with SMTP id v24so11042585ljj.3
        for <linux-wireless@vger.kernel.org>; Mon, 30 Sep 2019 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YyyVGIRKNRWW5jFyYbmhZVPsKZ1YvvL78UY6++vzUb8=;
        b=rCprS10PifPbWbiCiAdkZJkhfmOXKUlbQCCcx8e0LOvoLWIaouvWTqpRiNY+Mw+kgP
         vLqLW3TH9rDsGpM1jL+McrGJFXBZnZJt8mF0x+5kI1NiFutb6mmJjuBi9wwqokqDhlTo
         MewZ7YZiDxyzrbNMJhNn+yT5ZFS3OaqUFsKr+4/nypbF3g4bUqOIaH79SdYBA9Eys1Ji
         tU1PRf5+AI5vYFKgRCHg2d/tBBdXt9YALZEtd5e76UrjkGt9F5W+pk9O9A/dwgZ2MExP
         /Jup7s4LnlyrNL9gIXCnbN1SsDnaE8l3u+HqosDrdoqqEsoIQjHh2wB1ChJDkX5VNs4A
         fp/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YyyVGIRKNRWW5jFyYbmhZVPsKZ1YvvL78UY6++vzUb8=;
        b=dJ3IegsoEM6QAjfCIj8k0gceiwgBmXKujcE5Fb8+hjfOWxAko2gUyGSzJ8OFZpc6OA
         /DUqjXBfifsAVKddZDqnmjDTXDWZM7am15Py9/jzBjF60Fb5JV6Xj4nxKk/gozIWKwmt
         d/l0mONQPBodb57791Op620F7iVbkUTKcZWjGX3RFV0v16f0y/w9UbksjkWu740+UPZp
         VqjAzMLM1QxMdqLPwZj3e9+icOmYgvKnnkSBLuFR3T6H6ksM4w0NrjhiYSjFNylCzj8h
         E38Mr/s2qtcJnmpKKaFmMzpFajOyNMriQnsK89cIiXw/7/ZDX+MfY9icDpDRH31zbpSP
         iPpg==
X-Gm-Message-State: APjAAAXDWicuFrszxA64NMg6qyF2SjprupXxhZc0rJB03s6tTCqq7DBj
        s9WSvrH0AQkb3rwBTzPlUDjuUWW69MvzwI0zj51WBQZf9QI=
X-Google-Smtp-Source: APXvYqyMk1KeaNJjADPmecPTXVF5yRg6tGUrkncAg0ZiiBlT8S+sQROHRTM19vE2Y9i/tdfapcmKtfUp8jBAQZsx6qk=
X-Received: by 2002:a2e:a0cd:: with SMTP id f13mr12977245ljm.93.1569868117519;
 Mon, 30 Sep 2019 11:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8U23biuUY9hWE1NOnSbJCRtRVfdg1a27ZOkU5cbaGdzZLYEA@mail.gmail.com>
 <fa029365caf3db963b1c2ec05ae389a8c8fc20fb.camel@sipsolutions.net>
 <CAK8U23aHprXtZm2PV3sj6g4Da_ponK9L0YmSO1tb6xoFgK-ZLA@mail.gmail.com>
 <80d9c12986ec0a13c34672ca1c16f37cae0cc096.camel@sipsolutions.net>
 <CABPxzYLrTC3kS86iyfq+RY=XEgjedu2MWPtn+i+H50jPz3oh3w@mail.gmail.com>
 <39d646206446159a2b0a67ee7d8667483ade0733.camel@sipsolutions.net>
 <CABPxzYL0i+YbKh-xMXsS-xWeQvwfFUvv7vGhugM1e+OFMOSHSg@mail.gmail.com>
 <CAK8U23bbiGhmDg-ChDJtbRVVc_6njVdoUjfAhqM+V3yfQXTC4Q@mail.gmail.com> <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
In-Reply-To: <CABPxzY+8Jjvjv0x79yzo+rL3nONTZSkROK1T+gMqq5nhXb=7-g@mail.gmail.com>
From:   Ramon Fontes <ramonreisfontes@gmail.com>
Date:   Mon, 30 Sep 2019 15:28:25 -0300
Message-ID: <CAK8U23bb9C+16zuGi+uAYxUg-goddiSZfDAJUYeC1Xpu=jud+Q@mail.gmail.com>
Subject: Re: mac80211_hwsim (kernel 4.18+): wmediumd + 2.4Ghz
To:     Krishna Chaitanya <chaitanya.mgit@gmail.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Based on this info, looks like hostapd/wpa_s versions might be causing
> the difference,
> can you please confirm the versions on both?

They have the same hostap (hostapd + wpa_s) version:
Hostapd v2.10-devel-hostap_2_9-102-g12de14907+
wpa_supplicant v2.10-devel-hostap_2_9-102-g12de14907+

I've tested with v2.8-devel-hostap_2_7-313-g3e949655c+ too.

In this short video (https://www.youtube.com/watch?v=f6rrHIGpePA -
running on VirtualBox) you can see the problem in action. Through this
video you can see that it works with 4.16 and 4.17, and doesn't work
with 4.19 (I forgot to repeat the test with 4.18, but I confirm that
it has the same behaviour as 4.19).
