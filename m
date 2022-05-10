Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F15220AF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 May 2022 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347055AbiEJQJJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 May 2022 12:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348650AbiEJQIh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 May 2022 12:08:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DFF19FB2F
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 09:02:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 38151CE1F2B
        for <linux-wireless@vger.kernel.org>; Tue, 10 May 2022 16:02:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93960C385A6;
        Tue, 10 May 2022 16:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652198567;
        bh=s58tRb8Pn+W4p81rLCw5rVH06ylo9D3iqgXoSE3Hocg=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=jffuEJUfIFzTgGhepG1mYOYzEDKZy/Q2cjSvLpv51jQIYA+mgroDD73TO1g9k8lwV
         NXlyVEdwwKboT2Qtc9u2j5CEdY/LlKYHf0d+GhH4DpinZut+TBhl+EHFgqJNSZMOg6
         fwv1jkcGiZIwDBRaI6uEGEZKa16jjMgdrk/W63hDtfkIXgA+F1ZN+HoR+GEfb5ihsB
         S8It+HtXAgkCMCNEn6rHnWZ1zhVYnGYNxShJkjB4OqR4/wZEphpFpa6nohPBdnb7cu
         C/g5tgT+q95PLm1eAhjf4N+82oy5T7PnJkiYAL8huxd623h5JKBVHUKuKY+mfp4bnQ
         KaKo3f4Wzzh0w==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jeff Johnson <quic_jjohnson@quicinc.com>
Cc:     Sriram R <quic_srirrama@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] ath11k: update missing mumimo and ofdma stats
References: <1652152236-12038-1-git-send-email-quic_srirrama@quicinc.com>
        <a4e023e1-9c8d-bdfe-1060-48a68fb46e74@quicinc.com>
Date:   Tue, 10 May 2022 19:02:43 +0300
In-Reply-To: <a4e023e1-9c8d-bdfe-1060-48a68fb46e74@quicinc.com> (Jeff
        Johnson's message of "Tue, 10 May 2022 08:54:46 -0700")
Message-ID: <871qx18jfg.fsf@kernel.org>
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

> On 5/9/2022 8:10 PM, Sriram R wrote:
>> Update the missing MU-MIMO/OFDMA info in PDEV RX,
>
> nit: can we use MU-MIMO and OFDMA in the subject as well?

I can fix that during commit.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
