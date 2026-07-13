Return-Path: <linux-wireless+bounces-38936-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w1CpL/OBVGoKmwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38936-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:13:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7156747751
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 08:13:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=CCnC6lI2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=EcGxR2KD;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38936-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38936-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D09343001063
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 06:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82463367B96;
	Mon, 13 Jul 2026 06:13:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E83364022
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:13:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923182; cv=none; b=MryON+xrMiCKhUfveq1YqvPNqpqtTYY5XcHFfSNbJdLTzRVjf2au7aAmPt9dsKid7l5Ma/cjk3QKmjq8lBiDowFnqHSoYN6v62Cl/u4MwPaVLJ0R5PHFgxizyB7yBhUks2ywR7VcSvxqhCc1NyJAbQB9/DBr4B7FXt5M62uKCCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923182; c=relaxed/simple;
	bh=YkmRICqgo7YPaiwX4jWDk/7eauiL/wopObCKXc2TVFs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZIZBt3yvfocyE8ZVKzI6doEyedNzfsnpknm3C4LTwNNr2Sao6bPVK7xa8e+4uJfKcMfZYVcnnC8iVgKE5gjYX/DvTg0jQEXtonK5MEZZr4T2evvAH+hDCwpwNDdtbFT6z5p3UCdCatG3TaJWaeL6cv9bncIabNMlGGXdFf3Nis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CCnC6lI2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EcGxR2KD; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D3AIan136786
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:13:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Esj1g2bG213H6N7p0zMCbkRBnvln/9mEV3dG4w1Ful0=; b=CCnC6lI2bDZnHLFA
	e/M2f9kWK40UgQ7WJkDoLvmafZVMfHcK3T3Ff0RO2ShQubcTN3szuYm+EnDs9YpG
	dpxwMbsbC7OyG70ELnMu9YKqoA+e3Cfh/6W8fyLjLzNTgIZkkEN9A1+MpyilaRQg
	4C7pHJW8KDSfpSnwKvEPN7b8t6UIUSHKntaRBrX09ufDewxh3lw0EBzwjLRUvl1K
	KnTtlOSmfQR88jVghy3QouVEhwkfDFP84pzgsbwqkFdho9Uw3xnxJ3q1RBTWN8D7
	hjB4W2U92IZB2CKiZhKcBh7baqkk7tE+D0lRMHW6FdU7C1QCwD+25EEQNf1hKHah
	jsbDqw==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe914k9f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 06:13:00 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84a251c2e3eso1135966b3a.1
        for <linux-wireless@vger.kernel.org>; Sun, 12 Jul 2026 23:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783923179; x=1784527979; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Esj1g2bG213H6N7p0zMCbkRBnvln/9mEV3dG4w1Ful0=;
        b=EcGxR2KDzLoJM9GafO0U2/do5/5H6JuMdbTKLYicen2wIHGfmKirrlbXOF5EYpcEQe
         mWPVmM/W43ey9M6ogRlQp4M89huelx5JODzjMC2QXbAF76MEwpk6o17EUiEiHpBe1i3v
         7pYrjuJjoQHjUiZgmlkNVkBTltFVh8JBjHXZvg13qJxE5n8noaMqJlSUKEkWy3oFxsAg
         8D+XrwDhq3KFOr1rGsy6XrCmL9DtfEJNVom4OhJItphWOAnpchAQ0NOHZP/UbUZClPld
         BFr3hxgud+VnBg7XGCA6xA0dOYHNU4g/SS+38YgeiUDdJ3GDO9MAYYKDZsJihFLOKn5g
         HiNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783923179; x=1784527979;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Esj1g2bG213H6N7p0zMCbkRBnvln/9mEV3dG4w1Ful0=;
        b=DxUIrqIK0zrZAAInFMlwx1M0KbdJPZfJfPnHssOBYoe37HJUhSgiQP6/vvDTZUxyJC
         OuSaE4mWctqGLg1vWZUU9dWenSCM1HeHldPtIEZ2FAaTNMSccmFxWfwcCAZRODySDnXJ
         yjneRx0RJ9/T90NTWcBnZDbm02PhE7FF2CRF4szs4oAqfbEObtX6KcWURA11f6ZMSlrR
         LHtATc3D39OzAmNc+xOyvcHGKwr76v96YDqBgJiVJ8tcTQ2rU6sCEY3D/JBg6z9vGvbj
         vPJGI/BbyUFqwXis15YD10aZ1vptEYvGj7wITM3ZgG/VyVY73x/AAodmfVJwgb0XmH8b
         rDxA==
X-Gm-Message-State: AOJu0Yxlr8f8QhOPB0Lp9S+88ETM2n91FSkpeod6o29iI3OpZDjZqJEK
	3dmQRTeBipDrEllGj9L0IlWmdXILeKEERE6pZwLKBSz2wn7TWPsqN38JjmsF11Wz7pAjHSONQcI
	nfN52m8cWEvfZFq0+8sUghPAOs0xgIqDLchuSRKK34XjjZrHxXLZ94c2nDgTks/qfdaSdUQ==
