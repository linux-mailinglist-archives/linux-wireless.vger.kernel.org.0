Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873F4126363
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2019 14:26:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfLSN0F (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Dec 2019 08:26:05 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:60356 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726752AbfLSN0F (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Dec 2019 08:26:05 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576761964; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=0NkWaXjNVJPX2dUfkRTD8QKI9J6MTZv5tKvbm+RWy/c=; b=FRPBRK9F9JdMhyqIxiX2MelWJB8eT/pJbHSDN+ik7EVOANurBJvX57r8UDuufawf65m3YMWW
 D4uadqB9uNw+t4Aomp2PJ1VLghP0eQwCo6CBLgHid8HE2gJroWlhvCLCFr+B/LYaCZDvqNVG
 Yy5/hQaIyjzG9kQ0RrL629Gdbjc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfb7a68.7fc08d5b99d0-smtp-out-n01;
 Thu, 19 Dec 2019 13:26:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51F7AC433CB; Thu, 19 Dec 2019 13:25:59 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78C59C433A2;
        Thu, 19 Dec 2019 13:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78C59C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     vthiagar@codeaurora.org
Cc:     John Crispin <john@phrozen.org>,
        linux-wireless-owner@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [RESEND 6/9] ath11k: add debugfs for TWT debug calls
References: <20191204053713.3064-1-john@phrozen.org>
        <20191204053713.3064-7-john@phrozen.org>
        <0101016ecf7e75e3-b26c2edc-e278-4fbc-97d5-fc7f678c240f-000000@us-west-2.amazonses.com>
Date:   Thu, 19 Dec 2019 15:25:55 +0200
In-Reply-To: <0101016ecf7e75e3-b26c2edc-e278-4fbc-97d5-fc7f678c240f-000000@us-west-2.amazonses.com>
        (vthiagar@codeaurora.org's message of "Wed, 4 Dec 2019 06:00:03
        +0000")
Message-ID: <87eex078gs.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

vthiagar@codeaurora.org writes:

> On 2019-12-04 11:07, John Crispin wrote:
>> These new debugfs files allow us to manually add/del/pause/resume TWT
>> dialogs for test/debug purposes.
>>
>
> Information such as how these debugfs entries are supposed to be used
> could be helpful.

Yes, please always add instructions how the debugfs file is supposed to
be used. Not only it helps the users but makes the review easier as
well.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
