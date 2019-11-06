Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB530F10D2
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Nov 2019 09:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730060AbfKFIMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Nov 2019 03:12:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:56880 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729896AbfKFIMV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Nov 2019 03:12:21 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1iSGQO-0008O7-0H; Wed, 06 Nov 2019 09:12:20 +0100
Message-ID: <786f623306ad462e3776236c94e83b5f2e0648ab.camel@sipsolutions.net>
Subject: Re: [PATCH] crda: Makefile: fix .so compilation line with some
 compilers
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Brian Norris <briannorris@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        wireless-regdb@lists.infradead.org
Date:   Wed, 06 Nov 2019 09:12:19 +0100
In-Reply-To: <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com> (sfid-20191106_000450_777836_44FB1DDA)
References: <20191105225751.1233-1-briannorris@chromium.org>
         <CA+ASDXM_5Q3LNyv_mbrG8d8Qo1iZZz2A2CFfvQqj9_Ta-q-wMA@mail.gmail.com>
         (sfid-20191106_000450_777836_44FB1DDA)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2019-11-05 at 15:02 -0800, Brian Norris wrote:
> On Tue, Nov 5, 2019 at 2:57 PM Brian Norris <briannorris@chromium.org> wrote:
> > Write the CC rule such that it only tries to produce a single output
> > file (the .so). When including the .h files in the compiler invocation,
> > this suggests we should be producing pre-compiled headers too, which
> > doesn't make sense in this context, and Clang happens not to like.
> > 
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> 
> Apparently wireless-regdb@ is subscribers only. I have since joined,
> but I guess my patch bounced from that list... if I don't hear back in
> a while, I may resend.

The bigger question is who actually maintains crda now, if anyone ... :)

johannes

