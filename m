Return-Path: <linux-wireless+bounces-336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16639802554
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 17:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75DF91C204F9
	for <lists+linux-wireless@lfdr.de>; Sun,  3 Dec 2023 16:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06844156D8;
	Sun,  3 Dec 2023 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QmLSiZQT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDB5B6;
	Sun,  3 Dec 2023 08:13:33 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B3G9qtj027502;
	Sun, 3 Dec 2023 16:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rnsgqiaXdadfmJkJvEjXLeGovIOiwLZ+LOpiDIVA4Ho=;
 b=QmLSiZQTRdSEyb+h8PvEeNQI8LMC3q2D2nut4JLWj/3SRt5vbzWaf1WujgnJV4bKGM/l
 pY8l5iBFN0/imhul0Jrq03zx33eBAs+Ku9ipsktINRVuywfefOQRLdb4AvzyslBSFZSY
 xhZ7L0W8cRZl8pmQ0qrBGQGLz/B8ZHvLZ1EVJh/cBCE90Y7uo3/nWgKLw+8DR2gNIHg+
 eh1YZBv91tZ8XmjOhlJtnbj0hdS8qfP1bZ5z/XuZP8uu/SZcYn3dcjz+QvciXDORzw/A
 FNL6fPZGtQ6jfQkSfHL8JZwgl+mKxOfzH7LqxjK447bCP9B7vL/mrbTQX/Qi/NiHtDdX uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uqt9q29gt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Dec 2023 16:13:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B3GDGsq016873
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 3 Dec 2023 16:13:16 GMT
Received: from [10.110.89.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Dec
 2023 08:13:15 -0800
Message-ID: <16fea36e-a831-47e6-8983-da205ff7a8ab@quicinc.com>
Date: Sun, 3 Dec 2023 08:13:14 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v7 06/12] wifi: mwifiex: added mac address for
 AP config.
Content-Language: en-US
To: David Lin <yu-hao.lin@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "briannorris@chromium.org" <briannorris@chromium.org>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <20231128083115.613235-1-yu-hao.lin@nxp.com>
 <20231128083115.613235-7-yu-hao.lin@nxp.com>
 <ZWm15Nb4tZ5LfjFp@francesco-nb.int.toradex.com>
 <PA4PR04MB963883143033EEF9880D3ECDD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <PA4PR04MB963883143033EEF9880D3ECDD181A@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: m7QJtvjg3AuRLLa9knpV6eOmdJ5cgtUi
X-Proofpoint-ORIG-GUID: m7QJtvjg3AuRLLa9knpV6eOmdJ5cgtUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-03_14,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 mlxlogscore=725 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312030128

On 12/1/2023 2:50 PM, David Lin wrote:
> - fixes tag
> - cc stable
> 
> I don't understand what does this mean?

<https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes>

<https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-1>

