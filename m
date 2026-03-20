Return-Path: <linux-wireless+bounces-33611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCVyBtuMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:07:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA82DF2A7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5349E30069B3
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23212D876B;
	Fri, 20 Mar 2026 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TDBYr7n1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NDP/ice8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8823DE45A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030037; cv=none; b=Gu00W3Q2fcl8YZmwYaUgopUyDwIW+88oo2A0h7vG+m4rg684NUyl/A6SkjjEvJCplcQ6yVfInEQ7vKPy8zY+krASTGHqqHs1BCfBOeNrsyiBtNX5b9W5HASso1dGFI1ON/2Whmx4IEMLskhyypQodyGbnBSFtSnUqr2RHjVLSrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030037; c=relaxed/simple;
	bh=TBCq8IWbmgL6cyLnSTjPHYeEpm0PYTPvKMOysF1ceaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tkTDR65uL2FzQnHtuj2hUXNeKXMp29JgsA06gAx8clWxGHuRJjEVN8q5coYlKSd0Kv1IyRQ1ja2iQ/xl2eaXKTf2Ua05Tyv0FYmzM58LPoYVSM8BdxbBcLYkdTBc7RN5dLQXP80Rbs3QIRzBP5Vo6TtFz+Sc/M18ciGC4J33MD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TDBYr7n1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NDP/ice8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KA7un43348056
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQuP41ME4R86id9zQl59LkKllvPlwIM8gXYzx/b1p6s=; b=TDBYr7n1J4B6+l43
	1DiNP7XCZgc8PUG78id12kYzm0zvyAN1ywtNdU6DFGnAyk+fGHH07mdHujUKy9/5
	94+k+zPUEqIRPdU4PvVKQ6FsnJPhe1fTedMgq3aPH26ISsHkWFiVPpjMp1NZ0ZpN
	RslqrZ0be9r2fIUhBsBCS090wcQbVgGLlYDljlDbHN6OG2grRoz1Hu4oNyq0y4C2
	UgxKrhUx351RH+mVEEGq1/Oere7Cz6I+REBYQL+1KoTmBYTsTEjh3l0quqxqmFD4
	KI8tZr+v3z+VMfTkrJaFqpkNhWL0VvjnBhDhyKVmhlyEXjP+Y8kgFXXbQ+r9RIwL
	OChMSg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1479s55k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:07:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-358e425c261so2667179a91.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774030035; x=1774634835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQuP41ME4R86id9zQl59LkKllvPlwIM8gXYzx/b1p6s=;
        b=NDP/ice8Vcxhh6K0yYq1f3+PcOaVMCUn2BJtTXRqKlH/YQ6nose12bqpnFAtrRgIpU
         Sk5lrah/gLodSBoYWO0o1x8xCBlNovanvXQqW4HzqvIw/64klxAxxDOgoVEC8IPyqKxM
         ewstYuf62AUUwNNqhfQnPwo8uYaSG4S3BMOIVV/Gtmebo0RWWrZd4o6u9B4JfE1wg/D6
         80RVPf7xT1dZnh/FlGL5teZ62IEi+SAAzozigZrmnCjjZGVVRr5Ndmom7GmdyBX7ZGDy
         SHra+UPaYVM2DtXlCtB3iA1adfHv3Az0ZHNQ77TS0DlVcIe1lII5pRufjYDq4dt3vlEx
         b28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774030035; x=1774634835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IQuP41ME4R86id9zQl59LkKllvPlwIM8gXYzx/b1p6s=;
        b=DMcBAi2gyQfW1u2Lagb1e4KXA6nLzWZdnmSEOIdxXkrqMZX9/m4oB72ANyO2C15bOI
         KnXqx8lW9xQ6DR1y79k3Xl4Tc6xGcsESSK+9YXJEeJhL02O46MPvrUN58QE2stkXifZc
         8Zw/MkiYRyM98ujPSIfEoxf/oqlQNvgw3RetLW84ZUV7AjDcB5rdarhan4j9/G2nmWQ+
         s5AS5vWMlZff4SUOxFyGraEmFyFkOWTMdgSeYRA0lSF4aGYqrCFVX0skk8cntv6WhFGp
         qp7tZbSk3mVNtspl5/NKV3iWolpn8vaXLdw+EpCgaf46EmFR3Sr3aQksGyPeMgS/jIGO
         F27Q==
X-Gm-Message-State: AOJu0YzrF/wNukf4lztL1P1f+3UqINLIxDShaVvADCVJh+l9bdwyeHHK
	GLfchSLSyn/a49ghFWAXWR0dSkbLL4cClMm9flWuRURdiZt+hmHcGGz0UUWoccvF3bMRikyOiRh
	uWDBw3eKQfhKQszu0hy5eSnSI+gCBtCwzK78JAV7HKX0orI6tks4yruUXtdgE1PBS9UPoJ3Dpwo
	BR
