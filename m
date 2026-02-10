Return-Path: <linux-wireless+bounces-31691-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIYwFykJi2kdPQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31691-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:32:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C07119AAE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 11:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87A3D302A6DF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 10:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8BE3161BA;
	Tue, 10 Feb 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CcZJhgZL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OclD7+hT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983843164D4
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770719525; cv=none; b=K4i9CfqYy8+7ZadI9ecdifUvOXDyNxa2w67XqszcdfZLkiOOHjBaJIQmNuheMVsS1iOZtd+QKctf/52cnB2X6QkAP80wazkNoUbxYBxDS6ontJuE1zvZCilHp8n1UKu9kQSU+VflQpluy7WjI6oGWlcTGOkqUsshyiSH25dmPkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770719525; c=relaxed/simple;
	bh=Ca/Qr+os8S6LtQQC/tLZHdOMbxaAoeKTV0AT/N4i00k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jcNW+sooQneAXJbi1F4vnwI+zjbpXh2EbtWvX8dr9byZbAojc4RyDvJcd2/8rEyECJYuVNN3U4ItPx9wg4o+ASXGEdWUtcBuY+n6LMPmvKpJ6cMgf8aoTmgv7pCUL3jypc/o9mKF4QtwTzs/vnHONlkwFDy83JVJZRwwvNTOxJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CcZJhgZL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OclD7+hT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61A6vqG9441421
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2EwhTffyFScRvtp9KcmjEQdJygJPQPC6KJPYRlXso5I=; b=CcZJhgZLAYWVIzTA
	kz2Ci9iJQ/3rch5CayDkSWr7LVHhu4yhK6h5mrBMCQH1xb/m5JfGxZUculWiDdFs
	tODX8uPraxN+R+a4Pfu3fy39zTbEQEITP4+nPxDfa0PVqSizEpKfXinHunrgDhb9
	gkJcSK4Y0SjQwnZ1HgjI/utu2YokVfmC5hIU/9lQA87NwFU9TFpBDBjf2a+1tkEV
	uqPlqgTqM5UKiM8EetpgA61lE4BrF2SRpzptl6W7iDHElW0hr1ZPXKEKmIMpi1wN
	h+t8Xdr8fWTzRdAzxnx4uzDAWFsUCVAs69YaZIf7acahXY3liYl1ET5dpGidcCPV
	3m7ikQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7qp9j855-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 10:32:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-81f42368322so4281639b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 02:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770719523; x=1771324323; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2EwhTffyFScRvtp9KcmjEQdJygJPQPC6KJPYRlXso5I=;
        b=OclD7+hTlQbnqQJm9hUoCcylf3BABGbikNeuB1XmHR6ZwGDyq00f+5AY9PbKLN7B+j
         xgPCAc983oplLuF3ubjTNDhg8/lcOfdwloT7ZtyyXTfSDSoJz4qiuO1l/sUis8Vao22c
         zfmqxnx5zuF2fH2SUF4X7Ao9uuEv0ntLgsQtES7QkAAAm9h7Jj8F3NS2ro45AVSbRPBd
         IVQsr9XZKlpoi8/dnUOMzpIOy10eGtiYtIaWOglw19F7XFAClNfxagXrzUEFHxLgQsrG
         WOXF4UqospnwRC8C7CMZ4uqDBPUswGSXhA1mHchLXRC7DSV8cUipKam5MzhZOpxQFjLb
         2vEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770719523; x=1771324323;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2EwhTffyFScRvtp9KcmjEQdJygJPQPC6KJPYRlXso5I=;
        b=w6oUqe/2F+cV7cs9ClWyMAG9rdDMMdtrSXVPiinx2jcg9BcAOABLFKQtfVj41ujqdh
         QKDZj0omKHNPqbTk/M7mi0wCIuYBIKmb8ysUDeSr7PdlmMslMULadqYNsLQ0y6YP42xg
         ix0G+4Pb4+g7jnYvCZniqUkwxEU94xsggeWytOHCAbX3Yu4PV7V1ZoL+WXjnvN7uF/fY
         Oxz6eGNsfycItfI97JNxhA47QqgczCMahh6vojQxD4ootT2C/e7llrjpIPsHUH3Mwj2m
         1ptFwkhtJ5RyE62khKbWghMfS6bAiSYRu66t7RHGjIDBC+QdGT0vFvTeSHuxpnuj32iC
         FxOg==
X-Gm-Message-State: AOJu0YzDritQAkhWcsb3KWvd9GC3obCjffUKile5j/WFRwQqZH1YIGAs
	K+LZGVLVFTgnpGSyNpvOv8St4Ka0Wbo4ejInwLJOfKh1+swkdwwWclAlYMdcb9RA88/XGNl9fnj
	yhF8UjowL676pqeq0EGBXcwEeTA6VO8HeMktS/A2iRA8cfC98Px6l2n8jl3eRUfkdFl6A7w==
