Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C434AFDAF
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 20:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiBITsV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 14:48:21 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBITsT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 14:48:19 -0500
Received: from w4.tutanota.de (w4.tutanota.de [81.3.6.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F45AE030D57
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 11:48:18 -0800 (PST)
Received: from w3.tutanota.de (unknown [192.168.1.164])
        by w4.tutanota.de (Postfix) with ESMTP id 337EC1060255
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 19:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1644436097;
        s=s1; d=leirbag.net;
        h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
        bh=9LzdXbOQ9dOsP3wCrsq7zxlsTXBFmWidOqGNEB2iI0I=;
        b=ASh2SmmChJ/1lr71Ct5fe6eggaTZolk+Fk/z6YDBBY3RVq8WFaUroS9KOWxgcx0B
        gi9rXipYdaHiBYbHaiuRolHqr36lFU53qn+KkhycmJrwIO0pq1DVnUZPdSMcdpFY8EF
        cYUtrsd0JQ01EX2zRUjdFOA236gwDNsgWUSZ0pPUS4UjjN/GcRPGSnBmGLeo8UgOqcF
        9Me2jyjOOPEavqeuFlgO/EytPzs1hdtvF9LEJjDxRgTBB/WAGrW6+mnqeutd+EHZqxa
        l+jXaOqi9pVW06l/hqV9rBxYz1/ErnrCqNV19HhbN4qkkqSJQCwg1p7DZOYXQW6IlQ1
        ykX5naxIPw==
Date:   Wed, 9 Feb 2022 20:48:17 +0100 (CET)
From:   =?UTF-8?Q?Gabriel_F=C3=A9ron?= <g@leirbag.net>
To:     Linux Wireless <linux-wireless@vger.kernel.org>
Message-ID: <MvV0sOB--3-2@leirbag.net>
Subject: Disconnection every 10 minutes with mt7921e
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I have a laptop with a MediaTek mt7921 wireless chip, and I'm getting disco=
nnected from the AP every 10 minutes (PREV_AUTH_NOT_VALID). I've tried to d=
isable aspm, without any noticeable improvements.

The only relevant information to my problem I found on the mailing list was=
 regarding a problem that could lead to the driver preventing wpa_supplican=
t from receiving EAPOL frames.

I'm currently running a manually built kernel 5.17.0-0.rc3.20220208git555f3=
d7be91a on Fedora 35 (to toggle the requested CONFIG_MAC80211_ debugging bu=
ild options).

So far, I haven't seen anything suspicious from wpa_supplicant, which simpl=
y reacts to the event accordingly (from events NL80211_CMD_DEL_STATION then=
 NL80211_CMD_DISASSOCIATE).

-- lspci

03:00.0 Network controller: MEDIATEK Corp. MT7921 802.11ax PCI Express Wire=
less Network Ada
pter
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Lenovo Device e0bc
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: mt7921e
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Kernel modules: mt7921e

-- iw events

wlp3s0: del station 34:xx:xx:xx:xx:xx
wlp3s0 (phy #0): disassoc 34:xx:xx:xx:xx:xx -> b4:xx:xx:xx:xx:xx reason 2: =
Previous authentication no longer valid
wlp3s0 (phy #0): disconnected (by AP) reason: 2: Previous authentication no=
 longer valid
phy #0: regulatory domain change: set to world roaming by the wireless core=
 upon initialization request
regulatory domain change: set to DE by a user request
wlp3s0 (phy #0): scan started
wlp3s0 (phy #0): scan finished: 2462, "XXXXX" ""
wlp3s0 (phy #0): scan started
wlp3s0 (phy #0): scan finished: 2412 2417 2422 2427 2432 2437 2442 2447 245=
2 2457 2462 2467 2472 5180 5200 5220 5240 5260 5280 5300 5320 5500 5520 554=
0 5560 5580 5600 5620 5640 5660 5680 5700 5720 5745 5765 5785 5805 5825 584=
5 5865, "XXXXX" ""
wlp3s0: new station 34:xx:xx:xx:xx:xx
wlp3s0 (phy #0): auth 34:xx:xx:xx:xx:xx -> b4:xx:xx:xx:xx:xx status: 0: Suc=
cessful
wlp3s0 (phy #0): assoc 34:xx:xx:xx:xx:xx -> b4:xx:xx:xx:xx:xx status: 0: Su=
ccessful
wlp3s0 (phy #0): connected to 34:xx:xx:xx:xx:xx

-- dmesg

wlp3s0: disassociated from 34:xx:xx:xx:xx:xx (Reason: 2=3DPREV_AUTH_NOT_VAL=
ID)
wlp3s0: authenticate with 34:xx:xx:xx:xx:xx
wlp3s0: send auth to 34:xx:xx:xx:xx:xx (try 1/3)
wlp3s0: authenticated
wlp3s0: associate with 34:xx:xx:xx:xx:xx (try 1/3)
wlp3s0: RX AssocResp from 34:xx:xx:xx:xx:xx (capab=3D0x1511 status=3D0 aid=
=3D1)
wlp3s0: associated
wlp3s0: Limiting TX power to 23 (23 - 0) dBm as advertised by 34:xx:xx:xx:x=
x:xx

Thanks,
--
Gabriel F=C3=A9ron
