Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BAF85BC5F3
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Sep 2022 12:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbiISKC0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Sep 2022 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiISKCY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Sep 2022 06:02:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581B910D
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 03:02:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 191E1B808BD
        for <linux-wireless@vger.kernel.org>; Mon, 19 Sep 2022 10:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F6EC433C1;
        Mon, 19 Sep 2022 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663581740;
        bh=TAjgNNvH/vNy8LWjnZUYpsd9klrGYJO3joJkt1gM9Dg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VpTsBZhalY29JL+Ui/Zg+MyM7RsWIOaeY5u4MrnUuRbcTAneUzMSN5kAfbUZMoaNb
         jVTNXps61IvJmwNFJ6Zbt5I3oNDNwqIV9VF24VTm17f+LK9RiazKw+95u7i9fZrQs8
         DtSTXTFJTqLThjNKE0JSHRbCeBr6cUSZdw0Kyrl+wjEpNkfoPyzaiN4pHfSEbCLN7y
         eZ9mUSkaypvSa2iV6KVsgMhQ4twpG45prq8SJkaf59S5R42Tf0KuOx+OrwxFnAtIGa
         BMp4dzOCoQTmepdntw7Nzn15Sn/KCvDvB66U/UJkEey7LBy4AJClRbOQ8ATrdJQ6C9
         RbiQQegOCB6BA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: coex: show connecting state in debug message
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220912021009.6011-1-pkshih@realtek.com>
References: <20220912021009.6011-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166358173855.24821.18386341063538222936.kvalo@kernel.org>
Date:   Mon, 19 Sep 2022 10:02:20 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The variable cnt_connecting is to indicate if we are connecting to an AP.
> This is an important clue for coexistence to assign more time slot to WiFi
> side in this situation to ensure WiFi can establish connection.
> 
> Without this patch, compiler warns:
>   drivers/net/wireless/realtek/rtw89/coex.c:3244:25: warning: variable
>     'cnt_connecting' set but not used [-Wunused-but-set-variable]
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

bc012b16c15f wifi: rtw89: coex: show connecting state in debug message

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220912021009.6011-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

