Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091032B012F
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725983AbgKLI0m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 03:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgKLI0m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 03:26:42 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46729C0613D1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Nov 2020 00:26:42 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kd7wG-006CeF-Dw; Thu, 12 Nov 2020 09:26:40 +0100
Message-ID: <74fd89df307b46b644c0f4d7ef4edd3da351c657.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: wind down station state earlier
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com,
        syzbot+abed06851c5ffe010921@syzkaller.appspotmail.com,
        syzbot+b7aeb9318541a1c709f1@syzkaller.appspotmail.com,
        syzbot+d5a9416c6cafe53b5dd0@syzkaller.appspotmail.com
Date:   Thu, 12 Nov 2020 09:26:24 +0100
In-Reply-To: <20201110105138.3f84f2055a30.I65a9d01564067122c47d0b5b6448bb4702a06b02@changeid> (sfid-20201110_105152_181206_67F95866)
References: <20201110105138.3f84f2055a30.I65a9d01564067122c47d0b5b6448bb4702a06b02@changeid>
         (sfid-20201110_105152_181206_67F95866)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-11-10 at 10:51 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> sta_info_free() may be used in a context that cannot sleep,
> so do the wind-down earlier in __cleanup_single_sta(). We
> should probably just unify that, by doing the free inside
> sta_info_insert_finish() instead of the caller, but that'll
> be a separate cleanup patch.
> 
> Reported-by: syzbot+6a7fe9faf0d1d61bc24a@syzkaller.appspotmail.com
> Reported-by: syzbot+abed06851c5ffe010921@syzkaller.appspotmail.com
> Reported-by: syzbot+b7aeb9318541a1c709f1@syzkaller.appspotmail.com
> Reported-by: syzbot+d5a9416c6cafe53b5dd0@syzkaller.appspotmail.com

That's probably true - however, it will get the original problem that
syzbot reported back ...

https://syzkaller.appspot.com/bug?extid=2e293dbd67de2836ba42

That's because the allocation is in pre_move_state().

So we can't do this - but need to do the other two patches I posted
directly.

johannes

