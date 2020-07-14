Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8430C21F899
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2020 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgGNRyM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jul 2020 13:54:12 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:37324 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgGNRyK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jul 2020 13:54:10 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594749250; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=L1XYMeZq8mr3PCvQ6HmM+i0YLB7CkoBZ5IiOpY3WDpg=;
 b=wYq833RyZxtrrcQ83vvdngioNBSvyR5kjysFtHsDtqPBdChbv3rJ7+3uIwl9devMBDvSl13n
 QpwUR3zNItzM6eeqj2YSWWD77ln7u05E5k8n8raCO7OGRN7/T89h6pYo5s/zeYqcZ2UBR0U1
 3KF2NEmr3YwhhXmNCx+FLqVCIFE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-east-1.postgun.com with SMTP id
 5f0df12a03c8596cdbb3773d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 14 Jul 2020 17:53:46
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4B7BC4339C; Tue, 14 Jul 2020 17:53:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04878C433CB;
        Tue, 14 Jul 2020 17:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04878C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wilc1000: let wilc_mac_xmit() return NETDEV_TX_OK
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200629104009.84077-1-luc.vanoostenryck@gmail.com>
References: <20200629104009.84077-1-luc.vanoostenryck@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20200714175344.E4B7BC4339C@smtp.codeaurora.org>
Date:   Tue, 14 Jul 2020 17:53:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type defining 'NETDEV_TX_OK' but this
> driver returns '0' instead of 'NETDEV_TX_OK'.
> 
> Fix this by returning 'NETDEV_TX_OK' instead of '0'.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

cce0e08301fe wilc1000: let wilc_mac_xmit() return NETDEV_TX_OK

-- 
https://patchwork.kernel.org/patch/11632291/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

