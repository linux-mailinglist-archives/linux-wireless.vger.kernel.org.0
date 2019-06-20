Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE6BD4DA0B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2019 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbfFTTRD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Jun 2019 15:17:03 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:44146 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfFTTRD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Jun 2019 15:17:03 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1he2YP-0003mX-9H; Thu, 20 Jun 2019 21:17:01 +0200
Message-ID: <44923833f1068e360b1f9534a9bbd37be41e4833.camel@sipsolutions.net>
Subject: Re: [PATCH 3/3] nl80211: Include wiphy address setup in NEW_WIPHY
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Denis Kenzior <denkenz@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 20 Jun 2019 21:17:00 +0200
In-Reply-To: <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com> (sfid-20190620_181637_972412_D6CA9362)
References: <20190619223606.4575-1-denkenz@gmail.com>
         <20190619223606.4575-3-denkenz@gmail.com>
         <ec1ca95a5789f9001e89e603633b20316d687721.camel@sipsolutions.net>
         <7da9b924-78c7-ba72-fecc-a11700a34ff4@gmail.com>
         (sfid-20190620_181637_972412_D6CA9362)
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Denis,

> > We generally can't add anything to any of the cases before the split was
> > allowed, for compatibility with old userspace.
> 
> Can you educate me here? Is it because the non-split dump messages would 
> grow too large?

No. Those messages aren't really relevant, userspace will need to do a
larger buffer for it.

The problem is that old userspace (like really old) didn't split even
dumps. Eventually, we had so much information here that the default dump
message size is exceeded, and we simply couldn't dump that particular
wiphy anymore.

We solved this by splitting the wiphy information into multiple
messages, but that needed new userspace, so when userspace doesn't
request split dumps, we fall through all the way to "case 8" and then
stop - old userspace cannot care about new information anyway.

The reason it was split into cases 0-8 that are combined in non-split
dumps is that it was safer that way - there were certain configurations
where even the original data would go above the message size limit.

> Anyhow, What is the cut off point?  It didn't seem worthwhile to send 
> yet-another-message for ~60 bytes of data, but if you want me to add it 
> as a separate message, no problem.

It doesn't matter if you add it as a separate message or not, you can
add it to later messages, i.e. anything in or after "case 9" is fine.

johannes

