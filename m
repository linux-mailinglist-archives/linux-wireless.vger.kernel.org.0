Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3786F41ABB8
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 11:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbhI1J0U (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 05:26:20 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:34155 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239708AbhI1J0S (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 05:26:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632821079; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8g1WmO4zsI0Qad1a7UPKfzGAjqJuKEOek2wPadV/g+g=; b=oSEgOStPTwnPwp4heu/VJbXR3wFHHgq30Bq7E2e+pspZwKfwJgMoTsRUVgwQXCcBDVk/btSQ
 9kBEZp8s6TxRdFgHLUlIxTGz1q9FfK0T9ZOSS+z02pCfjf/gP6PtXVg0/X1y2AfsWL1Mhz2V
 QmnQ22v/vWH4WSWtjYXnUNjVttQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 6152df4b713d5d6f96a30938 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 09:24:27
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70C56C4360D; Tue, 28 Sep 2021 09:24:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E3BFDC43460;
        Tue, 28 Sep 2021 09:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E3BFDC43460
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Anilkumar Kolli <akolli@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH 4/4] ath11k: add caldata download support from EEPROM
References: <20210721201927.100369-1-jouni@codeaurora.org>
        <20210721201927.100369-5-jouni@codeaurora.org>
        <875yuqrp4d.fsf@codeaurora.org>
        <53726bfd2c5d7911dc8433e7fd82d238@codeaurora.org>
Date:   Tue, 28 Sep 2021 12:24:22 +0300
In-Reply-To: <53726bfd2c5d7911dc8433e7fd82d238@codeaurora.org> (Anilkumar
        Kolli's message of "Mon, 27 Sep 2021 10:12:35 +0530")
Message-ID: <87ee99qchl.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Anilkumar Kolli <akolli@codeaurora.org> writes:

> On 2021-09-24 20:34, Kalle Valo wrote:
>> Jouni Malinen <jouni@codeaurora.org> writes:
>>
>>> From: Anilkumar Kolli <akolli@codeaurora.org>
>>>
>>> Firmware updates EEPROM support capability in QMI FW caps, send QMI
>>> BDF
>>> download request message with file type EEPROM, to get caldata
>>> download
>>> from EEPROM. Firmware takes more time to update cal data from
>>> EEPROM, so
>>> increase QMI timeout.
>>
>> The commit log would need more explanation how this patch works.
>>
>
> FW advertizes calibration data support from EEPROM through
> 'eeprom_read_timeout' in QMI FW Capability message. Ath11k sends BDF
> download request with file type 'ATH11K_QMI_FILE_TYPE_EEPROM'. FW has
> logic to read calibration data from EEPROM and process the calibration
> data. FW takes more time to process the calibration data from EEPROM
> so increase QMI timeout to 10msec.

Thanks, I now copied the updated commit log below. And do note that the
timeout is 10 s, not 10 ms.

    ath11k: add caldata download support from EEPROM
    
    In some devices the calibration data is stored to EEPROM within the device so add
    support for that.
    
    The firmware advertises the calibration data support from EEPROM through
    'eeprom_read_timeout' in the QMI firmware capability message. ath11k sends
    boardfile download request with file type 'ATH11K_QMI_FILE_TYPE_EEPROM'. The
    firmware has logic to read calibration data from EEPROM and process the
    calibration data.
    
    As now the firmware takes more time to process the calibration data from EEPROM
    so increase QMI timeout to 10 seconds.
    
    Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1


-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
