Return-Path: <linux-wireless+bounces-14238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 042909A594A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 05:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32A991C212C4
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2024 03:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BB8208A9;
	Mon, 21 Oct 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MG+49zU/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494582C95
	for <linux-wireless@vger.kernel.org>; Mon, 21 Oct 2024 03:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729482155; cv=none; b=u/AaeSh/Ay/gHFclJ+5CqM1pTe6fqGnqfcbqaF6oOoapbXLEuAryl6m+Csem57b6u4HEGU782Wem5hY8R206ybiF1xpcohYpJPzzliFKOyPwQBFWCs0sd1mnzIVk4jalnAgFPPvneVYzAUvnhiHzuZxaNCVLnEZRpRuxz0yLTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729482155; c=relaxed/simple;
	bh=q9Y3agGMae5heb7QtJYd7L57USxzttEJvGVZw3BAyDw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=Dcuta1YG3BBn3H1DdUbtf+PlJu63y8J1hVMyS9CUYseB0j6ZnGOWFJkvOCPtFGCGZqI8GjQddTHT6NR1N7jRbCEPw11r4OVxe+nkfclt8UP8nt/0mEKLf7TGJhA/gFBCZSzYMD638otAStIMr6Z/73Es1LsN1hfMoZs+d4F0B6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MG+49zU/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L0U8rr032495;
	Mon, 21 Oct 2024 03:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ksLhW/V+p5aq+UYSCvfz+V
	/T+gkWpgjhCe1uOLs/VQc=; b=MG+49zU/35zOKGBwMs5+mdSSraOINX7ROiUyHf
	VJW8oEBbonEg57nvMslFL5vUkfBv+dI4+6uygzXZJR49msJ1T0yIQLguM0IG5sgy
	ERhChIzzjb1ref4gLBGFaqFvWxRTX1HhSA1ZElobTmB44z50qxBbQE1AfDv5nKqE
	2me+dGoGRZBrmZcgENcxhC71kAKfcrpKRoN8XRNBy8SamyW3NZ3vP1Kpor4sh1ib
	oi3jwc4H2LgL16HnLwKcrNHfHml+HH8HruGt0Okl+S8qHUdEaUytIdg+EKlaBL3Y
	BX+GeO1X8oDYp4a8DgvnFbTtR+fwcc2nWAdFvW79P1IYyWjg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42c6vuu3ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 03:42:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49L3gRr7032680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Oct 2024 03:42:27 GMT
Received: from [10.231.195.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 20 Oct
 2024 20:42:26 -0700
Message-ID: <9840f652-7d4a-4693-90da-844174dc30f5@quicinc.com>
Date: Mon, 21 Oct 2024 11:42:25 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Baochen Qiang <quic_bqiang@quicinc.com>
Subject: iwlwifi GTK rekey is not working with WPA3 SAE encryption
To: <johannes.berg@intel.com>
CC: linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ydHyaYliteC9snlSUpUlKxkaDsErnOGg
X-Proofpoint-GUID: ydHyaYliteC9snlSUpUlKxkaDsErnOGg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=373 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410210023

Hi Johannes,

My AP is configured as WPA3 SAE encrytption, and GTK rekey interval 30s. After enable WoWLan:

	iw phy0 wowlan enable disconnect

and put system to s2idle state:

	echo mem > /sys/power/state

I see in sniffer there is M1 frame from AP to station but didn;t see M2 response. AP retries for some times but finally kicked out station.

such issue is not seen after changing AP encryption to WPA2.

HW in use:

00:14.3 Network controller: Intel Corporation Ice Lake-LP PCH CNVi WiFi (rev 30)
        Subsystem: Rivet Networks Ice Lake-LP PCH CNVi WiFi
        Flags: bus master, fast devsel, latency 0, IRQ 16
        Memory at 603ebb4000 (64-bit, non-prefetchable) [size=16K]
        Capabilities: <access denied>
        Kernel driver in use: iwlwifi
        Kernel modules: iwlwifi

kernel is from https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/ and with version:

Linux xps13 5.19.0-rc8-wt-ath+ #4 SMP PREEMPT_DYNAMIC Tue Dec 26 17:02:03 CST 2023 x86_64 x86_64 x86_64 GNU/Linux


is this an known issue? or am I missing something?

