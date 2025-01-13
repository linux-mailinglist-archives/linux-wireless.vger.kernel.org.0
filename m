Return-Path: <linux-wireless+bounces-17444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955F9A0C15A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 20:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A84B6165985
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jan 2025 19:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2061C7B62;
	Mon, 13 Jan 2025 19:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GlvDxaH0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05811B21BC
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796355; cv=none; b=K+2TNi9Fzio7o8Kw333trCn81JqBUzVJK5dAIRy6ttd1PgvDrv6ltqRTrlknQ4OyXyongFKrS+oVJ2B1sCGJqUYOF+e9/mzqW/HI+adEJkmtypUfT6r1u23JT5MTGCCNIz7nXNLyopvujZXfn6CB83TgYe8hnPMpABBTR888aMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796355; c=relaxed/simple;
	bh=LStohHgNqiB9a0jWMdSVDJvUGVGBBdfj7CNP5EUqMuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U23Kyrj5Ck5uam4pL2lpx7yzVFFdDTETYP580ZnrIsLSqVpGmGuuNqSN68BcknUB9W0dtezNv3YmGHuKwMhqxYd/HdMQpyd5Gs7pYVsgIZbSS/znvmXfEoxg3lApNzGSn3Xj9mzJvq/Z+1lc0Scdh58RRYJLDUNX1of0YeojTdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GlvDxaH0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50DErcGb021692
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:25:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Lz34Xw3X4pr4DZA43rFUVWHHhjQk9s60FAWJ/bqHi0A=; b=GlvDxaH0g+9AZ3TJ
	xg+L3dX/5VpW2802mQ0uNVWgpIKQcVoZv1/cBCx6L/YPVGk52yiia6ciVKEkqMkt
	KoivWKPACrP2x354SCrbAUd6RTFzH00N5t87yNk+/FmP4as7MEEbMKElpaKCc2CQ
	sxMrx3IsOeCmT4pLSpPGkxS3hNklakxecnA+MWHkAyM3ZDMwlNn65bdHruE8DXuD
	YXviuBp7R5U62Bf2jNRw36IRn2cbL7gj4SLKOj7rJxIwUrzy+Lr9aWRJ2ecZspbk
	rJNeW1s116yPvHj7eajg1Jgn7QYAVE2DYIFjdKMiGm/WZ1nkcGEAi+R5a4wLWiaF
	rtttMg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44550agp22-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 19:25:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-216405eea1fso85669835ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jan 2025 11:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736796351; x=1737401151;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz34Xw3X4pr4DZA43rFUVWHHhjQk9s60FAWJ/bqHi0A=;
        b=WWg+wnh6GF9qNnfH4tjOP9HBart9ZE73z3h+GMP5j654Vf2dj/ZdMlar3tI3v/4T7M
         yYyjCG71g+mksXJxzbgyrrZm2VsIpa+T8gRRzmlrCXYmYX3ufwdnJMusxW59GttjFZK6
         cxqyzQwgKbqxp6EfsQrMx3uGe/01BILk/Jzd++uk/iDg5nhaOC5wgyE3HJ4KasOdjIJX
         35BpxJDVRRDX/LfNCscWj4gUeQs87vR+Yz1ml7ErObvrfjkr1V5oJ8jyJz/Jta1n/fVQ
         5aUWrkgWMInShuKaqLjUJTJTMnVsWcWb30tm0CiOjo8pT0OJoN2Fq9hlA8nw1a8O7szG
         WBpg==
X-Forwarded-Encrypted: i=1; AJvYcCXYko4KE1W3bdka/tkmUCwTXLPHQHcCA8jdSNSIU/6B6PEbssdYZsvH1Mbi9+AakTnf3Ov3pAglnpmaM1A0cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTskI7EV6Uixv0idKEGS+fW77z6xR2yDQ38dR/bUM1K4CSD7lA
	MRmGuY57JRA/+4VqV2Mr9cGjBD/PKEiSopAxu+NWflGhoS2xsV6EOQrVSxRk0qUVCyq3MNBGvai
	fKL5gnKywHBPyNWyTIC5P0ZVgWqHxYo+HR95vUhbt+tkJWP8YvkEixu0fg1b/tUrcBbJQSJEY3Q
	==
X-Gm-Gg: ASbGnctd7vgKTbmWdywFK2U12vN3Z5yjY+BYcU2SYnh+nwvEcC3OUTQfMktqimhjJBG
	yFPhtrQ+539kVwaJ1ao3FFsUAqiBryC1Bh/gXw6LpD9/KR7yfJl4J++9GqV1azM3u0FkX3YUIGj
	mv2zKUIimJFsSjlljPgjeWUidMewoLpTP7x+ZrxWoUVGOSn4JFP7eZM9nbkgZlgcECH4+9pJ7/Z
	nO95TRUjNQOXGu+E1vkmzhjJAa34wpHmM++sXOul2KCuZJtpN6HUUYOHNjtbC2I0emHIojsMDYk
	2Z7NOWcM+9LclGJ+zZ5nyYMot1xhKHpV17uPX5atCFfSqoL9hw==
X-Received: by 2002:a17:902:f54a:b0:216:2426:7668 with SMTP id d9443c01a7336-21a83f4bce1mr244800225ad.13.1736796350909;
        Mon, 13 Jan 2025 11:25:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLpebPF/QX+eZca/ElBLEy2ZhA5voD5qQJNkfygzbLSge2xYPad5A1qUYhWuTSY9XvssJUew==
X-Received: by 2002:a17:902:f54a:b0:216:2426:7668 with SMTP id d9443c01a7336-21a83f4bce1mr244799945ad.13.1736796350513;
        Mon, 13 Jan 2025 11:25:50 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254040sm56419705ad.232.2025.01.13.11.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 11:25:50 -0800 (PST)
Message-ID: <95825ece-cb16-4010-b189-092c39b6a7a5@oss.qualcomm.com>
Date: Mon, 13 Jan 2025 11:25:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] wifi: ath12k: reset MLO global memory during
 recovery
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Kalle Valo
 <kvalo@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
        Harshitha Prem <quic_hprem@quicinc.com>
Cc: Kalle Valo <quic_kvalo@quicinc.com>, linux-wireless@vger.kernel.org,
        ath12k@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250109-fix_reboot_issues_with_hw_grouping-v1-0-fb39ec03451e@quicinc.com>
 <20250109-fix_reboot_issues_with_hw_grouping-v1-10-fb39ec03451e@quicinc.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250109-fix_reboot_issues_with_hw_grouping-v1-10-fb39ec03451e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 1WeO09VaDS5lYF2UBOzFcd4vb-AaOxjD
X-Proofpoint-GUID: 1WeO09VaDS5lYF2UBOzFcd4vb-AaOxjD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 mlxlogscore=949 adultscore=0 impostorscore=0 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501130155

On 1/8/2025 8:25 PM, Aditya Kumar Singh wrote:
> When operating with multiple devices grouped together, the firmware stores
> data related to the state machine of each partner device in the MLO global
> memory region. If the firmware crashes, it updates the state to 'crashed'.
> During recovery, this memory is shared with the firmware again, and upon
> detecting the 'crashed' state, it reasserts. This leads to a loop of
> firmware asserts and it never recovers.
> 
> Hence to fix this issue,  once all devices in the group have been asserted
> and powered down, reset the MLO global memory region.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.3.1-00173-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>

Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>



