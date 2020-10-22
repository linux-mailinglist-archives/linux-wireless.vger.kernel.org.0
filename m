Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828902964A3
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Oct 2020 20:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368095AbgJVS1A (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Oct 2020 14:27:00 -0400
Received: from z5.mailgun.us ([104.130.96.5]:21658 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2900977AbgJVS1A (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Oct 2020 14:27:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1603391220; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Cu7ZTa+xQOns7SwIcrCbeXs+JUnsIByxQOyMwMvN+rU=; b=be+opnskJIouEbHoropSYG/+JUghlJscabuRX/XP92NtpAuR3BAsH1yf80GB/usn7+tdQN0b
 w9DJDH8Xggv2vmRU4e2sHm4rjbLmqbl0fSwtRlnjyaSAHP9AE11TQTpKynxrsb3XRXUSmt+o
 aLvv2Z1o39PE/4bIaECL26dIhT8=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f91ceda4f8cc67c31142f31 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 22 Oct 2020 18:26:34
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E25D9C433FF; Thu, 22 Oct 2020 18:26:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 27381C433C9;
        Thu, 22 Oct 2020 18:26:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 27381C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     "linux-firmware\@kernel.org" <linux-firmware@kernel.org>
Cc:     "linux-wireless\@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath11k\@lists.infradead.org" <ath11k@lists.infradead.org>,
        "ath10k\@lists.infradead.org" <ath10k@lists.infradead.org>
Subject: Re: [PULL] ath10k & ath11k firmware 20201022
References: <BYAPR02MB4567892AD5957F360C01E73F921D0@BYAPR02MB4567.namprd02.prod.outlook.com>
Date:   Thu, 22 Oct 2020 21:26:30 +0300
In-Reply-To: <BYAPR02MB4567892AD5957F360C01E73F921D0@BYAPR02MB4567.namprd02.prod.outlook.com>
        (Kalle Valo's message of "Thu, 22 Oct 2020 08:23:01 +0000")
Message-ID: <87sga65d7t.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@qca.qualcomm.com> writes:

> Hi linux-firmware maintainers,
>
> here's a pull request for ath10k and ath11k drivers. For ath10k there
> is a firmware for new hardware QCA6174 hw3.0 SDIO. For ath11k there
> are firmwares for new hardware IPQ8074 hw2.0, IPQ6018 hw1.0 and
> QCA6390 hw2.0. And also few updates for existing hardware.
>
> I did not include QCA9377 SDIO firmware as I saw Christian submitted a
> patch adding that.
>
> Please let me know if there are any problems.
>
> Kalle
>
> The following changes since commit 58d41d0facca2478d3e45f6321224361519aee96:
>
>   ice: Add comms package file for Intel E800 series driver (2020-10-05 08:09:03 -0400)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/linux-firmware.git ath10k-20201022

I noticed that ath11k Notice.txt files are not valid utf-8. Please drop
this pull request, I'll send a fixed one tomorrow.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
