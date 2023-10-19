Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A217CFB18
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 15:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbjJSNdI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 09:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjJSNdH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 09:33:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E70011B
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 06:33:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C38C433C8;
        Thu, 19 Oct 2023 13:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697722385;
        bh=/KTeEIlW5YqAIFD6soa+r7G+BrGSwAXI0I+oMa3g2uY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=S3RU1dCmJIbuuGenx9G1CL8mxwnOV+l86BL/rp0luxJc2CkeS6CGSz/crv+WJCEb0
         XZlJmk9DC/+pnRZkDpChWmAkRFl5te+7zbUmxa1IMyIdWseY9J5rBVfjDzKYSjRvDF
         CGo44Sytxm+LecjMRTg6Hs2PXZzjhluKEFBDf++om7ARdPqInnWoiLKpgBdD2bpjdw
         90rDvZ4XxHmdl4hL9uC/fy/Ti+R/rqZ72PcRBAY0jsfgQvovnelvqG2Yh1OFhKf8W0
         CMT80303sg0pobEKFOJA8PZCeFjOd185lf+fUzdpmaJ1i4fkf1jgVeS+puvKKM5eOu
         +A2y7M3d+n/SA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     helmut.schaa@googlemail.com, linux-wireless@vger.kernel.org,
        stf_xl@wp.pl
Subject: Re: [PATCH] wifi: rt2x00: fix rt2800 watchdog function
References: <169769882877.117236.15856778587852752332.kvalo@kernel.org>
        <TYAP286MB0315BFF338DEE34898A20584BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
Date:   Thu, 19 Oct 2023 16:33:02 +0300
In-Reply-To: <TYAP286MB0315BFF338DEE34898A20584BCD4A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
        (Shiji Yang's message of "Thu, 19 Oct 2023 20:05:13 +0800")
Message-ID: <87h6mm20vl.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Shiji Yang <yangshiji66@outlook.com> writes:

> On Thu, 19 Oct 2023 07:00:30 +0000, Kalle Valo wrote:
>
>>Shiji Yang <yangshiji66@outlook.com> wrote:
>>
>>> The watchdog function is broken on rt2800 series SoCs. This patch
>>> fixes the incorrect watchdog logic to make it work again.
>>> 
>>> 1. Update current wdt queue index if it's not equal to the previous
>>>    index. Watchdog compares the current and previous queue index to
>>>    judge if the queue hung.
>>> 2. Make sure hung_{rx,tx} 'true' status won't be override by the
>>>    normal queue. Any queue hangs should trigger a reset action.
>>> 3. Clear the watchdog counter of all queues before resetting the
>>>    hardware. This change may help to avoid the reset loop.
>>> 4. Change hang check function return type to bool as we only need
>>>    to return two status, yes or no.
>>> 
>>> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
>>
>>Is this patch ok to take?
>
>
> Hi! I think it's ready. I've been testing it for a few weeks.

That question was more towards maintainers Stanislaw, Helmut and other
reviewers :)

That reminds me, is Helmut still maintaining this driver? I haven't seen
an ack from him since 2016. As we nowadays try to keep the MAINTAINERS
up-to-date so should we remove him?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
