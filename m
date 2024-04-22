Return-Path: <linux-wireless+bounces-6686-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E60F8AD389
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2DA01F21DE6
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66395154424;
	Mon, 22 Apr 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="d755hgkB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05633153BED
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713808329; cv=none; b=mAmRoIyWW8FVQRKWZ6Kf9IUmg0esgxHTrk+tq4R9vVEp00bDttaBjk5dW0gHaBgBu19Xd+Wc8gkR0HWMB4D9+w4MVfB1jfBIhJ9vcEL+1Yvc7b4PPECYS3yO4NRDP364ywj+FBu1J/plHamhxg196TOLcK+x93SaKBSrn93N4aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713808329; c=relaxed/simple;
	bh=xapr2vGBSMxRcpoGK+wpkvYd++zB/CO2uaUU4dSLH+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mAYkUZNyigVfL8OE1ZPs6/O4YKOp4Gd++uHBW0CHu5z5DXtOKTWCQjigTnBSdwi8gJii1dmu7KLZeZ1ej/IZGjTzKqCzaEXRQShin00a8OdK916ztOvpRSBymlgJVsc62mEItof7Oq4/q+OAqsLmEBUea+lfW2T58ZnqQavtCTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=d755hgkB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MFQB3f020549;
	Mon, 22 Apr 2024 17:52:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=dMatxaznbfHN2DlNPykUz3hj551MmZqe8h6PfKf1pdA=; b=d7
	55hgkBw+EtVhhqBbbwrZq+bJrIZM21b+xxFR3BwHofWn8dXVP6exzJ+taAH2nYrs
	MQO+q8LpxZ3Anxp/udIE30D0AFy2vPkIJw0URPnAMnsFU7CwG1V2jM+10OMvhUMQ
	vP6oHlzqoQ+UPlQ1wVr+8M/+c5I7xbU87Xswbsyx1HAQkyNd65ftlvuiknP4abot
	MlevtrAQkamEqKXHKtHWXOt0/t9KZ8CbCutlWReiREvI4bFmO6JXmHh3RASlJ7FQ
	xg00ZHb+jBzTAQpR0ucYoKexeFJ1Xs8M3ZeIQvLZG4IlQNKfMVvCFmdh58L+se3x
	VxK4MT4Tr9r9/Ffnd9EA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnne298qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MHq32R029226
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 17:52:03 GMT
Received: from [10.227.110.203] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 10:52:03 -0700
Message-ID: <76020858-ca74-4f56-ae34-6a2d02dcda4e@quicinc.com>
Date: Mon, 22 Apr 2024 10:52:03 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] wifi: ath12k: flush all packets before suspend
Content-Language: en-US
To: Baochen Qiang <quic_bqiang@quicinc.com>, <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>
References: <20240412060620.27519-1-quic_bqiang@quicinc.com>
 <20240412060620.27519-7-quic_bqiang@quicinc.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20240412060620.27519-7-quic_bqiang@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z-qEprKeH5Ie814DwqBw-8w7cx64VZuh
X-Proofpoint-ORIG-GUID: Z-qEprKeH5Ie814DwqBw-8w7cx64VZuh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 mlxlogscore=809 mlxscore=0 malwarescore=0 clxscore=1015
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220075

On 4/11/2024 11:06 PM, Baochen Qiang wrote:
> In order to send out all packets before going to suspend, current code
> adds a 500ms delay as a workaround. It is a rough estimate and may not
> work.
> 
> Fix this by checking packet counters, if counters become zero, then all
> packets are sent out or dropped.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>


