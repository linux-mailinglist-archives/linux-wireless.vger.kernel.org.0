Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6202FE9F1
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 13:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730954AbhAUM0D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 07:26:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbhAUMZF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 07:25:05 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAA3C061757
        for <linux-wireless@vger.kernel.org>; Thu, 21 Jan 2021 04:24:24 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l2Z0f-009X7F-N8; Thu, 21 Jan 2021 13:24:21 +0100
Message-ID: <9406a5833f2bd6a15bf314717b7ac21952f11f24.camel@sipsolutions.net>
Subject: Re: [PATCH 0/4] Updates for rfkill
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 21 Jan 2021 13:24:20 +0100
In-Reply-To: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
References: <20210116125146.31932-1-markus.theil@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Markus,

Thanks for the patches!

I separately committed a fix for the buffering=0 issue, just so it's
separate and not part of the other changes.

>   rfkill.py: migrate to python3

Applied, but I made some cleanups.

>   rfkill: update rfkill.h
>   rfkill: support hard block reason in python code
>   rfkill: support hard block reason in C code

This is broken, unfortunately. Updating rfkill.h as is causes issues
because we read more data than we are willing to accept, which you've
fixed up in the support for hard block reasons patch. Seems that should
partially be in the original patch - e.g. checking "size >= V1" instead
of "size == V1".

Additionally, the hard block reasons in C patch is wrong because if the
read was short, the field is not initialized. Need to clear the event to
zeroes before reading it, or at least at the beginnning (I guess we can
assume the kernel will not change size between two reads).

The python patch I applied with some fixups.

johannes

