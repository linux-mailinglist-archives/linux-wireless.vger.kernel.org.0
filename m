Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CC11C527
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 10:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbfENIot (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 04:44:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:39974 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfENIos (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 04:44:48 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hQT3H-0006k7-A7; Tue, 14 May 2019 10:44:47 +0200
Message-ID: <be1934dad73b1cc654615c1c895a79a8b35ea456.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: remove warning message
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Yibo Zhao <yiboz@codeaurora.org>, linux-wireless@vger.kernel.org
Cc:     ath10k@lists.infradead.org, Zhi Chen <zhichen@codeaurora.org>
Date:   Tue, 14 May 2019 10:44:45 +0200
In-Reply-To: <1557471662-1355-1-git-send-email-yiboz@codeaurora.org> (sfid-20190510_090204_942831_B8A9C5A2)
References: <1557471662-1355-1-git-send-email-yiboz@codeaurora.org>
         (sfid-20190510_090204_942831_B8A9C5A2)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-05-10 at 15:01 +0800, Yibo Zhao wrote:
> In multiple SSID cases, it takes time to prepare every AP interface
> to be ready in initializing phase. If a sta already knows everything it
> needs to join one of the APs and sends authentication to the AP which
> is not fully prepared at this point of time, AP's channel context
> could be NULL. As a result, warning message occurs.

Please share the dump, I don't think this should be happening. I think
this warning did what it was supposed to, uncover a bug; rather than
remove the warning we should fix the bug.

> Even worse, if the AP is under attack via tools such as MDK3 and massive
> authentication requests are received in a very short time, console will
> be hung due to kernel warning messages.

I don't buy this, it's just a WARN_ON_ONCE().

> If this case can be hit during normal functionality, there should be no
> WARN_ON(). Those should be reserved to cases that are not supposed to be
> hit at all or some other more specific cases like indicating obsolete
> interface.

I agree, but right now I'm inclined to think it's a bug elsewhere rather
than normal operation.

johannes

