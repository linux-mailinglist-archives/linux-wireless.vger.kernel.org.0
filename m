Return-Path: <linux-wireless+bounces-18682-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE2EA2E262
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 03:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DDA165A30
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EAA01C2BD;
	Mon, 10 Feb 2025 02:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xyoul4/r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4C1C28E
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 02:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739155936; cv=none; b=QGzvkjaxOrZzI1PQ/l1KRDsQzAJjklkvPHwP1sqrEDSm680gf4zlQC73mXXb1SOWOLn17DsQagfRse9xmXva6IDHi5y5nT4bPoj2vVDVYwRsq3UUnvS2iA+9JRzz7tyhlQoMR+iCqWXBHzMKNJvxuK9PX8met0lOIjeN5AMyKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739155936; c=relaxed/simple;
	bh=B+RtU2cekuskwdyr5Y745EloP/5jzgBw2xkzMDJzm1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hnS6enyVSFvwxw/7SsDBbScs6DFWAJefoDBe0VqaKiKIA8aBulxz0p31u53pl/v78+EU8aAb3dCz6XKX3KpWZAc9qtI02fSWwwblMZI0VavKcisnW+T5v2bmceUr2SQ5ZrORsIQuxU9Hz5dH0a35PWAgFJ+qz14FrPE+x+msPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xyoul4/r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 519Kr0dN028226;
	Mon, 10 Feb 2025 02:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	11cM/BZaI2vjs2Q66vXwHvHPRnDApqHqaW0iYSnpCds=; b=Xyoul4/r2Nh/4AJH
	KdF99MhrPcCimtFdXc9uDCbwaBZmz4WGeHFA8bSyw/33vq3OpYp13QwwpZZC4wPK
	Uf+T3IKXjieQOJc8wOR9k1b1XFQJuqalmnWvxXCVAvhDffej8LUkMVd+XfqJjhns
	E3AQ6omzVPza+jlm2v+5zFzX5QMZq6w+iPMlG5r9397MDanKp1ko5x+8xAT7cUTY
	2cKOl+U4ReZDp1m8+PcQZ6kax2jLdUYqdBcowex1ZH5a2mN9mkRtbKjnNHZs3s8Q
	yRnHU9/0BncFOUG46NQGLKKQOVPsTuy9baMW1RReB65LMOGhSSoQSiT3eqWipHqq
	1tvhxQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44p0e1jv4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 02:52:08 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51A2q7il021854
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 02:52:07 GMT
Received: from [10.253.15.168] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 9 Feb 2025
 18:52:06 -0800
Message-ID: <bc54e1fa-da58-48e6-a148-4a980833f448@quicinc.com>
Date: Mon, 10 Feb 2025 10:52:03 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Abort scan before removing link interface
 to prevent duplicate deletion
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>, <ath12k@lists.infradead.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh
	<aditya.kumar.singh@oss.qualcomm.com>
References: <20250124093352.481-1-quic_lingbok@quicinc.com>
 <44dc86f0-7775-4d47-9058-17cb048cd976@quicinc.com>
 <7ee0f7fd-7a3d-4942-8323-08ff9c4c8915@oss.qualcomm.com>
Content-Language: en-US
From: Lingbo Kong <quic_lingbok@quicinc.com>
In-Reply-To: <7ee0f7fd-7a3d-4942-8323-08ff9c4c8915@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QbFqbBWLCvbxJvwPFsW9qyGiYd6Eo0U-
X-Proofpoint-GUID: QbFqbBWLCvbxJvwPFsW9qyGiYd6Eo0U-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_01,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100022



On 2025/2/8 2:53, Jeff Johnson wrote:
> On 2/7/2025 1:04 AM, Lingbo Kong wrote:
>>
>>
>> On 2025/1/24 17:33, Lingbo Kong wrote:
>>> Currently, when ath12k performs the remove link interface operation, if
>>> there is an ongoing scan operation on the arvif, ath12k may execute the
>>> remove link interface operation multiple times on the same arvif. This
>>> occurs because, during the remove link operation, if a scan operation is
>>> present on the arvif, ath12k may receive a WMI_SCAN_EVENT_COMPLETED event
>>> from the firmware. Upon receiving this event, ath12k will continue to
>>> execute the ath12k_scan_vdev_clean_work() function, performing the remove
>>> link interface operation on the same arvif again.
>>>
>>> To address this issue, before executing the remove link interface
>>> operation, ath12k needs to check if there is an ongoing scan operation on
>>> the current arvif. If such an operation exists, it should be aborted.
>>>
>>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>>
>>> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>
>>> ---
>>>    drivers/net/wireless/ath/ath12k/mac.c | 5 +++++
>>>    1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
>>> index 329c05003721..cdce88787182 100644
>>> --- a/drivers/net/wireless/ath/ath12k/mac.c
>>> +++ b/drivers/net/wireless/ath/ath12k/mac.c
>>> @@ -9333,6 +9333,11 @@ ath12k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>>    	    ar->num_started_vdevs == 1 && ar->monitor_vdev_created)
>>>    		ath12k_mac_monitor_stop(ar);
>>>    
>>> +	if (ar->scan.arvif == arvif && ar->scan.state == ATH12K_SCAN_RUNNING) {
>>> +		ath12k_scan_abort(ar);
>>> +		ar->scan.arvif = NULL;
>>> +	}
>>> +
>>>    	ath12k_mac_remove_link_interface(hw, arvif);
>>>    	ath12k_mac_unassign_link_vif(arvif);
>>>    }
>>>
>>> base-commit: 376673aa393c1c232299be3e910d7f2e6d974b2f
>>
>> hi jeff,
>> do you have any updates on this patch?🙂
> 
> while this patch applies cleanly to ath/main, it does not apply cleanly to the
> current ath/pending, conflicting with:
> 
> https://msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com
> 
> that patch relocates the adjacent lines:
>     	ath12k_mac_remove_link_interface(hw, arvif);
>     	ath12k_mac_unassign_link_vif(arvif);
> 
> so should this logic stay in ath12k_mac_op_unassign_vif_chanctx() or should it
> also be relocated to ath12k_mac_op_change_vif_links()?
> 
> /jeff

hi, jeff, this logic should stay in ath12k_mac_op_unassign_vif_chanctx().

should i resend a new version of the patch based on 
https://msgid.link/20250204-unlink_link_arvif_from_chanctx-v2-8-764fb5973c1a@oss.qualcomm.com 
?

/lingbok

