Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7B63865B
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Nov 2022 10:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiKYJfd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 25 Nov 2022 04:35:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKYJfc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 25 Nov 2022 04:35:32 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7158C27FC0
        for <linux-wireless@vger.kernel.org>; Fri, 25 Nov 2022 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=Aa7Ti6qDDUxCyl6kPQ5pglUYqGOHdSvpDB7Y9K2Y1+g=;
        t=1669368931; x=1670578531; b=Vdjs47l6NqX/5nPlbe0GU6xGU3YWO00K5bJeGgv7vnuYoTF
        bm0Q04kHyb2Kcj2VE/u9FZHvzDDWXRoSMdXLFPIIn/0taENTqVxi5S3HpOh6MyJ6xB4GVyk1AzVPe
        PgW/ibT70BSf36noeHFIplpbKDvxonyJLHG9fKPT5fh8ZPKyXD5yWl/9qjv4oAdQkidqgNRTUDcoK
        e8TX5B0AIOIlwCCqCaIqTeg8iPv/j3clXqCXuXxHHckoCZXeq3VXj3CeQhFPxowk3qQwrANXXwgrl
        0YikwF9K7JSdWbdC3SKHu/9XjWzdTVhkytoaefhd3kaQEnFXGS4g4iQt/2t9fC2A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oyV7J-008oKY-2m;
        Fri, 25 Nov 2022 10:35:29 +0100
Message-ID: <ce7eadda8c1fe68d23f67315e31d6249b36c7563.camel@sipsolutions.net>
Subject: Re: PRO/Wireless 2200BG Intel WPA3 SSID connection problem #1
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ioannis Barkas <jnyb.de@gmail.com>, linux-wireless@vger.kernel.org
Date:   Fri, 25 Nov 2022 10:35:28 +0100
In-Reply-To: <CADUzMVbL0ujvdRDCcQS0uBxruVYW3XV335wAz27AA80x5q9kOQ@mail.gmail.com>
References: <CADUzMVbL0ujvdRDCcQS0uBxruVYW3XV335wAz27AA80x5q9kOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> This period I have been dealing with WLANs as I have added a new WPA3
> SSID and fell on some trouble and limitations(more messages will
> follow on this).
>=20

Well, keep in mind that WPA3 requires all kinds of new things, and the
*most recent* NIC you tried is already ~11 years old afaict.

> Long story short, some WLAN cards do not work and
> some Android based mobile phones do not work(like my Android 12 based
> SAMSUNG M31 which is not detecting such SSIDs at all!). On one hand,
> vendors like Atheros have done a good job. As a result, all cards were
> able to connect successfully at SSID using the WPA3 encryption. This
> includes miniPCI, PCI, miniPCIe, Cardbus and USB adapters.
>=20

This probably means they use SW crypto for everything.

> On the
> other hand vendors like Intel haven't done a really good job. miniPCI
> cards from Intel are out of question due to legacy driver and custom
> 802.11 implementation. Initial miniPCIe cards like 4965 series do not
> support it similar to many iwlwifi cards. I believe that all iwlwifi
> supported cards should be able to use WPA3.

What makes you believe that?

> My 2006 Atheros cards
> connect successfully so I expect the same for intel cards launched a
> decade after the old Atheros cards otherwise we should blacklist such
> devices to save lots of noise from bug reports about undetected
> networks.=C2=A0

Umm, no? Why would we break NICs that work well with most existing
networks, just not WPA3 ones?

> Hopefully the Intel team will fix everything so that noone
> will not need to switch cards on laptops.=C2=A0
>=20

Unlikely. The newest Intel NIC in your list was 6205, which was released
in 2011.

Without wpa_supplicant logs I'm not even sure why it's broken, but
likely the reason is that it doesn't advertise management frame
protection support since the firmware handles certain management frames,
and there was no hardware offload for those at the time.

(This might be a difference to Atheros NICs.)
>=20

> It can't connect to WPA3 2,4GHz SSID and I got no logs.

Well, you should look at wpa_supplicant logs.


johannes
