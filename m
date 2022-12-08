Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 320A064753E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Dec 2022 19:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiLHSB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Dec 2022 13:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiLHSBz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Dec 2022 13:01:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB774AD313
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 10:01:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA4362017
        for <linux-wireless@vger.kernel.org>; Thu,  8 Dec 2022 18:01:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB7FBC433D2;
        Thu,  8 Dec 2022 18:01:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670522512;
        bh=on1+QRlIvDYz/5vEct+6S8cHbCRZt7ZeIgH6zrgyf2U=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lL0GnfOLj7hepUuca4nU42NauHke7t6Wu+6SLOm6wCja7lAjHBUNQhCrFruJBisS/
         H19hqxZJ/crzpclqgqOJ03VSZgqDBvUQkxqN1mWAt8wj558QNge5kY6/fZtKP3cMeE
         N8qU90FLLMI7xA0F2uNkvfRyuLI6adUWa6UJcSH1LkY9MBO22QlLGWgNwXupolTbTe
         30JFeGdLTuSbKmvLS5lCdH7XEs5/6ZaiZrmhvVDyFYI2d6l2bGmAYH8d30AEnzRo0S
         1WJvyO3DmNqktqSEOt+gGgJ0kWPKOO7yER3JuwFJhvt8vYP2WgFvDNVy6+vvnPHEek
         fBMzjTXtVhlhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix scan request param frame size warning
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221205192125.13533-1-quic_kathirve@quicinc.com>
References: <20221205192125.13533-1-quic_kathirve@quicinc.com>
To:     Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167052250860.20906.4772122739003133775.kvalo@kernel.org>
Date:   Thu,  8 Dec 2022 18:01:51 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Kathirvel <quic_kathirve@quicinc.com> wrote:

> Following warning was observed
> 
> drivers/net/wireless/ath/ath11k/mac.c:2351:1: warning: the frame
> size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> A local variable is declared with a size larger than 1024 bytes
> this causing a compilation warning. Change the local variable to
> heap memory to fix the warning.
> 
> Tested-on: IPQ8074 AHB WLAN.HK.2.7.0.1-01701-QCAHKSWPL_SILICONZ-1 v2
> 
> Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

d45daa6d1a8d wifi: ath11k: Fix scan request param frame size warning

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221205192125.13533-1-quic_kathirve@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

