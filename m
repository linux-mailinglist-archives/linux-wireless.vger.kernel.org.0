Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4F65B5982
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiILLnX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiILLnV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:43:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F0D3BC7E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:43:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D07ECB80D11
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:43:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BDEC433D6;
        Mon, 12 Sep 2022 11:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662982997;
        bh=t4GJB/EVu+vOuu3uT4F5JUpX6gRZemx9VdZ10JV+MjU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KAyUfBtDgev5tNf9aUhNVYhBOh4eWO/Ywd1dx9OnSowItk0l8s2isLSOisNzoVRJR
         Jo5A4a6917lqiS5deB0mJQN5OlFl56zJfWUKyRBxLthUbpaDG1HitLiEGq5RAogJos
         rxS8+iXHZEB0tRrQVIqcxd8+ooBI8yWuQcxIOmfUNDlU+jaf8X2fVzF+O44fwbZvIG
         6Tkq8HnE26+mdQVLX7Bc3nFI5PkGAeKxgXHdL1www1YYlQhyZ83ynPywndIuIVj81L
         Agn7LNfaH58XD+VHlTKYA8WDI52xP0tVvp7cRhvjbQpwuXEB6dh0i/uj+2xl/Xrtll
         jc6rv4PrDGV9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] wifi: rtw89: coex: Parsing Wi-Fi firmware TDMA slot
 steps
 from reports
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220905092539.51926-6-pkshih@realtek.com>
References: <20220905092539.51926-6-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298299440.4036.11589857120775115057.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:43:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> To parsing firmware TDMA slot steps from v1, v2 report.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

The commit log here also doesn't contain much info. For example, saying that
this is to support RTL8852A would be good.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220905092539.51926-6-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

