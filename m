Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A849C12777C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2019 09:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfLTIs5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Dec 2019 03:48:57 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:12669 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727174AbfLTIs5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Dec 2019 03:48:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576831736; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=GgfymSp4WXJavxzZ/gU/V2dOSz8ELQUdgDkVM3WpurY=; b=eq9ods00xVRzuhI//VH8Ifi8dpJUT/ify5kb60GhAVtuGBXDw5TpzUiV0y54pWFkcf1RIvJR
 MgxTiwplwGQJ/tPLldtncW1j+Lffo4JCS7RBv5XP5C7MxCJhQhM23r5wOYRSJRt79eBYtps5
 p0J9kZbAShnBvKzawPiuuwl6ydQ=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfc8af3.7f6b64ac8ea0-smtp-out-n03;
 Fri, 20 Dec 2019 08:48:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91266C433A2; Fri, 20 Dec 2019 08:48:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9805C43383;
        Fri, 20 Dec 2019 08:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9805C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     John Crispin <john@phrozen.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Wireless <linux-wireless@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: Re: linux-next: Fixes tag needs some work in the wireless-drivers tree
References: <20191220075337.789971fe@canb.auug.org.au>
        <739b70e9-6a77-9d4e-2331-16022325cd34@phrozen.org>
Date:   Fri, 20 Dec 2019 10:48:45 +0200
In-Reply-To: <739b70e9-6a77-9d4e-2331-16022325cd34@phrozen.org> (John
        Crispin's message of "Thu, 19 Dec 2019 21:55:32 +0100")
Message-ID: <87y2v72xhu.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

John Crispin <john@phrozen.org> writes:

> On 19/12/2019 21:53, Stephen Rothwell wrote:
>> Hi all,
>>
>> In commit
>>
>>    485add35771b ("ath11k: fix pdev when invoking ath11k_wmi_send_twt_enable_cmd()")
>>
>> Fixes tag
>>
>>    Fixes: e65a616f4e74 ("ath11k: add TWT support")
>>
>> has these problem(s):
>>
>>    - Target SHA1 does not exist
>>
>> Did you mean
>>
>> Fixes: 6d293d447670 ("ath11k: add TWT support")
>>
>
> My bad, sorry, I was sitting on an old tree apparently.

And I didn't catch it either. I try to avoid rebasing my trees so I'm
not planning fix this, let's just avoid this in the future.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
