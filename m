Return-Path: <linux-wireless+bounces-30749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AD4D19EDC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 16:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40F753008F82
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 15:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4E4392B8E;
	Tue, 13 Jan 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y98Zc6Mf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ceEW7wNc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65C270830
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318170; cv=none; b=Np6dQUSPcu7+ABOeBK2RUVNsp+QkraZHYE5eAzuV8fNr9HpG4D0AaXm6U3TRQmP0oCJFfpL1ZU63XRd6CJP2SxBrKq7+toiDVBUa04ylFjI5prQ55o9G7taRH1rqK4qz4oii+Jc+rVavvdgPSCqQ15PygiTb/5uISx82ZraN9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318170; c=relaxed/simple;
	bh=Nj6xnCVuK8b45Cbxv8affAKYBsuTuuql131JdglEfgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cup8DxAbLXKnnxvxtzkHqhdeR96Pg0kZZ/xwFwVhf/1I50Fm0g3lsxUWSq6LUT6DrFRJ/oBrtJJjw19600zxvyvbRWt0etzw6lm2R6Jb+kafASVwyHzHxXSwrlFiEXyROlJ0XDozqpgIPB4G195K5RpRRLUWz8LCwzRDV70lgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y98Zc6Mf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ceEW7wNc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60D88Zwk3299970
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j/l6Vz/ROV82wBBkFLcsuaWf8YScYkImEeK2Qy9YmyQ=; b=Y98Zc6MfQ62NYWG0
	WCdxT/b6f6quiJ+6a6Y7UPYL4MvsxdAGIOD5gdWT0rqAwpbtUlbUE/RAvWxjmQ/C
	8/QZqPxW+XDkiiWIXORBEiR9KMktWrQeBXevgTdOweRfdNcZQ0rK3kxpK8RDhVFo
	efGBlW1DfsBmr65OiW2ERUZLGEV1eLcCCV3RRil8KipyuaaD4iaTfCeOGLdvba19
	z59kngpGX6LFkIGjNtOVeGUpFa6WIqmXFSMJ39CAa87TU3/VGhEdEGWNWpEViitK
	mAy7UmEgN4G9u/USxG8pt4EDzgHcuL+tiYjWWmo4cfYJg2j3YbhS7Gg31JzJtai8
	10RZ0A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bn6jmba6f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 15:29:27 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2adc3990fecso3179107eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768318167; x=1768922967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/l6Vz/ROV82wBBkFLcsuaWf8YScYkImEeK2Qy9YmyQ=;
        b=ceEW7wNc1HAZD3JCtVFb5Oc6rjBMHfDcUMSSgAjzmqbr4sMQeZaoy07CXPScdk1+b9
         Tdc8/LXkT3k3+M0DIEcN7lCrsQ94GQDew9vn4u+L+3CMl7veCtWd8OYZjZcgcibHGn+S
         JiKRWmLDtkGDo29+y17viLz3fWkDnQxWIQL5J3YDurrVj7OVWBKvnzG87iO/PBbQeJoi
         BUmJcWaFOJgdgT7SqavONSYvX+pxLBvvql7Rym71XQjLgLOBPM9fGz5fUCYNcBGecSta
         9m8x/5vol5w4m7PanSE+E1nIFbex8KEuPYK3bdnQL9EpEQYZfrlCEfUEHP8HA4FBjesr
         wb/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318167; x=1768922967;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/l6Vz/ROV82wBBkFLcsuaWf8YScYkImEeK2Qy9YmyQ=;
        b=cK8b8s5piuddhdr2wNL8M+rVohW1WkC5Az7QxenQCg52wm3FXPyaW6Zy11vWXu2oQi
         5RgrtntgArmeCDBbqWfojG6r18aLBNH4b+Bo8dVAK/y28fWUxxoHO4jfnijbOm2YrxSU
         NNeJrBs1AlIHdJH2q4KnHRSOHqlUEi5bMWZdeMKuX/Y8vnYdadmAwt3pZUOyXmSwAzkB
         c45oLDixeF+wZwx7jjPungjWIgJCfJPRwjItCRK3kdkBTrdWVLwOMhUXu9LZTCOUSMkG
         d1iUGgKSSurynZS+BgqY344zBhMv14MheMg6ijWooUIf+feI0eFLu2SttRnWO0Lxb3Pd
         gnpQ==
