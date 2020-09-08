Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC968261ADF
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731973AbgIHSle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731550AbgIHSla (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:41:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBACC061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:41:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kFiYY-000lMK-C5; Tue, 08 Sep 2020 20:41:26 +0200
Message-ID: <12f9c1c504053f9119a0965ce468aa1da195421b.camel@sipsolutions.net>
Subject: Re: [mac80211_hwsim] 8cafe19852: hwsim.fst_ap_config_default.fail
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Thomas Pedersen <thomas@adapt-ip.com>,
        kernel test robot <rong.a.chen@intel.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Date:   Tue, 08 Sep 2020 20:41:08 +0200
In-Reply-To: <4b20df478e8e9a1e36dfa92b3c510022@adapt-ip.com>
References: <20200906084935.GD31308@shao2-debian>
         <4b20df478e8e9a1e36dfa92b3c510022@adapt-ip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-09-08 at 11:00 -0700, Thomas Pedersen wrote:
> - LKML
> 
> On 2020-09-06 01:49, kernel test robot wrote:
> > Greeting,
> > 
> > FYI, we noticed the following commit (built with gcc-9):
> > 
> > commit: 8cafe19852d95d6494cbd8c1ae24dbd621588a91 ("[PATCH v2 21/22]
> > mac80211_hwsim: indicate support for S1G")
> > url:
> > https://github.com/0day-ci/linux/commits/Thomas-Pedersen/add-support-for-S1G-association/20200901-045826
> > base:
> > https://git.kernel.org/cgit/linux/kernel/git/jberg/mac80211-next.git
> > master
> 
> This is really cool. Thanks Rong (?).
> 
> I'll move the "fix TSF timestamp write to S1G beacon" patch before the 
> one which actually exposes S1G to hwsim.

Yeah, I was thinking we should do that anyway.

If those two small things (ARRAY_SIZE & patch reordering) are the only
changes, I guess I can do that.

Unless you want to look at the reordering of the nl80211 bands, but you
seemed to say it won't really matter.

johannes

