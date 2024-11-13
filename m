Return-Path: <linux-wireless+bounces-15222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0940F9C666D
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 02:03:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FF5B28499
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 01:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F2AC147;
	Wed, 13 Nov 2024 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qfil4CYj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D003FC7
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731459709; cv=none; b=J1FZxlLgk4YInq7fnEBg88Pud5bv/subAcB58R/p1aqZUNHboEaPaYfXcArY8IUleqWX8aPNwABbaubmurar25uy5IIZ2AddvgkO0re95UtHuvt1LLKQoeJVF9hBPePKuTMqn4L+Ub21j24eyi26cTGW7XfoaOYJMAIQMpTLv5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731459709; c=relaxed/simple;
	bh=FajN7qSjWTAALWMIQkmvhpiUtupXo9Qg3T3pN95hhGo=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=reB+kMYpiciXejL+nP6mxzM5i/fDp/YPEzFl8pqWpsIHwUazDB8GOiDmJPjagdqD9El2zHauM61AplMQnR18K/W2mVJuy2ApoEJ58ok2SicsidrMsnKr4tjqOv/JPIMXk2+hC7ZDyZgAac7rF0S00UChxo13C7xYM2PBNGxjhok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Qfil4CYj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMRTD1029670;
	Wed, 13 Nov 2024 01:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9fRFCj/2WHJdzM9SOTrL9FW0ECrrU5zunC0IuN25yvI=; b=Qfil4CYjyk3xkJuh
	lWq27rnGQ2RlqvMGIDTVXCXb2vF0EGgCvUd+biobdvS4jLRSDEEc4E/S7mehrf4I
	CfrWxRolas/uZ5HBOUTjrCA4dlGZ6Lm4vnRamDKBPPu1Dm0ggc1+glvO1nP4ZLqG
	zteZolry7DFm79F84spwUK+bmVOlAQYvBzTI41KFTLLU5cjRt8VAZGXxKVx1QwhO
	EpppE3oUIX2G2tm5DvzK4APBFba0VNKlvbr0w0gN5kpZN2oq1kMIbnedfMnnsrph
	LyjCIApAr14f4O6fWRQsWrTqKmU+l9Fc4eZz4IshE+dsHgQya66dos2kUv2UgnIC
	+40mNA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42t04694fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AD11dX2023712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 Nov 2024 01:01:39 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 12 Nov
 2024 17:01:39 -0800
From: Jeff Johnson <quic_jjohnson@quicinc.com>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Dmitry
 Antipov <dmantipov@yandex.ru>
CC: Kalle Valo <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
In-Reply-To: <20241111104724.484586-1-dmantipov@yandex.ru>
References: <87frny5bcl.fsf@toke.dk>
 <20241111104724.484586-1-dmantipov@yandex.ru>
Subject: Re: [PATCH v2] wifi: ath9k: miscellaneous spelling fixes
Message-ID: <173145969958.2685813.9101794406330455860.b4-ty@quicinc.com>
Date: Tue, 12 Nov 2024 17:01:39 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hU8ih8Q_ITj3rdpL150rXKmBkMOS-PJz
X-Proofpoint-ORIG-GUID: hU8ih8Q_ITj3rdpL150rXKmBkMOS-PJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 mlxlogscore=650 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411130007


On Mon, 11 Nov 2024 13:47:24 +0300, Dmitry Antipov wrote:
> Correct spelling here and there as suggested by codespell.
> 
> 

Applied, thanks!

[1/1] wifi: ath9k: miscellaneous spelling fixes
      commit: 1053987a6bce68127504cda476ee56b97c9109d9

Best regards,
-- 
Jeff Johnson <quic_jjohnson@quicinc.com>


