Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0FF9882A
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 01:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729644AbfHUX5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 19:57:42 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32938 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfHUX5m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 19:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566431858; bh=rK/Pi7EguZq44uQT0yZvSGUkDVb+LvjOSqIOOcFIEBw=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=iaDJtpn20bGQKet9KP8tUnGIOcGIStgS84tc3zhBzNFO67kNUDmXBHHZjX1eC1HzD
         OCdbZ3ytWTZK5sPn0c+Kl82gL2GYR9ULFGFuRiCeaxzDdqcvpVfC47FTG4AhwR5T2W
         p2k53T9rOu8t+Ls7LgGJs0a9p/ObCX/wR/DxfkZmD4EQW11VPHBmmUHyIX6Tz/NGLo
         PXnqUkHH2/OT3/0m/eM4R/rQMjUYuDeA+XJ5n7F/El1FA2au08l6zem/iCgve+8C3W
         HHDtBK62aMBUFMNDekHiVsxmv0YmMLqW7ZWlDrTHaW+ZL66GUXRd3SEA2Pul3t7CWg
         /jHB0wc3F1HWw==
Date:   Thu, 22 Aug 2019 01:57:34 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <8ec8202e-ca07-3594-5873-5b282d553711@newmedia-net.de>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain> <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de> <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain> <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de> <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain> <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net> <b8009787-a182-d5f2-6dde-ee540c65a03b@newmedia-net.de> <bb0d7dd87a7821df245919c86458bd50a3d1a81e.camel@sipsolutions.net> <8ec8202e-ca07-3594-5873-5b282d553711@newmedia-net.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Implementing Mikrotik IE
To:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        Johannes Berg <johannes@sipsolutions.net>
CC:     linux-wireless <linux-wireless@vger.kernel.org>
From:   Josef Miegl <josef@miegl.cz>
Message-ID: <E28FAC24-4B21-48FB-A010-770BCEF4CCA1@miegl.cz>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 20, 2019 2:36:21 PM GMT+02:00, Sebastian Gottschall <s=2Egottscha=
ll@newmedia-net=2Ede> wrote:
>i know=2E thats why i never even tried to contribute it upstream=2E but
>from=20
>hostapd side it was more complicated than just hacking mac80211
>and from stations a second mod for wpa_supplicant would be needed and=20
>since the dd-wrt webgui just uses nl80211 to show the station table
>its more comportable and takes less code just todo it within the driver
>i there is special interest in it i could of course try to clean it up=20
>and make a upstream patch out of it

I don't think something like Mikrotiks IE belongs to hostapd=2E The cleane=
st solution is probably parsing the IE and generating the IE for hostapd wi=
th an external tool, that can the dd-wrt GUI then use=2E I've made a simple=
 C program for this, can share if you want=2E

Josef

Josef
