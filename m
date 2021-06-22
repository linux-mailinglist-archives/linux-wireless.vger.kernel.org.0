Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2A63B08AF
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Jun 2021 17:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhFVPYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Jun 2021 11:24:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38092 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231604AbhFVPYa (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Jun 2021 11:24:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624375335; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=fHJZj/aA5Iy2t/aT2GqBYJggUPO6nu4vDdwMYV3L2u4=;
 b=vOyPl5RXRvsIRIkz6mFkCfpdsP2mW3gGVZa35XKlGAQwyY5WZyls+wtHLt99IDcf9SXm77rs
 PC81ocYGA/LvAevktKHzvHp52HsuUASwFfqgSLAIERtszCfBZ3opi8yN5WYpgE3B3wMQ7hey
 VeTKP23ImriyxIZbmjuvWDSEycA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60d2000a32b73d6b2820eefb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Jun 2021 15:21:46
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 747EEC4338A; Tue, 22 Jun 2021 15:21:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C95F7C433D3;
        Tue, 22 Jun 2021 15:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C95F7C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] rtw88: dump FW crash via devcoredump
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210528032901.12927-2-pkshih@realtek.com>
References: <20210528032901.12927-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>, <kevin_yang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210622152145.747EEC4338A@smtp.codeaurora.org>
Date:   Tue, 22 Jun 2021 15:21:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Zong-Zhe Yang <kevin_yang@realtek.com>
> 
> Use device coredump framework instead of print_hex_dump to support
> FW crash dump. Pass data to the framework if preparing and dumping
> are successful. The framework will take the ownership of the data.
> The data will be freed after the framework determines its lifetime
> is over. A new coredump will not work if the previous one still
> exists.
> 
> Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>

2 patches applied to wireless-drivers-next.git, thanks.

7b80f3e48c4b rtw88: dump FW crash via devcoredump
ae04f15b1a83 rtw88: refine unwanted h2c command

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210528032901.12927-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

