Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354B2713366
	for <lists+linux-wireless@lfdr.de>; Sat, 27 May 2023 10:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjE0Ibv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 May 2023 04:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231726AbjE0Ibt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 May 2023 04:31:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A76F3
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 01:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D081F608D5
        for <linux-wireless@vger.kernel.org>; Sat, 27 May 2023 08:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F407C433EF;
        Sat, 27 May 2023 08:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685176306;
        bh=547n+5c8K+MDEglbwG9LGEaBa3KvZRN1jnqEom9nLb8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EzD5IXSVCJBAi4tj9R7xKETFuyxGbhGcd+fDSr03eUOOdUmM3QFsNSasjUHfa+C9G
         R6o7ZPSy6bBTTZwzJmadVAYzYLFDpvhAe4tU8fkmgaAVzByNWyAm05jETePBg61rEz
         hhCWI6szeOcK36sTXDL5wKZPFfsqrqryP5l0a6XHFBT4VdjQFK/D5fpjjDtHmrnSLd
         8HCfV3LodXb9YkiIFs7t74fSeZXm3f+rXt5MbnfD7eS+/piOwfXq3ibedhqbPRqvvp
         i7ibsYce1Ie8Bw4F3u52MdmRsPTnxtZpJ+mWD6gFufBkWMO8Gka4N9CprUkPVM9W0o
         QhbsJkY3/LD1Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: usb: silence log flooding error message
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230524103934.1019096-1-s.hauer@pengutronix.de>
References: <20230524103934.1019096-1-s.hauer@pengutronix.de>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Hans Ulli Kroll <linux@ulli-kroll.de>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Pkshih <pkshih@realtek.com>, Tim K <tpkuester@gmail.com>,
        "Alex G ." <mr.nuke.me@gmail.com>,
        Nick Morrow <morrownr@gmail.com>,
        Viktor Petrenko <g0000ga@gmail.com>,
        Andreas Henriksson <andreas@fatal.se>,
        ValdikSS <iam@valdikss.org.ru>, kernel@pengutronix.de,
        petter@technux.se, Sascha Hauer <s.hauer@pengutronix.de>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168517630118.21544.2267680746869698839.kvalo@kernel.org>
Date:   Sat, 27 May 2023 08:31:43 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sascha Hauer <s.hauer@pengutronix.de> wrote:

> When receiving more rx packets than the kernel can handle the driver
> drops the packets and issues an error message. This is bad for two
> reasons. The logs are flooded with myriads of messages, but then time
> consumed for printing messages in that critical code path brings down
> the device. After some time of excessive rx load the driver responds
> with:
> 
> rtw_8822cu 1-1:1.2: failed to get tx report from firmware
> rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> rtw_8822cu 1-1:1.2: firmware failed to report density after scan
> 
> The device stops working until being replugged.
> 
> Fix this by lowering the priority to debug level and also by
> ratelimiting it.
> 
> Fixes: a82dfd33d1237 ("wifi: rtw88: Add common USB chip support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

1f1784a59caf wifi: rtw88: usb: silence log flooding error message

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230524103934.1019096-1-s.hauer@pengutronix.de/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

