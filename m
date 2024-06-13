Return-Path: <linux-wireless+bounces-8958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 398B790633B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 07:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02B31F233A1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jun 2024 05:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6848E320C;
	Thu, 13 Jun 2024 05:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EUIIWaPV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF9065F
	for <linux-wireless@vger.kernel.org>; Thu, 13 Jun 2024 05:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718254885; cv=none; b=cPgU/uZNqHVCqMlv6Fea5HDjHO0V4ovZmhJbWWQI3S1HkiMpRGBlbZU4k4wQ8U9p/J/pqyX9w7xarP/QGkozYee7nWYuttrU7i6B3Od6DuH6UlgWXepRmNxM4/dZgjuJharIErirjM1dZ/jkWSpjPbTZeJuKY/6MkWUO+qt/PUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718254885; c=relaxed/simple;
	bh=OwTP7V5A8VGrDiRWIRIn3PT+FC28qXKJqQybDUo9NC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=a6IxvOTcUzOEr2asYnMZsQUvq9pTbjJyryYnQBxt+CuyE80z2pM9DXCSEsR7XGgNho1putlqC34R3Txn5LejLmWOPQhli5KNLq7sC7Ln3OQGIIiuQaHveQtJMxbxmyFhAY4xhxc23jL5DwcGBB3dy5UwFmFKXbzYtFDDiLIQ+/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EUIIWaPV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKnPJK015742;
	Thu, 13 Jun 2024 05:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NzFnlLAyBr1f3Ag+qJol4CGgTLhPlRxCoo0wwW4qI5o=; b=EUIIWaPVTdMTQJYe
	b1PBQXW+QVdTnM0FT3xlEcb0+S49VV6VHTd/G72HMvnvoPdaOVWhpAB1Mg+HjDH9
	fJTkf6n9eBsG1TjZVTosM+rSTfI7G/HEJyCPCNdSxgcPoHQLShhOaTCfdXnkXa7b
	ZooWQwgV185vzOF6i/jTVcgIUN3BkypBOMxDiVm7ILcZVAYXIPG+1+9MGMjTTzNn
	inWdBK0xRwqMZj7kG+B0DHWM2e9S9SgFIr4lyLICg3myW9VzZKKjkzMR5XL6Ra4n
	uRn+gbets/pTLS48iBYPMPprSXgEN1WMCaSPRaDVjmDbEesD+yncg46Ic+BeeMVM
	50/u0Q==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ypm45d1j6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:01:15 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D51EL1008488
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:01:14 GMT
Received: from [10.152.193.243] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 22:01:12 -0700
Message-ID: <5b3c9394-bac8-4f94-9af8-686a76a3726b@quicinc.com>
Date: Thu, 13 Jun 2024 10:31:01 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath12k: Fix WARN_ON during firmware crash in
 split-phy
To: Kalle Valo <kvalo@kernel.org>
CC: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20240529034405.2863150-1-quic_aarasahu@quicinc.com>
 <87v82goha4.fsf@kernel.org>
Content-Language: en-US
From: Aaradhana Sahu <quic_aarasahu@quicinc.com>
In-Reply-To: <87v82goha4.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 75rxmJ7DYRhxCorNVFdryirz5iS0FymX
X-Proofpoint-ORIG-GUID: 75rxmJ7DYRhxCorNVFdryirz5iS0FymX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=883 phishscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406130032



On 6/10/2024 10:40 PM, Kalle Valo wrote:
> Aaradhana Sahu <quic_aarasahu@quicinc.com> writes:
> 
>> Whenever firmware is crashed in split-phy below WARN_ON triggered:
>>
>> ? __warn+0x7b/0x1a0
>> ? drv_stop+0x1eb/0x210 [mac80211]
>> ? report_bug+0x10b/0x200
>> ? handle_bug+0x3f/0x70
>> ? exc_invalid_op+0x13/0x60
>> ? asm_exc_invalid_op+0x16/0x20
>> ? drv_stop+0x1eb/0x210 [mac80211]
>> ieee80211_do_stop+0x5ba/0x850 [mac80211]
>> ieee80211_stop+0x51/0x180 [mac80211]
>> __dev_close_many+0xb3/0x130
>> dev_close_many+0xa3/0x180
>> ? lock_release+0xde/0x420
>> dev_close.part.147+0x5f/0xa0
>> cfg80211_shutdown_all_interfaces+0x44/0xe0 [cfg80211]
>> ieee80211_restart_work+0xf9/0x130 [mac80211]
>> process_scheduled_works+0x377/0x6f0
> 
> This is just the stack trace, not the full warning. If you send me the
> full warning I can add it to the commit message. Also it would be always
> good to identify what warning it is exactly as line numbers can change
> etc.
> 

Sure, the full warning is given below:

[  364.713223] WARNING: CPU: 3 PID: 82 at net/mac80211/driver-ops.c:41 drv_stop+0xac/0xbc
[  364.716875] Modules linked in: ath12k qmi_helpers
[  364.724598] CPU: 3 PID: 82 Comm: kworker/3:2 Tainted: G      D W          6.9.0-next-20240520-00113-gd981a3784e15 #39
[  364.729378] Hardware name: Qualcomm Technologies, Inc. IPQ9574/AP-AL02-C9 (DT)
[  364.739965] Workqueue: events_freezable ieee80211_restart_work
[  364.747082] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  364.752897] pc : drv_stop+0xac/0xbc
[  364.759752] lr : ieee80211_stop_device+0x54/0x64
[  364.763226] sp : ffff8000848dbb20
[  364.768085] x29: ffff8000848dbb20 x28: 0000000000000790 x27: ffff000014d78900
[  364.771301] x26: ffff000014d791f8 x25: ffff000007f0d9b0 x24: 0000000000000018
[  364.778419] x23: 0000000000000001 x22: 0000000000000000 x21: ffff000014d78e10
[  364.785537] x20: ffff800081dc0000 x19: ffff000014d78900 x18: ffffffffffffffff
[  364.792655] x17: ffff7fffbca84000 x16: ffff800083fe0000 x15: ffff800081dc0b48
[  364.799774] x14: 0000000000000076 x13: 0000000000000076 x12: 0000000000000001
[  364.806892] x11: 0000000000000000 x10: 0000000000000a60 x9 : ffff8000848db980
[  364.814009] x8 : ffff000000dddfc0 x7 : 0000000000000400 x6 : ffff800083b012d8
[  364.821128] x5 : ffff800083b012d8 x4 : 0000000000000000 x3 : ffff000014d78398
[  364.828246] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff000014d78900
[  364.835364] Call trace:
[  364.842478]  drv_stop+0xac/0xbc
[  364.844734]  ieee80211_stop_device+0x54/0x64
[  364.847860]  ieee80211_do_stop+0x5a0/0x790
[  364.852375]  ieee80211_stop+0x4c/0x178
[  364.856280]  __dev_close_many+0xb0/0x150
[  364.860014]  dev_close_many+0x88/0x130
[  364.864092]  dev_close.part.171+0x44/0x74
[  364.867653]  dev_close+0x1c/0x28
[  364.871732]  cfg80211_shutdown_all_interfaces+0x44/0xfc
[  364.875031]  ieee80211_restart_work+0xfc/0x14c
[  364.879979]  process_scheduled_works+0x18c/0x2dc
[  364.884494]  worker_thread+0x13c/0x314
[  364.889266]  kthread+0x118/0x124
[  364.892825]  ret_from_fork+0x10/0x20
[  364.896211] ---[ end trace 0000000000000000 ]---

