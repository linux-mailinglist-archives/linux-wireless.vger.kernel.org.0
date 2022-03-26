Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CC44E8018
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Mar 2022 09:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbiCZIuK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 26 Mar 2022 04:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCZIuJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 26 Mar 2022 04:50:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A24A652C8
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 01:48:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 21D1AB800C1
        for <linux-wireless@vger.kernel.org>; Sat, 26 Mar 2022 08:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF1CC2BBE4;
        Sat, 26 Mar 2022 08:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648284508;
        bh=CWs64S7u0xalXvKpz9zCgW770mWGSrIjJcogyJjbcLg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=CLpm8T5gs5sWV1cTCVsyg7NwM+WUCv1k2ipHkDwfw06Ih6W7bCGNOUQaOO4/qk9GG
         EljLeUN9AsUEDu1nR/mThtH9muvX8cRGO7igJbHt1dAr+X/hE9ENhcbcBCAfFO+o1W
         xyea1DqyKEAh2ZnrLVDtIHxWluOqNLRUTFIKh5+IURC3s2gMmMErK5UgbDO0Q99bQM
         rBuWtkg8nn76Dd2WXbgbW6llegrgBPGLIJbRuQhSROKapeFDtS0Pxmu6xxmrjojC6d
         c25ys0smg+imOgRFLiTa8WucKB3NnYRdZcex3xMX0ZBvWJKpP1i0nRgN04leZBo9cU
         oGAIFrtIjq3Sw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Maharaja Kennadyrajan <quic_mkenna@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v6 1/3] nl80211: Add support for beacon tx mode
References: <20220325055949.3035053-1-quic_mkenna@quicinc.com>
        <20220325055949.3035053-2-quic_mkenna@quicinc.com>
        <bca5ba81-7e97-9b54-be57-a40df9b0634c@quicinc.com>
Date:   Sat, 26 Mar 2022 10:48:23 +0200
In-Reply-To: <bca5ba81-7e97-9b54-be57-a40df9b0634c@quicinc.com> (Jeff
        Johnson's message of "Fri, 25 Mar 2022 12:18:41 -0700")
Message-ID: <87lewxnlpk.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 3/24/2022 10:59 PM, Maharaja Kennadyrajan wrote:
> [...snip...]
>
>> +/**
>> + * enum nl80211_beacon_tx_mode - Beacon Tx Mode enum.
>> + * @NL80211_BEACON_STAGGERED_MODE: Used to configure beacon tx mode as
>> + *	staggered mode. This is the default beacon tx mode.
>
> Documentation doesn't match the code. There is now a default mode, and
> that is, well, the default mode

But what does the default mode mean in this case? :) Please document in
detail what the driver is supposed to do in this mode.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
