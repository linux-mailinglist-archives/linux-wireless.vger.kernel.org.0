Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB012BC6C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Dec 2019 04:21:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbfL1DVL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Dec 2019 22:21:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34373 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfL1DVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Dec 2019 22:21:11 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so38598983otf.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2019 19:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C27axE1tFb+X9nCVJoaSxmxUBrTHkIjyI8OLf34c6eo=;
        b=czR0skgirhf+2x6xaCBVqbwn7dfDAINw3FhReBjaBFkG3J0V2MbKQXWUtt5th3a13A
         zMM75pfpLms1Oopwzm6eVyB/4CVif/s0nEeNT2HjQ++oLLfAHY11yGLiH5QF/qNraI8P
         u3/t7ykD+4o1w+r+gHS6/1bQyW6YbIOYEQkPz3fxPkSv9qvzRbKD6sKzLA/H1KNp94Aj
         mbcAbB+NKlrEl3zJF87jefmz45+M9+0+hBWjLCvcHuZzDZwkIjB+j3+H9rRwaXdkQSpY
         UGkSXZLWUogbv9zDEh9SM0SviOCXuN2mPlM+SOdGnQo778feu/8vYyXNZtBMLhlSKpo1
         ccPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C27axE1tFb+X9nCVJoaSxmxUBrTHkIjyI8OLf34c6eo=;
        b=nD0joPCxvW6LUOfbNbE3ygRVoXUCRE+Hc8b6QNGMkM2SXs4TQEpTCHSWI3aHYff7/k
         euKEiGXHcZsa+y1ex9VKId+HuU0uRc2ms5CT/WB5hTIRhX8AGbsEZT8D9hHluJPQMWsZ
         r8dDZUFdDpir83l6qcetRowgg2iDZ9gJLbgmIOQAY4xvmfguwFxfmh8VFKbiNN/Xfvu5
         yBUEmHC+6zNy6zUNgCxlqzwKeExhkcrhzWg5DSb3+Z5kEZdI+wl+4EhkmNzCqySWz0ah
         fqInk1ZFDwcMQZx+VeTKsCSPKrOV8rNIyLZeW56dEBnukfeBHO4kIsZTOcZlHe09QRr1
         6K0A==
X-Gm-Message-State: APjAAAVpfIQwnkZWNPpUp6PdFijdnfkDt3lW2+mZORukyUzjhiiSaojB
        mCeICrwpgnpjejVGc1fJ1w7nX7/TBZHh4vQ33NM96A==
X-Google-Smtp-Source: APXvYqwYPhzHflt5XWxv53y/jLWPorZnyJzczQlF0rXFve1TEs1h+7a4j2FaSjng3saQDDFLarM2kyoGPrkxwOFPvx4=
X-Received: by 2002:a05:6830:22ee:: with SMTP id t14mr58731937otc.236.1577503270731;
 Fri, 27 Dec 2019 19:21:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Fri, 27 Dec 2019 19:21:10 -0800 (PST)
In-Reply-To: <d2e4207c-1cd6-198e-84df-21496f0be378@phrozen.org>
References: <20191216092207.31032-1-john@phrozen.org> <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com> <d2e4207c-1cd6-198e-84df-21496f0be378@phrozen.org>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Sat, 28 Dec 2019 04:21:10 +0100
Message-ID: <CAKR_QVJE6c-VTR-rGdBUt08ijt=w2rCRjeNQ2+=E6ZQ6_N+g=Q@mail.gmail.com>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
To:     John Crispin <john@phrozen.org>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019, John Crispin <john@phrozen.org> wrote:
> On 18/12/2019 23:45, Tom Psyborg wrote:
>> ccing Johannes Berg since upstream change (mac80211-next) breaks build:
>>
>> In the commit log its written: remove SUPPORTS_80211_ENCAP HW flag
>>
>> Any sane reasons for doing that? mac80211 fails to build because of
>> removed flags, this is on backports-5.3-rc4
>>
>> Other than that the feature delivers the promised:
>> QCA9880 iperf between wired and wireless machine
>> native mode 449Mbps
>> ethernet mode 522Mbps
>>
>
> superseded due to johill's fixup of the patch, new version coming up
> 	John
>

in case it doesn't fix up scan crash i can provide more details.

triggering scan (from luci at least) would always crash the driver
unless vdev was already started, right after the message: mac create
vdev 0 map ffff
