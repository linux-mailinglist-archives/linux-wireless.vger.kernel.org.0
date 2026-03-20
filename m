Return-Path: <linux-wireless+bounces-33616-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGc2I2CavWmR/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33616-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:05:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CC92DFB1C
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E469A307F299
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343C2DAFCA;
	Fri, 20 Mar 2026 19:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1VcgOVJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CRb4weUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5F23AE9B
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033218; cv=none; b=Dn4aLfSAD8ccC2fA23ulLt+lJ8fA79ZWdZQ/3HH1huqHaGZjyn0NMbrrLaWT6+KP1IfCO7TTz2os8++J1B2SXIIv/fB/O5w1UeJJ4CrUPrDsmIRPiQFoDqizTSxnlQzs3huKk4LjwwJwFldS+PLoLngGLMPHKTNIRhGK7fdsjvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033218; c=relaxed/simple;
	bh=wkQ4sWohym+R2HrDfyuBi2a9sIVBtvzXal2ds7naaC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJiFpVJeMY+0vwVb27+mkUNMfaKZx8rMs9uVU8fHjBuIdlErPEF8Tg6OZbdf4vm3kRW82R8UNFnDHYxYoimNnVVTFNgFiDmkg0FnSdvfh2S8B2XcsDzTuxTUGxPRNv2BuCtnNf4uSoORAjy2bSuWc94f7JpQyb3ISz2wBrnbf8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d1VcgOVJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CRb4weUZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEC0Qm3557777
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pzGkU6AO5uNzPzk8lYI3eCe4Dy0dV/2nplw2mY4kIZk=; b=d1VcgOVJxP4U9fLC
	ca6JZe/pB78jg4CGihdjndzVRU7DbV4X+i2C7X6yGZxmdTHzzmrYr611towedPte
	CwzDap16NgPPNZezNg/T11ER0sTj/Xm0kCxg36tUTzwgAL2O3XWfVe8axFU9iF0T
	1SiqQ6ICM2u0jMB04JaVrlSy4Pq5R5KfWypcSQIXUeHhMFnUUwW2UnFI3w0ii6vY
	B4uqHUSV15CBiZn49p43aCyITAymabz8CAVywP5su/Eg6DbWy29jr08371Be1UHd
	8Zo+Vbd6UwY8VUGV68qXGegmXVVa9WFhGIlcWimMenqkw2moS7vYvaTDjJlU569W
	EmalDQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gu3wy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:00:16 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c70dd30025fso4032152a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774033215; x=1774638015; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzGkU6AO5uNzPzk8lYI3eCe4Dy0dV/2nplw2mY4kIZk=;
        b=CRb4weUZr/FlB5oqVlvxDcTPo8uhri2PewkK+tzEfxw5PsxcP3tnHJ7RKWCxIpAU9N
         nB40oQSMAZoZgVQUm+C85YBDSzJ8JaI2FqBzEdKu5fyJbSiTnonIu2puYLd6OijlV/TA
         hkUev22qE6eNide3qc6YHLh2iTrlx3Vi7KbXl82Bdtj1/iMAZM6FtYEZsYuoIVCubv+N
         3X1wqnmZfhVDBagN2/0q08MiIv+1lXqAMc8CGpkbvINuqARhxDZXq4sj0bJ5tqIxLADG
         SStWqqG5zbTz/jiPegq7yMcMw+72kzPCycUexzFJQ2NNcvkN40PTUar4mLM5bVMlTnKb
         4MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033215; x=1774638015;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzGkU6AO5uNzPzk8lYI3eCe4Dy0dV/2nplw2mY4kIZk=;
        b=F0xizo2FZnmqTfHvrzI7qukBr/9TM0pzfP2JOyT0x16HPhb2fyr3FQmad70jZIU+ee
         kCWN4QfGy2ZvB6LaJBBub3Agir5yAuyyQmUwHLH7OPwGB5zyo8pM0cKW9p7NxJXNsnAE
         PHyBavwxtCg7jZVLM1368SYsgSLx5/IEw4cdV/TcTLwcppP5OmNtoHW8Ozv9gJaSHYGN
         6RKeXS95yVPada8/pKvC7LUhcjHyArEruN7vIL+vsdeihyWLO0PPbx/gmNRfKgbDbZbO
         KTwqArTI/PfP2pvDHau8rXH+ulxu2YlWVJOGuA4DMOTdcpocWq3Y6WYwJB1RQvXTYHx+
         2bGQ==
