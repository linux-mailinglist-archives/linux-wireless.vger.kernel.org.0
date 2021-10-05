Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE4E421E65
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 07:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbhJEFsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 01:48:55 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:37568 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbhJEFsy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 01:48:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633412824; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=tpR/uZLYExqObDmmqxiRbYu1CkA8GHJ5hA4/H1LVRkU=; b=tnbyPX5c0bBUroBuA3XC0vXiTH3uUS4+b3mBvtDiuEDinlkVIU+t6ZX4z/GQtXU8U7m+NS0q
 sSwKjO8Ux8qXkuGk1tuPKnhMXeVFxROmYaR2RNOVsQjOaiLT1kKp00nbJzxM2WQEJ225f+fd
 9q82YEnAQX5nUKx5hRK1ahWb/NM=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 615be6bfb62327f2cb7ca187 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 05:46:39
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 424EAC4360C; Tue,  5 Oct 2021 05:46:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97E37C4338F;
        Tue,  5 Oct 2021 05:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 97E37C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Ping-Ke Shih <pkshih@realtek.com>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v6 00/24] rtw89: add Realtek 802.11ax driver
References: <20210820043538.12424-1-pkshih@realtek.com>
        <8735pkiu0t.fsf@codeaurora.org>
        <7df9058b-4983-6d0e-07f7-8fe4df1cff27@lwfinger.net>
        <87y27chev0.fsf@codeaurora.org>
        <482cc641-7ba1-7d7a-f2eb-5d39aea9a5cd@lwfinger.net>
Date:   Tue, 05 Oct 2021 08:46:32 +0300
In-Reply-To: <482cc641-7ba1-7d7a-f2eb-5d39aea9a5cd@lwfinger.net> (Larry
        Finger's message of "Fri, 1 Oct 2021 12:18:36 -0500")
Message-ID: <87bl44gh1j.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Larry Finger <Larry.Finger@lwfinger.net> writes:

> On 10/1/21 11:46, Kalle Valo wrote:
>>
>> Nice, so I can assume there are quite a few users for this driver
>> already?
>>
>
> Yes. I do not know how many times the repo has been cloned or how many
> people are using it, but GitHub reports 31 forks of the driver, and
> 252 star ratings. The numbers are roughly comparable with those for my
> rtw88 repo.

Very good, plenty of testing then and most likely we are talking about
users in thousands. Too bad github doesn't provide statistics about
clones, that would be very interesting to know as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
