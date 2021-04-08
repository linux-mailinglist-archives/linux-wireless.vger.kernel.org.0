Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D4A3583E3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Apr 2021 14:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhDHMzc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Apr 2021 08:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhDHMzc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Apr 2021 08:55:32 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292FDC061760
        for <linux-wireless@vger.kernel.org>; Thu,  8 Apr 2021 05:55:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lUUBr-0090PL-CL; Thu, 08 Apr 2021 14:55:19 +0200
Message-ID: <ba477d2019d91ff822d0c70d874c20c4aaa6cd96.camel@sipsolutions.net>
Subject: Re: Question on "mac80211: HE STA disassoc due to QOS NULL not sent"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        shay.bar@celeno.com
Date:   Thu, 08 Apr 2021 14:55:18 +0200
In-Reply-To: <3c89f6f5-f094-4d1a-f254-6ca7483b54e5@candelatech.com> (sfid-20210331_012437_187850_3A6D0115)
References: <3c89f6f5-f094-4d1a-f254-6ca7483b54e5@candelatech.com>
         (sfid-20210331_012437_187850_3A6D0115)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2021-03-30 at 16:23 -0700, Ben Greear wrote:
> While debugging a station polling issue.  Should it maybe send
> a probe request instead of just not probing at all?
> 
> commit f39b07fdfb688724fedabf5507e15eaf398f2500
> Author: Shay Bar <shay.bar@celeno.com>
> Date:   Wed Jul 3 16:18:48 2019 +0300
> 
>      mac80211: HE STA disassoc due to QOS NULL not sent
> 
>      In case of HE AP-STA link, ieee80211_send_nullfunc() will not
>      send the QOS NULL packet to check if AP is still associated.

Quite possibly we should just fix this - I think there was a recent
discussion on that here on the list?

johannes

