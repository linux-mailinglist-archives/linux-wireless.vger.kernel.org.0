Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A032233238A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Mar 2021 12:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhCILB7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Mar 2021 06:01:59 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:17399 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229950AbhCILBx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Mar 2021 06:01:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615287713; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=mBSXofREaKzvR+6Hh7n1KKj4BbAqDDH/xii/W7+fGbo=;
 b=AUEmYWTIH744x2GXWb/Z5NsObTuK4zxBPgADnAqEaYhqLLDpb7L47eaNnmgRmrqpaVwOkyXf
 Y3755E2B+yKiPxWO6aUWbTGgA2HVmuz1oySwh+x06XEkSH5qlomztZxaf0kLupzKZVNnwspX
 k841zK7VekQiFQB3gL1umeiKyVY=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 60475591106ec1d9069b9149 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Mar 2021 11:01:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A462AC433ED; Tue,  9 Mar 2021 11:01:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 411B5C433C6;
        Tue,  9 Mar 2021 11:01:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 411B5C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Update signal filled flag during sta_statistics
 drv
 op
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210224090241.3098-1-srirrama@codeaurora.org>
References: <20210224090241.3098-1-srirrama@codeaurora.org>
To:     Sriram R <srirrama@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sriram R <srirrama@codeaurora.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210309110136.A462AC433ED@smtp.codeaurora.org>
Date:   Tue,  9 Mar 2021 11:01:36 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Sriram R <srirrama@codeaurora.org> wrote:

> Currently, though the peer rssi information is updated to station dump
> from driver sta_statistics mac op, the info doesn't get updated
> since the NL80211_STA_INFO_SIGNAL filled flag is not set in station
> info. Hence update this flag while filling the rssi info.
> 
> Tested on: IPQ8074 WLAN.HK.2.1.0.1-01213-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

f277eb0500b4 ath11k: Update signal filled flag during sta_statistics drv op

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210224090241.3098-1-srirrama@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

