Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C21ABAEBF
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2019 09:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404826AbfIWHzE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Sep 2019 03:55:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35720 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfIWHzD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Sep 2019 03:55:03 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id BB23D6119D; Mon, 23 Sep 2019 07:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569225302;
        bh=MRSOLs+IL9K3Xj2N/eEkLuoH7I546KXrmOYcpE3Oohs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=mQBVbCFXnPuibARCZEgivLrwRD9Iij8gFXYeTRaF80TJcSiFMoYzUbSBMqJQLoRtz
         xSdgHimpGFpb+OIwygqcj/6aLRk8OHNhvafg8unN7iy2bNLYmIoZiNU97Q4y34giQf
         C0zFoBAcr97Q8DKcdup7jdCAuz3pW9py9+LjBTc4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24EBA606DB;
        Mon, 23 Sep 2019 07:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569225302;
        bh=MRSOLs+IL9K3Xj2N/eEkLuoH7I546KXrmOYcpE3Oohs=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=WyFwRVegsLJj9N/grUPMqaBHpVzKrVT8SKCzXFx10E8Advf133pwkyLIhASw/yXb2
         5yczE2k1TlLDKkXFYdDJMblOggp7W+ZwxtirtteStxPKv/WiR7Ja7G1jetibBk+85D
         NX+SvBcBlxmGtQ+9C/xReCLola3xu+C09CtSIDWQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24EBA606DB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3] ath10k: Add support to provide higher range mem chunks
 in wmi init command
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1551098926-24644-1-git-send-email-svishnoi@codeaurora.org>
References: <1551098926-24644-1-git-send-email-svishnoi@codeaurora.org>
To:     Surabhi Vishnoi <svishnoi@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Surabhi Vishnoi <svishnoi@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190923075502.BB23D6119D@smtp.codeaurora.org>
Date:   Mon, 23 Sep 2019 07:55:02 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Surabhi Vishnoi <svishnoi@codeaurora.org> wrote:

> With the current implementation of wmi init command,
> there is no provision for the host driver to provide mem
> chunks addresses with more than 32-bit, to the firmware.
> WCN3990 is a 35-bit target and can accept mem chunks addresses
> which are above 32-bit.
> 
> If firmware supports address range more than 32 bit, it
> advertises the support by setting the WMI_SERVICE_EXTEND_ADDRESS
> service. Based on this service fill the upper bits of paddr while
> providing the mem chunks in the wmi init command.
> 
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-00784-QCAHLSWMTPLZ-1
> 
> Signed-off-by: Surabhi Vishnoi <svishnoi@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

40f4ef5e9232 ath10k: Add support to provide higher range mem chunks in wmi init command

-- 
https://patchwork.kernel.org/patch/10828535/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

