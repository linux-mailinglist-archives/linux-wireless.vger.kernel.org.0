Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810475B59A9
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Sep 2022 13:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiILLwP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Sep 2022 07:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiILLwO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Sep 2022 07:52:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B821DA54
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 04:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29129B80CB4
        for <linux-wireless@vger.kernel.org>; Mon, 12 Sep 2022 11:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C82AC433D6;
        Mon, 12 Sep 2022 11:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983530;
        bh=g1GQ/CmHFt4H0N1SADP0QAR0xLvT3+efA2sz8f0MQV0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=tcJB7j1fV34PjvzftCFs18WrHnMOllSk2XOBRuBhX/IJ/keWCbBJiDs46yo01TgOy
         kmYf1ytsHP4rJx26Jc1qHDtGUTQfEFuNLgG/s83AQv32ipFffutGYGue3KyC3rsuib
         3vntzYjDsi0WTJWJUUIdFPnxuBu1SKHcs3tsPySF2kHkQeMaBO6fX7oD7F+0ZlsBap
         kSO42g2FY7/HTJE08I2gMgsGKgxAJ11/3j2jxqAsFlkmtLbpreJovgiS89uzmPGPdt
         PAa4kSBWt6GKBgGBgaB9Mqm4/HxAjXnyUzlbcfR0iavL6/F218A4AjZWi6RGoQDYQq
         ffrSiRtLuDflw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 1/5] wifi: rtw89: use u32_get_bits to access C2H
 content of
 PHY capability
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220908074140.39776-2-pkshih@realtek.com>
References: <20220908074140.39776-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166298352687.4036.520114593767883203.kvalo@kernel.org>
Date:   Mon, 12 Sep 2022 11:52:10 +0000 (UTC)
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

> The definitions of bit fields in structure will be wrong in big-endian
> platform, so use u32_get_bits() to access them.
> 
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

5 patches applied to wireless-next.git, thanks.

c7ad08c60163 wifi: rtw89: use u32_get_bits to access C2H content of PHY capability
dc229d944e3f wifi: rtw89: parse phycap of TX/RX antenna number
5a8e06e49aac wifi: rtw89: configure TX path via H2C command
6ce472d6516c wifi: rtw89: record signal strength per RF path
7dbdf65525b3 wifi: rtw89: support TX diversity for 1T2R chipset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220908074140.39776-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

