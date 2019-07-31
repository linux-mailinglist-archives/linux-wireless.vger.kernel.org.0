Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5349D7BE69
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387665AbfGaK3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:29:34 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56480 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387399AbfGaK3e (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:29:34 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hslrQ-0005tM-Ko; Wed, 31 Jul 2019 12:29:32 +0200
Message-ID: <368d68860677d9ba4dcf7cb45bf6bc6998babf30.camel@sipsolutions.net>
Subject: Re: [PATCH] mac80211: HE STA disassoc due to QOS NULL not sent
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Shay Bar <Shay.Bar@celeno.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Wed, 31 Jul 2019 12:29:30 +0200
In-Reply-To: <AM5P192MB0226D165AF722EB4E578405CE7DF0@AM5P192MB0226.EURP192.PROD.OUTLOOK.COM>
References: <20190703131848.22879-1-shay.bar@celeno.com>
         (sfid-20190703_151855_846208_5223FFC3) <5957aa7cc7dcd1cf24bd81bcdff419a27c7782aa.camel@sipsolutions.net>
         <AM5P192MB0226D165AF722EB4E578405CE7DF0@AM5P192MB0226.EURP192.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-07-31 at 10:12 +0000, Shay Bar wrote:
> Hi Johannes,
> Station may receive a beacon from the AP that will rearm the bcn_mon_timer.
> If it will not get a beacon within the timeout, it will disconnect.
> In my test case, beacon arrived later (within the timeout).
> Without this patch, STA (wrongly) kicked out the AP without even sending QOS NULL.
> With this patch, STA keeps AP associated and will only disassoc if beacon timeout will pass.

Ah, we still need the timeout, right.

johannes

