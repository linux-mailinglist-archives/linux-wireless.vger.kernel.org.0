Return-Path: <linux-wireless+bounces-25296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B9B02601
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 22:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1B0564D38
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 20:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3481F30BB;
	Fri, 11 Jul 2025 20:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k58LvMWC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669CE19995E
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 20:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752267338; cv=none; b=SYpVBQ18mnkAWNrBPQxKygA43a3jd1Uo/c8ZhR3MihQjdc++KqhjCuebVMPe+FIwkrQF6XD9ZkeD1GlzjXl2xuNiudQ8Qp2wbw2xes6bJyfLwk9wqH6iF+xcebb74Ly7P3ypWvrmjiEAp4cpilAHWziqulyakBrXxZrb6woGXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752267338; c=relaxed/simple;
	bh=g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X9heg8PTHFVwCGHLUuC+8bdZSEApBZcWEUISY2geCrol+AXzZ6Ctt0ZkaMev+0q9sJI+fUc68HaPBuac2PCwuOXRUuGQqhnTsT9weYtAtkPPqKSRAM0Qq8PXa/6HVKwTCC01+7Fa6cV3YrI2B6iAp0AJObcG80RWJJAWsPLch+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k58LvMWC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAjmGj008142
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 20:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=; b=k58LvMWCjdxDKPNi
	MYhffkoFEEl8XWUvGQXBs1emGPakKiA5d5gFbSCM6pLgrWeYa9iL3iihCfiGugiv
	4hmLKtZ/sS0k/7Xe8Jkaig19zWGBv7etDQEs/yvFVQJHEhFpCQQ8ctjiJ/j2spCk
	JexEF+MyKLut1st2nDtjDzqWXHqu7nBGgNRWesdKIbBCwoVnpqG4C6Nx7CKVT4VT
	YuuwygMcWRTB7jZz9FEDRBjs3ubBgJHMU0NGuXLa+XkiMQQykZ09jlWBdoKHgcxD
	t/8Fiz6jOMjkyHGKbLDhaPLg5Z4DmMoXcW/pPrlW91BuY76BViiHAI6ES4ka/vG4
	9WKPwA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smcg9tpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 20:55:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74b29ee4f8bso2315664b3a.2
        for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 13:55:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752267334; x=1752872134;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8xumnlJKhg8TvzfYUZcKaeMMbkMPqFgS9w1YvjfoZg=;
        b=aTLBHpyYXbgT7YsEKcVOEoMVUOZcMmrf/asXNFJaMi9cF2RL3mJqNNhupIGQA/FQJE
         ZnfcCOChH4VdwHhS0p1fRgezl8fi2bs2qUFf9+kKRVo3CUZNGHrPxrf1c/tebpxhV4Yf
         Z9+P2UvSd5NlVChYYvRIRy0Ie6pdqH8NcQUqMezKdtPgk4dUWzfdAEzxk+wQLwYABz15
         cptffaPLcd0NZUwCD7ykvV9YFeT5uj/bAXbZmtSD7d3utyHv/2H4G+PLX+mKi8PvwlU8
         EGBMPHmk0HbdQmqGp/dAvx56mkBQgOkDSWyYhg7LNzNPKbSz0w/Vzdcc61H222h6+Gxk
         L0mg==
X-Forwarded-Encrypted: i=1; AJvYcCXKH7USLqBPMMFV96Q4L5rwoTgIit0S1h9R1eopAYfKLVqpOXQZXLePbjcz5fEGiSyUNTcJO/jMu3/fhzBt4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yznra+gl5rRTXpXbs6Sqf5aLAvQFLTVkhcHpWOCr0PR0myFEbPa
	q1pOHkhBZ7MM8nyYXaWs8zRQTZ7B4yQty6PVyInAyouCo3PcxopBkyTWdC+D9TFwIF2pubFLKAo
	GGP65wv22jJL7HWo+PHGkK0trweV1+z4ozA33vYuwBcR8qdKHOOXzfDMfotSOQNO1jJ4tKA==
