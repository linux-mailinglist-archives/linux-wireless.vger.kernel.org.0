Return-Path: <linux-wireless+bounces-21213-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E629A7EDB5
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 21:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B055A3A4A56
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Apr 2025 19:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884EC2153D1;
	Mon,  7 Apr 2025 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ciFGuBtj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBC721147C
	for <linux-wireless@vger.kernel.org>; Mon,  7 Apr 2025 19:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744054870; cv=none; b=rshIKftvFM5iW4gyG0ZgXJ3hWgCJ9FTWh0mCGXmdteTPgUUTh5+2dCCx5Ag/EH1gj5DMAH6T7YH40RgN+mkmPcO+Gi1MW5D2F6pYkzwKKfsOxariSrPzb61jCU6HaSqBfgTEij8Bqmud0fzIsmZR75y57g8d7t0Y8WUudcjiNDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744054870; c=relaxed/simple;
	bh=MkbSXAB5F7px5eilxXRYYWaFWvkDGNxLgdjCFZ2y2nc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QRrUUixDKfH9NSkJmISSpDP8+231NY19c3hRA2Y+xbQy+sKe+CqQa9wb1UmAI6x5gFSBHzFcJDVkLRWwK5kEUCsR67KGWpIO6gkTWH+UlgcpaM5QDfTPCyRQQp80y2x+TW+W5m+q/RXF8iifgFDjqz6/bzYJS2XWJjYatR3hU3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ciFGuBtj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 537Iev6t002203
	for <linux-wireless@vger.kernel.org>; Mon, 7 Apr 2025 19:41:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KscTYQy481PoZuE7Dp2EwtjkJkp0UdcKA2vsrikNWn0=; b=ciFGuBtjzEjnJlQZ
	PwAh98GDTEwJm/0grZ/7fnzsFdqlnGzXr/B/TMm3nD+Fp2Hz6MY2Rd0xmlCY/Kqf
	agD7OYeKbQgVrk669Xw83zBaFZ0OdQOLxAZ6t1TZ81EE9scoCm6hXOoJFEBoyqsW
	EKJ5tB/HXndYLABzXP2xXFbvwMNnd8R+ROtkHGya/OfyiNL8q9YxjVKTHN/STemr
	F+3jpAOOD2vHInnUaB5nhL94qjdwBL3NNDc5LquEs5sFuKDkY/vTNe515GtYbYm8
	F4NT3UG8Fl32BQEHT7kr3cXeSzoU6Jdjd5g2CRylfJGZdnGJg3djfDMHBjiq6jLv
	HttO5g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twtawcup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 19:41:08 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-224191d9228so57140155ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 07 Apr 2025 12:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744054867; x=1744659667;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KscTYQy481PoZuE7Dp2EwtjkJkp0UdcKA2vsrikNWn0=;
        b=NQk7KqSJ6GZaM0BsB1Ew5q+Hb79bXMhn9tutalUL/JJJSVRHPWGd0vurSvMi3m2kUS
         /drFJJNsBJ0dF/vVn/PdNELS+7FUZgOKfTqJhHMrNQmkRfB3nHCalxbb1dAoapRUvk6B
         hsKtUCKe9Uaqao0S28dNaaje99UKaaALR0/6KKHV1taL6NXD2thRogJr2pDL1qy9amZ6
         Pth8GequwK6ubtSi5MOTLgWu6hWeK5JMBGSf0k0u9mNPQ4Wu4xG4dzp2Di28HqPPF8go
         sbiA01IgMYLPpXc0Mvl1xXMf2xuvD3uuY7pj36VSxvd4BqTzz4HP6YBX8efJevXEX9D0
         P/Pw==
X-Gm-Message-State: AOJu0YxrjJqMECi+GXVcrkjS3G6hleZGwCxNqgzDUMRU+wkr1dw29wff
	jN/eHRgC5aGnUxyy2pw37Oh6dNE+hYzkXlFnVqGdCvJVLArvh3b47HInZA/lH1OBRVtpyEZdnxi
	Q5LP/qXDl0egCj2sQeclKKrM2cArpugWsyZt1f0gTR5qiUlVvW7+OMRKHhyl1r0E+V97LZJM9kQ
	==
X-Gm-Gg: ASbGncsjFPoF800oh5I86Lv5HtVb56c5TgA5jXRjQISqaR8f6/MC1JxkSX4LZ56D4Qk
	OS32Id8qSD7ZfyjcRJDrggFxA+QZ7wjlfEUDKZDKxSTYRAjhHVJWJXJJrZNExCW6ReX0J0Fp6sf
	iEQtwkMEEtIVpf1hllelVLs4/olDlgpVMB4m67QQFpp01Wk+qyp3+adf+ulbcRdpq+F5WtX4Eqv
	35WXRrqeNW3kZRUn6TTeLVgEklj4jterTSbLNZEsUEK8lBkEiuNdh0TjNzWYJYKfFutkAvYXfJT
	PMdfEO4Dc7fkeNZPfu09dtEJ+RRYDwM8Tm6A1mUGz47PSO4Phnq0
X-Received: by 2002:a17:902:ea06:b0:220:e655:d77 with SMTP id d9443c01a7336-22a8a8b80d0mr159882675ad.36.1744054867157;
        Mon, 07 Apr 2025 12:41:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmGHIXWQeBBp1gmPxy3r2HeeVJ9kG9fvZKoCvwdCeWI7S9RPL6SmBh4Nrj+lTZnGTwahoMYQ==
X-Received: by 2002:a17:902:ea06:b0:220:e655:d77 with SMTP id d9443c01a7336-22a8a8b80d0mr159882535ad.36.1744054866792;
        Mon, 07 Apr 2025 12:41:06 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2297866e6fdsm84822225ad.165.2025.04.07.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 12:41:06 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20250407-upto-v1-1-23ca65f2ccdf@oss.qualcomm.com>
References: <20250407-upto-v1-1-23ca65f2ccdf@oss.qualcomm.com>
Subject: Re: [PATCH] wifi: ath12k: Fix misspelling "upto" in dp.c
Message-Id: <174405486612.2865585.8066461311855235164.b4-ty@oss.qualcomm.com>
Date: Mon, 07 Apr 2025 12:41:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.0
X-Proofpoint-GUID: fIB6podS5Ek9KoOGvW9flwNKxMT_M5WP
X-Authority-Analysis: v=2.4 cv=LLlmQIW9 c=1 sm=1 tr=0 ts=67f42a54 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=EUspDBNiAAAA:8 a=iowja3EhBKiS3qvbEMEA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: fIB6podS5Ek9KoOGvW9flwNKxMT_M5WP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-07_05,2025-04-07_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=690 malwarescore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504070138


On Mon, 07 Apr 2025 11:28:26 -0700, Jeff Johnson wrote:
> ath12k-check is flagging:
> 
> drivers/net/wireless/ath/ath12k/dp.c:1656: 'upto' may be misspelled - perhaps 'up to'?
> 
> Replace "upto" with "up to" and split the comment line so that it
> doesn't exceed 80 columns.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix misspelling "upto" in dp.c
      commit: 68218fa0862aaa8fcc5f968663efc781eb4c91df

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


