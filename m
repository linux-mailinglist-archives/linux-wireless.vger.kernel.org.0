Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B2F38187B
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 13:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhEOLrC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 07:47:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31820 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229516AbhEOLrB (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 07:47:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1621079149; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=AFggAW9S2oUhsjO4QulujtwV4zRNgO0Lg/1tMQIHgN4=;
 b=kqLqwWDafskjxD1HEZz7EIg7rsNQzj1w+aOMnY45XHHBMA/fSON/hM1++S1k7KvoOZt9Ui76
 g+aYKrN0uc1MOImwj3zbZEONjHTMVtqDNT8FGQ2W/XAWoITNkWuduU4vqRUw+L8dea8C2QCo
 rRze/aesPZSxthwzeXy3YtmpegA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 609fb45d60c53c8c9dde4532 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 15 May 2021 11:45:33
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B2633C433D3; Sat, 15 May 2021 11:45:32 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26D30C433F1;
        Sat, 15 May 2021 11:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26D30C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5.13 1/2] mt76: connac: fix HT A-MPDU setting field in
 STA_REC_PHY
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210507100211.15709-1-nbd@nbd.name>
References: <20210507100211.15709-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org,
        Jayden Kuo <Jayden.Kuo@mediatek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210515114532.B2633C433D3@smtp.codeaurora.org>
Date:   Sat, 15 May 2021 11:45:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> The MT7921 firmware needs this to enable tx A-MPDU properly
> 
> Reported-by: Jayden Kuo (郭育辰) <Jayden.Kuo@mediatek.com>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

2 patches applied to wireless-drivers.git, thanks.

d6245712add0 mt76: connac: fix HT A-MPDU setting field in STA_REC_PHY
94bb18b03d43 mt76: mt7921: fix max aggregation subframes setting

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210507100211.15709-1-nbd@nbd.name/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

