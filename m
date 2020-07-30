Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8609123323F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jul 2020 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbgG3MbA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Jul 2020 08:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbgG3Ma7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Jul 2020 08:30:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0C2C061794
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jul 2020 05:30:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1k17i4-00DWCD-FG; Thu, 30 Jul 2020 14:30:56 +0200
Message-ID: <c9525845a8a8b7291988c92b9f427c64e8eef6c4.camel@sipsolutions.net>
Subject: Re: ax200, fw crashes, and sdata-in-driver
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Thu, 30 Jul 2020 14:30:55 +0200
In-Reply-To: <bb23b798-f347-7559-b3dc-d8f713899d26@candelatech.com> (sfid-20200714_015810_768492_BCCFB763)
References: <bb23b798-f347-7559-b3dc-d8f713899d26@candelatech.com>
         (sfid-20200714_015810_768492_BCCFB763)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4 (3.36.4-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

> I larded up my 5.4 kernel with KASAN and lockdep, and ran some tests.  This is with my
> patch that keeps from busy-spinning forever (see previous ignored patch).

Right, sorry, hadn't gotten to patches in a while.

> After a few restarts and FW crashes, the ax200 could not recover firmware.  There
> were lots of sdata-in-driver errors, and then KASAN hit a use-after-free issue
> related to ax200 accessing sta object that was previously deleted.
> 
> Now, I think I know why:
> 
> In the ieee80211_handle_reconfig_failure(struct ieee80211_local *local)
> method, it will clear the SDATA_IN_DRIVER flag, and according to comments,
> this is run when firmware cannot be recovered.  But, just because FW is
> dead does not mean that the driver itself has cleaned up its state.
> 
> So question is, should ax200 (and all drivers) be responsible for cleaning
> up all state when FW cannot be recovered, or should instead mac80211 do cleanup
> in this case by, among other things, not clearing that flag (and probably
> not doing the ctx->driver_present = false; config as well)?

I think it should be the driver. It's not clear _why_ the driver failed,
after all. If the firmware is still alive and just rejected something
then perhaps rolling things back will work. But if the firmware just
died again, that will just cause even more trouble.

johannes

