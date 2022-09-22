Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3108C5E5B22
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Sep 2022 08:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIVGMR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Sep 2022 02:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIVGMQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Sep 2022 02:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3404B5144
        for <linux-wireless@vger.kernel.org>; Wed, 21 Sep 2022 23:12:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B63962E14
        for <linux-wireless@vger.kernel.org>; Thu, 22 Sep 2022 06:12:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41ABC433D7;
        Thu, 22 Sep 2022 06:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663827134;
        bh=p4OyljZQu2vPynXUtIr2aKE0SOvSbzx/616SkSukEg0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jU9skZVP6SukKU7Uh2L9IK2sggTP5wxTLFRPnqa+zYJnVo3a+kNyDHYloi1E+2HBa
         USQCWChEEhj4JzVAR/c5kMa5ArQlzEackvUKfGe8KQoY4xnB5buEB59QSP7lZoebYv
         O6Ze+O4v0RCqnfcdhjgmJbpso5Oprzx+WQdWwDumvaiZmIO/JH+oZMN3pTajFKiIBU
         hp1VyhXYsgoq1+oGwzSLd/X+zcjEMWg/nMIOHKXLg3u7OfVEHw5jlgMXUOD1gWKwXL
         7CX45JlwhiE0rW7tifvs+WpofaAjguonsMEdUgvXNw1O15w65Kt6cdu3WZEMIIZbYw
         M1ou2/Tsz+jAg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] wifi: rtw89: coex: add v1 cycle report to parsing
 Bluetooth A2DP status
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220920010939.12173-2-pkshih@realtek.com>
References: <20220920010939.12173-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166382713202.9021.18413293426950339691.kvalo@kernel.org>
Date:   Thu, 22 Sep 2022 06:12:13 +0000 (UTC)
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
> 'cysta' is short for statistics for cycles. That is a circular buffer to
> record snapshot status including beacon count, RX count, TX count etc.
> Since 8852CE Wi-Fi firmware report this statistics in different format,
> add v1 parser by this patch.
> 
> Signed-off-by: Ching-Te Ku <ku920601@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

0d7b3a83c034 wifi: rtw89: coex: add v1 cycle report to parsing Bluetooth A2DP status
7d42efcaea21 wifi: rtw89: coex: translate slot ID to readable name
3f386573d490 wifi: rtw89: coex: add v1 summary info to parse the traffic status from firmware
b696d42205db wifi: rtw89: coex: add v1 Wi-Fi firmware steps report
4e924c8b8ca8 wifi: rtw89: coex: add WL_S0 hardware TX/RX mask to allow WL_S0 TX/RX during GNT_BT
f2fe93b387cf wifi: rtw89: coex: modify LNA2 setting to avoid BT destroyed Wi-Fi aggregation
ba297a2556c5 wifi: rtw89: coex: summarize Wi-Fi to BT scoreboard and inform BT one time a cycle
4d5468c63f35 wifi: rtw89: coex: add logic to control BT scan priority
2e405cff04ec wifi: rtw89: coex: update coexistence to 6.3.0

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220920010939.12173-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

