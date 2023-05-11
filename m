Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 980F86FF29A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 May 2023 15:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbjEKNW2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 09:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238165AbjEKNWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 09:22:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96685106F4
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 06:20:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9E74616C2
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 13:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E197C433EF;
        Thu, 11 May 2023 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683811174;
        bh=HnR7J0td/9sxLYMhvqEvrWZwL8cU9KkZCye8KJ/0zb4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=n5aBTnSYDJB3PwnDdJ6+fdJ2wKO08YYw25ojfzx8BNrqf0kbmJebQLA2UpJpPvhzD
         U9JCYRK4DRS3qmqgTXKrnIU6r0vqVmqHpscJC62HiOjKN5rYn1wAVAkydkRYWqqWrD
         DzzjCjSrkJrt9mAbxOUCa8n81jfQ7adZdxJElSPbQ3NYkEXkhRlpHQYbRi2Sx3dsf6
         dCfZuyu9Y5suEvR9NesGmQ8987eb8rwvufARrpaEzi5vbTK8sxfb0PQlbPSgh+T9Ui
         uagTrLei7/3qJ6l0ZvqoYZF7u+C9IpR4klkQJi0RybnoxAxMV4xyUgRajNifPn1R/Z
         89PM2zt7L2jBQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: introduce realtek ACPI DSM method
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230508081211.38760-2-pkshih@realtek.com>
References: <20230508081211.38760-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168381117136.27145.12859433715801863138.kvalo@kernel.org>
Date:   Thu, 11 May 2023 13:19:33 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Introduce realtek ACPI DSM method to get required BIOS
> configurations. It will be used in the following commits.
> 
> And, enum rtw89_acpi_dsm_func is added for listing the functions
> which are currently recognized.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

e897b0bef38a wifi: rtw89: introduce realtek ACPI DSM method
a002f98123dd wifi: rtw89: regd: judge UNII-4 according to BIOS and chip
e3b77c06c886 wifi: rtw89: support U-NII-4 channels on 5GHz band

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230508081211.38760-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

