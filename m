Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 146EF2FB130
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Jan 2021 07:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbhASGKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 01:10:17 -0500
Received: from mail-02.mail-europe.com ([51.89.119.103]:48758 "EHLO
        mail-02.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390462AbhASFam (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 00:30:42 -0500
Date:   Tue, 19 Jan 2021 05:29:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1611034150;
        bh=IdgqE5AmCK6s+9cL32+cDBDpit/K3Mz/iWpiUoTHZko=;
        h=Date:To:From:Reply-To:Subject:From;
        b=ESQ16yRbB7kYXzo3gtYhSBKXBkOJ0P2+miQKTCc7w+N5tMoHMKomJxdno9JWCCpJZ
         1VXpnXBIIzbEuuzGx/1HSpUV4GbCKO8m03hbE5rCtqH2OzPwjTBt6Q8vr+bekpum4q
         MyahPFwfBMaG7z7VGaiWvLFlevZohvkwGKfFmxUg=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   John Kavan <jkvt@protonmail.com>
Reply-To: John Kavan <jkvt@protonmail.com>
Subject: DFS/radar detection in mt7612 vs mt7612u
Message-ID: <dUoftpoHuAmD7Z8azZFQxfzyVrbsJ_0yvg4NXMPAN4IT7x-HJtnyIKkyPAMHQPPivCkXNmlSDHj_nZWX3tfwUA4O-5VKs9a9zw4_YW_28WQ=@protonmail.com>
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

Hi,

mt7612u does not seem to have DFS/radar detection enabled, while mt7612 has=
 it enabled according to a snipped below from mt76x02_util.c where radar_de=
tect_widths is not defined for mt7612u

Any particular reason for that, can DFS be enabled on mt7612u?


Thanks!


static const struct ieee80211_iface_combination mt76x02_if_comb[] =3D {
=09{
=09=09.limits =3D mt76x02_if_limits,
=09=09.n_limits =3D ARRAY_SIZE(mt76x02_if_limits),
=09=09.max_interfaces =3D 8,
=09=09.num_different_channels =3D 1,
=09=09.beacon_int_infra_match =3D true,
=09=09.radar_detect_widths =3D BIT(NL80211_CHAN_WIDTH_20_NOHT) |
=09=09=09=09       BIT(NL80211_CHAN_WIDTH_20) |
=09=09=09=09       BIT(NL80211_CHAN_WIDTH_40) |
=09=09=09=09       BIT(NL80211_CHAN_WIDTH_80),
=09}
};

static const struct ieee80211_iface_combination mt76x02u_if_comb[] =3D {
=09{
=09=09.limits =3D mt76x02u_if_limits,
=09=09.n_limits =3D ARRAY_SIZE(mt76x02u_if_limits),
=09=09.max_interfaces =3D 2,
=09=09.num_different_channels =3D 1,
=09=09.beacon_int_infra_match =3D true,
=09}
};

