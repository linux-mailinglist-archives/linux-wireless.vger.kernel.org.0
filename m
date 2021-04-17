Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE9F36319C
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Apr 2021 19:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbhDQRtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 17 Apr 2021 13:49:22 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:14301 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236643AbhDQRtW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 17 Apr 2021 13:49:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618681736; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=ccsK5pmy+NKu+zryqAu1pvu8d0fsb8w75hriVHJX0XI=;
 b=piwVqyLMltDiivTJcVQg6qj63KeREGK97Cb8lvVyttdHrB0ZGnN843SlXFHvdSjfuDYylMWr
 B8nBI5can73gxao6abzLXIdYBamJW/gJPZPz1B31STZhj3Qn396rN56IBO/qcxEgg1KqG02t
 7YRk6FMdleD/MKwokhjFsw59Jpk=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607b1f87a817abd39a273e9f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 17 Apr 2021 17:48:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 860D2C433D3; Sat, 17 Apr 2021 17:48:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C3CEEC433F1;
        Sat, 17 Apr 2021 17:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C3CEEC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/4] wilc1000: Make SPI transfers work at 48MHz
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210227172818.1711071-1-davidm@egauge.net>
References: <20210227172818.1711071-1-davidm@egauge.net>
To:     David Mosberger-Tang <davidm@egauge.net>
Cc:     linux-wireless@vger.kernel.org,
        Ajay Singh <ajay.kathat@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        davidm@egauge.net
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210417174854.860D2C433D3@smtp.codeaurora.org>
Date:   Sat, 17 Apr 2021 17:48:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

David Mosberger-Tang <davidm@egauge.net> wrote:

> For CMD_SINGLE_READ and CMD_INTERNAL_READ, WILC may insert one or more
> zero bytes between the command response and the DATA Start tag (0xf3).
> This behavior appears to be undocumented in "ATWILC1000 USER GUIDE"
> (https://tinyurl.com/4hhshdts) but we have observed 1-4 zero bytes
> when the SPI bus operates at 48MHz and none when it operates at 1MHz.
> 
> This code is derived from the equivalent code of the wilc driver in
> the linux-at91 repository.
> 
> Signed-off-by: David Mosberger-Tang <davidm@egauge.net>

4 patches applied to wireless-drivers-next.git, thanks.

f2131fa516b8 wilc1000: Make SPI transfers work at 48MHz
5ee2d9dd73fc wilc1000: Introduce symbolic names for SPI protocol register
ce3b933832b6 wilc1000: Check for errors at end of DMA write
c872e7ae056f wilc1000: Add support for enabling CRC

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210227172818.1711071-1-davidm@egauge.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

