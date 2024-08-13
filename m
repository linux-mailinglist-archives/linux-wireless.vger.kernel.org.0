Return-Path: <linux-wireless+bounces-11370-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29174950C78
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 20:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAC30B236A0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DA51A38F3;
	Tue, 13 Aug 2024 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nJUo7rKo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D52D17E8EA
	for <linux-wireless@vger.kernel.org>; Tue, 13 Aug 2024 18:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723574700; cv=none; b=FgqT1mN1NUnMwLLe4989HLiBnBSUtay+c7Wb7eGkCyYVBC4uDpU9MXbd6JR5ttT9+YPRohIQZ2S0WT/33mRu/sRQLsIJy4b+I7iSyAPtkPpwIE6hHtwjTgIUh5GLESyU3ac2t0V6MiJ/q3KY55XC1sGJMyFDO0v0S6fzpw5l2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723574700; c=relaxed/simple;
	bh=Em7cUJw5izL4WWcctmkjBTWewXnAU1bKpfm7GAgQUvo=;
	h=Message-ID:Date:MIME-Version:To:From:CC:Subject:Content-Type; b=B2ww1zOjXrPTNZwD4RIRTtFmVRUuNAMA0qpN3+FYvik4AdBcvtXeObumElgAEG+xvVtrrKecPFUYmkrusfJI4cPFWtmbo8veOcUWeWQOeLVvfNX74Jr9cCISxdY3jSA7EzeCNJ81YzF+0wp92lTQxZvegglwX4mf9eESXMQQ5KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nJUo7rKo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47DCXA0s008159;
	Tue, 13 Aug 2024 18:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Em7cUJw5izL4WWcctmkjBT
	WewXnAU1bKpfm7GAgQUvo=; b=nJUo7rKo6ZPFcjqqhaeMkgIBH4OmVT+ZfJc4Nv
	94hX0Kaa7KVE8PPF5gNlxLErMSyXQUZTrv7lNyVRS6Avqt3QOpoqXF9XoTgnsTr9
	JU/882kSDZG6L3hToVBOC6xYUJXXy40M+/jJbagsbML+T0gkdKo4WlaqfNgp6cVz
	hjZ9T1AMAhAT4SnSKrbxLXTtQjvuz3vlr/R10bzOaYrvCQuD5fpV3vahBsyLgoGf
	dSoPTHZh6BuiFk6YkM0kb2keY3y5HVirfXCGC/LGRTvRIiV8g//BsD2F3Ge19xeS
	cDE14LXHuNvfO/IdhFVjjXL0/AcSRZry2LCDyYhzC4vIWtdA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40x15e8t3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:44:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47DIir6s028122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 18:44:53 GMT
Received: from [10.111.178.117] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 13 Aug
 2024 11:44:53 -0700
Message-ID: <cfbfa8f1-3367-4bc9-b201-2faac3aa7581@quicinc.com>
Date: Tue, 13 Aug 2024 11:44:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chen-Yu Tsai <wens@kernel.org>
Content-Language: en-US
From: Jeff Johnson <quic_jjohnson@quicinc.com>
CC: <linux-wireless@vger.kernel.org>, <wireless-regdb@lists.infradead.org>
Subject: Should the wireless-regdb wiki be updated?
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S5ZvGth25uDQ43M8Ph3z0S-HDnW80e6d
X-Proofpoint-ORIG-GUID: S5ZvGth25uDQ43M8Ph3z0S-HDnW80e6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-13_09,2024-08-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=680
 clxscore=1011 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130135

In response to regdb e-mails showing up on linux-wireless but not
wireless-regdb I went looking at the Wiki to see the current guidance:

https://wireless.wiki.kernel.org/en/developers/regulatory/wireless-regdb

I was surprise to see the following:

Sending updates to the regulatory database
Note: wireless-regdb is currently unmaintained, and patches or requests for
changes are likely to get no response.

Elsewhere in the Wiki there are some outdated references to Seth, as well as a
reference to "signed with his RSA private key" without any indication who
"his" is referring to.

This seems like old information that should be updated!

/jeff

