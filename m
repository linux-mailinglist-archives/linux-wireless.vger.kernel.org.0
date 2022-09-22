Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30055E5C76
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 09:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiIVHbX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 03:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIVHbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 03:31:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480A379A43
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 00:31:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A519E62E10
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 07:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB014C433C1;
        Thu, 22 Sep 2022 07:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663831871;
        bh=p/n/2c3oDkf4hgIeuqkSs8FjK02uFuk4GAXJwgydQnE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=UTmpQYpLKBvCDBx0HfesiAuqd4EThGdI4r3zygP1QF+yn0cxP/Z2FZzY6tIQPMONu
         LyuSOgw/zz1aYkGEyQ63UoO4Z70pUR6Nc1ufFgcY4ypDlaKk+8SCq8mZEDmBbYm2dB
         EoC2UGDTXg0/pbp9lbS2/bIkMWr5mSyfntlv5hDpRwM+NguIgALAOHDluYtEH6+SvV
         rHMGkVnIy/afSBPPiP4AydXV3fjGqQ6yNlKIrAMk2S9xFpyWiKcwibOgCsBL40AELU
         qXjUuoVFWQYh4uxOjOTBwqJkT3fGitcQ0vUuISdZopg14qBf8j8tG7c9f4bjc8mOmP
         7xbSzlOqOuudQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>,
        <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: Re: [PATCH] ath11k: Add support to get power save duration for each client
References: <20220725054601.14719-1-quic_tamizhr@quicinc.com>
        <0c282a64-2ee7-f50f-1cbb-4c47b9089736@quicinc.com>
Date:   Thu, 22 Sep 2022 10:31:07 +0300
In-Reply-To: <0c282a64-2ee7-f50f-1cbb-4c47b9089736@quicinc.com> (Jeff
        Johnson's message of "Mon, 25 Jul 2022 08:49:20 -0700")
Message-ID: <87y1ub6f2c.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 7/24/2022 10:46 PM, Tamizh Chelvam Raja wrote:
>> From: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
> [snip]
>> Signed-off-by: Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
>> Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
>
> wrong order of S-O-Bs?
>
> Author should be first, then the patch sender should be 2nd

I fixed that in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
