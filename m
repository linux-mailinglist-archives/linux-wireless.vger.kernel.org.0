Return-Path: <linux-wireless+bounces-9552-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC021916F68
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 19:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02CAF1C2240D
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Jun 2024 17:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B6143C72;
	Tue, 25 Jun 2024 17:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LciV7TuM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48436135A69
	for <linux-wireless@vger.kernel.org>; Tue, 25 Jun 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719337139; cv=none; b=HNOZQsJPMxhSo8yIsCwKhypAmOGDSx153lsn5hn+qqZymQ+l00d1F0PyamFt/cUXi7jcR1oyEwnGB477OVjcjI730ErrWhiLmqO85ct2Kwe0+00vJ3fkx8BMX/iervbDqs8RmISFFiDZC5YQUob/QbhptdKhSlMx8rRbabDyJJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719337139; c=relaxed/simple;
	bh=lm32VVPinIzDH7BeMnqogTFuOF3gWjrAwWKfrWn4UgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=X5MNDpopTD6Be9sJ4QbkGa8qu52uNjNmaOriL/ouFVn8JYMlu5tzS81rqQOgBz2DiggUpP2rcLajWZ+JtSjCP8Dpl9WKHx0Nt17ChEije20wcoTS6liEFP7Yi3KTNezUC3N6b0t32haZX1jWIpe56jJl8W5hOJs5aSuzKWSjpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LciV7TuM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PGosf2029160;
	Tue, 25 Jun 2024 17:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rsckhxO2eyvlVTzi/1TuZcLt9XqppgZI6qdch4c+MsY=; b=LciV7TuMVgm4vOP+
	HPoxnvDMzi1wIDgB43a2QxpZANZfG5LZ4jrkpyNTklmlwwtieHze/TUDbwOuzy3M
	5jFaJn2ei3CpeIdbkubvkdze/0qq+/Ps7cOFTqBIPb4gCBDizWYLOY7AuQ0aC+r3
	NLglfdy90g3c7F/9TK01vapIvNIuSkN3B07LpGYbOBjjLGxW6BSr+/2JzjMDipwT
	1b2io9jylSTeJmhpErBW/Nl6PSOUct/edyC/f2cp+Ft/z0Z6o2tAJjtcCuN2Ibuy
	LW5YzVWSOats1fpAHEV5hLRncQKzxbl/rNq8oCGY97eX0ZRkfKazHQ/v+2lA5yEx
	CmgEtQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywq0779p0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:38:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45PHcoCn006084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 17:38:50 GMT
Received: from [10.48.244.230] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 25 Jun
 2024 10:38:49 -0700
Message-ID: <56e31e2c-e174-4bee-9a9e-7378fe71ef06@quicinc.com>
Date: Tue, 25 Jun 2024 10:38:49 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: fix peer metadata parsing
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240624145418.2043461-1-quic_periyasa@quicinc.com>
 <87frt1hvc9.fsf@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <87frt1hvc9.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xzchcks9JTZHO1ShPk370PK4YJfKq39d
X-Proofpoint-GUID: xzchcks9JTZHO1ShPk370PK4YJfKq39d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_12,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406250129

On 6/25/2024 8:53 AM, Kalle Valo wrote:
> Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:
> 
>> Currently, the Rx data path only supports parsing peer metadata of version
>> zero. However, the QCN9274 platform configures the peer metadata version
>> as V1B. When V1B peer metadata is parsed using the version zero logic,
>> invalid data is populated, causing valid packets to be dropped. To address
>> this issue, refactor the peer metadata version and add the version based
>> parsing to populate the data from peer metadata correctly.
>>
>> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
>>
>> Fixes: 287033810990 ("wifi: ath12k: add support for peer meta data version")
>> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
> 
> [...]
> 
>> +static u16 ath12k_dp_rx_get_peer_id(enum ath12k_peer_metadata_version ver,
>> +				    __le32 peer_metadata)
>> +{
>> +	switch (ver) {
>> +	default:
>> +		WARN_ON(1);
>> +		fallthrough;
> 
> I'm a bit wary of using WARN_ON() in data path, so in the pending branch
> I changed this to ath12k_warn():
> 
> 	default:
> 		ath12k_warn(ab, "Unknown peer metadata version: %d", ver);
> 		fallthrough;
> 
> The benefit is also that now we print the unknown value. Would this
> work?
> 
> Please check:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=0228ca402186a123e5c90187f952121de50bf64f
> 
LGTM, thanks!

