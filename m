Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 872A5669A6
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 11:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbfGLJLX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 05:11:23 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:55376 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGLJLX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 05:11:23 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hlraL-0006OG-CW; Fri, 12 Jul 2019 11:11:21 +0200
Message-ID: <1c371a5921200a11da459b591df121bbcb0f967d.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 0/2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 12 Jul 2019 11:11:19 +0200
In-Reply-To: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

> Suggested approach to handle non-transmitting BSS entries is simplified in the
> following sense. If new entries have been already created after channel switch,
> only transmitting bss will be updated using IEs of new entry for the same
> transmitting bss. Non-transmitting bss entries will be updated as soon as
> new mgmt frames are received. Updating non-transmitting bss entries seems
> too expensive: nested nontrans_list traversing is needed since we can not
> rely on the same order of old and new non-transmitting entries.

That sounds like a reasonable trade-off. I do wonder though what happens
if we're connected to a non-transmitting BSS?

johannes


