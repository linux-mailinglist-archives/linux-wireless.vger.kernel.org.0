Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684B8422B04
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235401AbhJEOai (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 10:30:38 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:54605 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234757AbhJEOah (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 10:30:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633444127; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M/tBEJGnQxX32yoGa1O+IWu4aAvfVnCAMmtGxlm25Iw=;
 b=Lx11FIdQfjH43CZ1AqYoGTdJAxO/VYQThoWOpz6krxP2nSm5GxYIYIhGbW7c3GFWrVf594E6
 yxe1iYUbGv3jFYrznuqaEYYb2mYaujPnaZY5KeJdjDKdBsgX3QhS93ina5m89bRkVEz35REp
 da4pYa7bSDjpkmXchYzNVLXLkCY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 615c61124ccc4cf2c7896482 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 14:28:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A9D1EC43460; Tue,  5 Oct 2021 14:28:34 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E3B8C4338F;
        Tue,  5 Oct 2021 14:28:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0E3B8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4] dt-bindings: net: wireless: qca,ath9k: convert to the
 json-schema
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210924223509.52525-1-chunkeey@gmail.com>
References: <20210924223509.52525-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20211005142834.A9D1EC43460@smtp.codeaurora.org>
Date:   Tue,  5 Oct 2021 14:28:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This replaces the existing .txt binding file. Furthermore, this
> also helps with validating DTS files.
> 
> Introduced binding changes:
>  1. added inherited mac-address nvmem property
>  2. added inherited ieee80211-freq-limit property
>  3. added new calibration nvmem property
>  4. added second example (taken from the Netgear WNDR3700v2)
>     Reason: Setting qca,no-eeprom; takes presedence over
>     nvmem-cells. I think a different example is needed,
>     because the driver can only reads from one calibration
>     source per device.
>  5. (re-added) chip list (based on data from ath9k's pci.c)
> 
> Added binding .yaml to MAINTAINERS.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

57bb2398bd5f dt-bindings: net: wireless: qca,ath9k: convert to the json-schema

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210924223509.52525-1-chunkeey@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

