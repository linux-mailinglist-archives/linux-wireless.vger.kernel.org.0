Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74C3BE9D15
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2019 15:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfJ3OEw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Oct 2019 10:04:52 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:59944 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfJ3OEv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Oct 2019 10:04:51 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iPoag-0003zY-5O; Wed, 30 Oct 2019 15:04:50 +0100
Message-ID: <48aa046256186ecc3aaffb9c6642ab44ae91bbd4.camel@sipsolutions.net>
Subject: Re: [PATCH] nl80211: allow more operations for mesh and ad-hoc
 interfaces
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Markus Theil <markus.theil@tu-ilmenau.de>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 30 Oct 2019 15:04:48 +0100
In-Reply-To: <f9828fb2-eda9-5e05-7683-0c180e994f43@tu-ilmenau.de>
References: <20191029115602.78990-1-markus.theil@tu-ilmenau.de>
         <4b9c7b36f175667a76609c6560618bb48a321ed8.camel@sipsolutions.net>
         <f9828fb2-eda9-5e05-7683-0c180e994f43@tu-ilmenau.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2019-10-30 at 14:40 +0100, Markus Theil wrote:
> 
> Mesh interfaces are allowed to perform EDCA according to the standard
> 802.11-2016.

Well, they *have to* in a sense :-)

[...]
> 
> Changing beacons on the fly from user-space in these modes is only
> useful, if vendor-specific elements are used, which can change over time.
> 
> All in all I can nevertheless understand your point, that these changes
> could be "wrong" from a pragmatic point of view.

No no, that's not even it. The problem is that you're focusing too much
on the standard without understanding how the stack works.

Take the QoS parameters again for example. Setting them from userspace
is wrong because that data will immediately be forgotten and killed
again by the call to ieee80211_set_wmm_default() in that code.

Or look at how the change_beacon call is handled - the data you set here
will never even be used for IBSS or mesh because in mac80211
ieee80211_change_beacon() will quite possibly even crash when you call
it for a non-AP interface since it accesses sdata->u.ap.beacon without
any other checks.

So while the *idea* of being able to change beacons or WMM parameters
*might* be correct, this kind of implementation is (fairly obviously)
completely wrong.

johannes

