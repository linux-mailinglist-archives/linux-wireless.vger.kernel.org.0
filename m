Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772EC422A40
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Oct 2021 16:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236494AbhJEOKA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Oct 2021 10:10:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:64894 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbhJEOJ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Oct 2021 10:09:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1633442832; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=Jg3m/g25bkbWNO+TyC8tvVbjrTAyib8vW1P1iQJqXDQ=; b=wvDpwTmGN/dNMrtiTSE5c7SwRMolLSUuREJJtSBsUEPd8enupWwqXXNuBesqPkh/UuWOG03x
 ZeB9rlwvUAopfTPkW5TwMnk1zbzn6zXcNoMYqmlWKUuDSnZELgUR/90o4UWPCk5XmZLCigoQ
 bKtWYyf7pj7GrcD44SZ29aMAo4U=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 615c5bd709ab553889b53350 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 05 Oct 2021 14:06:15
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 60B48C4360C; Tue,  5 Oct 2021 14:06:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82AE6C43460;
        Tue,  5 Oct 2021 14:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 82AE6C43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     bqiang@codeaurora.org
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 1/3] ath11k: Change number of TCL rings to one for QCA6390
References: <20210914163726.38604-1-jouni@codeaurora.org>
        <87tui4pwdz.fsf@codeaurora.org>
        <42fa097a799050100b6978ef0ab4e8b8@codeaurora.org>
Date:   Tue, 05 Oct 2021 17:06:09 +0300
In-Reply-To: <42fa097a799050100b6978ef0ab4e8b8@codeaurora.org> (bqiang's
        message of "Wed, 29 Sep 2021 10:15:45 +0800")
Message-ID: <87ee8zftwu.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bqiang@codeaurora.org writes:

> On 2021-09-28 23:12, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>
>>> From: Baochen Qiang <bqiang@codeaurora.org>
>>>
>>> Some targets, QCA6390 for example, use only one TCL ring,
>>> it is better to initialize only one ring and leave others
>>> untouched for such targets.
>>>
>>> Tested-on: QCA6390 hw2.0 PCI
>>> WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>>>
>>> Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
>>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>>
>> It's better? Please be more specific. Does this fix a bug or is this
>> just a theoretical fix you found during code review?
>
> Yes, this is just a theoretical fix. By "better" I mean there is no
> need to initialize
> the other two TCL rings for QCA6390 since they are not used.

Thanks, I changed the commit log now to this:

    ath11k: Change number of TCL rings to one for QCA6390
    
    Some targets, QCA6390 for example, use only one TCL ring, it is better to
    initialize only one ring and leave others untouched for such targets.
    
    This is a theoretical fix found during code review, no visible impact.
    
    Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