X-Gm-Gg: ATEYQzxi6iffxBrwjEFnqiNADur2/OdLC8P4oXF5sjxHCLyNJ/Z5YJPQgvUJx2DQjRB
	QpVDvjz6Iqc425ckol4JW+jJLrAb7dZ3h4F4fTnNHRLMyVGwwMBHio2bw/hKkCTp103MPyOWnqG
	HBnKpQAlL3eexwnmbP9/D5zEp1hQ3nsdGPtAemEuR4XjCIpSm3EaoGtqWRTL1WYoFigpA1WBsAP
	fnOhpAQRyaQ1VAtgqbl3Ohe+BEhbKGVB0Vj0y1ORoM6AuwvElb45qixUHPdWbgDyKejmt65Kf/y
	MaC1XQfXLVC7U1RIaNVVdkCfDNODwA5fOhPBk8Vz3ib07vn9tf9lcD1uOTatE+B8qO1NFJjS/3t
	CvdhrIFDXQyqvztsq8zwTqpTuvnFRaJxR3MZebaCSFtt/LKP/Tn2VGM8=
X-Received: by 2002:a17:902:e802:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b0827ff69dmr35450735ad.45.1774030035302;
        Fri, 20 Mar 2026 11:07:15 -0700 (PDT)
X-Received: by 2002:a17:902:e802:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b0827ff69dmr35450535ad.45.1774030034768;
        Fri, 20 Mar 2026 11:07:14 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083656f65sm40543705ad.45.2026.03.20.11.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:07:14 -0700 (PDT)
Message-ID: <2b84e132-d134-4376-9123-da655fde4e3f@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 23:37:10 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA role
 without LMR request
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-2-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383C2D2AFE618B66A92B698FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383C2D2AFE618B66A92B698FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4lEzFd4yL60RaOjdOlRKgzTyz3bUNxYH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NyBTYWx0ZWRfX5W78zEw2gi5J
 CB4sRBoaJCzJYTMAuoIgJS7VJQEyOGoZMrkUUwEnNgVSd0jK8DOKzLswUApDmSBEuks5tNJXKWw
 N3ose9zRXwzD/+qclgTwQteQb3pRV1JWTFi2AIONBQbuF9GmiPLdrd3OTiQv3PH1ppDQutLAu8q
 lEUuh1UbLrcHcgy4Ez8wzLCOIlptQjOtVsT0lhMIDH4zlJyw2H27kJb40nMKXqPGt377MfgPsnu
 M97wAZLwvxjsPhvrW6IqKyNoDWabPD/gqFK05BJooz/hCY+s8dLr2RJuAmTK6Mc4fKApSuQltTY
 Gy/wB0GPFPIaV965uB8s48rzWW3dEPrQmUiKvkApGCZv16tBvtDjgMlkYbT4sA0bjl7UiOttn0m
 XbDtRnXtk67ijlLqimOLP3UarOOqgA12TwhqMntJk/MmMRG+q5s8uTfkdQXOrk+5xiWZNkODXbp
 4yf6SRaxHfFYP0wPM/w==
X-Proofpoint-ORIG-GUID: 4lEzFd4yL60RaOjdOlRKgzTyz3bUNxYH
X-Authority-Analysis: v=2.4 cv=fOo0HJae c=1 sm=1 tr=0 ts=69bd8cd4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=_j2-lku_SYWScTVOvJ8A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200147
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33611-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 26AA82DF2A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:33 AM, Stern, Avraham wrote:
>
> Hi Peddolla
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 01/15] wifi: cfg80211: Allow RSTA 
>> role without LMR request
>> Currently when enabling RSTA role in PMSR FTM requests,
>> pmsr_parse_ftm() mandates LMR feedback to be requested. This
> I2R LMR is mandatory when the RSTA is not continuously available on-channel:
> I2R LMR is required for ISTA to request AW changes (NNW bit) and to terminate the session.
>
Yes, I agree with you, in the next version we added additonal checks for NTB and TB.
So it should not reject valid EDCA based ranging request.

>> prevents valid use cases where devices need to operate as RSTA without 
>> waking the host for measurement reports.
> Devices can decide not to wake the host although I2R LMR was used over the air.
> But with current API, cfg80211_pmsr_report() is expected to be called in response.
> So maybe need a different flag to indicate no response?
>
> Avi

This flag is present in later patches.

> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

