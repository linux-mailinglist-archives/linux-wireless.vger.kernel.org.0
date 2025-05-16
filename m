Return-Path: <linux-wireless+bounces-23097-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D565ABA43D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 21:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB54A406AF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 19:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E203927FD4E;
	Fri, 16 May 2025 19:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jon1E7FO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA37272E63
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424433; cv=none; b=UfX72mpxH+kt+csSBDsgcEnc7ONFoQKb1cmjPqFJ8f1rmNkKSXC7RN/XDtYDAniOFfA/n6jNBeu5I6gSMfpQ1EBHNp7VOQJuqlOAZ9IYc6RtM6UbvQw04MDEh0LmuD3n0amjJaJPiy3LK4iPYvUprDBN2Mj1OiMcaTJWJuR8V+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424433; c=relaxed/simple;
	bh=htGsAnW9vIIcUuHNlVZK/96B69SfrCzF83Cf8cvTFnM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MrV1iL7NjC3WaFuOm/lK2U25fte/igr9Bxcv/GqyvkvUuw9LmvwyjjCRE9yI88XEHcatY3tluP1OlSKSHg+e6Oba1oieP5gDp5WcAPkM4UgVhkyBBynTtsMs4ISUj/tqHcPIWHnz01/yOhcMvy1B7rTozevRhGkBUtN4y7sKxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jon1E7FO; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GBRdZS022995
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	h6c7n5DafH+kHXODhMMCqw3rDnPBMN0KyD+kENoMLGo=; b=jon1E7FOhqcR4XMZ
	ngpip/Ik+cyYx36d919nDFR//V2Y7GrLq/v4zaaAdkWw1yFqc6CH2QWdVlQWaSst
	eCiCo8GHKVNmO8g4o3PxRkMxNtPEVZyHKI0FQ0qALlvvwJk5DnUTKFZbyX+hA91j
	A1LroPJBVWR+MWCvLNafVutSkliFeiSqpPYYxQxGAP4E63LbWUCJ9sO6htH1R4v6
	YhAAN25JE9gCUNr7Gc91Y6adrzatKBtpnqj4XgKoFzhfhZWoqoT8nV3+SihcAUQS
	25AJnki4RCBAb7dBLrVv+xlKn+FqfNmu7WYGz3NrIVJU4DnpZPxAl+TJyFKqI+eD
	wTByRQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46p4gq99n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 19:40:30 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-231d7f590ffso8805825ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 12:40:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747424429; x=1748029229;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h6c7n5DafH+kHXODhMMCqw3rDnPBMN0KyD+kENoMLGo=;
        b=N+EmI48jN89gjUpgBDehdOaBTBD4S3I7NDvOpY1sGj7x3xvWSk+FMXjdeYSHMefsyF
         NHKeASMmv6qvQ8HRxfLGrzvPqffaXlL5Jrs4cNKQkyEzlXBKB+nr3scHmuLn8kaLXUID
         K+lCYlIll3EHCTb9iqKTWeMEaEZItZWXet7A3GZrwo66v/CbkxyZuWCXeMhWm8StUN/0
         Kn/dZf9BQq93gvvqxBDsBh5kiAwKNGot7apmzrSdueW/4whB9DFmYcYRIQzTD5KEUoe/
         X58Xz9YuKwWapyr4InQol6AP5ha7nNV9jO2NSIsnnqnwHkc/VKsqOplA+4rv3nRFRt01
         6l1g==
X-Gm-Message-State: AOJu0YxyrweJr86ll4a6kMCppaCb+W2GkJ5xoTK2d9Xn3SHI+Fyk4Pkh
	bJ5lyNmAYLVQJYemb00JHkzPwcTf5/XyZHGLmJDVdY4anuON6WznwZWmOb0QnmyF8OJZLEWIDgR
	sRht+p447xOPNUro2mELbZSZvAOxIF5we+/jXn11+Pr2wEWbVCOMNsmaA4G00jSTrkNKL2A==
