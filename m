Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829A05B59B9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiILL5r (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiILL5p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:57:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5666D19C00
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:57:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7B9B611D8
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:57:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDCEC433C1;
        Mon, 12 Sep 2022 11:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983863;
        bh=1JKmzLC3HhlmYXVuyu0eu+Mva9p4+Z6nSvcHFV3o7hw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=GLoZB/50anNi0lyaQy8fQrSdp6hXyk/qqeaoA1PWt+iCAeTH+uOi/qm1wM9A+LNeS
         UgOGWCKBrxutD0QaP+cXNSE3j82e0nR44Xc8bHa9zlY3Ts0w1cQQT5qo+RqZ2bk/8G
         C0KP/yRdfTMCt/SaKUX3cUoJiDeL7w8V+7byHvrRMpg+vR3HSdLzzpMyZ6z4AKfHIl
         rTy9AdVH/RZOsWQVXTk89SuQ+GKAV/fUy8i0MvvXaLiIN9GtHt08MvepVo+BRkZW2R
         pYoEXQ1x9SNuCoYTwMBKkUgXiIY1Fvf7n9j70QoCfHE3KF2oi8UCzjGXNaDt/0JdgF
         49UM/Q1kkWoEg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtl8xxxu: gen2: Fix mistake in path B IQ
 calibration
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <30a59f3a-cfa9-8379-7af0-78a8f4c77cfd@gmail.com>
References: <30a59f3a-cfa9-8379-7af0-78a8f4c77cfd@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     linux-wireless@vger.kernel.org, Jes.Sorensen@gmail.com
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298385989.4036.3324300344127875366.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:57:42 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Found by comparing with the vendor driver. Currently this affects
> only the RTL8192EU, which is the only gen2 chip with 2 TX paths
> supported by this driver. It's unclear what kind of effect the
> mistake had in practice, since I don't have any RTL8192EU devices
> to test it.
> 
> Fixes: e1547c535ede ("rtl8xxxu: First stab at adding IQK calibration for 8723bu parts")
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>

Patch applied to wireless-next.git, thanks.

e963a19c64ac wifi: rtl8xxxu: gen2: Fix mistake in path B IQ calibration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/30a59f3a-cfa9-8379-7af0-78a8f4c77cfd@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

