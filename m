Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA3B749C634
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jan 2022 10:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiAZJWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jan 2022 04:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239035AbiAZJWL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jan 2022 04:22:11 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6635BC06161C
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jan 2022 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=fws7yU5g/1M5DR6DlQOWCBCPz6l4PtHv7HEFBrWIipc=;
        t=1643188931; x=1644398531; b=garPF6+CF6EVY8z5Zfdgmoytis+r+QHOOrU7+uATF5u04r7
        B1ZpL738a5m6ipjZeVjKYqcDIIXWO+JhXY1D/DvhM8YLVAqZ9/RWKtOM6nuy8C6hChGIzqBFF8kMW
        5I6rb5c1kcqjRBe0j1n2487hD+0Ja8kKpm3WaThMrZHbuglCP5PG/Xz3E+59rexLMv+5+Wge5Iefx
        bBgSdhbv6zcPOvNtuGoaRdcczc7W3q4n6gNzSDyTlpY5WGzCLkA6xafc/awrUvitts0egVMNE66IU
        2iOUDzLrUvtoy3p0Bw8J20pbR9iTNr8EtBFeWMGy0cYfJbdJEfoS9neDPRtbZQ8g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1nCeVE-00ARGm-Gd;
        Wed, 26 Jan 2022 10:22:08 +0100
Message-ID: <358612b6bd79cb4dfa9bf5132eb4203656757078.camel@sipsolutions.net>
Subject: Re: Fix fell on the floor for rcu violation in net/wireless/scan.c
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Zzy Wysm <zzy@zzywysm.com>, linux-wireless@vger.kernel.org,
        dvyukov@google.com, hdanton@sina.com
Date:   Wed, 26 Jan 2022 10:22:07 +0100
In-Reply-To: <A7E1204B-E1CD-48AF-AA80-ECCF3E4F7049@zzywysm.com>
References: <A7E1204B-E1CD-48AF-AA80-ECCF3E4F7049@zzywysm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.3 (3.42.3-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2022-01-25 at 17:47 -0500, Zzy Wysm wrote:
> 
> However, the proposed patch appears to be a valid bug fix.

It didn't really look like that to me. Explain why you think so?

johannes
