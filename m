Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4704A7AD653
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 12:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjIYKqx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Sep 2023 06:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIYKqw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Sep 2023 06:46:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55B5A3
        for <linux-wireless@vger.kernel.org>; Mon, 25 Sep 2023 03:46:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38PARxTP020579;
        Mon, 25 Sep 2023 10:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NIdPdbnvJfJEYbUcscur2aVMLJmMMeL0hQsOcreDeYQ=;
 b=bz/XcSj/6fkxvXBdmqY79L8GD7mcbiE9FvqcsXp4XBhp18eoMzUHc2FXdJ/pYP6Xcqw8
 y1UR9wd5oezIrPAcC0aeWtoniosL4v4bZ7ThMuzaFd9ZIqfTp2hMrVFZtvpTZ5NJ7QY9
 KGr1rR9OB0TlmniGyrHD+4CP5aqyLAVxpyN+YmodZeiieMMR02Viw2YIbPGEw+ubV092
 s9AFLPHC94UxsD5zK8RIM4OCLmG2VAQliCAgcFMP6unW3Jy+3cQI2teapnNrFYwQT6k1
 5Z8WLZ3DqLagUInnwllHZ2I7ci9S+p1N20mm8QHCpvQVTGh532q33sN54oSE1Irw0ib7 lw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tb6tt06wd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:46:36 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38PAkaY6016466
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 10:46:36 GMT
Received: from [10.231.195.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Mon, 25 Sep
 2023 03:46:34 -0700
Message-ID: <8eba8b54-5805-151f-5283-8383d182ae3c@quicinc.com>
Date:   Mon, 25 Sep 2023 18:46:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 09/13] wifi: ath11k: fill parameters for vdev set tpc
 power WMI command
Content-Language: en-US
To:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <kvalo@kernel.org>
References: <20230920082349.29111-1-quic_wgong@quicinc.com>
 <20230920082349.29111-10-quic_wgong@quicinc.com>
 <13152047-9109-449f-b4f4-55fb7f4bb3ac@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <13152047-9109-449f-b4f4-55fb7f4bb3ac@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zaIwJjfSY_3FJ7K7sbfiTaGLywJuZnTD
X-Proofpoint-ORIG-GUID: zaIwJjfSY_3FJ7K7sbfiTaGLywJuZnTD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 adultscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2309250078
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/22/2023 4:11 AM, Jeff Johnson wrote:
> On 9/20/2023 1:23 AM, Wen Gong wrote:
>> Prepare the parameters which is needed for WMI command 
>> WMI_VDEV_SET_TPC_POWER_CMDID.
>>
>> Tested-on: WCN6855 hw2.0 PCI 
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>>
>> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
>> ---
>>   drivers/net/wireless/ath/ath11k/mac.c | 277 ++++++++++++++++++++++++++
>>   drivers/net/wireless/ath/ath11k/mac.h |   3 +
>>   2 files changed, 280 insertions(+)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c 
>> b/drivers/net/wireless/ath/ath11k/mac.c
>> index bfb900d98347..f05d66913abd 100644
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -7661,6 +7661,283 @@ static u8 
>> ath11k_mac_get_num_pwr_levels(struct cfg80211_chan_def *chan_def)
>>       }
>>   }
>>   +static u16 ath11k_mac_get_6ghz_start_frequency(struct 
>> cfg80211_chan_def *chan_def)
>> +{
>> +    u16 diff_seq;
>> +
>> +    /* It is to get the lowest channel number's center frequency of 
>> the chan.
>> +     * For example,
>> +     * bandwidth=40 MHz, center frequency is 5965, lowest channel is 1
>> +     * with center frequency 5955, its diff is 5965 - 5955 = 10.
>> +     * bandwidth=80 MHz, center frequency is 5985, lowest channel is 1
>> +     * with center frequency 5955, its diff is 5985 - 5955 = 30.
>> +     * bandwidth=160 MHz, center frequency is 6025, lowest channel is 1
>> +     * with center frequency 5955, its diff is 6025 - 5955 = 70.
>> +     */
>> +    switch (chan_def->width) {
>> +    case NL80211_CHAN_WIDTH_160:
>> +        diff_seq = 70;
>> +        break;
>> +    case NL80211_CHAN_WIDTH_80:
>> +    case NL80211_CHAN_WIDTH_80P80:
>> +        diff_seq = 30;
>> +        break;
>> +    case NL80211_CHAN_WIDTH_40:
>> +        diff_seq = 10;
>> +        break;
>> +    default:
>> +        diff_seq = 0;
>> +    }
>> +
>> +    return chan_def->center_freq1 - diff_seq;
>> +}
>> +
>> +static u16 ath11k_mac_get_seg_freq(struct cfg80211_chan_def *chan_def,
>> +                   u16 start_seq, u8 seq)
>> +{
>> +    u16 seg_seq;
>> +
>> +    /* It is to get the center frequency of the specific bandwidth.
>> +     * start_seq means the lowest channel number's center frequency.
>> +     * seq 0/1/2/3 means 20 MHz/40 MHz/80 MHz/160 MHz&80P80.
>> +     * For example,
>> +     * lowest channel is 1, its center frequency 5955,
>> +     * center frequency is 5955 when bandwidth=20 MHz, its diff is 
>> 5955 - 5955 = 0.
>> +     * lowest channel is 1, its center frequency 5955,
>> +     * center frequency is 5965 when bandwidth=40 MHz, its diff is 
>> 5965 - 5955 = 10.
>> +     * lowest channel is 1, its center frequency 5955,
>> +     * center frequency is 5985 when bandwidth=80 MHz, its diff is 
>> 5985 - 5955 = 30.
>> +     * lowest channel is 1, its center frequency 5955,
>> +     * center frequency is 6025 when bandwidth=160 MHz, its diff is 
>> 6025 - 5955 = 70.
>> +     */
>> +    if (chan_def->width == NL80211_CHAN_WIDTH_80P80 && seq == 3)
>> +        return chan_def->center_freq2;
>> +
>> +    seg_seq = 10 * (BIT(seq) - 1);
>> +    return seg_seq + start_seq;
>> +}
>
> The above two functions are driver agnostic. Will other drivers need 
> this as well, and if so, should these go into core wireless?
>
Not found other driver need it. If move them to core wireless, then it 
will be a new dependency for it.
