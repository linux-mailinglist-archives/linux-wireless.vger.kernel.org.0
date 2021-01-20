Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246942FC779
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jan 2021 03:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbhATCHd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 19 Jan 2021 21:07:33 -0500
Received: from mout02.posteo.de ([185.67.36.66]:56505 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbhATBdd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 19 Jan 2021 20:33:33 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 8C1782400FB
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 02:32:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1611106353; bh=sDzyWJlRylUb/ez8lYjV3fT/2ny+sS68fSiZevG6CYs=;
        h=From:To:Subject:Date:From;
        b=i1C0I0MMz79MluozjPUEoJxhAYtc6nSq67ysKrV4IQAsd0V3ax/iYlFnbirbymGbk
         3mqcpBGsBAD6mXprlKuAjN/0Nroyy1sRi7TXJ+5Tqoz+WC60nyOD5CMYoJi++s9cnt
         776CEjlVP0CcI+0oNsmU9saexHs588TuWBugXEkJ5nHyX/VqNSMpvBb1Z/o58mHsxw
         m/Mc1LzeJOTIWHKxL/PTJTTTQBaJUuGMt/5RtdtjeCWqhT0iJTtZv3mv45LErOP4nF
         +2ZhVlKn2pOSHRV6YoVImrUh0l+jAW+WWKhMNY9dsGWrZEPv9EPnGghqcAoXDT7CUd
         Y86spC9X652bQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4DL7LS6jKfz9rxM
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jan 2021 02:32:32 +0100 (CET)
From:   John Scott <jscott@posteo.net>
To:     linux-wireless@vger.kernel.org
Subject: The GNU triplet for the carl9170 firmware toolchain
Date:   Tue, 19 Jan 2021 20:32:26 -0500
Message-ID: <45145006.fMDQidcC6G@t450>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3659199.Icojqenx9y"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--nextPart3659199.Icojqenx9y
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: John Scott <jscott@posteo.net>
To: linux-wireless@vger.kernel.org
Subject: The GNU triplet for the carl9170 firmware toolchain
Date: Tue, 19 Jan 2021 20:32:26 -0500
Message-ID: <45145006.fMDQidcC6G@t450>

Hi,

Having been working on the same for ath9k_htc, I'm looking into making a 
Debian package for carl9170 so it gets built from source on Debian 
infrastructure. I'm trying to identify the ideal cross triplet to use for 
packaging the cross tools.

I see the toolchain Makefile builds Binutils and GCC with --target=sh-elf, but 
the README also specifies that an SH-2 toolchain is needed. Does sh-elf imply 
sh1-elf, and would it be preferable (or different) to use sh2-elf instead, or 
is it an alias for sh2-elf?

Debian already has sh4-* tools, so I'd like the parallelism of sh2-elf, but I 
wonder if this is a different ABI. config.sub seems equally happy to recognize 
either sh-elf or sh[1234]-elf.

Thanks,
John
--nextPart3659199.Icojqenx9y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT287WtmxUhmhucNnhyvHFIwKstpwUCYAeIKwAKCRByvHFIwKst
p5BIAQDPsf6Vg8aL/Jrn9E30WPYXxNJSktIwsPNEEBEjVwwM/AEA8IhoFxGe3Z+5
MwGb3YP74E/6IJGFr7Pnn0qVkB1BkwQ=
=oZXZ
-----END PGP SIGNATURE-----

--nextPart3659199.Icojqenx9y--



