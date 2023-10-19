Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3B77CF13E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Oct 2023 09:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232942AbjJSH3W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Oct 2023 03:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSH3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Oct 2023 03:29:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74119F
        for <linux-wireless@vger.kernel.org>; Thu, 19 Oct 2023 00:29:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68735C433C8;
        Thu, 19 Oct 2023 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697700559;
        bh=qAoAaESRcjikE5bppwq+sScr2PifU5y8kl8IbYKo1k4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ekgTsV0hGHWvfYz5r6kXRzKr1jSGVVNPBqG+Ee44QTVEMwstvYZptLACk0OGuUWp6
         DvAh0GVlGilfmI094BP3QPwRYrUNW/vwABkOos1LBXaecK7CP1jGYkEIiBMEOCqVTz
         HT5F1959oogEk7Hie+NRedlczxWVl4uJpopFoDfAz7g+2NX4uAZJpzKk6kCq7i/q7U
         +/9trEne7GYWJK0QanBHF6VzvxRPFaAQ8XXUjk7YEkptEVjaW8S+8AjwFxEmKkOBki
         07yQtlFZiH3KfCBk4tljdiB01w/o+uA+iwCzqkQvLLgRgaWBfyJCyV8A+5v9T+HtqM
         cgU1emhObPdhg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wifi: rtw89: phy: change naming related BT
 coexistence
 functions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231016065115.751662-2-pkshih@realtek.com>
References: <20231016065115.751662-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <cj.hsieh@realtek.com>, <hsuan8331@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169770055655.117236.17763530923752037470.kvalo@kernel.org>
Date:   Thu, 19 Oct 2023 07:29:18 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chung-Hsuan Hung <hsuan8331@realtek.com>
> 
> Change naming to disambiguate the functions because their names are common
> and not clear about the purpose. Not change logic at all.
> 
> These functions are to control baseband AGC while BT coexists with WiFi.
> Among these functions, ctrl_btg_bt_rx is used to control AGC related
> settings, which is affected by BT RX, while BT shares the same path
> with wifi; ctrl_nbtg_bt_tx is used to control AGC settings under
> non-shared path condition, which is affected by BT TX.
> 
> Signed-off-by: Chung-Hsuan Hung <hsuan8331@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

2901bbd26668 wifi: rtw89: phy: change naming related BT coexistence functions
4ba17aa476e2 wifi: rtw89: phy: generalize valid bit of BSS color
5d2f3c3aaaa6 wifi: rtw89: modify the register setting and the flow of CFO tracking
aecc60e7d3ab wifi: rtw89: correct the DCFO tracking flow to improve CFO compensation
388df37938da wifi: rtw89: move software DCFO compensation setting to proper position

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231016065115.751662-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

