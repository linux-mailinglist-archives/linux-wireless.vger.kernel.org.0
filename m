Return-Path: <linux-wireless+bounces-25606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E47BB090D7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08FD818972D8
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 15:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E009C2EBDFE;
	Thu, 17 Jul 2025 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kXmbstGw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5C71F30AD
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767174; cv=none; b=XNeEZGsrx+W5Nqkbj1D8P/WuFqw0Fnd1pDjmBxcEEh4aOhlnIkKcxddZKco+mCIWOt4HPjHwLFK+/e8MIP6hKRo6lWQ6AYaiJ2LQEYTD8L50jlJw/p5mT/pMX6o+Yu4oqzkqxeCYNGQqd0b4bKPwMV87cHa91s4A4wARKjqzGNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767174; c=relaxed/simple;
	bh=ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyCpwtrjOfgheT+JBrJ/XeJZcwoPyP9jTqcBgLH1N2jzSorNNs8uBcetkqZ1SRVYzl3sJVg6GdOzm/lnwtre/4+yK42JKmB0ztLDh7zpY2J4dtpdzthva4veRclYVXam42nUxk+525ckLens1ulmnJ/omEOT5g8r6jDddtZxQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kXmbstGw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HC61cG021601
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:46:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=; b=kXmbstGwL9feq4+i
	Y815sxyr3zgPIC7i+badJKZe3fJ9NVxNgppqa91Bk3QiyKivPw9NOauv7OpJJgYv
	ToTl0BEF50kVy9BQepNVgGtEMsAPMpjH9V1jm1I8kTNUO7DWDVClWo0dVCCwJrA0
	mLUAeSgsiUEqUmsCfTOSMUviM30AIHJhpmbJtlMryKHhDbUXpbQ77a3RG4rXxRnu
	mJ5Duq6BA6kJbnjBgmEmKqhXZQeUgQtFUziSwFESyUH8WffF3jEwCB2g0xT6yFTu
	UkwCWs8KX6j1OEz4ydoDjJSu76Ejwb3p3oMKGuwZlhkAkxLDwXrCZtAW1MJWyNrm
	lXNW6w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47w5dpkatu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 15:46:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748efefedb5so1021554b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 08:46:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767171; x=1753371971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwFGdQdzfvP/rmubG2Qeee2P6QDZM7L/fKdfITpiTjQ=;
        b=rsHU7bdW8MsCAW30OQRcOmlGXmGVusMBslaRVpLk3zCZ+nwViM0uTGNDxjHatSSm8D
         ZyuPwF7t69w9eqvW57yzRRW8G3S0rZySzScQWLvENlooD+5ZkoD5P2UQoZ/WPEdjzO9B
         Khz+idx4CGaaNJYz3RuxOWq6YeUIqd+bs6szAJXC0qJoEjDiJWTrZ9OfFytmXrSVSzfL
         Cb6a5YI34OupUb9zr79ZA/O36t7wVcf6bi2GfJEtSvOerZPn7B5hFasXr+dZ9QdXWSyG
         OCY6OcKVCUobnHflaPOsNEVECQqeaLV1HRVBXRDiu7e5nCt58cZMQccMIxe9b+P9pHmT
         P5cw==
X-Forwarded-Encrypted: i=1; AJvYcCVvJR8jdtup1elOiY3ZDKsFHh61r8iqIyV45eGJngDq9hk4QPBbNp6fX3z4tnzznhzC01PYjNjQ1LJlY8w9xA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5mHslCPABli4yTNqUFDaNco1/tCL8fWFl89KPJPc1LJj50/MK
	7qUAQoSEX5eiQ9ZXn7LheNDe1ADGROv8nHf5g21RyA8ifPcAh46l+eaOY3jUwkU9nJwwc3dMDQM
	uQyvtZW4OAXSR43NyAvnTg2Ohc27Ao5JMjL7Hy3fngtRzFs7gGZ4kcJZclxOSjCw2C/zWYg==
