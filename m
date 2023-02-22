Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992A69F492
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Feb 2023 13:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjBVMa4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Feb 2023 07:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjBVMay (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Feb 2023 07:30:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAB932503
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 04:30:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 341D8B8125F
        for <linux-wireless@vger.kernel.org>; Wed, 22 Feb 2023 12:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2876BC433D2;
        Wed, 22 Feb 2023 12:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677069046;
        bh=thhpSMSrKDbBY1TPCR6M+wAL2+xV3T0IG+MORgO1YAw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VuNJsyqxL0jhGvJc/C/YJ3FErZa8BYQ3drY4ZdujzYuvVPjML9CXTJScFl76pruv1
         NlCjR9r2Fdgwg0NLFKYP9D5Gm5P+teVyTVx5qQhiT7JmB0G6QKkWIRLIobxMWZKOo2
         Ls8n31oFcHoPUC5AX5VREpQ9AcKIg533KE5N507Za3OBdhQpQyktROkTgoF5BB3JxE
         SSo1gOCSi4lqgHjOFIC31Jzf7EJ47Fw0pDk+G4Ab3MW8N22SWLJovJ4vSU7uCTL5uj
         YiROEOYPVtjNk0Ske9EP1wTrsiqEU263htXnplwgymXh7r6+nIfUYxULnsPla4AhNq
         VUpGX/MHLkB4A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw89: add RNR support for 6 GHz scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230217120007.8835-1-pkshih@realtek.com>
References: <20230217120007.8835-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167706904433.20055.10416608640157920935.kvalo@kernel.org>
Date:   Wed, 22 Feb 2023 12:30:45 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Since 6 GHz band has around 60 channels and more strict rules for
> active probing. Reduced neighbor report can be used to reduce the
> channels we scan and get specific target BSS info to probe for.
> 
> Declare flag WIPHY_FLAG_SPLIT_SCAN_6GHZ so the scan request could be
> divided into two portions: legacy bands and 6 GHz bands. So RNR
> information from legacy bands could later be used when 6 GHz scan.
> 
> When the scan flag NL80211_SCAN_FLAG_COLOCATED_6GHZ is set, cfg80211
> will pass down a reduced channel set which contains PSCs and non-PSC
> with RNR info received in the 2 GHz/5 GHz band. This reduces the
> scan duration by allowing us to only scan for channels in which APs
> are currently operating.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

c6aa9a9c4725 wifi: rtw89: add RNR support for 6 GHz scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230217120007.8835-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

