Return-Path: <linux-wireless+bounces-31423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g4EKLtKjfmnybgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 01:52:34 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFFCC48BA
	for <lists+linux-wireless@lfdr.de>; Sun, 01 Feb 2026 01:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AB113003607
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Feb 2026 00:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDFF3B7A8;
	Sun,  1 Feb 2026 00:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T0gjgG4V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TvRw7qoS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E53EBF1F
	for <linux-wireless@vger.kernel.org>; Sun,  1 Feb 2026 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769907151; cv=none; b=i8XW0GPPRR0HvEDTXRzaKDSD5qBFqRhSHo6H4i3jsz9/TaCB83QerrR3qp7gpKUzH5LQX4u005DRyTlZwsPWVPFW9XcVy5w+qCS0tqrD5qmCGbu9bwQBL2YQxNjIE8Ppfn6DmfjFo+V9tjzrghJkdxBvrlwbN+Cxy9f8X2c/VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769907151; c=relaxed/simple;
	bh=/783b56n1ho2NIlkyQz36KihkW8nX8LbpdJRqGRcCgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B/H7179JezyyChdG48fUNvv/MTJ1TCDfSV6RzZVbAx9gw1g4b2r5MP9BRVyDX9ZPuJ4GYKWEtYSc/yPPj1j+YfiVdmSMp3kY7HiYnbKW9M5rnZuveYvlnTNsz+CT8dOC9b+sxF2GMPgVoBbnJOZN3AgACU3xQldKlsg5bA7n+3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T0gjgG4V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TvRw7qoS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VJSpIj2165791
	for <linux-wireless@vger.kernel.org>; Sun, 1 Feb 2026 00:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	js7SW7IlezvOQPHTslAdWN901PkVuUXR5XrWGLS887Q=; b=T0gjgG4V0h4AQDLY
	P5lgGceWsEKEE4sAbkrPKOQKmeZLA35U3OwWUCZvq4Si/bKFizVhb9AjnsHP9pqo
	ZF39Ocfp7zzvNUVY7GpYz51HQCOa8yDCQfkc+KqIDyasXJIy4mK8+VI3Um7JHqV1
	tchJFMfA5DrBUw/gdY2j3B6r7jUQWcPukhacgvJ4RVmnkq58AHokbrgJPuXEIaih
	64R5eLen1/MUF7n+Ho5JfEswhvDT2EM6fd3u5k96LnhpCoR5tL44Sevzc9F+8fsg
	lk168rPnsniYXDFqyvM190h1FA466BDzZV4TDjrSFZTFIbwdcVG62rKAuo68jUCz
	styqzQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c1awnssgp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 01 Feb 2026 00:52:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b7eddde359so457925eec.0
        for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 16:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769907147; x=1770511947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=js7SW7IlezvOQPHTslAdWN901PkVuUXR5XrWGLS887Q=;
        b=TvRw7qoSnxqaqrVgcIFhE6KT2+bQRx/39zqu/GMRhM9ALBJuk+9OlFAGtE1Y8NTJ3z
         oPFLUoL+IJt/q8rbdQ/8Zpb7xzB7cOD3J632mfGdarY1nxKnvJqAvVWeRpGLy53rzcHK
         4mKOhiPPpQHoztTg/xUBInxNlBKJOZSLF5uMaLrkqrOtAtWQ2sz88WJjF3M1dfVT0jDb
         Yqzl8x5a1ZwZz1Mrz6ywW4r3A6FyM5LNGcrvvsKu45bV7r+rLSRC0lCeVw/o3krbwAWU
         CYDyZhpDPRkiccJTyygPUuowKBGPJZeP0yqnNqM1Gcx/6LvZKAomd8iYfnCGo4YKBxL1
         lIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769907147; x=1770511947;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=js7SW7IlezvOQPHTslAdWN901PkVuUXR5XrWGLS887Q=;
        b=SmlukhcB78hkCTCrGsSckSD/5rD1oGutz6VAkCOQnYM2tutn51/CrvKoh5lbpw9Ut1
         uRx+9DpZYRJ8kljWt5yqHskXJWfkAM9bAV94Nx1Kdd1U/Cla3ackkNB5hjDtQH+q3jjQ
         Pst44Qu2YvdE/gC0HAaHjWngCAAP8GnwAP+AbyoKKdsMTgf4gs+OX+xDiw0PnMmT77/d
         fPhXiYktSyxx1QBLtJB1BH/s4dIHGGjJvn8Ytl7b+CXOQHHghriF52VhvdiXoZLBVDtI
         c8ZkvfNF+fw11kSPlAD0d1erl4xgXF7ZsgRTK1biRaIOl5L4Qa3Plyasw+OR/MZADqg8
         rbwg==
