Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F641DF38A
	for <lists+linux-wireless@lfdr.de>; Sat, 23 May 2020 02:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387461AbgEWAf7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 20:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387456AbgEWAf7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 20:35:59 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB4C061A0E
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 17:35:59 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id t4so5124218vsq.0
        for <linux-wireless@vger.kernel.org>; Fri, 22 May 2020 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QcO/ucQVMvQiApRZiTPxDNZkiNYiWG9EVqH96FDN/fo=;
        b=QCiD9k5KRoyWpcx5xQtw19B6CixFXzUtnca8lXUQsHL7mLRDcB/YIjY7O+zO8Klvxb
         F/7mAjh1bt/MJ+EtlcMu63VsjQ6S53xXmT9PTzifnvVZrhbvYuIJ81qPb8u5/1UnH8gH
         z8VM8rOVVH9tVMWmgp2GTIKQJjOBDlhMzTvktmDKIGBi3GyKDIiOnb67jQYB+r1sEwJp
         kenKGvtmbHvESeWUQnoenvcpAbZ8eyc/RyVinF+tMUaAXXyNSuq5WMtEzgMzenKHOMMx
         v2gYeCpwNGPiQW64own8/qtXHAeiklqEoRQH2V8XlAfO4UMcURadVwBQZ8VZUHOzw7q7
         7MpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QcO/ucQVMvQiApRZiTPxDNZkiNYiWG9EVqH96FDN/fo=;
        b=PByGnp2Nl242tAiQ1j6z5vTLk14PHFe+PfS8hDQmDG7XjYCL78Q7Exwn4Q1HBF4r0z
         TiQsMsjfFyBWW25qUsTD5AjwIPw2v5NohDXhzF1OMz4rheF24mu2UhXQIapIeaGXX1qt
         RbfVZoRFSUb6g+sPc/sf/RWIraDo15mt3VEDTWg9U8T0K2bAesZtOL7IbNt1Ku7qtzf5
         VOKbZ/cZCr54liapVWzc7VK2rw05ico4WOMkXO6/cgW4O6VQbBDlyUtGXFIYYvXRY3PQ
         Yeea4llCWEwF73o+zIUZOHbzu0REltjWF4uc/CIWAZ+s3XAgK1VCWi3hm8xn5oSlpm3z
         Rt6A==
X-Gm-Message-State: AOAM533XfTVrSfvG3vq6UNkkdXSVoxx1GbsU011l+MufCm+LfDKjyALM
        lTdir2NjWoTrdbJwGdiLnXA9W3PQ/kwgRYvagw==
X-Google-Smtp-Source: ABdhPJwTH+diMEXL1RcLUiBszUmg9uYllw6e+FW/b19An5Fjfm0klwoRMxhtxNBMdwlWrW2rQq+fkWhDB5C/ZlmRtMY=
X-Received: by 2002:a67:6dc7:: with SMTP id i190mr12248325vsc.75.1590194157927;
 Fri, 22 May 2020 17:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
 <CALjTZvYMF_ERBfzkhaHvsTu6kt7MW+L_979sOVs8hcH7zF_Nyg@mail.gmail.com>
 <20200521124608.4b5c78f2@wiggum> <CALjTZvan46UTwcUxOSN=RiE6XHm-29Ln8B6wiv40V_RVxWewtA@mail.gmail.com>
 <20200521134011.656381ad@wiggum> <CALjTZvZcfT-aURMa=j-1ksWyVdu42bLEsGOaq+Hw39ioiPFKAA@mail.gmail.com>
 <CALjTZvY3_wjAx9DOEgYxpc4_fG-HWh_=O7veFxeEoygPzTJptw@mail.gmail.com>
 <2b22b778-2f89-9c42-93a0-5c165de26f35@lwfinger.net> <CALjTZva70Ni-s5VjRZL5BPswEtz5VZsX+dvE6rq2ztLJQ9v3kA@mail.gmail.com>
 <CALjTZvbvE_cDg9mfszscSBowznp1UpxqiN1LQfbgeCOYatKMNg@mail.gmail.com>
 <f6152cd7-1043-dde2-7fc1-634d8b07a231@lwfinger.net> <20200522121910.254aefc1@wiggum>
 <87a720gpfb.fsf@tynnyri.adurom.net> <CALjTZvYiFfqN3UMSM89Pg1rB9fJga+L1hVkBriEDeaej7oXcPw@mail.gmail.com>
 <f1f97888-e7f6-d272-6ed1-8c040d8a7c91@lwfinger.net> <CALjTZvZV4kwLgoTijxsC2AYcxGeT1R_fsTdh3Gb=M03Rn_RsAg@mail.gmail.com>
 <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
In-Reply-To: <8252e6a1-b83c-64eb-2503-2686374216ae@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Sat, 23 May 2020 01:35:46 +0100
Message-ID: <CALjTZvaDDHvj1gPPrt4K81prxg=qgsROZbkgyS5bhTwB1Vv4OQ@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 22 May 2020 at 22:06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> It will do supported ciphers in hardware, and unsupported using software. The
> patch tells mac80211 that we will accept the newer ciphers, then in the
> set_key() callback, we tell it whether the current type will be handled in
> hardware. Operations will be transparent. I will keep the nohwcrypt option just
> in case someone has a hardware malfunction that prohibits hardware use for all
> ciphers, but it will not be needed in cases like yours. Performance will be as
> you did earlier.

Wonderful, I didn't know mac80211 was that smart. But I have even
better news (and it would be great if someone else could verify this):
with your unconditional enablement of MFP, the CPU overhead of WPA3 is
on par with WPA2, I believe it's doing hardware crypto. And it makes
sense when you think of it, WPA3 Personal uses the same AES cypher as
WPA2, but with SAE handshake, if I'm not mistaken.

> Thanks for testing.

My pleasure!

Rui
