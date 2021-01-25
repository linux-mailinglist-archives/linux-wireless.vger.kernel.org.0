Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2DA230480A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Jan 2021 20:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731151AbhAZFwm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Jan 2021 00:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbhAYKAN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jan 2021 05:00:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EBCC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jan 2021 01:50:51 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1l3yWH-00BN61-Ci; Mon, 25 Jan 2021 10:50:49 +0100
Message-ID: <5ac11f74e05e39e26b9cd6bd791a1deb863dc608.camel@sipsolutions.net>
Subject: Re: [bug report] cfg80211: avoid holding the RTNL when calling the
 driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Mon, 25 Jan 2021 10:50:48 +0100
In-Reply-To: <YA6KarkWBBT78rgd@mwanda> (sfid-20210125_102423_608265_EE76020B)
References: <YA6KarkWBBT78rgd@mwanda> (sfid-20210125_102423_608265_EE76020B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

On Mon, 2021-01-25 at 12:07 +0300, Dan Carpenter wrote:
> Hello Johannes Berg,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 791daf8fc49a: "cfg80211: avoid holding the RTNL when 
> calling the driver" from Jan 19, 2021, leads to the following Smatch 
> complaint:
> 
>     net/wireless/nl80211.c:3242 nl80211_set_wiphy()
>     error: we previously assumed 'rdev' could be null (see line 3222)
> 
> net/wireless/nl80211.c
>   3221	
>   3222		if (rdev)
>                     ^^^^
> The patch adds a NULL dereference
> 
>   3223			mutex_lock(&rdev->wiphy.mtx);

Yeah. I realized this later, the "if" here is wrong. Current version has
this unconditional :-)

johannes

