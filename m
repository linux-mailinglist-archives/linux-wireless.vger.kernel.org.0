Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5E614695
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 10:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKAJ0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 05:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKAJ0E (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 05:26:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26432183A7
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 02:26:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D803CE1939
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 09:26:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5D6C433D7;
        Tue,  1 Nov 2022 09:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667294758;
        bh=piDfUYcTSPFG+8NXoxpzPe2VMFyn71wc8s1HndhnTrQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=aMeRUVwortMMkqP3xgA7zfddYbJiLu3ljO3fFMgixmKdYZVDIZ1Gi6pJQSdPT6BqM
         446zdiXh1sw3RTPosy4yXB1WPs5BRX6Dbq7SoC1wnYOe8P15bsPYo0MqxKKVkFM7ah
         v3QzrsaPGCxVbfwaobtlYHKQtHfdXuPte9TlCXbDdBcqsaSbdn2oS0irLDPwvcHWQf
         sCJYx9ASVC7mSn+epykuLzIByz3mqymmFqOZmw9LWAH4KUGo/FI9BbJmz37I+0biIX
         5nTHhAcYf5ZP6LWylJpSabL+ud9g4p1MlgDfZv0i0WXhV/GV0VairsMp28m9cdsvzg
         QATMf+/eO2vgg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw89: check if sta's mac_id is valid under AP/TDLS
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221021091828.40157-1-pkshih@realtek.com>
References: <20221021091828.40157-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166729475593.21401.11061116132311676756.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 09:25:57 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Add boundary check of mac_id when adding sta under AP/TDLS.
> And, return -ENOSPC if the acquired mac_id is invalid.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

46245bc42aff wifi: rtw89: check if sta's mac_id is valid under AP/TDLS

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221021091828.40157-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

