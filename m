Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB5521E1250
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2020 18:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbgEYQFJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 May 2020 12:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388432AbgEYQFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 May 2020 12:05:09 -0400
Received: from dvalin.narfation.org (dvalin.narfation.org [IPv6:2a00:17d8:100::8b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDC4C061A0E
        for <linux-wireless@vger.kernel.org>; Mon, 25 May 2020 09:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1590422704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WSknnTEelKDGTuse5nRhrnX6VQ35I6QBIT1ENiOtNh8=;
        b=1TXsAliuxu9Aka01DX7EZlS6dgwHJPJqkUr6tn2n4+wO7/kS71fP+jOkUiuyQvVuv28aXT
        7CVABCeM92HCHZwvWJmV+55CaUBAVzBt1rrLdhNn7PwxOYY5yJtm0EOfMqK8WwXrwFMcoV
        nKM61v/6SfjaM3xljjE9v18fGnF5sik=
From:   Sven Eckelmann <sven@narfation.org>
To:     Sebastian Gottschall <s.gottschall@dd-wrt.com>
Cc:     ath10k@lists.infradead.org, John Crispin <john@phrozen.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        openwrt-devel@lists.openwrt.org, Kalle Valo <kvalo@codeaurora.org>,
        Sebastian Gottschall <s.gottschall@newmedia-net.de>,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v13] ath10k: add LED and GPIO controlling support for various chipsets
Date:   Mon, 25 May 2020 18:04:49 +0200
Message-ID: <3445075.COMLMNsY4U@bentobox>
In-Reply-To: <3608947.bSrYYtX6KI@bentobox>
References: <1523027875-5143-1-git-send-email-kvalo@codeaurora.org> <b23e65cf-4be7-72db-7955-32eae196953e@dd-wrt.com> <3608947.bSrYYtX6KI@bentobox>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3096809.FUlXiXFBBX"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3096809.FUlXiXFBBX
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 May 2020 11:22:13 CEST Sven Eckelmann wrote:
[...]
> And it still can with this OpenWrt version. But it doesn't seem to happen with 
> the most recent OpenWrt reboot-13353-gb1604b744b. But there are nearly 4000 
> commits inbetween. So no idea what changed (just a timing thing or an actual 
> fix - no idea).

Seems like there is a fix which solves some lost interrupt problems for 
IPQ40xx. Without this change, I see the reported problem. And with the patch, 
it is gone. Or in commits:

* creates timeout problems: 46b949a067e5 ("ipq40xx: enlarge PCIe BAR size")
* works fine: 18e942b6c4e5 ("ipq40xx: fix pcie msi IRQ trigger level")

If you look in the git logs [1], you can see that the working commit is a 
child of the broken one. So at least from my point of view, my initial report 
is no blocker anymore for Sebastian's patch (or Kalle's version of it).

Btw. OpenWrt is automatically assigning a trigger (phy*tpt) for these LEDs.

Kind regards,
	Sven

[1] https://git.openwrt.org/?p=openwrt/openwrt.git;a=log;h=18e942b6c4e51a5a717a121697a63f3f98d93b19
--nextPart3096809.FUlXiXFBBX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAl7L7KEACgkQXYcKB8Em
e0YDExAAvLYXS4zpbkE17T7xWf7LcteEbclolX0FYft3zOSe7xE0wjqT2N9n6yhk
F9WF/jJdWnGgxDHOqGUSbK3OYBGTzO5f4ZTRwIa1ag0gQtdqwshPPrkjU3L/0+DN
kCyNZ5qfvgAlwzEo8sfvNiorKi6GexqEDgy5AUDZYVmSIJ3kFtiM4Llovn/ouPj9
AEg/JwopaB/ZkhVTyzTtiRz4dJbMSEcWPn6f47SK2NMY4+GJLkg4bUJdSZ1NVmVT
W0VzRUdX3zYIx+HAdmtoTj2OO4PnWcdi4m94eRVnvjgOwaa2DTPx/Y7wH45zJGnP
IQdXGs8GuDHTKoJWtMGGPqmOt4mqc4amdOZb9Dq63c4IMKDrwwwSsGi8HaQQyjJq
ChI2EmDNuKIZ8mIwLxpTv3hAZaol/iCkvVPaLBVJc8wH9rdHO/O1G5CimoZqGu9d
3umD+laVmJvzZe1FzKLRGfa57w2W9BSnqq3WQM7/UQC03NZeQjuPEV7mY0VxyEQi
GNEsm3zU5IWwsQxSkNbSZC+KypHYhZL/sm/ES7ubhZkkMlJeFnOnFxjgavr1lNmq
GCUOFSeiklgfV3Sf2aPwFdxDRusACEaaVujFu4h6qzI+U5Ob66vsam0q+RW1XIpm
t82QMQhLTDK7zfZr9PQvFaFf4B/9vRpg3jxWmRPjDfwTb7b3Cwk=
=Ahpg
-----END PGP SIGNATURE-----

--nextPart3096809.FUlXiXFBBX--