X-Gm-Gg: ASbGnculTO+B8uZIMvUhDIMq5Y5CJv99plufqMFF/JSEU8u+F48jthvUH/FX77mZW+/
	PTjHNgr1wuXs/wGBlDpsnYdh/yh/Ra/JeyOtjlUxkX7mOsxWocpl1amxd1wfNQYSKNOgWjGoWfB
	8anFxOFC8vbMXciQGLgA7aQDjhYg/pieIC5OX3tXsGrd3elfBgE8dkd6zFkxxW6Gc1mx7fANdCu
	f9ksIpS36AOOTES1yRpF0WUrNdGZ1Yt726SVwzSzkaRpWUB2pSiDR2BBzvQNDHqhj5dvg/Yknpy
	LAIusHcsZrZ1682SQHwHFW1gOXAXiqmIUmhAAn0Od6pLCHxcEvgubaAu3yRvNPX2demNZKiWp/d
	d6yN6E9JVHa0XI5qq45k=
X-Received: by 2002:a05:6a00:1704:b0:748:ef04:99d with SMTP id d2e1a72fcca58-756ea1dd3abmr10368817b3a.14.1752767171512;
        Thu, 17 Jul 2025 08:46:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuMgT04W8H7FqBViOukrixeUUnPxkr/5CXJJMRmftkb7wIp9ibVR7/CoJg49nYXw6zIDgzbQ==
X-Received: by 2002:a05:6a00:1704:b0:748:ef04:99d with SMTP id d2e1a72fcca58-756ea1dd3abmr10368772b3a.14.1752767170903;
        Thu, 17 Jul 2025 08:46:10 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eba428161sm16444906b3a.42.2025.07.17.08.46.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:46:10 -0700 (PDT)
Message-ID: <a5e85969-1dc9-4d6b-be2e-ac2338d38d98@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 08:46:08 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless v2 1/2] wifi: mac80211: Update skb's control
 block key in ieee80211_tx_dequeue()
To: Remi Pommarel <repk@triplefau.lt>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: Bert Karwatzki <spasswolf@web.de>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <06aa507b853ca385ceded81c18b0a6dd0f081bc8.1742833382.git.repk@triplefau.lt>
 <20250410215527.3001-1-spasswolf@web.de> <Z_jpq26P99qzPP1c@pilgrim>
 <1df3a3df19b77e3b8d1f71a3a93c61221ff46a6b.camel@web.de>
 <aHj4zS_3uhDRhzDn@pilgrim>
 <fa538ba960369497f6d65c1448ab7710f76aa078.camel@sipsolutions.net>
 <aHkHOC6DYBXtnE5e@pilgrim>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aHkHOC6DYBXtnE5e@pilgrim>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDEzOSBTYWx0ZWRfX68kerpBm+0zQ
 giN0hElleUJTJuqczQWz9CrBbIwjs0EkdH/RvilNZi3+ppotfr84C8Kq89NrLNIDsMZlEAMZCZf
 KehGITbB//lLVa9s9McEpbtFJge7FP7VMvXo2tUFvpvd+5oZW7JjrfiJmfy8BsFy3ycsXohaZrV
 I5g3AkE1IXp7nqgmZ4NTx4KNGjQJDl4UrPkE8c0BdPHH9ZpuCdL3boQikaAqKzXjNArCfP7z3pK
 wFxTkil5gHmRCRweA+nr61R6XiyY8lxnHPckxcXnygGpDdSry8LPoD6OVSLW/4UP63kVjXzXYtR
 2ZOplbl0jKUGnwOzCnsANRN3gc/FUGI/9YPgpu0wCH8NRdbE1LjYZz8vf2ULSvF0nDE91nZMTu0
 MV/M2ACDONCghZ3DL06nzeryoB4wkGt4+3OuMkLyPngiBL8VCy76gUlAKemEhiI7ru4B/MsP
X-Proofpoint-GUID: I5muxiJc_uTipDJJxP4STHFiWj2lLnOs
X-Proofpoint-ORIG-GUID: I5muxiJc_uTipDJJxP4STHFiWj2lLnOs
X-Authority-Analysis: v=2.4 cv=Y+r4sgeN c=1 sm=1 tr=0 ts=68791ac4 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=MOVf-BS0YNWMpZGKuf0A:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=915 phishscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 impostorscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170139

On 7/17/2025 7:22 AM, Remi Pommarel wrote:
> For the record, if I am not mistaken, ath12k driver does not seem to
> support 802.11 encaps HW offloading mainline yet, I do seem to have some
> vendor patches to support it though.

Upstreaming this functionality is in the internal pipeline but won't make the
v6.17 merge window.

