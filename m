Return-Path: <linux-wireless+bounces-23085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5544DABA1FB
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844EE4A842A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 17:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2C1247293;
	Fri, 16 May 2025 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eQBFLzay"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4138274FD0
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747417250; cv=none; b=OK+psK9vj3kjDf1qisumI8F8vRUdsWry2+5hREhr3zTUXRbB7Y/st6iPnfyn3NLsGfXwX+F0ACixRkeFn5Tadh97gWLcevGQo/dsiXiLGo0PUna7ei4y0ex35SU1jjZHsFPKARc5qaDuk49NJuCOL3FlX/DM9q0jlMn+ULWLdSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747417250; c=relaxed/simple;
	bh=e9do+4dlGQovVQxUDIwDKoB5RJKvYweGM0c+P2erRJk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QjU7tQeaTgIBDuMjwlnMxsRHwQJQshBpY5JUWIGSg5EyvALlcrSWR4srF9Lhc9wqFRQ2xb66kRU2JCbvDU71e6ZwpbBf4bAoYAJ48jRnVrUAMVjHuTeU+z+kSIxMqm8fepLj1XmLqWnzAjBGV8TBKKXdkV59qayahPNly//JSsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eQBFLzay; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBajMW024320
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	C8pWKVxaMh1kzxVLK0M6ZtTeykbiXElVUESVt8rZ1zQ=; b=eQBFLzay5QsvcWew
	h+AOdyRqrCxzMUD/Lp6KFYb9lSOHN81UoQnq/AlS9uxhQrOHXA/E+DOJftKgqbcB
	fYKW59YPYu4FKopNoyAkaaZfLolAydYugSWeaZ3NYAqbhVVGZ9WIR/IyKhJED/Jw
	waoXnU4p9gfWjMHMaUBMhSPMLCFS8KQXdvDJzjCYFwpn07UbbDKkEHyjjJCkkgns
	ZoQ6EgUXR275fo8q5aHQgAEoOJIuJ4GUUgIMWHAKM7th9GOFV6TSOEKiCvT4n2c/
	YE/RMsrIq6yMCgJ0gq3Cm1NhUCEADaj6IEuCkv+dZZLo35dK0NtQVWxMxzKeW4Sx
	w8hz7A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcn2y12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 17:40:47 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-22e7f041997so40307405ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 10:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747417247; x=1748022047;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8pWKVxaMh1kzxVLK0M6ZtTeykbiXElVUESVt8rZ1zQ=;
        b=IIQqY2sQ+flSo8N0RJZyfRWlGFsQRrtQJEKomzAz4+hszljp1mqzxcuLmPLkNJNOwN
         1k7A8OXWm0MUhydEjhH/+hlc3nsIxPXs6KSOLxJX4GVha8SPmok/dn+j/OfRsepo7Dkn
         w3UBWHElebCvtB8kDNA+ZbWHhiB9DebGpEf9WQbg5b8I8fxolOLnbUKosfryMYThB2LN
         YouhOWKzH63I26UJAe6aKIMr0vDS1Zi9QF5JCoY/11chcCHj/u/elrVAfvBRZCylAyM3
         mFCnlT1hKbCBskwfwdhW9i9iLAX38GhhI9zFQTLeh3Rmp+nC/Ojn570sDhpb9kcxAJpY
         7AvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBW5nRCrwPbqVP7/TWt2zm2eP0TyxO2HkubOxUHqivsRZfF2gHY3AXONNygIsK4xpoV5okubNHzWeBdB9ZhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxOcfp2MfbQ8Uf1+re2ZjknRhz6yNej32gcchqwrBNzhKQgJjCj
	Bzo5pyFs1weIYK1m7iUaxYyQK1RplgSJ/p1jm7N/zKB1yCDDJ1zOsdtI6exuB0ErjudxK98qNW7
	KRxJ31T7ZQ262mokpKtWhA4OAc6Zj9FEahQ8DtinTNil30bIUWCs3pmm/duYapHIR4YnlLg==
