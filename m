Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1773ADE20
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390183AbfIIRk0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 13:40:26 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:35934 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfIIRk0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 13:40:26 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i7NeJ-0002sB-9T; Mon, 09 Sep 2019 19:40:23 +0200
Message-ID: <2e30e4df1eb69362f00db89efb133856ec96b755.camel@sipsolutions.net>
Subject: Re: intel AX200 crash on 5.2.7+
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 09 Sep 2019 19:40:22 +0200
In-Reply-To: <438925e0-deab-d84d-2b0a-da544d0989b3@candelatech.com> (sfid-20190909_190335_153534_A53C85B5)
References: <438925e0-deab-d84d-2b0a-da544d0989b3@candelatech.com>
         (sfid-20190909_190335_153534_A53C85B5)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-09-09 at 10:03 -0700, Ben Greear wrote:
> Hello,
> 
> Looks like we managed to crash the AX200 firmware.  This was running 5.2.7+ kernel
> in an apu2 platform.
> 
> Is there a better place to report/discuss this?

This is OK for first reports, but usually we'll ask to file a bug on
bugzilla.kernel.org (and assign to linuxwifi@intel.com if you can? Not
sure it's possible - or add that to CC at least)

> [ 6066.180908] iwlwifi 0000:01:00.0: 0x00000942 | ADVANCED_SYSASSERT

Hmm, that's a calibration failure.

Did you do anything special in that environment?

I guess filing a bug would be best, so we have a record for it and can
hand it off to the firmware team or similar.

johannes

