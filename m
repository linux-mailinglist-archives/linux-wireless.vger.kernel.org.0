Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6CE598
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 16:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbfD2O7T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 10:59:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49990 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbfD2O7T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 10:59:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id C2A9F60741; Mon, 29 Apr 2019 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549958;
        bh=vSlMT+EoIY/OAuBhrigeLDJkHMwznLgATF4JPvlYlAo=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=lPLueDBikMl7Ex/ajXR2xFYimRrETZvs1LqTmDih4qYweFTRniJdscXrQ1jS5vK8O
         vwC9cIGotwZuawVEPXezQ35mnuotZKHB2z1WmZtZAXvYvHpHREY4U6bA1P7cBpR2qc
         6P9FR/xqFKNjV/d4rUCqdVO6phxoCwUObOQJMrp8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,MISSING_DATE,MISSING_MID autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 354496029B;
        Mon, 29 Apr 2019 14:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1556549958;
        bh=vSlMT+EoIY/OAuBhrigeLDJkHMwznLgATF4JPvlYlAo=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=VItJRSSPUm+4gioyjmhGc/AJP61zaI7BwqqEaqNTTFOwzfRn1PQ0iA3TC4Dbld1Nt
         5Fzj4mBA2I5ouIibVFbJJOO/LbOp00XHMhCyuec+5JPqMBU8b71rMwS9me2X+/08sO
         5qIe7JqgBDtcmrF1YwHGbOtUWyhX304snFVvuMzA=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 354496029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath: DFS JP domain W56 fixed pulse type 3 RADAR detection
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1551893771-22485-1-git-send-email-tamizhr@codeaurora.org>
References: <1551893771-22485-1-git-send-email-tamizhr@codeaurora.org>
To:     Tamizh chelvam <tamizhr@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>,
        Tamizh chelvam <tamizhr@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190429145918.C2A9F60741@smtp.codeaurora.org>
Date:   Mon, 29 Apr 2019 14:59:18 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tamizh chelvam <tamizhr@codeaurora.org> wrote:

> Increase pulse width range from 1-2usec to 0-4usec.
> During data traffic HW occasionally fails detecting radar pulses,
> so that SW cannot get enough radar reports to achieve the success rate.
> 
> Tested ath10k hw and fw:
> 	* QCA9888(10.4-3.5.1-00052)
> 	* QCA4019(10.4-3.2.1.1-00017)
> 	* QCA9984(10.4-3.6-00104)
> 	* QCA988X(10.2.4-1.0-00041)
> 
> Tested ath9k hw: AR9300
> 
> Tested-by: Tamizh chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

d8792393a783 ath: DFS JP domain W56 fixed pulse type 3 RADAR detection

-- 
https://patchwork.kernel.org/patch/10841487/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

