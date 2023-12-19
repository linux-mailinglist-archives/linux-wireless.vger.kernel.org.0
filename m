Return-Path: <linux-wireless+bounces-1049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B5D8193D1
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 580C0B230A4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07CF3EA7F;
	Tue, 19 Dec 2023 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="buSkWV5u"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179C33DBAA
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJLEMZd014589;
	Tue, 19 Dec 2023 22:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dF+rvLwTnrcu7MGaXdXhsAxsk1RV9+jU362RTIzh/+0=; b=bu
	SkWV5uJjxIJ07Yx63jE+2lWHpwmzTICiLb/5VkLNlLcl22lILHtOoKTNoSAKHglY
	VzgnQTdRaWTBHilsVZEhh6vdluQTiAu6MM7r2wUswMZjf4f3phRlE/JYK5wfxK9k
	+4gKDQSOX6BxkPHW41tAIZe3BQGsDPBU7uKCHCuuWUznza/gfkMqmKYKSAM8ZLrq
	H4WTvCGKB6MCU58VJSkWK4XU8lNPsQSONYDhOF9CWJiSRVQEsDSqXisQPB675erT
	zgRin1RU5CRTifNrULmbIhjvuiC8jNPvBk/3xOfBKxi6GQrxYKPiyfjeOfsTqYK6
	SHtZ/a7TlnViEMxkmgZg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v38qssspg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:48:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJMmMff000653
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:48:22 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 14:48:22 -0800
Message-ID: <bcb3780c-746f-4652-83f7-72e8cb29a9ab@quicinc.com>
Date: Tue, 19 Dec 2023 14:48:21 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/13] wifi: mac80211_hwsim: support HE 40MHz in 2.4Ghz
 band
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Gregory Greenman
	<gregory.greenman@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
 <20231220133549.82d9666abb5b.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231220133549.82d9666abb5b.I1ba6905c806be6e0548ed15130c0bbb2ee04c9fd@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: DqlhFEG9jb7L57sDjCZN-Caz-90eYj_A
X-Proofpoint-ORIG-GUID: DqlhFEG9jb7L57sDjCZN-Caz-90eYj_A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=473 impostorscore=0
 suspectscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190169

On 12/20/2023 3:41 AM, Miri Korenblit wrote:
> We are missing the flag that indicates that capability
> of 40MHz bandwidth support in HE on the LB.

Subject nit: s/Ghz/GHz/
Also consider adding a space between value and units of all frequency
references to conform to SI naming (which is also the format used by the
802.11 specifications).


