Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBA33B2BAD
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jun 2021 11:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbhFXJpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Jun 2021 05:45:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:24856 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231971AbhFXJpX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Jun 2021 05:45:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624527784; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=LReHjJFjR5bo31mYcK3ZhpGfOdgUBnhgDioqSFj2D1A=; b=CeIpBtIUEr6CgWQvAthfVGVuDITQmLBhc50whQBRtaRvU8XTUWKsHKcqoYnANO7OU5VI+GTI
 C7ZBice0QPJHP7FGgblLWotVppTBjtvaOClynFTj+BOlzBgth5pEqvDJ1w6y0p4oItRBj5L0
 b5TTmLtn4r3giRX04ycTdOnPn8g=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 60d453a2dc4628fe7efdc45c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 24 Jun 2021 09:42:58
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFDC0C43217; Thu, 24 Jun 2021 09:42:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8DA73C433F1;
        Thu, 24 Jun 2021 09:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8DA73C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 12/12] wilc1000: increase WILC_CFG_PKTS_TIMEOUT timeout value
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
        <20210423182925.5865-13-ajay.kathat@microchip.com>
Date:   Thu, 24 Jun 2021 12:42:54 +0300
In-Reply-To: <20210423182925.5865-13-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Fri, 23 Apr 2021 18:29:50 +0000")
Message-ID: <87sg17ha3l.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Increase duration for WID config response timeout to have enough
> wait for the response message.

Why?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
