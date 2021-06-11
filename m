Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFE23A4269
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jun 2021 14:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFKMxH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 08:53:07 -0400
Received: from mail-40136.protonmail.ch ([185.70.40.136]:48549 "EHLO
        mail-40136.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFKMxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 08:53:06 -0400
Date:   Fri, 11 Jun 2021 12:51:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me; s=protonmail;
        t=1623415867; bh=YX/elhhoAJ16RsETk8a0LKlu1vUDc3bt9s7hfTfDKy4=;
        h=Date:To:From:Reply-To:Subject:From;
        b=W82CuaFHbZCOMvqJj/J9wtVYT7iMAQYj/MKeBKIuMmHbkgG0fxTYfr89A7bMq3+Ly
         2S8h7h0cZTHeHCYDu+QsmhA/bMPMns+AAJHEvPtiFBOoQK9FRO8RRfv1UQVvWza/fh
         jBkfC8eGaaBaL7xaetgcq4VuVrn5kmFzVNBcyK8Ts0TADwi61PRl9sKGi5h47pH6VU
         rd8RTWvgAZNVlTJDpcEBpUG+lhL5Mqj5uLBOefutrHlrMJW6iPfrVsmu2I52Rpnef4
         6hPB9Ciakreh3GpIAT/ynQoQGhGvVMpZ0KS6/eYe0kejuAs0f39saOjtE9DA/g0slg
         b8SWRrn1Dqp0A==
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Laaf <Avid.Laaf@pm.me>
Reply-To: Laaf <Avid.Laaf@pm.me>
Subject: IBSS performance issues on CentOS 5.10
Message-ID: <1Sez88avo_70Vy-_hLoHmF9C6xWMf-pGo7BSnamRE476LwxE6en-DjnRVrXd4ihJd1l6YE5Vmvec17ZiU40yFlMoSYX6p5AkNsS-jLHVpGY=@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF shortcircuit=no
        autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Platform: Raspberry Pi 4B / CM4 with CentOS 8 stream 64 bit - 5.10.42 kerne=
l

Trying to use this Mediatek USB device and I notice a - quite nasty - probl=
em using IBSS mode. On startup of the IBSS network, there is a chance the P=
i goes into a tizzy  https://github.com/openwrt/mt76/issues/543- when it's =
the first (and only) node.
I was able to dupe it consistently in my home - fairly static network - but=
 not anymore in a lab environment. I cannot easily go back home - it's ~300=
0km from where I am at temporarily.

Does anyone have experience with these MediaTek devices and B.A.T.M.A.N. on=
 lower performance nodes like a Raspberry Pi...

I have ascertained that NONE of the USB Realtek dongles work, as the kernel=
 driver is missing IBSS support at this time...

I'm against an urgent deadline, and trying to understand what I can do to m=
ake this work

- Maurice
