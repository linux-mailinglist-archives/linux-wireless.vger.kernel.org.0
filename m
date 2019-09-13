Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C050B22EC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Sep 2019 17:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390545AbfIMPEf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Sep 2019 11:04:35 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40800 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390365AbfIMPEf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Sep 2019 11:04:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 343F260770; Fri, 13 Sep 2019 15:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568387074;
        bh=AytpPB17RDte4mziVERFBXyIJYcxzsvfkAFRvf7T7qU=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=Cm4orovMrAvvzTGuKsmMIVqzlCl+gkZVFgxUS6XWJjtSpdGZ2r3JiepqVLIS+m4mT
         XZImTnCFneydpBBsdXqNyPjFjr3RRpJ5vKI65vMnlsKAKHnEIazSe7Cjh1J2lF73GJ
         TRNQv5JfULu+NJmSMg6LCr1/paNB0rCwe9FkMQ3c=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1102060452;
        Fri, 13 Sep 2019 15:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1568387073;
        bh=AytpPB17RDte4mziVERFBXyIJYcxzsvfkAFRvf7T7qU=;
        h=Subject:From:In-Reply-To:References:To:Cc:From;
        b=SgRokkREb2T0aumLTSysH9GorE3FTwD38NVTbHWMCmIAIR4oGBSyka1x/5vwHx9Mi
         s4R5kng6Rtvv0vDxUrq3K8u+TsxZa7n2ZuBlX0ty6LQBBaLXElKoDVloqTPpq6dl/m
         fplBYK+DaoedJSGC5UgxAGrvMNWsz/aAJYKYVq5E=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1102060452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/8] rtw88: 8822c: update PHY parameter to v38
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1568013371-21805-2-git-send-email-yhchuang@realtek.com>
References: <1568013371-21805-2-git-send-email-yhchuang@realtek.com>
To:     <yhchuang@realtek.com>
Cc:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20190913150434.343F260770@smtp.codeaurora.org>
Date:   Fri, 13 Sep 2019 15:04:34 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

<yhchuang@realtek.com> wrote:

> From: Yan-Hsuan Chuang <yhchuang@realtek.com>
> 
> Update PHY hardware parameters to v38.
> 
> Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>

8 patches applied to wireless-drivers-next.git, thanks.

8908a9c17a41 rtw88: 8822c: update PHY parameter to v38
dfcd0f58865b rtw88: 8822c: update pwr_seq to v13
bc61ae96437f rtw88: 8822c: Enable interrupt migration
1ac3294bf75e rtw88: 8822c: add FW IQK support
5227c2ee453d rtw88: 8822c: add SW DPK support
f27b886d0d06 rtw88: move IQK/DPK into phy_calibration
479c4ee931a6 rtw88: add dynamic cck pd mechanism
970cad9fb2a5 rtw88: allows to receive AMSDU in AMPDU

-- 
https://patchwork.kernel.org/patch/11137277/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

