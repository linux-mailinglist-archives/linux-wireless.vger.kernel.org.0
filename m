Return-Path: <linux-wireless+bounces-36606-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AKGNQQdC2o2DgUAu9opvQ
	(envelope-from <linux-wireless+bounces-36606-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:07:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD02D56E4F8
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 16:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 040A9300F632
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 13:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54173492195;
	Mon, 18 May 2026 13:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VhqQMg9l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SlodVRAD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E50D492189
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112460; cv=none; b=mzAHWb1VWGb4qvaLnS868JEjUOv5uaSOPC0u4qS+8bGAvDk8mT9a7Zzu1K/F0r648T1zTQKF0/s8k5FvqKPLpsdCPV4FsYlohCL8ahPGiXbPezmh6Rm6+j/tD865MZwR84c86vb3+FVUCfxGZIWgbFxVStF9XjpsPxoMsk5/OSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112460; c=relaxed/simple;
	bh=S8LUC6eqSlTAsIldkCTjC/CsuP2MsarcViqYhls7uNk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fg3NJGJ/dEbjpRSotzxjmF9W9nVT3T+cA8M5ESWnRBlj8ahyV9nrfiZmFr67uzfCbQ4bVTNQ+huIC3Mj4IgPLz4pfrK/GJRZAuNXjZo1/bow9GCUOea3KoTzMScodex8y/eWUCeIOF3Nm9DuelKcEKQUpYbc+Z30LEP+8B3tbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VhqQMg9l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SlodVRAD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64IDQapZ2892690
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=; b=VhqQMg9l+Es1EhIP
	EQyDzcmaXqmpqTuJX+4NbcdHUvAZK/nEGHUYihhRScCfQAE6VarU+6Ef8XwYY0vp
	T1wVBxC5Epsd2mUPdb9Vk7ChQsdtDVKtqsFqMDg18n3TfhnM4JpVJ9nE9Vm5fgzk
	SHp90eMCsMM0Z5+Ke/UHExwltx45m1NadKA5Uxlfi0q4IvuQIqK17+Mt3guxTviD
	AcTkCFXXWsrP9/Jfd/rp34hpdGB6t6VLCDwP5S5ePw0S+obA4XwWHVJvMvlFAlsA
	GwnE5/xhmC/d85oIuO/lytCJB6Ow5yz74UzBM3yN060vSPDiwQlzXRNfK/J7XGyV
	dn2jBw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xk19gg2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 13:54:18 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-132d631edaaso11578763c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 06:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779112458; x=1779717258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=;
        b=SlodVRADrW03d/UubEi0WVycltvmEx0l9etOnttyN2oLGVSNuj5/PN+0V39hvjWINa
         Gs+KYHdvVCtjw6tftvhPmquTvYI7vHrAKSWIuveuxvKpG0CegYWW51eh5DePXy3MI+zX
         ikkPtR21PMpKwn7WVvyfluO5Xla69h/Wq9Dfn2vdrL77sIuKP3QZqucLSrwsZnDNmyLo
         t626mEq/qzgvdjiRURv5sdMqMLhQ6nQr0gWZLK7CYzb5sxD/a5rn787XCZL06srytbRD
         3AIeKzoPBhttRBTfhF1W9On8mPqd2f3MY+i7CUOQPhJC/9drhHfFQEK7bx4QQ8alJlvf
         JnyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779112458; x=1779717258;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbs/00sIy0HRUS/VzxcZvFVipUwRNKU5yzSk8ZCe+Cw=;
        b=ljl6rVXDQ4Ky6W4+GoC3+KN5KUmz//vqYDB4TrU5umaUL4LFsB2LqSnUnp/TQi+hBh
         nF9MJMPSV2WLe4lE34Oqv61+bvHHJEhK4sqh/yNn8jJmGUKAnJ4sm8AXMeKuTWvsh9wy
         Sv64FjM+gW+rBYEFgKtjLP1JxQUfeeoBad+qFAXKuKSt26xXADvB+nB9RQV/sM+UP2F2
         zz48Jdp5RXbgcP3bLzEcHvOGGqggLoJ0Q+Ny9vZBCzteQvpuTegnwnh88sJTADg5woOK
         C5upXJhdcOEeWI6G4aUktJqSJb+DSVAUOYC6KOJny6vri293AdREYNqyNsVjgiAK4kAJ
         +yhA==
X-Gm-Message-State: AOJu0Yx8Ko8ABN7PLloNbUqDvfgrLDpIVHw8hcIFTkiOGefC9CNiqE0q
	f8nbJ6dMODkLGj+kcCN/WdGI8yGdS64RQBPZvg0mUng3kZTXYlmV8rLKttRSpJbz11scCr1udCt
	0kq/ZdVx223ud0I0XCElBwcfJ1suHXfIP5VCctHVwuoDniV0KwTDbyArzeRXqobO4qequnw==
X-Gm-Gg: Acq92OGK336FtQBc6Mxoed/AoCBUDFM+OmpbHw2AeWkpeAbQAdJOjlZwL1cOefw6BCy
	g5U7/YTt2CJiGdJ7vmuagKhUVIpSRfUJ6KE/7b4o3g5WLjgv4D46TvxQlo2WHvPbczAm9SfvNAo
	T4ZrTO9XK1Uk6+Ti4EgU5W4oPaUB2uZmPc4AAb84aB1HN85MUlks+CtQd4gZ6Xt1olsepwLgexN
	ez1RWx6QhABPvVoL/QP1/qP0dbwb/f2fTqgXyuSw0V7hwsXFLgOgL4bSMnp4bdxifa5dJdDvBbZ
	zxeT0uDVsO6BStARk0dWB9fYKF8EqZsAx60cJN3N7J9N+KXoRqiumqnsPd8nhutrnRVd1IKVjFQ
	NtlCbSymMqELkci4qXDjL/r4EcjDVxc1BNOJ/LLplhCkPwDrBQuox2a6NED8PwoAEtjdyo+3a5R
	qx
X-Received: by 2002:a05:7022:911:b0:12c:5e48:4c01 with SMTP id a92af1059eb24-1350441939fmr6474509c88.1.1779112457704;
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
X-Received: by 2002:a05:7022:911:b0:12c:5e48:4c01 with SMTP id a92af1059eb24-1350441939fmr6474476c88.1.1779112457051;
        Mon, 18 May 2026 06:54:17 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cc33a618sm20870488c88.12.2026.05.18.06.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 06:54:14 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Muhammad Usama Anjum <usama.anjum@arm.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Kyle Farnung <kfarnung@gmail.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, santiagorr@riseup.net,
        stable@vger.kernel.org
In-Reply-To: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on
 restart
Message-Id: <177911245414.2671480.12255059395274590716.b4-ty@oss.qualcomm.com>
Date: Mon, 18 May 2026 06:54:14 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: 5UVBoyBwo9At_OBjkC7hObPvkyZXJ3yh
X-Proofpoint-ORIG-GUID: 5UVBoyBwo9At_OBjkC7hObPvkyZXJ3yh
X-Authority-Analysis: v=2.4 cv=BICDalQG c=1 sm=1 tr=0 ts=6a0b1a0a cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=CbO934nNXDxLm8dFh94A:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEzNiBTYWx0ZWRfX0txBa5zIR/nf
 I2D9IK/Jcc9UNGvPAhYg9u57CPaCZbvjRBZtEoYE4UeErYG6/VfeYxLjeXCQBB7PKGeeP4q22cL
 Lz5an4cLIRY60NRotgm3lj20veAMkybe+JOYOLMvQQJTTcyz6KDID3H3iwiET0vx1A8Ap//TIZC
 +o4RzDT5RwGG4vnAxlUpl/ezmb+s869+ICweQRwasI+xt++bk193TLiy+lDVol71ZA7FNswGMaX
 dbB7QRSGL4wzX+b2MAUZM+5pjNSFb8uRP+kfWKuuSDDBHYNN2LoBo+uQ1h9A+HsVJIbEYCcD1V4
 eQ22zJl0OvFqPCSMLpLKBtvdWBfKhPCwikRlRNP2FM/WY6Le2rBRgDZlVJXfUJkVxT9g5vHpdnG
 LrJpWuMbA/iVdW4lCpmLcn0HFDI/KoZyGsy3uJmmbJHEXcTNLaedlAWgX9POnPrtNvYXkvIqfHf
 uakWmgrnzVq/TR/MhBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180136
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36606-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,arm.com,oss.qualcomm.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DD02D56E4F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Wed, 13 May 2026 21:52:12 -0700, Kyle Farnung wrote:
> LMAC rings reuse the shared rdp/wrp pointer buffers without going
> through the normal SRNG hw-init path that zeros non-LMAC ring
> pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> stale hp/tp state from the previous firmware instance back to the new
> one.
> 
> Clear the shared pointer buffers while keeping the allocations in
> place so restart still avoids reallocating SRNG DMA memory, but starts
> with fresh ring-pointer state.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: clear shared SRNG pointer state on restart
      commit: f51e4b3b5574ad8cb5b16b11f8a1452147ece87a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


