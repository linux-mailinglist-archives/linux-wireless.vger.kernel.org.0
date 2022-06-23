Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C829A557A1C
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 14:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiFWMQk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 08:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiFWMQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 08:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85853151E;
        Thu, 23 Jun 2022 05:16:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5594361B54;
        Thu, 23 Jun 2022 12:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 016DBC341C6;
        Thu, 23 Jun 2022 12:16:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fNTwnA8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655986594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ldgjSlcLJR6cjeouZsLQlrtYf5ACY3Wsfvn1/IBZujE=;
        b=fNTwnA8wDG/wg9DlpnOHl13P9917UsEIoqsT+iu6UKmx+4kOwLaDhMxiwSTYvmahJbQnZf
        Fr3d//8sfs9SD3qv9NYC6i1OEgJPh/2JvsG9A6o2xieDpB3/2g0FOLaGBRI6+oD7ON1O+u
        eHK4z7j1ccL6eboVigbvq58/WxwDkQ8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 89d1b8ea (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 23 Jun 2022 12:16:34 +0000 (UTC)
Date:   Thu, 23 Jun 2022 14:16:32 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Gregory Erwin <gregerwin256@gmail.com>
Cc:     Miaoqing Pan <miaoqing@codeaurora.org>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        ath9k-devel <ath9k-devel@qca.qualcomm.com>,
        linux-crypto@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: ath9k: hwrng blocks for several minutes when phy is un-associated
Message-ID: <YrRZoGBMBa3lFkwx@zx2c4.com>
References: <CAO+Okf6ZJC5-nTE_EJUGQtd8JiCkiEHytGgDsFGTEjs0c00giw@mail.gmail.com>
 <YrRZLPQHK0QbLTjr@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrRZLPQHK0QbLTjr@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Or perhaps more simply:

diff --git a/drivers/net/wireless/ath/ath9k/rng.c b/drivers/net/wireless/ath/ath9k/rng.c
index cb5414265a9b..5b44cd918c2b 100644
--- a/drivers/net/wireless/ath/ath9k/rng.c
+++ b/drivers/net/wireless/ath/ath9k/rng.c
@@ -83,7 +83,8 @@ static int ath9k_rng_read(struct hwrng *rng, void *buf, size_t max, bool wait)
 		if (!wait || !max || likely(bytes_read) || fail_stats > 110)
 			break;

-		msleep_interruptible(ath9k_rng_delay_get(++fail_stats));
+		if (msleep_interruptible(ath9k_rng_delay_get(++fail_stats)))
+			break;
 	}

 	if (wait && !bytes_read && max)

