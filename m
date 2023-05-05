Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625FF6F826E
	for <lists+linux-wireless@lfdr.de>; Fri,  5 May 2023 14:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjEEMBV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 May 2023 08:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjEEMBU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 May 2023 08:01:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6031A627
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 05:01:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC51563D8D
        for <linux-wireless@vger.kernel.org>; Fri,  5 May 2023 12:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC4A2C433D2;
        Fri,  5 May 2023 12:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683288077;
        bh=chzuA/J8hMY0kdlp7X2Sug5itdlXc5dTgDT3fwotc4M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FMbsodsXeKrLUsJL4x4mnUDbv65EdJXpvpRzLQuPPF0DrOu4nDsZ9pky1oq5fv2rd
         zpj5D89jCuBWC+dHhq//uXG8Ksto3Y/Kcm1wHzA6au5nMqo/2LbTCWSe5LZoWnG/w8
         oyO2ArHksv9HdVB1pgDdj2RN2arSv49llNf9oBhAf71bI4rKeGR+MK7R3yAJM8WQSO
         Ow2cUHqITJwoe4qm5kMxCnvwydiMifnNljF1I7xmBtgb+B9k5MyI1MAbfjKMGqvVoi
         7knYr3kViRK0gfxK31deFRdsi9+wYPlEG6/giR2ju5Y4W+khgCVt6aYAnVMY3WGlEF
         szBvHThV74YBg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: 8851b: add set_channel_rf()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230424065242.17477-2-pkshih@realtek.com>
References: <20230424065242.17477-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168328807497.30117.9322865317001714468.kvalo@kernel.org>
Date:   Fri,  5 May 2023 12:01:16 +0000 (UTC)
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Add to set RF registers according to the channel we want to switch. The
> callers will be added afterward.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

2a59fe291fb3 wifi: rtw89: 8851b: add set_channel_rf()
27d5559fd169 wifi: rtw89: 8851b: rfk: add AACK
ae546f0a2390 wifi: rtw89: 8851b: rfk: add RCK
93fbbeedca3b wifi: rtw89: 8851b: rfk: add DACK
a83c6bb22745 wifi: rtw89: 8851b: rfk: add IQK

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230424065242.17477-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

