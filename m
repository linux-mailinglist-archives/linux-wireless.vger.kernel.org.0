Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F952694DCE
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Feb 2023 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjBMRSi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Feb 2023 12:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjBMRSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Feb 2023 12:18:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE0E1A65B
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 09:18:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AAD3611F3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Feb 2023 17:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2DAC4339E;
        Mon, 13 Feb 2023 17:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676308716;
        bh=VJtnwq7nF8TMPtIVT+nmk4MsMm4nL/aRcLVegRqhfFU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=nZaNMrgipTvk0LnsLeoPkHTe4xcUnvSRCFxuJpaPwWH0srXASwkeFTnviSTKGUSUs
         aMWW9ePl5xgnKgBySwMkooseqNWs4DMAnaZyEcqh1jK9aF0Z7MrpLeBa3ErN/Gt3/g
         vpxgMqxlPRIH9HyUbpT2LvOQNedxOY9c8rEBkqHSDKhz/bJCMf7183wPmPMWVkhAro
         aV/eq+vW1b3/XvGK3obROhUlwI+fLpWe/doLIsUpvmWqWzJuSEUN0f4aaIbM/KUNfD
         5xwjJ5Qt48wxLsaHwNUC7CTtQ7tay63XeQFCFB3NNtdftdDerKYaiySmD4a/xAJtx3
         5hGQM24W4hrcg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: 8852be: enable CLKREQ of PCI capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230126112715.5811-1-pkshih@realtek.com>
References: <20230126112715.5811-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167630871309.12830.15912862527626712874.kvalo@kernel.org>
Date:   Mon, 13 Feb 2023 17:18:35 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> Enable CLKREQ to reduce power consumption for 8852BE.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

3712888e3dba wifi: rtw89: 8852be: enable CLKREQ of PCI capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230126112715.5811-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

