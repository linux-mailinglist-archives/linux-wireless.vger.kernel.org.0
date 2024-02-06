Return-Path: <linux-wireless+bounces-3186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A280584AC25
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 03:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2479B1F244C1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 02:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0475811B;
	Tue,  6 Feb 2024 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DVZsd3Yp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F0E58129
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186089; cv=none; b=dPS5ck2RmuTO/g37GQbF9snhTZAVAUA5Oc2uBw9nZPLtVn/kjUTGvAbTPl3/FdqQuU24kq3Lhb8T3D2SQ9xPXY4VZolefc/F9RKUlKZv4dGw/bJdfvJc9ZoSz1S6meM0DbRdjZfG0JN1NpJVhEsGq0w/x8oBzhpiGUlbSpQPJMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186089; c=relaxed/simple;
	bh=CCH5twNm8uG4+yrKi05dS9/VLNJl2KHU82jZ9XTSMXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pVBoYnzu1Zo3+iETrCSGX/7/KmSdcI5owYeOJAeVLxe4VO5M3k5BSidtih5V4zcuPtoTVcUr5jSjLuEvc9kuf38PqHh2msSPgegtM/qqO49ViVIB5BNbKjHf/+7rYlILye+woEs+tUBZZoKws1AXtsPq0cOo3P6hVmvQT6E4Ys4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DVZsd3Yp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4161eTD7008070;
	Tue, 6 Feb 2024 02:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=N+Eea2bQciagdDZRBsqMHdL6LsAgVPGvqZZ6JAM01QQ=; b=DV
	Zsd3Yp7YfK9cjq/EUXYTwXk70owXPdbWqe1SQWfKbjJZ+62l4A3F/Oci+SjA/tcC
	ReFq/jHd1vBGz7A1s3+f8TsrxxhhyVAOWklc7bNwGVt/HAavobyF4pa4zRki9xVQ
	OegJ6c7zKypv2SFrETi/FxSx8gDHu8DoO0y0Lj/X19K85HyrbM+4+qRaPufICeoN
	rZHIzZ/4gfWR1+8C96oK2bHywzG+XLGEM4x9+hcyzpAKgov0YHDA9t4EHNc6xqNb
	X+ODh5FGyuo1eYGMPptRdeEdwWXgu3NI3bIW7sfAcjN/wklfx0hVmwmjlocnVi+E
	DPBJhjLXse/vV1o9GFpw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w2v72a8kw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 02:21:18 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4162LHjx029819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 02:21:17 GMT
Received: from [10.253.73.189] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 5 Feb
 2024 18:21:16 -0800
Message-ID: <bc5baff6-83c9-44ec-9beb-a863045194da@quicinc.com>
Date: Tue, 6 Feb 2024 10:21:13 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 05/11] wifi: ath12k: implement handling of P2P NoA
 event
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240130040303.370590-1-quic_kangyang@quicinc.com>
 <20240130040303.370590-6-quic_kangyang@quicinc.com>
 <871q9vt1km.fsf@kernel.org>
Content-Language: en-US
From: Kang Yang <quic_kangyang@quicinc.com>
In-Reply-To: <871q9vt1km.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g6SwpuT334Y_qNTROufmFFQnEz6NRBiv
X-Proofpoint-ORIG-GUID: g6SwpuT334Y_qNTROufmFFQnEz6NRBiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_18,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=782
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060015



On 2/2/2024 9:53 PM, Kalle Valo wrote:
> Kang Yang <quic_kangyang@quicinc.com> writes:
> 
>> The NoA(Notice of Absence) attribute is used by the P2P Group Owner to
>> signal its absence due to power save timing, concurrent operation, or
>> off-channel scanning. It is also used in the P2P Presence Request-Response
>> mechanism.
>>
>> The NoA attribute shall be present in the P2P IE in the beacon frames
>> transmitted by a P2P Group Owner when a NoA schedule is being advertised,
>> or when the CTWindow is non-zero.
>>
>> So add support to update P2P information after P2P GO is up through
>> event WMI_P2P_NOA_EVENTID, and always put it in probe resp.
>>
>> Create p2p.c and p2p.h for P2P related functions and definitions.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
> 
> This patch 5 had simple conflicts in wmi.c, please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=pending&id=cbcb45c458a93d32a48b9280c13294e0853fa5dd
> 

Sorry for late reply, I am in Spring Festival holiday. It seems i have 
conflict in adding WMI event, because you merge TWT patch-set before.


conflict:
root@Mayan:/home/yk/ath12k-upstream/drivers/net/wireless/ath/ath12k# cat 
wmi.c.rej
diff a/drivers/net/wireless/ath/ath12k/wmi.c 
b/drivers/net/wireless/ath/ath12k/wmi.c    (rejected hunks)
@@ -162,6 +163,10 @@ static const struct ath12k_wmi_tlv_policy 
ath12k_wmi_tlv_policies[] = {
                 .min_len = sizeof(struct wmi_probe_resp_tx_status_event) },
         [WMI_TAG_VDEV_DELETE_RESP_EVENT] = {
                 .min_len = sizeof(struct wmi_vdev_delete_resp_event) },
+       [WMI_TAG_P2P_NOA_INFO] = {
+               .min_len = sizeof(struct ath12k_wmi_p2p_noa_info) },
+       [WMI_TAG_P2P_NOA_EVENT] = {
+               .min_len = sizeof(struct wmi_p2p_noa_event) },
  };

  static __le32 ath12k_wmi_tlv_hdr(u32 cmd, u32 len)
@@ -6807,6 +6853,9 @@ static void ath12k_wmi_op_rx(struct ath12k_base 
*ab, struct sk_buff *skb)
         case WMI_RFKILL_STATE_CHANGE_EVENTID:
                 ath12k_rfkill_state_change_event(ab, skb);
                 break;
+       case WMI_P2P_NOA_EVENTID:
+               ath12k_wmi_p2p_noa_event(ab, skb);
+               break;
         /* add Unsupported events here */
         case WMI_TBTTOFFSET_EXT_UPDATE_EVENTID:
         case WMI_PEER_OPER_MODE_CHANGE_EVENTID:



TWT patch change:

@@ -164,6 +164,8 @@ static const struct ath12k_wmi_tlv_policy 
ath12k_wmi_tlv_policies[] = {
  		.min_len = sizeof(struct wmi_vdev_delete_resp_event) },
  	[WMI_TAG_TWT_ENABLE_COMPLETE_EVENT] = {
  		.min_len = sizeof(struct wmi_twt_enable_event) },
+	[WMI_TAG_TWT_DISABLE_COMPLETE_EVENT] = {
+		.min_len = sizeof(struct wmi_twt_disable_event) },
  };

@@ -6798,10 +6829,12 @@ static void ath12k_wmi_op_rx(struct ath12k_base 
*ab, struct sk_buff *skb)
  	case WMI_TWT_ENABLE_EVENTID:
  		ath12k_wmi_twt_enable_event(ab, skb);
  		break;
+	case WMI_TWT_DISABLE_EVENTID:
+		ath12k_wmi_twt_disable_event(ab, skb);
+		break;
  	/* add Unsupported events here */




Do i need to send a new version ?



