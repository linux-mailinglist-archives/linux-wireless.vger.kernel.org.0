Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBC62CC6CF
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 20:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731145AbgLBTjZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 14:39:25 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:42594 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729192AbgLBTjY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 14:39:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606937944; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=a8K04QVKEOy+UOblGJhBHt4/tp3EBnexCUl49jcVOrk=;
 b=btiOoTgs9maTdKjxTAbf78R1L2+eMQqE7Dsf+i1Snalfla//Ln5ClxUrlfh+AX4OSmpe0kB2
 YR3XGcu5HA//dC1g20GWEOH9iRzM4fpRODUerq/Vapd9WlKVfe4Rs1/5Xnt0MXwJcesnTaP9
 BuJi8Gae8+/dE13LBcjP6S1cXis=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fc7ed3eedac2724d8ce3fcd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 19:38:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1D260C43463; Wed,  2 Dec 2020 19:38:38 +0000 (UTC)
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BC4FC433C6;
        Wed,  2 Dec 2020 19:38:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BC4FC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/5] wilc1000: added 'ndo_set_mac_address' callback
 support
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20201125114059.10006-2-ajay.kathat@microchip.com>
References: <20201125114059.10006-2-ajay.kathat@microchip.com>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202193838.1D260C43463@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 19:38:38 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> wrote:

> From: Ajay Singh <ajay.kathat@microchip.com>
> 
> Added support for 'ndo_set_mac_address call' callback to allow change of
> interface MAC address.
> 
> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>

5 patches applied to wireless-drivers-next.git, thanks.

c04fabacb780 wilc1000: added 'ndo_set_mac_address' callback support
dd460e2ac05f wilc1000: free resource in wilc_wlan_txq_add_net_pkt() for failure path
66aea5d198c3 wilc1000: free resource in wilc_wlan_txq_add_mgmt_pkt() for failure path
9c172f30b40b wilc1000: call complete() for failure in wilc_wlan_txq_add_cfg_pkt()
339754ffdb92 wilc1000: added queue support for WMM

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20201125114059.10006-2-ajay.kathat@microchip.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

