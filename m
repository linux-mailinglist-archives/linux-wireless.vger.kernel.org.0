Return-Path: <linux-wireless+bounces-23102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 490CBABA439
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096441C033F6
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F7327F73B;
	Fri, 16 May 2025 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cBTvW9P1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719728032F
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424436; cv=none; b=gdfFbDmGHkxKTWR9gTDbDMikgcltjMKk/sM+/2tDLChN69ZALPlknnh0x67ci1mE+6z0ee7cvmM7JbXKbpQOgj0eYGBjQcTL25hXJAqx1+Q+AIzriprz+hz/k9I6VdrQQdx7QU981owpqMVDVRheyPOsQS2OBxS/fZCHnelDfgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424436; c=relaxed/simple;
	bh=ilmrT+VRrQnL1dwErVZh6m0hKfcQqf7jU3gNr7+R03Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=etG53kAQPg8Sn1nHK4zhAcweD+7+Nnts/E5Wb27ECJpppTxdjNOFJlrRYBNDU8bKSvmR2uUKmhDdHUvaw+p7EjQLFMkxxgxL6e6cBo8e50DoCNL4UGEPQX7/XbnC7tm+62KQLFF8WfGeiyAOU30TCCYRdBhcbUidZtQqhjO4c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cBTvW9P1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBU9NS026254
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PVwBLv72/jIjfc8fkVtQIcacM3WtFV5IJFfM/wgdK2s=; b=cBTvW9P1f4AIi1An
	Xj4ZaySp7ojI5y6XPl3t3hP7TPh+HtgrYSLFkMSSq0AoPJ59jdHUFeiMmtpeZZhR
	Mv8qC62EqGQmnjGXZg0GvUxnC+bNGZE4vWDJl7uANZyf98op33djQAK44pWDJC+1
	2FLkWAcFo4m3uHIhwGQrwEWu40PCwmmaeYDTzo7D+x84kRToLTrm72SSgCWG4XeM
	qs51TZnG2Us5ssk0P4mKoO62dWR4k0+gkVfkR929d1XQ2goh5BWeYaMmD7OfXx28
	gGV0R7ZoGytr+WMbuPCGWOFAKZxniNJ2fiKozaDKhcdc3Qfs2QLXEI2ky+zQagjG
	VyWuqw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46mbcyu82p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso1284674a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424433; x=1748029233;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVwBLv72/jIjfc8fkVtQIcacM3WtFV5IJFfM/wgdK2s=;
        b=DSc5zAJfOC1E5xsYRfA0NL1kKc7wWc1koQFJJkhO5KKymh+HLjIf/egQga4vPMkNV9
         scTHLjNES/gV3ole6HlSMvr3EOzGqzrH/SvH0cOlH+7X2BdC/f5du8XXH+R2lSdIZjMU
         1YnJwwwf92o3qwN4VPWsljOOY/wCZfDFmx2P5nrfigPrlryFjKXyBQy887bzSAxUUMhE
         qHNAPNUHhhg1MLzMBYS0TpDkitA96PKOk9Rw4MmwuTdhtA8IEq9lo0Rc+vB0gvecXeHm
         cpzVCRe0mKmWSUHGyfDPcFEkSWSH0QXWeNW3QP0NFOjCFZOu/2xZTdgSEd5T5G2vGj5c
         h5Hw==
X-Gm-Message-State: AOJu0YxipGoWwnYOjVHLc9n7uNHa7/99MUsrEhkUrFsZe9EdEeKStocP
	QtdspeDhhWLiK/mpp6IfWh5kq0+zLErPB9YQMkABiOTA5UQcSjDxg3wFtdEujKsU5N7MCJCyMjJ
	mJVwal0g6lJ8NUnpkYTrGQYtzXrub+VCcAubuHWULgVmmxvFbr1cU3ccYKxAamGRxY/WkHqMU0t
	lLdA==
