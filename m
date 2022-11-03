Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C9561768C
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Nov 2022 07:04:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbiKCGEL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Nov 2022 02:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiKCGEI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Nov 2022 02:04:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3CA193D8;
        Wed,  2 Nov 2022 23:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDDB3B82623;
        Thu,  3 Nov 2022 06:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7E1C433D6;
        Thu,  3 Nov 2022 06:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667455445;
        bh=rFhLifYy+8HsdQTm8osPCDSqqdwFjwybPV/8Y+l48FQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=GL8HssBJpWpsGzTIJopmmhZ4bsHyh8YS9odof1AgbpYE56g2V9Rm+HE2tj8PcwftU
         L/rf6ly9l7WOWecQZkRMv5z+WuABFVSLRYc9neJ5MxTOGIVTrhbMMefZKL0ZsHC5FD
         EnNqZGoV0yQ1O84UH6lzycrdyB+P6TcJp2GnuFluCrUaEJnPqzW+mjuTn/vpSsB0qy
         +xmeP6UgvggxBwFaWEIGi+O6iu6pgS4uDOmXcZfSqEt/lezCC8Uq7p/v/rMTYxQlkc
         uyu44w6Be0sExGRgDaD/eQnzKY9dtjudICfqclrla1pxQ2xzgacf1JOjiXvH71QKo+
         EQwztzVwxkvNA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     coverity-bot <keescook@chromium.org>,
        Gary Chang <gary.chang@realtek.com>,
        Timlee <timlee@realtek.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-next\@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-hardening\@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        linux-wireless@vger.kernel.org
Subject: Re: Coverity: rtw89_mac_resize_ple_rx_quota(): Integer handling issues
References: <202211021253.44E254479@keescook>
        <884ff1b628e44d32960f438f75a6524c@realtek.com>
Date:   Thu, 03 Nov 2022 08:03:59 +0200
In-Reply-To: <884ff1b628e44d32960f438f75a6524c@realtek.com> (Ping-Ke Shih's
        message of "Thu, 3 Nov 2022 01:26:45 +0000")
Message-ID: <87h6zgfub4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: coverity-bot <keescook@chromium.org>
>> Sent: Thursday, November 3, 2022 3:53 AM
>> To: Gary Chang <gary.chang@realtek.com>
>> Cc: Timlee <timlee@realtek.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih <pkshih@realtek.com>; Gustavo
>> A. R. Silva <gustavo@embeddedor.com>; linux-next@vger.kernel.org; linux-hardening@vger.kernel.org
>> Subject: Coverity: rtw89_mac_resize_ple_rx_quota(): Integer handling issues
>> 
>> Hello!
>> 
>> This is an experimental semi-automated report about issues detected by
>> Coverity from a scan of next-20221102 as part of the linux-next scan project:
>> https://scan.coverity.com/projects/linux-next-weekly-scan
>> 
>> You're getting this email because you were associated with the identified
>> lines of code (noted below) that were touched by commits:
>> 
>>   Tue Nov 1 11:26:13 2022 +0200
>>     7a68ec3da79e ("wifi: rtw89: add function to adjust and restore PLE quota")
>> 
>> Coverity reported the following:
>> 
>> *** CID 1527095:  Integer handling issues  (SIGN_EXTENSION)
>> /drivers/net/wireless/realtek/rtw89/mac.c: 1562 in rtw89_mac_resize_ple_rx_quota()
>> 1556     		rtw89_err(rtwdev, "[ERR]get_dle_mem_cfg\n");
>> 1557     		return -EINVAL;
>> 1558     	}
>> 1559
>> 1560     	min_cfg = cfg->ple_min_qt;
>> 1561     	max_cfg = cfg->ple_max_qt;
>> vvv     CID 1527095:  Integer handling issues  (SIGN_EXTENSION)
>> vvv     Suspicious implicit sign extension: "max_cfg->cma0_dma" with type "u16" (16 bits, unsigned) is
>> promoted in "max_cfg->cma0_dma << 16" to type "int" (32 bits, signed), then sign-extended to type "unsigned
>> long" (64 bits, unsigned).  If "max_cfg->cma0_dma << 16" is greater than 0x7FFFFFFF, the upper bits of the
>> result will all be 1.
>
> Thanks for pointing this. I'll fix it.

Thanks Ping.

I noticed that linux-wireless list was missing in CC, would it possible
for the bot to automatically add that to all wireless related reports?
Adding it manually now.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
