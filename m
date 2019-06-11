Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAF5C3C3B8
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 08:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391144AbfFKGCF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 02:02:05 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:42856 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390485AbfFKGCF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 02:02:05 -0400
Received: by mail-qt1-f176.google.com with SMTP id s15so13136449qtk.9
        for <linux-wireless@vger.kernel.org>; Mon, 10 Jun 2019 23:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=24nWy+FWO5DbLf1W2l/ocge/pj2/4txv8/6/17vj9UU=;
        b=chKAVt7RsItNuyPFoOQgj3xFGEXvynDiPQjG1E7Ae5tNHPoZ0SZANcjCrF3oPs1hfM
         2BSb4vV/kZFHFIBR4XC2pzyck36Sk3fxc7O7aNh+0QJTKUWUArjhBjSeX59p0VbGjAOc
         /WFNdxp8snMMK0NVxJPQaYvrv1bM5zrB8SSNORtUOT8oQTxKUKDcmHFAnvcXu7yaaXkV
         z320Ora10hFvSQ52CbS41sqCRKA1ZGSZJaS06L0yaaHQdOqEfcvD2ClLJ5CO35cFLGRp
         ElvqO1OZgj/VmH4gMH83xbm9gTkJ9damZ1Yl3SB0MvwxdknHCUKgMfcwqlagez6RD4Nl
         x1PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=24nWy+FWO5DbLf1W2l/ocge/pj2/4txv8/6/17vj9UU=;
        b=Bt4bbJILgCVwsnFrTe2cWn2/KMPdLEuoPDoSPZaY+39a8xRCip+R4ZTT/DhhQ9K1by
         iQh+tYwYgDneAE8uRUoyC+ryQbu7paMjzmV4YPlFMLXiBtu82PEENdtMLlfO1VXXpYpm
         IsfSuhf0/wb1WT9+u8CcXgOWfccihhJ37ghPsSspFCc+Ivd3ZVFlVtoR0gvYOAyVGy78
         /c4Oo+IJol8rsR6XmviF0UWEdjzhZlie7WAdH4fEKKHKWF4fqS/VmDc8qztI9Z54F542
         0vDAIgujZVKQ292r+XiVO6JorvEVnJ5as3XDhzFcIXG3uuBLlPUj9eby/MPhrHmha7fs
         t3YA==
X-Gm-Message-State: APjAAAUhQHUbeh2fwKcD0CJmSgtpzPBruocx4KfuoxQwhVrd6kmIPrRb
        E8mpVt6O5DDQnJuW3QrE8tDY3OqqT8/s15fAM2Nn1Q==
X-Google-Smtp-Source: APXvYqw+jAN4EGphnEuM72KJ8pOLtyMrnPXrI4aLvx/M6bZFWQmdeOMoVQWqciQOwI+ECZmWJP8hp+nSDWELFOazjuc=
X-Received: by 2002:a0c:d24d:: with SMTP id o13mr7602665qvh.86.1560232924408;
 Mon, 10 Jun 2019 23:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAD8Lp45wxQ3vL_ttq-yKYDxscjn2KyJVCx_vJBCn+u8Yc5QtOQ@mail.gmail.com>
 <87h89lei7e.fsf@kamboji.qca.qualcomm.com>
In-Reply-To: <87h89lei7e.fsf@kamboji.qca.qualcomm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 11 Jun 2019 14:01:53 +0800
Message-ID: <CAD8Lp455PaQYqC0PKYK_2_nP2dP_bn=eCJnpiJP3=Dh34B0whw@mail.gmail.com>
Subject: Re: ath10k QCA9377 firmware crashes and fails to recover
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

On Thu, May 23, 2019 at 3:36 PM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Daniel Drake <drake@endlessm.com> writes:
>
> > We are experiencing failures with QCA9377 wifi, using Linux 4.18 and
> > Linux 5.0 with the latest firmware version:
> >
> > ath10k_pci 0000:02:00.0: firmware crashed! (guid
> > 54a4649a-1240-4459-9442-9d498c49de79)
> > ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
> > 0x003821ff sub 1a3b:2b31
> > ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
> > ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00002-QCATFSWPZ-5
> > api 5 features ignore-otp crc32 c3e0d04f
>
> Is this a regression? For example, have you tried older firmware
> versions?

Sorry for the delayed response, as we were testing old versions.
It doesn't seem to be a regression, at least we tested:

Linux 5.0 / latest firmware API 6
ath10k_pci 0000:02:00.0: firmware crashed! (guid
697a3b62-bf3a-4953-bf3d-058eb3b828ff)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.2.1-00021-QCARMSWP-1 api
6 features wowlan,ignore-otp crc32 42e41877
ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
ath10k_pci 0000:02:00.0: htt-ver 3.56 wmi-op 4 htt-op 3 cal otp
max-sta 32 raw 0 hwcrypto 1

Linux 4.18 / latest firmware API 5
ath10k_pci 0000:02:00.0: firmware crashed! (guid
54a4649a-1240-4459-9442-9d498c49de79)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00002-QCATFSWPZ-5
api 5 features ignore-otp crc32 c3e0d04f

Linux 4.15 / older firmware
ath10k_pci 0000:02:00.0: firmware crashed! (guid
7e1505fa-49e1-4fab-a7c5-a2352f1a47f6)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00267-1 api 5
features ignore-otp crc32 79cea2c7
ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
ath10k_pci 0000:02:00.0: htt-ver 3.1 wmi-op 4 htt-op 3 cal otp max-sta
32 raw 0 hwcrypto 1

Linux 4.13 / same older firmware
ath10k_pci 0000:02:00.0: firmware crashed! (uuid
701e7d5e-b405-408c-ae27-7de285c38c8f)
ath10k_pci 0000:02:00.0: qca9377 hw1.1 target 0x05020001 chip_id
0x003821ff sub 1a3b:2b31
ath10k_pci 0000:02:00.0: kconfig debug 0 debugfs 1 tracing 1 dfs 0 testmode 0
ath10k_pci 0000:02:00.0: firmware ver WLAN.TF.1.0-00267-1 api 5
features ignore-otp crc32 79cea2c7
ath10k_pci 0000:02:00.0: board_file api 2 bmi_id N/A crc32 8aedfa4a
ath10k_pci 0000:02:00.0: htt-ver 3.1 wmi-op 4 htt-op 3 cal otp max-sta
32 raw 0 hwcrypto 1

Any further suggestions?

Thanks
Daniel
