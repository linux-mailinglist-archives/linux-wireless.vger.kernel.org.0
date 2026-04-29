Return-Path: <linux-wireless+bounces-35552-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kP4wEwOP8WlIiAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35552-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:54:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEFC48F4B5
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 06:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCC5A3000096
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 04:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FC833A716;
	Wed, 29 Apr 2026 04:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QDEK4rrU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ise6Lzi9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9E129D291
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 04:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777438461; cv=none; b=RB26Xlfh+SbkkQ7L3lYDzxIaxRcz06aOqezmcPjcye3cvxQiAqtYOt44md78SBTAwoVgr3Ag+e1fd2G2eaCozC+4YBwI3d4xhXTlJzARXRh2wNKW09lClsEQHNwIaGhyFrIbiF9BT1jj1BglU0hCeB3cLkIeXnhS2LCGHFIt0O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777438461; c=relaxed/simple;
	bh=5K6UxPFYn2KoIPnnjVPaST+asVrN3X9xuoGWglV7T64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nho9IUVHhS5bQb5nUk1WTh6oiEGtr6Ll1QbcEcTrPpxlN3c+91m7oQUPwuNb6BKHUpFb5UKS5Y0xalg9v8kcBI8j0nXKPccQanh9iZ/gJ2DGl8bbCPrOj9akTVnrJpAUfI15JVSiSVWnW3JWck4B0Q/F8THabDTaaWvlekvYtxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QDEK4rrU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ise6Lzi9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T0oKUa2008553
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 04:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=; b=QDEK4rrUwdfX1y9J
	Bmw2sVvfzEHUr+0OaXaIebd5IqhvoJz6Mz98vRsclO8ovGdJNykHszblE0l7zFZC
	VQy53keg9J685pbzUKxmXQz2PBZtKYBpl5WhYBi1f0wdVhNdVaB/JKzQPonnVcd/
	kU+Wp3BIxR2fxkdFRoUwCO4dx6zyROKr0bHYrNQaa9r5HixEAQVi+1KpmmGRd4DO
	1lRTg14A+iQjw77N1zgxuslhZo0OEx6CIh6h9r+m9y/3bTrD1o3FN9I3zhUhSu+S
	795KYs6uLzwix4bFeaWgyuM6cKV7Ff5dXfKpqjlNIBn7XFysydgXvRbM2Vaxg6OA
	CU66uQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du7sx8p2f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 04:54:19 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c6e24ee93a6so292325a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 21:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777438459; x=1778043259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=;
        b=ise6Lzi9bv3xz5cmhFXhyV1cKqt6fHLjMG8qJHhCkagIPhZLi6H3poGbtBDsXn2OWX
         Bi/OLzIsnw/Bb/FOquDMvPCm1WSRO38PvDGEtAg5WKrJ0tWtEWiepzUmZEwFrl1q0cAA
         LlL0Ii/BAyW+QRJ3LNj6ODodJ9EAjnCyOjmcrM6lRxXh8Yyt5El6ZniRVTmedA/1Db2O
         ai6cFI5sK2Ypc7eHH5jJLHveRL7/D8BUa4Cx7KuQEHPBmXB9AW8XAvySScyiA0w+YXWB
         O04GiePcWSOU2/Q5C8VCpqjXlPpJy5v5b2O1WfeJ9Rw+VBonmneugoz4wPHsm12iMsG2
         Us7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777438459; x=1778043259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjP24Ug9r/GHXosW899GMKTKymLMpRxhQMylkjBjEOI=;
        b=isHRvAre/Z5Vfjg6i0RKSIZEGq94/CEBCK9ZsH/zcReT6hJa/OedETm9MQbO1HIJoe
         7u2bseg+VsDLJvSwJl6x5ioYNiR20L09Ykyr53/43fWq04C1eF3kwBRItUA4xaeKaHUM
         L+iN+JshbAvO9Awo6zhtU57lJWe5y30/StGbdSsIgN0TKYiKHIkeoJ2f/Xqapbuaw+3Z
         +bUkf0W6myZ3emM+iHUnJXC0xkFRqDhDAApgwhC2i/rDTQ11RwQHz54qL9G0LrvNMmE1
         xA6ZPqefoTvrlUp4ezYIecAFvaQPi1vCgbQ+UJcJikCpLkAvOKNU/AKYGlajgWGnZtob
         NsxA==
