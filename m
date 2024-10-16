Return-Path: <linux-wireless+bounces-14100-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B28C9A0DED
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 17:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F2B26B28
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86270206066;
	Wed, 16 Oct 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="j+xpyv7l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AC054F95
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 15:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729091902; cv=none; b=OzyjDyGOpvI9OazFfN9uydmXhQFuwfHGa3d0DOCfRVnvf+cWphQpW+ssz+QQLn8Wml/Y+4HE7FK7/rp9nKrMBmMs1nHboGmXD9s3mbPmOsDPxpV6TLbvzH96a4OSQ1MnHDde2JVVOYKsYRWNxvNtbJnjkvOsUoo3icgBZuDkt+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729091902; c=relaxed/simple;
	bh=zQLzjww2/avl9LDJi5JsWe2oxq1UBZca/I9CPTuRXVk=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=cbRwv8Sxbh0KAs+1znT1UDEfQ1gisQrkhKyDh2QLqVP+oAnJ4Xx6iBNu5CpoJVcHYiwjFEipi7Bb8h2I84/3V+wLIbLukLpyGXe/nJQkSHb8lPAzyux5AgwVMpi1Gr/9lQLwAA1xMqCn3vtTZbog0AQ9bhpE/13NFrFaoWqsDOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=j+xpyv7l; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GA0sJ3013279;
	Wed, 16 Oct 2024 15:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F/FYIpmSNaJmYrwaqExhTPX9lxFmMmdljl/54/P7u5g=; b=j+xpyv7loqtBl/Bp
	afks8OQR8zj7+PHSBZwykC5DJuHq14DSs5pg6J15FvqX/7q3ns/x/hl2eekDdwPO
	RDUohYEPTcb2XRuuIkRhfubJEx7Fi86rjQCkXOiRDWcCQQL9Mo2PPqqOxow3p56r
	9Q+qiCzPVqGdMVuegZ3imkk7c2+ag8+cjCcSYElXJfynjgZkXmcfIc1eL8NwsJ1U
	NL3KCWg1/67PW4E8YHOOBwUSytWD7LDoccg3JgI/bEcJXJEaSZsreirAZgys2b7F
	aFsplORsgVfKQjj+p6NQsNqvk5ky1YzLYNI5hm7ZzEwhtxM4cuhvc029ar7uAdwc
	BijaNA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxs284-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49GFHuT0028664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 15:17:56 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 16 Oct
 2024 08:17:56 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: <linux-wireless@vger.kernel.org>, Rosen Penev <rosenp@gmail.com>
CC: <kvalo@kernel.org>, <toke@toke.dk>, <nbd@nbd.name>,
        <yangshiji66@outlook.com>, <hauke@hauke-m.de>, <jirislaby@kernel.org>,
        <mickflemm@gmail.com>, <mcgrof@kernel.org>
In-Reply-To: <20240930180716.139894-1-rosenp@gmail.com>
References: <20240930180716.139894-1-rosenp@gmail.com>
Subject: Re: [PATCH 0/2] wifi: ath5k: add two PCI IDs
Message-ID: <172909187652.412681.4227275275376879963.b4-ty@quicinc.com>
Date: Wed, 16 Oct 2024 08:17:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lIChlKuV9yLiLZ7XHWPIkyWrNaPJ6a85
X-Proofpoint-GUID: lIChlKuV9yLiLZ7XHWPIkyWrNaPJ6a85
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=333 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410160095


On Mon, 30 Sep 2024 11:07:14 -0700, Rosen Penev wrote:
> These have been hanging around OpenWrt and never upstreamed for some
> reason.
> 
> Rosen Penev (2):
>   wifi: ath5k: add PCI ID for SX76X
>   wifi: ath5k: add PCI ID for Arcadyan devices
> 
> [...]

Applied, thanks!

[1/2] wifi: ath5k: add PCI ID for SX76X
      commit: da0474012402d4729b98799d71a54c35dc5c5de3
[2/2] wifi: ath5k: add PCI ID for Arcadyan devices
      commit: f3ced9bb90b0a287a1fa6184d16b0f104a78fa90

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


