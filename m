Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51D26E4474
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Apr 2023 11:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjDQJwy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 17 Apr 2023 05:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjDQJwx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 17 Apr 2023 05:52:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF3A5B90
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 02:52:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D6F6D6210A
        for <linux-wireless@vger.kernel.org>; Mon, 17 Apr 2023 09:50:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564DBC433D2;
        Mon, 17 Apr 2023 09:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681725010;
        bh=GloDY9RSY+FdUnWarKopN7KTCMWWSAwggxQviXh0CUI=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=bjvm6ghpGPRe3aUEmTiiFHYV2k+SxNOC5ElSgE0Th31MIL+bMd8UMsSrf0GNnvmFj
         HcFm4jYa858P0AUzryNGGlS7mTI40P4wl8hHo7lzPP9yRMJczWGVloE8xpqt2ycK+3
         2oPKuWWVaN/RJQ8D5mBBxnjy3spsU58mjSGTMzTg1aLNH9flDbYY5JB7iaN0smp4QR
         hzMbjtZQR86yKPhGoX7QYrV+h5Z7tEukE6HNVZ7JV30JBWuvIS4r5R9fU/TquZKSZi
         1z+ZjhQq6evlerHGLfGmixcj+Wd7aBTSjxOK2eDrn572Ca4zLeZp2NEjLY72p/57Nk
         dpTmmqe6LENsQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/6] wifi: rtw89: prohibit enter IPS during HW scan
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230415034900.15679-2-pkshih@realtek.com>
References: <20230415034900.15679-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168172500723.26465.14719731055543157237.kvalo@kernel.org>
Date:   Mon, 17 Apr 2023 09:50:09 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Chih-Kang Chang <gary.chang@realtek.com>
> 
> Mac80211 core may ask driver to change to idle mode during HW scan,
> then H2C command for HW scan will send failed since chip is in idle
> mode. Therefore, We check the SCANNING flag before entering IPS to
> prevent this behavior.
> 
> Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

6 patches applied to wireless-next.git, thanks.

e579e943bac3 wifi: rtw89: prohibit enter IPS during HW scan
e7399db231d0 wifi: rtw89: refine scan function after chanctx
8b048bd5ddf7 wifi: rtw89: use struct instead of macros to set H2C command of hardware scan
ac83f3809055 wifi: rtw89: update statistics to FW for fine-tuning performance
982a91642708 wifi: rtw89: Disallow power save with multiple stations
f22c0bffe8d9 wifi: rtw89: add support of concurrent mode

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230415034900.15679-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

