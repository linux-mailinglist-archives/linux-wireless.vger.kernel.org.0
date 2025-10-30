Return-Path: <linux-wireless+bounces-28419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBBC0C227C0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:58:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B795E4F1060
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653BF336EEC;
	Thu, 30 Oct 2025 21:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qg3TmO2T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ShY7Pz15"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E902233556C
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861465; cv=none; b=sqsoD/c70J6KgC5ZJFwnvD8Zmwvy/ZLg4TFgu9RScgUXjy5lFpdMIcyO7XsyWufkkHfEIlpStMuZ1GAdLHjvLOKWdjCL3ZkyDCbsLm1ZtRMj4Mr3bIFqQNFe/IiNabKzkTlZr/K9T90dX2qBseTETsQxKHr97DoFm+euPZ/9o+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861465; c=relaxed/simple;
	bh=8kleHHmGmOk7/a8X0a2S6t8xWGwv0DCERRkUQEs4i9A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U9r720SBo4qCmSHvzW7NmK7qU841FLhg0L0LaUq93JMcIyJfk1mBcA0ONUXXcRtyOxKlOnynLH1KiTLO/eTGnravbMfVmWNnvcAmhLGiePFw/5aRQyE0kw6ZBzHS0jkz9WUpDirzaIeANOqfKoHjZpwYGCqViIpKINCOFmhxgNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Qg3TmO2T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ShY7Pz15; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UFFRcB086817
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YUdNvRosN1UkdRWaiq4PTrTJjx9avzZeFXnIlwSgEMU=; b=Qg3TmO2TV7FWDtUf
	16Bmo30wgPFmLrWdFt1M3WMivYPMrmdvTZ8pf3o6EXFiFfhxQE9Ndxh1bYLoYEgk
	QwagKRdPRc7WsmkM6j+2wYn7VC0A52uct3FjurkQTGwM32U6JE3lswY7jUMk33d6
	iXmqFCTUhaiSIJCUg35SEcVEI04Fa0uWwWmsMiZbhJIuDkxsgDYlGTMNq7Bbkeup
	I+WeuBcloyyu89ZHzqZl3ih0k9WS/iyBE7ZJVwg7MRVigmLKC7fLBedqtqaphPKY
	8E+Rl32JYWJGrfA47uN9Ylv1DDG2t2Y0hJ+xfkC2Ecw4C+SpH6gc0DBFB75N9/jy
	9LCBLQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4ag393vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c62320f16so13931015ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861462; x=1762466262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUdNvRosN1UkdRWaiq4PTrTJjx9avzZeFXnIlwSgEMU=;
        b=ShY7Pz15yfvce1ycxOnq6iQ2Q+coYjrQ6R6HFSzKJy6/VqjJsevK6gE3oybVxZQGWW
         QenqwclmhknDgAOoy5JFAwTeUKKhrrBFzNEwJLOufYuh2zoYSZcIWZZ3jU1nHTPTFVc1
         v3XPrjeL3QKpOmcnNdDCS5HjaAk9GsfLaaoQwT6aTHMBsD+6m/0Tg8oXcVCC9vMrVIAW
         R8nnddll2BaKZKLpz474oHHRg0Y4xzzHvGqVzXqLenrtSlcUJK7K0Cm6bDqK0ji+1jud
         GTxAEkWt9LIaH0OjsB46HqpqJV0OB/nR44SyH0OX5IKgenyN4d0PyP6PDLrifbztV0J3
         hqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861462; x=1762466262;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUdNvRosN1UkdRWaiq4PTrTJjx9avzZeFXnIlwSgEMU=;
        b=t2iER0QQiUSAroOTcg6CcOPcvpdlRNm//4nPjdVJjDXwxswQ+9jFyNxSqcv19eTgxp
         qx7ByDpGMgYEIMArC0KLLHlFcdBbBBFc2T70VXV8QDzASfJ2R7fHnnK68CA9zGNi9u7f
         ZAs1Rjz4XlIn4mlr4XAw58bkLxZz6APFH4tZFsODF8eIQc1v6/kjJ8x3nkAVpA0Gmk9B
         t1MVQT4eeMCasz40pHNc9ZneCRYsg0dfixMqnliovksjXLDPR+Ao4swIgdNk6N5F7US6
         tznbk23yGzVYzErmDBwb36Dw7RXT3vYTy2vy5Yv4y3HLjGd2VbNabo2PBwpXTJD7a3n4
         Ga4g==