X-Gm-Message-State: AOJu0YzLmRoFOh4Rdqv9/lq+xsDC89XaP0K1sISVmCh3yaTZOm3i4UJM
	Vy7R/066ITa7FaSpjVuQhedi7Eq/yfDyyzyJ8U9FIuJuoAWxLPXOyV5+8tfmuK5FiGtNBGnhYmf
	QR1D/GxzRJh+ipaLuVfDuApbTwmFNK1hADpPyNCeytUycI0Dw4B68dQVpm91Krgi3kqgw4TT0aT
	ahig==
X-Gm-Gg: AZuq6aJP98xksYYk1hWKynEd7s5aiM9YGBxI5hhPMlkU+bW3XKu1d8wIYxAAGDI3vR+
	U+B/1F4c9vgkhwaeWy1m9AaaNZjT9l7ogyxJNOh2VUJDSaH0mhX/8oULoUU1w/TQBRLOVBIRRf4
	EBS9NkFMOdDqlIV6X239ugt4k2ESNFoC3E6L399+yXgE4VYJ1cpGWL86t9J4zRNJH6wG20tui9c
	4BrHZXe/HuyCBidxLRPJnUGlpzRUGJHNCiZrjSy3dARG8Y2HvJJA9uTh1Vl6nUh6RTIeHTdyYU/
	lq0dUSimoDMsXdO7Cs7RhXpnkzczOt4MNMbt6x0+F+GqU4a87C7Cu/K1M0Bihbyf4+foSBy1vCX
	ANnxlLIYtEA91qwB/uaQEsfSAw7otypmaHGuND2vu/skFj6VNr3Rt5AwiMoOTM4VW538ZS/EhNS
	zDLw==
X-Received: by 2002:a05:7022:2381:b0:11b:b3a1:714a with SMTP id a92af1059eb24-125c0f8c6ebmr3217858c88.12.1769907147437;
        Sat, 31 Jan 2026 16:52:27 -0800 (PST)
X-Received: by 2002:a05:7022:2381:b0:11b:b3a1:714a with SMTP id a92af1059eb24-125c0f8c6ebmr3217853c88.12.1769907146796;
        Sat, 31 Jan 2026 16:52:26 -0800 (PST)
Received: from [192.168.1.40] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af8a7bsm16941412eec.34.2026.01.31.16.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 16:52:26 -0800 (PST)
Message-ID: <bc47f1c6-2b65-4815-8751-0b3ad537d545@oss.qualcomm.com>
Date: Sat, 31 Jan 2026 16:52:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] wifi: nl80211/cfg80211: add continuous ranging and
 PD request support
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-4-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-4-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=MNltWcZl c=1 sm=1 tr=0 ts=697ea3cc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=iLK7PK85EKV1UHstNqgA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: CwpTGnlByq1oxYHi52X3waFTQ9YWHcRW
X-Proofpoint-ORIG-GUID: CwpTGnlByq1oxYHi52X3waFTQ9YWHcRW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAxMDAwNCBTYWx0ZWRfX61jIFpWmaBUz
 r/TclVwhBhN82JAtQrkXWZZDSGKb/xbQ2l8iJPYHo8Mwtb7tMwhKofP4pgs+/5QSgE3G6o6mfWR
 VcawiGciYEtKP1ba2zKB6bfwo5S/xZ4wY/7GYwk5GU9s9WyNN8nKkWaZYADkV7LcoJEOTPD7LBq
 hFbw3yR1nuyVc3HxCL7AdTYIuSDdEwD3RjzC1hVW02uPATPopOSg3WJjB/ho18e0wT6ozzOtZng
 fdZWFkmPXJ69JMNacHJdCKc0ABZoOm4c1kRB54wiezSg4BLIWic5EW0yoOBTveur52plNibcMcY
 mY7K10nsW/bX2BxdZAYvFYkmp4asEwrd1U4WlekqRN2jJxL370oHkyR92TaOB/nh8BBnpF/2KOE
 lzfLTj3DgYpA21negaYvzZklGR5HJ835LtSgMtqFl8oXwc43xELIcA4j3auxvGKGB4M/tCBgHS3
 s3eayCspaEPYuNJwKdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_05,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602010004
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31423-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4BFFCC48BA
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add support for NTB continuous ranging with new FTM attributes. These
> enable continuos non-trigger based ranging with configurable timing and

WARNING:TYPO_SPELLING: 'continuos' may be misspelled - perhaps 'continuous'?

> measurement parameters. Also add PD request flag to peer attrs for
> proximity detection support with device capability checks.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

