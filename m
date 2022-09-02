Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06DB5AAA34
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Sep 2022 10:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbiIBIhc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Sep 2022 04:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiIBIhR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Sep 2022 04:37:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B0826578
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 01:36:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB2D262118
        for <linux-wireless@vger.kernel.org>; Fri,  2 Sep 2022 08:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA30C433D7;
        Fri,  2 Sep 2022 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662107800;
        bh=54A1K3lNwLyv+9PNmZt2qejZqcurgr+OM50CA+H5Lgo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VaP3rcoDzxv8xfnBU1g1zrS+CZc3JgDHXcj9r6B7vin5NmDPdgwmt89lCPn65tQJe
         OhSjmixUEJdYAHjaQ4xHyI95rhqf3VWUUr6nAPdk1K0SYeWer1tX/Tv2eXgmWI6FlN
         DPcUkh3UoyIxwuc90XiUNQ6hpzJheE3Z66EP0/Eys0GSt/TMzC+RYFys7bq9yCPKIf
         UOhK7vqKubTa3B37mmqnUvOzK1Enh86wRBRXVWy8vro5QNHqcHOYFf6RQEdLEndDhN
         BZg2sXPTTuXk6CZwWxfZ/XIqI653HjYTvRTBhOdZn7P3+C1QGeXEK0yINZ+Zl1qyF0
         P8zNpSp+7qI9g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: enlarge the CFO tracking boundary
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220824061425.13764-1-pkshih@realtek.com>
References: <20220824061425.13764-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166210779790.24345.8836422672854772474.kvalo@kernel.org>
Date:   Fri,  2 Sep 2022 08:36:39 +0000 (UTC)
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

> From: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
> 
> The calibration value of XTAL offset may be too large in some wifi
> modules, that the CFO tracking mechanism under the existing tracking
> boundary can not adjust the CFO to the tolerable range. So we enlarge it.
> 
> Signed-off-by: Cheng-Chieh Hsieh <cj.hsieh@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

9bea5761750c wifi: rtw89: enlarge the CFO tracking boundary

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220824061425.13764-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

