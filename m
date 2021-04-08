Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5CB358315
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhDHMSG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMSG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:18:06 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5E6C061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:17:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUTbd-008zhv-Hu; Thu, 08 Apr 2021 14:17:53 +0200
Message-ID: <cb1325ad538c3bf385b5bdadf03cfbf9f4afa390.camel@sipsolutions.net>
Subject: Re: [PATCH v9 0/4] Multiple BSSID support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Aloka Dixit <alokad@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 08 Apr 2021 14:17:52 +0200
In-Reply-To: <20210310182604.8858-1-alokad@codeaurora.org> (sfid-20210310_192727_681722_4BC25758)
References: <20210310182604.8858-1-alokad@codeaurora.org>
         (sfid-20210310_192727_681722_4BC25758)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-03-10 at 10:26 -0800, Aloka Dixit wrote:
> This patchset adds support for multiple BSSID and
> enhanced multi-BSSID advertisements.
> 
> This version modifies only nl80211 patch (1/4) which describes
> the difference.
> 
> John Crispin (4):
>   nl80211: add basic multiple bssid support
>   mac80211: add multiple bssid support to interface handling
>   mac80211: add multiple bssid/EMA support to beacon handling
>   mac80211: CSA on non-transmitting interfaces

Also, can we have hwsim support for proper testing? Seems with all the
logic in mac80211 to give you the right beacons etc. that should be
really simple?

johannes

