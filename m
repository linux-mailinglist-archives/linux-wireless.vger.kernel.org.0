Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E9DBE48860
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2019 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbfFQQJZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Jun 2019 12:09:25 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:45712 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbfFQQJZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Jun 2019 12:09:25 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hcuC4-0002HH-5c; Mon, 17 Jun 2019 18:09:16 +0200
Message-ID: <f2a07e8e0194d3e4a0446ca56cfc1ced95eb9b5e.camel@sipsolutions.net>
Subject: Re: [mac80211-next:master 17/20]
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:3: error: 'const struct
 rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean
 'add_sta_debugfs'?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-wireless@vger.kernel.org
Date:   Mon, 17 Jun 2019 18:09:13 +0200
In-Reply-To: <87muigtg2q.fsf@purkki.adurom.net>
References: <201906142122.HSTAYprn%lkp@intel.com>
         <20190614143359.GA11550@kroah.com>
         <330312ef061715d2beba89d0337bfe1a6698f36e.camel@sipsolutions.net>
         <87muigtg2q.fsf@purkki.adurom.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-06-17 at 17:57 +0300, Kalle Valo wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Fri, 2019-06-14 at 16:33 +0200, Greg Kroah-Hartman wrote:
> > 
> > > Did you apply my "[PATCH 3/5] iwlwifi: dvm: no need to check return
> > > value of debugfs_create function" patch also to this tree?  The 5th
> > > patch in the series depended on it :(
> > 
> > Yeah, my bad, sorry about that. I was not paying attention to the "5/5"
> > in patchwork, and the other patches got assigned to other maintainers so
> > I didn't see them there.
> > 
> > I've dropped the patch for now, until that's all sorted out. Or maybe
> > Kalle will just take them all together.
> 
> Maybe it's easier that you just wait for other patches to trickle down
> your tree?

Sure, that works too, whichever you prefer.

johannes

