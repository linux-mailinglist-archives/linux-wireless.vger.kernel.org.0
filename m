Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A672F69CB
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 19:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbhANSmh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 13:42:37 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:51452 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbhANSmh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 13:42:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610649731; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=esK39flRSIstDf/87OWrnB14zbc3ysHEqZPRuLUxmO0=; b=jqnMUjE610I/5sNziJQ3QNsqICQCSLXb5dWUVFQQn0CHgZsrnx5qEPknhQMfOmtsrUoTkHOX
 dgXpftJY/rRqqscBfiTLX05SMjUugKRCPLZcobHuYHRoNx0Iks9OQC4el8TvtKyjCDrkb5f4
 EehH5uUgI1fBqpZbIo+IhYwA/xc=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 6000906846a6c7cde77fd044 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 18:41:44
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86586C43462; Thu, 14 Jan 2021 18:41:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D090BC433CA;
        Thu, 14 Jan 2021 18:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D090BC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Ping-Ke Shih <pkshih@realtek.com>,
        Yan-Hsuan Chuang <tony0620emma@gmail.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        phhuang@realtek.com
Subject: Re: [PATCH RESEND v3 4/8] rtw88: replace tx tasklet with tx work
References: <20210114010950.3316-1-pkshih@realtek.com>
        <20210114010950.3316-5-pkshih@realtek.com>
        <CA+ASDXPy784XGyqV-EM2KF_=K58CG6fLdhieZSoxvpbfQC5rvg@mail.gmail.com>
Date:   Thu, 14 Jan 2021 20:41:37 +0200
In-Reply-To: <CA+ASDXPy784XGyqV-EM2KF_=K58CG6fLdhieZSoxvpbfQC5rvg@mail.gmail.com>
        (Brian Norris's message of "Thu, 14 Jan 2021 10:34:18 -0800")
Message-ID: <87eeingy3i.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Wed, Jan 13, 2021 at 5:45 PM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>
>> From: Po-Hao Huang <phhuang@realtek.com>
>>
>> Move tx tasklet to thread, by this we can reduce time spent on
>> waiting for schedule and have better efficiency.
>>
>> Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
>> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
>
> I'll note here for completeness: I suggested considering a workqueue
> on v2 (I hadn't yet received v3), and Realtek was planning on
> considering that.

A good point, thanks. I also think that reinventing the wheel should be
avoided and instead use existing workqueue framework.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
