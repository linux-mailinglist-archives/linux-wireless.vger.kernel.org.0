Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA59E254802
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Aug 2020 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH0O5m (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Aug 2020 10:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgH0M0e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Aug 2020 08:26:34 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5852C061236
        for <linux-wireless@vger.kernel.org>; Thu, 27 Aug 2020 05:26:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kBGyy-00BaLQ-2D; Thu, 27 Aug 2020 14:26:20 +0200
Message-ID: <61219c725630447e832839196e20eb433723ed49.camel@sipsolutions.net>
Subject: Re: [PATCH V5 4/5] mac80211: add support for BSS coloring
From:   Johannes Berg <johannes@sipsolutions.net>
To:     John Crispin <john@phrozen.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Date:   Thu, 27 Aug 2020 14:26:18 +0200
In-Reply-To: <20200826055650.1101224-4-john@phrozen.org> (sfid-20200826_075710_318035_1DE9E6C8)
References: <20200826055650.1101224-1-john@phrozen.org>
         <20200826055650.1101224-4-john@phrozen.org>
         (sfid-20200826_075710_318035_1DE9E6C8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> + * @color_change_active: marks whether a color change is going on. Internally it is
> + *	write-protected by sdata_lock and local->mtx so holding either is fine
> + *	for read access.
> 

I started fixing up things like that but then I got annoyed and gave up
...

Just because checkpatch no longer warns on >80 columns that doesn't mean
it's suddenly completely acceptable to write very long lines. In flowed
text like this, it's much nicer to have shorter lines, and long lines
are just arbitrary.

That's actually in quite a few places in this patch - comments, function
arguments, etc.

Nothing against going over 80 where that makes the code more readable,
but long lines for flowed text are *less* readable.

johannes

