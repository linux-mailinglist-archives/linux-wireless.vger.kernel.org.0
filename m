Return-Path: <linux-wireless+bounces-30943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E7FD3A05A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 08:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2041B300E038
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1EF3370E5;
	Mon, 19 Jan 2026 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FvzMrArU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPbOK124"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B6133710C
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768808573; cv=none; b=sROQLAM+OpLA6Ch920DD5zXvyTJ9nrfcA03tmo6NEBnUy2mf9fUVeNIIAzCLhO9pGr9POy10pbE0DrMKNZKXaBfUkAh9qpqZmBc2j7hU4pAHT202CIqTC4GzQq+t9AR/WwNWYmX16mDAsox1+skQXIsXw4eH2R1v1z1vxficxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768808573; c=relaxed/simple;
	bh=4ZYBaBS+MmPTlRxo2BnRj1LJ4gB/MizRkDKeAAhIalM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1lbzlsw4ukCY0Ew4u6SbQl0ASsCacagdZIWTh478JFQiC1LGB/HuYEjynyaQRLjBiDcfQXL/M0D349J6IjGEx/zNrh7kzv7qY7bgF7JbS07kY0Dd5fODPDOcKAeYDAVJuTY5rtkHWEeCyQoCMTlJf0XaNaI3TNnnCh/pXlzzl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FvzMrArU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gPbOK124; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60J1dg0e4134318
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=y6l0LWL7wACGdBi9bOHrGQqS
	n2ahnUwbZBs4QuWBHvw=; b=FvzMrArUyx2f9vJEQCiS19NjRavKmlRTkPsI2yc5
	xktOEWqmihjoaM65QQUohAxVQCPLbHmRuzWawJegXFgd0yDysEVzi6BBJ9rZ1Xwt
	K+zC/C67GOT7s5nSrBD6J/Y18dUQ4NYsMScUGjqW8XkpfKlBBS8TqEWtVpgIxy2Q
	8bEIsBRlXiTsLg6rl6rT+nce/eGm9E5QSaU5M6WKHu1iANel9+ZRvVI8keuVAenj
	3mFmJg7RlkpYJwvE6wSCzwzW5YdnshtaOY3wKwGvHmbQab5ZL4bLc3gXmQG2ZNcs
	cqMT0+CelHh24zNt4ttHvyNDyPpEFTf4PvNs3XHMPXpeCg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsb4yrurv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 07:42:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88a47331c39so96855486d6.2
        for <linux-wireless@vger.kernel.org>; Sun, 18 Jan 2026 23:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768808570; x=1769413370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y6l0LWL7wACGdBi9bOHrGQqSn2ahnUwbZBs4QuWBHvw=;
        b=gPbOK124clYX8hn5sBXQwds77z2/aDldk6FfLYZBHJYALUySO3b3Kjd24LrSlgIRet
         5pO71bGNB67KD82Y756scQGbxdbPPeP18+21UJtUSV1JkvUGxrCXVhiQpN7nA9zdtAUk
         tRPgPNjkZjKXFIM2r4pJJvL9W5cHDMDHyLry3uTDm7oxcQFJsgLk4tVw/X5cEJU32LeB
         swMLEydbx+FD9p+kcXTa8w5tysbBPFiAy2M/CQaNXonk5uykxqvXnFkhkGZDVqPUh/ut
         k8elf0hJNpSCnoWOP7Ez+BSxddmSnL6SwnNWnDbv/EDDbp3S8VINKvUSrghqdjgUMS7T
         4nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768808570; x=1769413370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y6l0LWL7wACGdBi9bOHrGQqSn2ahnUwbZBs4QuWBHvw=;
        b=ryC+/O5rAz1oVWSbAnHFKk5dNHDtQVU5vPoP0vr43JOUZ/HCdRp08JUIYTOK9ldvtK
         T8OzrOVDmL42jpiCr+JVNOVLM1lZXkNfjAfOcSuEgAisfh6No5miRXfmzZIjAjpZPxzc
         t2HGuERuIj81voyrd8MqukZoWzFdVP7vNorxHUXL3zKquTfz0wPDgNupPwdBGtjMdW80
         FNxPMam5rQUdoiGIsPdnF+6++gZM23VLDGyRwMzmqrlM9lFmkI5vNil2xM4grBH1SVKi
         ttOOzrxLIF3q5Vi0azolJ13yECM5F+MAgg5ZWux54D5eXNeijWq2B7lIu3+fJdijoX8G
         ea7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVqvuO9Ywxqtgnj6k+0f3lWZA1uV+mHtQWaKl7K2XvKKbhxBb9SILHmtKkrKmnSjlA9wn+g9imB05Ytwo8OUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPwFvi4duV53LNM0JRgyHY2+UAMu326uBtDwjTD7JD3P5CmTRJ
	OhqMM+ccOmf20aX9j9w8HmXo00p6lG0XNyMQgkM221vwT4jZ58TOp0lbtokCNr2wS5DYdkBZ5CP
	Y1wN95KWOUnEMulzLL4kaM4kIFqx/pCYiWsXU9AABMBbJRDmMFQNlIHhhUlETQWjbSvqCpg==
