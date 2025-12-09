Return-Path: <linux-wireless+bounces-29626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C959CB0D65
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Dec 2025 19:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B3B3300911F
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Dec 2025 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3438F2F3C1F;
	Tue,  9 Dec 2025 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLP/kuod";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W8Djd8K8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850A12E6CC2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Dec 2025 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765304830; cv=none; b=NLnO/LGqcBhRESIYCr0cYsswHRt9N7OFPR/Aak4SglVm5vEzRZ/TkuBBoZTu/gAQE1hTRyiwfbjCv2VhZuLe48uymaFg2K+O2OSAWHTsdj+TyjFRIcNCHSErdm8VHUa3rvNY9kwDa2j/jX/41LFixTrcSS7CntCAvt4L4IfafFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765304830; c=relaxed/simple;
	bh=idb4m8oy8xZ4E3TGMjcP4xjmBIUCUvWJH7bWTXPv+b8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cG9PV0JDZFExjs9luxHMrcAuoFI0wVpZaOF+nZWNOaAMD/e74MqiLeIlNttt2carZJQ1JO2/3AFKfSQw4q2FTrRidIKaW0qn3jQicvbclTXALgqrRUUuniiE7R8omHwT8acDU4l9hvfNkn2tvVIsw0OAKGWG9Mk5IU2cE8PqNgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLP/kuod; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W8Djd8K8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B9Gj1XG3542431
	for <linux-wireless@vger.kernel.org>; Tue, 9 Dec 2025 18:27:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KWc1his47YbW3kd2ndwPyUWBoedhRm0CEUI1/xd9weI=; b=mLP/kuodHpApMqSc
	G87EVSmBZU6+wIftWzbx0snykUQ8uN+vhV3ojZMaIFkaBPsewbXsUJSx6suuYE9m
	yWRNjR0vSAqP93DTDoDwHCRk0kcUEF+I+1yvpyN71xui/zJ5jVj1/z1X3wkNDSpn
	LZ9UB59MuUl2VW9kIINS6tc+LN4edSZmzGrY+lvm67O5ddf034zDNXjrWpNw0LQz
	7qjiygkoZRHIu4u+rkyY3MKUHM7SEPIlQafOWnEv52nz0F6yc9Hspqo+sUyfESOL
	lfoQDmh3Jm86LHdP+xwLRzlRILOniAzmmosDJpiirE57UiWmhXd5oQYTHLg0WQLX
	fe/Lpg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4axesf260q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 18:27:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so12262101a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Dec 2025 10:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765304827; x=1765909627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWc1his47YbW3kd2ndwPyUWBoedhRm0CEUI1/xd9weI=;
        b=W8Djd8K8DvIcUD4XDyTxN2bg2JCnx4uzuoJAMRebqBSEX/rno6ZasnnG/Fz+fVXXCj
         3wr4R8Vmt9GkWSOytNOcykei9XNJwh57T7U2Ja7ZGiMEttbFdCAuYWXKFvqBGLgr9nUh
         ndML95+vMkxBdl11VeysZyAcmnh72teyEDwP078CPwC4lWsGj896kPzPYZ9K4JtP54C5
         HVZu5hKm32BYr6SK5/tH77Yyw7Gh65ggIvhW30q027Lo7v9iGnQHnR4VXc3WjqVKGYvL
         PR6LVvUXIw3+C2vsNIbq1+rMeZMFCLfyF0WcoLSrmMGm+R0UQd7diglvdh4TUidVy/db
         +EJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765304827; x=1765909627;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KWc1his47YbW3kd2ndwPyUWBoedhRm0CEUI1/xd9weI=;
        b=Ij/rx21lpk06iZMPH2DZR297KJIEMFAsmdclD5Cv1BCyIZdJF0a5I07gK5zCqAUh1I
         dtpt3e6YL5qVzbkkFF00rXPQuB7wzzE/oChi1hO0+wadTd0NZRK2vpn6MzNAKo2S5wGa
         kT/FP2zEQQ8UsCgLCg2nOsvptF6RapJsrAvAtondIL53oin4kBJv6Xxx8Thm2lVLMzBd
         C/LdlJ74i51d1W7Man/mDbDmjV1EydQ+iCAjOnQB8Qj1v/5gXl6KxRqkdlpw/4oRbGRI
         HR+p6Q09/5SoQNPtYMiyCX2yKB+JpfuSURTfMRjMYXhIbtDmQu/OgIlAo39Gpmjw92pW
         hXtw==
X-Gm-Message-State: AOJu0YzXXAcGYaEplLln8hTqRq7KzZ2qNX8uyqjLHT0rh6VELt3mV0Pq
	i7khlt4XaZz1C20rgO2/DsjrUxAprw8q6QIsxd/cKh7QGNaQojNcWeycA1rbQa31iXtmuWrA5sz
	5hRGED1X/aJqI+dl4pV9eyPqUexNE10lFRJ0wWZhUBUvigdHq3UmoPjiiSXX/NZZ3uV9NcSwujJ
	0LTA==
