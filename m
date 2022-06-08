Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772015429F3
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jun 2022 10:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiFHIxk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jun 2022 04:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiFHIws (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32A82A1D6C
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 01:11:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 659E6B81B34
        for <linux-wireless@vger.kernel.org>; Wed,  8 Jun 2022 08:11:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949C6C34116;
        Wed,  8 Jun 2022 08:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654675868;
        bh=yRUAw4QpAEMZhXXAU33UtTPfm/fafli/8z+ZeGOJqV0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tMfKFwScB/Yi27nYvtCbRdDYSfZzE/Y3OxMNmq1dGphyvRmFkOi8H/Mlnm6f9VEND
         M2ABtMR9hq08ZvkPkEmiTqXxCTx7nPOaPt3kY6ksg48DCPBQhbY+GVTbFMgiBXchMU
         bCZI5Gkc6ef8IZ1CLrxci8KNC1fzOCvXfDW9NZGYAHO3BY5Lv5A3ms3GXO5QvfClWN
         8S02A5qgPyGwupAQQH9d7ogaA761iqEXN2eKPtwTZOLv3BtcWGlyZSDHGyxfo93ylA
         C+3KuAhVtaHogpQkgZuNsg+XTz9dwsLpzjVGvWV1h8osJBdEzXIqjDVrCR9SOaye79
         7h9o8QykBVWbA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v2] wifi: rtw89: support MULTI_BSSID and correct BSSID mask of
 H2C
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220530112743.106857-1-pkshih@realtek.com>
References: <20220530112743.106857-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165467586536.10728.12490476035698474540.kvalo@kernel.org>
Date:   Wed,  8 Jun 2022 08:11:07 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The BSSID mask of H2C is used to match BSSID of receiving packets.
> Normally, we set six bits BSSID mask to exactly match BSSID of packets
> sent by target AP. After we support multiple BSSID, it could connect a
> nontransmitted BSSID, so we can only match first five bytes of BSSID.
> That means we could possibly receive other AP's packets if only the last
> byte of BSSID is different from target AP.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

85393ca610de wifi: rtw89: support MULTI_BSSID and correct BSSID mask of H2C

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220530112743.106857-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

