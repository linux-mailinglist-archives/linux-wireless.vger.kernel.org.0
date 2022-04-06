Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B504F5DB6
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiDFMJV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiDFMIi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:08:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF0507161
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:50:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94D26B82143
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B5CC385A1;
        Wed,  6 Apr 2022 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231411;
        bh=0E/7t0sS1sIpwq6V6YyyrgTdvVHWHCY7Ew1NaNN8tuw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=jgQ1REf+44hz231EpsTU1iT5z/F6C2F7szhm1GCfsZzBvRv4PCDJH8iiX7Ux41Ugu
         pY77aSz9eTkclXIX8bMqKam7OQ/pawk4R3yUSsap788TSizmaffSNvqUKfCggtMIBy
         ySqqQWnPKp94Bel7P9Y3AeXkhWZvP7j9dU+NrZ5e36fzBaoHWH9FesXQflUelw7hB1
         xlB85bBnvatpfzcmpZMjY5QK7oRlxs4G1+3ChVG8pe+cOtUiTw57SG2Sk0CV7hdJVQ
         wAdQdN3LAuLxXQZ7YlfrhyLsQyphUI/4wnHij3cg3eVuIP3QP335SbfvUE3ORBMpKp
         bzk/DioYiY/fQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw89: handle potential uninitialized variable
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220318035202.42437-1-pkshih@realtek.com>
References: <20220318035202.42437-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923140870.18336.8772283628956197308.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:50:10 +0000 (UTC)
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

> The smatch reports:
>  rtw8852a.c:1857 rtw8852a_btc_set_wl_txpwr_ctrl() error: uninitialized symbol '_cur'.
>  rtw8852a.c:1858 rtw8852a_btc_set_wl_txpwr_ctrl() error: uninitialized symbol '_cur'.
> 
> This is because rtw89_mac_txpwr_read32() can possibly return before setting
> argument _cur, and the caller will use the uninitialized value. To fix this
> problem, check the return value of rtw89_mac_txpwr_read32().
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

26bb93407c74 rtw89: handle potential uninitialized variable

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220318035202.42437-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

