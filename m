Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E2BFD6AD
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2019 08:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfKOHAI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Nov 2019 02:00:08 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfKOHAI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Nov 2019 02:00:08 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8EBEC60FCE; Fri, 15 Nov 2019 07:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573801207;
        bh=kaT7nSKljDVFGA31XHXafMtdN27FrNDDgjiJm3NuiFc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=YzgAfcx0EzdkvW3XXIEyzyV51+bdCs2O++GBx8eaR+G0ztmIKPpq4SL8waS999pyL
         SiDwHEGdKRmEN5qfUZcj03ZVJcscfIXTrgPiDmyPczaoHknJAXEYzqVkcvbjADZ/fL
         Dx4rxmhXk9Pkt/7myHsfwYxru63MQycQj23dRTf4=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 003FE602EE;
        Fri, 15 Nov 2019 07:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573801207;
        bh=kaT7nSKljDVFGA31XHXafMtdN27FrNDDgjiJm3NuiFc=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SmyHikiSDli7+CkNDJzDcWY1eVIUdMxYDQaf396kMb/KqSsZVt5TnspOejAWAE+Le
         3DFBsqWH9sassZV6PhlthH/HeZydJ0rE+DcE4x34TwzJEk5VyibyiSM6MATfKK24t0
         SuUMPLLNl/sbbw4IGQ76epzx1luYkncVOj5TrVz8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 003FE602EE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wcn36xx: fix typo
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191104061722.5379-1-eduardoabinader@gmail.com>
References: <20191104061722.5379-1-eduardoabinader@gmail.com>
To:     Eduardo Abinader <eduardoabinader@gmail.com>
Cc:     wcn36xx@lists.infradead.org,
        Eduardo Abinader <eduardoabinader@gmail.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191115070007.8EBEC60FCE@smtp.codeaurora.org>
Date:   Fri, 15 Nov 2019 07:00:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Eduardo Abinader <eduardoabinader@gmail.com> wrote:

> Signed-off-by: Eduardo Abinader <eduardoabinader@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

3c33a11a2913 wcn36xx: fix typo

-- 
https://patchwork.kernel.org/patch/11224961/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

