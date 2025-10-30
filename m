Return-Path: <linux-wireless+bounces-28422-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F801C227CC
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 22:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC5184F293F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Oct 2025 21:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FC633A035;
	Thu, 30 Oct 2025 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L0gi37Wu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VKnG6liX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB9433A01A
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761861470; cv=none; b=svhUHKdfHw5/S6r+JQgNoIr6vI85bj+I4wY2tA5sLFUft/87Gmkz8pVz9rbe13ga5avAo/7TqHw89jJUEhkikY4FPRb4J+WQpX+8fxvDwcu5Qx+xRMlZKpA9a0TmftETVOrdsTJIo/Q82GZuFugHE6eK0akQ7WUDX1K9qEwQ0yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761861470; c=relaxed/simple;
	bh=SmO8WphVJ7qdIcobB+LxFCdmC6Tw/3vwYrEm2jVbpYA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k5RB9/JUoERZNgfvF+J8N7YS+rBLDk0uFAPrBOir3Y7XBQ78gHQeXoWRGYzPiXurereQZMJewBUWLaUTprhzVayDknKNROaKj0FezeWOkzfciVq9aHwoe7MfPpnrfCfVcsGi/zG9oVvXU+/u7Cwsh4Fy7nhvj0RoLs+lrRdqjbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L0gi37Wu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VKnG6liX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UCrrl42623261
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=; b=L0gi37WuTWX/M0DS
	WKeZTDhKeqPTxyhbCh1kKdLj3LUtTKvV85X3Aeclk7kdBFDfxD4wP6wTWACykjxQ
	Lzmuh1d68uhI0eCTGiqkLMz/7hg4WxFW/xObxjHn1dinfhjQe/sVGR/OUCtqgWFH
	xHmri/ehfr3SbJODpCE7k13yPfMB27c8HUchJO/s+hKjkrDy36Dxz3XySJPGL3Wp
	YFPR0av6Cd1SJF1cwIB6oYztZQ015lJHJFA5nmznPdr60XYFpvwn2+LNltrHHh1T
	FO8/TLqFRSW0c1kkedY5cPR6U7cU/M1HLDUYRDpHeV4Aig6b9bH5ZQNdNiefdCR4
	siXPYg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a41fxjsun-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 21:57:45 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3409148acc0so8765a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Oct 2025 14:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761861465; x=1762466265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=;
        b=VKnG6liXR/DHrt24Aqa8S9NdSROWZtgcvIBZEbP13l3IoElYxh481qrSn+vMJeisTu
         +rF0gvIeElXv7C88EdERkPfoXlgYi6Dd8NI4FJabxD99vyZ9ELEU1iT6XyuRQIaERaGp
         wEKN/aTL9dJjJYqIPR5lz7QwO8/4KOEWl/gD/qQLKzAiPF6vKiSfh1o8lrdPkJbI40HK
         56Ri7ehanH1/fPi0c9JKt5HZH72f71J7guWHSjDSLP4QQsHv3NMEFiKabT3KPUPBpQby
         UTDqJhU3ZQUV0pBo0MHBFmbp43sOIYD/QHU5bse6D0SSbyiJSM+i3b/oXOF1PgzJzmac
         glOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761861465; x=1762466265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0YbvCREchJI8qwKRV6FazI6CbTuSXVx8wiILVgQiUY=;
        b=wiNoMQvaAvVig+Rdc8p6zfz29UITaPEGCz0ouqBdEcs5PC2SlOwuzXU1Nyq3QRdinp
         ifj34II//RteTnY1i/yOAoaeIT3asJjqRe/+XVsN94MCZR40HKostfR3i1AuHf7JdQZD
         f3IdHYM04mVOk/m1ILyAWhEZaUIMwRL29H2eHkg672PK6pyoEOalT4jmvfEOhBb+/GTf
         Szuyebc+9Fs1d5Anic1OUxNXOandbKbBc3CGIqbYGqtZKVe687rMDGMhrc86F5ELfrmD
         CrFD3U2hcGvio7R19Fin1btFp4xeBZLyLjaALAdCMASce4BYH8ejS18FttQwcnIO54CT
         qzjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzD9GsjH3ii0vT/J6iaVgszmgNRM3XCXzex78gG2DOoqZsMe73W5BVb1hnhUZX7+/Yz15PxmRyDwtwfUtPJg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzWC9VnmmKtZdXNLh3vmaMm4zZDnEUiHV/vLSeDUCoaS7g05EDJ
	fFe6ZazZ1tw61qTYGpBjlL+Jhu0xtHqUMzZqZZ/epfmHY3rXMb5jJeKBKz2rte0902061HntuMH
	b9ozKZdVMccadM3uTDejgH2FZpJ5tBiHFzq3pXui06aQsIb6WLTHLKriX+Xv4XYcBgPCVoIk0Wu
	oaYw==
