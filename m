Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065EC4D2E3E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Mar 2022 12:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbiCILkn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Mar 2022 06:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiCILkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Mar 2022 06:40:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1A74F9F7
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 03:39:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD39EB820D3
        for <linux-wireless@vger.kernel.org>; Wed,  9 Mar 2022 11:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B409BC340EE;
        Wed,  9 Mar 2022 11:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646825981;
        bh=E7kCJxHEQ0jKdtKILB5xMRVSSYOizh+iyLS2i16fYjc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tdTCzQ/dDR9uFC1hxK56gKipQngn03Ybcf1PSk2sZpxnCb9ejflDoOqtOAc0IDesV
         7ifleN8eYJB515WihBx9U+kzwKEhqCC6p0vkKEJ1cux0bSiD3VaYL0pmnQTKI8fOp4
         XEBWA76d2Q1BE5EC2flSlEG5ZaP3Ca5WqKptrw3yJmSwgp264DKKyP0pusvlgEDalv
         cGRkDwlFFcKcDMWPEnfmr4kL1Bp/l7RAKH+b99DaUfdokvoJZeErfckRtZTejcy2up
         +gRQAT7xOcQICiFnuJicT8g6yllfnddtEVXykHXUqsL1XR11cUq1VG37HIy3JVMbli
         0uLOlx/lfWjdw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] rtw89: fix HE PHY bandwidth capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220301004331.6621-1-pkshih@realtek.com>
References: <20220301004331.6621-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <johannes.berg@intel.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164682597848.8809.16847267741686269518.kvalo@kernel.org>
Date:   Wed,  9 Mar 2022 11:39:40 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> Bit 2 and 3 are reserved on 5/6 GHz and bit 1 is reserved on 2.4 GHz,
> so the driver should only set the non-reserved bits according
> to band.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

517eed92bca2 rtw89: fix HE PHY bandwidth capability

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220301004331.6621-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

