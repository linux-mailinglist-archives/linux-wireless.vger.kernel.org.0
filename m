Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7A52F5B22
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 08:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhANHPt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 02:15:49 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:41931 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbhANHPs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 02:15:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610608524; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=ZSg3J0obu4mWcl7IU16U2O31KnnR49F5PT1Z49A0/DQ=; b=fg8abW5EOOvvriB1vw2hSwDTeMIeHPjZrG+O5/ypT8wlLPiJr4TRYPK5KZg4OkfgrRhKzVpN
 KA5K2ln0vnNNkIR4Ak4kc040PICd8gvyFrGfacP7nKAb717QeJm+I5dDRTcDRAWNLZTUT/qY
 A1DkfAx1YTRiGOxN6hA3/Joo2g4=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5fffef5e8fb3cda82fd0d140 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 14 Jan 2021 07:14:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7326C433C6; Thu, 14 Jan 2021 07:14:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C4628C433C6;
        Thu, 14 Jan 2021 07:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C4628C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "Coelho\, Luciano" <luciano.coelho@intel.com>
Cc:     "tiwai\@suse.de" <tiwai@suse.de>,
        "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/2] iwlwifi: dbg: Don't touch the tlv data
References: <20210112132449.22243-1-tiwai@suse.de>
        <20210112132449.22243-2-tiwai@suse.de> <87turmrw9j.fsf@codeaurora.org>
        <s5h5z42qh2w.wl-tiwai@suse.de>
        <3022a89080907456096ef137ffad525fa134b081.camel@intel.com>
Date:   Thu, 14 Jan 2021 09:14:33 +0200
In-Reply-To: <3022a89080907456096ef137ffad525fa134b081.camel@intel.com>
        (Luciano Coelho's message of "Tue, 12 Jan 2021 17:08:22 +0000")
Message-ID: <878s8wrnvq.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

"Coelho, Luciano" <luciano.coelho@intel.com> writes:

>> BTW, I thought network people don't want to have Cc-to-stable in the
>> patch, so I didn't put it by myself.  Is this rule still valid?
>
> In the wireless side of network, we've always used Cc stable when
> needed

Yeah, we handle stable patches differently from the main network tree.

> but the Fixes tag itself will almost always trigger the stable
> people to take it anyway.

BTW, this is now clarified in the documentation:

https://lkml.kernel.org/r/20210113163315.1331064-1-lee.jones@linaro.org

So cc stable should be added even if there's already a Fixes tag.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
