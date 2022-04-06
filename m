Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EAB4F5ECC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 15:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiDFM47 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiDFM4r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:56:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D608E2BE96B
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 01:56:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64B54B81C86
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 08:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41F14C385A3;
        Wed,  6 Apr 2022 08:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649235409;
        bh=cmzkaTtZPv75jvqK+QyPiQ8fZ9U0t3x+vhWYz23IaYc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=iYJAcJLM8pOIZGUf/9Qbr31rX8//G8jWLV/fPOXnVODb2pZgjuJZDLs/Djw3q17UM
         ok4uEmzGoLWdQpM3hef6PsLEjvjHJnRaM/jJ6EjC67b+UrO1nlAAb9Awtu7z3QvB+F
         Fwmg0rlT1Mf7Zya381bfG9GjVsLf5Ba/eKrcxWz6JrHehbd6U2xBi9y+T527L9zufy
         YDERqA8pLQrmk66+DM/3kJ1Sxec+SS+BG0USsNUy6O1MMnc/dFmC32UyvJjDecqlQD
         OcbUlUbrryz11bQSGJAC9vqGA+j0CYpsB5TLK8FaAWX5JTbRbWIzk83D1DuPwmLHrB
         sRbOy++aJT5Jw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] rtw89: change idle mode condition during hw_scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220401055043.12512-2-pkshih@realtek.com>
References: <20220401055043.12512-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <ku920601@realtek.com>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923540619.20183.735405897151196118.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 08:56:48 +0000 (UTC)
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

> From: Po Hao Huang <phhuang@realtek.com>
> 
> Previously we only consider single interface's status, idle mode
> behavior could be unexpected when multiple interfaces is active.
> Change to enter/leave idle mode by mac80211's configuration state.
> 
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

ee20d538c498 rtw89: change idle mode condition during hw_scan
2b8219e9b746 rtw89: packet offload handler to avoid warning
841f2633840e rtw89: coex: Add case for scan offload
65ee4971a262 rtw89: fix misconfiguration on hw_scan channel time

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220401055043.12512-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

