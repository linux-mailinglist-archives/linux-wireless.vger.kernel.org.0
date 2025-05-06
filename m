Return-Path: <linux-wireless+bounces-22656-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D899FAABAF0
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 09:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468C77A38DA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3B51FAC42;
	Tue,  6 May 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IBcqB+4A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6751FBEB0;
	Tue,  6 May 2025 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746513852; cv=none; b=SXwAqYwd+9B52Eh/TJL2fFZ+yhXFBkC6f7HPaZ8DCTh5/rJhFJbxM/luEOGwG8vCuTaSjjZ+9Ayp1xo4F7rB7Q88CQxYBztx/xEr5u23xqrgg+e+NUcOgGpnoUUqP2S5eGfpNemZqs9C2EPvYgBhM9MH3Dy3fVAQl+dNMuT1E0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746513852; c=relaxed/simple;
	bh=D6l5a6yLH8qWV9KPFdows+TcDdIFYb2ufnL4LDozxTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bt4F3NwQENELmOZikHs2C8K40j151mK954zUseggBeMKqR3/XdeRrXuvmux+FDarzuDj6K+HZAjlPE32j/U1uKoc4f8CQFhfp9xVIA7wiQIuzzcD6yHgnqZMKREtyPMv0i5yNKnfp5cf4zQrEL5hh8byR5JXxGp0Jdts3s+KuNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IBcqB+4A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54619BlZ006486;
	Tue, 6 May 2025 06:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WK9L3OkxqSiRGKVbkuqEXufHIwwknHBbNopS0E5l9bU=; b=IBcqB+4AEzSoAia9
	ZBeU32r15qVEuYTnke5awAS7Gz7HBqSQcK8crFs0fZ/hYlYRkdvgw1CqHPJ8FH36
	Fm8v7QXLppEIRBMJl005edOPuoOGVGnpqghNEq+NN4gUd+fWiXVBwf394UBOmMbs
	ZuVFjq1jMA4zPyZr7RozEMNxREAB5Fwlzi/ouMaFigsi0942nkREjkurzJQGceOv
	yC94YpTqW1zIS0etxtG4R5HFkvt7sXeaNSrJlmofd39UwsODGcQ+/CORK2fsPpip
	qgeW+ckQKgAQDyMMbwEXeQSViUZ09rL/cQqOEI3m3EgO8FStdZw0nkFJoob4EjuP
	4qrwNg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46f8gw0tbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 06:44:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5466i6He018627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 May 2025 06:44:06 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 5 May 2025
 23:44:03 -0700
Message-ID: <3732e542-5b8c-4351-8e41-f9f0cdeb4643@quicinc.com>
Date: Tue, 6 May 2025 14:43:58 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: ath11k: Fix memory reuse logic
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Muhammad Usama Anjum
	<usama.anjum@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
CC: <kernel@collabora.com>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20250428080242.466901-1-usama.anjum@collabora.com>
 <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <f58075f7-f643-4e47-b774-dc529aaa01e5@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -IkgXWHcJwJ3dmWydU9yVdzL9aRb7sSb
X-Authority-Analysis: v=2.4 cv=fdSty1QF c=1 sm=1 tr=0 ts=6819afb6 cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10
 a=IiQ9mteBGh7z-pP5onEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -IkgXWHcJwJ3dmWydU9yVdzL9aRb7sSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDA2MiBTYWx0ZWRfX32EMiA/yAugn
 +eQZShxByN+UzXcd4GlE0meN3Jfw/n+tD58rpecn1LF3uV/bdgMZj+N42NirSzUYX4h5GqhUjtM
 swffFngQt+5h12OM429VGbs+2+a25QJH0HDUHh/lLY6EmFaRsjxKzgNhDXCjrVAsOeya1DGZ7Ju
 q0o5FKsv2A4R8vSSgAHgp4ImbuBwwEMPwQbAhjHHBfo8pHISE9MPkddUvxDGuTI9eTRu9B2OYTi
 24CmEuPcqOGcPFKLcoajU1ZuXZzNxJpcavTQQz5M0IWOHVDL+yZwP/Lh3CcogfOJVrWyRDsipW+
 al+/193/JJnZs7OmTuRlJU/ErXcxYyhrbPVAoN5vUVxgmLMaijv84Q+dfGIqcetU0gvIIAAwgV/
 hrA6XkbLsJgZgjbSPtKtTXnoYB1/YwVgaea7MhLuqhm/rr4sFpIXgxQcV4CvWyRtIwQtcEFu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_03,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=866 impostorscore=0
 spamscore=0 mlxscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505060062



On 5/6/2025 3:17 AM, Jeff Johnson wrote:
> v2 feedback was not incorporated:
> For starters, can we make the subject a bit more specific, i.e.
> Fix MHI target memory reuse logic
> 

Ideally I prefer below subject

wifi: ath12k: Fix QMI target memory reuse logic


> But don't repost for this -- I'll make that change in ath/pending
> 
> However, does ath12k need the same fix?
> If so, can you post a separate patch for that?
> 
> /jeff


