Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4A2284494
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Oct 2020 06:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgJFEW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Oct 2020 00:22:26 -0400
Received: from mail-41104.protonmail.ch ([185.70.41.104]:55542 "EHLO
        mail-41104.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgJFEW0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Oct 2020 00:22:26 -0400
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail-41104.protonmail.ch (Postfix) with ESMTPS id AC93120021CE
        for <linux-wireless@vger.kernel.org>; Tue,  6 Oct 2020 04:22:23 +0000 (UTC)
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="IF60/54e"
Date:   Tue, 06 Oct 2020 04:22:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1601958140;
        bh=0uL+oKdZ+kIeGKgDRmsSuusyePnfIt0hi8CQ7e378S0=;
        h=Date:To:From:Cc:Reply-To:Subject:From;
        b=IF60/54eovN4JhWjC/GAGNk93iXPz3RrokoXxvGTywJy5ILvTGTPeD/jbznsld95l
         9o48p9UsgUQ3r/ugkuwhVXaSwkIc/W4sEvpaXncRjWELFUsJ9Fc2Km65RmF8+n8evB
         Y8KoFm8CMDRnGscI9i2u0Z2SdjfWxPnf0gIiAA3Q=
To:     "johannes@sipsolutions.net" <johannes@sipsolutions.net>
From:   Ttttabcd <ttttabcd@protonmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Reply-To: Ttttabcd <ttttabcd@protonmail.com>
Subject: [PATCH] iw: Add support for specifying the 160MHz bandwidth when setting the channel/frequency
Message-ID: <cIf-30s-5axo5iDqyzwY9VTVB_JLKCXbxlXdODMSK61q-yFzR6rtAk8URRAPavRlllrwXr1Q-jtem_upoCNKd_fba8qmM0DpJn0O7MIkq6o=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current iw tool only supports the direct setting of
[NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] bandwidth
when setting the channel/frequency.

If we want to set the 160MHz bandwidth,
we need to calculate the center frequency ourselves,
which is inconvenient.

E.g:
iw phy phy0 set freq 5220 160 5250

From now on we can:
iw phy phy0 set channel 44 160MHz
iw phy phy0 set freq 5220 160MHz

This is much more convenient.

Signed-off-by: AK Deng <ttttabcd@protonmail.com>
---
 phy.c  |  8 ++++----
 util.c | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/phy.c b/phy.c
index 716677e..2d489ef 100644
--- a/phy.c
+++ b/phy.c
@@ -199,13 +199,13 @@ static int handle_freq(struct nl80211_state *state, s=
truct nl_msg *msg,
 }

 COMMAND(set, freq,
-=09"<freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+=09"<freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]\n"
 =09"<control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_fre=
q>]]",
 =09NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_freq,
 =09"Set frequency/channel the hardware is using, including HT\n"
 =09"configuration.");
 COMMAND(set, freq,
-=09"<freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+=09"<freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]\n"
 =09"<control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_fre=
q>]]",
 =09NL80211_CMD_SET_WIPHY, 0, CIB_NETDEV, handle_freq, NULL);

@@ -222,9 +222,9 @@ static int handle_chan(struct nl80211_state *state, str=
uct nl_msg *msg,

 =09return put_chandef(msg, &chandef);
 }
-COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]"=
,
+COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|1=
60MHz]",
 =09NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_chan, NULL);
-COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]"=
,
+COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|1=
60MHz]",
 =09NL80211_CMD_SET_WIPHY, 0, CIB_NETDEV, handle_chan, NULL);


diff --git a/util.c b/util.c
index 186e05b..647e85a 100644
--- a/util.c
+++ b/util.c
@@ -576,10 +576,10 @@ static int parse_freqs(struct chandef *chandef, int a=
rgc, char **argv,
  * user by giving "NOHT" instead.
  *
  * The working specifier if chan is set are:
- *   <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]
+ *   <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
  *
  * And if frequency is set:
- *   <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]
+ *   <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
  *   <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_fr=
eq>]]
  *
  * If the mode/channel width is not given the NOHT is assumed.
@@ -619,6 +619,10 @@ int parse_freqchan(struct chandef *chandef, bool chan,=
 int argc, char **argv,
 =09=09  .width =3D NL80211_CHAN_WIDTH_80,
 =09=09  .freq1_diff =3D 0,
 =09=09  .chantype =3D -1 },
+=09=09{ .name =3D "160MHz",
+=09=09  .width =3D NL80211_CHAN_WIDTH_160,
+=09=09  .freq1_diff =3D 0,
+=09=09  .chantype =3D -1 },
 =09};
 =09const struct chanmode *chanmode_selected =3D NULL;
 =09unsigned int freq;
@@ -1233,6 +1237,7 @@ int get_cf1(const struct chanmode *chanmode, unsigned=
 long freq)
 {
 =09unsigned int cf1 =3D freq, j;
 =09unsigned int vht80[] =3D { 5180, 5260, 5500, 5580, 5660, 5745 };
+=09unsigned int vht160[] =3D { 5180, 5500 };

 =09switch (chanmode->width) {
 =09case NL80211_CHAN_WIDTH_80:
@@ -1247,6 +1252,18 @@ int get_cf1(const struct chanmode *chanmode, unsigne=
d long freq)

 =09=09cf1 =3D vht80[j] + 30;
 =09=09break;
+=09case NL80211_CHAN_WIDTH_160:
+=09=09/* setup center_freq1 */
+=09=09for (j =3D 0; j < ARRAY_SIZE(vht160); j++) {
+=09=09=09if (freq >=3D vht160[j] && freq < vht160[j] + 160)
+=09=09=09=09break;
+=09=09}
+
+=09=09if (j =3D=3D ARRAY_SIZE(vht160))
+=09=09=09break;
+
+=09=09cf1 =3D vht160[j] + 70;
+=09=09break;
 =09default:
 =09=09cf1 =3D freq + chanmode->freq1_diff;
 =09=09break;
--
2.28.0

