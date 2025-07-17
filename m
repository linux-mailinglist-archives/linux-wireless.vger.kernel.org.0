Return-Path: <linux-wireless+bounces-25616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2784CB092F9
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 19:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17BE73ADDB7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC92D9ED4;
	Thu, 17 Jul 2025 17:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TboCK+3X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7A149C6F
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752772469; cv=none; b=KGdnHBfbvaXzr2FB1KgyZ8ZnykDaiSmG3dinQJnPuLbkLUXHYpnsxDVAH+YIOsykb1ULIs3Q2g/SLGVay9kUXnvLBKWoP6wGqAqV/WDYfRpvZj2ZF8X7UynpPkzqRY0ElUe42YJv3O16MG7RpDChnfVmyTlAY6lk9S/p21YfWCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752772469; c=relaxed/simple;
	bh=R2XPFw4AaWnvgOJBV5DYVm3/7vVANR9a9XeIQH3inJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4FBrxu0Zh+iXAUSH/MEVFwjVZsPaKztHGtblQmyk3g9xWfvShd2y8Xzd2HLvK+v4iUFkXGbMJMyDeJrY7DjZMX7dG3S34QI0k4dS8k+U3+oXFQbcY+NE0XuV840PdOglee3krOg3CMdv457gPlxoh1sc/j+4jSP/UuRglm1Y1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TboCK+3X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBGXdu022439
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:14:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nctCoQOwVx2VreMm80S+O1eLM/uAvusb2nruLcJYSPo=; b=TboCK+3Xdsla+WRb
	+6+fjn9MpovDRp+u5D6SDB+Db/PUPGxLlThxXf8lr1LWeaSqxurfxfp2e9enOvEq
	nWqEQqqDi+V4eTF6U6Wru0MO+RzEJp2JOMFTfNeqmQb5BeCxlJjRnNroTfJdutI7
	dueczVz8MhlMwQqljISJi+Ed6TYi1BxZR4eW5ZKHh5DVt+v6RchvsjCpxjJNczIk
	BUQ9a0UMzXfIQtC+r0Zp+infObiNj/mEfEELdw9l+qVY3Wjc3HeiFonsNGHMqYUf
	a0r6t4L6Zt2n78fNSW+a/sfWP9fqAfYRc9lY87UBANqzS0QJtivXTEvocjIGiaUX
	R6FLAQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wqsy8j33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 17:14:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2369dd58602so8779855ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752772466; x=1753377266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nctCoQOwVx2VreMm80S+O1eLM/uAvusb2nruLcJYSPo=;
        b=PSec+O1LML6n64+wG5lKaAfBB5N9a752Oj7soI7wwLcIPfcVUgj0TDZA9RXsJeRBna
         2k76ixcZLz9dnKRc97Wi8vACbytKPbV+jE3WuEhe09mBYm0yu0QJxQRSyhdfA8zJvwGY
         BF44xnQiyXxi08DSCeVIxLrXdCqeyRWtW+mmseJxw+6gg6VRqwod75Lvb+0oslAViWjK
         buT9/QPPAxOXF5qVmdGUi6uzkb/j98AwcaCMknx4SEB2X/iyy4kGRfY5aiKfuqTaTxyK
         BRGqUfLXxN5tWi/QDsVeFU5AMDdEFGjuLexrmze3jy4uN5AnhNgn7Kx0dkwlV9A1d+cz
         HOOA==
X-Gm-Message-State: AOJu0YyaVWBtC+5s6hwVrv96xo4hmDdNhivB6Ajai79GxkeNT4kCjGJI
	5DkfxKEU8F09Agf8jEfXtuY50lV0MJcThL2BwNDT8HJInREk6j2AI2Sn1MFSC4YaXlXyihrKeBh
	JnzNgsSBUTUHRboUR94F/myYztYtQ+cmx4i1R7gpYfd4HQWSuWebU9pTnG0aa603a61LI5g==
