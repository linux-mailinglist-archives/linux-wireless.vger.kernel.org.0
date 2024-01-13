Return-Path: <linux-wireless+bounces-1865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE8682C907
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 03:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67F86286774
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Jan 2024 02:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A6918C27;
	Sat, 13 Jan 2024 02:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NtMpbyLv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A2818B00
	for <linux-wireless@vger.kernel.org>; Sat, 13 Jan 2024 02:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40D1xEQC018915;
	Sat, 13 Jan 2024 02:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=cM8fIaehgJMklMVOd/tedYVm4URXb2TVGyy1kxUWmCY=; b=Nt
	MpbyLvrFWLaNVsMkgkMnpqvYNwpfm3OuO4V3NZM3wqWekBE1L9ur/Gz9xxK/lkKM
	Tg59xyCIDBnMWrJenRfxlCpOt8ORxC6M6OCNEsYrPNLt9RBYgDys2ZWw13pMskhP
	eGAEs8RjH3JS5zBcVoTkw7CgocvpdC4tZVbMlj1+POeumZpiptgeU6kRmMc81+p6
	oS/AOHVsEwl3TpOd5HN3MZPKafix9yOZVyrv7DHFC/wWiIzRs1/rMkXGpRm/0o7d
	fMDw2CB5J8scnqYwk6z6C7yLH2ubgfTaYK2EhMKdbPd5LVZcTt1/O2Hul7r2fxAQ
	MckaQVU+zQRVOB3hagFw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vk6ee9eaf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 02:05:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40D25meU014108
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jan 2024 02:05:48 GMT
Received: from [10.110.118.97] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 12 Jan
 2024 18:05:48 -0800
Message-ID: <25e2a46e-51a3-4bae-836e-6ceb2b5c4ebe@quicinc.com>
Date: Fri, 12 Jan 2024 18:05:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] wifi: ath12k: implement handling of P2P NoA
 event
Content-Language: en-US
To: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Kang Yang
	<quic_kangyang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240112092824.7664-1-quic_kangyang@quicinc.com>
 <20240112092824.7664-4-quic_kangyang@quicinc.com>
 <b1cb2130-ca6c-525e-4370-ea0acbd73138@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <b1cb2130-ca6c-525e-4370-ea0acbd73138@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ou_cYbLxfdPbzc6PZQRfFJU5-71NaeBg
X-Proofpoint-GUID: Ou_cYbLxfdPbzc6PZQRfFJU5-71NaeBg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 suspectscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=210 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=1 adultscore=0 spamscore=1 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401130015

On 1/12/2024 5:35 PM, Karthikeyan Periyasamy wrote:
> 
> On 1/12/2024 2:58 PM, Kang Yang wrote:
>> +	ieee80211_iterate_active_interfaces_atomic(ar->hw,
>> +						   IEEE80211_IFACE_ITER_NORMAL,
>> +						   ath12k_p2p_noa_update_vdev_iter,
>> +						   &arg);
> 
> 
> ath12k_ar_to_hw(ar) is introduced to avoid direct access of hw from radio (ie, ar->hw).
> 
> This new helper function introduced by the patchset "[PATCH v2 1/2] wifi: ath12k: Refactor the mac80211 hw access from link/radio"
> 
> 
> @jeff
> 
> Any comments ?

you are correct, we should use the helper function
Please rebase on hw abstraction series

/jeff

