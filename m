Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 478267C6DC3
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 14:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343869AbjJLMP6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 08:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347260AbjJLMP5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 08:15:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB469DA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 05:15:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838D4C433C8;
        Thu, 12 Oct 2023 12:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697112955;
        bh=Ly1H4kos/SLEQT68TRBP2BtT8jGtepNKp4Vwr1HcK8w=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=EGLbSh/tcJlCD9y9HChEjXYGCNv6WCMrNWxl+z0goirrg4mchJZDD8c4RGLzc/Pm/
         vCYlCXiBEo5Z+te7XpiE2SosIisyUSfcBUlbf4/jJ9vd6mzZEAvhre9Qf2YekGli14
         SOSH29h5mPjl21PfnW+Na6Z6uSQa+sY3CUQ02kaPULZ7XA1Q8GifkKFsFOl+bSK49T
         mnR+b5CSLsdkxuBfFhiJYISY02fGaNmQoujP4PN0+/4ReeywgDL2fkUtxEL+W1t/NG
         LnlLAMYwElzBn9xjKX+OM3AZE8y89HBBinPG08W4oNLZllzqWTxMyb4pquknSTQh/t
         KJxWRq7/Qy+vQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/6] wifi: radiotap: add bandwidth definition of EHT
 U-SIG
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231011115256.6121-2-pkshih@realtek.com>
References: <20231011115256.6121-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169711295258.2932680.17199632143941464580.kvalo@kernel.org>
Date:   Thu, 12 Oct 2023 12:15:54 +0000 (UTC)
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

> Define EHT U-SIG bandwidth used by radiotap according to Table 36-28
> "U-SIG field of an EHT MU PPDU" in 802.11be (D3.0).
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

61b546b1f3e2 wifi: radiotap: add bandwidth definition of EHT U-SIG
786a93c9b232 wifi: rtw89: parse EHT information from RX descriptor and PPDU status packet
1f3cd090b4b2 wifi: rtw89: Add EHT rate mask as parameters of RA H2C command
f456701201e2 wifi: rtw89: parse TX EHT rate selected by firmware from RA C2H report
e25ef743866c wifi: rtw89: show EHT rate in debugfs
f1f74dffdfb7 wifi: rtw89: add EHT radiotap in monitor mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231011115256.6121-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

