Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DDD45E32
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 15:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbfFNNbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 09:31:00 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:42106 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbfFNNbA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 09:31:00 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbmIF-00011R-0L; Fri, 14 Jun 2019 15:30:59 +0200
Message-ID: <ebab80c3f632f792373bfcace252c7a1bf65ce89.camel@sipsolutions.net>
Subject: Re: [PATCH v2] Revert "cfg80211: fix processing world regdomain
 when non modular"
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Hodaszi, Robert" <Robert.Hodaszi@digi.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Fri, 14 Jun 2019 15:30:57 +0200
In-Reply-To: <20190614131600.GA13897@a1-hr>
References: <20190614131600.GA13897@a1-hr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 13:16 +0000, Hodaszi, Robert wrote:
> This reverts commit 96cce12ff6e0bc9d9fcb2235e08b7fc150f96fd2.
> 
> Re-triggering a reg_process_hint with the last request on all events,
> can make the regulatory domain fail in case of multiple WiFi modules. On
> slower boards (espacially with mdev), enumeration of the WiFi modules
> can end up in an intersected regulatory domain, and user cannot set it
> with 'iw reg set' anymore.
> 
> This is happening, because:
> - 1st module enumerates, queues up a regulatory request
> - request gets processed by __reg_process_hint_driver():
>   - checks if previous was set by CORE -> yes
>     - checks if regulator domain changed -> yes, from '00' to e.g. 'US'
>       -> sends request to the 'crda'
> - 2nd module enumerates, queues up a regulator request (which triggers
> the reg_todo() work)
> - reg_todo() -> reg_process_pending_hints() sees, that the last request
> is not processed yet, so it tries to process it again.
> __reg_process_hint driver() will run again, and:
>   - checks if the last request's initiator was the core -> no, it was
> the driver (1st WiFi module)
>   - checks, if the previous initiator was the driver -> yes
>     - checks if the regulator domain changed -> yes, it was '00' (set by
> core, and crda call did not return yet), and should be changed to 'US'
> 
> ------> __reg_process_hint_driver calls an intersect
> 
> Besides, the reg_process_hint call with the last request is meaningless
> since the crda call has a timeout work. If that timeout expires, the
> first module's request will lost.

It's pointless to resend when I still have the original patch pending,
at least without any changes.

That said, I looked at this today and I'm not sure how the code doesn't
now have the original issue again?

johannes

