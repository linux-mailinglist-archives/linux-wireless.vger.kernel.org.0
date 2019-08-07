Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9492383E58
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 02:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfHGAaV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 20:30:21 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45996 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfHGAaV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 20:30:21 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so83701902lje.12
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2019 17:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=04KeAaCHcaHA13etq10kb5eqtxQxSQGGJ3drhfuep0U=;
        b=fqRhCbgmWE11EYy3WIsEPjq48dq2jzTQOhZT7z7UW8KW//nC8dYqObDWTiTfCLO1kp
         kxxcmjUAd/qgJ4YzxnhotT/4QmTXeMCRqlRUH6vvg2rdYn3xcQosK24cTLIVKz6qhULf
         VJVsUbuWu0FTrMtZ86g1CyNgtVWby+VNSNh5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=04KeAaCHcaHA13etq10kb5eqtxQxSQGGJ3drhfuep0U=;
        b=F3GjU4Kjk6WK7er+WCBTZFgd/vxVLS9/LJNCQXMB89hX0tvPw4N/OtrH4fBfXPF3FO
         83U6BpB40zKEeuIre7tHqLzL3a12iQD/CfDx3l2JvMhxIT4rmHATk30c61yvP8e1aVM5
         OuFzqhOoEWDbTt/oQxZ5Jex9R76+ubyKuzR5X0bv9gb+NJRFZupka7nuSZtWhFLStmrP
         Fx3vBAI3C0+s32LmlPY7MIHKZzh5eHWs37faYXJcF8F34pkFYhnoYBayIN6Ddiuh90nT
         qNySv5SL+Nbq7rWrxQcTIcyPW+2gnCizhWlkjO6iPvCzZSSeLecs24qEo45leLWoOVz5
         bdLQ==
X-Gm-Message-State: APjAAAUcFUaKLaryvGIWKhkaTSm9qBGne1EcyDxgVDlN4hGwwiU3ZE3H
        8d1VqAEpSmawV9bir21qtF9zzc4P5zI=
X-Google-Smtp-Source: APXvYqy5EWZQPI60VCH4PtnMCCY5hpnrIoBA4N+HD4fVbLvD0hapXxk2cXR7A84otT7GeXK5t2IheQ==
X-Received: by 2002:a2e:8559:: with SMTP id u25mr3161106ljj.224.1565137818656;
        Tue, 06 Aug 2019 17:30:18 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id q21sm2969290lfo.18.2019.08.06.17.30.17
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 17:30:17 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id s19so62648922lfb.9
        for <linux-wireless@vger.kernel.org>; Tue, 06 Aug 2019 17:30:17 -0700 (PDT)
X-Received: by 2002:a19:ed11:: with SMTP id y17mr4205590lfy.141.1565137817348;
 Tue, 06 Aug 2019 17:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAH040W7fdd-ND4-QG3DwGpFAPTMGB4zzuXYohMdfoSejV6XE_Q@mail.gmail.com>
In-Reply-To: <CAH040W7fdd-ND4-QG3DwGpFAPTMGB4zzuXYohMdfoSejV6XE_Q@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 6 Aug 2019 17:30:06 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM6Jz7YY9XUj6QKv5VJCED-BnQ5K1UZHNApB9p6qTWtgg@mail.gmail.com>
Message-ID: <CA+ASDXM6Jz7YY9XUj6QKv5VJCED-BnQ5K1UZHNApB9p6qTWtgg@mail.gmail.com>
Subject: Re: Realtek r8822be wireless card fails to work with new rtw88 kernel module
To:     =?UTF-8?B?6rOg7KSA?= <gojun077@gmail.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Tony Chuang <yhchuang@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

+ yhchuang

On Tue, Aug 6, 2019 at 7:32 AM =EA=B3=A0=EC=A4=80 <gojun077@gmail.com> wrot=
e:
>
> Hello,
>
> I recently reported a bug to Ubuntu regarding a regression in wireless
> driver support for the Realtek r8822be wireless chipset. The issue
> link on launchpad is:
>
> https://bugs.launchpad.net/bugs/1838133
>
> After Canonical developers triaged the bug they determined that the
> problem lies upstream, and instructed me to send mails to the relevant
> kernel module maintainers at Realtek and to the general kernel.org
> mailing list.
>
> I built kernel 5.3.0-rc1+ with the latest realtek drivers from
> wireless-drivers-next but my Realtek r8822be doesn't work with
> rtw88/rtwpci kernel modules.
>
> Please let me know if there is any additional information I can
> provide that would help in debugging this issue.

Any chance this would help you?

https://patchwork.kernel.org/patch/11065631/

Somebody else was complaining about 8822be regressions that were fixed
with that.

Brian
