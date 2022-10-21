Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6E60725E
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Oct 2022 10:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJUIdn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 04:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiJUIdm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 04:33:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331DD5B9E6
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 01:33:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDAEB61DD7
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 08:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72460C433D6;
        Fri, 21 Oct 2022 08:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666341129;
        bh=DmHWC++gP2rCYs1bP6ciQXbsn2q9U2LCgCYB8RYFUf4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=uizwqBAyMda1rf1B2MSz3uBAbKJSInfjWkC3A5tvTy4jgBeRtNQ1tkbCeS4K3j1t+
         OtmNr4y9ddCqP5HFsTkMZrjnhBff4Vx4vG2sVGwb4di2NHn92XL5mhko/sjPZYuRfL
         80olcipls/UyGzRtMYDEIOyMUyjDpuzVTHEyW1N/EPk7Z0OLv68kj/iiP2U1Y8DwEo
         HUAp8JAe2GTYMxTDNttbYvf7lXmIJJVz1/v+wW7TwVInCaBKu+GFMcseX3R+NNMmCP
         atTy0ymIPEC1cMc4r1wdVYu3SLrOcVCXfCi99rKVL1eBl4DCO8uA8aJ3C8ly4l1x2U
         cjNG7Lt+N1UnA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k\@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 05/50] wifi: ath12k: add core.c
References: <20220812161003.27279-1-kvalo@kernel.org>
        <20220812161003.27279-6-kvalo@kernel.org>
        <6cce0974d5bb40c2a2a40b4abeb41e74@realtek.com>
Date:   Fri, 21 Oct 2022 11:32:04 +0300
In-Reply-To: <6cce0974d5bb40c2a2a40b4abeb41e74@realtek.com> (Ping-Ke Shih's
        message of "Tue, 13 Sep 2022 06:18:01 +0000")
Message-ID: <87a65plgqj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> writes:

>> -----Original Message-----
>> From: Kalle Valo <kvalo@kernel.org>
>> Sent: Saturday, August 13, 2022 12:09 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: ath12k@lists.infradead.org
>> Subject: [PATCH 05/50] wifi: ath12k: add core.c
>> 
>> From: Kalle Valo <quic_kvalo@quicinc.com>
>> 
>> (Patches split into one patch per file for easier review, but the final
>> commit will be one big patch. See the cover letter for more info.)
>> 
>> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

[...]

>> +MODULE_DESCRIPTION("Core module for Qualcomm Atheros 802.11be
>> wireless LAN cards.");
>> +MODULE_LICENSE("Dual BSD/GPL");
>
> // SPDX-License-Identifier: BSD-3-Clause-Clear
>
> Out of curiosity, SPDX license and MODULE_LICENSE() are different. 
> Could I know the rules?

The rules are in linux/module.h:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/module.h#n185

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
