Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09C33A813E
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Jun 2021 15:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhFONrd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Jun 2021 09:47:33 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64423 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230305AbhFONra (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Jun 2021 09:47:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623764726; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=scxrBwWGr3JyMxv75SuwLWPc8G0Nv56Ryje1L/Thbro=; b=pinsSxrI2+uqcpkxilA1UL780/Dwk3J8NZDpB4js5rFUQwhiOCsprhT+17u4+EBnAbEIy/3c
 Kskxk/Ws+55kfug+cBb64VKfvbTF0B1EpgZ5iaJKBPQ6MyI8h37zFNnMtBXdJWP0qTMGN5aJ
 2aOyqP+fS/2gH5JVwu9P2S5rnGg=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 60c8aeee2eaeb98b5efa464e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Jun 2021 13:45:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1740CC43217; Tue, 15 Jun 2021 13:45:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0503C433D3;
        Tue, 15 Jun 2021 13:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0503C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Arend van Spriel <aspriel@gmail.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>,
        Hans deGoede <hdegoede@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] brcmfmac: fix a loop exit condition
References: <YIKzmoMiTdToaIyP@mwanda>
        <20210615102656.DBB04C43143@smtp.codeaurora.org>
        <20210615125259.GB1901@kadam>
Date:   Tue, 15 Jun 2021 16:45:11 +0300
In-Reply-To: <20210615125259.GB1901@kadam> (Dan Carpenter's message of "Tue,
        15 Jun 2021 15:52:59 +0300")
Message-ID: <875yyfjl7c.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Tue, Jun 15, 2021 at 10:26:56AM +0000, Kalle Valo wrote:
>> Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> 
>> > This code is supposed to loop over the whole board_type[] string.  The
>> > current code kind of works just because ascii values start 97 and the
>> > string is likely shorter than that so it will break when we hit the NUL
>> > terminator.  But really the condition should be "i < len" instead of
>> > "i < board_type[i]".
>> > 
>> > Fixes: 29e354ebeeec ("brcmfmac: Transform compatible string for FW loading")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> > Reviewed-by: Matthias Brugger <mbrugger@suse.com>
>> 
>> There was talk about v2, but I don't see it in the patchwork.
>
> Ah, crap.  I started to debug Smatch to find out why it wasn't warning
> about some of these bugs and I got a bit carried away writing Smatch
> code and forgot to come back to this.
>
> I will send it tomorrow.

No worries, take your time :) I just wanted to remind about this, or see
if patchwork or the mailing list have lost patches again (which has
happened in the past).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