X-Gm-Message-State: AOJu0Yzpd1/34S1/X3nPqAnB3sUruJzPm45JWOdi9dCb27tq42wS8Xc9
	jjRPtGxnnqhLUyIycnSqL+/YhYuT9F+J6wV0U2b0eReDA12SR+1htX65SJ7A+NfnFl5mpEAZoaC
	nNP+LFSQITQGoNNCuui0Pedq6/1Ic3dls3e0L4PrWK6pCbCJciFmu1SFoR+rrm6UT7L/7dg==
X-Gm-Gg: AY/fxX7r6AgYqeO9V2GUuRx0y3L2OH2MhhEiu1Gf6y0sKZTAMN5nQOTyhfYITzHGQPg
	D9QM4O5vmxBcXS1z0aMKE5Z08i9DQm+BIfZr97G0rXYseuUzRxtHWfzAVkNG5pdDxRB56daLZAt
	WsYJn122FRU0QPDAxeEC6a7zn5TK0IEwXTY3SGDVEiFAKI2HQX1UX/EuE/kLnc2thidl2ZdRuUM
	Z6adiNZa7YlPH4U0b/MgF4blN1KNNbNByJmCa3gdHRaNHjXmkV5RDHiSIDQpiWtmAwzEoru3Lnr
	zl0fmJ7EwSUqcPVKC1y140xfEP+Oiq0vl8GETBO/MS9qiHC4fvp483zkfBnnZKUZnfQ8uq5bora
	lgrRvZpa5ZsKgJk4IcLun4ZEUwDmixTgTGhosaTuaLAyzui9bstv9dE4yYgTJC5X7
X-Received: by 2002:a05:693c:2a0f:b0:2b4:7d0d:9bae with SMTP id 5a478bee46e88-2b47d0d9d4cmr247367eec.9.1768318166632;
        Tue, 13 Jan 2026 07:29:26 -0800 (PST)
X-Received: by 2002:a05:693c:2a0f:b0:2b4:7d0d:9bae with SMTP id 5a478bee46e88-2b47d0d9d4cmr247346eec.9.1768318166076;
        Tue, 13 Jan 2026 07:29:26 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1707d76aasm16858049eec.33.2026.01.13.07.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:29:25 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Manish Dharanenthiran <manish.dharanenthiran@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
References: <20260107-scan_vdev-v1-1-b600aedc645a@qti.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: cancel scan only on active scan
 vdev
Message-Id: <176831816518.3453943.9391616403961545253.b4-ty@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 07:29:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: odrsaRKjR6zafcUn3WuZ-vJFBzfKY8gZ
X-Authority-Analysis: v=2.4 cv=SK1PlevH c=1 sm=1 tr=0 ts=696664d7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=6eCcPrk6fTqf2FKRD3YA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: odrsaRKjR6zafcUn3WuZ-vJFBzfKY8gZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDEyOSBTYWx0ZWRfX9R/DNbInxVyf
 fSlaZ03lVVG9+OiYKm/R7YOfxk1jrKzB9WvoMWBaJDIPjJbWFsNrFGQVV3ea+Ybw4vqXBLro4wg
 UUQ5YOmn72ZUrA8YPCky/KCNO8sfD7BkMV/gPbejjijWwRDIBkErTq/zFqY09RPbj1gubfuhBRa
 CgDLHxH2wK6QAO7N0aHY8INhDgpy9Fah4S1m/1/LJMGyuHPjvbeZ5dQ8RWNYvyynKiPLim28MKM
 3c6x7u5YnCcYYLJylZuOtmCKyD2sWqCU0Ptjax1LXuYRIhl2PeHunT8TzQseqpHj3WjUh36CKID
 FhQuUSxzbfT1GQb7QZ/HlZDOliAN9xPVtu6Qta92Ims70zwIva4ARLLrfiMvZB86Nl6PjYdY1YM
 jPIOrzVt3R9rFfX0JJMRfAhkH0LfFFKM7/5Bj5QKMp9bHGtNKL0tc60b/812lTCxTr3CIeZ5fpO
 HpoGi7UHGntrotYeq7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130129


On Wed, 07 Jan 2026 11:32:35 +0530, Manish Dharanenthiran wrote:
> Cancel the scheduled scan request only on the vdev that has an active
> scan running. Currently, ahvif->links_map is used to obtain the links,
> but this includes links for which no scan is scheduled. In failure cases
> where the scan fails due to an invalid channel definition, other links
> which are not yet brought up (vdev not created) may also be accessed,
> leading to the following trace:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: cancel scan only on active scan vdev
      commit: 39c90b1a1dbe6d7c49d19da6e5aec00980c55d8b

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


