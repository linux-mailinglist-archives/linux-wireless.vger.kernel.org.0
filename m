Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5EF2870DF
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Oct 2020 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgJHImh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJHImh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 04:42:37 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB916C061755;
        Thu,  8 Oct 2020 01:42:36 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kQRVO-001UdQ-Az; Thu, 08 Oct 2020 10:42:31 +0200
Message-ID: <81ebd41b4f39c78867949e6453b2fb58e69ed48d.camel@sipsolutions.net>
Subject: Re: [PATCH] docs: net: 80211: reduce docs build time
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Date:   Thu, 08 Oct 2020 10:42:29 +0200
In-Reply-To: <f0085721d85ebc3a77164b457ed948eee48b55df.1601890703.git.mchehab+huawei@kernel.org>
References: <f0085721d85ebc3a77164b457ed948eee48b55df.1601890703.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2020-10-05 at 11:38 +0200, Mauro Carvalho Chehab wrote:
> the files under /80211 calls kernel-doc script 207 times, one for each
> single function and doc chapter. Due to that, it takes a lot of time
> handling it:
> 
> 	$ touch Documentation/driver-api/80211/*rst && time make SPHINXDIRS=driver-api/80211 htmldocs
> ...
> 	real	0m22,928s
> 	user	0m21,644s
> 	sys	0m1,334s
> 
> Reduce the build time by doing only one kernel-doc call
> per functions that belong to the same group. With that, there's now
> 50 calls to kernel-doc, which makes the build time for those docs
> 62% faster:
> 
> 	$ touch Documentation/driver-api/80211/*rst && time make SPHINXDIRS=driver-api/80211 htmldocs
> ...
> 	real	0m8,666s
> 	user	0m8,084s
> 	sys	0m0,642s
> 
> As a side effect, it should now be easier to add newer
> functions, as there's no need to repeat the kernel-doc
> pattern.

Thanks, I'll apply this.

I wasn't even aware of that syntax ...

johannes

