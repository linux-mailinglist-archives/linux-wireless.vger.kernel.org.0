Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09DEE622453
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Nov 2022 08:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKIHBo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Nov 2022 02:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiKIHBk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Nov 2022 02:01:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808FEDEA8
        for <linux-wireless@vger.kernel.org>; Tue,  8 Nov 2022 23:01:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E73C618B9
        for <linux-wireless@vger.kernel.org>; Wed,  9 Nov 2022 07:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3526C433D6;
        Wed,  9 Nov 2022 07:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667977296;
        bh=mbt4qQIiBat3VM8OKLuk9CKy7kUH3YnKOyW8DIrK9vk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=rKHKkaPwothskP23YQ4L9PzaS9vBjU4ScWIR8uDP18eAqR4vRJrx7FnzbfauzzqHj
         XdEwewvzkm/AV11DmhfSuOIp4M22jKut8xnXDgDXRx61Y7rR5CwjOpyQvVvppYjYDd
         u9kWMzwVMPg2YeiYDH1IGpmOcWzCskDousbKPqn8k82M/AOUk38FiRglaZSGyYwVtd
         wdnn8GXcwUTP9pUsEXi6p1WLsPPJluayOqz4NYZitT3/H36ms7QaRzAAxkQkRA89U7
         RTlVdY7OvG1MURiInJTS+tdoUDVqI+KQ/TSZhyF3tG77BT3yscTtHeEluRHhIs08qU
         TwKvVMmINZrNw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rtw89: 8852b: change debug mask of message of no
 TX
 resource
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221108014230.11068-1-pkshih@realtek.com>
References: <20221108014230.11068-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166797729378.32472.5552624732638416348.kvalo@kernel.org>
Date:   Wed,  9 Nov 2022 07:01:35 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> 8852B has smaller TX FIFO than others in WiFi chip, so it would be buffer
> full frequently, but it doesn't affect TX performance. However, it shows
> verbose debug messages with RTW89_DBG_UNEXP mask that is used to indicate
> abnormal behavior, so change debug mask to RTW89_DBG_TXRX for 8852B.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

Patch applied to wireless-next.git, thanks.

901c247f9687 wifi: rtw89: 8852b: change debug mask of message of no TX resource

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221108014230.11068-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

