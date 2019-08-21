Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6EDA973B4
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2019 09:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbfHUHjt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Aug 2019 03:39:49 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56790 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHUHjt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Aug 2019 03:39:49 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1i0LDf-0004qB-Ot; Wed, 21 Aug 2019 09:39:47 +0200
Message-ID: <cd3fadd347228b8edf6dd88297ab3092b64e5283.camel@sipsolutions.net>
Subject: Re: Unaligned Memory Access on mesh_*.c files
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Guo Wei Lim <limguowei@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 21 Aug 2019 09:39:46 +0200
In-Reply-To: <CAJSNYx3Paw7RXpHFbC55zNptT+1AGeYPx08m0=XSr6sSGtC33g@mail.gmail.com> (sfid-20190810_122908_760531_72861C3B)
References: <CAJSNYx0k7k8RyRT6siC1xv_0xqf3ggKSwNp7sp9c7y-kOgSeAg@mail.gmail.com>
         <64EA957F-B24A-4B1C-AAC0-B51790F47E9E@sipsolutions.net>
         <CAJSNYx3Paw7RXpHFbC55zNptT+1AGeYPx08m0=XSr6sSGtC33g@mail.gmail.com>
         (sfid-20190810_122908_760531_72861C3B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2019-08-10 at 10:28 +0000, Guo Wei Lim wrote:
> Hi Johannes,
> 
> Correct me if I am wrong.
> The problem is largely in net/mac80211/mesh_hwmp.c
> The macros
> #define PREQ_IE_ORIG_ADDR(x) (x + 7)
> #define PREP_IE_TARGET_ADDR(x) (x + 3)
> 
> Almost guarantees the addresses will be odd when it hit the following

Oh, yeah, good point.

> if (ether_addr_equal(orig_addr, sdata->vif.addr)) {
> 
> Results in unaligned memory access

Right.

> I have tested that replacing ether_addr_equal with
> ether_addr_equal_unaligned fixes the issue but this happens in many
> places as well as other functions like is_multicast_ether_addr(),
> is_broadcast_ether_addr() so it isn't the correct fix.

Unfortunately, I think it _is_ in fact the correct (and only possible)
fix, I can't think of anything other than making the code properly
handle unaligned addresses, as they do seem to happen here.

johannes

