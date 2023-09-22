Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6B67AAAA8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Sep 2023 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjIVHqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Sep 2023 03:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjIVHpp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Sep 2023 03:45:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7D119BA
        for <linux-wireless@vger.kernel.org>; Fri, 22 Sep 2023 00:44:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5776FC433C9;
        Fri, 22 Sep 2023 07:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695368664;
        bh=4J0YpT7AiSnhsgyKDdI1p4GbzGZK4PWSE/jvZEH5l6Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mhxawKxuzRc1KQdx8en3S88LSiOACAIlvmifNk+VEQg1Y6RNagE2cuO1OYiO5O2cH
         04ix2EIlj7VXzY5mRHXD/bpYrdaj0mvdtQLYXDmb8bOrTVndebI4gyB83iXHhk//T6
         9ICAim+3Hu+7MnzuqF3ys6yPRfgN/NlZtOXW51yTPG++QfXuWgRD7x/LnTWVSmpQBw
         VDVFg0VDXaOlVgNPNpxchFDQAEguq1+xyeeqE2q3bTP3WO1Tit5SGkqyBw/j7NPwaJ
         jK5X4Zcbjv1Xl32SwL7T6xhaQ9MIUiKVQqcDLdiYx/rhZbi5BSOFkLflTwzInIIbCm
         umSWquiN6XLug==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/7] wifi: rtw89: add subband index of primary channel to
 struct rtw89_chan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230920074322.42898-2-pkshih@realtek.com>
References: <20230920074322.42898-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169536866144.2011393.5748552700226455609.kvalo@kernel.org>
Date:   Fri, 22 Sep 2023 07:44:23 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> The subband index is a hardware value of relationship between primary
> channel and bandwidth, and it is used by setting channel/bandwidth to
> specify the primary channel.
> 
> Because this index is only needed when bandwidth >= 20 MHz, adjust
> order of enumerator bandwidth to access offsets array easier. To prevent
> misuse RTW89_CHANNEL_WIDTH_NUM as size, change it to
> RTW89_CHANNEL_WIDTH_ORDINARY_NUM that will be the size of array. The
> enumerator values of bandwidth (before ordinary number) will be also
> used by upcoming TX power table built in firmware file, so add a comment
> to remind keeping the order.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

7 patches applied to wireless-next.git, thanks.

9483d8b3aac8 wifi: rtw89: add subband index of primary channel to struct rtw89_chan
1bf24172cc75 wifi: rtw89: indicate TX shape table inside RFE parameter
4cc05e315650 wifi: rtw89: indicate TX power by rate table inside RFE parameter
634fd9920c28 wifi: rtw89: phy: refine helpers used for raw TX power
9707ea6d6822 wifi: rtw89: load TX power by rate when RFE parms setup
f6d601c7590f wifi: rtw89: phy: extend TX power common stuffs for Wi-Fi 7 chips
5ee7b2ea07cc wifi: rtw89: load TX power related tables from FW elements

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230920074322.42898-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

