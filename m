Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDE28314C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2019 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbfHFMZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Aug 2019 08:25:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbfHFMZq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Aug 2019 08:25:46 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3E5D460452; Tue,  6 Aug 2019 12:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094346;
        bh=nlFQIg/gVN0nwYqtpZP/7+7QfiDAEcVDq908uP/58+Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=XYT6KPkAc1Y4OuGaF93Wts5e3kBiE6qExY4hqUTItTZDx0+6XXNahNuMERDkJlrkn
         NX2bevJv8JpMSNtsgsflRP5gJp9y46kvl8kLm6XiOsvkxHbBnjtlt5ciIriZqdwiF8
         M/GzB7oHed7gTzTCcUEE7lQxa2k9JBaynarD6aXw=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F157608A5;
        Tue,  6 Aug 2019 12:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565094345;
        bh=nlFQIg/gVN0nwYqtpZP/7+7QfiDAEcVDq908uP/58+Y=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=T6XQFH4XqbX0ZOz/n8kdvEwuokYyf1j6+sNmHgR8aOzolBNeoouGXqJPuDevXN6OP
         Yz8nObbyyyxtR80Oo0EpVuwQVFmJuOOAb29PhMZzA+JEIacXSbOo/CaxrN1XJOv6Rp
         prv9t+kBBHRC2kIOHnqYddIIJGljwl/de9KFt2rw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F157608A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: Use dev_get_drvdata
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190723082918.21077-1-hslester96@gmail.com>
References: <20190723082918.21077-1-hslester96@gmail.com>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     unlisted-recipients:; (no To-header on input)
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Illegal-Object: Syntax error in Cc: address found on vger.kernel.org:
        Cc:     unlisted-recipients:; (no To-header on input)=?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
                                                                     ^-missing end of address
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190806122546.3E5D460452@smtp.codeaurora.org>
Date:   Tue,  6 Aug 2019 12:25:46 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Chuhong Yuan <hslester96@gmail.com> wrote:

> Instead of using to_pci_dev + pci_get_drvdata,
> use dev_get_drvdata to make code simpler.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

9236c1250cb7 bcma: Use dev_get_drvdata

-- 
https://patchwork.kernel.org/patch/11054111/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