X-Forwarded-Encrypted: i=1; AFNElJ/qB87C2mwLElSDrhVkQGIhDt23BUtsxwtijSd2ofuYabgDg+QWKq9GLvv7/j2BoEv1opwabyeqWJbSI4wjlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwjB+Ami3cwQtyX6hWGrNxvZKQL0puA0vFiNvT91Yf2bhKMTOIC
	j52N3IKBt3iEQGA1Ndf/Hhk+SqGytAKXDThFqCKjdPiO9ACO8TlF4dblYJNjoWrNEbLAFU+ONeN
	J3koayggr3M+RhcLDj4D4DjOJYShHyK56SkHKLbM7k9lMeX1yLAHCCOILTH2QyRv+nRP/EA==
X-Gm-Gg: AeBDietXz0Mt3zavWbT5vC/kpeINlWGrmridki6CJI971l6VTlPAOjhyH9FOMJJNf3L
	sH7KF2Hjua0Ynjg6qpvcAX7nPmBa65WwSWHl9VRm5jVtQbSaPeqyJxWhCC8XZCU/TJoobB//ux0
	mYVgwkVamLE8EwduIhVOyq0WufDX2+tu8I7J4q/H40x7V4lhi6Wsk6FwyOq1XYXPi0aAkS+IhtF
	PrYRhcttkaktnJLmbTaqV5hpikQo4OtPyztjPXjQSeNF+XNXgwnZ/qp2gM1dVNwjFRyB+tbsJ57
	4TPibedMQ59wiGnTiyMvVVk1ovZmMzklMtmRSVDNeXRdswl9x0HOMRUTF1g+Gimt6KUkt0awcFf
	NbKCkxH8KRPSoNDoXideKgTx7UuWNseyQyyByUaB+Wu9AOnTl3O4zBi5xYBhR1Hau0vzmqiok
X-Received: by 2002:a05:6a21:e081:b0:3a2:e8f1:b862 with SMTP id adf61e73a8af0-3a3b393ee12mr1255816637.23.1777438458219;
        Tue, 28 Apr 2026 21:54:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:e081:b0:3a2:e8f1:b862 with SMTP id adf61e73a8af0-3a3b393ee12mr1255801637.23.1777438457725;
        Tue, 28 Apr 2026 21:54:17 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd606662bsm679084a12.8.2026.04.28.21.54.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 21:54:17 -0700 (PDT)
Message-ID: <535dddaf-0275-4f16-b221-a593ff6f7611@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 10:24:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 ath-next] wifi: ath11k: use kzalloc_flex
To: Rosen Penev <rosenp@gmail.com>, linux-wireless@vger.kernel.org
Cc: Jeff Johnson <jjohnson@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "open list:QUALCOMM ATHEROS ATH11K WIRELESS DRIVER"
 <ath11k@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260428205017.26288-1-rosenp@gmail.com>
Content-Language: en-US
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
In-Reply-To: <20260428205017.26288-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qu4r2e1TkqCINeyTth6suERaPmfIbUJT
X-Authority-Analysis: v=2.4 cv=eeANubEH c=1 sm=1 tr=0 ts=69f18efb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=rJ_IYOnZYG8bJ-BjWygA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA0MyBTYWx0ZWRfX3BuPbJDPafyS
 6CqdbJWW2WVmfoQJbiRsdJoj+tY024j5W/r1COMJfib6B6o+S2Cdf7SdzNykq1RnYssZm9m0nKq
 jqd+PCj4wmbWmFBcHe48bZtpsMMmV5rHMfwJSGAteWT7EURKEkqoH0cx0gZx1A03DzStCRyHPEx
 rixhIyRVamFq7iWdyPjdr/luLMkAyGApqsKbqIbvUan6EnWwzxn3izVy+iNcBxPaMD1hF1lD5QH
 5EFVj2Op7SU9QKJ3BFFghYVuvf458bDMs3BDMCl5zrimEgiISBq1egTEgGSxpphDDm0iyVURNfg
 AYEx0CDfINQx/Zk+zpwk1gXBVqOkYg6Sl1vM267Df4ayN+oJEXHuYewJZQ8HbRVyZL192QlNjht
 6UcjN2SXVCEiYEtWNJTRnQo5ch8qAG1Eub9yhspEaiiIxvTzm29DmRWB15Yj3nkyrA2SLAgxPKX
 IeIB0vYlGeLIYs6zG4A==
X-Proofpoint-ORIG-GUID: qu4r2e1TkqCINeyTth6suERaPmfIbUJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290043
X-Rspamd-Queue-Id: AAEFC48F4B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-35552-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/29/2026 2:20 AM, Rosen Penev wrote:
> Convert kzalloc_obj + kcalloc to kzalloc_flex to save an allocation.
> 
> Add __counted_by to get extra runtime analysis. Move counting variable
> assignment immediately after allocation before any potential accesses.
> kzalloc_flex does this anyway for GCC >= 15.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

