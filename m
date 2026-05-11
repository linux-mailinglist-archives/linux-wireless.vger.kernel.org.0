Return-Path: <linux-wireless+bounces-36192-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLBFLnlhAWoiXQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36192-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:56:25 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20796507EBE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6951330097C2
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DFB3630BC;
	Mon, 11 May 2026 04:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddc06HoT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K6IWk6k4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B763D36309D
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778475382; cv=none; b=UU9r5owfqsTB4HLZEnBkYkDGAZJmVwdvE0ZUATpi3Aet4x8YNDHklxcRXyt+mhUNIEBdgl23nqBEiannLJsBxJbSnj1cKiKAzOxTStU3DFIPUgcv+cJ4KuXk0pzxzY6j+psuBTetPICa59z4GHDzMXhOEzFBsDqNG+EilR3cxBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778475382; c=relaxed/simple;
	bh=386DGmWnViYwwh1a4OaANbZRlvABlVElAWhPcjKF5GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VsCkhBHupJvBMZyYEZuURdJjIcF4j39O9G/Y5Ub/Bd9PgrjsNOr43vHRpHDrJjjkuWii9Wo7ub/2HMOxKdMrjWlttwB748npQ6ziW5sKaC9J10UyrhERePvl4QwE0jvw44awSGfv+YMF0fZXHr/ZOXt+B38kgAddfNIG6oIgOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddc06HoT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K6IWk6k4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B4G6gW017378
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+EhcPMqV8LfsmYPtNXO5uC1iRN/cyenwSX0ewW/WPQ0=; b=ddc06HoTu38UgR50
	E5pU3plbkWYW3rW3DJ6n5kr/wqUcoe73wAbBA1BnR3Y9RYoLnlzWUpW84KbSdfu8
	Ctl53XuXnG81MEln/K7AouTFb0sO3AJYQ5lu3PXJnmhRVUdGDsOB/rD2gR8elQun
	LFrSLpm1RP3aZQUfSOldEuh4R0nB7u8O1BWhLufiXRKCevQkasrPTeuiMLim6LXF
	YcyRoJQfIKf9dewoQxwtoeVDSDSyM5DoreMCfvTGJ6ibbKmoaoOoC+d90Oj3ybMi
	L+9ffzyDXWe+yp3RPBa/PsNZf/p0o9/sN/ziB/OrYdQbQULhW9wxKSvIJq+f1Qjg
	TkesSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xfr2vh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:56:19 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ba5f794825so32691075ad.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778475378; x=1779080178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+EhcPMqV8LfsmYPtNXO5uC1iRN/cyenwSX0ewW/WPQ0=;
        b=K6IWk6k4ps8To8n/G19fYU55JjiUMA5FgshxO/mSMTDN93krToSbbXP5qrCCuXa0LK
         oK7kff/4daEOL5PgRmpVn8IOz+3HDoK0gLAbUXFjcYwEAq03wAyOqiPP+KGmWIO1hqJb
         TlAN11wqLFnJ6ghEvkhnAK8UyEissolPyHsENNrVSQoyfbx2QTQqYSTTCeK6mBCrnpyr
         yt8bUoBj7pUyEOOS/u0e0dmRDT+jpFudq9kACzAb3O/762+Lirx12pegl+my7gYwMHNC
         QOqfnW3yPezgVO/NlZpSfpt/yZMe50Q23A3FU+C7xeXZlPzSF9ad6uSNSUi0IuSPnMSO
         ASjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778475378; x=1779080178;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+EhcPMqV8LfsmYPtNXO5uC1iRN/cyenwSX0ewW/WPQ0=;
        b=XVuLciNXL13S/0FTafhEaJyd6vcDUlcsgWE5Dvk5Alvpsdv1n7l48SizZQWJNgE01w
         jIVwh9Ib92r6OunxihehT/yLDizrdK3buK0H6gkvMLBWawUkhG4dl/PW1ZQqEZcxbmq+
         QTB170VYaLWAFgf9vqOadQMwA99M5mHAOQzIGoJjw9/N8dvkWZ1htqCWrMPYzUCbeC1b
         aMaobpzqZTzsDLbNK1zR2jHR7Ict25c6HxK7ISJTlXXf9/gd/JuAylVZTykoduYPJcl+
         nZvKJ4y40erf/vcI+XBwPLVizS4v1CFbtSq/qRb0sDL/q3V0IMu4Ki+3qiOqEhYy86sk
         qDCw==
X-Gm-Message-State: AOJu0Yx6Ac0QsN2dXfAtzIhu4QHguo3uaezKm+Bv9d6CgC0c2weIm8L5
	yCjJfR3NHe3uHKlubOnnp/SG0G3md/LXoxHVHB+WtSv6vlS28CsO49sso8G5po3aMDPQKtGceA6
	QWE4/dj0Y9LHfVILtX2mlk3/6qCJ/fcoeIk3+lwB9kCW/SHVM+x33VkZDT411gDJXNjYBmg==
