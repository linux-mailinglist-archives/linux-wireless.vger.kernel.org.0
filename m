Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2201C5FB87B
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Oct 2022 18:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJKQqc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKQqZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 12:46:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E02A5732
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 09:46:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0888B8162D
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 16:46:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72CFC433C1;
        Tue, 11 Oct 2022 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665506777;
        bh=SvKyq+1YoTL0x74PzK/DyxLuNqLhBCHysixaHrKLEpU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YCL8SeOTxBCLkSHbWjxo/tpDTb+1cpOM1IJ8xLN5sh73yG/QHpb4yCHqoV1C9+qot
         b/w3Cx3fouiVAArIFM66rHuas/OJ3iv3CEVoCeeaOB3jHFLIH/WpErCcMnYSpZVOLM
         GSLgiDAIpseKURjAvAwfpiKCn5sObXu0zn/sq81XgA++epiRHRXU9aPE7b+ywEfMxT
         FTT69m+ThPJTvhLVef4D5RoDhWd/7AJU4ijXTFDBxliI0NMqU0ZoywB5xazPs6rPRt
         PXHwgxq5V3l2yt5wZiZJC4uo+PAimn3H98jDCO6IRISagh1elspD7u5tQhki0H9NdO
         NhhTaPBz0RzPQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: correct 6 GHz scan behavior
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221007045900.10823-1-pkshih@realtek.com>
References: <20221007045900.10823-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <phhuang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166550677471.12241.12467602625666531364.kvalo@kernel.org>
Date:   Tue, 11 Oct 2022 16:46:16 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Change active scan behavior to fit 6GHz requirements. There are many
> different rules on active scan between 6GHz and 2GHz/5GHz, so if the
> SSID is not specified, do fast passive scanning and limit number of
> probe requests we send for now until new firmware can support all
> rules.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

54997c24767b wifi: rtw89: correct 6 GHz scan behavior
478132050360 wifi: rtw89: fix wrong bandwidth settings after scan

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221007045900.10823-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

