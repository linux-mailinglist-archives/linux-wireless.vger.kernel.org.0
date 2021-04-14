Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBCCA35EE27
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Apr 2021 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348470AbhDNHIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Apr 2021 03:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhDNHIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Apr 2021 03:08:16 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635C6C061574
        for <linux-wireless@vger.kernel.org>; Wed, 14 Apr 2021 00:07:55 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lWZcr-00BVIO-Ky; Wed, 14 Apr 2021 09:07:49 +0200
Message-ID: <2db76f5161be090f9fec2bc4fcb8973533e32564.camel@sipsolutions.net>
Subject: Re: "rfkill: add a reason to the HW rfkill state" breaks userspace
From:   Johannes Berg <johannes@sipsolutions.net>
To:     "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Date:   Wed, 14 Apr 2021 09:07:48 +0200
In-Reply-To: <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com> (sfid-20210414_071301_651335_B1FA5905)
References: <efafa85c-c021-14ff-619c-fdd0db53ddbb@redhat.com>
         <SA0PR11MB4752FEE472EC18B6A4F376FAF24E9@SA0PR11MB4752.namprd11.prod.outlook.com>
         (sfid-20210414_071301_651335_B1FA5905)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, 2021-04-14 at 05:12 +0000, Grumbach, Emmanuel wrote:
> > 
> > Hi,
> > 
> > I've been debugging a userspace rfkill issue today which boils down
> > to the
> > "rfkill: add a reason to the HW rfkill state" patch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?i
> > d=14486c82612a177cb910980c70ba900827ca0894
> > breaking userspace.
> 
> This has been rolled back by:
> https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git/commit/?id=71826654ce40112f0651b6f4e94c422354f4adb6
> Other userspace broke (systemd) so Johannes rolled this back by
> default.
> Userspace that is interested in the new byte will read 9 bytes.

Which, unfortunately, doesn't address *this* particular case, because it
uses gio and that will fill the buffer with arbitrary size?

When you (Hans) say you saw in strace a read of size 8, did you mean the
size passed to it, or the return size? I guess it must be the return
size, and the size passed to it was way larger.

The commit Emmanuel linked to fixes cases such as systemd that were just
completely garbage (reading with one size, and then checking they got
another), but it wouldn't fix this case.

Unfortunately, as you also said, it does seem a bit late now - it's been
released in various kernels since 5.10, and while the default rollback
will improve the situation somewhat, read(..., size>8) will still return
9 bytes rather than 8 as it used to. Switching that *also* back *should*
be safe, but who knows what other bugs were introduced in the meantime?

I certainly don't really have a major objection to rolling that also
back, but would it really help that much at this point? I guess it could
be going into 5.10/5.11 stable kernels though.

johannes

