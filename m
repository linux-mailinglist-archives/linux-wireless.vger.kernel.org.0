Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1C270C12
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2019 23:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfGVVx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Jul 2019 17:53:27 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:46323 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfGVVx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Jul 2019 17:53:26 -0400
Received: by mail-io1-f42.google.com with SMTP id i10so77332895iol.13
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2019 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=suyRjY4hRWM09kcSpFkEIs5D6dArl6vQjNWpnTsECKs=;
        b=d2kcq1m8rgsTmC9B0ZqxgrTMYFr18hUcYvKS6fzj6u2aMZ3JeieT3WmdDfBqVK2p5e
         7vDQPTrxGI+D12GklrmFM+n1L6hp08d1O0oj3ATNMgtrXhE+1gUAqLlWktRUKNmhNkoj
         XgvC3gamJh3WeQSdOOJrQNDlKVqPnsDYUMs35OdpQmdzEHAaUEZgqQ6lMO379wZczuoG
         w54aJb+czJtYxO/Ml/4WLy+MB/j9Kz9ZyCTW8ILkkzuxtZ/lyHmMlmjdzyqcLz+vDVSu
         Ph+/7JHXqRBQ2ThNHWlYY8LScnxEyMPC8Vrl/mGs/RnIM/KDO1hiOfy7oACCEb6tprBw
         aQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=suyRjY4hRWM09kcSpFkEIs5D6dArl6vQjNWpnTsECKs=;
        b=B6MMsKV3FxGp2mMb12L1daU4jzWgib7OVRC3HvkodaFQRqDT632R7k9/Edso74+O+u
         4Q8dvEsgILaUz6MVJNixiXpqKkfrASLo8H6q3KbGsBRAxHluGFwqpXbToWUL6/11VTqe
         kAQpL0kd2aTloPeOpTcrtywRJpRtgnNgHlM8f/HuApWv1YrqdXLOEUCwt5uD+8MTbSTj
         CSTlhl6+l0pBq8qB+VXR6cUNLo2sSdt6eNfCF9QBXG+wexJpJYIZqavQLsv2i9IZM2OS
         p6aMv1p6s90IYi6gBT7xJN6oKBD0d02W2CCeICGXUkNEOe/64a+hky1KZx5tzZ9+z9/N
         SbMQ==
X-Gm-Message-State: APjAAAUGDjzTDIEdmfvdOEZYHMM5kb2UOc795pT/20aGi8HYrCGIoqNV
        g4lkb++WAa5TAcOicid5jb3eEfPnubjrgk3smTX1NCe7y0o=
X-Google-Smtp-Source: APXvYqyl07gsM90hYOqFRfEpd3/e/sMrsjiklqrxvuScs9MgW5Q+G/SJaTj2tAeMbmf2zHILZ9gKqapQtYG+MQER42g=
X-Received: by 2002:a6b:c081:: with SMTP id q123mr67797478iof.210.1563832405783;
 Mon, 22 Jul 2019 14:53:25 -0700 (PDT)
MIME-Version: 1.0
From:   Dmitry Tunin <hanipouspilot@gmail.com>
Date:   Tue, 23 Jul 2019 00:53:14 +0300
Message-ID: <CANoib0Hn9uNnk5vpjEJUiGriD5rHuDc7xxLFj3r8ij6ALSxcag@mail.gmail.com>
Subject: wireless-regdb: Update regulatory rules for Russia (RU) on 5GHz
To:     seth.forshee@canonical.com
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The db entry looks like this now

country RU: DFS-ETSI
(2402 - 2482 @ 40), (20)
(5170 - 5250 @ 80), (20), AUTO-BW
(5250 - 5330 @ 80), (20), DFS, AUTO-BW
(5650 - 5730 @ 80), (30), DFS
(5735 - 5835 @ 80), (30)
# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_2204=
2015.pdf
(57000 - 66000 @ 2160), (40)


This doesn't look correct. The regulation document is here
http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-=
16_36_03.pdf

According to the regulation document issued Feb 29 2016, there
frequencies should look like this:

country RU:
(2402 - 2482 @ 40), (20)
(5170 - 5330 @ 160), (23), NO-OUTDOOR
(5650 - 5835 @ 160), (23), NO-OUTDOOR
# 60 GHz band channels 1-4, ref: Changes to NLA 124_Order =E2=84=96129_2204=
2015.pdf
(57000 - 66000 @ 2160), (40), NO-OUTDOOR

Note that there was never a DFS requirement in Russia, but always was
NO-OUTDOOR on 5GHz.
Maximum power is 200mW that is ~23dBm on all 5GHz channels.
Also Russia has never been regulated by ETSI.

If this looks good, I can send a patch if needed.
