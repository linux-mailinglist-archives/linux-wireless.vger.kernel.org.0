Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B2A18FAC6
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 18:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgCWRFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 13:05:24 -0400
Received: from mx.sdf.org ([205.166.94.20]:51620 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbgCWRFY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 13:05:24 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02NH5GQH000011
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 23 Mar 2020 17:05:17 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02NH5GLL012023;
        Mon, 23 Mar 2020 17:05:16 GMT
Date:   Mon, 23 Mar 2020 17:05:16 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Ajay.Kathat@microchip.com
Cc:     Adham.Abozaeid@microchip.com, linux-wireless@vger.kernel.org,
        lkml@sdf.org
Subject: Re: [PATCH v2] wilc1000: Use crc7 in lib/ rather than a private copy
Message-ID: <20200323170516.GB3769@SDF.ORG>
References: <20200322120408.GA19411@SDF.ORG>
 <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
 <20200323064558.GC19411@SDF.ORG>
 <48611e28-5a55-ab05-3865-71992a5be327@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48611e28-5a55-ab05-3865-71992a5be327@microchip.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Earlier, I also tried to replace crc7 by using existing library but it
> gave different results with 'crc7_be()' because I didn't modify '0x7f'
> to '0xfe'.

I had an afterthought that maybe documenting this in <linux/crc7.h>
would be useful, since you're unlikely to be the last person to
make this mistake.

Something like:

/*
 * Generate a CRC with the polynomial x^7 + x^3 + 1 and big-endian
 * bit order.  (Thus, the polynomial is 0x89.)  The result is in the
 * most-significant 7 bits of the crc variable.
 *
 * This is where most protocols want the CRC (the lsbit is past the
 * end of CRC coverage and is used for something else), but differs
 * from most example code, which computes the CRC in the lsbits and
 * does an explicit 1-bit shift at the end.
 *
 * Because the state is maintained left-aligned, the common "preset
 * to all ones" CRC variant requires the crc be preset to 0xfe.
 * (Right-aligned example code will show a preset to 0x7f.)
 */

Feel free to add that to the patch (preserving my S-o-b) if you like.

> Thanks again for submitting the patch.

Thank you for writing the whole driver!  I know it can be a real PITA;
Linux kernel developers Really Really Want drivers in a common style
and using existing kernel facilities as much as possible, but you're
usually starting from some internal driver that has its own, 
very different, support library.

BTW, one thing I noticed at cfg80211.c:1132:
	*cookie = prandom_u32();
	priv->tx_cookie = *cookie;

I don't know what the cookie is for, but I notice that *cookie
and priv->tx_cookie are both 64-bit data types.

Should that be "(u64)prandom_u32() << 32 | prandom_u32()"
(since there is no prandom_u64())?
