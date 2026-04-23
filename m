Return-Path: <linux-wireless+bounces-35250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OuLIc9e6mksygIAu9opvQ
	(envelope-from <linux-wireless+bounces-35250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7759D455DE0
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 20:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABDDF3092C82
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Apr 2026 18:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CFE3AB284;
	Thu, 23 Apr 2026 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZI1iTMIF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlWVDBFL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070033AB274
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967266; cv=none; b=pODAKeeXTeobbJ5uOAc9khCZZxazNWSl1f1AxxcXeLFLyreDOBMdRQ1XMsIpsc4e2bh5YtxujPBGnYxHVOrhRi7k6f7TDkcKOX1MM9HF9qNDB2G8bo8BgKmIQQ7IANKZc9GgD1pTH8ppFQPS4nlF1b23DD1O3WiXGzD2JjWlsFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967266; c=relaxed/simple;
	bh=+JOes+x7cvfxfvpqnGSmuY6FZ+UQx4Y5GOdipyD8aWI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=U6qZtnr35eWeBBKERzqlQF4reeiXo3JOO9ScHFv1gjc/VT6nwyl9WIukAXXUs3uFYxbzv1LENSyPyIdH9Gl1OpFNUg2NFaRDR9XKshAe26KCmBAToz6J2wv6BD94uFwTOMJPLYglUjNInPLBRgAWtxf7vfyBaV3UsfNWL8Emc1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZI1iTMIF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlWVDBFL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NBxB4W010547
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=; b=ZI1iTMIFBVS7Mulr
	Zghrm51CWEAI8iqXz2kVEIz/mpxBfXbLdNPVHx05MOyM508eF0s7BjF3IMUn6Hea
	FpquPQ8eOV2Y7rP4C9uH1OBbDjcBLlHUAl22LeJXgmtt2QbXs/3YOdVkao9U9+Ee
	K2BCLWzwMVBFIK5EXTVgzp49Cg9/ad6TJRtCTs0EtX2J+SlZY7xHEeQ0pP8K2Dn6
	7iGEHE7lc7lu5GffeB7kcR+a8ADWbuLsQEATWogxhtT/mOLqJtt0GZgAQlgH9ae9
	JdlXZeghyQ//3kXDeu8LNo55T09cqL0nfod/93UBAu23E+J5Rql2vD7nymGdBcLp
	IWK7Tw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqk179en6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 18:01:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2c0ba59a830so10926548eec.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Apr 2026 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776967263; x=1777572063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=;
        b=DlWVDBFL441j8nMMRdF3scAvPOmE6MZnfgVRQp+4A9SLjxPM+tmksVTMdTfVPfnWea
         K3XCIiSENXBxyCHLGb+GX7jW7Rw6yCBVnLXGdDvS4bC54m5hAwl8R2dUnDfRrEZ5NGOj
         5Sj6KReq3VxtDDVYYIwB/JDf+qgq7xIWkna/Kxaw3SrPncWcyKqvQA58tyRmx6ynY7DO
         cNQkXlA4xAXRj6VLoRg3BssqkuvqzW3YlIAk3JoxT1E6ZOw7aKkqqtB53N9orc+xixu/
         eBZH/nKWJeiNKpXl3Wgt5So7HJfFZYxtBXUWCMJUOanpLCtXdYHUApd68y8u7ZYztOzb
         jXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776967263; x=1777572063;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H97jdc53rsSV9J1bHg93erHFl20K7pFWAZodpNuOJ0k=;
        b=BA3v4QjSA8byZ1RMBKYquM6AHKjpmCqIa6YvKOHwMwy1EQ3smfeYtWEKMQ8qwTt6a9
         Ollee+pB5BeYoOyGlipqNK8hNsNYep3Hwyda+fsnbQuJtqpxJ+iIpQzNQJEvHmIHq3Y2
         DdyqNTdyJwGyrfUBdURQ0s1gsYcwdz0WxlyFPSvanYSOCyT3PqazDA2l/slrFiAz4o5f
         k4zscN1aRdcVSEeEj49qMaC72w6TLfM7uQR8aGO6H3mdFJ42CLym551gyGGQwMU1UFrj
         sD7hTqZUrf7RMlULqAWe6VqbfRUd1nlgOtcHHh2aO4EJXoTArkZvP6SEg1aUOY7rEHAX
         Dtdg==
X-Forwarded-Encrypted: i=1; AFNElJ9v2kY1MyC1CoFx41+5gQpd2H/zs6iVa6rDlZOFjJXgZcZ9SFBZ6wLtxMHPUWJX0EH5wLPw6+ssinPBqN+ugw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy6SDtgEaYZfyZ7GbiWmb71Ui2OwgGOSAFgwhkDXG46s8XPBuJ
	6I2nQWPJEICCcYRYp5fUkp1P3ZxTWzCD8+bv3NoQ8awZzzMMYGbatau0kbNiJL1aW2zTw5SYO5V
	rFjNHkYKAspyzklq9Tw5eQSZXGxbZ09nRAb1s45TBE0XG54O9URGBa9UV4EPtp63d1l5dnA==
X-Gm-Gg: AeBDies6gefk9QR7HoW2KY6jhJX/EuXpLJYl9FDWCvZ5p0KjNK6QFq+Ji7rRpIkKbOz
	t27kOWYjCNDaN5kBgonJWIILZrBOSLIA97y1O+nxj4dqsM4mPKH2T7ghEYLhtji9Yl8sYSIdcVE
	YZ5YkPGX328XOKwnD1elAFqnOze0uSzQV1efNS5l5E36G2q1notc4s/uGspkJQTqky039WYEDod
	nvE3aBewrb0Sl7pToCO8aqQFzVoxvw317GFH7SUlq2AAzRQwyA9M6DC15Ijm25Rop8NswF8RzxZ
	EHzpzqlMNF3b2G/1bAuIRbLpknr2I4rgbG0TEi6WsndTuTdIVQv/01ZiL8Z18PcXYs6zcy+sMJ2
	+Fq6rA2xhsDyTC6wq0fKvGpb1YGLxIxKra955N1kI7EDVpFu9DKNd3Uk6XtnxI/0V61t8n46j2U
	X40etezmMHzLw=
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr14968512eec.25.1776967262645;
        Thu, 23 Apr 2026 11:01:02 -0700 (PDT)
X-Received: by 2002:a05:7300:7491:b0:2d6:4297:5fc7 with SMTP id 5a478bee46e88-2e4872fb657mr14968475eec.25.1776967261658;
        Thu, 23 Apr 2026 11:01:01 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm27867887eec.2.2026.04.23.11.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 11:01:00 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, ath12k@lists.infradead.org,
        Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        Kalle Valo <kvalo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Clark Williams <clrkwllms@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260422180814.1938317-1-asas1asas200@gmail.com>
References: <20260422180814.1938317-1-asas1asas200@gmail.com>
Subject: Re: [PATCH v3] wifi: ath12k: use lockdep_assert_in_rcu_read_lock()
 for RCU assertions
Message-Id: <177696726047.2493545.5792745669762197871.b4-ty@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 11:01:00 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: yOEhogWgL-KiU-woS226FmPsOEAsJpEB
X-Authority-Analysis: v=2.4 cv=R98z39RX c=1 sm=1 tr=0 ts=69ea5e5f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XjcZkKkVyDdEEfN8XZIA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDE3NSBTYWx0ZWRfXyaC5ZWbJ1kD7
 tNHG+3q1houUAsGV8glKChpQOy6CuDGe0s+ZFy/+lgE4TLXaYdanV3m3bdz3SYCjjUQHlMyFCut
 BEHkHqALVNxzhu1Jp8IAM0YL26al5Yj6fiGurt9iblxQKk1okU8c/Rnu6Sg5RvaRI8PDB0/lbxF
 TnMBRTTSzh8Sy9pL1wVrP6vmIcmGcL0k0YE5+CgfkJGVL62sYSKOAgfs0o9/9QdOe4okTr+5Zu8
 kQ6Jh7AGa6f7CM98tkkuK7j/H2M4az/tOmX56+8R1lUhYFmtNw57YgDgwKqE7f6238TBpK9EPIJ
 /Cxci2a6hd4bc1SzSxmYE1ZuQl9kJR1LDI8EaGbd+2ZhQAQaGfPQw5Dpv5uk6SyAl5e+qvSG0Es
 0tqpCrm5j9V2VPtZ0D/eE7nutpdLCV922t22DkrfcHSkTh6Iqw/67n7oG9AceYqt+CV6tJqPe/3
 yLnDSKuvaAHMUYGgdKQ==
X-Proofpoint-ORIG-GUID: yOEhogWgL-KiU-woS226FmPsOEAsJpEB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230175
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35250-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,lists.infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7759D455DE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 23 Apr 2026 02:08:14 +0800, Yu-Hsiang Tseng wrote:
> Two functions in ath12k assert that the caller holds an RCU read lock:
> ath12k_mac_get_arvif() and ath12k_p2p_noa_update_vdev_iter(). Both use:
> 
>     WARN_ON(!rcu_read_lock_any_held());
> 
> On kernels using preemptible RCU (CONFIG_PREEMPT=y or CONFIG_PREEMPT_RT=y)
> without CONFIG_DEBUG_LOCK_ALLOC, this produces a false positive splat
> whenever these functions are invoked from paths that do hold the RCU
> read lock (e.g. firmware stats processing or mac80211 interface
> iteration).
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: use lockdep_assert_in_rcu_read_lock() for RCU assertions
      commit: 4498664e2d5888efabb96428196a926acdaa25ed

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


