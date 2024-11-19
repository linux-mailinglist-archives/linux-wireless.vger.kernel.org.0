Return-Path: <linux-wireless+bounces-15506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBB19D29B4
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 16:34:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBF21281DFE
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Nov 2024 15:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5021CF2B6;
	Tue, 19 Nov 2024 15:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hdC+QXIh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF3578C76
	for <linux-wireless@vger.kernel.org>; Tue, 19 Nov 2024 15:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030482; cv=none; b=KqdRbXqSXKGPmWOkmWvpjR8CW4e/6GSdEmSUx+tkcQodb2dAXWeLetHUL5o9VzbeZmTlWyYkM3dMeR8WD/HlKbUXUAOPEkG8IlddxB1nViKZfE0NoB+ydscA0VdzJwkjJ/2UxRMo/ICqTb9J6pJbE/MYb8isf0XffEBdDxTM1WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030482; c=relaxed/simple;
	bh=8elBXPFfBZMz/YhqRxf2P6P7knt/FLy0S+9I0Ey5my0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=Z7etdjD4iZ+5wFuNliQ6JV8LA2w2MmNnJErcPT+bD12JvSvJ9OFWP6E8kPseaK4lrVfNO0VKr+YsBr14u1Yk3vZYFMpOQvzv2ANv3h+4vzEosnVCoH431DeMzlfC2cBQ7xihbTBfH+LFAJqQgSWEjsUty3ntYrUO38BHpK0wIHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hdC+QXIh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJ7iT5I004712;
	Tue, 19 Nov 2024 15:34:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5QykAg1FWy0/Ynvq/cWizV2FyfeR47E/OB1t9XvGt7c=; b=hdC+QXIhVip67IRW
	ocfNv7je8Tf1VV0BQ0uSc0UiXiPCSLycAWc6qqMgdlPBUIz8M9X647nnb9h060i4
	OWGdZlMHb7Ouyaord3H6NJjo0AyZVwoZ0xi0FKftiHQxUulD+dX6o3KArpa60yYP
	KhyWVpkFdS3DTi7NMcP8IOqqLSGjruNMc9dmlhixjIm0rviTMRAwV/bwWbZtnacu
	/NmtAaFqN+QL5u2tRjEkxLzA+t9JZHAfSqIrnhDS2u4/TnJ5iKTzooLPi1wcrMOA
	3mCa76sYjnCVfbFLuqkYSTLwbsVNl4xgS99JGVhK0Lljj76k66LMDS54GnqwkLNt
	FsfR+w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y7twwa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:34:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJFYUYp018968
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 15:34:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 19 Nov
 2024 07:34:29 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: Kalle Valo <kvalo@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
CC: <linux-wireless@vger.kernel.org>,
        Simon Wunderlich
	<sw@simonwunderlich.de>,
        Sven Eckelmann <se@simonwunderlich.de>, Felix
 Fietkau <nbd@nbd.name>
In-Reply-To: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
References: <20241106-ath9k-deaf-detection-v1-1-736a150d2425@redhat.com>
Subject: Re: [PATCH] ath9k: Add RX inactivity detection and reset chip when
 it occurs
Message-ID: <173203046976.60288.346351687516567007.b4-ty@quicinc.com>
Date: Tue, 19 Nov 2024 07:34:29 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SiOYmwf1qA0JlH46Bp0R-Uxl1wPTjSyZ
X-Proofpoint-ORIG-GUID: SiOYmwf1qA0JlH46Bp0R-Uxl1wPTjSyZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=277 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411190114


On Wed, 06 Nov 2024 13:41:44 +0100, Toke Høiland-Jørgensen wrote:
> Some ath9k chips can, seemingly at random, end up in a state which can
> be described as "deaf". No or nearly no interrupts are generated anymore
> for incoming packets. Existing links either break down after a while and
> new links will not be established.
> 
> The circumstances leading to this "deafness" is still unclear, but some
> particular chips (especially 2-stream 11n SoCs, but also others) can go
> 'deaf' when running AP or mesh (or both) after some time. It's probably
> a hardware issue, and doing a channel scan to trigger a chip
> reset (which one normally can't do on an AP interface) recovers the
> hardware.
> 
> [...]

Applied, thanks!

[1/1] ath9k: Add RX inactivity detection and reset chip when it occurs
      commit: b5f871ab4913b2403a7cdcbcde16d39d0b071fb3

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


