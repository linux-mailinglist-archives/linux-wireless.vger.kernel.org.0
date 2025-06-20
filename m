Return-Path: <linux-wireless+bounces-24274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 107EFAE1069
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 02:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F30E7ADF42
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 00:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7FA930;
	Fri, 20 Jun 2025 00:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DJCimJmD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1580E30E84D
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 00:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750379594; cv=none; b=PJBHzi56AqjoEGgK7417qarhWkeFfJHTQyH79j2Rxyiv9hQ0TTbF1n5MXZxb4WMHvngwCm07P30MohShDUAfD/ozzzpTFrVwR4mtCBo3zvCkJYklYzlr3RRfqV9/KLLmwJHrV3hS/mj7s8rr6FZJZWS+Qvt9mpFfAPXVd23sIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750379594; c=relaxed/simple;
	bh=dEjH+FSN3ipBFal1GleYoxDYC0kKtc29ALoxhYDANVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ROD+pKUH+a3w59Jig5HVj+gZ0dsSeZ/HK4+k9hbtIfgQqilY8TXpiVMCG3jAXkhWKJs++daOLxA3sUN1K45XOglFVxLNgYaWeadU+SnGl4YbQewcnOG1g/QVCppoGotdR1CJXL/Em4LqOpn1vyFuMTRurqROFdshK/BGrve8iVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DJCimJmD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55JCLFbi007075
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 00:33:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ksoABJXXvx1N7hucQ6NraV5GRYy+LrljohBAACfBYU8=; b=DJCimJmDniSrnAi/
	lA/7GdTkSTITFfbx7hE+c7yk2g602L6WarirUSqXbmomuzG85xCqRWCm+DqHZvdP
	9sASt+NHpnbS2QAvojqcT7ZWsHG6qS9Ll2Kw3jDSQ1DFddyHWq1irh7NfGXmsIm3
	bo9ZThfwlcLMHlxVGSEF7aQPQyI2skZCgriJk5QZVjRQylrPeE1zixBHplcbbnJu
	2kkHR/gYDYG66WMZBcW2Qnq/m93eZrzpQeBXhuSg/lyH/px2bSHO16IWh0VD1Vi+
	eop16Qi9ZMAncCgq8h0J2r3C3VOo25V7qFUPdU/HDvL7wtwVm7zBldTx4h2sPM0q
	IalWCA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47c0rvmqsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 00:33:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-748865aa38fso1805203b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 17:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750379590; x=1750984390;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksoABJXXvx1N7hucQ6NraV5GRYy+LrljohBAACfBYU8=;
        b=TfWWB15G9FHzGN5MPv8+VEsEh4401e25yL/YPrSATCdr//j0N7Td5I5lvTx8bBivv0
         bckcPU/cFUdXqNA/xmUvvkWlxoB8chkB8sBjbqYqn8qVzum6s6+rA378UZNIN9PjV6BI
         eF1Njsl1VLDLH0vxuNJ7GePJxWnBC2kMQKP62oR2mUqbBnwxS1+m3nbGoJJ7BLpwV0RK
         yooqX8nj+AqOxKG1qJtc/ftjS87SCP8WBJDw4sMz1hTuxTrDDYy5V+HLSpQfwjA8hlXw
         XJiS+24V6ig0quBDHRdviYOZwf7ryfp+DGEup3C0iBEw9oXtalhjHz/OsIMeCIxja/ep
         ENyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfhx0BMqXmqnOCi4bbCvQwvTamedboSVOPsS3eGhaKoiMNgWk6c/EgYMsJO5JNZeNA2MoM7RdxKFeft6rQ5w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzol3aoTuKhAAYOBV+Bdn1Hx0VzeVYQu5C81Yz5j1mKGRvzJnsX
	aKXxBSi3XVrltyYTdRUCcx0jNJJfEETI1dG4HhzWCS8Rt+U/6K3HEMePLKoXGkJ46SMCjrQrzNw
	qDztObLgiveAOaPT8i6oreZRmGfrvLzTxw3CMlfE3fh8UEOVWXZsKiIYVT/ioZvG1zajCLw==
X-Gm-Gg: ASbGncsIWtzOMfXWZeoncc3K6TG4lXRsKjFlJMRZ6WXVZG/G2tRwTED4vze+fXPlYlU
	aXPgirydGcz5ItccioA7ZfeKNuATIYV8J6mKoYyoH4NisVWxwS28E07rYGyL5nhRAhciVtqwmFr
	lgNXjnSdtGanz03w5+VhKot4VIwQMdup48nb1RbgIsBCxwiFtnSBmZW5/BirfX/XFa/f4XoyQrd
	iSy2LB2ulzoEixTruQsW/n/AysH3cr6Zq7WFxXM8rCwNKQPy9ErbH003FpGaJaXDDDopt9sBtOB
	IVLqRWLXfs0qGdcJYvO1zALkTXg9fJi+hJIUzlhcSUvs5574byMMr0Sht2yiFPmCIz6PEslL0PU
	kZRRZjQwwNtQsIEo=