X-Gm-Gg: ASbGnct2XauaMmrPlsYaPFSTxFnCGMeS0MHL9I5nj6/PcwjKTd2nYMKWvdBaEq42oNu
	fPyf3I8S7RW+uGUacQHXn3XYYMh9feYJ8h4hDdbckbArxrxKO4ncdgJ3Na3Jxn0YWblV/Ptfdts
	PbJRAX9ekpt7t6nScJS15KUpheDme+zDif+d+9/SFiLplux9OCCxm9bPg2s+k2LCS6Vt1rnRpxQ
	sHxuL5BFIzdlaylaQxwXi4vU3X1I7aqjhnjOENncr8JfyOtvE/xwNWvnhe64xMdZrtS2PC+vPo4
	ntlm3580balYpxARoi2PdlDBQ1WPGSibP+gZOxvGWw/Nvx2z
X-Received: by 2002:a17:902:e742:b0:223:4341:a994 with SMTP id d9443c01a7336-231de2e6c97mr49516515ad.9.1747424429368;
        Fri, 16 May 2025 12:40:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCZ6lxvExb9dHFY4zmyLbDl9SQjg5iXwjDDd8iQxCPbeg4+fT23K57b6hk+lmG1RQDRMYplQ==
X-Received: by 2002:a17:902:e742:b0:223:4341:a994 with SMTP id d9443c01a7336-231de2e6c97mr49516245ad.9.1747424428952;
        Fri, 16 May 2025 12:40:28 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97798sm17955255ad.147.2025.05.16.12.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 12:40:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Kang Yang <kang.yang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250416022011.1935-1-kang.yang@oss.qualcomm.com>
References: <20250416022011.1935-1-kang.yang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v7] wifi: ath12k: delete mon reap timer
Message-Id: <174742442831.3316767.12622994031508589555.b4-ty@oss.qualcomm.com>
Date: Fri, 16 May 2025 12:40:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: ctiFe-D8oJfKlhblODBgWGmNYJP4jvfP
X-Authority-Analysis: v=2.4 cv=KulN2XWN c=1 sm=1 tr=0 ts=682794ae cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=tbk3IEclxwNNDUlJFEYA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE5MiBTYWx0ZWRfX4pX4rrUxMKmA
 Bq2cSHzOwRkx3lFJTvvbiWejKiWW2iJkpoy7ThUZvjNcl5YH9HRB4ne8am4SFhQ/B9iW/qNxUSE
 mlUjJkezOg0eSZ4eDEzYhi/gv/rvt0tw9kaA+Yu85O+ce/BQDlfFCzbutpOpv94mVsRPvME2kY7
 I20TDG6oXb2jYDTAccCyZQj5+Z8dYRTMRLVKdq5VGBIela2Sg90MDAnnu9aBOck/Mq04yNrQE2f
 IbMSkKGsA9scJaeuNXFgeQ1RZvKmBvNUks4GfvSp+ScRx1wHK6XqLOiGT3sxzinugKZJqZZ5P/r
 vwMKDXVga+HyOk+WqWxYnX/57bIydoeUI4ePe8NxQVqCb4ZW2e+t7mj8X04m3ld3FzjvwVh34PO
 wLCu7T1HPmLne9dw4EylsxsV6Q2IirVCp4AnDkhpo+DS8ppOdI5Dh70eqXmIimCAuLd+Z8ay
X-Proofpoint-GUID: ctiFe-D8oJfKlhblODBgWGmNYJP4jvfP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 mlxlogscore=768 clxscore=1015 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505160192


On Wed, 16 Apr 2025 10:20:11 +0800, Kang Yang wrote:
> Currently mon reap timer is not used, and it is not needed anymore for
> WCN7850.
> 
> So remove related code.
> 
> This change does not affect QCN9274, as the mon reap timer is not used
> for QCN9274.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: delete mon reap timer
      commit: d1b4ccc24ea66552dd718d2fb2f305ea9ecf8363

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


