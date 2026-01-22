Return-Path: <linux-wireless+bounces-31058-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGEECR7lcWngMwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31058-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:51:42 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6B663768
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 09:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFC265C7B47
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jan 2026 08:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61B4341ACB;
	Thu, 22 Jan 2026 08:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oVloIxpR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="giQQayc2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B9E326D65
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769071371; cv=none; b=l6Jw5AKumi4OonHysRF7B2IobUqE6Mj1xrKZCNpHtwlu4iVuUY9nkgwZFEJhKwh9nFiN6Godvkkwv4fEjKZkLE+ccdmy0zdgiM+kt+DrpyYmnxSXLjT8ozCP9RXvHO301H59i8mGiz/bV12bZy3scknDvutDnJFrADo2TJCzQso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769071371; c=relaxed/simple;
	bh=GdQrpX+rDeCNmatXQD+PpZCZ7rSryovCQH7c71Ub/S4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VPURMxkW5LCoMtU/94+IaFubzqrJEb9F3t+pmJwNsTEwI7q2kbhunXg93VL9p8DM3ptHllBBkLIOF/owCJILfWqfCgjcEsmOUoD6dEPcMD4H5QrphVvCTWmZ5dmavvzM7MQNt9yacozlgLJBaKBWMKGV0K0xgcaUVlNwMXakqTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oVloIxpR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=giQQayc2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60M7l6Vq1407051
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1cdGPB/S2sh1anSOPeZCSBZLuL/6UNTrZkzCo3aZvAM=; b=oVloIxpRMSeqbSG8
	Iri1wV5TQcsousRHai9UnyhvC7PXW7rX41xVtR4DJ7bt8/sX/STfJ7A+3ndZCXdQ
	fFe4JhZjS+EpGAVTLW143RRh1ljA3AoJ0t9a6pALxgIBEUEDx9X+CVsn1Or/qT3t
	hVoOSS1Ta+lctlZT9XtqNm6393Ohr4Q+ZRY+uuCJXES3DxrkGnGjs3bhZ9LjurRP
	tsN9174siafzCfGxUXPItWpQ8FgZSX/EPBrG/8sj2Z/vPKFym8pQvW4i0zGCQ5op
	tPIPrOWNNe9AQLxQHAYJQfqENlA22BwAp290iYzAHfcNuUhx/LwcQiICEeOh0HU7
	8lXrDw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bu802shjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 08:42:48 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12339e20b66so1016940c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jan 2026 00:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769071368; x=1769676168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1cdGPB/S2sh1anSOPeZCSBZLuL/6UNTrZkzCo3aZvAM=;
        b=giQQayc2Vh3TJ1m+3/JTvDIUvjo9FA/wtr9MlUeRZ7DH9Ue1tz4q8V1vQyGHMa4PS5
         V1+5JehOlByjTecVxkcGF7NYPGNgQ59IvOVwjVJbH4Tnt1EfVKW1VLbO/u8E+p0Bf/qd
         aIcCidLDKekYBc5Q49lfn0YXp9t/oebLnDJteB0MMM3ZCeyi1l9A5VUmJqiVj/D7sFTI
         4UmfbQKNhyYxuQr9PBu5uSj95k1Q2nWADnFNAO4ymf9F9tBtywkSRmgVt4h1zqhssf97
         9IbfbxAMSXUPDRsxfkhrDVfnWM0bdiodtCiR7PiLpqCCYgLwsOYJXYekp0KeMQ5abZKX
         JKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769071368; x=1769676168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1cdGPB/S2sh1anSOPeZCSBZLuL/6UNTrZkzCo3aZvAM=;
        b=hUbixhvF6Ad1t9S/Vi8flY5i126eyHXdbHaIbrHtUjBzwvu7Jl/SAImJ3gS0FssPgw
         IxkWqatidj+GMKqOv/xScNq4m2UYvtfnwQf+525q7kRpODNfNIIUvV31GqtUBcdajq1C
         cszQewE3axaWWQVBXS/A2PCinM4iJefZIuXO/dz3WMieaLnEEF5E1OSkj1dEfHzBeHKI
         MJ1lYO4BsTsCkBx9yBi+VgQMoc/64G7NNzK/YWBEjkZvSH88tlCwmWxvMrhqaKRHBvfy
         IZ5z2R9XZwGYaxPIN0Ad7zjysz/bb1cGwQ6UEeutt4InjOR+4T2PaiI8+z2T0u7MJ1kU
         8/Xw==
X-Gm-Message-State: AOJu0YzA5hMjIJKQaVTdKfNWmXJGVUXqVR3I4e31lhpifd6oQHEi7S9S
	Ia6QZ8LKMBD7IV1teN8ZU5VldIlY84luS0e0Q1bkPn6jWGJdDIVIJSi6TsJkJiZkaGwfQujL0CH
	vUSNbwljc1uSECnuovu1DCpwiTN8T0vOA/W1LvRVyIWLRDysFAI6O1OJ7frLv32OIiW081A==
