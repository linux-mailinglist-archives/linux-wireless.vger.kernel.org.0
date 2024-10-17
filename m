Return-Path: <linux-wireless+bounces-14155-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4C49A2965
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 18:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606BD1C268CD
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Oct 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC611DF277;
	Thu, 17 Oct 2024 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ApfjmDHQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D0D1DF755;
	Thu, 17 Oct 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183474; cv=none; b=sRS83MW2aatpiEaAqJ2jiEYM8lEEFiOwIGkvxdCziOT9i2uZJw6yJoNvcLg0iHaAe5w8FXt/Rcdgv1fYPX6I9RXkFb068WKP7haGnG2ne7JxEQ5ntSCwVNojU1qq0LMeJWS5bhTOl8ncnw+fwaTxXnGCwoA/znqF1slVZAbWsI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183474; c=relaxed/simple;
	bh=0JHEWdi44CFocuk6SWRK/s7L704YIYj+qbPEBPZbByo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UF8BBNgLlbJgaqdZSG4G46DowWUwCp3uZBlq+ksgbhaBKb3NB7JzpNdtvBLiSj0w/YF3XNoS1MPm5tNn1H3XU9ltetdczavw5ITz1svIXXbPXzWde79r9I+V1mI4RyirAyKCaLP0sKScmzDdU5ha0nTsOlMl9vvHyVozGBcj0XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ApfjmDHQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7xomQ020121;
	Thu, 17 Oct 2024 16:44:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0JHEWdi44CFocuk6SWRK/s7L704YIYj+qbPEBPZbByo=; b=ApfjmDHQiOtV3Ey3
	gsyyDIr90W86sx6x63rNtRGH916znzkYzM0riixU6PJ09bLM5vZSH2SOPXVNP5Oq
	h90KmUY8PDqAdq6svd9oFSgbB/NbhwLWtMlphMKiruhwpI1xrJMea7spGBxMp7gd
	BXxvOwpmEZbMRF3fr4CsWJ2xL6BWhI0GOTcxGDHTlwpSIGfGecc1gq+OtHfgB3Jb
	cnqJfu/YlFU2ySXD+sYVfsb+JaEfpVDt8SOJVJ0TOfm70xVLOnUlpkiQ2cuU8Mql
	mVdZbyU7vdgYMjlw/ePemCItQLw5Ar4a9SQ6dPyYCHog+TQfHvAsy69xYxvP7v98
	pX/JYA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429m0fgxgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 16:44:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HGiJXV012299
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 16:44:19 GMT
Received: from [10.48.241.64] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 17 Oct
 2024 09:44:19 -0700
Message-ID: <f9013f01-a61b-4697-a85a-60d70b6596db@quicinc.com>
Date: Thu, 17 Oct 2024 09:44:18 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] wifi: ath12k: fix crash when unbinding
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, <kvalo@kernel.org>,
        <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
        <ath12k@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241017074654.176678-1-jtornosm@redhat.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <20241017074654.176678-1-jtornosm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8GQXwUJsLhJOtHJGmV0To1O1fMklfJ0i
X-Proofpoint-ORIG-GUID: 8GQXwUJsLhJOtHJGmV0To1O1fMklfJ0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 spamscore=0 impostorscore=0 suspectscore=0 mlxlogscore=502 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170114

Your v3 patches look ok to me, however they are not showing up in Patchwork so
I cannot act upon them. I suspect the issue is that you did not link them
together (the 2/2 patch should References: the 1/2 patch). Better would have
been to maintain a cover letter and have both the 1/1 and 1/2 patch reference
that, just like you did in the "v1":
https://msgid.link/20241010175102.207324-1-jtornosm@redhat.com

Can you submit a v4 that follows that original pattern?

/jeff

