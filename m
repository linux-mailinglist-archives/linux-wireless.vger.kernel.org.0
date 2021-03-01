Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA1A329356
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 22:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243909AbhCAVP0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 16:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237864AbhCAVN0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 16:13:26 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD500C061788;
        Mon,  1 Mar 2021 13:12:45 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lGpqH-00ARN0-Um; Mon, 01 Mar 2021 22:12:38 +0100
Message-ID: <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net>
Subject: Re: Lockdep warning in iwl_pcie_rx_handle()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Luca Coelho <luciano.coelho@intel.com>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 01 Mar 2021 22:12:21 +0100
In-Reply-To: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm> (sfid-20210301_215846_256695_15E0D07E)
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>
         (sfid-20210301_215846_256695_15E0D07E)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Jiri,

> I am getting the splat below with Linus' tree as of today (5.11-rc1, 
> fe07bfda2fb). I haven't started to look into the code yet, but apparently 
> this has been already reported by Heiner here:
> 
> 	https://www.spinics.net/lists/linux-wireless/msg208353.html
> 
> so before I start digging deep into it (the previous kernel this 
> particular machine had is 5.9, so I'd rather avoid lenghty bisect for now 
> in case someone has already looked into it and has ideas where the problem 
> is), I thought I'd ask whether this has been root-caused elsewhere 
> already.

Yeah, I'm pretty sure we have a fix for this, though I'm not sure right
now where it is in the pipeline.

It's called "iwlwifi: pcie: don't add NAPI under rxq->lock" but right
now I can't find it in any of the public archives.

johannes

