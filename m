Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283BF3130C1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhBHLZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:25:20 -0500
Received: from so15.mailgun.net ([198.61.254.15]:20940 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233053AbhBHLWx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:22:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612783330; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=hQjzgIkCcOTZYYS/Zt8zVxPDT+/pdfnIY+uVO/iRm6c=;
 b=d0IWVZbAGgiDrT9/OLnw6AhTKme9l9Bmn6EYVbFFSBnorCEFkppD6kitm4nSuerYjWi6B6mk
 hl/iGKhaesiI2yuWDD8LTgRa3YD/APptFmEFpNUn+ieH+tyt/RUtQu1L8FeTkBkXgFL07A7t
 G8/TGRlfZaNUCrez9lsk5/r2Mgo=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60211ec8e3df861f4bfe6355 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 08 Feb 2021 11:21:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 28211C433ED; Mon,  8 Feb 2021 11:21:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0C8B3C433CA;
        Mon,  8 Feb 2021 11:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0C8B3C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rt2800usb: add Sweex LW163V2 id's
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210204101902.199590-1-stf_xl@wp.pl>
References: <20210204101902.199590-1-stf_xl@wp.pl>
To:     stf_xl@wp.pl
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210208112144.28211C433ED@smtp.codeaurora.org>
Date:   Mon,  8 Feb 2021 11:21:44 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

stf_xl@wp.pl wrote:

> From: Stanislaw Gruszka <stf_xl@wp.pl>
> 
> Add support for Sweex LW163V2 device.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers-next.git, thanks.

93476ca74457 rt2800usb: add Sweex LW163V2 id's

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210204101902.199590-1-stf_xl@wp.pl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

