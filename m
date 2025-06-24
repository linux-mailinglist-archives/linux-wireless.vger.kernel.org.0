Return-Path: <linux-wireless+bounces-24440-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC3DAE6C47
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 18:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9229A4A177C
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jun 2025 16:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DD34A00;
	Tue, 24 Jun 2025 16:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJP8ug+t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268F1D5CE5
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 16:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781756; cv=none; b=WE+yt+pP8aijIjOsxdl9/qYtLvYPbjtw7O84/hwcRJhqHtgDhdRJykF6IOXl0ekVEltFuDlQTe8NjRYn040UA97IdzVNIP5+HeWG3vmro17YiX8XUHnpPP1XmgEBq9Ab3yFUyH+gcvIkegf6oa5Im8W3VKC01MLywaGlzgU10Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781756; c=relaxed/simple;
	bh=cnqRmP3MWftqLsVV3rIWse2EOfNLNh9JhYIyXhzOGog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lnad2/l5GQIzJEK1AZAVW+OgK7g78aQBKlpZVxI3veN1c6R5KC29TIYM/zVES/9av6ff21oUaSqXWjvVO1jQ6UzzLTRvny75lwqtIAxOMiiKItc6aY9NCAWsTBlwN5M7VD+BCbDQ0Myg1teGRFeT8U/Wc6R8k09SqKu7ssx86ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJP8ug+t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55OBwHYq026045
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 16:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Qyfhlor21ICWZh+rc4+fdzgPyjA2dUWzPSk1D9SVOxw=; b=VJP8ug+t6fivQjJ9
	2HdIITE3R/FvdMiFv/sFzLfYQdjlR6LZfI0tk+12LkzUfCaWvffmwc90exzRsxKK
	UnvVLM0QdfIFKK+CvwZyvict5EgEX4l+GIzBh+GhR8MSXn2oiaR4/+EXpwiN/sQa
	e4l8j0Y9W72UPEnouis0Zg28oux4KNQ2zXElHUE+oSMvlgF9qw74nBZ46+2+rqnb
	TOdKOpXc0klR2Ak36eoxs8eTTBQvXx/CjBDtfPduiIA4CSIorzhA+cINUYInl5ee
	Y+H4INM1M28qQRnvek+Qna+bQ6Mc0dwgilAqPxMJroBoYT5qmIF94fsCByFje5pz
	EdjfSA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f8ymutgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 16:15:53 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-23536f7c2d7so92333355ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jun 2025 09:15:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781753; x=1751386553;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qyfhlor21ICWZh+rc4+fdzgPyjA2dUWzPSk1D9SVOxw=;
        b=OwPrgac/z7M/NgU9IAasVcMuH+WRYM7IVWn4cpSIJfTS+1DBA4s9nbXrcz4QUcHAkC
         SjpNSG4GE8fxNkT4HTiMKerV9cF5opzWlrowvGsQQPbylJH0SsG9vKWfuVzedP7xZPvV
         ULSQOdOOMxWly3AYoLTdAE9+l10V2U0Hs+8VQHhHJ4LlW1d68mhJPJWLm3Oe70zDuGQA
         7hcxNClsq2CeDP2ssL7zkvJp18EHd/GyIFbv3R6znZ3T7reM1UhirBzzn+8/trAKgdH3
         4cB+4Rda472p+NtMtEjZqJbI4ycJWtFm3wsscnuJiXAboumLQYgP6r6Xj4FJRHgaDJXJ
         wbEA==
X-Forwarded-Encrypted: i=1; AJvYcCU2Mnm+aHPrsWb93iDHdEyLqBWikHpzL3vXD91At0Po0+DFt/20atizGbjJQDEHMccI27j9TSb3EwVIbHR3kg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2oLFkL6L5PyjnPpBFrnZMXLErf5UmNicRSUuPP3rkXWE/tHZD
	jsoEvi82AI5MhWEq81TxGN1wvgXubg7n/u80z80sN9a7s3xXJlDItX4GOvKsm5P+zV4s2g0o0RN
	blRPgesnPpc1YpzIgCHq/9f21XpfXXTim+anRbtkCJc/3ecGDgKr177bjh1asi5CkGK2s5A==
