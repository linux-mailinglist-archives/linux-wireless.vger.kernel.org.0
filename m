Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554CE2C8605
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 14:57:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgK3N4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 08:56:25 -0500
Received: from z5.mailgun.us ([104.130.96.5]:18945 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgK3N4Y (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:24 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606744564; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=4ODmtDjeDdSdLODLuNoVpFCsh5S1HRcxsNTB8FKizWY=;
 b=pi5q3BubzlIN7SAEUoZnrk3h8hfk8l+SWtdCTwll2NikI0Sxrso44bqOf6u822gtpT+hmvUa
 ovNuVN4RA1iB5ghJpBvAQintH91pu/xR7oers7o0RkVw6BD0JE1kbAaD/DPX6/4NJrJvERmf
 NY1JgQsI19qG9sSDEThBHlp78mU=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fc4f9caa5a29b56a1b7379e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 30 Nov 2020 13:55:22
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 73A3CC43461; Mon, 30 Nov 2020 13:55:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CB3FDC433C6;
        Mon, 30 Nov 2020 13:55:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 30 Nov 2020 19:25:21 +0530
From:   akolli@codeaurora.org
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2] ath11k: fix rmmod failure if qmi sequence fails
In-Reply-To: <87mtz5pm8a.fsf@codeaurora.org>
References: <1605076699-21924-1-git-send-email-akolli@codeaurora.org>
 <87mtz5pm8a.fsf@codeaurora.org>
Message-ID: <013d9ee1c0f88863013f2672b6b2197a@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-25 19:33, Kalle Valo wrote:
> Anilkumar Kolli <akolli@codeaurora.org> writes:
> 
>> QMI sequence fails if caldata file is not available.
>> It is observed that 'rmmod ath11k' fails if qmi message fails.
>> With this patch rmmod/insmod is working.
>> 
>> Logs:
>> Direct firmware load for IPQ8074/caldata.bin failed with error -2
>> Falling back to user helper
>> qmi failed to load CAL: IPQ8074/caldata.bin
>> qmi failed to load board data file:-11
>> 
>> Tested-on: IPQ8074 hw2.0 AHB 
>> WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> 
> With this patch reloading ath11k (which has worked fine before) crashes
> the kernel on QCA6390 hw2.0:
> 
> Nov 25 16:00:52 nuc1 [  393.188277] BUG: unable to handle page fault
> for address: ffffffffc05b8e38
> Nov 25 16:00:52 nuc1 [  393.188300] #PF: supervisor read access in 
> kernel mode
> Nov 25 16:00:52 nuc1 [  393.188312] #PF: error_code(0x0000) - 
> not-present page

I will test this in QCA6390 and update.
Which branch should I use for testing. master or ath11k-qca6390-bringup 
?

Thanks
Anil