X-Gm-Message-State: AOJu0YwTgXGOz4hJMuAYM9+gQyVWs3n/CqmsNwDvPeucpnlgabNSuB3I
	hYfhxny8WZQ1XgWo1Fs5ij5dInU7KIFqbvvkOPDVsbQg81dk8aa9mlOVE8zBmwCfpAHXT+dxo05
	XN8Fu3UbSLjWx+BXuvpJvRgCLAdgnP/r1gOm9D2eWn+KiQ/4tCaXpto3HHG+9LtfRM7xy
X-Gm-Gg: ATEYQzxw3Rkho1zUcjQCHUzLajeU5kljB0739P0Ow+nL2xHCDO/d5s9qZnPCt2A4Rc1
	JlaEvm937K/P96gynk3UhETftQtgmJdB6z/JXU13mFqy20kf/oSfM9koT7GVVCs5h3BP8bBHDBP
	Vzx7FQTVTByDFcjBMN49JptF+85qvlnNsSffiP8kUVRfibchOD+jeKfGp5rvn58lUEy4VN8h+Mk
	C6ADhzdXWOxiV+lKFpspG7foJ24tjj4Fer+N1NUJ6o8Ae88T8a0uuTV0wWjPgvcFn+9V6I3kJKH
	vLnGtmVbYgtRQwQIKglvHajxUVAPokO+IJKfbMtrBxVNrVOMrAhjbM+ue4mSkJyq3JdACeDaUqO
	2z6KHS7iVJRPtVvckHks0Cnaap2HMj4lFxEgo8Dt98EaV4rGRJWwxE7Y=
X-Received: by 2002:a05:6a00:13a9:b0:827:2a07:231d with SMTP id d2e1a72fcca58-82a8c280e77mr3865512b3a.17.1774033215567;
        Fri, 20 Mar 2026 12:00:15 -0700 (PDT)
X-Received: by 2002:a05:6a00:13a9:b0:827:2a07:231d with SMTP id d2e1a72fcca58-82a8c280e77mr3865478b3a.17.1774033215071;
        Fri, 20 Mar 2026 12:00:15 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040db767sm2910226b3a.51.2026.03.20.12.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:00:14 -0700 (PDT)
Message-ID: <369a99a3-9fba-4959-91b3-0f39bee42d40@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:30:12 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range
 report negotiation support
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-13-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB838301E435C801AF69C87B96FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB838301E435C801AF69C87B96FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NCBTYWx0ZWRfX49QUfhNpIFc8
 /J3tnMMXoiGykLNsxcBHgLXEYbkdKRhoTanyS0qbof2mSnYeal4+5hPnIjW43fbKeHkY15olLM9
 Fw+zxu0p9mFweiqZqPjoOJ3IHMEcKiPihsbv+9xNTtxvVlXXp7yhguhLlNjqkQqFUnOyPER1VXX
 vcIQst8ulSFzEwlfW4UHLWL4aDkVxQA1CAIkwTPx3igLhZvVR1Qckir+61mGHuxDxwCNAReB1Jo
 6ZoLsbJbf5tsoJ9GJlH9xu67N1c33uP110J4MV3Tl6wNvXC5axaCkpuzI4n8pUKe3CKXzfiHY39
 U6fZIhHMapoZW7duJ532b+FOGPqRPaWVdTfz14hc7Z7j9aGJvsYlo3flRooKQQvvB1mUe/FY2mY
 9luXrqUHSJvjiB79Rila9TmTkFBNt/dOahGulkQ/8G0sx2avACsteJ9VNyKuraSjWRWcxsLZj46
 3SVRe2r7ns8xtPV/IqQ==
X-Proofpoint-GUID: qFMdMiDS4Q8mf_-0XgizERFJRazmjIlc
X-Proofpoint-ORIG-GUID: qFMdMiDS4Q8mf_-0XgizERFJRazmjIlc
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bd9940 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=dtGjxmhuiRq3e1MmmRkA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200154
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33616-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9CC92DFB1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:45 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> 
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range report negotiation support
>> + * @range_report: negotiate for FTM range report. Only valid for
>> + *	EDCA based ranging.
> FTM range report is not negotiated. It is mandatory for PD EDCA based ranging. So this is implied by the pd_request and is redundant.


Yes you are right, we dropped this patch.

>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

