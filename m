Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBED34D2E3C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 12:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiCILkB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 06:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCILkA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 06:40:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9507E49274
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 03:39:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EF6161871
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 11:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA10C340E8;
        Wed,  9 Mar 2022 11:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646825940;
        bh=Kc43U6Bj3Bq+jg1JHuT/PT5v8SHlKpV851yk2EzZcl8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Lyr0Tb6APp63y4wFM2r4QZvIc0CZMLWfJdPo+ed0J0vPgT9AN2IdxKJJCBilbGY1n
         NfOJQS9qu3xG2xlroVw2N35JkkUx3OR3HYnnBTnzuZjlwlQBEMIZpkDeU2Ayv21cfb
         +RrnkG/nhZ/2CgFzL1pxyRvagjYJiwUAfC1BaX5gPUti8PT3HjbVBx0IPApHbO+XFa
         d7J7FdTfJHznkBM+qe27vDQuIoIVVjwnR9mTJfxPDYwY++p24cdCSTCIOQQwVOi0sf
         v3Gev6WWz+lB6vHvQiWPbx+sZI7u2H3JvJJ27eunSNqWZ9y9+sxAshWv8ZvFD0hD3e
         QnEptQxMVoMpA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw89: 8852a: add ieee80211_ops::hw_scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220225030851.13327-2-pkshih@realtek.com>
References: <20220225030851.13327-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164682593609.8809.5519897685373259530.kvalo@kernel.org>
Date:   Wed,  9 Mar 2022 11:38:59 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po Hao Huang <phhuang@realtek.com>
> 
> Declare this function allows us to use customized scanning policy, so
> each scan takes less time. This is a similar implementation to hw_scan
> in rtw88, except that we offload more items to firmware and extend the
> maximum IE length. For backward compatibility, we fallback to sw_scan
> when firmware does not support this feature.
> 
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

895907779752 rtw89: 8852a: add ieee80211_ops::hw_scan
7bfd05ff4e80 rtw89: add tx_wake notify for low ps mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220225030851.13327-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

