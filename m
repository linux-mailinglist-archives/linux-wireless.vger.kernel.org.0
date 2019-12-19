Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3C6125EF0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 11:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfLSKb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 05:31:57 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42127 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfLSKb5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 05:31:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id 66so6644275otd.9
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2019 02:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DLEszXaacQuiY1BjIoGn6m52GPWZFUM5WSBXLC5+nqU=;
        b=j/yeYtDpICBA+SJzbt05tOW/PahPplwQV4ZOJ9ucdGkgfFDcE0G1s9YyKMo2zsCHZN
         /PBs5juTVvOBGQAGIaTXLno8RiuQ6Mpg6yL809m0APZBQ1ZFXf1C8qICBQgq8+hTgsj8
         U04JYdlI/rbv4P16uzFKDMtLoZFu8ywikTH6CIerUJhpSiWDI+jH/kfpyJm7ftDORh7h
         IE0MDcC40edGmUDkf+IjzbZ10Zy/y2MGLZyPd5k9DghKFR9+C2RqE08w1hRr/D74Jz5q
         fwQs7YuY50XJhVg3Cjo1S+cGbkhG1DQSNXq0dNfk8WWXW1KS9gqiQ3jThuIwBiV74P5n
         +2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DLEszXaacQuiY1BjIoGn6m52GPWZFUM5WSBXLC5+nqU=;
        b=J9ChTMA1T0mx+UB5QOUQ4kXYYgi0xoNW9f3RlVL0EfpwB17q6yl1Neu8xQQolsVIjC
         4LS+S0JAK27RNgp2Gn3F6FxSfbBAslmT/MBGiyQXsRyQxkAPXpp11zdmrZmw9UfIT2Rs
         dHU7gXWJ3GkazODij9W/nxeJKhXXgyhJoZgSoGbqgjiElNysdR68gSmMXRHAfgH0TXO3
         nINn2UBJbs3TDaITOcveu7HNuXRMpe0PQiN+Ukmudz6WKCwDfLFuNO2DX+5GQYnGUNR3
         tS77TCRADSNDAAoYlwT3FlIIQIQty0IKQ1k2OgzfO1lKMJOThB2W+yNIh47GDtgNZNM4
         TpOg==
X-Gm-Message-State: APjAAAWPhMfVfyi8hLYWA8civiJwpJhYu32jVnJgifBn4KBkjSOf15Yi
        K4v7Eq3mVMs6GYHaL7bWl5IAGnRb3i3Yc3tEX/A=
X-Google-Smtp-Source: APXvYqx71mdsFZDaUgRQ7Z+PzB+5glVEdowDZbofAdFjoFbb7Nfqol4pOGu/W4hQH/S8p7UB/s8LOlTjKTGOuP443YQ=
X-Received: by 2002:a05:6830:1116:: with SMTP id w22mr8263740otq.63.1576751516699;
 Thu, 19 Dec 2019 02:31:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:362:0:0:0:0:0 with HTTP; Thu, 19 Dec 2019 02:31:56 -0800 (PST)
In-Reply-To: <d24c7821-4e5e-28b5-5d1d-f076cfd762fc@newmedia-net.de>
References: <20191216092207.31032-1-john@phrozen.org> <20191217153000.76AB1C4479C@smtp.codeaurora.org>
 <CAKR_QVJVfqid8i5PXj3Yg8VJjht=MF2fZg+twkLgEkKuMB2bbQ@mail.gmail.com>
 <CAKR_QVJ1PhCHfAO5Rp6pm-wjAO-HcZiq-9Lw67FzBFO5jjYtbA@mail.gmail.com> <d24c7821-4e5e-28b5-5d1d-f076cfd762fc@newmedia-net.de>
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 19 Dec 2019 11:31:56 +0100
Message-ID: <CAKR_QVLKfoo15EqszGSZ9zf6YnfEkih9=PeB0d92k3i0SJZfxQ@mail.gmail.com>
Subject: Re: [RESEND] ath10k: add tx hw 802.11 encapusaltion offloading support
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, John Crispin <john@phrozen.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>,
        Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 19/12/2019, Sebastian Gottschall <s.gottschall@newmedia-net.de> wrote:
>
> Am 18.12.2019 um 23:45 schrieb Tom Psyborg:
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
> johns patch does not work for qca9880 wave 1 chipsets. it works only for
> 10.4 firmares like 9984, ipq40xx  etc. the 9880 has no benefit from it
> and has no effect.
>
> so your test seem to have false results
>
> Sebastian
>
>>
>

no way. check that you applied code correctly and enabled ethernetmode
parameter. iperf or ping also wouldn't start from wired machine in
ethernetmode unless pinged from wireless machine first
