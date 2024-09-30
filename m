Return-Path: <linux-wireless+bounces-13323-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A14898A708
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 16:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E6C280405
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 14:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C11917E9;
	Mon, 30 Sep 2024 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="dqFPEmpX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA31917E3;
	Mon, 30 Sep 2024 14:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727706608; cv=none; b=h3ICrds4YTLBgtZcVNTIOaKVVPRrJWRkwyk/pY4C9NOFjDn1hrgVosDryMTW/E5/jHmF+9HgYRnF1xdesaMuPNndG/YZOO7isUuo5J3Zr6HXKqDHudbyxzZamiVswrvo0unWObUxzIgzCsaKViOSIxxhehJFtEmJcaYjXytEIkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727706608; c=relaxed/simple;
	bh=b09YgrVJmvgRvMBhcaVCn7o5eWZqdGkkra9l64YUxvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LZRiRP3ye8wpZZv1OB0uNN9PuGq/gE1czugHx0DILgnqgDrDES2Oq21qVmZa2prLk2oUY8CfHWHoVmMBf49HF4gT79+jV4FxK2T7exuWCCrA5Naa5FSjvhvEdMBCNU9jV0vBZaiWTB0q9ljYp+Nx3FGZAkd4VbbTrZjJY7fzt7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=dqFPEmpX; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UCGRJH032600;
	Mon, 30 Sep 2024 14:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	67L6sCzfDHRdsopuyWGssY6DOebG1iMqtYOyqTtRtwA=; b=dqFPEmpXDy5qytvr
	82tYrmYnshp8ZE2clF0e/7yHufzsq2gFLNY+JMUDJu7aKKQGreJNgbL9femc9XOv
	ZIFPn2uA95sHOBDST70OXeLW8YmI1BSTt9SvkwXPc2RjN9+tm0k+8VMALy3p7iu5
	hIbmxDZ0ABdEJwFOtkZ4HsgjNfNzHQ8iQIUO/FsFRxVwTxo0xS6Gv5+khXZ9PTfN
	wRoxTELxgB6O/WjRmlE755q2uvr43AeaWMv9seRW3LnkfBf0WWhMXEqbO4S+O6cD
	uXezWMRW4lvQ14xcfw8E71qa+UafOy7UMwZ1Uu1op7XnNJmJ6+Pa7pWqyYqZw4Cz
	lMFkkA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xa12n0k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:29:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UETrCV008012
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 14:29:53 GMT
Received: from [10.111.183.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 30 Sep
 2024 07:29:52 -0700
Message-ID: <6a07392e-b296-4a1b-9444-aa0e2f7eb78c@quicinc.com>
Date: Mon, 30 Sep 2024 07:29:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/35] mac80211: Reorganize kerneldoc parameter names
To: Julia Lawall <Julia.Lawall@inria.fr>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: <kernel-janitors@vger.kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-28-Julia.Lawall@inria.fr>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20240930112121.95324-28-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oam3lfWcCdJQAVnqNPKThWDjszyIyDMS
X-Proofpoint-GUID: oam3lfWcCdJQAVnqNPKThWDjszyIyDMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=574
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300105

On 9/30/2024 4:21 AM, Julia Lawall wrote:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>


