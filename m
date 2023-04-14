Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4F6E22ED
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 14:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjDNMOP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjDNMOO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 08:14:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5391722
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 05:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6BC63E28
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 12:14:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA361C433EF;
        Fri, 14 Apr 2023 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681474452;
        bh=8k7pqC+YL5WSuceXwU+mxpT/HQ0cVSzkC82ttaYA+0o=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Os7cLhR7gEwsXJOYIxYQONViLWZBrh2OX71ronGazPQxZAfCMrLfJHkRfExQ1IqQ/
         rPg96JfgJe6ItLhymbvL0PnnlSkXaQEEUvqj1WrLFo5Ll3e5K6hik95hgjH5rg+26l
         NDywLwecna1/jzk2eFjEYhhRQ6fgd+jz3dF39flGA+loYEFQRCp7VqmRR+4bBHxcaE
         obPpy5fIEeWuKPgsPCFaaANEL9vcie0HNfwnNuvj28J5ZW+wgacGHuGg4w6e/a46RJ
         bYKjRnGyuizor6netmRggYSxLYlQA2ZbgGX/9h1akdU+KY4jcsN62TER1x1I9dpT7q
         qUg7RG+2CgqXw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/3] wifi: rtw89: fw: use generic flow to set/check
 features
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230320130606.20777-2-pkshih@realtek.com>
References: <20230320130606.20777-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168147445001.16522.17153010812658667309.kvalo@kernel.org>
Date:   Fri, 14 Apr 2023 12:14:11 +0000 (UTC)
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

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> In early feature bitmap obtained from rtw89_early_fw_feature_recognize(),
> the bits needed to check get increased. It's more friendly to work with
> RTW89_CHK_FW_FEATURE(). So, we concentrate the flow of iterating FW feature
> configures and calling RTW89_SET_FW_FEATURE() for various uses. And then,
> we adjust rtw89_early_fw_feature_recognize() for RTW89_CHK_FW_FEATURE().
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

639ec6d63588 wifi: rtw89: fw: use generic flow to set/check features
b80ad23a8f2e wifi: rtw89: use schedule_work to request firmware
ffde7f3476a6 wifi: rtw89: add firmware format version to backward compatible with older drivers

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230320130606.20777-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

