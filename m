Return-Path: <linux-wireless+bounces-18223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A65A232E4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 18:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77DE8164CE0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BFA1EE7D6;
	Thu, 30 Jan 2025 17:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mDT43JF1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0E61EF0AB
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738258225; cv=none; b=pgNSBjn5NwrrukYrTxCvXg1yB/JZ6GFjh8NvypY+6UgSzgWJ5jG3bfMkIPgp2XjKUDMuJOwlAuEb8opL0I/O90mC8+m1N60QtV+TNaMB8xhXBghFwZLuSrNKp3R6krqi8f9GZTy9CdlTchcZ+AKNlXtCccLlaSiTsJ1ktbxlBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738258225; c=relaxed/simple;
	bh=D6Fa1/5aBiWk2HfzzQZzJAz5jF/zmzA7utLWq1npJTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM0xggq4k98OeUpEdRAAj+mCPFpVhX8F9D3SrymagPlvTfkFfUmTrd8wiuPD2z2HvT776h1fbWrkK8BONbwLw8A1GwBFCJIOqzrX7rxiLZwXheW7WuTMGbx9kb0X1IkBmIkl09+4TbwlvZXMaYFmo410pf19zPeyYyjCpn3thzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mDT43JF1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UE3VgU031760
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:30:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	D6Fa1/5aBiWk2HfzzQZzJAz5jF/zmzA7utLWq1npJTA=; b=mDT43JF1KuiNtVPS
	yZd+VRxf/prCPKevFe/6ZIN8RIsCBy1/T1sRZN1xB3WrO8ixzPVPmVJUJ2H0KQ3w
	hdVou80bUiNhIcdQCIzLKkv+ggq7ctI9NPfiknLfzJIPtoSaJjIKkCzR+lrqcMoH
	02V/14TmnOQ965ABDguQUcrO4GrE8A1KuD7n0ix1QcLKimQcbr5HpSyos1ZwLZ0M
	6OTXvKE7dWPixle0cExSaJuru6iNdzZOZZQZbUQmuG6D6tBZoWESXBbydikZAK+7
	MEdir5mwSaMYgMPBEing/GFijmlBYOwfC6ypuvCzWzPzz+FRNgVi6MQ9CuJ0CMQj
	CWp+XQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44gauurh93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 17:30:23 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2163a2a1ec2so35843225ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 Jan 2025 09:30:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738258222; x=1738863022;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D6Fa1/5aBiWk2HfzzQZzJAz5jF/zmzA7utLWq1npJTA=;
        b=GLeZhtIEvyk0aaoJiXfTrHVfQ8Fmf5MtFeoFlrg8l1asxWLrBwq+kBY9jIRzZZYpHq
         MhA/ek4ICCC7ST/ANOP4VL70GmAD5s1mbwYTwdQebI2Jg1vcD9a7DV1EqxcIsBz2pFbc
         vhrRM2mi4Vhz5x4Vu6PGBAKxSuCHMLXAY7hv4h5Wfuqn7IEpzaNufP43iOXONMpLUyq4
         60bRdnYkOI8cBhoJRd5SprKHLamverRIE69/rKqnBo+jKq9jFTW/VOv4bvcXEgBbgc51
         Y+4eZyS5wkCAixMh8BxIg7FknBTWJUaTACTTnvUTpATkEjGuwY44r231fNkPwIu5JiR0
         2y9Q==
X-Gm-Message-State: AOJu0YyKmQI3V7h7OYIZje1VRfjToqPCssaCdOvQEdHrL9onjWkEURue
	DDu7L6AFeBv2q6A/68iLAUXvz8TnVxPwlLi2hwkphBHLGwsIDMsBOdrNy4DISc1rnJs04P+qO1R
	XkDl1bQnnJWphI8RhnJm9OlgilcckOjPgPR1vEdJ25Da2lAz4OpflUl/mxbTT4vT3hg==
X-Gm-Gg: ASbGncuarZNefDEM7525pr5VH2sJU2KidzFfM/nN6qY+TlVOAmOvvQRqCUOTCnL/NUE
	bkolGLrVq6Nwv7wl5c44NwMvmrkRBETYtq3uQsRtocGYe9DnIVXec8lMIPWEm41++yWu1vZJeg9
	1qf8hYtfpzGr3P7vGE9JFG8iFLIc39X8fygyIm0yPzXi9ranq3NJyoZ2yBKVBb7+TldxiIzJmWz
	Vf8P+eyojmy2Do9v19tozcoJgbtC39MjgCpmkUhqtA0atJNIdtmuwy7Kecj8cUkb62o6+mmW0DM
	U6uZA4ZVh9zH0nh+WhuU5pOslayhNmddpDCjsADOCu9D1bQjm41SL91gSh+FGyzKPK/dZZgSag=
	=
X-Received: by 2002:a17:902:d48b:b0:215:385e:921c with SMTP id d9443c01a7336-21dd7e39d0emr115615675ad.51.1738258222153;
        Thu, 30 Jan 2025 09:30:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELaiH32awt6QGzr63yRUAiA8B5sIZqc9gY7P8Bsp7pqcQV/C7UcdET9yb1E1jIjNmL8+e4kQ==
X-Received: by 2002:a17:902:d48b:b0:215:385e:921c with SMTP id d9443c01a7336-21dd7e39d0emr115615015ad.51.1738258221437;
        Thu, 30 Jan 2025 09:30:21 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de330305asm16366485ad.186.2025.01.30.09.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2025 09:30:21 -0800 (PST)
Message-ID: <bdfc31fa-bf09-4540-8a72-139c46cbc353@oss.qualcomm.com>
Date: Thu, 30 Jan 2025 09:30:20 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: ath12k: fix ath12k_hal_tx_cmd_ext_desc_setup()
 info1 override
To: Nicolas Escande <nico.escande@gmail.com>, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20250127071306.1454699-1-nico.escande@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20250127071306.1454699-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qZ1Pk5LIpSn9YhJ9HHez4FQyOeKFtAgb
X-Proofpoint-ORIG-GUID: qZ1Pk5LIpSn9YhJ9HHez4FQyOeKFtAgb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_08,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=874 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300132

On 1/26/2025 11:13 PM, Nicolas Escande wrote:
> Since inception there is an obvious typo laying around in
> ath12k_hal_tx_cmd_ext_desc_setup(). Instead of intitializing + adding

WARNING:TYPO_SPELLING: 'intitializing' may be misspelled - perhaps 'initializing'?

I'll fix in the 'pending' branch