X-Gm-Gg: AfdE7ckFl5Ap4wQC2FeVQz2ffWoOT3guweQzhKOsN+1GB1TL9lhYAOssr2laztOoDF1
	DR7Vrh6I3BwzAPnkiH1A5f4Q8r/gmi9jE+vcQAvMas6933KHo9qbUPt2rWuzFkU/LNc2fEtf4V+
	z78ZKJLY4ATtIVSIMTikrOLMkPUCvAiWw5zkg5TkbPKCYpRe6Vg0aVBomATbOY08lk/koEbxuNe
	8pNX1qeGsHqWjYxsTvvN6DFmAdfheUY3gMIs5JHpNZRzzMIBOkLLCNJ8gEHG2rc16Tdyxll9HtN
	XuAEVEgDfC0S4ITP8M7pfi86YZZEdWi8UjVyJnAL/OxswHZI15eEeOOYCcIVf/YQaotU53DyPgc
	dvBh48L7K26RnHEecibCX8CEic6Ei5nHulwTNeeAwUa3ACJmY+dZlWJS8s05+V1jxKuk76EvXBx
	VDYzCEp+8=
X-Received: by 2002:a05:6a00:1393:b0:848:536f:4236 with SMTP id d2e1a72fcca58-8488ac9f361mr6774371b3a.22.1783923179115;
        Sun, 12 Jul 2026 23:12:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:1393:b0:848:536f:4236 with SMTP id d2e1a72fcca58-8488ac9f361mr6774353b3a.22.1783923178657;
        Sun, 12 Jul 2026 23:12:58 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6ddc974sm13738668b3a.60.2026.07.12.23.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2026 23:12:58 -0700 (PDT)
Message-ID: <8672d283-fb01-46ff-8dd6-b1d9bd3d17ca@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:12:55 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: Set
 IEEE80211_OFFLOAD_ENCAP_4ADDR after tx_encap_type vdev param
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260701182428.906441-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a5481ec cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=sEHCxLyKOP1LC-VHyggA:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfXysy4xCONIpeX
 rOCcav5LN+isMIlDpGlrVFcH1Lp4FvdDIvnOXrwfQ6SQq2gYKnzsWijmmlSWA0y167yb/ZtO+YP
 0cPVrC6V3+2ugL/HC6xIQ42dmj1KriU=
X-Proofpoint-GUID: R-uUezQ5Qs4fk9CJqOEHo3Xgopn1ODO3
X-Proofpoint-ORIG-GUID: R-uUezQ5Qs4fk9CJqOEHo3Xgopn1ODO3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA2MSBTYWx0ZWRfX4hFBnRJbxbyV
 NwMoH82mNsrGhTU6y74qjpHhH2yxXl6De6kCihvnXZgDwUpt8vL1HM99UwDbX4M7pUdx/a41u+F
 goCENHh+b2PUV6NB8DhR6//O7UD52FAN5zi5GWaf5vkgvObb0yXQhxkMVUOFt8/HLSiWr4Q75/y
 K3REh/2Bm+dblHyiubiqCvLgO+AmWyJpR0wJj5a+fcUx/vpoY+5pIRsrLGSoE7LsxoyIHh8tmXa
 ssXkUB4h9UgDHBB/9zI0QyBxhMWXeFbAtnA5GcAnxLTV8fpk1OsMs6kc7DLOARnl3KDthcDByQK
 1I5qFDAK/HTQAoIounEDSC3356es4GTs4st5OCvC9aKaK7XX3LerF3ykNe0K1mMGEZvzp3lGlE5
 IPpA5m63Zead9nqR+IUDaB8MEopQj5RQprzeK6O2RickuPn4AyNJN5nxepwmPIVtAPxRuf9qgDe
 tS7M+LdOG0TOTDX9CSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_01,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130061
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38936-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tamizh.raja@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A7156747751



On 7/2/2026 2:24 AM, Tamizh Chelvam Raja wrote:
> Currently, IEEE80211_OFFLOAD_ENCAP_4ADDR is set when
> IEEE80211_OFFLOAD_ENCAP_ENABLED is present in vif->offload_flags
> at the beginning of ath12k_mac_update_vif_offload().
> 
> However, if the WMI vdev set_param for tx_encap_type fails,
> IEEE80211_OFFLOAD_ENCAP_ENABLED is cleared but
> IEEE80211_OFFLOAD_ENCAP_4ADDR remains set, leaving the flags in
> an inconsistent state.
> 
> Fix this by setting IEEE80211_OFFLOAD_ENCAP_4ADDR only after the
> tx_encap_type has been configured via the WMI vdev set parameter.
> 
> Compile tested only.
> 
> Fixes: 729cad3c3c9e ("wifi: ath12k: Add 4-address mode support for eth offload")
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


