Return-Path: <linux-wireless+bounces-6661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 252CF8ACD37
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 14:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD08285388
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 12:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F90B54FB8;
	Mon, 22 Apr 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R7zdDku6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69414A4C7
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 12:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790019; cv=none; b=hamQ1ICBhOHT2CG50mSITRQfTJ0mQsUJZBsMm3alZz+eBuiTx9LngWjVL+Zy4IJYS7uTJiFC2CQqt14RO/WVuEZ+XGa6NVxiTRUnM2G5/4cAMQQ67mZ6zKsoG3WdlxryUKEMHEQtZEZyQ29K7OXwZU8FboJPwcVhCX5iELtd6wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790019; c=relaxed/simple;
	bh=0/qAVmZW1zs2Q1B856gFYfcLnIFFYhaTAdS6PK43XyQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=DbGTbEtpPdmYW6Uuit7GE4a1Qi8UTKPQBbvrza/ai7sByqI82EeRtD2AicZcg99pgzHmE0i26tDsyucnLOuLWGV5yMothZekZZaa8yTLUslyH8iu/78Fw0CyPq/SRZA5ILOi3aSJy/XEC2cMeQO7QrnrBwzXTdXH7AXcq69w6DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R7zdDku6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M9OnUh026499;
	Mon, 22 Apr 2024 12:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ALDfA2ZDxAlRxWBlXQMCIynW5wm9GKrgPTnQ6O7BQRg=; b=R7
	zdDku654Q8h0oQMYma4sCyzbg6UKn6MkZ8lCbTHptk98+sHxFsSV30cClKwxGFZK
	KTlDlJIK+HDelDqX983StrDwWTkbFhDjV9d74kxhblwt2+joSARYUtOxSrsRYqeC
	S3FjBPK6AGEO37C4R1q1GmZ98cvjYIDv9ijE1DGs5DxVAqrwGTI+5kgLfTZEaaDt
	14/gHrf+ptfh24sR4xLbjjtA2r3ZkODo5+AtuVNGUMuLwpJV5Ox9933IhdgxgPpG
	RdT0PKXIdExcTvXHx8F3caiP1iANLtJ+32zKUo6Sm2jF1VokLe4a1eJmSsQ8tpqc
	MSeoRA7nN2ydXK2HbtcA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnn82ggs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:46:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MCkrNT011947
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:46:53 GMT
Received: from [10.216.22.65] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 05:46:51 -0700
Message-ID: <3f62b373-cbdc-4dc3-ac74-7868692d755d@quicinc.com>
Date: Mon, 22 Apr 2024 18:16:47 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] wifi: mac80211_hwsim: add support for BSS color
From: Aditya Kumar Singh <quic_adisi@quicinc.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>
References: <20240416045943.576656-1-quic_adisi@quicinc.com>
 <20240416045943.576656-8-quic_adisi@quicinc.com>
 <01fc6041e04b05ac6909a9818c9a890628542373.camel@sipsolutions.net>
 <99cbc879-3cbd-4c35-b5dd-991f8871607e@quicinc.com>
Content-Language: en-US
In-Reply-To: <99cbc879-3cbd-4c35-b5dd-991f8871607e@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yhgcKI8uw_HTHhhv_4wIsM0dvCkaMXud
X-Proofpoint-ORIG-GUID: yhgcKI8uw_HTHhhv_4wIsM0dvCkaMXud
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=867 priorityscore=1501 clxscore=1015 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220057

On 4/22/24 14:18, Aditya Kumar Singh wrote:
> I have added hw_sim test cases to test and validate it (non-MLO or HE 
> scenario as well as MLO).

Here is the hostapd change -
 
https://patchwork.ozlabs.org/project/hostap/list/?series=403938&archive=both&state=*

