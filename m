Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5AC322C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Oct 2019 13:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbfJALPm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 07:15:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57066 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbfJALPm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 07:15:42 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6504060790; Tue,  1 Oct 2019 11:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928541;
        bh=1iaNgMpqvf1SlTf13O5y/DXKAT+h8Zcuc4V/7Zi8Qnk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=W2gTtpuI/EmV/TGNvNTJIH1QQ5sa9qE1HmbYTwkmbDN0EmcMR/yXMD+Y+DYl+rFxK
         Qn8w7RGDayTGXhqLJD+upmHcwarqHVMsDhtzxS7Vve+8ZDZ+OTnXcYVNG0tYPR5Rsd
         pCGlMxUk+K1wGYmGAjz2Zchp4iCGIBaMRojahP+k=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 04EDB6014B;
        Tue,  1 Oct 2019 11:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1569928540;
        bh=1iaNgMpqvf1SlTf13O5y/DXKAT+h8Zcuc4V/7Zi8Qnk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=R7Qr3Iyk3i8/C0xvBZKoF/wMxZxYX/DtHeGwBEyZ22xqlLRaB5990OxQPbEmwtM/c
         MdjOOu8T9f1Z4axYbNde9rkNNKs+5EjwzCGM9ZRkCE+/VYsl5qf2uZnhomsaMjPUVN
         Qp6iXzhMGKI1f233CUEcGNi4ArJGJVVaTxM6b89E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 04EDB6014B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] ath10k: add 2ghz channel arguments to service ready
 structure
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
References: <1569268165-1639-1-git-send-email-pozega.tomislav@gmail.com>
To:     =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191001111541.6504060790@smtp.codeaurora.org>
Date:   Tue,  1 Oct 2019 11:15:41 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tomislav Požega wrote:

> Add lowest/highest 2ghz channel arguments for use within WMI service
> ready structure.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

4 patches applied to ath-next branch of ath.git, thanks.

fa879490e412 ath10k: add 2ghz channel arguments to service ready structure
275ea1b26f38 ath10k: print service ready returned channel range
73690c4843fb ath10k: print supported MCS rates within service ready event
7b3087323faa ath10k: change sw version print format to hex

-- 
https://patchwork.kernel.org/patch/11157519/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

