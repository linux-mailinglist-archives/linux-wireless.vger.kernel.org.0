Return-Path: <linux-wireless+bounces-1043-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BEF8819356
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 23:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB43328424F
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 22:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98103D0A4;
	Tue, 19 Dec 2023 22:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n2xrHMAb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD53C69F
	for <linux-wireless@vger.kernel.org>; Tue, 19 Dec 2023 22:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJDoHpv023644;
	Tue, 19 Dec 2023 22:03:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=lTTmPE1EolbryFBM44SZogFmD3S/VI1xjecu39GfStw=; b=n2
	xrHMAbBU/+E3nSIlOfX1BFLxqsqaHXsFLi1p33miu+K1vQQDz88/e3c9cD0JGSda
	dXFLTH9XeMLSS6X1F7XEhdQP5Mnzmh/1cQu40JSQ9fqUzPBhdVwPkcgwbDUmzPLl
	a1AfjBSvtYVDpH+xLZaX3f6Nut9aHjgCU2nxwaSOCPs5pqKCg3atim3KSoFjufJR
	D9I3RpBwM7gDK0hgGoWkw3UAJraNRhJ1AyzqdTn0XYLcRgPMXevcvO/p/3zBkD5m
	4Wds3VgCcEc408reLU/gU4yC0S6dXZlhfQqpCkomDYdCd7ZaF+8TYotBh7B/rTLh
	CqVNzjBMKaKVKN+wJjfw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v35tma7nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:03:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJM3pt4012487
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 22:03:51 GMT
Received: from [10.110.4.21] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 19 Dec
 2023 14:03:51 -0800
Message-ID: <45a96faa-013f-4c2c-95ba-191709324607@quicinc.com>
Date: Tue, 19 Dec 2023 14:03:50 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/13] wifi: cfg80211: reg: Support P2P operation on
 DFS channels
Content-Language: en-US
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Andrei Otcheretianski
	<andrei.otcheretianski@intel.com>,
        Gregory Greenman
	<gregory.greenman@intel.com>
References: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20231220133549.bdfb8a9c7c54.I973563562969a27fea8ec5685b96a3a47afe142f@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dz752Mkxk1bW_yRjhM6SBxHs6wiFsD59
X-Proofpoint-ORIG-GUID: Dz752Mkxk1bW_yRjhM6SBxHs6wiFsD59
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=306
 impostorscore=0 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190163

On 12/20/2023 3:41 AM, Miri Korenblit wrote:
> From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> 
> FCC-594280 D01 Section B.3 allows peer-to-peer and ad hoc devices to
> operate on DFS channels while they operate under the control of a
> concurrent DFS master. For example, it is possible to have a P2P GO on a
> DFS channel as long as BSS connection is active on the same channel.
> Allow such operation by adding additional regulatory flags to indicate
> DFS concurrent channels and capable devices. Add the required
> relaxations in DFS regulatory checks.
> 
> Signed-off-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
> Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
> Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Curious if there will be a companion change to wireless-regdb.git to
allow this flag to be set in db.txt?

Looks like we haven't been very good about adding support for new
nl80211_reg_rule_flags to dbparse.py.

