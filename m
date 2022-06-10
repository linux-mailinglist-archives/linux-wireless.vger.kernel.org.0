Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CDE545DB3
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jun 2022 09:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346750AbiFJHli (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jun 2022 03:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244446AbiFJHli (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jun 2022 03:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149404F461
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 00:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B08161FF5
        for <linux-wireless@vger.kernel.org>; Fri, 10 Jun 2022 07:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87246C34114;
        Fri, 10 Jun 2022 07:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654846895;
        bh=70JLSD9rVuYwkUc4Ze7ggjfWBTJdzchfQ+IAx4ykUgM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=I1cNtJ+TFVCs2X3PVKnj+k1ljFsCsU7qO9r0yCKclxFe4E3i+wWhbGAjfQlByLa3T
         HqJ75c1Jdi7dGsP17IEYDZwTwloErpDZpm6G/U2fKtzlHPKfS+z0twGYbdtbO6KnZ0
         i437vGOqRrvZHxoWUXFyDSaAnh4ooqAtN10B37PVmVgnY5Wzq7ugqCJAKy5B1zfl0J
         NwVGX8AzRTCdQj9TDo3vxxSX5Kz1KnpTNlnW8VgH8PsNDex3xZsqgl4lZvcACd3ZaB
         Pxi3BKbowuG6aPDwy3OeT9LeVknVBnnS3edEXSBD4rcXOwuXB2lk0bZo7LJq49/ofK
         shCvOOeJTFDMg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/3] ieee80211: add trigger frame definition
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220608113224.11193-2-pkshih@realtek.com>
References: <20220608113224.11193-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <echuang@realtek.com>, <phhuang@realtek.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165484689243.24214.16051989736625303750.kvalo@kernel.org>
Date:   Fri, 10 Jun 2022 07:41:34 +0000 (UTC)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po Hao Huang <phhuang@realtek.com>
> 
> Define trigger stype of control frame, and its checking function, struct
> and trigger type within common_info of trigger.
> 
> Signed-off-by: Po Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

3 patches applied to wireless-next.git, thanks.

21ab562c1f65 ieee80211: add trigger frame definition
5165f1689a2c rtw89: 8852c: add trigger frame counter
bc0130524cd9 rtw89: add new state to CFO state machine for UL-OFDMA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220608113224.11193-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

