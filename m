Return-Path: <linux-wireless+bounces-27110-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BF5B4961F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 18:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496041647E2
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CAF3112C8;
	Mon,  8 Sep 2025 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T8Jo/J9r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2F2E2DCD
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757350200; cv=none; b=CjHDsnUnN+9AXe06My8v5JmQXYlPn5EScCSoD5IwFkPu6wFJO6+oD06CqBToH9ff294ILvLkB7Oy8NLEBFXyUKZc/LsdJXadjVcS9R6Vs+g8ElOr+v6BAhDLTT2DPFZ/pU5PJeqBA5GJMOv1OztRlUQS1pBYAl6Hbe8y2LPudiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757350200; c=relaxed/simple;
	bh=JEtBp4nWlL/gSYH2z2WH6wFwIkvJdVFll98+dPenHAE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PHGjExUZH8Ss6NLlSOZfol47YNbq/IocaSuZrpcincIFkn56bGRNzrornWJx0nJ7yl40vWeV+xTXKjTRXzXpz7TfZ70Qv5sA8CK+hrQT2sHql75qgCKV0Rj1BiOxRri974jtNLyv5B2ILrQzDAJ/3rxw53boO7m9/9LW9D0Wfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T8Jo/J9r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588BE8lW013569
	for <linux-wireless@vger.kernel.org>; Mon, 8 Sep 2025 16:49:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tmc/KncJcDRAf/6Ym1h7RSvUJ/Yk8F28mp2Cw4+IbTI=; b=T8Jo/J9r57K9cxfO
	nOgTGtQUJ+cWzprP6LsL0tNFyir5S9zbfLkSbc9k5/EjGaqzyPFD5ktblUtkLIKR
	Za5k8ID1/wfiw0B9tS6dSJPzwl9xJhTIWzU2+KEyYnN9WdqqYiNAH2nizgE37/uU
	/hSqmdljTisOGrAP4rHFLjACiClYJ/nbSbt9oxaUGEKeV7eBbqNu8zh3ijNYqRol
	tsYT5/JE34gYW6XBznhJu8Yk70nocJKTINu9Z8NgPP5I4MJGZy2kEpgiGEwgtasq
	DoNHhr4hQ5d7fcR6Mx0BZTg8n2RKX+JxU/DNLpHqMdpsk9JfRVSKdvCTG4eDMHUt
	7HlGcA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 491qhdt4x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 16:49:58 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24cba71c71fso37367735ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Sep 2025 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757350197; x=1757954997;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tmc/KncJcDRAf/6Ym1h7RSvUJ/Yk8F28mp2Cw4+IbTI=;
        b=k8I6HZQkoltfRvnliBAwTFOxxY0R/b32NfBmyxMH3biaHxQcTul9znHfEg9/yxpEOx
         t7u0A2n3ticyyY+XNjKaiF8l3PotrnFeKomtZKaWgObVbCV2ST2XtpkZphEieJ224slB
         SWc7BdfpFFiAS88VriEt0WI0qEgArCI24XcU2WCbmCjshETY6yWBpvM9MSpmQROkeSbJ
         qtTR7yFPN59PSeSdsOvm7VjnIfzxcpGaajL7uPiEsYqrVDgG3r7aE8Spzi1NRnmWk85W
         74B+DzOxtXBBX80NyIk8zjKTOCGVB8WHQLQphjPeshjXJ3NIsRcRBPEx/1ticyFLrhwc
         DE1A==
X-Forwarded-Encrypted: i=1; AJvYcCVtDd2fLFRWpvIbPC7XCHRk7zPLpDFBL++uIMD1arxNnt6uVgozpWNoUVMunmpK5IQmJdiSUTjD7Bges6yWxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH0Uy9t9wG7rKD2sJp2GUy8h3p+GUuJMq7KeKE9vpWkKGuHaIj
	bC7Mj89bX0O7u50Aw1EvvxJ5YEUXLJ1OlvLc9AJtZ3DzyQ/vj1hK8gKS4d7JhI0sA5ftAET+jgA
	5AUOeJ/6HPamhM39OOynshZKzmmjEpg86LvX0kaRM6UFAth9CPNfp2cLaaFKk7AvtUyqGF0QNOy
	MnPQ==
