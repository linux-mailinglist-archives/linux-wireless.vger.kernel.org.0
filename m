Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC70E58C4B6
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Aug 2022 10:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235837AbiHHIKa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Aug 2022 04:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbiHHIK3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Aug 2022 04:10:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5030C10FE9
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 01:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB53B60ECE
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 08:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 965C5C433C1;
        Mon,  8 Aug 2022 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659946227;
        bh=Vnofo+8cOpI5iozV0xgNLxioDFpMQQslwFH20M0AtVM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bib6RYYENEqm9JKS6xu55gpaLnRDDhoQAxcArC8j/B/FiFaouTZQChXqaRfeIO8Zt
         XuPhHLRAIScSG3kMGGi4ahb6meAYON5SXuwQa2sfGFfuqzUrpusceoMqTrWjnPvUYV
         Exse2tJ6HGmZO4tdkKMpkdnNUsAtyyALQC2XTsVf4/4CdnjUmREawdlRNv8l8M2XyJ
         APMJdULTfuVXAclJf+KFUJ7wEOP1kLdG4NKe6mcoCo//mTYU5ubnEd7gvzfsOAm0XH
         z5xyfhT0y41nGR5PmPWfkQAp3qQWSsvmBrJRIwVqeSNvcNgKIJOgQwwOQimQmk68Qk
         Xy7NXw/GzFS1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: cfg80211: Fix validating BSS pointers in
 __cfg80211_connect_result
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220805135259.4126630-1-quic_vjakkam@quicinc.com>
References: <20220805135259.4126630-1-quic_vjakkam@quicinc.com>
To:     Veerendranath Jakkam <quic_vjakkam@quicinc.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165994621338.4951.14995602960290467000.kvalo@kernel.org>
Date:   Mon,  8 Aug 2022 08:10:26 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Veerendranath Jakkam <quic_vjakkam@quicinc.com> wrote:

> Driver's SME is allowed to fill either BSSID or BSS pointers in struct
> cfg80211_connect_resp_params when indicating connect response but a
> check in __cfg80211_connect_result() is giving unnecessary warning when
> driver's SME fills only BSSID pointer and not BSS pointer in struct
> cfg80211_connect_resp_params.
> 
> In case of mac80211 with auth/assoc path, it is always expected to fill
> BSS pointers in struct cfg80211_connect_resp_params when calling
> __cfg80211_connect_result() since cfg80211 must have hold BSS pointers
> in cfg80211_mlme_assoc().
> 
> So, skip the check for the drivers which support cfg80211 connect
> callback, for example with brcmfmac is one such driver which had the
> warning:
> 
> WARNING: CPU: 5 PID: 514 at net/wireless/sme.c:786 __cfg80211_connect_result+0x2fc/0x5c0 [cfg80211]
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Fixes: efbabc116500 ("cfg80211: Indicate MLO connection info in connect and roam callbacks")
> Signed-off-by: Veerendranath Jakkam <quic_vjakkam@quicinc.com>
> [kvalo@kernel.org: add more info to the commit log]

Patch applied to wireless.git, thanks.

baa56dfe2cda wifi: cfg80211: Fix validating BSS pointers in __cfg80211_connect_result

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220805135259.4126630-1-quic_vjakkam@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

