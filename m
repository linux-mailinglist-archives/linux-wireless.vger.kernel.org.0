Return-Path: <linux-wireless+bounces-33774-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gI99HfWWwmkbfQQAu9opvQ
	(envelope-from <linux-wireless+bounces-33774-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:51:49 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A7B309BD8
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 14:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88C56308BD33
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2026 13:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29B33DEFE6;
	Tue, 24 Mar 2026 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DRQ97I8D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RXswCTyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58EB34D3B9
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359991; cv=none; b=LU5zLsfMqB9oX69HOqih/Ey5TWE95h5Fj4jdjW6UeS7LVgAauZ/DSuJqQy5dFR3ypMEkT8tNsxnMIoeQ9bBFIjX78J1qNWzsrVTAE8e1XE2LRR3lp7oRGn9iTLaoNaRdTrrAfHAfklyFlmobQPMkLJaUGzpahZo50fqZkwgG1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359991; c=relaxed/simple;
	bh=olR7J5GNpfZdHzbLUItPugVxHEf+guq8iT2lrhemA30=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q77S0nr9S84lWYjKNXds8tPMZOJyw1EhHKzMS7CFPJ/FaHrknTiI3fNYAHd0+3MWSN0yowN+1oQTWeDgNAe1qGuA2lx1KaY/wGcQW4m8aiyfJ9sc48VFh+rHPSmm/e5L138PXHYnTUKUB/wE/UWGiPlA6Os/zYwwLIbrJLXwyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DRQ97I8D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RXswCTyp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OCqh8x127598
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZKVWxNgajjDfSEk0znsaaLuR+dYipGX+JnJkNm9MLrE=; b=DRQ97I8DkKS+ccJ0
	DDXt4PNCNz2H7AqmvVZDABEnu4jzj1qHFP/YAVkdR+YoiPvXYS9PxjSRNjG7jmLA
	jCOuoI2i4Nw9ter/6nI9Owy9ruxtQeezi4pWHpMzqwfuTZHGPPbA97hWRPASs0wZ
	I8gS8GTBBnNUF54R1L8i752fA3FL8OdiAewLdFbbkhiWsuBWEHrnHPnB3Yp5NbYx
	+8Vzv6c5ml09+9sAtllk4xf5gyb12IRE7mJLOYZqnZVip/0jX8ps8L57hfgSSqoI
	r13XsI8DNSY5rzlRZjPYjtR63XfRo9WPcGUgyXrx4C5ZzvnRHUlqQ37pX826ew4I
	aCC4ig==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3u0m063c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 13:46:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-128d0b690feso10559121c88.0
        for <linux-wireless@vger.kernel.org>; Tue, 24 Mar 2026 06:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774359989; x=1774964789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKVWxNgajjDfSEk0znsaaLuR+dYipGX+JnJkNm9MLrE=;
        b=RXswCTypAMqYXvnrGo96+c8bajzD3uYJ3GPillMauYhKw0tvLU1YDpT1ewME5jb2vY
         uSU8nO5PjAappDWrPdeH0GOOQ12g0Z4J1jdsjJJ2Q5RhSvC2zFYNaCvosBvhdcDSn3Dq
         9Zleyb6U6k8U1ERZGb4Fw10sM9VJsoX9fB7fEbgq92mZr3lz5GtESSvKtykFvR423/de
         SUSLuBiGBnK/gfL8HwQMsqRZ+jD3Y7ONEU2KyMPcH1gC/5C9hW1WuJaX7PViL1YJCYfR
         jwJ930kcAFLRTpQDVa6GtlDxoXKLSebZBfX+H7OFh/R+slD2keY/gzPNROen1v8xCzs0
         z/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359989; x=1774964789;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZKVWxNgajjDfSEk0znsaaLuR+dYipGX+JnJkNm9MLrE=;
        b=pdNQAWwPSQ8qp0pYgfEt/xnvtYQXU85t7R3Xt/zivZQJxaePSaFtdGmHeMQ0Mwo8lT
         uMUddMBos8sIvlLEZCkXrbK3nn6KKxqWwQOc3bResaO+ZLpcRIPmXllfoIjcddBFR25t
         FqQ2GCVsBme8DfkOI9madI5taX6mEFVUXJLsjM49dWA8jc0FMzT7V9btI/FXLdIT8n10
         fMoJHSbFAapFxFLmAZRUGtZKE8F8kiczCYVf9h2pn0PgxwY2BzsfL/qhjDEGXmDZ2e/g
         QI7cVcZEveE306WR2+Izc5sLBC8cik/mMtvj8yJYkIKZ61pKxoTKeGbDDeZIrpetEB3P
         m1FA==
X-Gm-Message-State: AOJu0Yx63YGXNN/IbySm9q4strO6/udvnEGMrkmM5KR7qXmvNIhyJ1QM
	YK+SgNYglpvMwgUk5tOzrGHFQZgyTQplks4sD7sarZdbEb33KDXUK7rMDqgujGdvukNAyaKjaBu
	wTRlGZ0hFOP1llo75J63UQ6UkxZ2x5/V2PWV5fLdkqwZTGYdkQhM1Yeex/0+jBK6bK5+sYg==
X-Gm-Gg: ATEYQzwCBR5SDDZVgg1iLrKV+NJXYi4P9a+EmYV7J6WEXxHMJO89vg75a0qn3VocvwK
	vxYQXxaFK+Azg4hYq/0P+0ySkOdtJfO6ksQvcDYlZmKjHIx/LFtNpfyRbKbcDlv5WVW1cebNfys
	LkN7YF52sC2hyz20xyL+dgDcmTzpoYvIakP0hGztD2A2yvkLkkws8UNLxiPnwBBpdqwbRde+KBg
	16xQulg0bJnjvXwFS4Vxtj7utujORWERd+S2yj9wEHtYUPfEQHVXCFS+q+fhxN33BQ78LaqPTK2
	d6/RWt5pWcxop3+Fhxr5x4r/vLTIM7RX/ACSVl5j6IcBSEBtDJrTv1bbEjvisgwa51Rg6Vu9QkL
	M5iloSRzqa83Cekw7zpZ8fiElxuWGKTwBIRhJAnzXpXHZ7leyzuP+U1TPgUkkfEqRTaJnpw0u/R
	jJ
X-Received: by 2002:a05:7022:1b09:b0:127:5cda:fb7d with SMTP id a92af1059eb24-12a72656424mr7994026c88.6.1774359989461;
        Tue, 24 Mar 2026 06:46:29 -0700 (PDT)
X-Received: by 2002:a05:7022:1b09:b0:127:5cda:fb7d with SMTP id a92af1059eb24-12a72656424mr7994005c88.6.1774359988859;
        Tue, 24 Mar 2026 06:46:28 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a733e794esm11368447c88.6.2026.03.24.06.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 06:46:28 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath11k@lists.infradead.org,
        Reshma Immaculate Rajkumar <reshma.rajkumar@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
References: <20260319065608.2408179-1-reshma.rajkumar@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v3] wifi: ath11k: Pass the correct value of
 each TID during a stop AMPDU session