X-Gm-Gg: ASbGnctIeckOEVOhsfguHKiL0AVVHJKf25OfrdiYaIisBmy8wsD7rGW44hcgYqUmGrR
	8uU9/qXp7cNy6QzLfDd60lbi3I6C5nM+DhcCcyB9eEFlBxGKa0SeFNKsl76f8NyIoabEw1VFD3u
	YsZmvgi/mg5FLTaDO2lEtPvBkeEqEWkFYTu8oiaDeSzZMvaRgoNQBxzN19/jr+4BqKmjC3dlpt0
	vrPB2o8IMgi5jSrUNfvgOf6UEIpnRA4lhXttuyShzAREN/OzYCEvr+uy9563Fmi2opTVxnxqsss
	7Q+IN44bQnxj2dROyh35703qIcdMvt6bkVjHvo/xN2g+u8/Ykw2ooaSB4P8au8sqYWEv83yuTxs
	H
X-Received: by 2002:a17:902:ce89:b0:24e:229e:204e with SMTP id d9443c01a7336-2516da05c43mr113562685ad.16.1757350197049;
        Mon, 08 Sep 2025 09:49:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHndtWQTiMWDQbMOMbDHp6W6wnK7I1e6M9IeM3dg7nGZndf9T4LlIhZ3ILQvi+OcSxqbgjV1w==
X-Received: by 2002:a17:902:ce89:b0:24e:229e:204e with SMTP id d9443c01a7336-2516da05c43mr113562335ad.16.1757350196566;
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24cb28c3147sm130460655ad.73.2025.09.08.09.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 09:49:56 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
References: <20250908015139.1301437-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-current] wifi: ath12k: fix WMI TLV header
 misalignment
Message-Id: <175735019587.347840.16470768919118721674.b4-ty@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 09:49:55 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: 72US_xiHxC8rwC093UuJQxwy2C2ZNQjP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDAzNCBTYWx0ZWRfX3SnAgHHPmkiQ
 TJI92ut3UfhPYTqwiPsLkdrkgThYSi1IGDLFSflwaGAsH46DMAi5qI13Rosf0Lr33AIvFFEje5D
 FdnGUw+f/x0kHCRj/Lqge6QS/cPznKZtl8OSM1sOwZqBgtfy458qQuTa9CtasvC3F8OULwegtSn
 J8GE4nqQ1zWznm/bCIjbnkweeHnA8xjDK3SQiEceTGBOmtyYip7w3FkAGuMi8U1Dgz9rJuk+B8N
 MO6NljaN0UJoAp2QmpucZT9r8Ja+uCji18SbF74v9c+I0uRsEeLNfIuMfk5prMYRSYf3djd4xUX
 +LUxKmkbaFWspa0N/12biuyuD6gCjaziXw89ogGB5b8NkI28FOZLbX/64Iu3Fgumm8F/rdA3GHp
 IoIAPz9b
X-Authority-Analysis: v=2.4 cv=YOCfyQGx c=1 sm=1 tr=0 ts=68bf0936 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=FHtBw0_P-ZgSNNpYaWgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: 72US_xiHxC8rwC093UuJQxwy2C2ZNQjP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509080034


On Mon, 08 Sep 2025 09:51:39 +0800, Miaoqing Pan wrote:
> When buf_len is not 4-byte aligned in ath12k_wmi_mgmt_send(), the
> firmware asserts and triggers a recovery. The following error
> messages are observed:
> 
> ath12k_pci 0004:01:00.0: failed to submit WMI_MGMT_TX_SEND_CMDID cmd
> ath12k_pci 0004:01:00.0: failed to send mgmt frame: -108
> ath12k_pci 0004:01:00.0: failed to tx mgmt frame, vdev_id 0 :-108
> ath12k_pci 0004:01:00.0: waiting recovery start...
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix WMI TLV header misalignment
      commit: 82e2be57d544ff9ad4696c85600827b39be8ce9e

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