X-Received: by 2002:a05:6a20:244e:b0:21f:77e2:13a0 with SMTP id adf61e73a8af0-22026e13231mr1171724637.5.1750379590469;
        Thu, 19 Jun 2025 17:33:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoDIsNEyUlki7ZjrTI9GVJS+GocIYC/rwWPCWnAG3PSWetKeeD6OC1n37shGoNB4dnpm//FA==
X-Received: by 2002:a05:6a20:244e:b0:21f:77e2:13a0 with SMTP id adf61e73a8af0-22026e13231mr1171695637.5.1750379590051;
        Thu, 19 Jun 2025 17:33:10 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a69bb81sm708272b3a.156.2025.06.19.17.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 17:33:09 -0700 (PDT)
Message-ID: <37561ac8-ac0f-4744-9495-c7589544d4bb@oss.qualcomm.com>
Date: Thu, 19 Jun 2025 17:33:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv5 0/5] wifi: ath9k: add ahb OF support
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, nbd@nbd.name,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>
References: <20250609030851.17739-1-rosenp@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250609030851.17739-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDAwMiBTYWx0ZWRfX+v3qRFeMEDnI
 nuUgwveWxsVrPpNdvkUhu8sZmKFykK84zojfbUM25Tm1Bb/IQHT5UQVBeCRuZSaYz9N6mJnEf+E
 96UCpGtRm1UwU21QfkqYONdCp973OdMhAUrQlsW0cTgJC/+CjWIuKiZQCR5Kdk59XeLoghjy4EF
 u+qsp65BIbqXibeestMuH8DX6opYnf3pvGu8F8uoLDLfttmI1pfCb/RQtxRtQQrSFHNQ/EDdobi
 Z+8XwDpe0FJ8cfPKkMxZGJrwDK9os5oA385/59orzMfYOqQNQWFuyHZU1aRDsfv1dgODWurT3TX
 qa+JkIuTPd3nf7yfm2gjeJw6rLSbfuAlnY1gPVRnvEYZ0/VGzJsKpMSYNxF9sRp6NL6tLqdBKvP
 XuBGd3gAi5r3QO4eTEg1ilIIzoju+ZeMZLypAbQkbV11XHV3Gk5l0wXpC+Pfw7mbDnN2n4lE
X-Proofpoint-GUID: ByKFrhfIxCWFnuSSwTszkuKpGAA8kNtu
X-Authority-Analysis: v=2.4 cv=btJMBFai c=1 sm=1 tr=0 ts=6854ac47 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=aMoWnUFRsw3tUzfFL3sA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: ByKFrhfIxCWFnuSSwTszkuKpGAA8kNtu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_08,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=762
 bulkscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200002

On 6/8/2025 8:08 PM, Rosen Penev wrote:
> First two commits are small cleanups to make the changes of the third
> simpler. The fourth actually adds dts definitions to use ahb.
> 
> v2: Add documentation, use kernel_ulong_t, and of_device_get_match_data
> v3: Use qcom prefix and wifi suffix as in other ath drivers.
> v4: fix up dts example in Documentation
> v5: move back to using qca prefix. It makes no sense to diverge between
> all the other drivers for MIPS based qualcomm devices. qcom as a prefix
> is used for Quallcomm's ARM(64) stuff.
> 
> Rosen Penev (5):
>   wifi: ath9k: ahb: reorder declarations
>   wifi: ath9k: ahb: reorder includes
>   wifi: ath9k: ahb: replace id_table with of
>   dt-bindings: net: wireless: ath9k: add OF bindings
>   mips: dts: qca: add wmac support
> 
>  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++-
>  arch/mips/boot/dts/qca/ar9132.dtsi            |  9 +++
>  .../boot/dts/qca/ar9132_tl_wr1043nd_v1.dts    |  4 ++
>  arch/mips/boot/dts/qca/ar9331.dtsi            |  9 +++
>  arch/mips/boot/dts/qca/ar9331_dpt_module.dts  |  4 ++
>  .../mips/boot/dts/qca/ar9331_dragino_ms14.dts |  4 ++
>  arch/mips/boot/dts/qca/ar9331_omega.dts       |  4 ++
>  .../qca/ar9331_openembed_som9331_board.dts    |  4 ++
>  arch/mips/boot/dts/qca/ar9331_tl_mr3020.dts   |  4 ++
>  drivers/net/wireless/ath/ath9k/ahb.c          | 60 +++++++------------
>  10 files changed, 84 insertions(+), 41 deletions(-)
> 

DT team, should I take this series through my tree?
Toke, Ack?

/jeff

