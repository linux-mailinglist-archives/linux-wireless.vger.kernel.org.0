Return-Path: <linux-wireless+bounces-7611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E38C4881
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 22:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE230286220
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 20:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CA580BF7;
	Mon, 13 May 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y88OngXy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210307F496
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 20:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633535; cv=none; b=UqT/yAAltPYy8bcGGwft8/nuBZWkClncl4ADqEp+4Y+Bdk3Ga5oeaZdZVg9qZvDfZ0Ry0zQkiIgSGjvPmrnOCI+jdTRihLHNc3BezMYnv3O2dy/svuXcZpC5+93PFi31Boiw2jKzcrm/hCjJnr+W5PhfTrYUaXJINmEca1gldb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633535; c=relaxed/simple;
	bh=A8kmSw9JSMy6VGS63f/TWne7Wmnuj0oGyhdDn6hNteU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RWXeA8JqwuBnHbLirrV+Q0agUM7YJhh8ZXts8tE4p8c+tiUlDoY+l3XwQwjq7HBnyTIKT2NPjw4Y3TFh2eiq17zYT+41eYo/70KSmNBVqG5d57zeZej0YW/gFhw4Rm4/BQ7v69w/f7RLICSMm3qMZmEGtdxZSSFT4QOa6BW/vjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y88OngXy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44DJ8rUc001193;
	Mon, 13 May 2024 20:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=eDsc9pk/eydLP0xmnlQiV+qyHnf9r6A0BUULnPs4WPA=; b=Y8
	8OngXyjBTUSKmM167nhtxePA9Kbm9Kj0qnaSNbxOaLmWlmPE/EgP7L9OSFuxS+Ej
	n18wXSghF7YHoGc50BaAjWCAQaJE9AeS2m2QjujkV/aTIxL41QJM7guA9diyKFCU
	BU3jCj/b+TOJwUkkTBJ/qhR/e0T8/aOBzqOFcipZ+tO34z6+ttl7eiUEWXlz/cQU
	co6wg3vDuSAhZi+FWOuV2jKq8qJ3rTeYqJkYjzgTrat694v0G6D9+kVRUvw9edib
	FGyN/qcw7JJ+TpZ9JcqVyMEtfYRYIk7Mjij1BCypOdHWcK5pXyzxiR204Lla3SKw
	/Qs+/7cuY9Yb7lh5ci9Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y1y9kvksx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:52:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44DKqAS4023027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 20:52:10 GMT
Received: from [10.110.0.4] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 13 May
 2024 13:52:09 -0700
Message-ID: <8d154a30-888e-4e9e-afb3-d5ec27223e67@quicinc.com>
Date: Mon, 13 May 2024 13:52:09 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 06/10] wifi: ath12k: fix TX and RX MCS rate
 configurations in HE mode
Content-Language: en-US
To: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>,
        <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240508002055.17705-1-quic_pradeepc@quicinc.com>
 <20240508002055.17705-7-quic_pradeepc@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240508002055.17705-7-quic_pradeepc@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gCAKaN9GYE3ndntZ4TNkyPu3zXCCy5kc
X-Proofpoint-GUID: gCAKaN9GYE3ndntZ4TNkyPu3zXCCy5kc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_14,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=938 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405130143

On 5/7/2024 5:20 PM, Pradeep Kumar Chitrapu wrote:
> Currently, the TX and RX MCS rate configurations per peer are
> reversed when sent to the firmware. As a result, RX MCS rates
> are configured for TX, and vice versa. This commit rectifies
> the configuration to match what the firmware expects.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


