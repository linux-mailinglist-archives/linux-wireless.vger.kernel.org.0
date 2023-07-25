Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F3761C3D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jul 2023 16:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjGYOsX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Jul 2023 10:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjGYOsH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Jul 2023 10:48:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7E4E5A
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 07:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03FBB6177D
        for <linux-wireless@vger.kernel.org>; Tue, 25 Jul 2023 14:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C6C433C7;
        Tue, 25 Jul 2023 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296485;
        bh=8c29I4WRirJPbYWQZOfC5zhMVGj6oHQPQN4/HPWfkYg=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=MNCiDQnoQohf6X1vqfKgW2Spa38DaW6RTKiHp6cWgARuZOl4VWMGbtlK0X6TcX4E/
         T1AXfXy0C2UiHv66a7pCna6QdEATcHb7xE/yYQ2qs+M89nDVhY9M3MqmFUw6FnupP3
         +pQGHHY+93if4pXzoBDMCcr9lVB/8zipO0U6xMRDxhgGdO+77kSIHltsCHI9qJ6OyH
         0uLvOCbX5M+wxH53NwLrFYEJJ39MTcs0wuuuE7WOp+3LHYOOzod98JhcB+8ihVOF85
         US/tI7n5+3paX3gGPcPN3o6kLUnxrBmsP0u95f9FP/H2DogdMcowXZc81BpH4zrglB
         mg2jHbQWRCvAA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/4] wifi: rtl8xxxu: Enable AP mode for RTL8192FU
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
References: <ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com>
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Jes Sorensen <Jes.Sorensen@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169029648239.3309254.5027406529928176640.kvalo@kernel.org>
Date:   Tue, 25 Jul 2023 14:48:04 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:

> Theoretically this chip can handle 127 clients.
> 
> Tested only very briefly but it should work as well as the RTL8188FU.
> 
> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

4 patches applied to wireless-next.git, thanks.

efbc7e791a51 wifi: rtl8xxxu: Enable AP mode for RTL8192FU
dd71aca9a58b wifi: rtl8xxxu: Enable AP mode for RTL8710BU (RTL8188GU)
8c34b62167b4 wifi: rtl8xxxu: Enable AP mode for RTL8192EU
4831a80908f1 wifi: rtl8xxxu: Enable AP mode for RTL8723BU

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ffcabba5-7e9e-674c-ad03-73646b040b96@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

