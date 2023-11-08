Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A04E7E5CF4
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Nov 2023 19:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjKHSMw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Nov 2023 13:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjKHSMv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Nov 2023 13:12:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC961FEB
        for <linux-wireless@vger.kernel.org>; Wed,  8 Nov 2023 10:12:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C1AC433C8;
        Wed,  8 Nov 2023 18:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699467168;
        bh=9JTHUK4ChCuoBYGY9C4vcn53TacLI8MSqCGHNTJBEn0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=X7Q9ODSg10D42M/psyugA+g/BaDEmsnmD9lx6tu1RRlPVtXrnbnQuIYK7fHjuvw5G
         FaoQuf3D8wTOVrmubruGlywNCLOylCBbbLAsnlwkjOFx8V0NcyGT30uSlY+V8/VOBI
         I362FZDzqkDt4iywRBHF4eIp4NKa9vgjNUWdsLMyAglLxNyq1ZTp5+YtYJ1vPadrQm
         kpia4vx9kCzJoXXM13gs/rdq8KpHLdO/qW9p+2jGPdu20dRvgUzeqnD5cf9XbDM7Bt
         arJER9ZwuErbwEnzHDumXD3Lbi7+17kBHxZUMLvJNPSaFKs/zjcnMDkMgNrUcaPEv+
         LNZSuP+E9ds3g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: simplify __rtw_tx_work()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231102115606.69838-1-dmantipov@yandex.ru>
References: <20231102115606.69838-1-dmantipov@yandex.ru>
To:     Dmitry Antipov <dmantipov@yandex.ru>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org,
        Dmitry Antipov <dmantipov@yandex.ru>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169946716617.2821494.8446673537914209958.kvalo@kernel.org>
Date:   Wed,  8 Nov 2023 18:12:47 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dmitry Antipov <dmantipov@yandex.ru> wrote:

> Since 'ieee80211_txq_get_depth()' allows NULL for 2nd and
> 3rd arguments, simplify '__rtw_tx_work()' by dropping unused
> 'byte_cnt'. Compile tested only.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

ed4f0c195e8f wifi: rtw88: simplify __rtw_tx_work()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231102115606.69838-1-dmantipov@yandex.ru/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

