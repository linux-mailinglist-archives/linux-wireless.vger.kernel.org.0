Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF965461D6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2019 16:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbfFNO6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jun 2019 10:58:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:43284 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfFNO6t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jun 2019 10:58:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hbnf6-0003Kx-PT; Fri, 14 Jun 2019 16:58:40 +0200
Message-ID: <330312ef061715d2beba89d0337bfe1a6698f36e.camel@sipsolutions.net>
Subject: Re: [mac80211-next:master 17/20]
 drivers/net/wireless/intel/iwlwifi/dvm/rs.c:3317:3: error: 'const struct
 rate_control_ops' has no member named 'remove_sta_debugfs'; did you mean
 'add_sta_debugfs'?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@01.org,
        linux-wireless@vger.kernel.org
Date:   Fri, 14 Jun 2019 16:58:39 +0200
In-Reply-To: <20190614143359.GA11550@kroah.com> (sfid-20190614_163416_107500_923FA63D)
References: <201906142122.HSTAYprn%lkp@intel.com>
         <20190614143359.GA11550@kroah.com> (sfid-20190614_163416_107500_923FA63D)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2019-06-14 at 16:33 +0200, Greg Kroah-Hartman wrote:

> Did you apply my "[PATCH 3/5] iwlwifi: dvm: no need to check return
> value of debugfs_create function" patch also to this tree?  The 5th
> patch in the series depended on it :(

Yeah, my bad, sorry about that. I was not paying attention to the "5/5"
in patchwork, and the other patches got assigned to other maintainers so
I didn't see them there.

I've dropped the patch for now, until that's all sorted out. Or maybe
Kalle will just take them all together.

johannes

