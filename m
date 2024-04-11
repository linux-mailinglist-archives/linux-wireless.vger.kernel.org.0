Return-Path: <linux-wireless+bounces-6204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA658A2102
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 23:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894951C232E1
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Apr 2024 21:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1101F619;
	Thu, 11 Apr 2024 21:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pV0xLs9q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3B383AE
	for <linux-wireless@vger.kernel.org>; Thu, 11 Apr 2024 21:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712871572; cv=none; b=NWXtyxZEt8+oKKfKV+so7f1OWasJn7obW7g8pEvzfqPIxhSMpqxlqCxGk1d7frGAria6Sf3L6mismiRzQ24ILJV9MepP9ENLkfRlYmzxfMeNXJkoU+57/z5FmoXMiBew7BVxdyx+Ez9sVJ0UeNlN6beQbqo5y5l1j5kDtG4HJEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712871572; c=relaxed/simple;
	bh=FWJpa2SO9bgY2HrTA4Q+Dh+ZvGfbP4if1mne2k0ezmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H1PiFNO04DZuDy6hY8Mi4lxWAHCursRqLU4FdyHZXVQrunaKxcEi0GQQaPtSmrPpg28KbPy3LrS0oZ14Wl0rdfc3ja7gZ3T/K4Gi+NsHfEED4m5mczaLUKwaPR7+OcnWwdG7p68fROQ/E+Cwr9S5ic1zbyWW7RwpCxqj6vnPafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pV0xLs9q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43BLHSnv028729;
	Thu, 11 Apr 2024 21:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tBm2jiJY3rEEe5r+/MkrFmr4jpv2JBIlBCacTGs5T5M=; b=pV
	0xLs9qvZ2QwOFug1bKZYc5ON2d8cRf1UnxayZg+u+vE/Fljn5ZLFmS09OL/2+Sn8
	rhZu5aX+EWWz5kvESpCiStszqyvci4jEi5jcsa1IG7pKworuqpxv37wi3EdyMGJo
	pzizHYFL5Tj+VGFeLhlTlJSu1VpVIU1XqB6KGAPT8dQdhHmSbr6MuOb6ob29R9Qk
	S5Icni84eLOwNoVVnoPYwFBBO9sccCPOsdQTdjFd8se7EhkZbsk7wzYJXaESlXIr
	rg+yxnldYtH9X38DWJb6Xc2Nq0wnESD4UISTZ30meuya25vdl0h6/49iq0UfSY/S
	tnBMBmOi45/ddHRzfOjw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xec6dj9aa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:39:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43BLdRGq018072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 21:39:27 GMT
Received: from [10.110.37.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 11 Apr
 2024 14:39:27 -0700
Message-ID: <77ae34e0-c647-41fd-a40d-5ade63ab8765@quicinc.com>
Date: Thu, 11 Apr 2024 14:39:26 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] wifi: ath12k: report station mode stats
Content-Language: en-US
To: Lingbo Kong <quic_lingbok@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240411025322.33888-1-quic_lingbok@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240411025322.33888-1-quic_lingbok@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9nQHuL_bTcmsxGhx_qF2hsSQYB9VRAFF
X-Proofpoint-ORIG-GUID: 9nQHuL_bTcmsxGhx_qF2hsSQYB9VRAFF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_10,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404110156

On 4/10/2024 7:53 PM, Lingbo Kong wrote:
> Currently, the transmit rate, the receive rate and signal strength of
> “iw dev xxx station dump” always show an invalid value.
> 
> This is because ath12k has no logic to handle this relevant information.
> 
> To solve this issue, ath12k parses the information passed by the firmware
> and passes it to mac80211.
> 
> After that, "iw dev xxx station dump" show the correct value.
> Such as:
> 
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  600 ms
>         rx bytes:       4642228
>         rx packets:     23796
>         tx bytes:       933967
>         tx packets:     8761
>         tx retries:     66
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      8925
>         rx drop misc:   191
>         signal:         -20 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>         tx duration:    0 us
>         rx bitrate:     1801.4 MBit/s 80MHz EHT-MCS 11 EHT-NSS 3 EHT-GI 0
>         rx duration:    0 us
> 
> Lingbo Kong (3):
>   wifi: ath12k: report station mode transmit rate
>   wifi: ath12k: report station mode receive rate for IEEE 802.11be
>   wifi: ath12k: report station mode signal strength
> 
>  drivers/net/wireless/ath/ath12k/core.h    |   4 +
>  drivers/net/wireless/ath/ath12k/dp_rx.c   |  20 ++-
>  drivers/net/wireless/ath/ath12k/dp_rx.h   |   3 +
>  drivers/net/wireless/ath/ath12k/dp_tx.c   | 147 +++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/hal_tx.h  |   9 +-
>  drivers/net/wireless/ath/ath12k/mac.c     | 180 +++++++++++++++++++++-
>  drivers/net/wireless/ath/ath12k/mac.h     |   3 +
>  drivers/net/wireless/ath/ath12k/rx_desc.h |   2 +
>  drivers/net/wireless/ath/ath12k/wmi.c     | 130 ++++++++++++++++
>  drivers/net/wireless/ath/ath12k/wmi.h     |  48 ++++++
>  10 files changed, 537 insertions(+), 9 deletions(-)
> 
> 
> base-commit: dc410c4accd2fe64479a1f4ebc47ec9cd3928f4a

FYI I'm not able to verify this series since it conflicts with the pending branch.

Patch failed at 0003 wifi: ath12k: report station mode signal strength
error: patch failed: drivers/net/wireless/ath/ath12k/core.h:607
error: drivers/net/wireless/ath/ath12k/core.h: patch does not apply
error: patch failed: drivers/net/wireless/ath/ath12k/mac.c:7561
error: drivers/net/wireless/ath/ath12k/mac.c: patch does not apply

Note that wireless-testing doesn't have the following series which conflicts:
wifi: ath12k: Add single wiphy support

Can you rebase against either ath-next or pending, both of which have that series?


