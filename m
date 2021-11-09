Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9B5A44AAF6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Nov 2021 10:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245106AbhKIJya (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Nov 2021 04:54:30 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:41484 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241827AbhKIJyR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Nov 2021 04:54:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636451491; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=MmotNd5wfk0LxABbGhf1k4uc8MqGoHWhxl0N0+F4Wmk=;
 b=fXs/Clwsihm1+qoR91BqvJ9/BgVj3DWMKV0pZdtXDwMj0c90vnLmIQkb0fSjIE/2lmxfSFQp
 hZMaa8lk/ylJsI6xkRNmWiTcO42yyQke5oyjO7bBexKT4VD8XHxQidWepOzBuNzIbv2sEFuE
 5lNs9UP8E/U5d14B217OAYztJ1A=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 618a4494f6c5b6c8d5f821ce (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Nov 2021 09:51:16
 GMT
Sender: wgong=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id F1BCFC43150; Tue,  9 Nov 2021 09:51:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A69B6C4314B;
        Tue,  9 Nov 2021 09:51:13 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 09 Nov 2021 17:51:13 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: add string type to search board data in
 board-2.bin for WCN6855
In-Reply-To: <87mtmepz3z.fsf@codeaurora.org>
References: <20210913181131.194024-1-jouni@codeaurora.org>
 <87mtmepz3z.fsf@codeaurora.org>
Message-ID: <802a09c8fb8f284a2961f229353b9590@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-11-08 21:15, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
...
>> +	switch (ab->id.bdf_search) {
>> +	case ATH11K_BDF_SEARCH_BUS_AND_BOARD:
>> +		scnprintf(name, name_len,
>> +			  
>> "bus=%s,vendor=%04x,device=%04x,subsystem-vendor=%04x,subsystem-device=%04x,qmi-chip-id=%d,qmi-board-id=%d%s",
>> +			  ath11k_bus_str(ab->hif.bus),
>> +			  ab->id.vendor, ab->id.device,
>> +			  ab->id.subsystem_vendor,
>> +			  ab->id.subsystem_device,
>> +			  FIELD_GET(ATH11K_CHIP_ID_MASK, ab->qmi.target.chip_id),
>> +			  ab->qmi.target.board_id & 0xFF,
> 
> Why are chip_id and board_id masked? Why cannot we use values directly
> provided by the firmware?
> 
below is the log for WCN6855 2.0, its chip_id is 0x2 and board_id is 
0x106, but actually we need to
find the board data with chip-id=0 and board-id=6, so we add mask here.

[ 3000.176621] ath11k_pci 0000:05:00.0: chip_id 0x2 chip_family 0xb 
board_id 0x106 soc_id 0x400c0200
[ 3000.182361] ath11k_pci 0000:05:00.0: boot using board name 
'bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=3374,qmi-chip-id=0,qmi-board-id=6'

> And if we need to mask those, it's better to do them in qmi.c where 
> they
> are stored:
> 
Currenly logic of default: in ath11k_core_create_board_name() which is 
introduced in 1st commit
also use the chip_id and board_id, if mask them in qmi.c may effect the 
logic of ath11k_core_create_board_name().

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/drivers/net/wireless/ath/ath11k?h=ath-next&id=d5c65159f2895379e11ca13f62feabe93278985d
ath11k: driver for Qualcomm IEEE 802.11ax devices
+static int ath11k_core_create_board_name(struct ath11k_base *ab, char 
*name,
+					 size_t name_len)
+{
+	/* Note: bus is fixed to ahb. When other bus type supported,
+	 * make it to dynamic.
+	 */
+	scnprintf(name, name_len,
+		  "bus=ahb,qmi-chip-id=%d,qmi-board-id=%d",
+		  ab->qmi.target.chip_id,
+		  ab->qmi.target.board_id);
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot using board name '%s'\n", name);
+
+	return 0;
+}

another thing is that, other bits of chip_id/board_id maybe also need 
used by other place/feature, so we still need to
store the total original value of chip_id/board_id instead of mask it 
only for board data file.
Then user can easily get their own mask from chip_id/board_id.

> 	if (resp.chip_info_valid) {
> 		ab->qmi.target.chip_id = resp.chip_info.chip_id;
> 		ab->qmi.target.chip_family = resp.chip_info.chip_family;
> 	}
> 
> 	if (resp.board_info_valid)
> 		ab->qmi.target.board_id = resp.board_info.board_id;
> 	else
> 		ab->qmi.target.board_id = 0xFF;


