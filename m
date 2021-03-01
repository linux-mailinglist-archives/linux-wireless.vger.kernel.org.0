Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9CA93279D7
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 09:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhCAIrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 03:47:33 -0500
Received: from z11.mailgun.us ([104.130.96.11]:38902 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233479AbhCAIqp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 03:46:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614588371; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=O3yhFBjQe0kRff0bAX1BbX9HwQn6+fCi8LLDaatQMAw=; b=D6uDlw0FzOZq0b0LcoEV+zxkinvh2JqpE/jaIZwrBAhSjgwvgAn01tqBd1PvAMxtbdt1fIPE
 yVGKWWOop6F4Sa2ldutuwJwomJxFWWk2wu0rIyC3S6yD1RWiW467/a42aJ/eT5cvdOaChwgh
 5w+W9MqEWxEPAeKdIKM8j4Jgwd0=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 603ca9b216ba745201a067fb (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Mar 2021 08:45:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29C02C43466; Mon,  1 Mar 2021 08:45:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CD2AC433C6;
        Mon,  1 Mar 2021 08:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CD2AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, mingo@redhat.com, kuba@kernel.org,
        will@kernel.org, davem@davemloft.net
Subject: Re: [PATCH v3 0/3] Add lockdep_assert_not_held()
References: <cover.1614383025.git.skhan@linuxfoundation.org>
        <YDyn+6N6EfgWJ5GV@hirez.programming.kicks-ass.net>
Date:   Mon, 01 Mar 2021 10:45:32 +0200
In-Reply-To: <YDyn+6N6EfgWJ5GV@hirez.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Mon, 1 Mar 2021 09:38:19 +0100")
Message-ID: <878s779s9f.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Fri, Feb 26, 2021 at 05:06:57PM -0700, Shuah Khan wrote:
>> Shuah Khan (3):
>>   lockdep: add lockdep_assert_not_held()
>>   lockdep: add lockdep lock state defines
>>   ath10k: detect conf_mutex held ath10k_drain_tx() calls
>
> Thanks!

Via which tree should these go?

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