X-Gm-Gg: AZuq6aIHxs+cAE4McePZw4H8wi2+JHv5jLCyNAeaD/sk89MC1QV50LXplYgHL19Vdnq
	OyYQxirNAvRxT0Pq0wxm+pPReMUWkyKbQWErlkl2qs30prZkeQbE9YMxffEqlQluLtRztqitzG3
	9LL71iVmH+QJZCmC/G4suDYr84qlTCrOjUm5/ndHH3N1sLSLM/UfA5lNUQkLg+hC18j034dDQ8e
	lLjxbNEsldR4NrDF69iE8Yb98JnqwHae8Tm7N1M6BWtVVJiU3Xb7E3TWhxSgvdFhDyZmqKuHaWJ
	w+eUUpK5ZNYHP5JbveiWNxvCTFRMy7qiWD3LwXZPXZsvzuNqmKDMZXsdiWGGKsGdoFzqVe6ikfR
	drYKnVfQoxLedpiMVNxi+FeAf7pl7JYezADH/dumWMelabloRFUQfotVNPPML3Y4TcoiXfj21VB
	FY7oH1hCea3cUhE1QMKp+mTTU=
X-Received: by 2002:a05:6214:1c87:b0:882:79dc:71a with SMTP id 6a1803df08f44-8942e4a65ebmr173739166d6.46.1768808570488;
        Sun, 18 Jan 2026 23:42:50 -0800 (PST)
X-Received: by 2002:a05:6214:1c87:b0:882:79dc:71a with SMTP id 6a1803df08f44-8942e4a65ebmr173738926d6.46.1768808570051;
        Sun, 18 Jan 2026 23:42:50 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59baf3976dbsm3138500e87.66.2026.01.18.23.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 23:42:49 -0800 (PST)
Date: Mon, 19 Jan 2026 09:42:47 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Allan Wang <allan.wang@mediatek.com>
Cc: jwboyer@kernel.org, dwmw2@infradead.org, ben@decadent.org.uk,
        Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, Quan Zhou <quan.zhou@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>, Deren Wu <deren.wu@mediatek.com>,
        Michael Lo <michael.lo@mediatek.com>, Leon Yen <Leon.Yen@mediatek.com>,
        Jack Kao <jack.kao@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
        Sarick Jiang <sarick.jiang@mediatek.com>,
        linux-firmware <linux-firmware@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-firmware: update firmware for MT7921 WiFi device
Message-ID: <3sdwtf5qj3svipxcnmj43qnmerv6ouxnonmn4r5s7am3ebykz2@yqxwrosjcnvs>
References: <20260119063300.2741850-1-allan.wang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119063300.2741850-1-allan.wang@mediatek.com>
X-Authority-Analysis: v=2.4 cv=SNhPlevH c=1 sm=1 tr=0 ts=696de07b cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=p0WdMEafAAAA:8 a=mpaa-ttXAAAA:8 a=BbqIKv7TG13PCbykag0A:9 a=CjuIK1q_8ugA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA2MiBTYWx0ZWRfX9PAzaHnoSL5M
 hOb7tp7h7Qs+NHr77QkdBbT12XsiS4nseMxojzKgx/MGkxDOLf+v4848WAMYs8QZu6KUANk2Ldp
 E1N9AqlvJ/KtsosTccc8Qvvfzh9KZur/YbATVUZPIcRAvnLM42Ld3lDJWzrjqFnzPh80TaHgZdF
 3R1q3cKeWa/f8q7tv6CYoSJm8H3RsFhJnWJiv7QaSs/KwoMt6OsbyCmv/81H35J7n6fCRN6gZpd
 X5qjrnUDHUxrPjKA/oPsgbV86Gjam7AtilTkfk9qYdgADk2BaAT5TLnk+M0uW+bTE85Q1c7+NzY
 ouh4ocoUHZleCl5o3ePjZyP4dSL3P6zCkc9NMGleWdqpvd1sUzMkmEExCH6s6LHqzRsK+FzmBnD
 jx9gMi5pu2BGXW+KTKy07foiNpGzhT7GZ1eOXC75G2EkBs0Ce89emH0yh+ty8e2AvFLPE+e0fQV
 7bzrcyOxHEG5oI9b11Q==
X-Proofpoint-ORIG-GUID: 2AYU3b6zEN5U_Bnp12ywF43LBuyOoKRu
X-Proofpoint-GUID: 2AYU3b6zEN5U_Bnp12ywF43LBuyOoKRu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601190062

On Mon, Jan 19, 2026 at 02:33:00PM +0800, Allan Wang wrote:
> Update binary firmware for MT7921 WiFi devices
> 
> File: mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin
> Version: 20251223091050a
> File: mediatek/WIFI_RAM_CODE_MT7961_1.bin
> Version: 20251223091148
> 
> Signed-off-by: Allan Wang <allan.wang@mediatek.com>
> ---
>  WHENCE                                     |   4 ++--
>  mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin | Bin 92192 -> 92192 bytes
>  mediatek/WIFI_RAM_CODE_MT7961_1.bin        | Bin 791588 -> 791908 bytes
>  3 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks, merged and pushed out:

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/871

-- 
With best wishes
Dmitry

