Return-Path: <linux-wireless+bounces-4841-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E40287ECE8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 17:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB036280E20
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Mar 2024 16:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B39052F79;
	Mon, 18 Mar 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jPBN2E5D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F71524CE
	for <linux-wireless@vger.kernel.org>; Mon, 18 Mar 2024 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777745; cv=none; b=l33g7HPxjTmJg/KpGv8Y4NERwG2WAulLQZIbz1uflELj9YT3Hk9zOnxb1eIdIein75WZpkcL8YyH3JuFTTod0VvgNgvusLaKkrNYH1aQO0mHAnO3BJtagsv6uRIqGiY/vzqgoIpGGwKUU4x5EzD0MLHtZGs3KwLZv5l+FpUAmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777745; c=relaxed/simple;
	bh=SH5a/ZrSrJrODl+yVkFTPggcHihxnp0KH6Mkhc2MrR4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n9kF6zOgpgP1+f2vNGuzKkzXs7R48GPtpwL1nNzxWsE3fluPdrkk9XV3DM+cdOi7kryI6RZ6wPfSngEfqKDyCPH0kyg4UlyjqRPD4ATtvg4J+G2H7NKu3WbTenq2nFH3bRIkh2BmfzAWa2zKlH3Qu5VdFDVXlBYGYEdNQMRSDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jPBN2E5D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IBLbNH005204;
	Mon, 18 Mar 2024 16:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5uwoDH3kbCTXxeMutaIDHslrE1LQRXq9d9NNePLLkrM=; b=jP
	BN2E5DbSTkXCTrwZz/mHDKCQ46NixffLKnzmuRtgXULJQKVfX+dSmAYIOdLjwt/7
	1rbxuH3TFxiqsVCwdraFDowiE+TmCg1R17ZnUg6in1wXoZvyzacqm3bVxI8rRivk
	El1az79gNwBlsHf18UFZdW+qWcjT3aNF8kT+jVESBTa5mD9ItSb6JWOLUxMdoHe1
	EDnrac85zir2Y7jlv2cEuB1o6He5jYNpDcoz1yOzrKyjkBCDmpIO0cl64PWPl2q/
	EeSzmKsbstH8+SMAJqIhBeI5hea1LX8WRmFhvIXSGqHvlvNG9Diw0iJH5q05TJDe
	mU7Bw6U5+EE+hx0tSwZg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxmnjrmq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 16:02:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42IG2DuC020076
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 16:02:13 GMT
Received: from [10.110.89.243] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 09:02:13 -0700
Message-ID: <c1b44950-95d2-4185-b906-4296ceec123d@quicinc.com>
Date: Mon, 18 Mar 2024 09:02:12 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Add firmware coredump collection support
Content-Language: en-US
To: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240318060249.1023837-1-quic_ssreeela@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240318060249.1023837-1-quic_ssreeela@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hsbU_oQyHFKupgA1s5D41EVjVApHtmju
X-Proofpoint-ORIG-GUID: hsbU_oQyHFKupgA1s5D41EVjVApHtmju
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1015 mlxscore=0 lowpriorityscore=0 mlxlogscore=600 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403180120

On 3/17/2024 11:02 PM, Sowmiya Sree Elavalagan wrote:
> In case of firmware assert snapshot of firmware memory is essential for
> debugging. Add firmware coredump collection support for PCI bus.
> Collect RDDM and firmware paging dumps from MHI and pack them in TLV
> format and also pack various memory shared during QMI phase in separate
> TLVs.  Add necessary header and share the dumps to user space using dev
> coredump framework. Coredump collection is disabled by default and can
> be enabled using menuconfig. Dump collected for a radio is 55MB
> approximately.
> 
> Tested-on: qcn9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Sowmiya Sree Elavalagan <quic_ssreeela@quicinc.com>

b4 shazam reports warnings when applying your patch:

Applying: wifi: ath12k: Add firmware coredump collection support
/local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:35: new blank line at EOF.
+
/local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:230: new blank line at EOF.
+
/local/mnt/workspace/jjohnson/kernel/ath/.git/rebase-apply/patch:298: new blank line at EOF.
+
warning: 3 lines add whitespace errors.