X-Gm-Gg: AY/fxX6swNgcR7tTss4B6DQgr20rnG8vFTA/uTy6gOgMBid2HkQ7iRjaFVzB/LRdXJZ
	9ur6LVVtctbl6UKlA/xJwB+nKjou0CsHsckEgqGtZTzkPr6umq4jhE+m1M1Y/tTCbtLAIKtYWet
	u6EltoEfisABClySh2UMwe2b68b5jzRbV+iOvfveksEDb1RUewCo4nPrLxmuEoq7b+2BsTfVm6s
	IM1YaA/J0bhWiiqz/NcD+lvbt3oFiz3486fNuw1iP1RNtLyo3Wz1lArmc0Jk9/a4F7rCRCIwIlj
	AN9Yren/T/MBKQ3LPLlljdHEVeuMfuulKCtVaoLvzDgk6om5TAdJOw7valRzaDfnMyS1S8UUCu7
	aj8BUXgt1K9JKANzMb9Shuax7/7RMJY4ci/8em80FhXn3dw==
X-Received: by 2002:a05:7300:f40c:b0:2ac:358:bad9 with SMTP id 5a478bee46e88-2ac0358ca8emr232423eec.34.1765304826605;
        Tue, 09 Dec 2025 10:27:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb/yPodXYo7Re4324W/yvxqRI6/vTepPoy7QBffY/3pV6kx28oYV9En+0Z21x7gstYSKWg7Q==
X-Received: by 2002:a05:7300:f40c:b0:2ac:358:bad9 with SMTP id 5a478bee46e88-2ac0358ca8emr232406eec.34.1765304826010;
        Tue, 09 Dec 2025 10:27:06 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2aba822b615sm44650977eec.0.2025.12.09.10.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:27:05 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Ripan Deuri <quic_rdeuri@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
References: <20251207072717.95542-1-quic_rdeuri@quicinc.com>
Subject: Re: [PATCH ath12k-ng] wifi: ath12k: Skip DP peer creation for scan
 vdev
Message-Id: <176530482553.1967172.17240990564355668386.b4-ty@oss.qualcomm.com>
Date: Tue, 09 Dec 2025 10:27:05 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: MXFDo7_ohuVXNArMcJs5pvijOTbG4zZQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA5MDEzOSBTYWx0ZWRfXwhOoxJp+eBaO
 jBssZND5G/AGZigFx8b+gRK7IcSGZ18Kot2tUTxSdrDMAAGs+cNKhQRJwHea32nU/DP9MWLPZ2y
 mqCBr/sqO1/ayZAkTwHRb4MpGrdZ3vFFQqU8g2fujXZfJxpsuXrMNh08xf04/eViquX0QYqWE4A
 yZk9i/Bp12eEblbiq5xoXWI5q6iS3RvDF3dMHU4CLNHfzItZW1+THrWgc5SaDzFbieVonz/HJzy
 /gZkjQDuAymBGx2t8eWo/sm+zIagur7eoPskV/6S4tCSC0EUTIQBodfpJEuxJG7QEquKo1FDX+6
 Iy3m8GYle4tvvVAAr9rPpoMqEnTD7M2+lG7V15QBUeb3kDX2vp2vTHfRvWoSStlZD9Oq4B5fide
 9ZgHqoujDVhkm5QGGnIRO2QX6EWpSQ==
X-Authority-Analysis: v=2.4 cv=fMc0HJae c=1 sm=1 tr=0 ts=693869fb cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2nbRYCtD-rQ1MBVNGtwA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: MXFDo7_ohuVXNArMcJs5pvijOTbG4zZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_04,2025-12-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512090139


On Sun, 07 Dec 2025 12:57:17 +0530, Ripan Deuri wrote:
> Consider a multi-link AP configuration:
> 
>     MLD vif (MAC addr: aa:bb)
>         |-- 2.4 GHz link (BSSID: aa:bb)
>         |-- 5 GHz link   (BSSID: cc:dd)
> 
> For AP vdevs, ath12k creates a DP peer using the arvif's BSSID and stores
> it in dp_hw->dp_peers_list. During scan operations, the driver assigns an
> arvif to the scan vdev and uses the vif's MAC address as its BSSID. In
> the above scenario, the scan vdev MAC address (aa:bb) matches the BSSID
> of the 2.4 GHz AP link, causing a duplicate entry in dp_hw->dp_peers_list
> and leading to scan vdev creation failure.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Skip DP peer creation for scan vdev
      commit: 5a58414fe107e4844e0b5b33e94d8f3e563cd38e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