Message-Id: <177435998825.2954589.4435953156706637235.b4-ty@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 06:46:28 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=IY6KmGqa c=1 sm=1 tr=0 ts=69c295b6 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=vkfXM0Oplov9zySb:21 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=9PWgfb-kKbfySk47rSMA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: ZANYHrG7LwaJG9q-lscjG5t_8Eh-zsEs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEwOSBTYWx0ZWRfXwIvfOcbMIeCk
 dwDnXRv5rpPpHR6qY4ITfACCvfg/uC6ouwFGjlr4ZNHgyRCryqreZPyd+fbTDRzLcEJeoFmWgYg
 gJD5j72UET4XKIj+h1VQqCFx2EMaAwfUxX6J/6TwFfUWqdsSIzwXFnSlLo2yq/aoDFXSUalryxR
 OAU5PbeZwJWK/gL6rEh2LzLbG2WIxFZXHnjRkctHqINnd8nwD7CmpJNjokofstZMJpqdru1QjzJ
 IAc/U1z+15kYnd+/ayctzTJx0vwRCEaGkStOAdBUE3vt1yfF/2aI5RkDdoCO1cpc2vRvy+hKrti
 +oITLISGjfsGOXCNLjjZNZBcecolia/O0TnIGFs5TaQnA768fzXPydrMcBse41uk7kolGJTA6hi
 El6dPwDBVdwbBpN93ZsWF0lcCez190MccL8tKukCzW+I8cotxz5elt9vaY+GHh0/vt8DlvnL7ka
 XmVWLIBXGNFsEYm294A==
X-Proofpoint-GUID: ZANYHrG7LwaJG9q-lscjG5t_8Eh-zsEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240109
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33774-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: E5A7B309BD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 19 Mar 2026 12:26:08 +0530, Reshma Immaculate Rajkumar wrote:
> During ongoing traffic, a request to stop an AMPDU session
> for one TID could incorrectly affect other active sessions.
> This can happen because an incorrect TID reference would be
> passed when updating the BA session state, causing the wrong
> session to be stopped. As a result, the affected session would
> be reduced to a minimal BA size, leading to a noticeable
> throughput degradation.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: Pass the correct value of each TID during a stop AMPDU session
      commit: e225b36f83d7926c1f2035923bb0359d851fdb73

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


