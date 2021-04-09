Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC6D35A726
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Apr 2021 21:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234761AbhDITbh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 15:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbhDITbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 15:31:36 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A00C061762
        for <linux-wireless@vger.kernel.org>; Fri,  9 Apr 2021 12:31:22 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUwqd-009aTJ-Ow; Fri, 09 Apr 2021 21:31:19 +0200
Message-ID: <82a7c6c9bcbe923906276e8aa26a9a783598a0d7.camel@sipsolutions.net>
Subject: Re: Memory leak in ieee80211_rx_napi()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
Date:   Fri, 09 Apr 2021 21:31:19 +0200
In-Reply-To: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net> (sfid-20210409_172345_954618_8D29770B)
References: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net>
         (sfid-20210409_172345_954618_8D29770B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

> What setting or lack of, would cause ieee80211_rx_napi() to leak the skb that it 
> is given? The documentation states that once this call is made, mac80211 owns 
> this buffer. Does this mean that it will also be freed?

Eventually, yes. But it might go onto a NAPI GRO list, etc. Perhaps it
might even look like it's leaked if it's on such a list if you didn't
implement NAPI properly as polling, but just call ieee80211_rx_napi()
with a non-NULL napi struct pointer.

That said, of course there might be bugs in mac80211 where it actually
leaks the skb.

How are you determining that it's being leaked?

johannes

