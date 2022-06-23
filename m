Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C57A557A0E
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 14:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiFWMOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiFWMOq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 08:14:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046A219F;
        Thu, 23 Jun 2022 05:14:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE185B821D5;
        Thu, 23 Jun 2022 12:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A450EC3411B;
        Thu, 23 Jun 2022 12:14:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ZyceW3nV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655986479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E8jdJIRzA1iOORaTEf/RwVI5GsVVtwzLHx5t+phlsrg=;
        b=ZyceW3nVnyup8sNSwO4OqvLCVU3YvTxHicYyytWmA57+rIrc3jQ1ZktF5uaSh9tZ1/+mfb
        mff+BPY8/ZPdXjlOrwBFhagofjc7ATezWOtOQXbBmPa9b8/Pthj3Hvs6PWzCgNuod/draG
        zN5IZI+vu7Jar0hI3M7VTEdx3DaYoCI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 93aa512b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 23 Jun 2022 12:14:39 +0000 (UTC)
Date:   Thu, 23 Jun 2022 14:14:36 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Gregory Erwin <gregerwin256@gmail.com>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>,
        linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: ath9k: hwrng blocks for several minutes when phy is un-associated
Message-ID: <YrRZLPQHK0QbLTjr@zx2c4.com>
References: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Gregory,

On Wed, Jun 22, 2022 at 10:08:15PM -0700, Gregory Erwin wrote:
> Hello,
> 
> I bisected down to commit [fcd09c90c3c5] "ath9k: use hw_random API instead of
> directly dumping into random.c'' while investigating a long delay when entering
> suspend on kernels v5.18 onward. There are other reports of hangs or
> unresponsiveness at https://bugs.archlinux.org/task/75138 with some more info.
> 
> AFAIKT, the issue is triggered by the ath9k hwrng when the interface is up,
> but not associated with any AP. In this state, 'dd if=/dev/hwrng' will block
> for up to 231 seconds before finally returning an input/output error. Similarly,
> I get a kernel log message "hwrng: no data available" every 231 seconds.
> 
> The hwrng will unblock when attempting to connect to an SSID that doesn't exist,
> but not when performing a scan, so I'm guessing AR_PHY_TST_ADC only produces new
> data when the phy is transmitting.
> 
> Admittedly, I don't actually know if this blocking behavior is
> expected or not, but it certainly seems undesirable.

Thanks for the report. I wish somebody from one of those bug reports
would have emailed earlier.

I don't have hardware to test this, but could you let me know if the
below patch does something? I'm sort of guessing, but maybe this is
right?

Jason

diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index cb5414265a9b..a6291f5f0d47 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -80,7 +80,7 @@ static int ath9k_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 			bytes_read += max & 3UL;
 			memzero_explicit(&word, sizeof(word));
 		}
-		if (!wait || !max || likely(bytes_read) || fail_stats > 110)
+		if (!wait || !max || likely(bytes_read) || fail_stats > 110 || kthread_should_stop())
 			break;

 		msleep_interruptible(ath9k_rng_delay_get(++fail_stats));

