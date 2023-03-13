Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AC96B794C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 14:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjCMNpW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjCMNpV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 09:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B96515E2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 06:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C9EB612AE
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 13:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CEBC433EF;
        Mon, 13 Mar 2023 13:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678715119;
        bh=H/b31PTJUlK2Z4es9wUwki2xdkVTZ8M8bsIyPIlO7yI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fSto2SuMRVPPFnmnjkmv57iz0aT96Q1ebIz4yqTyqWst6jtjFpuc7WBaXBkwDCb9G
         OkMV2C2xecxZyUCR9qg8EBKrYTMhZVOeRIq+oSUHrdmuX6gci9BRENUkUT1+v2up6d
         IqlWSymqgEOPLZt6+MyFWAau1G6z0nA+7Cfab7upMsDHYbsiHq+eEHOEP+YUp6xksD
         A6mJz2Iw6JmCHeJGuK7MNZ5cO9OMYjMs+lqn2OPwVDyOzQbtinI1FDAoe+v+VZkXHk
         KpzJcLVFj7wZg4WOOyoH4yWzCexETEUsq9r5PsvVyMzMn/TdBM2Sozp9WMCNo/HWGu
         hsd5acg/pOPHw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: coex: Add more error_map and counter to
 log
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230308053225.24377-2-pkshih@realtek.com>
References: <20230308053225.24377-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167871511733.31347.4238112993069903081.kvalo@kernel.org>
Date:   Mon, 13 Mar 2023 13:45:18 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ching-Te Ku <ku920601@realtek.com>
> 
> The error map and counter can help to analyze is coexistence mechanism
> going well or not. For example, if there is E2G (External control Wi-Fi
> slot for Wi-Fi 2.4 GHz) hang counter, it means Wi-Fi firmware didn't cut
> a slot for Wi-Fi 2.4 GHz. Maybe something wrong with firmware timer.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

e49bdd85c92d wifi: rtw89: coex: Add more error_map and counter to log
5049964c4af8 wifi: rtw89: coex: Add WiFi role info v2
a2c0ce5d01a2 wifi: rtw89: coex: Add traffic TX/RX info and its H2C
e5e52feb5053 wifi: rtw89: coex: Add register monitor report v2 format
9dfa09e0628d wifi: rtw89: coex: Fix wrong structure assignment at null data report
262cc19ea902 wifi: rtw89: coex: Add v2 Bluetooth scan info
3ab7f9b90cc0 wifi: rtw89: coex: Add v5 firmware cycle status report

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230308053225.24377-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

