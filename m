Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0301939C3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 08:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgCZHpj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 03:45:39 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45949 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgCZHpj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 03:45:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585208738; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ofNam/A9mK9m4P86u/2kTjqxbhuy862zWmIh3TjFQ6M=; b=icXWfIFP3F+kpV96zkGU85HPSal33crd2qMl5UcKbTGkBuJxTVRghCUggIMuinPYZNzkQ08A
 R2DrX2dFqO+CRSZ7SZuxzonoPHDhcXJRIseTE1J2mk15kWfTQ7lNkR8E7jyUaSQvrJdmAgt7
 5B9y+MwiuasobGCR7oZZoxPx3ZI=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7c5d9b.7f09eda134c8-smtp-out-n02;
 Thu, 26 Mar 2020 07:45:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85168C4478F; Thu, 26 Mar 2020 07:45:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tynnyri.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D007C433D2;
        Thu, 26 Mar 2020 07:45:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D007C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     <Ajay.Kathat@microchip.com>
Cc:     <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <devicetree@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <robh@kernel.org>
Subject: Re: [PATCH] staging: wilc1000: remove label from examples in DT binding documentation
References: <20200325164234.14146-1-ajay.kathat@microchip.com>
Date:   Thu, 26 Mar 2020 09:45:22 +0200
In-Reply-To: <20200325164234.14146-1-ajay.kathat@microchip.com> (Ajay Kathat's
        message of "Wed, 25 Mar 2020 16:42:39 +0000")
Message-ID: <87v9mrpnjh.fsf@tynnyri.adurom.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<Ajay.Kathat@microchip.com> writes:

> From: Ajay Singh <ajay.kathat@microchip.com>
>
> Remove labels and not relevant property from DT binding documentation
> examples as suggested in [1].
>
> 1. https://patchwork.ozlabs.org/patch/1252837

Just a nitpick but patchwork links are not that reliable in the long
run. Instead using a lore link is better as the message id is visible
directly from the URL.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
