Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A868F51D3F0
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390350AbiEFJIc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 May 2022 05:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbiEFJIb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 May 2022 05:08:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188A643D
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 02:04:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A15EB83470
        for <linux-wireless@vger.kernel.org>; Fri,  6 May 2022 09:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF5DC385AF;
        Fri,  6 May 2022 09:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651827886;
        bh=TXmXKROOQFPUwAMUkpU12yOUshYWNBEx9Vmv7ZV2FKI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=KrgmwXRU2ZhuwhIeFUnMG5fPtci/0KHHUGXjBOFi74Y/55KbpnIO1dSgPs2ctDHuz
         Hsja480c1XH2UYT/o8EP7NOYTVlacDF3ssO3SB6xgW9w5ekLHUp97YQnaLBxNYdrZR
         677tL3aZl4cApDM6WePF5kcshIWTdsIcFh6s/+0S67VO9a3KTfqYHmCwyLIp5mVVZV
         i05H9lRKw9XBN6tkbnUkgNUEabLdQ2d1qX68umEW9/aSO5SIf2vAMtN+MlQCO4rQuA
         tNEMjD+GpsodCyw0fCYSQKW2mx9S49nTrm76FqsL5BKIsU6eZ9DtGwwu8vO5lillmM
         3PzGn+c+DAbLQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] ath11k: mac: fix too long line
References: <20220503060415.24499-1-kvalo@kernel.org>
        <f2f27831-03eb-3788-5855-649c0f33c785@quicinc.com>
        <87y1zhalfy.fsf@kernel.org>
        <1615688c-fb7d-261a-7b01-fe47c74b9597@quicinc.com>
Date:   Fri, 06 May 2022 12:04:42 +0300
In-Reply-To: <1615688c-fb7d-261a-7b01-fe47c74b9597@quicinc.com> (Jeff
        Johnson's message of "Wed, 4 May 2022 09:30:35 -0700")
Message-ID: <87y1zf821h.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 5/3/2022 10:58 PM, Kalle Valo wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> pe>> is there a reason to not declare deflink here?
>>> then its scope of definition would equal the scope of usage
>>
>> In ath10k and ath11k I have tried to avoid that and instead declare all
>> variables in the beginning of the function, this is to keep the code
>> simple. Of course there are few cases where a variable is declared in
>> the middle of the function, but that's just sloppy review on my part. I
>> feel that it's better to refactor the function into smaller functions
>> than start declaring variables in the middle of functions. Does that
>> make sense?
>>
>
> This is really an academic question.
>
> In the larger kernel community I'm seeing a push to reduce the scope
> of identifiers in some cases:
> 1) declaring loop control variables within the actual loop control operation
> 2) prohibiting the access to list iterators outside the list iteration loop

Yeah, those are definitely good examples when to limit scope.

And of course this isn't a hard rule, in some cases we have to make
exceptions. For example ath11k_mac_op_bss_info_changed() and
ath11k_mac_op_sta_state() are long functions but trying to split them to
smaller functions most likely makes them harder to read. So for these
functions having variables declared within if blocks would sound like a
good idea, I think it would make the functions more readable.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