X-Gm-Gg: AZuq6aKAPqBYGi9tO9zRWxM0p1VYSUhr3Spad69vIijb3wyDFK+hLEw04FpvRHQA0Jn
	+O4uUDLivr/25HPrCBr5HmuoKuuPz1pFKb9iFglbm4hDwMFYpcFBKoR4bUstyw1uI8VZYYIuHBn
	Pf248GSACD5+HI9J9tEmfn50XWwtvvLjJSMvXhy72PbmyCOHKLS5PBNvKvTaz8KWL1fv8u00XbQ
	S3vzAQTp6BBtTGo6IAxM9ksG3wSZ/q74J5oK12Ghql+UKacXOQuvXnMY78VEvu6m/yclPFq+wCn
	6BMX+3rTol+zrQJdZEfHo/VPTCym0JkYKWlRllzwPWiOt0xh8B0iHZ9xXOAxqQMuK0r6cUNLYH+
	WhsJm8e4bV10+ekof6/u+2IStzknutzRNHXwXE/EaKUw7g5ph+Q==
X-Received: by 2002:a05:7022:f96:b0:11b:65e:f35 with SMTP id a92af1059eb24-1244b3050f4mr11531019c88.7.1769071367551;
        Thu, 22 Jan 2026 00:42:47 -0800 (PST)
X-Received: by 2002:a05:7022:f96:b0:11b:65e:f35 with SMTP id a92af1059eb24-1244b3050f4mr11531011c88.7.1769071366797;
        Thu, 22 Jan 2026 00:42:46 -0800 (PST)
