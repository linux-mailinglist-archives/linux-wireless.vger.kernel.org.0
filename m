Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FC6319AE8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Feb 2021 08:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhBLHxd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Feb 2021 02:53:33 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:39681 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229497AbhBLHxa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Feb 2021 02:53:30 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613116387; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=NrvO2uppTHCR5JiceDu5hcB9OymX27G0NpYh5Q21lBg=;
 b=cz1e2W7dnKsvbZvilbWRqwMZYIq130L0NwPR2m9zQrft2+H7rs7qnHCoaftzBSxoR05tnU+9
 IbgzYKOp7rRnvN/HSp4H6UVqHPGq1XMAQNRjcoU3lP7/s3aev5RQC9OgWK2vB+lB+TiOjWVU
 AxYo4NoQaSKv2Ji3NtzNR9IAp34=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 602633b74bd23a05ae9323d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 07:52:23
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E69AFC433C6; Fri, 12 Feb 2021 07:52:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 55F53C433CA;
        Fri, 12 Feb 2021 07:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 55F53C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 1/8] rtw88: add dynamic rrsr configuration
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210209070755.23019-2-pkshih@realtek.com>
References: <20210209070755.23019-2-pkshih@realtek.com>
To:     Ping-Ke Shih <pkshih@realtek.com>
Cc:     <tony0620emma@gmail.com>, <linux-wireless@vger.kernel.org>,
        <phhuang@realtek.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20210212075222.E69AFC433C6@smtp.codeaurora.org>
Date:   Fri, 12 Feb 2021 07:52:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ping-Ke Shih <pkshih@realtek.com> wrote:

> From: Po-Hao Huang <phhuang@realtek.com>
> 
> Register rrsr determines the response rate we send.
> In field tests, using rate higher than current tx rate could lead
> to difficulty for the receiving end to receive management/control
> frames. Calculate current modulation level by tx rate then cross out
> rate higher than those.
> 
> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

8 patches applied to wireless-drivers-next.git, thanks.

4830872685f8 rtw88: add dynamic rrsr configuration
d77ddc34d731 rtw88: add rts condition
9e2fd29864c5 rtw88: add napi support
fe101716c7c9 rtw88: replace tx tasklet with work queue
9e27d4bf12ea rtw88: 8822c: update MAC/BB parameter tables to v60
0e5abd1172c9 rtw88: 8822c: update RF_A parameter tables to v60
6817cbdd9df7 rtw88: 8822c: update RF_B (1/2) parameter tables to v60
9d083348e938 rtw88: 8822c: update RF_B (2/2) parameter tables to v60

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210209070755.23019-2-pkshih@realtek.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