X-Gm-Gg: ASbGnct5G3X6o9hP4UmUeKDIWVx9EWKAZ7qewKzVobSmGoTqHMGOI5xEHLb9KE1gugh
	keY/mDCcnWUqvFUOhCuURKPnOtD78vZqXNayFNnP5faW7w1DrRumEi7sI3Auh0HSGD0vNaGPKiU
	BkcAUoLXHNLiF/mdkc3bj+V8ip1sRshXu8Nll5Efswu4RnxACRAwDd7IuzJZNkHKs8Bt+Eul389
	QGUiNX9+8UGaIjnQRh2nOvtMawXQ1ONXRsR3XqCshLrE/o73n3NJLiDsTu3EY9TwrM5sUneRNVx
	Zs0HNKfgaEG5ue48bTmfI26AeWI7JK36sYydJtTVnx8lP1cNyn9mvWQaD+uWk1XaLnoKQaEIflv
	dCXU6IKI2FMX1ADU=
X-Received: by 2002:a17:902:fc44:b0:234:e655:a632 with SMTP id d9443c01a7336-237d9b19e2cmr287442615ad.51.1750781753001;
        Tue, 24 Jun 2025 09:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3GDtY6uAafIPWUwLJ9fdR1mlv1odipIGVPfHXlQOfWlJDASFtqBzLLuEVdFTlA964kKvR6g==
X-Received: by 2002:a17:902:fc44:b0:234:e655:a632 with SMTP id d9443c01a7336-237d9b19e2cmr287442015ad.51.1750781752475;
        Tue, 24 Jun 2025 09:15:52 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695440sm113338745ad.185.2025.06.24.09.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 09:15:52 -0700 (PDT)
Message-ID: <377affe8-fa88-4ade-9cf8-aaeaaabee679@oss.qualcomm.com>
Date: Tue, 24 Jun 2025 09:15:51 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: ath11k: fix suspend use-after-free after probe
 failure
To: Johan Hovold <johan@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Baochen Qiang <quic_bqiang@quicinc.com>
References: <20250624082022.15469-1-johan+linaro@kernel.org>
 <aFpingRwP3foaKJ9@hovoldconsulting.com>
 <43b978a5-c1c3-450d-8340-dc1a6dddc884@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <43b978a5-c1c3-450d-8340-dc1a6dddc884@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDEzNiBTYWx0ZWRfXzN7F1Sd4UUYs
 G6iO4X4E8B/fC8M17kRbpvDfVFIXtU0n3Msvage4PGS6n/SfBVHVsL/0+BI165Nq2gpBKsmfMLa
 f7G512NkfLnqNSUo08e64f0DXF1G5l3F7K8gDgNjHBs6K+U5Ys+7OUjx/DxNYmrK5NlROadO+vw
 ADpojn3keOdvMoSk7fz5mfklJ9aQKLInLiqEd/cRHcr3pA6J1ZntsKTlvrGSZC44IldbZKGSXoR
 OGy61mSZ3NBZF5Cl6dJGmak+SYp+cExtSFlkFyI9bLkeew3MlCN4fxR1sluB3rfH2ZNJzj+J7WJ
 o584kj7ifRazmsyP/8qiJHnoiB+rWEbYT9dAPLP+Q1/6W4Yb8ITyUSj1XkxutEPplr9MqcvDf7E
 TIpn1FCbPvALM8uv1Xmg5NtmRs/lSqfcVPG/2GoejsnwnTFLdaYd48PlYX9c7xfYsFNslie+
X-Proofpoint-ORIG-GUID: O8oOsygqMxIfVWlv7u0G0Y5h2o5eiQ9q
X-Proofpoint-GUID: O8oOsygqMxIfVWlv7u0G0Y5h2o5eiQ9q
X-Authority-Analysis: v=2.4 cv=GLYIEvNK c=1 sm=1 tr=0 ts=685acf39 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=qSSGdmx9Lv0nWuJ4rdQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_06,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506240136

On 6/24/2025 8:11 AM, Jeff Johnson wrote:
> On 6/24/2025 1:32 AM, Johan Hovold wrote:
>> On Tue, Jun 24, 2025 at 10:20:22AM +0200, Johan Hovold wrote:
>>> Make sure to deregister the PM notifier to avoid a use-after-free on
>>> suspend in case core initialisation fails (e.g. due to missing
>>> firmware).
>>
>> Not sure it matters in this case, but forgot to include:
>>
>> Tested-on: WCN6855 hw2.0 WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41
> 
> I'll add that.
> I'll also change the Link: to Closes: per checkpatch:
> 
> WARNING:BAD_REPORTED_BY_LINK: Reported-by: should be immediately followed by Closes: with a URL to the report

Please check pending patch:
https://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git/commit/?h=pending&id=2418079880408c5ae0b2a93f72af044eaff18cb6

