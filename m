Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF000418E6E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Sep 2021 06:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhI0ErX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Sep 2021 00:47:23 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13140 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232340AbhI0ErW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Sep 2021 00:47:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632717945; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=W7p3QXLDhHghk27urhivg8nixGDG0Pm9NPPoz9k5znU=;
 b=qnAfgufKBvyQx0OoewfbRhypmWZ6muk7aSq/L3qqHU9RRtyAL7sai4OXOPLberKQLWy+psZ2
 p8fy+iZuBZkvz7XXtFOd9pDreJWRWb0XBemxIlIlE2peePj2gMVGyv6vzk5iia8HIHwDpxF8
 hhbVMqFdQ8D9OyNB8GGxTY6b7pc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 61514bbd1abbf21d3485f050 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 27 Sep 2021 04:42:37
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 44417C43616; Mon, 27 Sep 2021 04:42:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A74C3C4338F;
        Mon, 27 Sep 2021 04:42:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Sep 2021 10:12:35 +0530
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] ath11k: add caldata download support from EEPROM
In-Reply-To: <875yuqrp4d.fsf@codeaurora.org>
References: <20210721201927.100369-1-jouni@codeaurora.org>
 <20210721201927.100369-5-jouni@codeaurora.org>
 <875yuqrp4d.fsf@codeaurora.org>
Message-ID: <53726bfd2c5d7911dc8433e7fd82d238@codeaurora.org>
X-Sender: akolli@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-24 20:34, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Anilkumar Kolli <akolli@codeaurora.org>
>> 
>> Firmware updates EEPROM support capability in QMI FW caps, send QMI 
>> BDF
>> download request message with file type EEPROM, to get caldata 
>> download
>> from EEPROM. Firmware takes more time to update cal data from EEPROM, 
>> so
>> increase QMI timeout.
> 
> The commit log would need more explanation how this patch works.
> 

FW advertizes calibration data support from EEPROM through 
'eeprom_read_timeout' in
QMI FW Capability message. Ath11k sends BDF download request with file 
type
'ATH11K_QMI_FILE_TYPE_EEPROM'. FW has logic to read calibration data 
from EEPROM and
process the calibration data. FW takes more time to process the 
calibration data from
EEPROM so increase QMI timeout to 10msec.

-- 
- Anil.