X-Gm-Gg: Acq92OEbbkQVOhVjTzQtyZKxzrrTiI99yNHoBvUtYHAE5rHn3TBXjTboL5Qrv6Lf8sY
	NN2UjVa6wVURKhW8fF6gD4P/uXGoaH9JsZV1qpgvDvGsq3RUH3D9KJawNmIubTBNRZhm9MjMYa8
	zOr2lBy+OvK3TONetrI3WXko00GIz3aTmWv7hwRAjDs7FR3tbbQ0+UpaX32vUqiNmMXxgTNynW3
	kEZKiVWVV0g/sb8YSfRcCqt3YHUT8Fajcksv+iaIsBHOU+6w8TNc/ZxEOzYJufhVzWyuyzOBKj3
	UXi1pGWJbrlx67iWVkt2jZJMWX0B0PLnOq9uqLzjkjfUi3A2/owz1u7iuUpI5pyP5YmJrElIMQp
	2swc8Ul4NjeYxwpL56q9hum3Pjhk3q97796JKbraUbPwbcLGo6m3kSbkNH67dPUeRH8UbwHW9cU
	IbwRFz7tXHSt/H3B2407mVJQji8W9yfA==
X-Received: by 2002:a17:902:e750:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2bc7a9ba9c0mr83512505ad.14.1778475378480;
        Sun, 10 May 2026 21:56:18 -0700 (PDT)
X-Received: by 2002:a17:902:e750:b0:2b2:5258:a23d with SMTP id d9443c01a7336-2bc7a9ba9c0mr83512175ad.14.1778475378016;
        Sun, 10 May 2026 21:56:18 -0700 (PDT)
Received: from [10.133.33.243] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1d27109sm88991895ad.1.2026.05.10.21.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 May 2026 21:56:17 -0700 (PDT)
Message-ID: <2cdeba00-9e20-4cef-b84e-b4de4225fa12@oss.qualcomm.com>
Date: Mon, 11 May 2026 12:56:14 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] fix leaks in some WMI error path
To: Nicolas Escande <nico.escande@gmail.com>, ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260506134240.2284016-1-nico.escande@gmail.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260506134240.2284016-1-nico.escande@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TqXWQjXh c=1 sm=1 tr=0 ts=6a016173 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6dxGyyh_nZznhl1tEkMA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: OwaLyBMJxEZ5lT9u1UARTTyeaecUgSta
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA1MSBTYWx0ZWRfX0QsWLDAw8a3w
 qIXGzCLBTaTm/u2OFC4pXhcGS9U1mmtx1hKB1iP6nuMDsx4ydoSJ39VzQnj78sQrqZX/gwX2t/R
 KwFdpxVGouruREz0qcpE3uMgJf2HbzOmdsRtNIWIRY9P+2mYPVd/Z3b2GzXtqMCJVGwi0jDNFDq
 S0g6fDEgCxHfsYxfnupL/+YcUAh5i03aY5FOfYkdLvIxeNT+Ef996/GH3jaPQdUhJdZNoYBQ+LS
 GkM00u4xmIBWSnfj/GNR1fGJMizew2U5FaFgRB0p8suyg3N5wxAu9IqVIFBZ7IsicfkVniTckTc
 xX7O/wZc4+E95r8lqavnoMmVMTgeZxEWkZKIHOoVzujI6gF8J8fmbaQQw0OWrBB8GMGpTwWB2mS
 y6SeR+IQmYqpthox+e2a7vD8hLX0alVLeqIiIleQkfLvL1LDWOkxsgzOX8gO+KSkRhaSkQlVrUJ
 w6AwBfOTL4I10xJAcMg==
X-Proofpoint-ORIG-GUID: OwaLyBMJxEZ5lT9u1UARTTyeaecUgSta
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110051
X-Rspamd-Queue-Id: 20796507EBE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36192-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 5/6/2026 9:42 PM, Nicolas Escande wrote:
> So this is similar work to what has been posted here [0] for ath12k.
> 
> When we use the pattern 'return ath11k_wmi_cmd_send(...)' without
> explicitly checking the return value we fail to free the allocated skb.
> 
> This has been split into 2 patches per Jeff's guidance to hopefully
> ease the backporting process.
> 
> [0] https://lore.kernel.org/linux-wireless/20260422163258.3013872-1-nico.escande@gmail.com/
> 
> ---
> Changes from v1:
>   - Added patch to also fix ath11k_tm_cmd_wmi_ftm() as per Rameshkumar's remark
> 
> Nicolas Escande (3):
>   wifi: ath11k: fix leak in error path of some WOW related WMI commands
>   wifi: ath11k: fix error path leaks in some WMI calls
>   wifi: ath11k: fix error path leak in ath11k_tm_cmd_wmi_ftm()
> 
>  drivers/net/wireless/ath/ath11k/testmode.c |   1 +
>  drivers/net/wireless/ath/ath11k/wmi.c      | 131 ++++++++++++++++++---
>  2 files changed, 113 insertions(+), 19 deletions(-)
> 

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


