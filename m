Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768B821F88F
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 19:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgGNRxJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 13:53:09 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:11067 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725883AbgGNRxJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 13:53:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594749188; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=W+EwrRD6fqxzTBYfgtLxgLwr+To9DcP2qQnWGT+TXGQ=;
 b=jy/44gSGYyrtbnZq13Lvia0kct0Oix3LYZ9zryzqslH+g2co4q6dKkyFFPzu4ASYt4NPKm7b
 BFO+d3zdS72+L8YdLc9NhAXJxb6kV91kQpWDNXP1pHpFtdOZr5KcdEzRRl+ncE8eSctHTeX/
 poDoKE3RstZDteSKUACCePeDcyM=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5f0df0fdee6926bb4f1a5027 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 17:53:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 36E8EC43387; Tue, 14 Jul 2020 17:53:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8E7FFC433CB;
        Tue, 14 Jul 2020 17:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8E7FFC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-drivers-next 1/5] MAINTAINERS: net: wilc1000:
 Update
 entry
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200710051826.3267-2-ajay.kathat@microchip.com>
References: <20200710051826.3267-2-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714175301.36E8EC43387@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 17:53:01 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> As Adham's email address is bouncing, remove him from wilc1000 entry and
> add Claudiu as a new co-maintainer. Claudiu follows wilc1000 driver
> development for a long time and contributed to it already.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

5 patches applied to wireless-drivers-next.git, thanks.

4f5479e2ee1f MAINTAINERS: net: wilc1000: Update entry
1b3dd7743041 wilc1000: use strlcpy to avoid 'stringop-truncation' warning
9bdcbdafc659 wilc1000: fix compiler warning for 'wowlan_support' unused variable
0b3dd675ed59 wilc1000: use unified single wilc1000 FW binary
b52b331a8978 wilc1000: use API version number info along with firmware filename

-- 
https://patchwork.kernel.org/patch/11655667/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