X-Gm-Gg: ASbGnctbEFQy4C9LrJtbsQSRXyVGc8TZy06duFl4falmQmvxfC6BeVb3y/Gz4J9r0MH
	LnZgK5+0w3ArhGUh+KmHEKBiR1i0NBU9s/IifCjeq0Jjv6lW7OU7dI1ddqOLMx4imbM6+K/r34K
	p5HUHQ43WsYxn1o2hBDMISua/OQ9D1lxojBsIVB7wONbrbPiegdJS09yaCdauZ4A9NTzzAu+jVd
	9V7WIk45QRW0Phqfsl4HOyxILUjasM92KRxyCSoQNzHeh0C3CEZpYDWcn4JO1fqSKU/IhX8vUfs
	IhdTRxnAp76d3ZBj6cH3+FfTGj+XbFY7/ksWfniX2bBEi7o9Jf6mVnB6k7eZEnqOIsaw4gB6W/e
	swCJoIU3kE9Zq+doW0SsqO60N+z13gZMPDMc=
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id d9443c01a7336-2951a4976f9mr17416255ad.23.1761861464673;
        Thu, 30 Oct 2025 14:57:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3QS9ZHlD/2JfJsKFJfl78n9pTNSfLsEEv+V2BKfr8XOEJAWn3kAqkmxy7fqEgwCK0M3sJPA==
X-Received: by 2002:a17:903:187:b0:295:1277:7926 with SMTP id d9443c01a7336-2951a4976f9mr17415995ad.23.1761861464081;
        Thu, 30 Oct 2025 14:57:44 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm201868405ad.6.2025.10.30.14.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:57:43 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
Subject: Re: [PATCH 0/2] wifi: ath10k: clean up structure initialization
Message-Id: <176186146337.3489476.10061776463232373681.b4-ty@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 14:57:43 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: YlLefDnJLmP1ABpKDFx68ljA5I2Kadk6
X-Authority-Analysis: v=2.4 cv=UJrQ3Sfy c=1 sm=1 tr=0 ts=6903df59 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=cMOJL1K5Z7ST7ju7w8YA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: YlLefDnJLmP1ABpKDFx68ljA5I2Kadk6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE4NiBTYWx0ZWRfX9CHinNUNj9jx
 72kjcIkmDjnQkMCzgTa2oyD/BiQw2+3IziU3qOaeZHS8kjHdn8uO4Fa0Es9EBALuUSwoEpX5q89
 GejvZylDQoMM6xZZGuLJKtkyi37mnahPYaUeFc9vzyBEMESwqIVAZdZiyL1B7yq2t+MPIHLAnE0
 /6zTfgy95V6/6j6LWvKBch2SORCN/NrxrcrBINldInRs0QepfLtY8EOgUTHQMNxOJ6GPi5zZeBr
 0pMMAk1zhdSQw7DZBsrjO9rmJ2UsPEd7bSjgnzxeIJMry2jDdtIPGaYO4y541pbzV5hdDZsfpx9
 xoBqEvGhdsbix+FIQmM3TX/+0sYxuZeLGLkNu8DJgH/rLUU+08BuwDc75qeNFmabkPw12c++0+4
 3DvmIpFrEXC/P5Ew3JbCbI4LbucUUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300186


On Thu, 30 Oct 2025 21:00:21 +0800, Zhongqiu Han wrote:
> This patchset simplifies structure initialization in ath10k by replacing
> explicit memset() calls with zero initializers (`= {}`) for local
> variables.
> 
> Patch 1 updates the initialization of `pm_qos_request` in
> ath10k_download_fw().
> 
> [...]

Applied, thanks!

[1/2] wifi: ath10k: use = {} to initialize pm_qos_request instead of memset
      commit: 877f9c22fdf424c657de757bfe8543cf77461324
[2/2] wifi: ath10k: use = {} to initialize bmi_target_info instead of memset
      commit: 059ca8fd692b67a77fb89e9d4e8f57cf08e32b08

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


