Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859FD4BE650
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 19:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344869AbiBUIvL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 03:51:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344867AbiBUIvK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 03:51:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67722BC6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 00:50:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40DE161138
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 08:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B155C340E9;
        Mon, 21 Feb 2022 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645433446;
        bh=q2oI/GDWoXii6cw01B3OcEAudm2Lu9j7EZLQQhRvTmQ=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=fu+tAHwVIw/c8G5cqqttOqa8Sz79XWPRjm6D51hlHzXSDF729k/wL2RDkp3uq1BDq
         a61jPJgO69Oyy1yEnHrwgthehJYtLP8BpJBnKMwuL+w7CaltcR3jJVKHsC4Th5PAxf
         ZrkPyZpf8J1sdqC/gZ9wM7lgAfkO2JH4bXDQX6YgmR59Tzb4X8KM4JXpWuWfoewuAh
         OPxmwgp3rMfBkIBqninkJJvVZ+1+yYYqXKQG3NDIejUGI7MFXvwAAle+3AxWAcBXxE
         +1kJfQyIhpBEPAHvYtiblpDm21q3IbP7qg/bjnVIONPtp3kvEV2P/w5Lni2tugY7vo
         sFBdJ76JNU58A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] rtw88: 8822ce: add support for TX/RX 1ss mode
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220215004855.4098-2-pkshih@realtek.com>
References: <20220215004855.4098-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <timlee@realtek.com>, <ku920601@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543342900.995.5302058503879391290.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 08:50:45 +0000 (UTC)
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

> From: Chin-Yen Lee <timlee@realtek.com>
> 
> In some case, wifi chip need to be configed to be TX/RX 1ss mode.
> For this mode, wifi components, such as MAC/BB/RF, need to be
> specially set, and driver need to send SMPS action frame to inform AP.
> 
> Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

04e00ac94f6c rtw88: 8822ce: add support for TX/RX 1ss mode
176989b412b6 rtw88: coex: Improve WLAN throughput when HFP COEX
349d858ba7b1 rtw88: coex: update BT PTA counter regularly
0c496a7d6f6a rtw88: coex: Add WLAN MIMO power saving for Bluetooth gaming controller
fc3c66d324fd rtw88: coex: Add C2H/H2C handshake with BT mailbox for asking HID Info
052e4a9d87eb rtw88: coex: Update rtl8822c COEX version to 22020720

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220215004855.4098-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

