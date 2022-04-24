Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DDC50D008
	for <lists+linux-wireless@lfdr.de>; Sun, 24 Apr 2022 08:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238369AbiDXG1D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Apr 2022 02:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiDXG1A (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Apr 2022 02:27:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E02A17BF96
        for <linux-wireless@vger.kernel.org>; Sat, 23 Apr 2022 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1650781441; x=1682317441;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kKPFsit4rUYK7gNNds11XB+VuG/GjGDkpievrmyAjw8=;
  b=s57dneqiR4TY60fVXRmMyyPdfY6FvYOqQwnMuH24FGgjdfMIAAXvYcjY
   /28YigTRX6CtWN3CJJZuhahy+8Em2T99eWjt1QJ+dTt1qTFIvNA2Kt7ex
   ac2J//9lKdZEMEwSZ7pI/MyNaRyMBezYXS3OL739LL/F/A1A+Xlsk7NAA
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 23 Apr 2022 23:23:00 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 23:23:00 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 23:23:00 -0700
Received: from [10.253.9.110] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sat, 23 Apr
 2022 23:22:59 -0700
Message-ID: <61d2a5aa-c82d-6994-a8f3-0d31e32421be@quicinc.com>
Date:   Sun, 24 Apr 2022 14:22:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] ath11k: add read country code from SMBIOS for
 WCN6855/QCA6390
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20220421023501.32167-1-quic_wgong@quicinc.com>
 <8735i4m8hu.fsf@kernel.org>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <8735i4m8hu.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 4/23/2022 5:53 PM, Kalle Valo wrote:
> Wen Gong <quic_wgong@quicinc.com> writes:
>
>
...
>> +
>>   struct ath11k_smbios_bdf {
>>   	struct dmi_header hdr;
>> -	u32 padding;
>> +	u8 features_disabled;
>> +	/* enum ath11k_smbios_cc_type */
>> +	u8 country_code_flag;
>> +	/* To set specific country, you need to set country code
>> +	 * flag=ATH11K_SMBIOS_CC_ISO first, then if country is United States, then country
>> +	 * code value = 0x5553 ("US",'U' = 0x55, 'S'= 0x53), To set country
>> +	 * to INDONESIA, then country code value = 0x4944 ("IN", 'I'=0x49, 'D'=0x44).
>> +	 * If country code flag = ATH11K_SMBIOS_CC_WW, then you can use
>> +	 * worldwide regulatory setting.
>> +	 */
>> +	__le16 cc_code;
>>   	u8 bdf_enabled;
>>   	u8 bdf_ext[];
>> -};
>> +} __packed;
> Is cc_code really in little endian? I would expect data in smbios to be
> in native endian (ie. u16), bios using different endian than the host
> sounds strange to me. And struct dmi_header also uses native endian:
>
> struct dmi_header {
> 	u8 type;
> 	u8 length;
> 	u16 handle;
> } __packed;

Yes, Kalle,

I agree with you.

need I send new version to change the "__le16 cc_code" to "u16 cc_code"?

