Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9CA782DF8
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Aug 2023 18:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjHUQMW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Aug 2023 12:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236220AbjHUQMT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Aug 2023 12:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C974A18C
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 09:11:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D5CE60D39
        for <linux-wireless@vger.kernel.org>; Mon, 21 Aug 2023 16:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17889C433C8;
        Mon, 21 Aug 2023 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692634315;
        bh=NzbE4GfBLJJ9FmAUckhGDJ12XT2tWQxDYuLZ2gsbEg0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=KgoIhPykRaoXZOPiQVGpdXnWsXGTQ+wLZC5B1p20OohQt1pEdPW2GgmzMFPYWbhQB
         JsPWa0TSoqU+zBo7tOvVPpWOY+tJd/2hOu3Lyo9YU8v78VthaC8UVBs0g24ZTpykFZ
         ER9xPWgl8G+zT23Bz67VLrLz9tOlVNn1L0MNQbzXZUkSbRameXZ3yHh3e835UONe0v
         dHWcJ6Ux5Akwt6VYhJRfn58XMmM2iN3W8Ujcc1FpbDUymfcceHPy/eM9C2GsdHyUH+
         GC0Hwq6D64cCpH0AK51NyCr6SIPdax5WfbnInB+RRNsNZA0O4rQ7PT6TV6ojcjoPhM
         P1mwUxB1R4TNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: Introduce Time Averaged SAR (TAS) feature
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230804053458.31492-1-pkshih@realtek.com>
References: <20230804053458.31492-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169263431307.572263.5654808387221005476.kvalo@kernel.org>
Date:   Mon, 21 Aug 2023 16:11:54 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> Time Averaged SAR (TAS) tracks the amount of transmit power over a
> period of time and adjusts the power accordingly. Two thresholds are
> used to determine when to increase or reduce transmit power: Dynamic
> Power Reduction (DPR) on/off. Compared to Static SAR, which has a
> constant transmit power, TAS can improve the user experience or
> range extension.
> 
> TAS can be enabled through BIOS, and the driver will evaluate
> Realtek ACPI DSM with RTW89_ACPI_DSM_FUNC_TAS_EN to determine
> whether TAS should be enabled.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

eb2624f55ad1 wifi: rtw89: Introduce Time Averaged SAR (TAS) feature

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230804053458.31492-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

