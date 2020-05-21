Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4642E1DC8C1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 10:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgEUIgN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 04:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728389AbgEUIgM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 04:36:12 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90190C061A0E
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 01:36:12 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id w188so1518575vkf.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 May 2020 01:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+Ntmxv1WGjMNV/B3U/bZGop11ppaur3FZfYTHyL9d1s=;
        b=sd6OQhdbDgWPHIhpVIswIIm3hgtzSFmXYCjpoflfbO76qTSYkG5lzPRBcgU9ZXpYDI
         IOq750r/HF2pRCyjL6jyqGzHxpwLT0enGRGCiXZKtEutQ3BBMbA4D0YdCawJVXUOK6DX
         3jh894WYXMYOB+kuQRho4i5nrT00TNjwA0hii1n5ikE30VS+J9DgcenG9lX0v3HFnxoI
         ECJn7j3nso8Exa0GH+zl5m9EFh+eXoKW0ZHg/fzBq006d/8iEEMsGWhiGI7MW/YkDthF
         7hsAWMqe1dtcOhCNKC2XhK9JCOVc8ad+tD9zCt0Mb+vLusnMyPkxgo19MaRMHX/pIKXb
         W4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+Ntmxv1WGjMNV/B3U/bZGop11ppaur3FZfYTHyL9d1s=;
        b=DiwY06cIyldmBjvSNBT61ID8jZme77Mt+qviu0aqA/7g/Nei8CfK66uF60RU07GLRb
         wmuWzEtXQn4nozTqXAVeROttqBRaHEhuUSN+8VSXu1AzsorElHOyFwSOVQ5mjk2EHTGQ
         xWg7CoNCvnSFa+Fz+g50ygohbxDS7c21vqtxJIDStyiCTmKDY010ygkvIFBAIJmTF8PA
         KsdbMKqqt8VXWsipGIIPRKA/xSkybikTUTLDgBd9cNkQ0jJ0x5+Lk7vwqceiVspFZk59
         SIQwIaEB8il8d/oqHsyFzSEoEbKEjfl+aWj8BS7d3Ibs4YvgyGlSeBICI2iDTQOV5UOy
         0x/g==
X-Gm-Message-State: AOAM5302fvGdaVZBmF36lpyOlMM0dpVYbeFJdrvj5fr3JlejX8mvT+wz
        E9uc9NIKYsh7vA4zMoCVycYjXHUolP9oJ08FRzGtHFYLvozM
X-Google-Smtp-Source: ABdhPJwUg5wJDopJxG4IDHWbUscBN1sSeETsn09df6vx+nKGD0Rk7m3bSuwfrNAP0DXKjOhRVY9AJJR2Ct8wE+RUeFM=
X-Received: by 2002:a1f:9fc9:: with SMTP id i192mr6860699vke.97.1590050170262;
 Thu, 21 May 2020 01:36:10 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvbLOr5zAYyp75Cs6Zo8mWNUVq3ZRJu56G1iHdiihFejWQ@mail.gmail.com>
 <3483242e-c2ad-ec83-0c2c-ce952bc9b638@lwfinger.net> <CALjTZvatxQ2BvUeZGcTFijBf1PiLizJuDdENxg2b=tPQL_NAzQ@mail.gmail.com>
 <CALjTZvYSJOx0xeMVkN6dHcGTdgW9O9NVbgXPKK4d6-31VX+0JQ@mail.gmail.com>
 <29f5e3de-a32c-6292-9197-19dcc57fa6a3@lwfinger.net> <CALjTZvaroTrgK9=W8uTwq9YcYayfuEU31BUc0qNYJr+08hevfg@mail.gmail.com>
 <CALjTZvaPi2FL-epk-Vd2wOLye2O0J8G5aZPsqzHXt2b7u=HyuQ@mail.gmail.com>
 <263e247c-3bf9-6d42-996b-bc513efe4b71@lwfinger.net> <CALjTZvauK0Hh+aoabcDX9kkQZ4zN2ZjPnB+aq7YrJ9+-4ihiAg@mail.gmail.com>
 <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
In-Reply-To: <87fffd5d-242a-7195-c4cc-80260dbd53c5@lwfinger.net>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Thu, 21 May 2020 09:35:58 +0100
Message-ID: <CALjTZvYCFNSQ6HMN4owkiGTVrYaiU8R-P1KXgvkwGqcOo8uMuw@mail.gmail.com>
Subject: Re: [BUG?] b43: can't connect to WPA3 network (nohwcrypt=1)
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi, Larry,

On Wed, 20 May 2020 at 21:56, Larry Finger <Larry.Finger@lwfinger.net> wrot=
e:
>
> A quick difference - this one supports 3 additional ciphers:
>
> vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:13
> vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:11
> vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:12

Well, yes, I wrote exactly that in the first email. :) But notice
there's another cypher missing from that list=E2=80=A6

vedder wpa_supplicant[376]: nl80211: Supported cipher 00-0f-ac:6

=E2=80=A6 which is CMAC.

> The one with :13 is for  BIP-CMAC-256, :11 is BIP-GMAC-128, and :12 is
> BIP-GMAC-256. I did not find a reference that says that these are needed =
for
> WPA3, but I am suspicious.

Actually, I've been digging around in my other machines, and I noticed
that an Intel card I have, which has no problems connecting to my WPA3
AP, supports a much narrower variety of cyphers. According to iw list,
its supported cyphers are:

        * WEP40 (00-0f-ac:1)
        * WEP104 (00-0f-ac:5)
        * TKIP (00-0f-ac:2)
        * CCMP-128 (00-0f-ac:4)
        * CMAC (00-0f-ac:6)

So, the only extra cypher it supports is CMAC. Digging around the web,
I found this [1] blog post, which does seem to imlpy CMAC is necessary
for the group cypher. Additionally, there's this line in the second
log I sent you (with the successful authentication):

vedder wpa_supplicant[376]: WPA: EAPOL-Key MIC using AES-CMAC
(AKM-defined - SAE)

My conclusion is that CMAC mode is required for WPA3 Personal. What
strikes me as odd is b43 not supporting any additional cyphers in
software crypto mode.
With that said, I'm going to try your patch, but I'm 95 % confident
the result will be the same.

Thanks,
Rui

[1] https://mrncciew.com/2019/11/29/wpa3-sae-mode/