X-Gm-Gg: ASbGnctEoMT55u6XdFJlypS5d4lQSEanUkb8XG1zixrygleZf4sydIKukuh9sjApJxn
	XdXrbk44lUhHt2Q0RmgjML6T+rMxilZlEmuk5fjlZRcqDXwOc2d8IrIbRU5LA6WCyWWEDw2AB17
	mIvFZgwrfH/nPxujBE3vNoxkNBj5povT1d3pDm3dFK1UfQCTElkr8j5SRyON2WRXUCPqQyoabKm
	lDpprYAWU7mTP5I/OWXu/EKcOrhG1mv8j7wNXclpZoZmX6h9Bi3b7ULT4HpERoidMMNDrORjKgZ
	c66q27Sd2vwM5P5qwfQJ4T+hy00NML42QVWxYi4XsP1NPHd5
X-Received: by 2002:a17:903:2f4d:b0:224:24d3:6103 with SMTP id d9443c01a7336-231d4596d40mr61192125ad.35.1747417247089;
        Fri, 16 May 2025 10:40:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSWa8ji6HOqJCeB/StEMfWMDUBnd1taWIOBSxPGp3Cgj8KNbuY90IhBKEkiubja+uA4+WbBg==
X-Received: by 2002:a17:903:2f4d:b0:224:24d3:6103 with SMTP id d9443c01a7336-231d4596d40mr61191765ad.35.1747417246668;
        Fri, 16 May 2025 10:40:46 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ade573sm16994125ad.80.2025.05.16.10.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 10:40:45 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
In-Reply-To: <504b4d5276d13f5f9c3bffcfdaf244006312c22b.1745051315.git.christophe.jaillet@wanadoo.fr>
References: <504b4d5276d13f5f9c3bffcfdaf244006312c22b.1745051315.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] wifi: ath10k: Constify structures in hw.c
Message-Id: <174741724522.2935573.13839146888605668919.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 10:40:45 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: L9djxRpN_58jzdbngBdFY3yv1GBVE-5A
X-Authority-Analysis: v=2.4 cv=HZ4UTjE8 c=1 sm=1 tr=0 ts=6827789f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=iT9tRhyl7QObuXKRkkAA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: L9djxRpN_58jzdbngBdFY3yv1GBVE-5A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3MiBTYWx0ZWRfXz11VjERf0qch
 nJV8Pzqno7Fkl7ydW4jem5oy7CqVhIaezvGb5iZnmM2D1vqpFHjOu48Z+DBkm4Zqp1Ub/YIoQyG
 Q+dGM2StEX/tOyjSiQPsxbiKd3Vd56XLiQFiPoguNIowGLzZpJIHHPd4rmSrTWxvi3hWlWYT5T9
 QD181l881K523BRuVl1BajXWCiR4EgurLdSoivHGRuOACQfNwEsG695jz7f1q7nfy+DYd0XtCtz
 Bzc2PbhPKE09+y+o3Idz7SVY1DKf/0qK+fCFDHpool1ODz2z0jqdKfT1iRSS2h5752Zk8/Wpi0T
 e2CPafq3TWJszD88pbYRguqTO70rRMkycnV2aNnjxoducJjd1280+EOdWJYzJ43F8Q2Fxjeu+hE
 WRL3bmS3RdWRYzBFyZmchZsef6pl/5grLXLCHDPJ3uc9PzmxFwwFS7E29/ImF9v0Josq8tp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=629 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160172


On Sat, 19 Apr 2025 10:29:17 +0200, Christophe JAILLET wrote:
> Structures defined in hw.c are not modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increase overall security.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   10357	    951	      0	  11308	   2c2c	drivers/net/wireless/ath/ath10k/hw.o
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: Constify structures in hw.c
      commit: bd8402eec9aa3f9d6c797bd51b3c5b4b029673af

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


