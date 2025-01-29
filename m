Return-Path: <linux-wireless+bounces-18169-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2AEA2261E
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 23:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6AD17A2B91
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 22:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FA618DF60;
	Wed, 29 Jan 2025 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OCxkDX7q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5BE6EB4C
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 22:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738188950; cv=none; b=Cqq1U9wVftVlTMBSV+/T51KPNAgY5d61DVbfCTFgZx2eO2xlwch8m/ZM4E9bIY+vO1xEs4kCA3LNmHOc+lRkCMgEsTJNSgEZMH5sjQ7PoKy8Hg4UmTEZpNV2yf/7FMLyZT/DuigAa2ONeNcZm7ilJkLHM6N/T1Oqb/OBep8iTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738188950; c=relaxed/simple;
	bh=1SjdnaOK/wkINwS+lO40qjjfEguDVrQDgyK/efKlEiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cn3zSn3HwLcgy3Ig63h56iZLpqm6flx2E2fX5fKTDR44nu6woBYeAj1xmY9Vci7a73s6Gls8BagptOuC5YdA+tJqhRnRd+IHCD/YwF4pwWJi8NuX7CKSozBlvljTxnzZxnSdrJgPAPv6q0LeuXYa+5zUVVBaHwgRu3Y8b1LAvL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OCxkDX7q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TJnIWC024285
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 22:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1SjdnaOK/wkINwS+lO40qjjfEguDVrQDgyK/efKlEiM=; b=OCxkDX7qktaYz+0g
	9TdzB0v/FxSarkSEuRJQOY12ZYbnk/yMjsOMwWUPn2v+zpgVhrEj+mm0dXM7u94i
	1AaSKY7LOKf5W9159YE5bpQfUWBNIdFfHocsSVLdJJunpAbfa/gH2jEWtuDlP1KX
	3M2RbBmzE7lc9LkIfYB64BTR83rLqBc5UkmlaEOAG5vNyX2B5YXIlieSY7w3Zet3
	KdC70ZzhCvNxg0GZL7kRWfHdyFYn59RmLtQSC+IeimmxYr7F9POqLbG3oNlDFLmV
	rCVopAvasBR8f9OXCepEaO0URvSX669CU0p+NKdeKQarc5+7Uf2yozWW/0Jz85dd
	wB6iyw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fttj0abh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 22:15:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f83e54432dso253085a91.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 14:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738188947; x=1738793747;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SjdnaOK/wkINwS+lO40qjjfEguDVrQDgyK/efKlEiM=;
        b=f8+2zboZlQE6kimr+tVe89RAhA6WblINxccwWIHSQLzQD1mpOZvT5HhlN49R0i0XcU
         hXHQuAJ4pgI/B+EBBBZkWF9PLdBrnuB+DlSsNibhqbsd2L15hwFXMAqXw748nzIIYypB
         4WSrEZ3oZDEXFQE7WihKGNNJMc9LsO/FXuC944ksZCPLxs0WUjuX2kZYBKMIBtoSYVAm
         +hvOhpR+59GW/kw8Cm1yWVWTCPtBV5x4+nvYmzzy77tjVmqfozA9WmT4De7TNbShAMJL
         aKHAmIhXbu4RdIq8KNAqviiExUWEUFbXDfePGjxvD2T2wGJYFmLEEXNTsNK8afBjVySg
         KqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoRBqqkMqVMJxyPiw5p8/bI2QQdaOBbkSot760tB6n7eV0UciADGDWvqI47X6mUrHmkYCr0AbjwNEbQfzzdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpz2ifBpbruoq3oZoMHwmHNNdS8AAEsojoGrrA6I+j6xZ/iH7
	QVIHoev4YbcHYMJ8wl/WUEhyxZhrfvFXdTatn+cBb/bz/iGzw7oJsY0reBGXmMyC8fgDhSUe5fY
	f9AOlxkdpoYHDwATh1G1QIBbOOE5lfaXbtltXhSRbXeQcheeHOfAzZH7B8yFVjqflVA==
X-Gm-Gg: ASbGncsReWwXYzqYllWzfFF7QhR9WpiIFt/t+HB92qHI97v59VAF7hy7ZQVuS+0Y+lM
	+Y1QNu/TNeke2Jlhd9n8f2TnM12W6DeiC7ebYqmOTpdjN0J7VILtnLIHZUoL40aYmJC1mdj88cn
	ojpGjiyl96aVb35PP/o5oaUnnGpZ1EyzoCnwFTVy52xSBJBPL1e1R7JsoTmOpTV1p/WDo1rIcL8
	3erYtPfKBg7do9toQiA/j2Yhte4JFO5cfRAd5Da1FeQwkqmSXtoHPM+aueHCVPLdpEhGDDPsdQs
	TP/S16o7puW9QAHL336IfmcELSVdy/KgJD57hidfHB28x9zATOWI0WrM3p5agxM7/PKqrq6bbw=
	=
X-Received: by 2002:a17:90b:2f0c:b0:2ee:5edc:489 with SMTP id 98e67ed59e1d1-2f83ac5cbe9mr6645819a91.26.1738188946814;
        Wed, 29 Jan 2025 14:15:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcHEy2Igp1hM2NEI8F+9zpZ9hSDtzYP/SFbrHAHJKwgy/9K6SCSQdmimT1ejTnxVM6D0vU3Q==
X-Received: by 2002:a17:90b:2f0c:b0:2ee:5edc:489 with SMTP id 98e67ed59e1d1-2f83ac5cbe9mr6645791a91.26.1738188946455;
        Wed, 29 Jan 2025 14:15:46 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bfbdba2sm2336328a91.40.2025.01.29.14.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 14:15:46 -0800 (PST)
Message-ID: <ae45d808-1a9b-4f92-a99d-6acd8100fd3a@oss.qualcomm.com>
Date: Wed, 29 Jan 2025 14:15:45 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/13] Convert mac80211 to TXQs only
To: Alexander Wetzel <Alexander@wetzel-home.de>,
        linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20250127162625.20747-1-Alexander@wetzel-home.de>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250127162625.20747-1-Alexander@wetzel-home.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: qSjXFk3A3Iek7sE-lOKZmRuvyNjOisyl
X-Proofpoint-GUID: qSjXFk3A3Iek7sE-lOKZmRuvyNjOisyl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_04,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=694 spamscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501290169

On 1/27/2025 8:26 AM, Alexander Wetzel wrote:
> This converts mac80211 to only use TXQs internally, moves TX into
> a kthread and picks up some easy optimizations on the way.

It would be awesome if the cover letter actually described why these changes
are being proposed...