X-Gm-Gg: ASbGncsk5c6cZElxl+HYqKoWE5mvBuPCv6WMHXh+3UEqf98jgqRRr8s2UtT3lPO4LBa
	5n5qZ++PwafIBTdPcAD6aCA1Z2wrwvXLkyc4rG3xJ5KKa4LOJNsyXcJ6LQReQ5t89V2X+3jidqf
	nSlDxezC60G0/juNhPRVL8ZpE3mMzKZuDFzuVuVieA8e0+kYwhn8rWYq3wcEdQPMkgeizo2+X7A
	o3FFqzzQKF3pTGk5YsWhU0/ERjmzOttNaWZftloJxwrKBcJ0EKWJPnX5T/jUO+LLOKSgxtcSR2I
	DwhNhs2P2tKHKD/Dobhi8YVfewLorhOrJE1p3Mllx1HDpeuyJXPs4gCGDHuKtx04E12ird68JU5
	dg9MsN+LaTdI1sIhDEM/AylTq6fK73VdB
X-Received: by 2002:a05:6a00:4f8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74edd64c6bcmr6178030b3a.0.1752267334486;
        Fri, 11 Jul 2025 13:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ+7Q4jYJh5aHc1D1Mi2+k4SzD1hY5UuKAGZpXpIPCcTz1Wm5TRFPEpAjDLHuHOTCW2uOJaQ==
X-Received: by 2002:a05:6a00:4f8e:b0:740:afda:a742 with SMTP id d2e1a72fcca58-74edd64c6bcmr6178007b3a.0.1752267333998;
        Fri, 11 Jul 2025 13:55:33 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e06890sm6204889b3a.48.2025.07.11.13.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 13:55:33 -0700 (PDT)
Message-ID: <b4217107-f81c-4004-8683-2f9b37af9f31@oss.qualcomm.com>
Date: Fri, 11 Jul 2025 13:55:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] wireless-2025-07-10
To: Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20250710122212.24272-3-johannes@sipsolutions.net>
 <20250710172352.3ccd34ec@kernel.org>
 <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <934e5e1e253ee3025f617cc38ce6fc15e0619d6c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=P7o6hjAu c=1 sm=1 tr=0 ts=68717a47 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=udskd3E0VjEkj09em8MA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: bWSvp6iT0FtImkTPdKElLIQAJobfsKlI
X-Proofpoint-GUID: bWSvp6iT0FtImkTPdKElLIQAJobfsKlI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE1NyBTYWx0ZWRfX6BOzaIcgQZHj
 L9Uywa+R4e9h7pPKEY94sTjViTx5Tw+eKbgNzi7LA5BgurswaZKIosx9HKdrNqSdKm3RaMQn8GX
 7DCkow14p7IDt/uwt839ON1cp3CwKf6ZlRZXyhtl9cGouBPwRw9oAZmk2PtfuIXKymsjl2aunl2
 gMmYyJKNw/4nfuOB7xxYkETkFm7v6otk6QxjfyjnvlG6NfYaPN+L3eQvc6qcHX/QBn4b0ztKg9I
 8X+q2Ey6rLFKz0t2eyco2NxeD37CdYzL7z/AKjEd/eD45qlOZoD3paShEuZWz5lv3YZd0J2ot1l
 nQUAjlhCCdW1KV0EeFSfvB7AtO21SZ3FzRbT9vFdtEiKfrV/io3VydNF75KhGxFSa6sgmLLGaYl
 mH6Q5Er8cHUhykXhvgM9VzLZAY7pu0BbMiGQwuycCZ/ynQsn3rfzyHFN0DQloDYEoR7jzN9h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_06,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110157

On 7/10/2025 11:41 PM, Johannes Berg wrote:
> No worries, and thanks for the heads-up, I can wait. I actually really
> hope this was the last pull request for the current -rc cycle anyway,
> but of course now that I said it someone's going to come out of the
> woodwork with a fix ;)

<sticks out head>
I have one small patch for -rc7.
I'm holding off a PR until Monday to make sure there aren't any more

/jeff

