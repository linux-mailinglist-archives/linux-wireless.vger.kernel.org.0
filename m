Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A36725AB0D
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Sep 2020 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgIBMWn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Sep 2020 08:22:43 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15708 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726674AbgIBMWf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Sep 2020 08:22:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1599049355; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8WbKDeJ3PF8O3xWmTiGYTFKN799m8NupHcLuMv0ylRw=; b=mxX0q3sID69Nwopo3PQAs7Q39Uh2wzIppLdeaVQD2mhnJjnvfDGTcXfSqxkc8fNHYoZUaDBg
 Fg8jkQGmkvP4txU0MhPeCwlJFlewexI8aHJC+SYlG7c8g60jIqeCmKKwb+ac205B+m4pmzhY
 J77GSAaeMuJv3VphSyl2Gbaah2c=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f4f8e7a25e1ee75862522f8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Sep 2020 12:22:18
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 87197C433C6; Wed,  2 Sep 2020 12:22:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBD7BC433C9;
        Wed,  2 Sep 2020 12:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBD7BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        shawn.guo@linaro.org, loic.poulain@linaro.org
Subject: Re: [PATCH v2 03/10] wcn36xx: Add ieee802.11 VHT flags
References: <20200829033846.2167619-4-bryan.odonoghue@linaro.org>
        <20200902085545.5CC7EC433CA@smtp.codeaurora.org>
        <0b09678b-0966-09f1-7e83-252ad1bce25f@linaro.org>
Date:   Wed, 02 Sep 2020 15:22:15 +0300
In-Reply-To: <0b09678b-0966-09f1-7e83-252ad1bce25f@linaro.org> (Bryan
        O'Donoghue's message of "Wed, 2 Sep 2020 10:46:44 +0100")
Message-ID: <87pn744bd4.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Bryan O'Donoghue <bryan.odonoghue@linaro.org> writes:

> On 02/09/2020 09:55, Kalle Valo wrote:
>> Fails to apply. Please use ath.git master branch as the baseline.
>
> Oops, I did this on ath.git/pending

Yeah, using the pending branch is a bit risky as I can always drop or
change patches. The master branch is the best as there the sha1 ids are
stable and I can easily fix the conflicts with 3-way merge.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