Received: from [192.168.4.41] ([209.237.159.1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1244af10e21sm30230032c88.16.2026.01.22.00.42.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jan 2026 00:42:46 -0800 (PST)
Message-ID: <88f05d03-2742-4b61-964f-54beafdd2e70@oss.qualcomm.com>
Date: Thu, 22 Jan 2026 00:42:44 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DESIGN RFC v3] AP Architecture for Wi-Fi-8 Multi-AP Coordination
 (MAPC)
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        ath12k@lists.infradead.org, hostap@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <653a4207-38f8-408c-8067-c4960c11a71f@oss.qualcomm.com>
 <05381371a41f154058429f0a1079204c4a454f45.camel@sipsolutions.net>
 <59cec65b29ded381c85d1be943d88e956a4b7e74.camel@sipsolutions.net>
 <63ff0362-4ee4-4f13-a212-dc1351eefe08@oss.qualcomm.com>
 <52356be3d21920d84579d1a8fd803540c6f9644d.camel@sipsolutions.net>
From: Abhishek Rajkapur Suryawanshi <abhishek.suryawanshi@oss.qualcomm.com>
In-Reply-To: <52356be3d21920d84579d1a8fd803540c6f9644d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcWbdBQh c=1 sm=1 tr=0 ts=6971e308 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=T8DXQ4rxpc9enYjWm433SA==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=6u4s4mMX8zNXQG3WQnQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1OCBTYWx0ZWRfX/nZZ3t7N4HT7
 hsXv4+BwYHL9z8RSlL0nbNGfzSasjgfGS/FOtHIa9sKi2ucfXIUsN/dGWyhBKkSjT+SNLnMuE//
 iky9KQjpOvHHClRyVXlQOvzjIGH3B8pzGl0II8antSyt0difMSuAJwayiVayq/iofuxNwAzPgkq
 Ehq2DA6e6c6exxp6Hul3Z8FnSQrc+ZrpcvbiBMaP98+zQ29LNHlRZbOB1R6FK/sGXRXq5PWNtYp
 HLk/SNkgouLjQLyb3h4tYZePe53p5aRd7NPvuxRdKyr4RkKXPj7Iq6Db71KvKAxBezW03MpsjMy
 lRNvBpeT8UqSXCwlaS8QXBYO678WhKpMnS1ZTcdXG6VS5ma8c2BAxJ9sp2DjqlUSi4qAdA74zgz
 1R3qEdZPfTtefEaIB5Q/B8jTfFOqJqUhPHwhncQ7SINmDaFNXNnpWZfGrD1tI59LVWcuRYMA8qj
 Ffb0zvOpOF7rF5dGXyA==
X-Proofpoint-ORIG-GUID: ZDA975HQ8VXRjekrtCwIRbEjSTFXxGaY
X-Proofpoint-GUID: ZDA975HQ8VXRjekrtCwIRbEjSTFXxGaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601220058
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31058-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[abhishek.suryawanshi@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD6B663768
X-Rspamd-Action: no action

On 1/15/2026 6:17 AM, Johannes Berg wrote:
> On Wed, 2026-01-14 at 11:15 -0800, Jeff Johnson wrote:
>> On 1/12/2026 11:18 AM, Johannes Berg wrote:
>>> On Mon, 2026-01-12 at 20:12 +0100, Johannes Berg wrote:
>>>>
>>>> Why do you always want to let firmware be in control of everything?
>>>> Seems at least for some of this you'd really want the upper layers to
>>>> control it for purposes of coordination? How does the FW even know which
>>>> other AP it can coordinate with, isn't that something a network
>>>> controller would determine?
>>>
>>> A less generous reading of this could be: you guys want everything to be
>>> controlled by FW, so you don't have to open-source it in hostapd. Now
>>> you realize oops, don't really want to do all the security handshake in
>>> FW, so we need to ask hostapd and then we need keys and stations and all
>>> this stuff. So let's build something nobody else can use, upstream it
>>> and we get the best of both worlds - others will maintain the mac80211
>>> code for us anyway.
>>>
>>> Am I wrong? Is there a technical reason for not simply doing MAPC
>>> discovery/agreement negotiation etc. in hostapd as well, based on
>>> driver/hw/fw capabilities, and then you don't need all these strange
>>> "triggered by firmware" flows?
>>
>> My perception is that Qualcomm would love for all the Wi-Fi 8 functionality to
>> be in userspace and nl/cfg/mac80211 since then there would be no code
>> maintenance overhead on our part -- just you and the userspace maintainers.
> 
> :)
> 
>> But there are concerns about latency, and internal consensus is that some
>> aspects of this functionality has to be handled in firmware (or even hardware)
>> in order to meet customer KPIs. This comes from our history of supporting
>> large-scale deployments of APs, and the expectations of how Wi-Fi 8 will make
>> things better. That is why we are posting design RFCs, so that you, as well as
>> engineers from other vendors, can review our proposals and give your feedback
>> and counter-proposals. We want to avoid developing what might be an
>> architecturally pure design that doesn't actually meet customer needs.
> 
> Sure, that's fair.
> 
> Maybe I can just ask folks to spell out the constraints and reasoning
> behind the design?
> 
> Taking this specific example, it basically says "FW sends a request to
> hostapd, hostapd does the handshake and installs the MAPC station. This
> is how we think we should handle the MAPC stations."

hostapd controls and manages all MAPC related discovery and MAPC peer 
creation part. No trigger from firmware for MAPC Discovery Phase.

> It never says _why_ and how any of this happens. What's the magic thing
> only the firmware can do to figure out it should start coordinating a
> given AP? (Clearly that operation can't be concerned much about latency
> if it asks hostapd.)

In our offload architecture, the firmware monitors various telemetry 
and controls all data‑path‑related scheduling. That's the primary reason 
why our design requires offload-based trigger for MAPC feature. Additionally, 
the offload-based design only signals intent or need; hostapd still owns 
MAPC peer selection to kick-start the MAPC negotiation. This trigger will 
be configurable (i.e could be enable/disable from user-space).

> In fact I'd have expected that in certain cases some controller
> infrastructure sitting *on top of hostapd* would decide which APs
> coordinate with each other, rather than the firmware. Although I guess
> if you hear the beacon on the same channel with a good enough RSSI then
> you can coordinate.

Offload based MAPC negotiation trigger is primarily intended for 
non‑controller-based AP deployments. In controller‑based AP configuration
& deployments, controller is fully responsible for triggering hostapd to 
initiate the MAPC Negotiation Request (e.g., via centralized telemetry and 
policy enforcement). In these deployments, the offload base MAPC negotiation 
trigger shall be disabled.

> I could keep guessing - maybe there's a limited space to do this in FW?
> But there's not even anything built into the design where the firmware
> can ask to _remove_ it again, as far as I can tell, unless there was an
> (unstated) assumption that it can just delete the MAPC station and send
> a DEL_STATION notification about it.

Like offload based MAPC trigger intent for adding MAPC neighbors, it would 
be extended for the MAPC teardown intent as well. hostapd will still controls 
MAPC peer deletion & MAPC tear down protocol

> The document even says that phase 1 is discovery, and then goes to
> completely ignore phase 1 (it's hidden in FW), and describes basically
> only phase 2.

Phase 1 discovery is completely handled by hostapd, as outlined under
section (A)hostapd

>> And apologies for the "firehose" of both design and code, but we have a desire
>> to ship Wi-Fi 8 products using upstream code. I've passed along information
>> that you want our engineering team to focus on the base NPCA patches so that
>> there is the appropriate foundation. But in parallel we do also hope there is
>> engagement from other vendors on the Design RFCs we are posting. Our goal is
>> to upstream as much AP functionality as you can absorb.
> 
> Sure, and I appreciate that this is coming. I'm a little overwhelmed by
> having so many parallel things going on right now, and all the parallel
> design documents don't help.
> 
> Maybe this is the point where we consider inviting everyone who wants to
> a room for a few days? Even a video room might be better ;-) List some
> topics first, present the design briefly, etc.? But I don't know if it's
> just the medium.
> 
> johannes

Abhishek

