Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8766F09E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2019 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbfGTU2O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Jul 2019 16:28:14 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:48216 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfGTU2N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Jul 2019 16:28:13 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hovxi-0007FV-E4; Sat, 20 Jul 2019 22:28:10 +0200
Message-ID: <2dffacc1bcbf001d38a173cdce7d141a3dd130a7.camel@sipsolutions.net>
Subject: Re: [PATCH] mt76: mt7603: fix watchdog rescheduling in
 mt7603_set_channel
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Date:   Sat, 20 Jul 2019 22:28:09 +0200
In-Reply-To: <a266417a71907f663991142f5ce44becc09e6996.1563490117.git.lorenzo@kernel.org> (sfid-20190719_005053_270251_AEECE9D8)
References: <a266417a71907f663991142f5ce44becc09e6996.1563490117.git.lorenzo@kernel.org>
         (sfid-20190719_005053_270251_AEECE9D8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-07-19 at 00:50 +0200, Lorenzo Bianconi wrote:
> Convert MT7603_WATCHDOG_TIME in jiffies rescheduling watchdog delayed
> work

Seems a bit inconsistent to me, the previous patch for mt7615 used
jiffies in the define, but here you convert?

johannes

