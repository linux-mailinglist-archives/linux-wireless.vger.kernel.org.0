Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE535B151E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Sep 2022 08:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiIHGuy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Sep 2022 02:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiIHGuO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Sep 2022 02:50:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD817FFA7
        for <linux-wireless@vger.kernel.org>; Wed,  7 Sep 2022 23:50:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC58661B48
        for <linux-wireless@vger.kernel.org>; Thu,  8 Sep 2022 06:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50322C433C1;
        Thu,  8 Sep 2022 06:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662619800;
        bh=U6BKQuMQPjPIj7UYLySFnwE0T6a7A1V+ksMafHOAoJU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=muP1SlBhmY5pUmbfoXIneJjuw8poFU6ghR9oW48duEe3t2B4DaxL0MLNG/i45S0pd
         9+IuqYw7fyteKnPlAM2H36+KJ9zEAL0vEeu0DINHuPspqHQEU582sOFD0/d46VI+X2
         D/0A2ldbF7FIBUgIcsrIXaTxP+yvpbMKY5sGeZyo1yHjfIX7WD0ajE2kZqMp8hMhzr
         0uLgkscE32hFx0KZHymkyMu9MgtIKg6TQ4LlPbJ+UA08cakIdxDhzhTCRGa7za3dJM
         0Zpb4keFxVF/FuHElwipPXsDuDbcVNcXPSQQoZv2fb4HblmEBQ2xZ5JT7hSuzbWS7u
         xGJcvQ9vMJRyg==
From:   Kalle Valo <kvalo@kernel.org>
To:     Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/3] ath11k: Enable threaded NAPI on WCN6750
References: <20220720135113.15755-1-quic_mpubbise@quicinc.com>
        <20220720135113.15755-2-quic_mpubbise@quicinc.com>
        <87czceaqng.fsf@kernel.org>
        <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com>
Date:   Thu, 08 Sep 2022 09:49:56 +0300
In-Reply-To: <dcc14883-51c9-c1bb-bbea-1b309eccedf2@quicinc.com> (Manikanta
        Pubbisetty's message of "Fri, 2 Sep 2022 18:47:41 +0530")
Message-ID: <874jxicqcr.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Manikanta Pubbisetty <quic_mpubbise@quicinc.com> writes:

>> Also more testing would be nice. Enabling something like this with
>> testing only on one hardware family (WCN7850) can be risky. I always get
>> warm fuzzy feelings if a patch is tested with all three hardware
>> families we currently support:
>>
>> * IPQ8074 etc
>> * QCA6390 etc
>> * WCN7850
>
> WCN7850 should be an ath12k device If I'm correct.

Sorry, I meant WCN6855. Too many drivers and too many hardware...

> Regardless of the chip family, even I feel that the tput changes like
> these should be tested on all the chipsets. Availability of the
> hardware and time are something which are stopping me in testing the
> changes on all supported targets.

I have the same problem, I cannot test all possible hardware. That's why
I was requsting help here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
