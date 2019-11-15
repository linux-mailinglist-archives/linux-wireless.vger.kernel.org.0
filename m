Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6BFFDD6D
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 13:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfKOMY2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 07:24:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:50544 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727196AbfKOMY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 07:24:28 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E453960E0D; Fri, 15 Nov 2019 12:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573820667;
        bh=g6xe7iyjtAnHZF/FM9T/0U/255aCYUNGehEIvHnXysE=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oTFgDV4DeIM92tYbqSStBkLgQH3dZTTzXMFPivt65UlK/hcux/7U2NYCm75r89HG2
         u+MKUbQN2cN3m19Lzxx6khYOXDeBxtXtjoJoAsUdpS3oGAxJqWvadGP/hzAj+0K1EZ
         LKDZQGkghfbWfLG6JuvTLmvIB6EXMyJxrplD/oiE=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 786696030B;
        Fri, 15 Nov 2019 12:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573820667;
        bh=g6xe7iyjtAnHZF/FM9T/0U/255aCYUNGehEIvHnXysE=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=j916EAZu8O9hSzKISFJmirQge+Bw4idgBpZ6LdqSUfl1QxM7TebvhMHBButeml3wd
         YnbyTIEQ67h1sKQjHq63WuY/6e28y2rLuNyW1H+AWWubIBIERmlfEIJyEJIvWZDGyJ
         h4t77hz7ebmaHeUxxvALqqHolR7w10ho1OjJTxAI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 786696030B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtl8xxxu: Remove set but not used variable 'rsr'
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191110104955.131246-1-zhengyongjun3@huawei.com>
References: <20191110104955.131246-1-zhengyongjun3@huawei.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     <Jes.Sorensen@gmail.com>, <davem@davemloft.net>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengyongjun3@huawei.com>, Hulk Robot <hulkci@huawei.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191115122427.E453960E0D@smtp.codeaurora.org>
Date:   Fri, 15 Nov 2019 12:24:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zheng Yongjun <zhengyongjun3@huawei.com> wrote:

> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c: In function rtl8xxxu_gen2_config_channel:
> drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:1266:13: warning: variable rsr set but not used [-Wunused-but-set-variable]
> 
> rsr is never used, so remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

Patch applied to wireless-drivers-next.git, thanks.

38860bdf28b7 rtl8xxxu: Remove set but not used variable 'rsr'

-- 
https://patchwork.kernel.org/patch/11236191/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

