Return-Path: <linux-wireless+bounces-13967-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBAF99F3BD
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 19:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DA11F2355D
	for <lists+linux-wireless@lfdr.de>; Tue, 15 Oct 2024 17:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4481F76C6;
	Tue, 15 Oct 2024 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LtE5tCH1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA117335C;
	Tue, 15 Oct 2024 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012448; cv=none; b=qs0MLI4Kz5L0Z/GNPBha40fCZ2gnnK0DCcItuCKXLDBmLXSLmYaigLCf8kcjNCXR5lNihXcw6HTUpMGHhnimvMg7plU+0rtzJQEIVQBAZ/YC0eZpXQNIDSdGYqI8cbh7wZ7YdlJGZ62EwjBfOhVWk/FtKZkKwkzg609csPM+vLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012448; c=relaxed/simple;
	bh=6hhjjX296MgLHzT7WDibRPRupKhNhJn+ECmZjq6lcxI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=VnRrd/bqlMlo3ZH6ugSb/ySZO/tAWHJTJTzVX1Ch0mLnsHv/BiAom9gp/iA9gE3IwfK6sY7wfGv/NbWlnIVbAFB7FgdrSy9No9ItX1hlfLJIwZrP0edGO9HHRy2o379kSxgzgrK4F4HyBclElwot6w9+O3vlPiZHTWU1FLubSqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LtE5tCH1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49FBZ6en005958;
	Tue, 15 Oct 2024 17:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6hhjjX296MgLHzT7WDibRPRupKhNhJn+ECmZjq6lcxI=; b=LtE5tCH1P7Hskj3N
	Oow7Vw1oIFSoRD56HvCGnNQ4N66kk34irvHjfI/9KkT8PnWOHQ3iFHpapaTX4Is9
	2b23h7/XEemeZGCeOLzGp31lAY9TCdAm5Gft+/et4MN5MssuCRItUJYScHsaZwNe
	yiYBd3dzHHr8E+lA7Vemb+OMeJSSh+ZvUVDhBb25j7qXb4oM4A5tV9luFjWKghGh
	ef2ut9MTXrvzR7QrDMdc9naE4wyNREgJxki5dPHHoJGWTqFyrtqD47ne8JjoXWAE
	QSnH39jNI86FQfm+0ayTUP8KAGytRt5AE9YHoTag5Z/MGIAbvHQ8INRXJu7NrL2l
	zVwyDg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427g2rrdyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 17:13:57 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49FHDvCl031597
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 17:13:57 GMT
Received: from [10.48.240.238] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 15 Oct
 2024 10:13:55 -0700
Message-ID: <fd99a66e-edd7-4c01-bc10-3596fb24f637@quicinc.com>
Date: Tue, 15 Oct 2024 10:13:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: ath12k: fix warning when unbinding
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
References: <20241010175102.207324-1-jtornosm@redhat.com>
 <20241010175102.207324-3-jtornosm@redhat.com>
 <2f6f7649-772e-42e6-a762-f2d66b7e3b22@quicinc.com>
Content-Language: en-US
In-Reply-To: <2f6f7649-772e-42e6-a762-f2d66b7e3b22@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rwkCopgQ4arcmTJS5_JcF7MkiKjuCRS3
X-Proofpoint-GUID: rwkCopgQ4arcmTJS5_JcF7MkiKjuCRS3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0
 clxscore=1015 spamscore=0 adultscore=0 mlxlogscore=624 impostorscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150118

On 10/15/2024 9:48 AM, Jeff Johnson wrote:
> On 10/10/2024 10:48 AM, Jose Ignacio Tornos Martinez wrote:
>> If there is an error during some initialization realated to firmware,

s/realated/related/ (also in 1/2)


