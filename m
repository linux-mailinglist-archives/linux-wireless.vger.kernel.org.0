Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEFD318555
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 07:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBKGrH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 01:47:07 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:39411 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229734AbhBKGrE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 01:47:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613025999; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=1s9pD/OVQBsEQtS0E7TnZb65yfbnfW9++9thyxskWvM=;
 b=DQablHnMTZYxY2I+HOEQurjRzXs8/oOnQrCvsIOXfE0JWIjsMWk7SblJtWitrNf/zTRS9it6
 ACuuFLMkX4gqWcT5FE0fRn5cqbD2lKK4cnA8RyP550bYdzJcrIRGq1RiMd3UBGm9ke2bGeoI
 Zuo56tYqDtnyi3C3Gpe/nXkJ4dA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 6024d2b0830f898bac423547 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 06:46:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A03B5C433C6; Thu, 11 Feb 2021 06:46:08 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B34BC433CA;
        Thu, 11 Feb 2021 06:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B34BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wilc1000: Fix use of void pointer as a wrong struct
 type
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <YCQomJ1mO5BLxYOT@Vsevolods-Mini.lan>
References: <YCQomJ1mO5BLxYOT@Vsevolods-Mini.lan>
To:     Vsevolod Kozlov <zaba@mm.st>
Cc:     ajay.kathat@microchip.com, claudiu.beznea@microchip.com,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210211064608.A03B5C433C6@smtp.codeaurora.org>
Date:   Thu, 11 Feb 2021 06:46:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Vsevolod Kozlov <zaba@mm.st> wrote:

> ac_classify() expects a struct sk_buff* as its second argument, which is
> a member of struct tx_complete_data. priv happens to be a pointer to
> struct tx_complete_data, so passing it directly to ac_classify() leads
> to wrong behaviour and occasional panics.
> 
> Since there is only one caller of wilc_wlan_txq_add_net_pkt and it
> already knows the type behind this pointer, and the structure is already
> in the header file, change the function signature to use the real type
> instead of void* in order to prevent confusion.
> 
> Signed-off-by: Vsevolod Kozlov <zaba@mm.st>

Patch applied to wireless-drivers-next.git, thanks.

6fe91b69cece wilc1000: Fix use of void pointer as a wrong struct type

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/YCQomJ1mO5BLxYOT@Vsevolods-Mini.lan/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

