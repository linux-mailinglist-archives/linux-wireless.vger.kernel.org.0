Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074911B71D5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Apr 2020 12:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbgDXKSl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Apr 2020 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726289AbgDXKSi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Apr 2020 06:18:38 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC73C09B045
        for <linux-wireless@vger.kernel.org>; Fri, 24 Apr 2020 03:18:38 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jRvPo-00FShF-B6; Fri, 24 Apr 2020 12:18:36 +0200
Message-ID: <db1081861ba7e7ee334c3e50494ff3cd34d9963d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/4] cfg80211: updates and fixes for TID specific
 configuration
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        linux-wireless@vger.kernel.org
Cc:     Tamizh Chelvam <tamizhr@codeaurora.org>
Date:   Fri, 24 Apr 2020 12:18:35 +0200
In-Reply-To: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
References: <20200420113437.16998-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> This patch series contains several minor fixes and enhancements for TID
> specific configuration functionality. The first three patches include
> minor fixes and TID specific AMSDU configuration.

Looks good, though I just saw you noticed a small bug :)

> The last patch is somewhat controversial, so the series is marked as RFC.
> The last patch simplifies current override logic. It suggests to make no
> difference between 'specific peer' and 'all peers' cases and to apply
> new TID configuration immediately after resetting the previous one.

Yeah, I tend to agree.

Can you resend with the small fix?

johannes

