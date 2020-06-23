Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767AF204CC8
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 10:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731733AbgFWIoP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 04:44:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:54897 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731674AbgFWIoP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 04:44:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592901854; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=XyBQkWQbDwqBgVKO/Vo3EKznREop0sfc4JcrU5tZ5a4=;
 b=XgNWDNaQ//MIXNkQoMcInD/LxGr50Tc1629URkqa7aDwY0OyoAWxe/DlnFVnBGyjr7Mmbk0W
 m5U6Wy7G30fGffOnLIvwhdaSAlQtuIsXp644HuAACwX8SI/BNv62qohfmAh91Rd6/bgz8Go7
 mr8NlVTy/hiWQnrkvCM+Vsh7ocg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ef1c0cf567385e8e7e11a50 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 08:43:59
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5EC2C433C6; Tue, 23 Jun 2020 08:43:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0083C433C8;
        Tue, 23 Jun 2020 08:43:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0083C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5.8] mt76: mt7615: fix EEPROM buffer size
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200622150716.49622-1-nbd@nbd.name>
References: <20200622150716.49622-1-nbd@nbd.name>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200623084358.C5EC2C433C6@smtp.codeaurora.org>
Date:   Tue, 23 Jun 2020 08:43:58 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Felix Fietkau <nbd@nbd.name> wrote:

> Avoid adding MT7615_EEPROM_SIZE twice.
> Rename MT7615_EEPROM_EXTRA_DATA to MT7615_EEPROM_FULL_SIZE, since it already
> includes MT7615_EEPROM_SIZE
> 
> Fixes: ad380ad1ebbe ("mt76: mt7615: add support for applying DC offset calibration from EEPROM")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Patch applied to wireless-drivers.git, thanks.

dc7bd30b97aa mt76: mt7615: fix EEPROM buffer size

-- 
https://patchwork.kernel.org/patch/11618085/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

