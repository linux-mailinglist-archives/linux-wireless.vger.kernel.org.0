Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E46E1E69F5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406048AbgE1TCe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406029AbgE1TCd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:02:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AEDC08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:02:33 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeNnT-0053IB-57; Thu, 28 May 2020 21:02:31 +0200
Message-ID: <6d5994325bbb28ff855b527a26e4e7e87760705f.camel@sipsolutions.net>
Subject: Re: iwlist scanning: how to exclude old scan results from output?
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bruno Dantas <wireless@dantas.airpost.net>,
        linux-wireless@vger.kernel.org
Date:   Thu, 28 May 2020 21:02:30 +0200
In-Reply-To: <f78191c6-3093-4d97-a959-068dce1da552@www.fastmail.com>
References: <afef8a7d-053e-4aaa-ace7-d320c32e8b7c@www.fastmail.com>
         <(sfid-20200528_174911_413757_32DBA783)>
         <a185a4283c1230965b520de52737427c91af9c22.camel@sipsolutions.net>
         <99c4ece3-15ca-42cb-aa09-c86d466d6429@www.fastmail.com>
         <7406af4a9e852d99735e1b1af63deed2f0c5d703.camel@sipsolutions.net>
         <f78191c6-3093-4d97-a959-068dce1da552@www.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, 2020-05-28 at 14:57 -0400, Bruno Dantas wrote:
> > Does it go away if you wait long enough for the "last seen" to go above
> > 30 seconds (30000ms)? You should use "iw wlan0 scan dump" (no need for
> > sudo, and don't scan again) to check.
> > 
> > Because if not, then there's a bug in the references, and the entry is
> > just being kept alive by ... something. Did you previously connect to
> > it? Does it also happen if you never connect? Then I guess we'll need to
> > know what the kernel version is too. :)
> 
> Yes, it goes way if I wait 30 seconds. Whether I had connected to the
> hotspot or not makes no difference. Kernel version is 5.4.3.

So at least it's not completely stuck.

> I thought discovering *currently-available* hotspots would be a common
> need. I'm a bit surprised that getting this information is tricky.

That's why 'flush' exists :)

> Like I said, reloading the wireless interface's kernel module does the
> trick.

Obviously. But still, now I'm wondering if there's a bug?

But then again, I think we use this a lot in the hwsim tests and rely on
it for a quick succession of tests to not find previous APs, and
"scan_for_auth" seems to be a fairly direct test for this as well?

Hmm. Not sure. What driver are you using?

johannes


