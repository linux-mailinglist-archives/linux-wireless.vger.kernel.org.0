Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0D65370794
	for <lists+linux-wireless@lfdr.de>; Sat,  1 May 2021 16:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEAOfT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 May 2021 10:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbhEAOfS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 May 2021 10:35:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433B6C06138C
        for <linux-wireless@vger.kernel.org>; Sat,  1 May 2021 07:34:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id l4so1337046ejc.10
        for <linux-wireless@vger.kernel.org>; Sat, 01 May 2021 07:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=P7wlVldFzAa9KGTsX4/sCHUDDDcScVbS5pBQOENVnF4=;
        b=VeobQzwvAaKEKB6sxRptTZt/D5zIrnn4dhfQaPD4KkXkB8zK3+ppDR2EcRlqFHXnyq
         z9LX4IZoGkyuQypHRLo4vw7krU8J6s7h/NPP8h48jb/J0nYYrEOsX4gOOCzGH9AgkelQ
         vxnAurV8B5bZ7q2BPhDu/+zKD/wGPlOhoAeUCT5LksuBjHXEqMeHA4bVC3tzfOToIGMH
         3vlzFwiJHazGquHEN7zAMRgppAJ2hwJbPvjHBsZYqXB6UdgAK+FY/rfCe08c3/1i9V/T
         mR9AksIpd0b2TKLcVI6zsxz+IgGbCJbrWPSjCeC7MQlV6wgEyyt2RkJ7qzp1HM3wSshH
         wS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=P7wlVldFzAa9KGTsX4/sCHUDDDcScVbS5pBQOENVnF4=;
        b=HDJKzQSx/4Sj0/Vb4MDFmovQlqHFgv6iwOwi6aurOZKtxTBdfzCrVOK7lqay5/PHCN
         kes2Y7BzNVQBcJfAyT0DS68ZxfennEuaJN9jQQm1/TLsEueFOU9yIJQVbZ8QSU4P5u4F
         kJC2A0EdKvQRgtlJBH8HlKw6TJjDbQlGdUOTlycOsMDv3g7sUl23KmV0Yb2ZU44rfYTJ
         rUqyfBnog/taG2sf7BFgHEZ+KJrVvr/efcHqGc0KMoaV818WpYzFope1i/G9wMyRv1+/
         FkB5/UghmD9V12TsilCHe5Oj9rKBT+wG0TEo9baELx/KSOWBpnbhJJQgLqh7SU6ad+SP
         ivqA==
X-Gm-Message-State: AOAM532hq2CZbk1esFCfrGrHDdusGLG9/B1qnJmhhyl4+6ZFkvTylXnf
        fSdxMh0LwfJqPRoeGmPmFirO/EddPGD2yJtUFeETDl1kvcWGnA==
X-Google-Smtp-Source: ABdhPJxFtwXifIVA+0x1mncQQTBc469M9vGVr82gVOGw3lloMDiZVveIB6esV10P/Rj/lds0K3KooOp7a5zqVf9iz5M=
X-Received: by 2002:a17:906:168d:: with SMTP id s13mr9006579ejd.81.1619879666741;
 Sat, 01 May 2021 07:34:26 -0700 (PDT)
MIME-Version: 1.0
From:   Turritopsis Dohrnii Teo En Ming <ceo.teo.en.ming@gmail.com>
Date:   Sat, 1 May 2021 22:34:18 +0800
Message-ID: <CAMEJMGHaiEUKkGPXXz=xJNxfpATXnmrVSg4Yp1rSuWBF7XgTDg@mail.gmail.com>
Subject: Huawei E3276s-920 4G LTE USB Modem works on Fortigate 60D firewall
 firmware 6.0.10 but not on Sophos SG 115 rev 2 firewall UTM 9.703-3
To:     linux-wireless@vger.kernel.org
Cc:     ceo@teo-en-ming-corp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Subject: Huawei E3276s-920 4G LTE USB Modem works on Fortigate 60D
firewall firmware 6.0.10 but not on Sophos SG 115 rev 2 firewall UTM
9.703-3

Good day from Singapore,

I subscribed to TPG Mobile 100 GB SIM Only Plan (SGD$10 per month) and
collected my TPG Mobile SIM card at Besk Denki, Bedok Mall, Singapore
on 30 April 2021, all on the same day.

After collecting my TPG Mobile SIM card, I went to Sim Lim Square,
Singapore to purchase Huawei E3276s-920 4G LTE USB modem for SGD$75 on
30 April 2021, also on the same day.

After extensive testing on my firewall appliances, I am very glad to
announce that Huawei E3276s-920 4G LTE USB modem works on Fortigate
60D firewall with firmware 6.0.10.

These are the minimum CLI commands required to get Huawei E3276s-920
4G LTE USB modem working on Fortigate 60D firewall with firmware
6.0.10.

config system lte-modem
set status enable
set apn "TPG"
set modem-port 2

However, I am disheartened to find out that Huawei E3276s-920 4G LTE
USB modem does not work on Sophos SG-115 rev 2 firewall with UTM
9.703-3. My Sophos SG-115 rev 2 firewall with UTM 9.703-3 cannot
detect the Huawei E3276s-920 4G LTE USB modem at all. This is the
guide that I followed but did not work.

Article: Sophos UTM: How to create a 3G/UMTS interface
Link: https://support.sophos.com/support/s/article/KB-000034757?language=en_US

There was a Fortigate OR Sophos technical support engineer (I can't
remember who) who said that if you can get a 4G LTE USB modem to work
on a Linux operating system/distro, it should also work on Fortigate
OR Sophos firewalls. This is because Fortigate and Sophos firewalls
are based on Linux.

Mr. Turritopsis Dohrnii Teo En Ming, 43 years old as of 1st May 2021,
is a TARGETED INDIVIDUAL living in Singapore. He is an IT Consultant
with a System Integrator (SI)/computer firm in Singapore. He is an IT
enthusiast.





-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:
https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microwave.html

********************************************************************************************

Singaporean Targeted Individual Mr. Turritopsis Dohrnii Teo En Ming's
Academic Qualifications as at 14 Feb 2019 and refugee seeking attempts
at the United Nations Refugee Agency Bangkok (21 Mar 2017), in Taiwan
(5 Aug 2019) and Australia (25 Dec 2019 to 9 Jan 2020):

[1] https://tdtemcerts.wordpress.com/

[2] https://tdtemcerts.blogspot.sg/

[3] https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----
