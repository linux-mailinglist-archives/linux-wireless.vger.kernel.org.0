Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B365EAB35
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 08:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfJaH7L (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 03:59:11 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40290 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfJaH7L (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 03:59:11 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 24E1D60930; Thu, 31 Oct 2019 07:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572508751;
        bh=K+P0WmOZtIxLVIqj6uP9thlwD4zxqpwuHAS3xWz18y8=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=a5Rfh3m8PdXSfaBIB0v0btKpQlnh0WqLGm6UjAnsdPfMMUCpnpchGl1WoC4KPBWwM
         eX1+BuJO7gAYQfv/7Mus53RPJ3QcFHDxE/x2AdV8Hs5z0UQZ5VB/HXThHXqm+jPpUN
         n1ssyA/yKYkch2/GAftAB4fJbDRXKeJ0WGu72Qo8=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 511CA6034E;
        Thu, 31 Oct 2019 07:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572508750;
        bh=K+P0WmOZtIxLVIqj6uP9thlwD4zxqpwuHAS3xWz18y8=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=l1DRo5olWy6bY7/MZWlCNnmC97O484gG5Y4v142jpfD5QGCiis/6vOj+zeBfLW/k8
         N7GarJ5yN4Su3QF4bpRw02iChYe840sgUG1F4By2CmoEHjDj5TEpHF/Qedls2CR41q
         hydeaEZXDPAstY78tZ+WRDg+Xa6UC5b1pq+CDOUA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 511CA6034E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/6] rtw88: use a module parameter to control LPS enter
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191025093345.22643-4-yhchuang@realtek.com>
References: <20191025093345.22643-4-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <g.schlmm@googlemail.com>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191031075911.24E1D60930@smtp.codeaurora.org>
Date:   Thu, 31 Oct 2019 07:59:11 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> If the number of packets is less than the LPS threshold, driver
> can then enter LPS mode.
> And driver used to take RTW_LPS_THRESHOLD as the threshold. As
> the macro can not be changed after compiled, use a parameter
> instead.
> 
> The larger of the threshold, the more traffic required to leave
> power save mode, responsive time could be longer, but also the
> power consumption could be lower.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
> Reviewed-by: Chris Chiu <chiu@endlessm.com>

I don't think a module parameter should be used to control power save
level, instead there should be a generic interface for that. Also the commit
log does not give any explanation why this needs to be a module parameter.

Tony, there's a high barrier for adding new module parameters. It's a common
phrase for me to say "module parameters are not windows .ini files". And to make it
easier for everyone always submit controversial patches separately, do not hide
within a bigger patchset.

-- 
https://patchwork.kernel.org/patch/11211881/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

