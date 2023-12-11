Return-Path: <linux-wireless+bounces-616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D8280C028
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 04:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16E761C2032E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 03:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CCE179B6;
	Mon, 11 Dec 2023 03:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RKeaUVwZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4373AF3
	for <linux-wireless@vger.kernel.org>; Sun, 10 Dec 2023 19:56:58 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3avmH007820;
	Mon, 11 Dec 2023 03:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cbGhdVTcI/aVomh6hJpeZFwWbflJrOoOloLwZ+SLRM0=; b=RK
	eaUVwZP+6wkG3Yq2rH4cLfG+hHNgmuCDyrGfQtIe1hn+jSKbMGhK/JvDRBwhF3ag
	Wm0FU8KzPL4R6eEtEK1gx/ncehB2LNdraDxXgl3cZ3GzoINhEUPbW7F3gfoNCGWg
	xN+mIDr6cofJDhrxMn358HbpT3UjxDTmSgYgRuMlpNcvw8FgyNRVRFib/esRPaZ2
	hQO0kWa7TOQ0rVZuLzzc6LUHdd9BB+VlXJTQBH+2vyGZKVcBFfsNlTtKQJ+hga5D
	oM7g0lwcpjd9WAyv+57KoUHWMr3UNXTS3meuQAVXlbyzYlKsdSk0fG7Si6gNNJ4w
	D0X3IY9wplzve0dtfR7w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvney2752-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 03:56:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB3usMe014818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 03:56:54 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Dec
 2023 19:56:52 -0800
Message-ID: <2c70dfd6-9e0e-468b-8585-252f0c23ff0a@quicinc.com>
Date: Mon, 11 Dec 2023 11:56:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/12] wifi: ath11k: store cur_regulatory_info for each
 radio
Content-Language: en-US
To: Aditya Kumar Singh <quic_adisi@quicinc.com>, <ath11k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20231204081323.5582-1-quic_bqiang@quicinc.com>
 <20231204081323.5582-3-quic_bqiang@quicinc.com>
 <db8b0734-8e4e-43f9-ba48-b3df2d33e29e@quicinc.com>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <db8b0734-8e4e-43f9-ba48-b3df2d33e29e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2nodsRR9MpKM83N-HDzKkYi1CmYoEwlg
X-Proofpoint-ORIG-GUID: 2nodsRR9MpKM83N-HDzKkYi1CmYoEwlg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110031



On 12/7/2023 11:15 AM, Aditya Kumar Singh wrote:
> On 12/4/23 13:43, Baochen Qiang wrote:
>> --- a/drivers/net/wireless/ath/ath11k/mac.h
>> +++ b/drivers/net/wireless/ath/ath11k/mac.h
>> @@ -159,7 +159,6 @@ struct ath11k_vif *ath11k_mac_get_vif_up(struct 
>> ath11k_base *ab);
>>   struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, 
>> u32 vdev_id);
>>   struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, 
>> u32 pdev_id);
>> -
> 
> Irrelevant change w.r.t commit message?
> 
> 
>>   void ath11k_mac_drain_tx(struct ath11k *ar);
>>   void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
>>   int ath11k_mac_tx_mgmt_pending_free(int buf_id, void *skb, void *ctx);
> ...
>> @@ -4749,6 +4749,11 @@ static int 
>> ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
>>           soc->pdevs[0].pdev_id = 0;
>>       }
>> +    if (!soc->reg_info_store)
>> +        soc->reg_info_store = kcalloc(soc->num_radios,
>> +                          sizeof(*soc->reg_info_store),
>> +                          GFP_ATOMIC);
> What if this memory allocation request fails? Any negative case check 
> should be present?
> 
> 
>> +
>>       return 0;
>>   }
>> @@ -7071,33 +7076,54 @@ static bool ath11k_reg_is_world_alpha(char 
>> *alpha)
>>       return false;
>>   }
>> -static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
>> -                      struct sk_buff *skb,
>> -                      enum wmi_reg_chan_list_cmd_type id)
>> +void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info)
>>   {
>> -    struct cur_regulatory_info *reg_info = NULL;
>> -    struct ieee80211_regdomain *regd = NULL;
>> -    bool intersect = false;
>> -    int ret = 0, pdev_idx, i, j;
>> -    struct ath11k *ar;
>> +    int i, j;
>> -    reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
>> -    if (!reg_info) {
>> -        ret = -ENOMEM;
>> -        goto fallback;
>> -    }
>> +    if (reg_info) {
>> +        kfree(reg_info->reg_rules_2ghz_ptr);
>> -    if (id == WMI_REG_CHAN_LIST_CC_ID)
>> -        ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
>> -    else
>> -        ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, 
>> reg_info);
>> +        kfree(reg_info->reg_rules_5ghz_ptr);
>> -    if (ret) {
>> -        ath11k_warn(ab, "failed to extract regulatory info from 
>> received event\n");
>> -        goto fallback;
>> +        for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
>> +            kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
>> +            for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
>> +                kfree(reg_info->reg_rules_6ghz_client_ptr[i][j]);
>> +        }
>> +
>> +        memset(reg_info, 0, sizeof(*reg_info));
>>       }
>> +}
>> +
>> +static
>> +enum wmi_vdev_type ath11k_reg_get_ar_vdev_type(struct ath11k *ar)
>> +{
>> +    struct ath11k_vif *arvif;
>> +
>> +    /* Currently each struct ath11k maps to one struct 
>> ieee80211_hw/wiphy
>> +     * and one struct ieee80211_regdomain, so it could only store one 
>> group
>> +     * reg rules. It means muti-interface concurrency in the same 
>> ath11k is
>> +     * not support for the regdomain. So get the vdev type of the 
>> first entry
>> +     * now. After concurrency support for the regdomain, this should 
>> change.
>> +     */
>> +    arvif = list_first_entry_or_null(&ar->arvifs, struct ath11k_vif, 
>> list);
>> +    if (arvif)
>> +        return arvif->vdev_type;
>> +
>> +    return WMI_VDEV_TYPE_UNSPEC;
>> +}
>> +
>> +int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
>> +                struct cur_regulatory_info *reg_info,
>> +                enum ieee80211_ap_reg_power power_type)
>> +{
>> +    struct ieee80211_regdomain *regd;
>> +    bool intersect = false;
>> +    int pdev_idx;
>> +    struct ath11k *ar;
>> +    enum wmi_vdev_type vdev_type;
>> -    ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
>> +    ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg handle chan list");
> 
> I believe this debug was helpful in the sense it showed which type of 
> event came. Can't we still print this somehow? Or may be somewhere else?You can check the event type from logs of 
ath11k_pull_reg_chan_list_update_ev() and 
ath11k_pull_reg_chan_list_ext_update_ev().

