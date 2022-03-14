Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7F4D7FF1
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 11:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238595AbiCNKgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238098AbiCNKg3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 06:36:29 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F04B1A388
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 03:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647254120; x=1678790120;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cY7GWN7r9XYXXHS5uAvzO3nquuNRfXZRi/dw0vfXAeQ=;
  b=JDYt+ykwHTZ2beiq3aeKBtwcSe5UE2y6XaQTSddttTP5otC/aw56Gwx6
   4PdSfe/DUWqEt2LacoXEPc3K4M9Bi1DTgQp9vdAUhXk1abNa/E3KH9eoY
   cZoLdcl09gW7te52KasTyuL80NK1cOoMh0prKMFgE13AVIINCdcyxz1R0
   A=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Mar 2022 03:35:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:35:20 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:35:19 -0700
Received: from [10.253.10.5] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15; Mon, 14 Mar
 2022 03:35:18 -0700
Message-ID: <bb2a64ce-33f9-154c-faad-c5fbc70cd91c@quicinc.com>
Date:   Mon, 14 Mar 2022 18:35:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v5 2/2] ath11k: add read variant from SMBIOS for download
 board data
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211220064829.17557-1-quic_wgong@quicinc.com>
 <20211220064829.17557-3-quic_wgong@quicinc.com> <87wnh2ql8n.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <87wnh2ql8n.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/10/2022 4:12 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>> This is to read variant from SMBIOS such as read from DT, the variant
>> string will be used to one part of string which used to search board
>> data from board-2.bin.
>>
>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> [...]
>
>> +static void ath11k_core_check_bdfext(const struct dmi_header *hdr, void *data)
>> +{
>> +	struct ath11k_base *ab = data;
>> +	const char *bdf_ext;
>> +	const char *magic = ATH11K_SMBIOS_BDF_EXT_MAGIC;
>> +	u8 bdf_enabled;
>> +	int i;
>> +	size_t len;
>> +
>> +	if (ab->qmi.target.bdf_ext[0] != '\0')
>> +		return;
>> +
>> +	if (hdr->type != ATH11K_SMBIOS_BDF_EXT_TYPE)
>> +		return;
>> +
>> +	if (hdr->length != ATH11K_SMBIOS_BDF_EXT_LENGTH) {
>> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
>> +			   "wrong smbios bdf ext type length (%d).\n",
>> +			   hdr->length);
>> +		return;
>> +	}
>> +
>> +	bdf_enabled = *((u8 *)hdr + ATH11K_SMBIOS_BDF_EXT_OFFSET);
>> +	if (!bdf_enabled) {
>> +		ath11k_dbg(ab, ATH11K_DBG_BOOT, "bdf variant name not found.\n");
>> +		return;
>> +	}
>> +
>> +	/* Only one string exists (per spec) */
>> +	bdf_ext = (char *)hdr + hdr->length;
> A proper struct is preferred over pointer arithmetic. For example
> something like this:
>
> struct ath11k_smbios_bdf {
>          struct dmi_header hdr;
>          u32 padding;
>          u8 bdf_enabled;
>          u8 bdf_ext[ATH11K_SMBIOS_BDF_EXT_MAX_LEN];
> }
>
> I'm not sure if I got the offsets right, but I hope you get the idea
> anyway.
Will change it.
>> +
>> +	if (memcmp(bdf_ext, magic, strlen(magic)) != 0) {
>> +		ath11k_dbg(ab, ATH11K_DBG_BOOT,
>> +			   "bdf variant magic does not match.\n");
>> +		return;
>> +	}
>> +
>> +	len = strlen(bdf_ext);
> What if bdf_ext is not null terminated? Wouldn't strnlen() with
> ATH11K_SMBIOS_BDF_EXT_MAX_LEN would be safer?
Yes, will change it.
>
>> --- a/drivers/net/wireless/ath/ath11k/core.h
>> +++ b/drivers/net/wireless/ath/ath11k/core.h
>> @@ -971,7 +971,18 @@ int ath11k_core_fetch_bdf(struct ath11k_base *ath11k,
>>   			  struct ath11k_board_data *bd);
>>   void ath11k_core_free_bdf(struct ath11k_base *ab, struct ath11k_board_data *bd);
>>   int ath11k_core_check_dt(struct ath11k_base *ath11k);
>> +/* SMBIOS type containing Board Data File Name Extension */
>> +#define ATH11K_SMBIOS_BDF_EXT_TYPE 0xF8
>>   
>> +/* SMBIOS type structure length (excluding strings-set) */
>> +#define ATH11K_SMBIOS_BDF_EXT_LENGTH 0x9
>> +
>> +/* Offset pointing to Board Data File Name Extension */
>> +#define ATH11K_SMBIOS_BDF_EXT_OFFSET 0x8
>> +
>> +/* The magic used by QCA spec */
>> +#define ATH11K_SMBIOS_BDF_EXT_MAGIC "BDF_"
>> +int ath11k_core_check_smbios(struct ath11k_base *ab);
>>   void ath11k_core_halt(struct ath11k *ar);
>>   int ath11k_core_resume(struct ath11k_base *ab);
>>   int ath11k_core_suspend(struct ath11k_base *ab);
> Please don't mix defines and function declarations, so move defines up
> in the file.
Yes, will change it.
