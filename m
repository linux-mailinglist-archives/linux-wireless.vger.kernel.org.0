Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD67F0EB8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Nov 2023 10:14:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbjKTJOS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Nov 2023 04:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjKTJOR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Nov 2023 04:14:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A4B8
        for <linux-wireless@vger.kernel.org>; Mon, 20 Nov 2023 01:14:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86D0C433C9;
        Mon, 20 Nov 2023 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700471653;
        bh=vgJvmpCV9HLNfOdNG/HfmOWosDAeSYMlsE665fuAPjw=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=G+zTVl9KMKNRRENidWysHsqWhr/l2KuAmwmb+ySNZIefm4bR7G68rVRed50vJgU1C
         /homhVoWTYpHveinKRoJTaIpaB9/poh7EqgBP3R8du/EA4OJRIBe2LGzflgv9/2kjh
         qyoFYAsH4eXep0cPQ3iLSwYz8yqmXBieyqjld7PU82nSaCVQwyat+m+75VfC18h20K
         EX9xn7U/pQPBJ6Qy/SdUIuZsEZ2+V6NMQwhNBJMELaUbMH3bI/EO4UpyeA9pxpWQoD
         mKoMJr7K46ZRUrme5ZPYs91lSzrcwfGRFGCvjf9u6iGdK/mjqm8bDFjxMTQImqohCD
         l2NoTrPe6R1nQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     James Prestwood <prestwoj@gmail.com>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH 1/2] wifi: ath11k: use select for CRYPTO_MICHAEL_MIC
References: <20231113153544.282461-1-prestwoj@gmail.com>
        <343af05d-eab9-4411-a016-8d7d96f78379@quicinc.com>
Date:   Mon, 20 Nov 2023 11:14:10 +0200
In-Reply-To: <343af05d-eab9-4411-a016-8d7d96f78379@quicinc.com> (Jeff
        Johnson's message of "Thu, 16 Nov 2023 11:24:56 -0800")
Message-ID: <87pm04947x.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 11/13/2023 7:35 AM, James Prestwood wrote:
>> Let ath11k select this option automatically which makes building
>> more intuitive if the user enables this driver (rather than the
>> driver not building unless CRYPTO_MICAEL_MIC is explicitly enabled)
>
> s/MICAEL/MICHAEL/
>
> add hard stop
>
> Also suggest you include (or summarize) the information that Kalle
> shared that ath is the outlier here:
>
> Further investigation shows that ath11k and ath12k are the only who use
> 'depends on' with CRYPTO_MICHAEL_MIC:
>
> ./drivers/net/wireless/intel/ipw2x00/Kconfig:	select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/intersil/hostap/Kconfig:	select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/intersil/orinoco/Kconfig:	select CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/ath/ath11k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
> ./drivers/net/wireless/ath/ath12k/Kconfig:	depends on CRYPTO_MICHAEL_MIC
> ./drivers/staging/rtl8192e/Kconfig:	select CRYPTO_MICHAEL_MIC
> ./drivers/staging/ks7010/Kconfig:	select CRYPTO_MICHAEL_MIC
>
> consider these comments apply to ath12k change as well :)

BTW I can add these changes in the pending branch, no need to resend
because of this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
