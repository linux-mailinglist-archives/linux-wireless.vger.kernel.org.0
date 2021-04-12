Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4035C5BA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Apr 2021 13:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhDLLyE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Apr 2021 07:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLyD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Apr 2021 07:54:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD85C061574
        for <linux-wireless@vger.kernel.org>; Mon, 12 Apr 2021 04:53:45 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lVv8Q-00AgH5-WF; Mon, 12 Apr 2021 13:53:43 +0200
Message-ID: <ce98174f1513d8a7fb9b89915f58717562dbe8ed.camel@sipsolutions.net>
Subject: Re: Memory leak in ieee80211_rx_napi()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Pkshih <pkshih@realtek.com>
Date:   Mon, 12 Apr 2021 13:53:42 +0200
In-Reply-To: <32687519-1c0e-1e6c-dbc3-1e9fd027fc8a@lwfinger.net> (sfid-20210411_211744_139894_B68237C3)
References: <ad9bee4f-ef24-1fe0-5e63-e2e840ac0449@lwfinger.net>
         <82a7c6c9bcbe923906276e8aa26a9a783598a0d7.camel@sipsolutions.net>
         <32687519-1c0e-1e6c-dbc3-1e9fd027fc8a@lwfinger.net>
         (sfid-20210411_211744_139894_B68237C3)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Larry,

Sorry I didn't respond to your other email on Friday - it was close to
midnight here and I couldn't pay much attention over the weekend.

> There were two bugs in rtw88. The first, suggested by PK, was that the sequence 
> between start/stop of NAPI and the enable/disable of interrupts were reversed. 
> The second bug was in NAPI polling as you suggested. The poll routine was 
> calling napi_schedule() rather than napi_reschedule().
> 
> With these two changes, my RTL8822CE handled 12 hours of flood ping with my 
> router without leaking a single buffer.

Glad you found the issues, and thanks for following up!

I do wonder where the SKBs were actually leaked, that's a bit strange,
but I guess it doesn't matter much now.

johannes

