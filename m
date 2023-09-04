Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A04F791C11
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Sep 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350719AbjIDReW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Sep 2023 13:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353363AbjIDReU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Sep 2023 13:34:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADF0E42
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 10:34:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 109B9CE0F2C
        for <linux-wireless@vger.kernel.org>; Mon,  4 Sep 2023 17:34:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 916C1C433C7;
        Mon,  4 Sep 2023 17:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693848853;
        bh=6Od0oTEyH0wHU6wqZ4vkkaEQcrXv0eqxfPxcq7zQQUk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=NrFdHU+25zpI8cl6IwL2WbshP5CLYjz1ftZF5urjc+HO9UsBqnlwtfJt1EIGh2Kiw
         renQHxelCJ+APiRK2/YBiinxxEelLWs4pssSowQ//PY4yJCBCk40rYBQ09iLfSpOkY
         M1Q54u9uniDHI8Ud3I4d8yoEHSFXw57JyPhAevM1FOP66o+FC+47nHrhMDSNbLotU1
         O1OnH5utA/coaIuYaFtx7I3ugD2zhxAEuczy0+psOuLImfJkzG77g568jabnMu2Wfs
         CAV4NKF6qMQ9LpnJL39g296rRmyzcnjCoDxC0jtomObqr9djlBW77yC/iesyrDc1qj
         ULWaw2zZaBVpg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: rtw89: 8852c: Update bandedge parameters for
 better
 performance
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230830092849.153251-2-pkshih@realtek.com>
References: <20230830092849.153251-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <damon.chen@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169384885074.3484948.5218000101306762440.kvalo@kernel.org>
Date:   Mon,  4 Sep 2023 17:34:12 +0000 (UTC)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Kuan-Chung Chen <damon.chen@realtek.com>
> 
> TSSI configures bandedge to TX proper waveform, these new bandedge
> parameters improve the accuracy of transmit power compensation.
> This helps to avoid throughput degradation.
> 
> Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-next.git, thanks.

8f969ba1de42 wifi: rtw89: 8852c: Update bandedge parameters for better performance
dae446493902 wifi: rtw89: 8852c: Fix TSSI causes transmit power inaccuracy

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230830092849.153251-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

