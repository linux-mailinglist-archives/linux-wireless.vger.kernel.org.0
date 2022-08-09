Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1379758D359
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 07:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbiHIFsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 01:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHIFsi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 01:48:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C31BEAD
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 22:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9A461185
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 05:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA87C433D6;
        Tue,  9 Aug 2022 05:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660024115;
        bh=2W669nJ1EzQXOxEgsEOeCSOqSkjqcX+MKr/icofkDRc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=WqevvAEt1+WqtrYpeEuhVeD3ZPsD2L3+c1TO2KKIrcOrByi394IaTDN1n1m6bjnHd
         rupB6zZW3PcK/mPYwVxE58Qzfmr83u5AnyX9re9LRYuw5a9Onapc9EFR44BYrGFOjs
         zUKvIzTmGSBExykC4PC2q1ApM3SOblCubADUb65AIJU4ebw4GuvSRZ5PebKnlLqkVD
         /ZMkt5GpPMYx8YFPHPRHcetw8Og2fwOsMiK243K02BjPhvwRz8P34PFbyud2lnNbwH
         ETAaHzRM4k7sukxoFPORan3u3yDTch3Gc0n1UKRyz4m0iLLADjkx//GXDNj81noDWF
         pvjG3REKVfGgA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3,1/4] wifi: rtw88: 8822c: extend supported probe request size
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220727065003.28340-2-pkshih@realtek.com>
References: <20220727065003.28340-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <gary.chang@realtek.com>,
        <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002411090.8958.12960245596599654054.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 05:48:34 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Some WSC IEs require size larger than we current supports. Extend size
> to fit those demands. Separate the registered scan IE length by IC so
> settings can be independent.
> 
> Since old firmware uses fewer page number, define a firmware feature to
> be compatible with various firmware version.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

d2eb7cb97c7d wifi: rtw88: 8822c: extend supported probe request size
8edb22de9de7 wifi: rtw88: fix stopping queues in wrong timing when HW scan
79ba1062c459 wifi: rtw88: fix store OP channel info timing when HW scan
86331c7e0cd8 wifi: rtw88: phy: fix warning of possible buffer overflow

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220727065003.28340-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

