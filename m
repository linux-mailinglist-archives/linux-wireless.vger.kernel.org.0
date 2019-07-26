Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06076519
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jul 2019 14:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfGZMEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Jul 2019 08:04:05 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:47998 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfGZMEF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Jul 2019 08:04:05 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hqyxA-0002QC-2N; Fri, 26 Jul 2019 14:04:04 +0200
Message-ID: <92167a1803b9f90d231b080c9edfbf335c4685ed.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v3 2/2] cfg80211: fix duplicated scan entries after
 channel switch
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>,
        Mikhail Karpenko <mkarpenko@quantenna.com>
Date:   Fri, 26 Jul 2019 14:04:02 +0200
In-Reply-To: <20190710173651.15770-3-sergey.matyukevich.os@quantenna.com>
References: <20190710173651.15770-1-sergey.matyukevich.os@quantenna.com>
         <20190710173651.15770-3-sergey.matyukevich.os@quantenna.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Umm, regarding multi-BSSID, I'm clearly just not paying any attention
... sorry about that.


This looks good to me, can you resend as just PATCH?

Thanks,
johannes

