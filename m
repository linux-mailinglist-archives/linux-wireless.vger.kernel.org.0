Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 466A84286AE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 08:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbhJKGTC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 02:19:02 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:42646 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhJKGS7 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 02:18:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633933020; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=I+tx+chtHAFNVvgwyfpJDzCDd0STWvEz3+21VZkjv68=; b=JavdBa+gtIpUKdcbv2iiDk7TNP500vieIVFLRPLnYAF1gdZ0QHr5EUZoJsFtV4OYOUypCa2j
 z92pcXuMbPZXT8OvOISVWpGIN+EBARJ91l2u6d0vbL/Bnj2p0NRojZ414xXVOPoA54u2F+7x
 9GqJT9yFeXqGoWDdmLnWBLDMR+U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6163d6d64ccc4cf2c7959b63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Oct 2021 06:16:54
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D0614C43617; Mon, 11 Oct 2021 06:16:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 69A79C4338F;
        Mon, 11 Oct 2021 06:16:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 69A79C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Srinivasan Raju <srini.raju@purelifi.com>
Cc:     mostafa.afgani@purelifi.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-wireless@vger.kernel.org (open list:NETWORKING DRIVERS (WIRELESS)),
        netdev@vger.kernel.org (open list:NETWORKING DRIVERS)
Subject: Re: [PATCH] [v19 2/2] wireless: Initial driver submission for pureLiFi STA devices
References: <20200928102008.32568-1-srini.raju@purelifi.com>
        <20211006100501.6545-1-srini.raju@purelifi.com>
Date:   Mon, 11 Oct 2021 09:16:50 +0300
In-Reply-To: <20211006100501.6545-1-srini.raju@purelifi.com> (Srinivasan
        Raju's message of "Wed, 6 Oct 2021 11:04:12 +0100")
Message-ID: <874k9o5bn1.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Srinivasan Raju <srini.raju@purelifi.com> writes:

> This introduces the pureLiFi LiFi driver for LiFi-X, LiFi-XC
> and LiFi-XL USB devices.
>
> LiFi is a mobile wireless technology that uses light
> rather than radio frequencies to transmit data.
>
> 802.11 bb is focused on introducing necessary changes to
> IEEE 802.11 Stds to enable communications in the light medium
>
> This driver implementation has been based on the zd1211rw driver.
>
> Driver is based on 802.11 softMAC Architecture and uses
> native 802.11 for configuration and management.
>
> The driver is compiled and tested in ARM, x86 architectures and
> compiled in powerpc architecture.
>
> Signed-off-by: Srinivasan Raju <srini.raju@purelifi.com>

When you are submitting a patchset you should always submit all patches
at the same time. Also including a cover letter is very much preferred.
And remember to use git send-email when submitting the patchset.

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#sending_large_patches_or_multiple_patches

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
