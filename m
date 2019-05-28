Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFC2C672
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2019 14:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfE1M1Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 May 2019 08:27:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36946 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbfE1M1X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 May 2019 08:27:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 3BE186086B; Tue, 28 May 2019 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046443;
        bh=N3jmxJi+uhRnOGW92vnSos4mY31DLekVphGfriyMTNU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=o/P+hLViduAsEODXgu1AYnwpau2ZZPBjDDT9e+BKv9uGJVEH2Xy8+8p0nnq8qi+MQ
         sQuzkXWFp2FmJnmWo8ZqMtf3uh9KGYb0eQNKMtSO9IfUTju6Mt0ptfsH7oZvWb/zVl
         jFMtV/yDtbwlX9+XtLZ3OofkkYTB14znIFmFQexg=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 646576034D;
        Tue, 28 May 2019 12:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559046443;
        bh=N3jmxJi+uhRnOGW92vnSos4mY31DLekVphGfriyMTNU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=JDh2Hr9bBNK16vM9q9kpqobb3UmdsjToIBlc6E7qUspmC8bwgAw3ZFgvATfvFvMUe
         MvngZIgE1o+xyXMk7p0US0qp0k65RlUG9jaFCOuVKZhAP6oPm/PgGphGD590Z8yhsU
         SWtszWDHXAjHVi9kZR3TIyggjC3wIS2MDd5wF3RY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 646576034D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] p54: Support boottime in scan results
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190524213308.18575-1-chunkeey@gmail.com>
References: <20190524213308.18575-1-chunkeey@gmail.com>
To:     Christian Lamparter <chunkeey@gmail.com>
Cc:     linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190528122723.3BE186086B@smtp.codeaurora.org>
Date:   Tue, 28 May 2019 12:27:23 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Christian Lamparter <chunkeey@gmail.com> wrote:

> This patch fixes an issue with wpa_supplicant dropping all scan
> results because their where considered to be "too old" (e.g.:
> "skip - scan result not recent enough (121056.086325 seconds too old)")
> which is very weird because this looks like that the scan results have
> been received before a scan started. This is due to the inaccuracy of
> the default timing mechanism for calculating the BSS entry age.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

c11c75ec784e p54: Support boottime in scan results

-- 
https://patchwork.kernel.org/patch/10960463/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

