Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF52F1831C4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Mar 2020 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCLNkY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Mar 2020 09:40:24 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:47056 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726571AbgCLNkY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Mar 2020 09:40:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584020423; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=d28xa1xEebWBphmMmajbYL+BZL5iOrK+edbC2qTbE5A=;
 b=vO7bq6yamjEdBRz7iRsu7kla5GIDliwr2Hki+LsAASTTnsSLOgHFwbDbxvvCwJLtQ77eoVc9
 u+UUmvofvEolbhrL1jEVhjuZil/KuSnCCDDWtkSSlmW4GArWM5DaNmDvwormTnjmVPxC1yFF
 tQXDHC3guYCGr7wXH2neoewG/+4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e6a3bb6.7f6465f4fea0-smtp-out-n01;
 Thu, 12 Mar 2020 13:40:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3DEAEC432C2; Thu, 12 Mar 2020 13:40:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 16E6CC433CB;
        Thu, 12 Mar 2020 13:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 16E6CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] rtw88: remove unused member of struct rtw_hal
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200214141645.GA26343@ns.kevlo.org>
References: <20200214141645.GA26343@ns.kevlo.org>
To:     Kevin Lo <kevlo@kevlo.org>
Cc:     Yan-Hsuan Chuang <yhchuang@realtek.com>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200312134005.3DEAEC432C2@smtp.codeaurora.org>
Date:   Thu, 12 Mar 2020 13:40:05 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kevin Lo <kevlo@kevlo.org> wrote:

> Remove unused fab_version member from struct rtw_hal.
> Some of the checks being made were nonsense.
> 
> Signed-off-by: Kevin Lo <kevlo@kevlo.org>

Patch applied to wireless-drivers-next.git, thanks.

90a39326f1d1 rtw88: remove unused member of struct rtw_hal

-- 
https://patchwork.kernel.org/patch/11382317/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
