Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9BE3E8406
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Aug 2021 21:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhHJT7p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Aug 2021 15:59:45 -0400
Received: from mail-0201.mail-europe.com ([51.77.79.158]:38397 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhHJT7o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Aug 2021 15:59:44 -0400
Date:   Tue, 10 Aug 2021 19:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1628625558;
        bh=JpwKQU7qJGvcJbOmub6Vo4gSKW3dGyhyyY1vRQB7Uo4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=YthvMLKdgFD0TDoG/Pk6rBF5GZj0q9my5X8G4kxdXL5xdhDhxGTa/jUv1XT6GDMH1
         Bz4Lr6Q5orNffC/BDuW6KmIvWwQHygq7DW1q2RBN5k5rOJQn178kqVYRk8oMv7qm8o
         KYXMTnUB9aDn1NBF489aKW8Csh8OZ5d+YNV+0ct0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Michael Yartys <michael.yartys@protonmail.com>
Reply-To: Michael Yartys <michael.yartys@protonmail.com>
Subject: Not able to roam on FT-SAE network
Message-ID: <NB-cdP_zWop55KKgEYOXNh25URknq08i4hqQ2mRF9aVBi6YFIlJaYIk9pg1ewyJY7hLC1x8mtEFX5WyutbN3YZRoyaJMvOpn7MH2GsUTv7o=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

I've been running an FT-SAE network for quite some time now, and I've long =
noticed that my both my laptops with Intel 7260AC cards are unable to roam =
from one AP to another. When I move the laptops to an area with poor signal=
 strength the background scanning of NetworkManager/hostapd is triggered as=
 expected and a roam appears to be initiated, but instead of successfully r=
oaming to the other AP with better signal strength it ends up returning to =
the current AP. This keeps on happening until I either manually disable and=
 re-enable wifi, or if I move back to an area where the current AP has good=
 signal strength. The laptops are running the following distros, kernels an=
d wpa_supplicant versions:

-- Laptop 1 --
* Fedora 34
* 5.13.8-200
* wpa_supplicant v2.9

-- Laptop 2 --
* Ubuntu 20.04.2 LTS
* 5.11.0-25
* wpa_supplicant v2.10-devel-hostap_2_9-2285-gc3155a725 (recent snapshot)

I can provide relevant logs from wpa_supplicant and the APs to developers p=
ersonally.

Michael
