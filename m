Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACC9518EFE4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Mar 2020 07:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCWGqK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Mar 2020 02:46:10 -0400
Received: from mx.sdf.org ([205.166.94.20]:49847 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCWGqK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Mar 2020 02:46:10 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02N6jxUu014451
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Mon, 23 Mar 2020 06:46:01 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02N6jxjX008409;
        Mon, 23 Mar 2020 06:45:59 GMT
Date:   Mon, 23 Mar 2020 06:45:58 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Ajay.Kathat@microchip.com
Cc:     Adham.Abozaeid@microchip.com, linux-wireless@vger.kernel.org,
        lkml@sdf.org
Subject: Re: [PATCH] wilc1000: Use crc7 in lib/ rather than a private copy
Message-ID: <20200323064558.GC19411@SDF.ORG>
References: <20200322120408.GA19411@SDF.ORG>
 <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2315a030-75ad-0383-3aa3-25528d2cd29a@microchip.com>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, Mar 23, 2020 at 05:03:02AM +0000, Ajay.Kathat@microchip.com wrote:
> On 22/03/20 5:34 pm, George Spelvin wrote:
>> The code in lib/ is the desired polynomial, and even includes
>> the 1-bit left shift in the table rather than needing to code
>> it explicitly.
> 
> These changes will break functionality. The crc7 used in 'wilc' is based
> on the previous revision(commit# ad241528c491). The new changes can not
> be adopted from 'wilc' device side because the crc calculation is done
> on hardware IP and it expects the value based the older implementation.

I'm confused.  Both crc7 functions compute the exact same value.
I put them in a test harness and checked that they produce identical 
output before submitting.

The only difference is that the implementation I deleted does

	crc = 0x7f;
	while (len--)
		crc = crc_cyndrome_table[(crc << 1) ^ *byte++];
	return crc << 1;

while the lib/crc7.c code maintains its "crc" state value already
shifted left 1 bit, so it can use the simpler loop: 

	crc = 0xfe;	/* 0x7f << 1 */
	while (len--)
		crc = crc_cyndrome_table2[crc ^ *byte++];
	return crc;

It's not a different CRC-7, it's the *exact same* CRC-7.  You can
see that the syndrome tables are identical, just shifted one bit over.

> It seems you are using an old version of 'wilc' driver. This logic is
> already changed in the latest code. We have remove custom behavior to
> decide p2p role (P2P_Go/P2P_Client) between 2 wilc devices based on
> 'local_random' value and now relies on 'intent' value received from 'wpa_s'.
> To submit changes for wilc, please use 'staging-next' branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git repo.

Ah, thanks.  Sorry for the noise, then.  The rcr7 patch still applies,
however.
