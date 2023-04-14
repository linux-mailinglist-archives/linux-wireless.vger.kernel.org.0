Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC85A6E233F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDNM3C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDNM3B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:29:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB99B74A
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:28:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD52264781
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:28:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B378C4339B;
        Fri, 14 Apr 2023 12:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681475324;
        bh=dTFHbg56+aEohIJzqUqE8MLs/hioYYV9w2Q+GeeCkH4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=e4R22u89bXf5DTn08WQdix+20vk+kNjZ5kBavrU9jZJNRGTjscLRIr7yYNuVbkE4i
         n9zEuUuCJA/Nxy9WY1GF93V8/CXGguaZB3m3q6axsvMkKrH/zKORpCnCwSH/0/1U5q
         LxUTiW6AhFv952SxzQpgqKMD01Jsn5OgTx10x4kpCFT7FUQ0Pf3cMUdqxu0n2lnqsr
         mGfCY6WmksBDSDaZ/M25n+scospT0m/ovg2GmDilNGGgHfQqhDeEqqsNWtdr0nkgfB
         X3iviDz5dyH6W8hhlTuxsJwh7IZNWZ/MPaDBVo+FzGlt7NNLUb0P82NaeCgbf+EbRT
         +2V4RcDGPwDgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: wilc1000: fix for absent RSN capabilities WFA
 testcase
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230405173555.6041-1-amisha.patel@microchip.com>
References: <20230405173555.6041-1-amisha.patel@microchip.com>
To:     <Amisha.Patel@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Ajay.Kathat@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Amisha.Patel@microchip.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147531839.16522.15801459237923800344.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:28:42 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Amisha.Patel@microchip.com> wrote:

> Enable the RSN flag to pass cipher suite and AMK information, even when
> RSN capabilities field not present (as it's optional).
> 
> Fixes: cd21d99e595e ("wifi: wilc1000: validate pairwise and authentication suite offsets")
> Signed-off-by: Amisha Patel <amisha.patel@microchip.com>

The commit log should always answer to "Why?". What issue does this fix?

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230405173555.6041-1-amisha.patel@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

