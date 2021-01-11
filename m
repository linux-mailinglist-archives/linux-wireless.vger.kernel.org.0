Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2824F2F1175
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jan 2021 12:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729781AbhAKL1z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Jan 2021 06:27:55 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:31569 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729771AbhAKL1y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Jan 2021 06:27:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1610364455; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=lVOR0bCfXd+aa/JLPYQU2BSap426WSyvOAm4RkmdGMk=; b=Z9BhoFlQlSTL8/EiRpH6NN6lxqWPDSfSyhA2hiYGSBkrldvm7P2N+d7C/AqzaGQ1HxNRr91a
 xkhSrv0+BNmtsk+Jv+OJUKAdqy/1w4iZoZjXBeRIiQTGt7cv3nQUQbuujlzWKYuY91+orfeR
 RQPVHR5LitkAtP+D5QP+2zzZZhI=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ffc360c415a6293c571da1e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 11 Jan 2021 11:27:08
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 18A00C43461; Mon, 11 Jan 2021 11:27:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C8B7C433C6;
        Mon, 11 Jan 2021 11:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C8B7C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     kernel test robot <lkp@intel.com>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, kbuild-all@lists.01.org,
        shawn.guo@linaro.org, benl@squareup.com, loic.poulain@linaro.org
Subject: Re: [PATCH 06/13] wcn36xx: Add ipv6 namespace offload in suspend
References: <20201228162839.369156-7-bryan.odonoghue@linaro.org>
        <202012290547.6ryYf96B-lkp@intel.com>
        <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org>
Date:   Mon, 11 Jan 2021 13:27:03 +0200
In-Reply-To: <bcf6adbc-e03a-6f02-e55f-6e0b738806fd@linaro.org> (Bryan
        O'Donoghue's message of "Tue, 29 Dec 2020 02:15:04 +0000")
Message-ID: <878s8zlnnc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 28/12/2020 21:49, kernel test robot wrote:
>> [auto build test ERROR on wireless-drivers-next/master]
>
> hmm
>
> works against this
>
> * 77da2c99eca0 - (tag: ath-202012180905, ath.git/master) Add
> localversion-wireless-testing-ath (11 days ago)

The bot tested only ath-next from ath.git, not the master branch:

[auto build test ERROR on wireless-drivers-next/master]
[also build test ERROR on wireless-drivers/master ath6kl/ath-next v5.11-rc1 next-20201223]

I'm guessing that this build error is due to some API changes in
net-next. I'm planning to update ath.git tree today to v5.11, hopefully
that clears up the issue.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
