Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972BE340DF1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 20:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhCRTNU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 15:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhCRTNN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 15:13:13 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAE6C06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 12:13:11 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMy4z-000Gme-Fn; Thu, 18 Mar 2021 20:13:09 +0100
Message-ID: <05ede675a6829ab3f3e69a1766a9df39f18ad024.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: avoid holding the RTNL when calling the
 driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter Collingbourne <pcc@google.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 18 Mar 2021 20:13:08 +0100
In-Reply-To: <CAMn1gO6PoOZyejd_Pu0fj9DHz7d8ty8-sb8voRvXd3=-XV23jA@mail.gmail.com> (sfid-20210318_201103_082515_6B31AB13)
References: <CAMn1gO7evHe+pvcFwv1XE+y090CSWwXL=pRKjZwmnrZa3j4gtg@mail.gmail.com>
         <a4502cc2a3547780b075e4ee0d3946f9b727adb9.camel@sipsolutions.net>
         <CAMn1gO6PoOZyejd_Pu0fj9DHz7d8ty8-sb8voRvXd3=-XV23jA@mail.gmail.com>
         (sfid-20210318_201103_082515_6B31AB13)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2021-03-18 at 12:10 -0700, Peter Collingbourne wrote:

> Yes, it was deadlocking after a few minutes, although at that time I
> hadn't confirmed that the deadlock was being caused by the patch or by
> some other issue.

Ah ok :)

> > In any case, I fixed it here, I believe:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=77cbf790e5b482256662e14c8b6ef4fecb07d06d
> 
> I cherry-picked that patch and tested it on my setup, and it fixed
> both the warnings and the deadlocks. So if you like you can add my:
> 
> Tested-by: Peter Collingbourne <pcc@google.com>

Too late since it's already applied and just got into net also (so
hopefully into rc4), but thanks for confirming that it works!

johannes

