Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0E3FD5DA7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2019 10:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbfJNIjt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Oct 2019 04:39:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37938 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbfJNIjt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Oct 2019 04:39:49 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 822EF6074F; Mon, 14 Oct 2019 08:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571042384;
        bh=3pmd2/Dg2zjuK4TND60bIyRKaMBttWSoVmjkAXloajk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=m91MrAjwNfhomQ06Y8rG621sPLYdAx9LvcxGhREHQhpt/IxFMR6/rHlrY1qNglgGO
         EqwlyD1w/5HCINIfvdLUGyq1Vi6NEf1tSNW7PgWodeJKWlvLExuyzAgxRex0JAze42
         YqiocEJe5CMjG1y0+iUL1VYk/FhZwvgaGhuwTurg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BCFCD601E7;
        Mon, 14 Oct 2019 08:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571042383;
        bh=3pmd2/Dg2zjuK4TND60bIyRKaMBttWSoVmjkAXloajk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=U8uk+O+dLlnNFiAc9iOrZaA4D6Hi/SSigRV099puvznMY+eC7qKJpPw5dh7HTru5c
         1pfM3FxC1as/ZKRD9g3fv1ap5RQti88XLDrwQrrXiOqebHpowXT7cCOsY0G0TPjTps
         hY+2G9JW+OJoRCD20tJAedcfR+V4rvu620IPY6lE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BCFCD601E7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath: rename regulatory rules
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1570740795-12522-1-git-send-email-pozega.tomislav@gmail.com>
References: <1570740795-12522-1-git-send-email-pozega.tomislav@gmail.com>
To:     =?utf-8?q?Tomislav_Po=C5=BEega?= <pozega.tomislav@gmail.com>
Cc:     linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191014083944.822EF6074F@smtp.codeaurora.org>
Date:   Mon, 14 Oct 2019 08:39:44 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Tomislav Požega wrote:

> Regulatory rule defines in regd.c are used not only by ath9k but also
> ath10k driver (haven't test other drivers) and thus should be
> renamed from ATH9K* to ATH*.
> 
> Signed-off-by: Tomislav Požega <pozega.tomislav@gmail.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f433abfc2f76 ath: rename regulatory rules

-- 
https://patchwork.kernel.org/patch/11184439/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

