Return-Path: <linux-wireless+bounces-12507-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1396C94F
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 23:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 454211F28676
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 21:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C341527B1;
	Wed,  4 Sep 2024 21:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cOGTKWcz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD4F154C0E
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 21:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725484149; cv=none; b=bh8dLOKbwuRct+s5OUWY2TKkqrgrHhJqDo24dAA5+Hm2Hnprhkt1aHHUaNavEQEzaaN6RObzyXlDsyJ8mEdjvVfIiFRtWdMeR5nyro2JZQxBqDuu8mMLEUXdgohorjuGOihnDu1SuXHp1qRLwOAuD5NfJS5kaXPstCznFEMJi9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725484149; c=relaxed/simple;
	bh=LihfnsRWDChzCRSIqO8jDemQua0gerj/Yu68zc+b8kA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LDtfG1kKMMXGdCtwh3og9d3ujYhOopqtFr99teGTSOkq9b7fcX03HbC9AMiGyH4qBVrWlIWSIx8gKQfsYOpS4G6uDmAhnoHT1xnU9st6QEDX60q5y+B5+LpMihJfeMgBLNZ/2bdeSWiBMCL3flrxAuh8hH7ORpuapGghNdmJTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cOGTKWcz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 484DH8rF009037;
	Wed, 4 Sep 2024 21:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QTTjo7NTFeiyi1GWoiVfJY9SrFo2k4ZD0hkZxbwH2Io=; b=cOGTKWczdmXVhNGW
	LMd4y0gLraxhkPu19vC74FNzPX6RM42ZUBILLQZNgmCQ9Tr7kcTxs+ArYmqYlaIZ
	60cwSC/Yqb8ntjXtNXRWOoqR9lMtWlmIw5jAbzkABSjKsJU+3dy6bq7Zc2KM8V8Q
	M6ENfhYVo9eo+tmMfhFrKNgS/mk21zcYSHAB9wADWXFbd6s6HLO3tBxOaTfdCKk/
	vro467ew4NVHvn2g9vxlrp3N+QVk0kv+qjWofn4KrINqcJREhX0FYCDS5ut7556a
	AsyH24A4CrzvmsV3OAs/X8MhTP80NMpiLktoClyp1BNa5Q7M6IlzS2MBhvn6tC2V
	9o70Gw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41bt67443t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Sep 2024 21:09:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 484L91Uh005416
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Sep 2024 21:09:01 GMT
Received: from [10.111.180.250] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 4 Sep 2024
 14:09:00 -0700
Message-ID: <c9f1100c-b34a-4d77-bfbe-1e20cf4143ef@quicinc.com>
Date: Wed, 4 Sep 2024 14:09:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath10k: add USB device ID for Atheros QCA9377-7
To: Tomas Paukrt <tomaspaukrt@email.cz>
CC: <linux-wireless@vger.kernel.org>, <ath10k@lists.infradead.org>
References: <22t.ZbsX.5bWREDtSGGB.1cqQpF@seznam.cz>
 <8b7d9777-e239-4173-bec5-607e15b98130@quicinc.com>
 <56o.Zbc9.7x3xmPitckT.1csARP@seznam.cz>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <56o.Zbc9.7x3xmPitckT.1csARP@seznam.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TVWLsE-zo3Eb7Y07qoe0nBKsNjrkj_8I
X-Proofpoint-GUID: TVWLsE-zo3Eb7Y07qoe0nBKsNjrkj_8I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_19,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=708 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2409040160

On 9/4/2024 11:28 AM, Tomas Paukrt wrote:
>> Also the Tested-on tag should include the firmware version information as well.
> 
> Hi Jeff,
> 
> I tested it with manually converted firmware from https://github.com/8devices/qcacld-2.0/tree/CNSS.LEA.NRT_3.0/firmware_bin/usb which does not include any explicit version.
> 
> What version should I write in the Tested-on tag in this case?

Ah, my good friend qcacld-2.0.

I'd expect to see something written to kmsg, but not sure it is there for USB.

for QMI there is: 
		ath10k_info(ar, "qmi fw_version 0x%x fw_build_timestamp %s fw_build_id %s",
			    qmi->fw_version, qmi->fw_build_timestamp, qmi->fw_build_id);

but looking at past ath10k USB changes I only see:
    Tested-on: QCA9377 hw1.0 USB 1.0.0.299

So I guess what you have is OK since this just allows you to be probed anyway
so that is actually independent of firmware version.


