Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D0A1262B4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 13:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLSMz1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 07:55:27 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29920 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbfLSMz0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 07:55:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576760126; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=pcpQR5Y6NXIAKYzjTBF5uYO7m2wC4b4uGvao0dePeLk=;
 b=bKK/HYoSYSKi6lo00eei1FhAkM2u2puq46gU5EjJ0dyDjCBd4kgHfFk2J5FrBwIsoPoKwQbd
 DKsL59fXIBxh4Z7NyafSdGw+Il3UohjDwyzau/McuyIRQtq6LMfzQfJGVwU6VMw7BI+B0FcQ
 W1qLjVRVfOnKaltcQQvKDOpV9ds=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb733b.7f43042ee730-smtp-out-n03;
 Thu, 19 Dec 2019 12:55:23 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2E2D8C447A3; Thu, 19 Dec 2019 12:55:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 57039C433A2;
        Thu, 19 Dec 2019 12:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57039C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] MAINTAINERS: change Gruszka's email address
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191219093559.GB14003@wp.pl>
References: <20191219093559.GB14003@wp.pl>
To:     Stanislaw Gruszka <stf_xl@wp.pl>
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        Daniel Golle <daniel@makrotopia.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191219125523.2E2D8C447A3@smtp.codeaurora.org>
Date:   Thu, 19 Dec 2019 12:55:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stanislaw Gruszka <stf_xl@wp.pl> wrote:

> My RedHat email address does not work any longer. Change to my private one.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>

Patch applied to wireless-drivers.git, thanks.

33328bfab892 MAINTAINERS: change Gruszka's email address

-- 
https://patchwork.kernel.org/patch/11302927/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
