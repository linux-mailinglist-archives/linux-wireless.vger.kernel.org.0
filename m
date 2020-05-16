Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764611D6141
	for <lists+linux-wireless@lfdr.de>; Sat, 16 May 2020 15:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEPNZD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 May 2020 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726302AbgEPNZD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 May 2020 09:25:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72C71C061A0C;
        Sat, 16 May 2020 06:25:03 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jZwnO-00EBvX-6E; Sat, 16 May 2020 15:24:06 +0200
Message-ID: <2b74a35c726e451b2fab2b5d0d301e80d1f4cdc7.camel@sipsolutions.net>
Subject: Re: [PATCH v2 12/15] ath10k: use new module_firmware_crashed()
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Luis Chamberlain <mcgrof@kernel.org>, jeyu@kernel.org
Cc:     akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        keescook@chromium.org, daniel.vetter@ffwll.ch, will@kernel.org,
        mchehab+samsung@kernel.org, kvalo@codeaurora.org,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Date:   Sat, 16 May 2020 15:24:01 +0200
In-Reply-To: <20200515212846.1347-13-mcgrof@kernel.org> (sfid-20200515_233205_994687_1F26BDAB)
References: <20200515212846.1347-1-mcgrof@kernel.org>
         <20200515212846.1347-13-mcgrof@kernel.org>
         (sfid-20200515_233205_994687_1F26BDAB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Fri, 2020-05-15 at 21:28 +0000, Luis Chamberlain wrote:> module_firmware_crashed

You didn't CC me or the wireless list on the rest of the patches, so I'm
replying to a random one, but ...

What is the point here?

This should in no way affect the integrity of the system/kernel, for
most devices anyway.

So what if ath10k's firmware crashes? If there's a driver bug it will
not handle it right (and probably crash, WARN_ON, or something else),
but if the driver is working right then that will not affect the kernel
at all.

So maybe I can understand that maybe you want an easy way to discover -
per device - that the firmware crashed, but that still doesn't warrant a
complete kernel taint.

Instead of the kernel taint, IMHO you should provide an annotation in
sysfs (or somewhere else) for the *struct device* that had its firmware
crash. Or maybe, if it's too complex to walk the entire hierarchy
checking for that, have a uevent, or add the ability for the kernel to
print out elsewhere in debugfs the list of devices that crashed at some
point... All of that is fine, but a kernel taint?

johannes

