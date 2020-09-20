Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27AD2711E1
	for <lists+linux-wireless@lfdr.de>; Sun, 20 Sep 2020 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgITDAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 19 Sep 2020 23:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITDAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 19 Sep 2020 23:00:13 -0400
Received: from mxout012.mail.hostpoint.ch (mxout012.mail.hostpoint.ch [IPv6:2a00:d70:0:e::312])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443E0C061755
        for <linux-wireless@vger.kernel.org>; Sat, 19 Sep 2020 20:00:13 -0700 (PDT)
Received: from [10.0.2.44] (helo=asmtp014.mail.hostpoint.ch)
        by mxout012.mail.hostpoint.ch with esmtp (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kJpaE-000Olu-Eo; Sun, 20 Sep 2020 05:00:10 +0200
Received: from [2a02:168:6182:1:c8fe:6df8:e928:a08a]
        by asmtp014.mail.hostpoint.ch with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3 (FreeBSD))
        (envelope-from <code@reto-schneider.ch>)
        id 1kJpaE-0007Pq-Cj; Sun, 20 Sep 2020 05:00:10 +0200
X-Authenticated-Sender-Id: reto-schneider@reto-schneider.ch
Subject: Re: [PATCH v2 1/1] rtlwifi: v88.2 firmware files for RTL8192CU
To:     Josh Boyer <jwboyer@kernel.org>, Chris Chiu <chiu@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Jes.Sorensen@gmail.com
Cc:     Reto Schneider <code@reto-schneider.ch>,
        Linux Firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
References: <20200323024500.4090-1-code@reto-schneider.ch>
 <20200323225809.11594-1-code@reto-schneider.ch>
 <20200323225809.11594-2-code@reto-schneider.ch>
 <CAB4CAwcj3wNociyMoszY50yWsE=Xy_6JLpYi=kuTj261uat6pA@mail.gmail.com>
 <CA+5PVA7WLAGP6oL8pxGvjqHS030LoDTcz5-YDHVjYaYVHOZD2g@mail.gmail.com>
From:   Reto Schneider <code@reto-schneider.ch>
Autocrypt: addr=mail@reto-schneider.ch; prefer-encrypt=mutual; keydata=
 mDMEXsRRExYJKwYBBAHaRw8BAQdAvw3GH8aeA8Pay1QqPdjlETAUDAa8WmHHXZRDk5a0DHa0
 J1JldG8gU2NobmVpZGVyIDxtYWlsQHJldG8tc2NobmVpZGVyLmNoPoiYBBMWCgBAFiEEP2/t
 baSDn9KAkTQyv7k+j0IlhuAFAl7EURMCGwMFCQWjmoAICwkNCAwHCwoFFQoJCAsEFgMCAQIe
 AQIXgAAKCRC/uT6PQiWG4IsVAP9xonMRrcrTBWFxPMjEYVWUMHi8BssqkzMdc1QQXwpCKwEA
 qdBF1odOUr4SUHVQmadIE5eRpF9MbyBMQdR3ms8DrQ64OARexFETEgorBgEEAZdVAQUBAQdA
 6PW5+rUjfrKbl3623SR35Drobzij2XjkGFY6zswMz3EDAQgHiH4EGBYKACYWIQQ/b+1tpIOf
 0oCRNDK/uT6PQiWG4AUCXsRREwIbDAUJBaOagAAKCRC/uT6PQiWG4IyHAQCqmjwBTGyVAfLZ
 OVQSUPqSlu/RGcCWPQFEXP+Be2mdNQEA05ScK4+GgAShVE8wUObbpjdl/u5djZF8hEGQR3Ke Vws=
Message-ID: <744509e3-d3f6-21bd-3f6b-83a93d88d7df@reto-schneider.ch>
Date:   Sun, 20 Sep 2020 05:00:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+5PVA7WLAGP6oL8pxGvjqHS030LoDTcz5-YDHVjYaYVHOZD2g@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------8477E11C88D70A63090BD0B6"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------8477E11C88D70A63090BD0B6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 9/14/20 3:19 PM, Josh Boyer wrote:
>> On Tue, Mar 24, 2020 at 6:58 AM Reto Schneider <code@reto-schneider.ch> wrote:
>>>
>>> The vendor driver rtl8188C_8192C_usb_linux_v4.0.1_6911.20130308 includes
> 
> Where can one get that driver?  It's unclear to me what the terms and
> conditions around its usage are, and therefore I can't tell if
> deriving values from this driver are permitted.

This driver was available on the official Realtek servers before they
prevented accessing their FTP servers [0][1]. Luckly, someone mirrored
its content on GitHub [2], which is also where I got the driver from [3].

> If you can get an Ack from someone from Realtek, or someone that

I have no contacts to anyone at Realtek. Not sure if "cold" e-mailing
random people there would be helpful.

> normally maintains the upstream drivers, that would go a long way.

Jes Sorensen, the maintainer of rtl8xxxu redirected me to Chris Chiu in
order to get (paid) work done on rtl8xxxu (which includes testing this
FW). Does this help?

Kind regards,
Reto

[0]
https://forums.mydigitallife.net/threads/ftp3-realtek-com-tw.72385/#post-1581267
[1] https://github.com/lwfinger/rtl8188eu/issues/275
[2] https://github.com/XAIOThaifeng/realtek-linux
[3]
https://github.com/XAIOThaifeng/realtek-linux/tree/370738ceb9efa42c31ecdcb4db90ee0d6d064004/RTL8188C_8192C/USB/v4.0

--------------8477E11C88D70A63090BD0B6
Content-Type: application/pgp-keys;
 name="0xBFB93E8F422586E0.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0xBFB93E8F422586E0.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
XpxTgY94Its7BZwpBw=3D=3D
=3D1Ttn
-----END PGP PUBLIC KEY BLOCK-----

--------------8477E11C88D70A63090BD0B6--
