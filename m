Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78AC9A69EF
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbfICNf2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 09:35:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48240 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728094AbfICNf2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 09:35:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C703602CA; Tue,  3 Sep 2019 13:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517727;
        bh=Pmi6kQUMCrBKjf5WgQmoGmW6Qy0WBA7AmvZFx1TxLWk=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=HfXfWVqL323NpATbM8hIEYrKGu5GAfMs0pMCzPzRgYyxxQgm3ibKDDAxDPUUFXLca
         gxVY6KRwrkO8Smi6eUi4c4+7ipeshxIP4Hj037CokIPCsXZ+Pl2FAexyXbVvdvMaA+
         i1pcbqvSR4/BGLxBMvLkrhaUF2LPn16BIsS94uQU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A889602CA;
        Tue,  3 Sep 2019 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1567517727;
        bh=Pmi6kQUMCrBKjf5WgQmoGmW6Qy0WBA7AmvZFx1TxLWk=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=QvRHFeLJWus8KVZVDHnA2L8EJeYwGjxZCjdinOiMEBRVJpfj5draVhmOoe2DhKHF1
         6EImIWVPOG8aDrqf7c5rE6e4Ri9J8Lti0MSBEKbgEMW7aZ+LSEqBt6jtVfp7wmYFR6
         DpkCvw9tb0FS8vmZ/744hsovoZWN7IYvxRmkqK0Q=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A889602CA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] rtw88: Fix an error message
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20190814104642.GA14268@mwanda>
References: <20190814104642.GA14268@mwanda>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190903133527.9C703602CA@smtp.codeaurora.org>
Date:   Tue,  3 Sep 2019 13:35:27 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The WARN_ON() macro takes a condition, not a warning message.  I've
> changed this to use WARN() instead.
> 
> Fixes: 4136214f7c46 ("rtw88: add BT co-existence support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied to wireless-drivers-next.git, thanks.

52929cad3293 rtw88: Fix an error message

-- 
https://patchwork.kernel.org/patch/11093733/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

