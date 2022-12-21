Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2E865369A
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Dec 2022 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiLUSuG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Dec 2022 13:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbiLUSuF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Dec 2022 13:50:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007D31EC4A
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 10:50:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B3274B81BE3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Dec 2022 18:50:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F74C433D2;
        Wed, 21 Dec 2022 18:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671648601;
        bh=n02ugOPJOwZGw8+6diAS6a/S9SaUsjNR80kwvgDfc9M=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=VFrf6zdGvizGYudgJwnXGSd9WXdYSw8CGn4T9lwkKxKklBZxFGsT8aYFC31DXe/dO
         +8B4TM0ZWfrUE6vZfpKsvuSEFFYfWAwexzwCz5DkiI1wPUL7hQlT3Z3/SacnEgtvNJ
         jMqtPYrwdKFBwbfPIxZIzJ8lNT8RLy2Pg8ASijj8mIBNNi3pAP1BZZYGCZNvqdHlYq
         uSRX6B8avwPF9INDOMAlFPwWXdg/u7CLYNRcZljRezVIByAqP6TDWSx3FnUu8xF2x5
         Da6SmP7+EVDR21vP6K/zjqpnsAne+YtIrLIdXAYk6MlwdB0Bbhkx7/3DM2s2a0juzq
         MridMdnpgLx0A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: coex: add BTC format version derived
 from
 firmware version
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221217141745.43291-2-pkshih@realtek.com>
References: <20221217141745.43291-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <ku920601@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167164859882.5196.234923464798303383.kvalo@kernel.org>
Date:   Wed, 21 Dec 2022 18:50:00 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> Originally, each chip maintains its own format version followed firmware
> it uses. As new chip is added, firmware changes format of exchange
> messages to have rich information to handle more conditions.
> 
> When old chip is going to upgrade firmware, it could use new format and
> driver needs to maintain compatibility with old firmware. So, add this
> version array to achieve this goal.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

6140635a73c0 wifi: rtw89: coex: add BTC format version derived from firmware version
1fc4a874ff02 wifi: rtw89: coex: use new introduction BTC version format
bc20f9235f64 wifi: rtw89: coex: Enable Bluetooth report when show debug info
52c7c983174c wifi: rtw89: coex: Update BTC firmware report bitmap definition
0cdfcfce85b6 wifi: rtw89: coex: Add v2 BT AFH report and related variable
31f12cff9d26 wifi: rtw89: coex: refactor _chk_btc_report() to extend more features
e0097ac51e84 wifi: rtw89: coex: Change TDMA related logic to version separate

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221217141745.43291-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