X-Gm-Gg: AZuq6aK8XZ9Z+GqqQfd3XdbFOAm469XuKRgoAW/rbJ2G3dFqedFAGZ1UzXLX/DHwcO9
	tou2FcIJVvKo3V2OiBG0DGAso2sE+DT/jQfw0CAkWiw9nZBFphGZ1fcf22qkcL7yURPhUrlvY4S
	vKcdY94VL/oVxd9+yMNnNkVxm3KXsCqkVi4NRAqzXBmdmalFfvqsaaSL5+WyL7nFfGA0Pf/cEpV
	A0/ab8J6bWLXP430Dyhz0844pQYu/sq7R/0AXRnLOjTbI1F8W453zvQO7+YWt3ZTcm0awTxVjYP
	6ZGsrG1F9SchcwzT/814afWYHh32ELq7Jq5B/MCC9QddgKxjUxiPc0WISqF3ZqhATjmoqRgRE//
	duwORB26DPk3PR17erqleHxTs1ofHsmF4n9yvNJMamt+huKP6FuxbPTZNMVjm90Y3gh0cg05X3A
	9z9gFNwJ87V8yxpRlS1kK3E+BQrFrto0Fr
X-Received: by 2002:a05:6a00:4215:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-824416e3e25mr12022998b3a.33.1770719523012;
        Tue, 10 Feb 2026 02:32:03 -0800 (PST)
X-Received: by 2002:a05:6a00:4215:b0:7e8:4471:ae55 with SMTP id d2e1a72fcca58-824416e3e25mr12022976b3a.33.1770719522513;
        Tue, 10 Feb 2026 02:32:02 -0800 (PST)
Received: from [10.79.196.209] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8244166f3edsm14055044b3a.3.2026.02.10.02.32.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Feb 2026 02:32:02 -0800 (PST)
Message-ID: <333cc057-f393-48f8-a5bd-de69a9c46b03@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 16:01:59 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v4 1/3] wifi: cfg80211: add support to
 handle incumbent signal detected event from mac80211/driver
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,
        Hari Chandrakanthan <quic_haric@quicinc.com>
References: <20260205112146.3997044-1-amith.a@oss.qualcomm.com>
 <20260205112146.3997044-2-amith.a@oss.qualcomm.com>
 <f28034e35e7b1e9c942de3b78a8b03de9e2833cb.camel@sipsolutions.net>
From: Amith A <amith.a@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <f28034e35e7b1e9c942de3b78a8b03de9e2833cb.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: vfMmKEkJpZfiftsKmVxAbMYPB6y4Cqux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDA4OCBTYWx0ZWRfX8IQ9ZBfaOoHn
 RO9Rzvcb6OJoD/Qw3Q5qKwoGdRWZ8RBZj+nKl5KEX4PbUfl1K9lxP7bjRbo1ddnpvTtC41ZP9he
 oIMxtGIjPsrAKXvn+CxkVO/tQfoWEVmX1179PasCRfjHhZ7AztEgbMoR1336aPZCsITJJg+Z3Na
 jlU0Duh0hlE+WjEtLNpVMVm7FGYnbQnjKNAUkUAJTBmW4lehvITQC80sobkGPWf2VvEEr7Hh3gn
 4t97G5a+aEXSwf20mgABe+lytt2ukslRMpI23T4NCEnL8opol3Ouq/A5tdEcrzsEKEhSoQpYOjx
 CY2vs3scPLgMD7tCEBioOvERN5NnlbkhLr1tjWkFsXNLO5+RqaCta9GcfLb4jyYrvdZqktIQlGL
 pejlNzEwqjNtiSvB6Ka4lMAXIpcAu5HyYg7/WE63nQX34KhFluVV2TvpvsgxRv986axW0S2kWZ4
 yk5k2IsooA6NsRFoPow==
X-Authority-Analysis: v=2.4 cv=dP2rWeZb c=1 sm=1 tr=0 ts=698b0923 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=Ez4E2TKNG9VtMti-g5oA:9 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: vfMmKEkJpZfiftsKmVxAbMYPB6y4Cqux
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100088
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31691-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B1C07119AAE
X-Rspamd-Action: no action



On 2/5/2026 5:52 PM, Johannes Berg wrote:
> On Thu, 2026-02-05 at 16:51 +0530, Amith A wrote:
>> +++ b/include/net/cfg80211.h
>> @@ -10423,4 +10423,27 @@ cfg80211_s1g_get_primary_sibling(struct wiphy *wiphy,
>>  	return ieee80211_get_channel_khz(wiphy, sibling_1mhz_khz);
>>  }
>>  
>> +
>> +/**
>> + * cfg80211_incumbent_signal_notify - Notify userspace of incumbent signal detection
>> + * @wiphy: the wiphy to use
>> + * @chandef: channel definition in which the interference was detected
>> + * @signal_interference_bitmap: bitmap indicating interference across 20 MHz segments
>> + * @gfp: allocation context for message creation and multicast; pass GFP_ATOMIC
>> + *	if called from atomic context (e.g. firmware event handler), otherwise
>> + *	GFP_KERNEL
>> + *
>> + * Use this function to notify userspace when an incumbent signal is detected on
>> + * the operating channel in the 6 GHz band. The notification includes the
>> + * current channel definition and a bitmap representing interference across
>> + * the operating bandwidth. Each bit in the bitmap corresponds to a 20 MHz
>> + * segment, with the lowest bit representing the lowest frequency segment.
>> + * Punctured sub-channels are included in the bitmap structure but are always
>> + * set to zero since interference detection is not performed on them.
>> + */
>> +void cfg80211_incumbent_signal_notify(struct wiphy *wiphy,
>> +				      struct cfg80211_chan_def *chandef,
> chandef could be const, I guess?
Will update in next version
>
> johannes


