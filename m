Return-Path: <linux-wireless+bounces-298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DAB800DE5
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 16:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD54281B8D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Dec 2023 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0753E49C;
	Fri,  1 Dec 2023 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KrwHhOV2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E3A8;
	Fri,  1 Dec 2023 07:05:16 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1CFHMs001243;
	Fri, 1 Dec 2023 15:05:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vIyqDqrpQXUkJiwj/1Jen/Rv0bmhnV8/I/dv8ILzzho=;
 b=KrwHhOV2d/5gLpeiKL3r6002hHTeWUMmQcxV9m3wdUYZG5CCfCe2x6YoQipUAdPDJ9SK
 DEeHW5oD1Ycku62DEQ8baLByYgbs6bkrcC2r4LyYJZjetnnZyRMSF2ZwoGKV9S01BZ3v
 I/xPr1sty0/OU7JR+dj4irquW8+51SloSqHSKTjMv6hxuFtxwb9p78IcrsoLkaek0Q+3
 2490SgCmyY2t/3qvyDtiLhMyJW+15a51qMfM9Jyd+GbgV4Lzrtjq74n8yIkdAKCazjp6
 VO3qE6uWC6yp9oxiIDLQuWgMT31yhfvVm3loqwHAkjaQoFpp+TxXS/bz9utEEHss/5nt xw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uprhduwqw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 15:05:05 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B1F5481007104
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Dec 2023 15:05:04 GMT
Received: from [10.110.26.250] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 1 Dec
 2023 07:05:03 -0800
Message-ID: <8d720940-5cd1-4d53-bdf2-97334069a5b8@quicinc.com>
Date: Fri, 1 Dec 2023 07:05:02 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/12] wifi: mwifiex: fixed group rekey issue for WPA3.
Content-Language: en-US
To: Francesco Dolcini <francesco@dolcini.it>, David Lin <yu-hao.lin@nxp.com>
CC: <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <briannorris@chromium.org>, <kvalo@kernel.org>,
        <tsung-hsien.hsieh@nxp.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-3-yu-hao.lin@nxp.com>
 <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <ZWmyQ9ilyAPGJmft@francesco-nb.int.toradex.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EGQ6AB49ZtW8Zu2PaIFByA0gyvCZfjoY
X-Proofpoint-GUID: EGQ6AB49ZtW8Zu2PaIFByA0gyvCZfjoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1011 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010103

On 12/1/2023 2:15 AM, Francesco Dolcini wrote:
> On Tue, Nov 28, 2023 at 04:31:05PM +0800, David Lin wrote:

>> diff --git a/drivers/net/wireless/marvell/mwifiex/main.c b/drivers/net/wireless/marvell/mwifiex/main.c
>> index d99127dc466e..3bebb6c37604 100644
>> --- a/drivers/net/wireless/marvell/mwifiex/main.c
>> +++ b/drivers/net/wireless/marvell/mwifiex/main.c
>> @@ -802,6 +802,10 @@ mwifiex_bypass_tx_queue(struct mwifiex_private *priv,
>>  			    "bypass txqueue; eth type %#x, mgmt %d\n",
>>  			     ntohs(eth_hdr->h_proto),
>>  			     mwifiex_is_skb_mgmt_frame(skb));
>> +		if (ntohs(eth_hdr->h_proto) == ETH_P_PAE)
>> +			mwifiex_dbg(priv->adapter, MSG,
>> +				    "key: send EAPOL to %pM\n",
>> +				    eth_hdr->h_dest);
> 
> this is just debug code, at a first glance not sure i

not only that, the usual pattern is:
if (eth_hdr->h_proto == htons(ETH_P_PAE))

you want to do endian conversion on a constant when possible since that
is a compile-time conversion and not a runtime conversion


