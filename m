Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56E1C4F5D95
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 14:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbiDFMHA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 08:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbiDFMGx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 08:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2A52228C7
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 00:46:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B1D460AF8
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 07:46:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42718C385A5;
        Wed,  6 Apr 2022 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649231217;
        bh=8YLU6QINSg6DURvdBafkZYwejCAUeNa91QPTyCvoIo4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=UdrMh3OU7kEljINml0iuXdKAVKCf01yiJMyfMCHKkeM8BiZ/dZqcVUKcrgbd3zXwh
         xSryeqszbfqi9xJWLAyKrPylBWtLsqPgc+eAWFJSnSwdaLLnXo3PzkwmIRf63qePXx
         +nIrBsOA6qtRMeIOLVPdYyOSmFrSDFqNMBlh/qehQnq/xsy7jpuHIlmcVeudjJND3/
         MGrJYmvBVutL0oqpqlyu2DxpXHiMqxJ5wHrq4hmaxzmr+h2JioGeURk9ojhXDQarvi
         uhZdXKIZbCg9ITVGvSa2qFam2+YyR7t9ZnK0+uBvY749Il9gGy+XjQW/ZrZIbMgc0x
         EM9UQpsylt4lg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/8] rtw89: ser: fix CAM leaks occurring in L2 reset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220314071250.40292-2-pkshih@realtek.com>
References: <20220314071250.40292-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164923121407.18336.9671639816732399502.kvalo@kernel.org>
Date:   Wed,  6 Apr 2022 07:46:56 +0000 (UTC)
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
> The CAM, meaning address CAM and bssid CAM here, will get leaks during
> SER (system error recover) L2 reset process and ieee80211_restart_hw()
> which is called by L2 reset process eventually.
> 
> The normal flow would be like
> -> add interface (acquire 1)
> -> enter ips (release 1)
> -> leave ips (acquire 1)
> -> connection (occupy 1) <(A) 1 leak after L2 reset if non-sec connection>
> 
> The ieee80211_restart_hw() flow (under connection)
> -> ieee80211 reconfig
> -> add interface (acquire 1)
> -> leave ips (acquire 1)
> -> connection (occupy (A) + 2) <(B) 1 more leak>
> 
> Originally, CAM is released before HW restart only if connection is under
> security. Now, release CAM whatever connection it is to fix leak in (A).
> OTOH, check if CAM is already valid to avoid acquiring multiple times to
> fix (B).
> 
> Besides, if AP mode, release address CAM of all stations before HW restart.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

8 patches applied to wireless-next.git, thanks.

b169f877f001 rtw89: ser: fix CAM leaks occurring in L2 reset
e1400b115cac rtw89: mac: move table of mem base addr to common
198b6cf70146 rtw89: mac: correct decision on error status by scenario
14f9f4790048 rtw89: ser: control hci interrupts on/off by state
9f8004bfed03 rtw89: ser: dump memory for fw payload engine while L2 reset
f5e246846412 rtw89: ser: dump fw backtrace while L2 reset
11fe4ccda867 rtw89: reconstruct fw feature
edb896297abe rtw89: support FW crash simulation

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220314071250.40292-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

