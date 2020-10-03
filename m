Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1FF2823A5
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Oct 2020 12:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgJCKiV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Oct 2020 06:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbgJCKiV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Oct 2020 06:38:21 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50479C0613D0
        for <linux-wireless@vger.kernel.org>; Sat,  3 Oct 2020 03:38:21 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1kOevi-00FpOk-KY; Sat, 03 Oct 2020 12:38:18 +0200
Message-ID: <3173d6cfc6c3945c6902cb53106197c04ff7cb2e.camel@sipsolutions.net>
Subject: Re: [PATCH] cfg80211: add support to configure HE MCS for beacon
 rate
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Date:   Sat, 03 Oct 2020 12:38:17 +0200
In-Reply-To: <aaa10d95575451d02ce4b71ece457217@codeaurora.org>
References: <1600143587-25327-1-git-send-email-rmanohar@codeaurora.org>
         <f44add4463a8b171e8e207517f3ceae0542d23e2.camel@sipsolutions.net>
         <aaa10d95575451d02ce4b71ece457217@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2020-10-03 at 02:30 -0700, Rajkumar Manoharan wrote:
> On 2020-09-18 05:05, Johannes Berg wrote:
> > On Mon, 2020-09-14 at 21:19 -0700, Rajkumar Manoharan wrote:
> > > This allows an option to configure a single HE MCS beacon tx rate.
> > 
> > This breaks the ap_beacon_rate_legacy2 hwsim test but I'm not sure why,
> > please check.
> > 
> Ah... Thanks for reporting... Hostapd has to clear VHT/HE rates while 
> setting
> legacy beacon tx rate. Otherwise the default he_mcs is filled and 
> causing hwsim failure.
> Posted a fix[1] for review.

Not sure that makes sense to me - why wouldn't the kernel side just
default to "no HE MCS" if the attribute isn't present at all?!?

johannes

