Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6819A412E6C
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Sep 2021 07:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhIUF6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Sep 2021 01:58:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:12918 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIUF6p (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Sep 2021 01:58:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632203837; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=orNVVNubHpfEVmr+2SE3Jqrd0OJbKJ5z52HgsjPQVXw=;
 b=SoaAE+LuXuVZF8y8FFaj7FClQyU2Cnc96wWwdNkgGwteO+S75DPxYtX6/r0qyNpq4YWWrtsx
 lyO5jHzrBFbXBp8uJoW0ssMxrgSXa9TT33ZTOHDn26LwKBeaOi3UyjAPuwzheScD8Bof34ey
 WVBrMRzhZzwQ6I3+cvHs8UpSMRU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 61497438ec62f57c9a76c852 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Sep 2021 05:57:12
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EDBFBC43460; Tue, 21 Sep 2021 05:57:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL autolearn=no autolearn_force=no
        version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E6BEC4338F;
        Tue, 21 Sep 2021 05:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 4E6BEC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] brcmfmac: fix incorrect error prints
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210901190641.255624-1-prestwoj@gmail.com>
References: <20210901190641.255624-1-prestwoj@gmail.com>
To:     James Prestwood <prestwoj@gmail.com>
Cc:     linux-wireless@vger.kernel.org,
        James Prestwood <prestwoj@gmail.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210921055711.EDBFBC43460@smtp.codeaurora.org>
Date:   Tue, 21 Sep 2021 05:57:11 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

James Prestwood <prestwoj@gmail.com> wrote:

> An unsupported AKM would end up printing "invalid cipher group". Instead
> print "invalid akm suite" with the offending AKM.
> 
> Signed-off-by: James Prestwood <prestwoj@gmail.com>

Patch applied to wireless-drivers-next.git, thanks.

beca6bd94da5 brcmfmac: fix incorrect error prints

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210901190641.255624-1-prestwoj@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

