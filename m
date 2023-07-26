Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6FB764115
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Jul 2023 23:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjGZVXv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Jul 2023 17:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGZVXs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Jul 2023 17:23:48 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A838926B8
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 14:23:44 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bb8e45185bso1767365ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Jul 2023 14:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690406624; x=1691011424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m6XD8OavGJfHNDlqaTxMVRCQptoHA5mpSAhAL1B9W6w=;
        b=l4LKKGUHYE5Vnh43DZx4HL1+7pFbh+J2HtBI+e1UTnY+IxoSSpBQZ7N19Sa1S5vCC4
         k19RqmxqXmtM5cEoF2b46bwBprq96IRR9rt6t7J6iG2/Q21mK+rVfI7ekz6/dScfbE2X
         CXy3ekOoDvByd/o/LThnjguOnvvOSSVRZS5J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690406624; x=1691011424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6XD8OavGJfHNDlqaTxMVRCQptoHA5mpSAhAL1B9W6w=;
        b=BwBVCW/O1QhtK3nTDxyTwpyA2ooQqUCE+/FeOnQWOHlGf5KaN1WuzdmhNC7S7L24Ts
         L1VdTY0beXfLw5iiXrBV/vT1MiIoIwFPHxPRXRF6ksShsZzLmU8nXuH0xeQ/wq8NcOtI
         s46EBVTV2f5pgZdBUFllKgRwx22UMinQ3skf6kuIG+kbdqXZYhTtDuCZY9S+AW9F35VU
         YrNKhp2oor/XLJ6fi+Vh/YtMfBFIUk99NedMMD2aX/jVWdw0AyUwsM34LfWCLS2opm0m
         ZTvc4QthV3xOIqHpgxh/imfGuq7/dCqAaxV7Z7qvvaaZWz4RqgBwQNb29QJOqTdadO4v
         E0og==
X-Gm-Message-State: ABy/qLbEfNHroeBlJ/uDC3mRLnEusYJabJCVE/oKK2LEtzikIozih39z
        kGOdqL+6h0fEb7ik1aebPjEtHw==
X-Google-Smtp-Source: APBJJlE4JPj5NEXjOC3WQoK1cCbtTyPw4joE7tfonopa9fywGe9FntYcnv4qJVz0mHE9mBlVL5+bqQ==
X-Received: by 2002:a17:902:e54a:b0:1b9:ebf4:5d2 with SMTP id n10-20020a170902e54a00b001b9ebf405d2mr3257553plf.33.1690406624118;
        Wed, 26 Jul 2023 14:23:44 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:cf94:79ce:7d48:984a])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902704c00b001bb97e51ab4sm13082plt.98.2023.07.26.14.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:23:43 -0700 (PDT)
Date:   Wed, 26 Jul 2023 14:23:42 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Polaris Pi <pinkperfect2021@gmail.com>
Cc:     matthewmwang@chromium.org, kuba@kernel.org, kvalo@kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v7] wifi: mwifiex: Fix OOB and integer underflow when rx
 packets
Message-ID: <ZMGO3r44oOtMck7S@google.com>
References: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230723070741.1544662-1-pinkperfect2021@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sun, Jul 23, 2023 at 07:07:41AM +0000, Polaris Pi wrote:
> Make sure mwifiex_process_mgmt_packet,
> mwifiex_process_sta_rx_packet and mwifiex_process_uap_rx_packet,
> mwifiex_uap_queue_bridged_pkt and mwifiex_process_rx_packet
> not out-of-bounds access the skb->data buffer.
> 
> Fixes: 2dbaf751b1de ("mwifiex: report received management frames to cfg80211")
> Signed-off-by: Polaris Pi <pinkperfect2021@gmail.com>
> ---
> V5: Follow chromeos comments: preserve the original flow of mwifiex_process_uap_rx_packet
> V6: Simplify check in mwifiex_process_uap_rx_packet
> V7: Fix drop packets issue when auotest V6, now pass manual and auto tests

"auto tests" isn't clear to anyone not familiar with Chromium stuff.
It'd be courteous to at least make an attempt to describe what this
means (even just, "ChromeOS WiFi test suite" or something). For the
record, I believe that's approximately this?

https://chromium.googlesource.com/chromiumos/third_party/autotest/+/HEAD/docs/wificell.md

Anyway, I think the patch contents look good:

Reviewed-by: Brian Norris <briannorris@chromium.org>
