Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3F785B0CA
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2019 19:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbfF3RGu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Jun 2019 13:06:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36950 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF3RGu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Jun 2019 13:06:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14so11216716wrr.4
        for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2019 10:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VadvVfJRUsXCCVwcZQ6442rizseWUssLKQnSOoBCOI0=;
        b=NnJhcJRWIEkZ6grgwio3KYkFwBQRrjarMdHKZS4UtYGO/hAnZFhBdCpJG7MUXwkEHz
         ZuudbzbfrysyPdCeHVc+1avxE/Btge+yp8PU/QvSNkcnxHYZOSql1HEM7hyFaxgH1MuZ
         Zf+0+HVBjRwYdm+NrXWZiL7oOFr/b9Exj/BtP/E0JxxDGfmuT5L7Lspkoyo7RCfP23HK
         +SE49D8TQP6H/UQEI19rRUxWZXVee4GqSbcBkgDeHuhSvpZr+rkUMAzW47n6ZXTrik4x
         JcRTPm0WhriXW1AO9UXWSK+b2ryJXf+1SJPZN1P6goizpODjTd9V04K1qe2HWbnNFH7o
         BNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VadvVfJRUsXCCVwcZQ6442rizseWUssLKQnSOoBCOI0=;
        b=tfusNlsTLZn/88cvFuliCcbVHO382GLz+GqknV58FQyKbIt/aAO5Yy9OOABkjyx7sg
         1LkUCfsDgoXISIMLxFfNXs5VnxupZEscvWPlm+H5VejxOqbdKtfX4tYe+YxdPjrUb8of
         Bvdok2PHG1n5bxfv59hc1X0XwMJXxkxgA/sUVzqAhatre6ZYTCBGNqtB2yttNWICCWq3
         Ja/54CwdykUC9+zRf3HDriWk8fkoRT2fJ2opeUubT6RYg8xilWR0knXQrbVYdM6zf4Lz
         ITb+jMm8T2iXuW5/vyDqIyu0YplQbezVC7V4Dg93BjDMJiL8r34TjjsvKd+sM7lZcfJi
         FvHg==
X-Gm-Message-State: APjAAAVU66js3Xskcl7p+5ga7DV1hAaTqCnlKi6sLFXPrYchkcJ5Ml52
        iJibDIXaZt/lMn/EYmCIsqsMcUSnOoI=
X-Google-Smtp-Source: APXvYqwl5VjqXq5j6JHePn/96pXSBQum5ybFYn7iZycw9EFTaeb/XvN7zH0yh2WyqaxUvqXLEf/tRw==
X-Received: by 2002:a5d:4992:: with SMTP id r18mr15499776wrq.107.1561914408511;
        Sun, 30 Jun 2019 10:06:48 -0700 (PDT)
Received: from ultraworld.home (host86-143-16-37.range86-143.btcentralplus.com. [86.143.16.37])
        by smtp.gmail.com with ESMTPSA id a12sm6089527wrr.70.2019.06.30.10.06.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Jun 2019 10:06:47 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [RESEND] brcmfmac support for BCM4359 sdio on arm64 ??
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
Date:   Sun, 30 Jun 2019 18:06:45 +0100
Cc:     linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, Wright.Feng@cypress.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <312E6304-FD5D-4FA8-8A0C-6FA604083D3E@gmail.com>
References: <F5C2858A-498E-4AD3-859D-FA9D14BF6B37@gmail.com>
 <37d2964d-1c2b-51bd-ac98-2cc171aa0c9c@broadcom.com>
 <30516339-BAD7-40F4-980B-D30CDF504A08@gmail.com>
 <db1e6182-d8fe-a68a-e769-b6460c68fab0@broadcom.com>
To:     Arend Van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3445.104.11)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 24 Jun 2019, at 8:04 pm, Arend Van Spriel =
<arend.vanspriel@broadcom.com> wrote:
>=20
> Hi Christian,
>=20
> Here it is. Hopefully unmangled this time.

Hi Arend.

The extra logging patch is un-mangled and applies fine, but I bumped to =
5.2-rc4 recently (and now 5.2-rc7) and hit a major problem.

If I add the BCM4359 device ID=E2=80=99s with the following commit I see =
a brcmfmac splat and the system fails to boot.

commit: =
https://github.com/chewitt/linux/commit/f07161815699a48e636600a0b835d7ff64=
715383
splat: https://imgur.com/a/28wu5kh
defconfig: =
https://github.com/chewitt/LibreELEC.tv/blob/amlogic-master/projects/Amlog=
ic/linux/linux.aarch64.conf

Adding the extra logging changes you suggested is not the issue, it=E2=80=99=
s adding the device ID=E2=80=99s.

I was previously using 5.1-rc1 and 5.1.9 kernels and didn=E2=80=99t see =
any issues adding the ID=E2=80=99s.

Any ideas?

Christian=
