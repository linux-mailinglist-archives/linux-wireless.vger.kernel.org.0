Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A94FE2D2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 15:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiDLNhX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 09:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232921AbiDLNhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 09:37:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A09A1CB35
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 06:35:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59D07B81D7A
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:35:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51ACC385A5;
        Tue, 12 Apr 2022 13:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649770503;
        bh=flebTVYRC7PF7Pn2mlVDLfZTNlOIqfWxE9rQwXd2yPg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VGNfja1gZ/H85OHdpPYsJTXVe0IlvxtFgWQtM+b/K+3GJtiiwJeRa8/WEKn+my3+U
         JzIjocAmoRZc5YvqYrQXr45ATt28pL50jIZRLu5fqaKvhxtqYLv23j3P/N8oUVedQE
         uFeV0YAI4EYTd/vxEeJ/h+t04K+6X6/9izWfAfQ/hz2+VlzQNYnpRgYffkbpX1BLl0
         uvYcblDuekYUTH2UjzYIhYEd0J9dNwudDmJFoWTj2gmDWeprSFdcT4GMXaQSlRoVpL
         O4bYxR9D6j8NmW0nRpRLKOrG0C6ZTnhohxeqbzXbcFfS65iTfTbuMeX+M4+XrcVBvi
         HOLSpjsyH0TRg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/13] rtw89: ser: fix unannotated fall-through
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220408001353.17188-2-pkshih@realtek.com>
References: <20220408001353.17188-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <leo.li@realtek.com>,
        <johnson.lin@realtek.com>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164977049978.31115.8928477805509989443.kvalo@kernel.org>
Date:   Tue, 12 Apr 2022 13:35:01 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> add `break` to fix warning of unannotated fall-through between switch
> labels.
> 
> Fixes: 14f9f4790048 ("rtw89: ser: control hci interrupts on/off by state")
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

9 patches applied to wireless-next.git, thanks.

5ddfffd6da9b rtw89: ser: fix unannotated fall-through
eeadcd2a47f8 rtw89: ser: configure D-MAC interrupt mask
d86369e937f1 rtw89: ser: configure C-MAC interrupt mask
9f405b0162ba rtw89: ser: configure top ERR IMR for firmware to recover
9a1ab283c709 rtw89: change station scheduler setting for hardware TX mode
181751970107 rtw89: reset BA CAM
ec356ffb2917 rtw89: 8852c: disable firmware watchdog if CPU disabled
d264edb1cc65 rtw89: Skip useless dig gain and igi related settings for 8852C
065cf8f9777f rtw89: 8852c: add 8852c specific BT-coexistence initial function

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220408001353.17188-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

