Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B485B7D00FE
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 19:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235501AbjJSRxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 13:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235491AbjJSRxg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 13:53:36 -0400
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C547114
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 10:53:32 -0700 (PDT)
Received: (wp-smtpd smtp.wp.pl 7621 invoked from network); 19 Oct 2023 19:53:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1697738009; bh=2+rAyM9M/Mvxutl5GHk2fAK8bFZXXD6Ce8sUEHiFKio=;
          h=From:To:Cc:Subject;
          b=DlzZ5ETnhYF6Z8ZzLcFDlrCyyYlhzXL5xA5XFl664MkyrfNr9oKVWAGFg37WhS6iW
           83ZAl/L99TSslc9TKvNCCfY9xErN2Kl5kOJ8SnGboFpvHaH9ZNeUjhjnlyAhNFMKCv
           GOfnIFYxlvqruAH6d9UOOYIyE3MRxksqCWz4tUN8=
Received: from 89-64-13-175.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.13.175])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <kvalo@kernel.org>; 19 Oct 2023 19:53:28 +0200
Date:   Thu, 19 Oct 2023 19:53:28 +0200
From:   Stanislaw Gruszka <stf_xl@wp.pl>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>, helmut.schaa@googlemail.com,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
Message-ID: <20231019175328.GA512047@wp.pl>
References: <169769882877.117236.15856778587852752332.kvalo@kernel.org>
 <TYAP286MB0315BFF338DEE34898A20584BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <87h6mm20vl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6mm20vl.fsf@kernel.org>
X-WP-MailID: 73c6b66a9abc78415fbeca0f90fae148
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [wTMR]                               
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thu, Oct 19, 2023 at 04:33:02PM +0300, Kalle Valo wrote:
> Shiji Yang <yangshiji66@outlook.com> writes:
> 
> > On Thu, 19 Oct 2023 07:00:30 +0000, Kalle Valo wrote:
> >
> >>Shiji Yang <yangshiji66@outlook.com> wrote:
> >>
> >>> The watchdog function is broken on rt2800 series SoCs. This patch
> >>> fixes the incorrect watchdog logic to make it work again.
> >>> 
> >>> 1. Update current wdt queue index if it's not equal to the previous
> >>>    index. Watchdog compares the current and previous queue index to
> >>>    judge if the queue hung.
> >>> 2. Make sure hung_{rx,tx} 'true' status won't be override by the
> >>>    normal queue. Any queue hangs should trigger a reset action.
> >>> 3. Clear the watchdog counter of all queues before resetting the
> >>>    hardware. This change may help to avoid the reset loop.
> >>> 4. Change hang check function return type to bool as we only need
> >>>    to return two status, yes or no.
> >>> 
> >>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

> >>Is this patch ok to take?
> >
> >
> > Hi! I think it's ready. I've been testing it for a few weeks.
> 
> That question was more towards maintainers Stanislaw, Helmut and other
> reviewers :)
> 
> That reminds me, is Helmut still maintaining this driver? I haven't seen
> an ack from him since 2016. As we nowadays try to keep the MAINTAINERS
> up-to-date so should we remove him?

Yeah, feel free to remove him. I can post a patch if needed.

Regards
Stanislaw

