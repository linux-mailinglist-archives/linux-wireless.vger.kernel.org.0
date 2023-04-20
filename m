Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CD66E8ECE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 12:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjDTKDA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 06:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbjDTKC5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 06:02:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF7319B1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 03:02:55 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33K9tkFG014393;
        Thu, 20 Apr 2023 10:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kP63/IWD6Fj6iskn0QZpM5NG8blh+w8LLmuthH8joTo=;
 b=bBDlbD4xdw/qp5q8nhZTKTAq+f8iZXEspLXrokUrDlri1SuGJRPRFXM2zqQMql+6Xn49
 SKyUy8gncZoxo3f6YHe8hzaKw45WVAoaSjHLktB2IyWr/uhGKAbgUyFPLjoz2KVyiqd6
 tz3qHny4ma2E/Falv4lc2W++l+OdsqKf/Z6ubQCq/4KBmNAvrlk5v50Sj65yWDfT6dQK
 SpLHisY038/WKSVIntyEw3G2rgs9F4DKW8kRoz3se1AktkqMZXo96zuZdhx9/xU7Jbx/
 YAacsnYG4TLyIbz3GLQj6+IinulU+Itdw8XRnpzhU2S0SgQyEGGaV5K+EFDkV5IsnepT fQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q2hd9jhke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:02:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33KA2eI3019791
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Apr 2023 10:02:40 GMT
Received: from [10.242.242.48] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 20 Apr
 2023 03:02:37 -0700
Message-ID: <ca872729-513a-e9dc-95f5-bc1692af648f@quicinc.com>
Date:   Thu, 20 Apr 2023 15:32:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] wifi: ath11k: factory test mode support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        "Govindaraj Saminathan" <quic_gsaminat@quicinc.com>,
        Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
References: <20230213130854.2473-1-quic_rajkbhag@quicinc.com>
 <20230213130854.2473-2-quic_rajkbhag@quicinc.com> <87ilf4onge.fsf@kernel.org>
From:   Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
In-Reply-To: <87ilf4onge.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tnrO8ExaT0GqP4U04dhSfPTum440UqBv
X-Proofpoint-ORIG-GUID: tnrO8ExaT0GqP4U04dhSfPTum440UqBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-20_06,2023-04-18_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304200080
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/13/2023 5:47 PM, Kalle Valo wrote:
> Raj Kumar Bhagat <quic_rajkbhag@quicinc.com> writes:
> 
>> From: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>>
>> Add support to process factory test mode commands(FTM) for calibration.
>> By default firmware start with NORMAL mode and to process the FTM commands
>> firmware needs to be restarted in FTM mode using module parameter ftm_mode.
>> The pre-request is all the radios should be down before starting the test.
>>
>> When start command ATH11K_TM_CMD_TESTMODE_START is received, ar state
>> is set to Test Mode. If the FTM command or event length is greater
>> than 256 bytes, it will be broken down into multiple segments and
>> encoded with TLV header if it is segmented commands, else it is sent
>> to firmware as it is.
>>
>> On receiving UTF event from firmware, if it is segmented event, the driver
>> will wait until it receives all the segments and notify the complete
>> data to user application. In case the segmented sequence are missed or
>> lost from the firmware, driver will skip the already received partial data.
>>
>> In case of unsegmented UTF event from firmware, driver notifies the
>> data to the user application as it comes. Applications handles
>> the data further.
>>
>> Command to boot in ftm mode
>> insmod ath11k ftm_mode=1
>>
>> Tested-on : IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Govindaraj Saminathan <quic_gsaminat@quicinc.com>
>> Co-developed-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>
>> Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
> 
> [...]
> 
>> -bool ath11k_tm_event_wmi(struct ath11k *ar, u32 cmd_id, struct sk_buff *skb)
> 
> Please do removal of this ath11k_tm_event_wmi() in a separate patch,
> then it's easier to read this patch.

Will address this in next version.

> 
>>  static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>>  {
>>  	struct sk_buff *skb;
>> -	int ret;
>>  
>>  	ath11k_dbg(ar->ab, ATH11K_DBG_TESTMODE,
>>  		   "testmode cmd get version_major %d version_minor %d\n",
>> @@ -98,21 +205,50 @@ static int ath11k_tm_cmd_get_version(struct ath11k *ar, struct nlattr *tb[])
>>  	if (!skb)
>>  		return -ENOMEM;
>>  
>> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
>> -			  ATH11K_TESTMODE_VERSION_MAJOR);
>> -	if (ret) {
>> +	if (nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MAJOR,
>> +			ATH11K_TESTMODE_VERSION_MAJOR) ||
>> +	    nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
>> +			ATH11K_TESTMODE_VERSION_MINOR)) {
>>  		kfree_skb(skb);
>> -		return ret;
>> +		return -ENOBUFS;
>>  	}
>>  
>> -	ret = nla_put_u32(skb, ATH11K_TM_ATTR_VERSION_MINOR,
>> -			  ATH11K_TESTMODE_VERSION_MINOR);
>> -	if (ret) {
>> -		kfree_skb(skb);
>> -		return ret;
>> +	return cfg80211_testmode_reply(skb);
>> +}
> 
> Please also do the changes in ath11k_tm_cmd_get_version() in a separate
> patch.

will address this in next version.

> 
>> @@ -47,4 +49,21 @@ enum ath11k_tm_cmd {
>>  	 * ATH11K_TM_ATTR_DATA.
>>  	 */
>>  	ATH11K_TM_CMD_WMI = 1,
>> +
>> +	/* Boots the UTF firmware, the netdev interface must be down at the
>> +	 * time.
>> +	 */
>> +	ATH11K_TM_CMD_TESTMODE_START = 2,
>> +
>> +	/* Shuts down the UTF firmware and puts the driver back into OFF
>> +	 * state.
>> +	 */
>> +	ATH11K_TM_CMD_TESTMODE_STOP = 3,
> 
> The documentation for for the STOP command is misleading, now ath11k
> just ignores that command. So is there any point even to have the
> command if it doesn't do anything?

Will remove ATH11K_TM_CMD_TESTMODE_STOP as it is not used and send the
next version.

> 
>> @@ -8096,6 +8128,12 @@ static void ath11k_wmi_tlv_op_rx(struct ath11k_base *ab, struct sk_buff *skb)
>>  	case WMI_PDEV_CSA_SWITCH_COUNT_STATUS_EVENTID:
>>  		ath11k_wmi_pdev_csa_switch_count_status_event(ab, skb);
>>  		break;
>> +	case WMI_PDEV_UTF_EVENTID:
>> +		if (test_bit(ATH11K_FLAG_FTM_SEGMENTED, &ab->dev_flags))
>> +			ath11k_wmi_tm_event_segmented(ab, id, skb);
>> +		else
>> +			ath11k_tm_wmi_event_unsegmented(ab, id, skb);
>> +		break;
> 
> I didn't investigate this in detail, but I find the flag a bit
> problematic as it alters the behaviour ATH11K_FLAG_FTM_SEGMENTED and the
> behaviour difference it's not documented at all in enum ath11k_tm_cmd.
> 
Will document the behavior difference in enum ath11k_tm_cmd, in next version.

Thanks
Raj
