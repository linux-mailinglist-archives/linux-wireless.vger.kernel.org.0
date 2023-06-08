Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C077172846D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jun 2023 18:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjFHQAO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Jun 2023 12:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237972AbjFHQAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Jun 2023 12:00:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BFC30CD
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 08:59:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EC1264EC4
        for <linux-wireless@vger.kernel.org>; Thu,  8 Jun 2023 15:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EF7C433D2;
        Thu,  8 Jun 2023 15:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239974;
        bh=ZPEff1ZRSF+DP6DGJ6dae2WNc+MwoTnIyhH7J5LCw+o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GmPmQ0rSPQHiVDFsdvpz7M75NfDejovZQ2dUE086lLacYB5CWZGL9PogVnmLdmnlo
         CCQktFuNeowsuaNtZ+EQkkS2aHTIfjcMS2aUwD+OxnyO8vp1fyM/74prRQTnWBlqQt
         VuhRRGpi07849uPoxCtBjFEJ66NS362hnUgc8/s3JD8Gpgh3WlovyjhdFCjTf9KhKF
         th18t2yNXGA4rlVBrrdCQdVcx8FU4Kp7Ts2i2qdnZQqWnKN3Wb1pV2N9fFcqTfqEJt
         uLi8WGDnofzTggExeSoH3ErRx0gGe7ahN72MJutKJyjckPUkU8eFdqUmOXu6iqWnFg
         6exolDYMLod4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] wifi: rtw89: refine clearing supported bands to check
 2/5
 GHz first
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230602150556.36777-2-pkshih@realtek.com>
References: <20230602150556.36777-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168623997184.5828.2367321219284832936.kvalo@kernel.org>
Date:   Thu,  8 Jun 2023 15:59:33 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> We refine to check if supported bands of NL80211_BAND_2GHZ and
> NL80211_BAND_5GHZ exist before freeing their iftype_data. For
> now, it does not really encounter problems because all current
> chips support both 2 GHz and 5 GHz. But, driver actually allows
> chips to declare whether 2/5 GHz are supported or not. In case
> some future chips really don't support them, we refine this code.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

b7d170d5a670 wifi: rtw89: refine clearing supported bands to check 2/5 GHz first
ffc235115313 wifi: rtw89: regd: judge 6 GHz according to chip and BIOS
9468046ff54e wifi: rtw89: regd: update regulatory map to R64-R40
f6baa1d3d570 wifi: rtw89: process regulatory for 6 GHz power type
b742394cfe80 wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (1 of 3)
2a8ec45f4d0e wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (2 of 3)
dad142c3f56a wifi: rtw89: 8852c: update TX power tables to R63 with 6 GHz power type (3 of 3)
5883fc2ef857 wifi: rtw89: 8852c: update RF radio A/B parameters to R63

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230602150556.36777-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

