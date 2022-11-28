Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA0263AA41
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 14:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbiK1N7G (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 08:59:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiK1N7D (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 08:59:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF8CDA4
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 05:59:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D310CB80DBF
        for <linux-wireless@vger.kernel.org>; Mon, 28 Nov 2022 13:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D52C433C1;
        Mon, 28 Nov 2022 13:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669643940;
        bh=QMkvviKD3gsVJI4hfNMMNMhDR/UdQTDhv1GhtdjTd8I=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=e1CbmSuU4CTeAk/WnreA0ZUQiS/2m6Equ4p1yAqKzFDE4rUNZDj0juH9AFG8yBkWf
         tyW8O41Sjshmx4dQwlQJKx7Qbvm+jd3PUqApNhzdHOl7/eFdeOzMCjIcE5FKN9l0lu
         Dhq5rW1RKCB7rQZXFTkNWGR/mVsFKL0Q9QStxjrMgMUZMshNQIfgoaUClc83KJZk8u
         X5BvPmVcogeeEiqAZcTUX+eiAbyywnh0CV1Hd/bOUsglh1whYpn9VsphxapVjWvhD7
         4NRCk4EoiBjUenwh+EbYL5KAFVY0s9eFz1VMVNs8nWhMPiF5ireRnsBm0E9gnubIYD
         pzmueRJguMCPw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: rtw88: fix race condition when doing H2C command
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221124064442.28042-1-pkshih@realtek.com>
References: <20221124064442.28042-1-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <neo_jou@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166964393792.4701.9928917528260013977.kvalo@kernel.org>
Date:   Mon, 28 Nov 2022 13:58:59 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Ji-Pin Jou <neo_jou@realtek.com>
> 
> For SDIO/USB interface, since the tranferring speed is slower than
> that in PCIE, it may have race condition when the driver sets down
> H2C command to the FW.
> 
> In the function rtw_fw_send_h2c_command, before the patch, box_reg
> is written first, then box_ex_reg is written. FW starts to work and
> fetch the value of box_ex_reg,  when the most significant byte of
> box_reg(4 bytes) is written. Meanwhile, for SDIO/USB interface,
> since the transferring speed is slow, the driver is still in writing
> the new value of box_ex_reg through the bus, and FW may get the
> wrong value of box_ex_reg at the moment.
> 
> To prevent the above driver/FW racing situation, box_ex_reg is
> written first then box_reg. Furthermore, it is written in 4 bytes at
> a time, instead of written in one byte one by one. It can increase
> the speed for SDIO/USB interface.
> 
> Signed-off-by: Ji-Pin Jou <neo_jou@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>

Patch applied to wireless-next.git, thanks.

823092a53556 wifi: rtw88: fix race condition when doing H2C command

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221124064442.28042-1-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