X-Gm-Gg: ASbGncs5baieHx1P0uhD88QkftkpFIaPRlT8dA/b2XazRfIXDNjyAFauAwT9cCy9iZD
	+gjVrFpx+JJ94g4g4rmcY4TzLd/3R1dWVf9vIufRHo8lvl1US/rBDWI6ZhZiBipJFpegOq5bAQg
	sNdTIWPXQTXjqfEP/0r4MRm10ioS+Wbgpn4CZdvCbElwz1ERkeZZanqrsWcvlnmwpmOZGzayjOV
	9qtJ0cwIQCILWmH+0w8ijvd0Qb8QKVE2yW7b4irH39qnVdEhjOR4QmQFamDN7cVS5nMOuWdKMRu
	JcO9EEv0qtco/6myVgItckywFpepsAkqukgXfBKqk7/SPb4BLIC4RnNCJY88L1glnblkoyg+nQs
	BXKNY06+1UK+P
X-Received: by 2002:a17:902:e847:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23e25771857mr105318465ad.48.1752772466399;
        Thu, 17 Jul 2025 10:14:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQxieo0G9qOuWsHwOUb+yMkawbhF1C4BakOeNyDTCgxsQsoNMgvnnSNbaBLBbPkuoQ6NXs8w==
X-Received: by 2002:a17:902:e847:b0:234:8e78:ce8a with SMTP id d9443c01a7336-23e25771857mr105318125ad.48.1752772465938;
        Thu, 17 Jul 2025 10:14:25 -0700 (PDT)
Received: from [192.168.225.142] ([157.49.215.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4341833sm145166655ad.173.2025.07.17.10.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 10:14:25 -0700 (PDT)
Message-ID: <24dcbd98-cd43-b155-4c24-7d5cf54cc07b@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 22:44:22 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH ath-next 1/2] wifi: ath12k: Use __le32_to_cpu() conversion
 while parsing wmi service bit
Content-Language: en-US
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250717064527.1829660-1-tamizh.raja@oss.qualcomm.com>
 <20250717064527.1829660-2-tamizh.raja@oss.qualcomm.com>
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20250717064527.1829660-2-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MiBTYWx0ZWRfX+GcjE3kXf7mI
 Qj/v8D7FzugDRo9XJbbr68a37w+oxliHVOBYxNVpbaFswW52p0qCA/HgE5YN6TE6WlG5pUgHy0R
 5DqZ92wSqJPXsBTvLSOlfZC1ky3/bk+a7xUirmuLZJarIQiPLDAWiMxHjvwR4jryNo1cnshFKWC
 Fz1KG9n/uiQXUOtcyjMMQqBPcD2/6ClBuzyXY2ot67Rf5ifjvdXdf1r+lt2TOJ/ABM3M0Uf8Fcc
 kgLsbR8uaUSnukj7WJOodzQZSkoFp4bUsS5wRJcuWZ0SlEpmkU5UwxXmlnav+zcX1pUtqCFDFUH
 AbqOqZ2mLLT79Ah4Qu+evc/xCIO3j7bjP6Rc3u0YUlmz44ikD6K/vYuwXTSFTH1xdWO9qmFOKX9
 rQIC/F+7qm/GEV23P9Sna9clMMf4zcAN/oT+W1yxa47FJEOWh7l9zuVLqjWZ75lqgEVCBj2J
X-Proofpoint-GUID: luM3fZhWcMfex4cjTUBKHZnhWIMNcpLs
X-Proofpoint-ORIG-GUID: luM3fZhWcMfex4cjTUBKHZnhWIMNcpLs
X-Authority-Analysis: v=2.4 cv=McZsu4/f c=1 sm=1 tr=0 ts=68792f73 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=yGYHVi08oRoRdJ9zovgz5A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Fk5S617eLcW_KvA3zIoA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170152


Instead how about title something like below
"wifi: ath12k: fix endianness handling while accessing wmi service bit"

On 7/17/2025 12:15 PM, Tamizh Chelvam Raja wrote:
> Currently there is no endian conversion in ath12k_wmi_tlv_services_parser()
> so the service bit parsing will be incorrect on a big endian platform and
> to fix this by using appropriate endian conversion.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.4.1-00217-QCAHKSWPL_SILICONZ-1
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Fixes: 342527f35338 ("wifi: ath12k: Add support to parse new WMI event for 6 GHz regulatory")
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Other than that

Reviewed-by: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>

