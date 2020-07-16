Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E220F221CB4
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jul 2020 08:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGPGjG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Jul 2020 02:39:06 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:20902 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728183AbgGPGjF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Jul 2020 02:39:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594881545; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=URyxVwFZr3AjejW+Og0G6Nd4XGb+XQV7xYYxmN1mO6Q=; b=XaIsWnSDts174HU/+AT9Xhzr4GXWWdlwr3mEaATka72uk2wv62QbaFjNEk+8KiD+htdLkfK1
 9s953qHYyHR21RT7nLIbi++CknQ7a1f08X4QcTVw/GllEWmJ6Bhx51jn7zglkyXHxMWtSekS
 nEcpq8xJ2r93O6Ykgj09IZZ69Gc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5f0ff5ed8423214e130cc0d4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 16 Jul 2020 06:38:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9081EC43391; Thu, 16 Jul 2020 06:38:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8401FC433CA;
        Thu, 16 Jul 2020 06:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8401FC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        ath10k <ath10k@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ath10k: Add interrupt summary based CE processing
References: <1593193967-29897-1-git-send-email-pillair@codeaurora.org>
        <CAD=FV=V_ynwukeR92nbJXkuQ7OAW4mLaTjxko7fXt5aEfDUNhA@mail.gmail.com>
        <CAD=FV=XJDmGbEJQ1U-VDuN2p0+V+uRm_1=DwBnDPmPQsXqS4ZA@mail.gmail.com>
        <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
Date:   Thu, 16 Jul 2020 09:38:32 +0300
In-Reply-To: <CA+ASDXNOCFZhdNMDk9XTuC2H+owQ0+wHipDbkJAGnU9q7BXz_w@mail.gmail.com>
        (Brian Norris's message of "Fri, 26 Jun 2020 14:52:30 -0700")
Message-ID: <871rlcx8uv.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Brian Norris <briannorris@chromium.org> writes:

> On Fri, Jun 26, 2020 at 2:49 PM Doug Anderson <dianders@chromium.org> wrote:
>> I should also note that, while I'm not terribly familiar with Kalle's
>> workflow, I would have expected to see him in the "To:" list.  I've
>> added him, but it's possible he'll need you to repost the patch with
>> him in the "To:" list.
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches#who_to_address
> https://wireless.wiki.kernel.org/en/users/drivers/ath10k/submittingpatches
>
> Patchwork is his patch queue, so I don't think you need to address him directly.

Yup, I take all patches from patchwork so no need to Cc me.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
