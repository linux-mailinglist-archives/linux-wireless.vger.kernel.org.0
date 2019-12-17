Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC91225FB
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Dec 2019 08:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLQH5M (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Dec 2019 02:57:12 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:43136 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfLQH5M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Dec 2019 02:57:12 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.3)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ih7jA-004FGq-R1; Tue, 17 Dec 2019 08:57:08 +0100
Message-ID: <9ff2afcfb6590e92d8e73656e657414ec2c71b3d.camel@sipsolutions.net>
Subject: Re: [RFC] mac80211:  Fix setting txpower to zero.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     greearb@candelatech.com, linux-wireless@vger.kernel.org
Date:   Tue, 17 Dec 2019 08:57:07 +0100
In-Reply-To: <20191213230334.27631-1-greearb@candelatech.com> (sfid-20191214_000347_234159_5F7C9357)
References: <20191213230334.27631-1-greearb@candelatech.com>
         (sfid-20191214_000347_234159_5F7C9357)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-12-13 at 15:03 -0800, greearb@candelatech.com wrote:
> 
> So, instead initialize the txpower to -1 in mac80211, and let drivers know that
> means the power has not been set and so should be ignored.

Technically (or maybe just physically?), even -1 is a sort of valid TX
power.

I know all of this is pretty messed up, but wouldn't it make more sense
to go with some kind of tx_power_valid bit, or perhaps something that
certainly will never make sense like MIN_INT instead of -1?

johannes