X-Gm-Message-State: AOJu0Yz4Zl0cN7Dx5niN6guNOeQoapanG4ZLMB609J/kuVDP8ltyXOHh
	fUuqGd5mCee8eGU7kpyH6vbsknwe/HUeTJEHK/sEESAlouCqTp4n/WqJwY1e+gppM0AJkVLEt0X
	aZf1oDUEssi+XOQGsjrEneTx+rgT6dwjASEDaYN92mKmKdZb0Me88LYENjktHH5ppUZXngKgfRp
	ouyQ==
X-Gm-Gg: ASbGncsOa8ko8J20IijYtiR/7NzmJb+KwF+8XjcjPEou3CtRjMqqfKdhM95b7XLnMjD
	yULK3anqlHVGhyXIKvRRHgC4Bx6mZP05ZwXnefEkCA/x1ZFSEQvGuhyIS114zn4t2WuIC6Kp4Ce
	gPDX+50M5PS0wOEPwzYl7n8wzkXMP34BcPW2ThWuxpZsg4N03gk8Hqq6TbvpbtWf45DBiqYbLUq
	86pytcc32F0EcW15bGw++REA5vDyXI11oyRkdJA+WRXAf46RRHBceLe4yof9PFfT2Ee5LV0Ek6h
	zXiQoYoSNHiC8bnlguSPVBsKsJJW6otqPfhWo01veCkJAKaP0FU2DXi6DcC0v/+w/LOvMmBEt8F
	P4s45VIh0pt1dNvAtE52h7aawZxsdXndw80o=
X-Received: by 2002:a17:902:e414:b0:293:97f:208f with SMTP id d9443c01a7336-2951a4f6c89mr9818455ad.45.1761861462190;
        Thu, 30 Oct 2025 14:57:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2kZEJgbdubt9KJFcBXfENCGNLUQuQjIxSGUSn1+zhnUqkD6WbOql/ewdQJ8/XXjIIiZsj7A==
X-Received: by 2002:a17:902:e414:b0:293:97f:208f with SMTP id d9443c01a7336-2951a4f6c89mr9818345ad.45.1761861461717;
        Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:41 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        a-development <a-development@posteo.de>
In-Reply-To: <20251030-fix-hw-group-create-err-handling-v1-1-0659e4d15fb9@oss.qualcomm.com>
References: <20251030-fix-hw-group-create-err-handling-v1-1-0659e4d15fb9@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix error handling in creating
 hardware group
Message-Id: <176186146100.3489476.15112650202285878090.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:41 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfXyAcv06PxEyKJ
 6vjJsuwmbe8Qi2pvweQnlqLVkFJ7a2SPqFyTwHvDN90t03lZe/7FZ4sOLJASUnQCyaHe0dgh7Db
 XKbeBrgT7OaeKgRW0+24oDxqJgzq7bHT9oX0SoEYyA3D1XVnRFki2ZcXvuJD3O4hOgdGC7KPWtN
 vXfNtyvKkDUHwchdEIlHvDi1JBeWJv/k6oDGRfbMBPM1bIKOn02vOttSwtO634MQLs5wpRO3S9X
 iWcxeup9aD3Y2BZAowLu1YYnX2jRcGv1VV67Qc0o0Cn8w6rvF0YWQuNeLn1zu0G418Bdmb/YyHg
 S64oAHdbjSq4wGcoszIE0K07IRacM8SDng25cxmPyIEKsYyKa0UHl1SQJmfB7p0EyFVulgXVkvG
 T/MO0OLy8+tthWBaOpbrVlPmSUAj8w==
X-Authority-Analysis: v=2.4 cv=TrnrRTXh c=1 sm=1 tr=0 ts=6903df57 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=D4pEDFDytygc9mKA3-8A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: tXkKVkgphlvsYTcKqqdxyXNyY0l0Zv0x
X-Proofpoint-GUID: tXkKVkgphlvsYTcKqqdxyXNyY0l0Zv0x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300186


On Thu, 30 Oct 2025 10:08:43 +0800, Baochen Qiang wrote:
> In ath12k_core_init() when ath12k_core_hw_group_create() fails,
> ath12k_core_hw_group_destroy() is called where for each device below
> path would get executed
> 
> 	ath12k_core_soc_destroy()
> 		ath12k_qmi_deinit_service()
> 			qmi_handle_release()
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix error handling in creating hardware group
      commit: 088a099690e4c0d291db505013317ab5dd58b4d5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


