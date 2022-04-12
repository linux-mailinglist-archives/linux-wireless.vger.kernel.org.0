Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6034FE318
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356388AbiDLNz3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356350AbiDLNzY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:55:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A31A574B0
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 06:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F849B81E2F
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE3DC385A1;
        Tue, 12 Apr 2022 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649771583;
        bh=fie9O3IP4l4CmbJlsuBaESnC8kisYYm2VqqyHUJb0XA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=B2BankoT4PNC+YZh0YCNKiNLN4AGxWnFwmmmPjGAPSgM6KEYm19AO6FADV50V76hk
         qBSPvtyK0R2WNjjhnkjVVdrYVkwWGdYWIb+J5smyIDrmYbUYXcVymw5gWM4raDnFQJ
         VM//vqWWex8VOpfJ3y5Z6PbJe8yTwbN44qgQmy5WKiKAATRmWyPTDi+Bwqt3pH0xkG
         pMRvLhfGnFl6IQvtIq9rKzIa5fk6GxaRROGisLeXMf7p+8iBJGgl54j1pTu70AAWX0
         ZG1DcQ63RhYFTq5Nnmce4YaKatO9s5ZjAoiEigY2Xcfu0m0MmQ5Krh+jcPHF2Omfta
         icKDb3ZS3czLA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: 8821ce: add support for device ID 0xb821
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220407075123.420696-2-honyuenkwun@gmail.com>
References: <20220407075123.420696-2-honyuenkwun@gmail.com>
To:     Jimmy Hon <honyuenkwun@gmail.com>
Cc:     tony0620emma@gmail.com, linux-wireless@vger.kernel.org,
        Jimmy Hon <honyuenkwun@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164977158090.6629.1398098068246292684.kvalo@kernel.org>
Date:   Tue, 12 Apr 2022 13:53:02 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jimmy Hon <honyuenkwun@gmail.com> wrote:

> New device ID 0xb821 found on TP-Link T2E
> Tested it with c821 driver. 2.4GHz and 5GHz works.
> 
> PCI id:
> 05:00.0 Network controller: Realtek Semiconductor Co., Ltd. Device b821
>         Subsystem: Realtek Semiconductor Co., Ltd. Device b821
> 
> Signed-off-by: Jimmy Hon <honyuenkwun@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

d5286826201e rtw88: 8821ce: add support for device ID 0xb821
b9eb5f0742d1 rtw88: 8821ce: Disable PCIe ASPM L1 for 8821CE using chip ID

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220407075123.420696-2-honyuenkwun@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

