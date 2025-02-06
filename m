Return-Path: <linux-wireless+bounces-18550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C4AA29DD5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 01:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F56C18889CB
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Feb 2025 00:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5572905;
	Thu,  6 Feb 2025 00:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nlwf+sxL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8DB15199C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Feb 2025 00:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738801012; cv=none; b=LT242Iu/i3KcbdW65A2dsg87U3Wv0kojg/VC0X8jnw0/1fh/m9BWR2S6HwGz2ORtK6qbIvmywHTN1STnD6IBUPByJ3UfrGh1RX8ryBBz2F9gSJF8Vmz++W0zkfOCwPEUqxwviQoavN1NXlN5ngNvD0wA/RG05lt7x8V2egfHoV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738801012; c=relaxed/simple;
	bh=KMKb8gZ5UotN19+veRo4bdemHnpDIR0pU/PKk/9fRsM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CV4J52AqE9+biDC2iZwFhZN6uZPpKnJwBqywMpDITXDgB734Z/iVzlZsTQyeoF5SNP7OpGfdmHqBNa6pAjfNgmBGPgPiHcadNm15xxIxnTZNq4K4eR48/4oSRprXEEIIU/s6O3bhqMm+nggXfrVEL+YX8p9ojGs/aLO+SkW+XqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Nlwf+sxL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515FDkUv030466
	for <linux-wireless@vger.kernel.org>; Thu, 6 Feb 2025 00:16:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iTxg7nKuffcT4iD2zKX1r6AOCSGMFdncbWDtotDGgbg=; b=Nlwf+sxLd5iS47mm
	RcHJW35NF7mbdEHB5SEJSv3hepYDejIi1eFeoHH7UN5CMZpjyKKxzkikpgCnIXWM
	LIoiFxBaVr5KzxJ9+fclU2YES1tJxlabjjaoL78raIg75GmvB59Irnzaj2HmM0NF
	eXix7PPHHdVBPj+apG2qR9nKEoYhTIXbM8868VsXlhZpAUnFVs467h2WrZjKk0Ys
	F8+bx0yNLgwSsw4sbTZtyOt2G7yDhLvJ3Pz5HtvEX6jdR1ozic1RJBMcI/sQCnYM
	xjkDHaMc6tWDIIelPS8mF/+OTpjE6eHf/vdkiTLMrEtDA/6xgAH/b0yV7a0Yh9wF
	I/XQiw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44maep961f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 06 Feb 2025 00:16:49 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-21f02d17cd0so6393335ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 05 Feb 2025 16:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738801009; x=1739405809;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTxg7nKuffcT4iD2zKX1r6AOCSGMFdncbWDtotDGgbg=;
        b=GEt0QNbMC/wIMhQjhoPYTtKJW5V9dHdLUNgIgw1b8Vk4AcXNO7gydJPYXztfoNJBRM
         7fepYL1V7J70qUnb7lbFjlH6uvVdQ27MLFXWjODrCMlNFgUUnvgUe1/9KQt6ljARwEOW
         Cpnac6hQPOzj7NfTMxnaYHWbJ5CpUE+Wsgou9TcWdy9cmMqsyRR4+GoSdWm+mQVIGTMu
         KHXj/91dKqjkGVS3qB0Khoc8BssMyuXQOsVbEYMJ3YCipKRNM2xXs263bdo6TZ/qk54C
         2bwLTzxDcBCOfLRYjXWR33eMZqP8dumHnNytbIPZWfRWHGivmeBmD6HQ53hI2Pua/DO5
         KLPw==
X-Gm-Message-State: AOJu0YybHF7Hh/eQTL+CnHhN10RWfxvrnXwFwZjH7Z1B7Z3POXrFuTo6
	+2LlrKy4C7nCKgmiKY10VLT5wbwGfrZgG09pVVBG2vepcgslqa8GW7Sd3IZrKCCjDwIY0kM/M1Y
	hDgA8xzkNb7HSX5mK0iNcpDH4ESctPbxNx0BerYmFb0BaC3ZSnTPbN8FkFa51zXfKzw==
X-Gm-Gg: ASbGncvadZ8t8vOp+7xIxE4FZ1KNvjdRskMHXWrUVtPA/jm9UfxaUWZLo0Wt8e7BYLg
	8LcY567SgEAxxuvEqm4D8sGmwvjDYuFUWm0JOFNj+WckrZ67hGhdiRdnRiMJRC0hcWdkKe6X7wU
	T46ykZaiOHIa7qM8AMChGPaw79xn0WB1uzaMNWx9PZNZRgk/E9YamV4B4blZ4JUCDwP9On8vV3l
	6c4MJMoapWABLrL3wQDJ5Im6ICUXvwXHzfX/9kadsNXad0jfG3SinT/Wnset5s+FmOWJ1RLwK/F
	nP4acPJ0JKGmQjenLR/FbdSRwrV/2ps2KmShGajZ/Q==
X-Received: by 2002:a17:902:ce03:b0:21f:78f:c17a with SMTP id d9443c01a7336-21f17e4ce67mr81713425ad.20.1738801009022;
        Wed, 05 Feb 2025 16:16:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ/QvgK5grrKymF4ubh6+iClejBycX3N8Bto30t1untzbWq0H34PSSoTDqIHX96ZFYWY52sw==
X-Received: by 2002:a17:902:ce03:b0:21f:78f:c17a with SMTP id d9443c01a7336-21f17e4ce67mr81713055ad.20.1738801008595;
        Wed, 05 Feb 2025 16:16:48 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f0463e770sm39641685ad.165.2025.02.05.16.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 16:16:48 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org, Kang Yang <quic_kangyang@quicinc.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20250117061737.1921-1-quic_kangyang@quicinc.com>
References: <20250117061737.1921-1-quic_kangyang@quicinc.com>
Subject: Re: [PATCH v5 0/2] wifi: ath11k: fix data out of sync for channel
 list for reg update
Message-Id: <173880100793.1503921.12113647130337572024.b4-ty@oss.qualcomm.com>
Date: Wed, 05 Feb 2025 16:16:47 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: aBARq6ywAxmqnEN6JBCQgQbX-sGUUhhV
X-Proofpoint-ORIG-GUID: aBARq6ywAxmqnEN6JBCQgQbX-sGUUhhV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_08,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502060000


On Fri, 17 Jan 2025 14:17:35 +0800, Kang Yang wrote:
> Currently there are two threads to updating/fetch data of channel
> list, and there are no synchronization for the data, it leads data out
> of sync for channel list when doing reg update.
> 
> So change the call flow to make sure the fetch data running after the
> update data finished, then data of channel list become synchronization.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath11k: update channel list in reg notifier instead reg worker
      commit: 933ab187e679e6fbdeea1835ae39efcc59c022d2
[2/2] wifi: ath11k: update channel list in worker when wait flag is set
      commit: 02aae8e2f957adc1b15b6b8055316f8a154ac3f5

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


