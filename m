Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0F01340084
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Mar 2021 08:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhCRH4g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Mar 2021 03:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhCRH4H (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Mar 2021 03:56:07 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F299DC06174A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Mar 2021 00:56:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lMnVe-0004wr-O1; Thu, 18 Mar 2021 08:55:58 +0100
Message-ID: <a4502cc2a3547780b075e4ee0d3946f9b727adb9.camel@sipsolutions.net>
Subject: Re: [PATCH v2] cfg80211: avoid holding the RTNL when calling the
 driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Peter Collingbourne <pcc@google.com>,
        linux-wireless@vger.kernel.org
Date:   Thu, 18 Mar 2021 08:55:57 +0100
In-Reply-To: <CAMn1gO7evHe+pvcFwv1XE+y090CSWwXL=pRKjZwmnrZa3j4gtg@mail.gmail.com> (sfid-20210317_235308_888337_2C802BBF)
References: <CAMn1gO7evHe+pvcFwv1XE+y090CSWwXL=pRKjZwmnrZa3j4gtg@mail.gmail.com>
         (sfid-20210317_235308_888337_2C802BBF)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Peter,


> I'm seeing warnings like this on 5.12.0-rc2 which I think were caused
> by your patch.
> 
> [    4.898946][  T455] ------------[ cut here ]------------
> [    4.899434][  T455] RTNL: assertion failed at net/core/dev.c (10988)

Yes, sorry about that. I clearly didn't audit that particular code path
(well enough, or at all) with the locking changes.

Even worse, it probably deadlocks?

In any case, I fixed it here, I believe:

https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=77cbf790e5b482256662e14c8b6ef4fecb07d06d

johannes

