Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0E5EF4255
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2019 09:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfKHInO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 Nov 2019 03:43:14 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37934 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbfKHInO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 Nov 2019 03:43:14 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 7525D60909; Fri,  8 Nov 2019 08:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573202593;
        bh=WhxqsAeTYD0pXN4EMoNIgBxzPCQEBMKIOLxKIgOLbAA=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=F8PidCTeRHs6r2a82OJ8jxiJWaPOA9Sjk1uSL6FIkOy1JRf2GiV7bVQIQH4QUr2rU
         7Fn8MiMHewIEqEATVyXzNHAf/Thx9kVexBMkicj3LWpuKIuV529D3zqZQ4609NkEJg
         zfSwzDyQBjWk3wfeHDYA4VaDkrv+4WdwT67/8Pno=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9389D60591;
        Fri,  8 Nov 2019 08:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573202593;
        bh=WhxqsAeTYD0pXN4EMoNIgBxzPCQEBMKIOLxKIgOLbAA=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=KVBp3Z0ClLJpDQb/mFEwiBgarsXC3yVQpBEC1XvbaBFL6ZlPb6S9gSGnm04YHEBZw
         yH5eekiQtOHoPKc4ZmqGbrKSeHbVOI8kmBCdUVTu+MFT/WCOSMktibJaFkwF2QuvD9
         +kz1sf+LnheShw+Q7nXqyP0YOgkkSyNjENnoQVVY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9389D60591
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: fix get invalid tx rate for Mesh metric
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1572329537-27728-1-git-send-email-miaoqing@codeaurora.org>
References: <1572329537-27728-1-git-send-email-miaoqing@codeaurora.org>
To:     Miaoqing Pan <miaoqing@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>,
        Hou Bao Hou <houbao@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191108084313.7525D60909@smtp.codeaurora.org>
Date:   Fri,  8 Nov 2019 08:43:13 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Miaoqing Pan <miaoqing@codeaurora.org> wrote:

> ath10k does not provide transmit rate info per MSDU
> in tx completion, mark that as -1 so mac80211
> will ignore the rates. This fixes mac80211 update Mesh
> link metric with invalid transmit rate info.
> 
> Tested HW: QCA9984
> Tested FW: 10.4-3.9.0.2-00035
> 
> Signed-off-by: Hou Bao Hou <houbao@codeaurora.org>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

05a11003a565 ath10k: fix get invalid tx rate for Mesh metric

-- 
https://patchwork.kernel.org/patch/11217003/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

