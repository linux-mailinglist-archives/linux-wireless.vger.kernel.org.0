Return-Path: <linux-wireless+bounces-13145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7334D9856E7
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 12:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40ED1C20F62
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 10:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82777158557;
	Wed, 25 Sep 2024 10:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aLclYhix"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAD414AD19
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 10:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727258882; cv=none; b=Aq7t4d8YOEmp4TIyVLB+ZeOhuyTYibWLNNvNMDEi75ER4Am0PZCfRTiBKb4a7DgKJwOSxOKwLs9qScIFODp3hpf8zDrluNQDQ7+3QCwFUj5WghF3zMCOHhNaX4C2+4RCAQYFoIVPlqqPq2hwUaFoz6lnqRF6NJ00/LgFFfiqKe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727258882; c=relaxed/simple;
	bh=+38GOmygiW9XUvstBAjolEL2L0r0UfsO4V78w/iowXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rabyUwh6yxRfbCZDd+9xv5dH2V/dtcYLEW+hUGQCdRqbNsg6RzkcBfmcTcniZzhGuik41K6Fxl4IP/NnE42/hlpKySS6XiBpQJZGQ7IJr6nofT6GL35f+OtpAwxFC0Q61Mb9aTuuEknE20AQCVz7AVeHQt4UmXe5I7MFDz19hMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aLclYhix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P8kIXw031702;
	Wed, 25 Sep 2024 10:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+38GOmygiW9XUvstBAjolEL2L0r0UfsO4V78w/iowXc=; b=aLclYhixJFdzp2l6
	+84y8J0zjgp9vX8HotS6Qrxxv4Dtl4TxcgD8DwOuB4ii+xsJoK3ihhUBVTU1Claq
	EOG2y6RFa01QACSsK6yn93NvYuzQXVO4uq0bLy6al14y1c+u8Ali/76tZjLmqwen
	8Rp7VdJ7io3ukHI+aujVw4+pHXZ/towcwzKucdLdFL7KEGr/hWcRjPA0krmrvy59
	IhTKrduCOsLhXYEgQq3wJ0SyxEeadXdXlhIQ71o2WGkPnN+JQJaQhjKu6I9qJ+qr
	afKwqq/bh+DUJM82mTdqXfageoP/I4UJI0DW1C9yW/EEBnXG5ZA14Umb1CqENMcW
	KvW8Mg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sph6utx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 10:07:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48PA7ruh012546
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Sep 2024 10:07:53 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 25 Sep
 2024 03:07:52 -0700
Message-ID: <fd90d471-503b-4f58-ae11-bae2afab08c7@quicinc.com>
Date: Wed, 25 Sep 2024 18:07:50 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k/WCN6855 neighbor report request made immediately after
 connection gets no response (with MFP)
To: James Prestwood <prestwoj@gmail.com>,
        "open list:MEDIATEK MT76 WIRELESS
 LAN DRIVER" <linux-wireless@vger.kernel.org>
CC: "ath11k@lists.infradead.org" <ath11k@lists.infradead.org>
References: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <eb41d8ec-c4f1-474e-a938-099f27aa94e3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kZUCtKEp1hFLA3jxvBaUhA7splbbZ8qG
X-Proofpoint-ORIG-GUID: kZUCtKEp1hFLA3jxvBaUhA7splbbZ8qG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxlogscore=999
 mlxscore=0 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409250069



On 9/19/2024 8:21 PM, James Prestwood wrote:
> Hi,
>=20
> I noticed an issue when we started putting ath11k clients on a WPA3 net=
work which seems to be related to the fact that management frame protecti=
on is enabled (works fine on WPA2 no MFP). Immediately after an initial a=
ssociation a neighbor report request goes out and we get no response from=
 the AP. After getting a PCAP in one case we noticed the neighbor report =
request went out unencrypted, though still had the CCMP IV parameter. The=
 content of the request was the unencrypted request, and something like 1=
5 bytes of 0x00 padding. I will say, this initial PCAP was made through t=
he AP vendor so perhaps it automatically added the right keys to decrypt =
the frame, this could be a red herring. I tried on my home network and it=
 was hit or miss, sometimes I would get a response but sometimes I wouldn=
't, but I did see the frame was always encrypted in my home network case =
though when adding the PMK directly in wireshark I couldn't decrypt it, w=
here on other hardware like iwlwifi I could.
is your home network also WPA3?

and how did you get the PMK? is it generated by IWD and printed as debug =
message?

>=20
> Some time after the connection neighbor reports work fine. I'm not sure=
 of a time frame or delay required that gets them working, but it makes m=
e suspect that ath11k doesn't have the keys fully added in the firmware b=
efore userspace gets signaled as "connected". Running the same scenario o=
n ath10k or iwlwifi has no issues. This neighbor report request immediate=
ly after connecting is IWD's default behavior, so its relatively easy to =
test by just restarting IWD.
I captured a WPA3 SAE PCAP too, but only can find some unencrypted ADDBA =
req/resp frames. for those encrypted action frames I am still struggling =
to decrypt them

>=20
> Since the neighbor reports work fine after some time its not really a c=
ritical issue but I wanted to bring it up just in case.
>=20
> Thanks,
>=20
> James
>=20


