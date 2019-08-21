Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62CBB98671
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 23:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfHUVRX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 17:17:23 -0400
Received: from ocelot.miegl.cz ([195.201.216.236]:32926 "EHLO ocelot.miegl.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727136AbfHUVRX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 17:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=miegl.cz; s=dkim;
        t=1566422240; bh=RXmQ3+KVC9WaR+KwYlpMgwzuiI6xjT9dpoe+2/HhEQQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From;
        b=EJvZ6LugDRle/wsTxweIwssT6dESZZfqop6PsDM1YxPED1NblZKaeKNX2kChR/fxA
         Wx8tA8T/PjJQnxbdTELRH7zJ5gnPHZBK9gArvIqc3bKw4XpT1xdDEssECQ6MESgFgP
         bH7difno7fYUk7LdJWybJlwJ/beuq+1sXjBD2O1dn9RrGUck7K7sDZMwzC+0V/qoZv
         gYhhB77B2TWFdzuCZOwim/F5td9a9I437JXD97LkQxqfhEyDzNj+fE2s1I+nLYZQf9
         QlXWVL32VcR5va4P/IumTZlFRhXuO8Undr0jNIcrctYIBt7JMu/Rycc2UyjV5EgwOs
         87VJUQdQzYkrg==
Date:   Wed, 21 Aug 2019 23:17:18 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
References: <20190815152844.k5mmddvbwrohkzr6@pepin-laptop.localdomain> <3a079683-6f57-3b42-f909-90c46e14f14f@newmedia-net.de> <20190816111044.4ntizgmpa3twbzcg@pepin-laptop.localdomain> <e8129acb-fc32-c85c-b504-ab8777a3f1a3@newmedia-net.de> <20190816113818.ohktykc4fyetzyvq@pepin-laptop.localdomain> <9985fddfb059640f36665efc9c1ef2dc0bdb7662.camel@sipsolutions.net> <20190819113706.ujsz67sxcwt2ulmt@pepin-laptop.localdomain> <b3b7a99971f1512b4cd9c72920b699c252c1ae83.camel@sipsolutions.net> <A3C14EA9-BA2D-4745-BBB9-E10028B6DE13@miegl.cz> <6efb9b56c77cd9ea945f89c3371b49c301dc2b4e.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Implementing Mikrotik IE
To:     Johannes Berg <johannes@sipsolutions.net>
CC:     Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless <linux-wireless@vger.kernel.org>
From:   Josef Miegl <josef@miegl.cz>
Message-ID: <58A25955-2A17-4DE7-82FB-3B20E00C96EC@miegl.cz>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On August 21, 2019 10:12:26 PM GMT+02:00, Johannes Berg <johannes@sipsoluti=
ons=2Enet> wrote:
>What AP are you trying to connect to? Have you tried adding some other
>random vendor IE, with an OUI that the AP is almost certain to not
>know?
>Maybe it's actually interpreting this somehow?
>
>Would you be willing to show sniffer captures so we could take a look?
>
>johannes

Of course it's interpreting the IE=2E Random vendor IE works fine=2E Let m=
e explain why I'm even bothering with sending this mikrotik IE in associati=
on requests=2E The Mikrotik IE has a flag that tells the AP if the station =
wants WDS=2E Setting that flag and sending the mikrotik IE is required for =
transparent bridging with a mikrotik AP=2E

Sending the Mikrotik IE with the WDS bit set to 0 works fine=2E Now I'm su=
re this is a problem on Mikrotiks side, however in ubnts airos this works a=
s expected, and since their airos is probably based on openwrt there has to=
 be a way to make this work=2E

I will send you the captures, however there doesn't seem to be anything mu=
ch interesting in them=2E
Josef
