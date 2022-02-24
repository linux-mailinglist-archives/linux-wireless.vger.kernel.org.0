Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9B4C275E
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 10:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232078AbiBXJCD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 04:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiBXJCC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 04:02:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3F0B14
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 01:01:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29ABDB82490
        for <linux-wireless@vger.kernel.org>; Thu, 24 Feb 2022 09:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B713C340F5;
        Thu, 24 Feb 2022 09:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645693288;
        bh=iWQ9/XL+XPCbRTAkF64mX9DhFmkRiHGrDG2Zeem6XZU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EHa/5lC/sts4ozi3E7clHtypP0AOboxq1sZmlPrTcor6/H3S6zWLkt3Wl7n7YAAnE
         unyS3N2duYhysqo46XhgI70CEWE+s7XEqdy1cX9txd+4F0sLlIRBt06Uel0/fRJxZB
         rQB8hAbyTpmVAARNOUxZeCiHm9UuvyKYwdvJ95IyM4Vn8Ei+WMDJOXhDv+sg6Insx3
         dIvY5TwcK5ORAOIgeb1ZLVaP5C7BopP51WEXDYxpcBbDQB9R/J9hP04ZhpE00vycRU
         LmZVHXhjQpL3rIAVIwdWt9wnj6XuHQAhF1t4BYi74txb4mAywJyI3yfDpzUpmTffLZ
         8mgPrhcNJKG+A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v10 1/3] ath11k: switch to using ieee80211_tx_status_ext()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220217012112.31211-2-pradeepc@codeaurora.org>
References: <20220217012112.31211-2-pradeepc@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164569328285.30378.10070902613470760583.kvalo@kernel.org>
Date:   Thu, 24 Feb 2022 09:01:27 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> wrote:

> This allows us to pass HE rates down into the stack.
> 
> Co-developed-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: Miles Hu <milehu@codeaurora.org>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

3 patches applied to ath-next branch of ath.git, thanks.

94739d45c388 ath11k: switch to using ieee80211_tx_status_ext()
01d2f285e3e5 ath11k: decode HE status tlv
ab0a9ef605cf ath11k: translate HE status to radiotap format

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220217012112.31211-2-pradeepc@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