X-Gm-Gg: ASbGncubxTDbjpPr5oe1I0oyS/UTKKcuMQ48ofFeAn1AALpQ2h8EjJHupDaXQHFxYz9
	kFFU8TMbvrl9Fc0cQd4V5ZyS2E2L8LgCrgNjenGjRAKVnjR8y5Nhmq+Z8/ir1VBCr9fWcbTZ9pZ
	Dz61/9MPZh2THtDfzID5O9My1Z5QIctKbftNsJw49Xgw/C/yvhVW14gPaUWNHYbme+JrVg0eqQ0
	q3XNvIlh7lsF/Tgh7Qa5kpCGYcXSWfwxXcq582Nk6z/WybFvDsDNyKw9xhGJB2Ta/X9ZWQXcHIl
	8hRgrsdssXRndw0ypyoqVvR3hM6FE0uCtUhc6tarovZGggHP
X-Received: by 2002:a17:902:cf42:b0:224:18bb:44c2 with SMTP id d9443c01a7336-231de2e6c8cmr42140765ad.6.1747424433302;
        Fri, 16 May 2025 12:40:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkIeQF6Ytx/Fz3MUlJS9qx7AyuEa7pBWc8iwkgcsaVL2E2VmrhUxxUSJ2yA3UZ6/9suSvfyQ==
X-Received: by 2002:a17:902:cf42:b0:224:18bb:44c2 with SMTP id d9443c01a7336-231de2e6c8cmr42140595ad.6.1747424432942;
        Fri, 16 May 2025 12:40:32 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:32 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Muna Sinada <muna.sinada@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250424221404.1262597-1-muna.sinada@oss.qualcomm.com>
References: <20250424221404.1262597-1-muna.sinada@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Prevent multicast
 duplication for dynamic VLAN
Message-Id: <174742443237.3316767.12135704112973393808.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:32 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: V18_rINpcoZctR6x0zEHZS3ooQeMdJip
X-Proofpoint-ORIG-GUID: V18_rINpcoZctR6x0zEHZS3ooQeMdJip
X-Authority-Analysis: v=2.4 cv=JszxrN4C c=1 sm=1 tr=0 ts=682794b2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=MUrHrFjxuhniufZK1DcA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MyBTYWx0ZWRfX3+O4SuAWp+Rn
 xohgg3zICXAucYA1phfoYAN9Jueb0fy1zl//e1IDBIt5sqAorz4ozcNWFPRIs1F5L14+sKPiEPZ
 J9b4aq0OmjBVKGJ/MnwIutUKsDrCbO59TQkFMq5TR9+b13DhwrFCNVhNKsm7f7xEy/gdKwLSdwa
 w8ftA5Lh1h4xMTFn7VJA6cuX5XuGdSg/K01C9QG/8O7afgeQ5g8r/vvVYu9Z8d4DrSdk5ICl5Ze
 rgXYsfXXDRXZi9v0JWj5Giy85ewPb1ZVMKG9BlGfysPDovM+JcZtPMYvNY/opVmfnpk/v6znagF
 3DveLbtK3iLhVJFgVqlW5wLvnfbqY432BwFWMxADb6dkOc/RFzTM4uGQ707xyar4f/RpCLslBty
 NatR9g4YRaeKO6/FGcqpQy7P1MMkH03dLF4RXrNrJLtiwpeiBqfAoS2/0TKpGADls6gq4ioX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=668 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505070000 definitions=main-2505160193


On Thu, 24 Apr 2025 15:14:04 -0700, Muna Sinada wrote:
> Since dynamic VLAN traffic is software encrypted and encapsulated,
> mac80211 handles the duplication on each link for MLO dynamic VLAN
> multicast.
> 
> Currently in ath12k_mac_op_tx(), all multicast frames are duplicated
> and are assigned a mcbc_gsn. This is causing dynamic VLAN multicast
> traffic to be dropped in hardware.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Prevent multicast duplication for dynamic VLAN
      commit: a5f95d3d02d92421edceb597f93c7348e54a5264

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


