Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCED2AD180
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 09:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgKJInO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Nov 2020 03:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJInN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Nov 2020 03:43:13 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BB0C0613CF;
        Tue, 10 Nov 2020 00:43:13 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kcPF5-004p3K-PR; Tue, 10 Nov 2020 09:43:07 +0100
Message-ID: <2aaaefd6cfda1928e5ea397850fa6fca01fb0642.camel@sipsolutions.net>
Subject: Re: linux-next: build warning after merge of the mac80211-next tree
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>,
        Rohan Dutta <drohan@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Tue, 10 Nov 2020 09:43:06 +0100
In-Reply-To: <20201109164342.1ff7d645@canb.auug.org.au>
References: <20201109164342.1ff7d645@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-11-09 at 16:43 +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mac80211-next tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1014: WARNING: Unexpected indentation.
> Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1016: WARNING: Block quote ends without a blank line; unexpected unindent.
> Documentation/driver-api/80211/cfg80211:48: include/net/cfg80211.h:1019: WARNING: Unexpected indentation.
> 
> Introduced by commit
> 
>   9f0ffa418483 ("cfg80211: Add support to configure SAE PWE value to drivers")

Thanks Stephen, fixing it now.

johannes

