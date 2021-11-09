Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6C44A9C1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 09:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbhKII4K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 03:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244596AbhKII4C (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 03:56:02 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08221C061764
        for <linux-wireless@vger.kernel.org>; Tue,  9 Nov 2021 00:53:16 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1mkMsU-0004Q1-88; Tue, 09 Nov 2021 09:53:14 +0100
Message-ID: <27297ff6-d970-7b9a-01f0-d5261d553e6b@leemhuis.info>
Date:   Tue, 9 Nov 2021 09:53:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
From:   Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] ath10k: abstract htt_rx_desc structure
To:     Francesco Magliocca <franciman12@gmail.com>,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, enrico@fracta.dev
References: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
Content-Language: en-BW
In-Reply-To: <CAH4F6us6kLs4WZVKVNQV69wZ=BA2AzOyacyKLB3RfVme=9uKvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1636447997;a9d42547;
X-HE-SMSGID: 1mkMsU-0004Q1-88
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 08.11.21 17:25, Francesco Magliocca wrote:
> QCA6174 card often hangs with the current htt_rx_desc
> memory layout in some circumstances, because its firmware
> fails to handle length differences.
> Therefore we must abstract the htt_rx_desc structure
> and operations on it, to allow different wireless cards
> to use different, unrelated rx descriptor structures.
> 
> Define a base htt_rx_desc structure and htt_rx_desc_qca_old
> for use with the QCA family of ath10k supported cards
> and htt_rx_desc_new for use with the WCN3990 card.
> 
> Define htt_rx_desc_ops which contains the abstract operations
> to access the generic htt_rx_desc, give implementations
> for each card and update htt_rx.c to use the defined
> abstract interface to rx descriptors.
> 
> Fixes: e3def6f7 ("ath10k: Update rx descriptor for WCN3990 target")
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00157-QCARMSWPZ-1
> 
> Co-developed-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Enrico Lumetti <enrico@fracta.dev>
> Signed-off-by: Francesco Magliocca <franciman12@gmail.com>

As a Linux kernel regression tracker let me use this opportunity and
say: Thanks for working on a fix for this regression.

There is one small detail that could be improved: the commit message
would benefit from a link to the regression report. This is explained in
Documentation/process/submitting-patches.rst, which recently was changed
slightly to make this aspect clearer:
https://git.kernel.org/linus/1f57bd42b77c

E.g. add something like this, just *without* the leading caret(¹):

^Link:
https://lore.kernel.org/ath10k/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/

Francesco, could you please do this in case you need to sent an improved
version for other reasons? And if the patch is already good to go: could
the subsystem maintainer please add it when applying?

Thanks in advance.

Let me use this opportunity to explain why I'm asking for this. Yes,
that link is not really crucial; but it's good to have if someone needs
to look into the backstory of this change sometime in the future. But I
care for a different reason. I'm tracking this regression (and others)
with regzbot, my Linux kernel regression tracking bot. This bot will
notice if a patch with a Link: tag to a tracked regression gets posted
and record that, which allowed anyone looking into a regression to
quickly gasp the current status from the regzbot webui(²) or its
reports. The bot will also notice if a commit with a Link: tag to a
regression report is applied by Linus and then automatically mark the
regression as resolved then.

IOW: this tag makes my life easier, as I otherwise have to tell regzbot
manually about the fix. ;-)

BTW: feel free to drop me from the CC list after placing the Link tag,
as I have no real interest in this.

Ciao, Thorsten

(¹) I used caret (the "^") before the "Link:" above, as that will make
regzbot handle the parent mail as if it had contained a link to this
regression and start to monitor this thread. At least I hope so, as I
just added this functionally to regzbot, so this is the first test in
the field.

(²)
https://linux-regtracking.leemhuis.info/regzbot/regression/CAH4F6usFu8-A6k5Z7rU9__iENcSC6Zr-NtRhh_aypR74UvN1uQ@mail.gmail.com/
