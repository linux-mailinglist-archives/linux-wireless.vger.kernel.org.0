Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFABB58D35A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Aug 2022 07:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbiHIFtU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Aug 2022 01:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiHIFtT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Aug 2022 01:49:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340EF1BEAD
        for <linux-wireless@vger.kernel.org>; Mon,  8 Aug 2022 22:49:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E03DFB81071
        for <linux-wireless@vger.kernel.org>; Tue,  9 Aug 2022 05:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD492C433D7;
        Tue,  9 Aug 2022 05:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660024156;
        bh=YZbzE4QZGBY1bg4/vl0o9pn44MR49HngIqo4D6P45ac=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=TcRxCJwPvK+4+mwCW+4zAOOOjDzXCV2o3ioAsJ9nLEbevBlbVK2e0aK5YNdgF2/A1
         GOGRQVQ11Er/NSaH1Ek/12ToxI5f5RLKBojZncAptRAfprtropIvBkWdpwJhxPvoXs
         lbnpdPxratd2D/ngdb6bm8jJA2ECaYmwQUc1Tn1j4lwo4DtfZlY+F1iNdf1TbH5of3
         KInfGKynR1bqYSOP9j/FEDqK3g5+cEgfesXEvUJRM4rtEYzLR+rSvVR+gH5Zrujky3
         FirUv2m60LtvE7p1GW/HqDIGCK9vVDEB2uSm5uXpQqjOOOfsPNXEFaEkJK7IHU/iye
         TJDIWUPkjJfbA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: rtw88: access chip_info by const pointer
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220727065232.28510-1-pkshih@realtek.com>
References: <20220727065232.28510-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166002415361.8958.8436030931461252861.kvalo@kernel.org>
Date:   Tue,  9 Aug 2022 05:49:15 +0000 (UTC)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Since chip_info has became const table, we must access them via const
> pointer to avoid invalid writing.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

dcbf179cbc18 wifi: rtw88: access chip_info by const pointer

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220727065232.28510-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

