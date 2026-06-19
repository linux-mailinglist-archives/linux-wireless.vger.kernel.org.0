Return-Path: <linux-wireless+bounces-37929-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /1AFO5yLNWpUzQYAu9opvQ
	(envelope-from <linux-wireless+bounces-37929-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 20:34:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A06A764F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 20:34:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ISUw+mBt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AVPgxVwj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37929-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37929-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3790F309E2EF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jun 2026 18:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999E133F58C;
	Fri, 19 Jun 2026 18:30:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665552C9D
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:30:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893835; cv=none; b=W2tOWDIWtyo2+DgrGuO2VJ0V/pmuh8m5hLjVW93L0jwhHKLn3agOwt20RdzDtcafGLSDuQCgf2/3kCWZ48NDfd5QnUHbDxPLuPgfy7MlS6Daa5rcqKVScX0vwG5JSeUFQ/34vm5mMO9PyQ1yMU9geF74C+zoG8DUa9atdCsMYWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893835; c=relaxed/simple;
	bh=8Mf7pLCSYMTCP0NjURIOvA4PHcOIvALkjbDEOaTBTYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMc/WMnW7IfFDWjXXAXkKeozM4mstVq7/m62wlcOfABtYzdycxQl2ZgiFJqjyiQQQEgfSVaTLxDQOXBj4OZiaiyhpXm6RFJOyIKsLHIvT4ZArYEzm1nVRAHTaF1GXz3VC9VUvf3X4WaFx5vIZqdZvNufENfS42GZ3EYFEOUxlQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ISUw+mBt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AVPgxVwj; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JHSj20736771
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Avbh5upeI5OaTX5yqy97LarkLggUeIf2fKq66mXSuNA=; b=ISUw+mBtlv4gzPOO
	UjyfOZ2lvDHClG/XOdMZ+MS11FGddFm5KK3DPm9waKDBGvaRMXvYj5aXl1LQdFLh
	GfGN83u7ebnt6tvkUSjqX4lNng8qBWOuoxkhFuv529GUaTeJ/xeicXagcfGkTQzf
	9zQ3R/keRrC/UNskmLe5PMDJeDYV1AZaCjSwtwWJ280yXaMH/sNXRkuFny7NMgBc
	xtMX9XvMMQxp02rSWNqBuXW/f9LdkHGs5CONSPP4Pf31Zp0CV1IhBhnNzcShAfap
	mE67PKA/5XN1/VsG8xzUvAWaottHHZwwCVdd9+Du1x2BxdPpIQq4ZIMxs6v/wyd6
	ZyzjXg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evkvf51nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 18:30:33 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36e09ec696aso3946648a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jun 2026 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781893832; x=1782498632; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Avbh5upeI5OaTX5yqy97LarkLggUeIf2fKq66mXSuNA=;
        b=AVPgxVwjH8yHAOxcy4vhlY+uoTdXSp126MiyUY2PJAoYWcWguXXN0AU3GvUPzHJi9Y
         pXSd3ztFbqxgHm6NrBrQrziKvQ7nQ0zL2l/6wYxadE8+1HDVFWwMTX7NHPi/isUefhQA
         ADOe2IBYmFdX+C7icbeBJeKSnf5W3nqWrgAuMncK+5miIq7XeNU+yjtPWeubTM5AuECo
         mbsrNDvyOmqD3t6XDSfk9D72IB+jysva+JL7Dw/v10hltI1+q2WR/8dncBwJbADYL4zx
         p4HhJoA7cgFpVjAMhdDHzkS/WxDmo1WOkht5kTPQB9Iu2RwENdqoOWjQFeZeI22M+9AL
         vuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781893832; x=1782498632;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Avbh5upeI5OaTX5yqy97LarkLggUeIf2fKq66mXSuNA=;
        b=epWUeDyxU/DYrIRJrbdcLGzLm9kAM1gV+az9yTkTCbDmwhs2BbO1uPbgflk9wsifXs
         bQ6+VOq8r8DYM6/y/puoiQJgr+kGjycBgxNgKy+OTi2avihIVapLbB0OyR0928XP9yy+
         MXlqSg55cuF9FrqM3h/pO/R4B3cuu3P64WGndaEVEHW9zfnezHr8kG0alYM6JDu14vQV
         StuQElVmLTr62yTR82vPaeADJ3nRXe2bqJVeQ50p1TAaQXV0QSvaYFVcZ68WVb4a8WLc
         PCtChKBc8V0A9nVo+zIbiOdbCtaLU/AjoM2xytU5Ok2SEMRuJPIMx85UMSF029dUStdm
         KU2w==
X-Gm-Message-State: AOJu0YyIjJOiQYR+tJcI5JdpuQUNEGFgHmDc1M6JCkxDnn2iD6M++ZJ0
	TvtyfhUOeEQOWH98GB2G4iGgxkkF5eSunwfgmGBOb6yPM8ke+o3pDcN3PFdwXYpDXNs6ZNDCqvK
	H2CCQEfwa+3daULrUAKeJXeVtACUA2i+xz9Ez5fesgKrzbw0sX40IailmGveNiiTDP0iUfg==
X-Gm-Gg: AfdE7ck1ESmbp8Yhrs/wd1ik9W9H8oXPL+WB0VLsD0Z8XU5wG7mnmOXtquDnh54+kAS
	4cTvW0CBBkeoadcV+2OrpNfBLsrTn1u2HRqwIRfvFzBUqdI97E6NT3PpqG9y6kCyQQXR/AtqFj7
	kD/eGR6j7uNR4XyAUjkhNs8cz8zxYk+fTKTTXGDxchKQazCC2FvERKXaLuZJKyIqFcPLXIQ8A5Y
	gE9gsZYDLLJIs44FPlBdfRMT3muAZqvGBcsELsuL9aTCpXkxUL4MspQQGzvTt4mQ4SfC/iYBy/p
	DxuICBvW2+b694wsMO/ydigIag6cZP5u+FIgN93AGp2psBNKQRhNbdD5Y99TGaimlgclDsf8Zch
	7EJh7IfPHPAeN4vyBFasy+/gTkx6F9QyQb23GWCA4OgtSzQQGb6byHmo=
X-Received: by 2002:a17:90b:380f:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-37d160d9177mr4966539a91.23.1781893832383;
        Fri, 19 Jun 2026 11:30:32 -0700 (PDT)
X-Received: by 2002:a17:90b:380f:b0:368:af5c:5925 with SMTP id 98e67ed59e1d1-37d160d9177mr4966506a91.23.1781893831966;
        Fri, 19 Jun 2026 11:30:31 -0700 (PDT)
Received: from [192.168.11.106] ([124.123.80.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f2d2919sm235734a91.9.2026.06.19.11.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jun 2026 11:30:31 -0700 (PDT)
Message-ID: <95d1796c-060d-4813-824d-9826d49e4a9d@oss.qualcomm.com>
Date: Sat, 20 Jun 2026 00:00:27 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next v2] wifi: ath12k: add QMI capability negotiation
 for dynamic memory mode
To: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260619065816.2139392-1-aaradhana.sahu@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE3NSBTYWx0ZWRfX/O1rcH2rHypj
 i2wHe2Vpo3MXVnylgEewOtzvXsjCDv7lVigTGkeyfFxfGqLcZ9hT6ckvPjrITn8bxdVEz1VD4Ql
 lUO+cJoaft6OFscBlIKKdqINu0G9u1s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE3NSBTYWx0ZWRfX79qmNrdrxw9T
 hsjq0QS1R/zsAFDIX52l/D5NfhPIySUk7YXZZjVplpyMcurbWmoTvdpYDEauODm2XWOl8F+i2ha
 kYiyBVJD5L5eqzEiMeLZuhD85eW3hrwxJN4uUQqHorxZFjPcQm92mt3ngBP3/gk03stgBnjzAUi
 a/9s8au3zrDBG/YbL81RHrTlCisvn48ylueqnmQ8ZqLehJnwGkVk5RqElr0WrmLB6NJvEpQ23n0
 xBdDEpHtC9cBBbirUYWuuQu+kyMIiDE23QJh9Nh49oUOn03Naqqym9oQ0y8uCmzbnDc4NW27ORo
 UqexqCW4hA7PoW6klFGNO/HJZxaxe8zyPuy5EyvZ7VM6Vs3i7YY/ImgbPK/NYhLg7UGnw93G252
 40dKhcE0VikLC2sVPJq1zkfBGKKz0sacHbrKedignFeDD0MKNJxWbvVXa0KS0tuZzpCN/P3hAoY
 /Vv/D8etjvMl8hbUMMA==
X-Authority-Analysis: v=2.4 cv=H/3rBeYi c=1 sm=1 tr=0 ts=6a358ac9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=kllYWVK2JqQtNyhMtAlpJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=vXOABIWjEGlRoqXTTScA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xY1KH7b5K9oulrDAQ18qat1NlETFGXds
X-Proofpoint-GUID: xY1KH7b5K9oulrDAQ18qat1NlETFGXds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_04,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37929-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:aaradhana.sahu@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4D8A06A764F

On 6/19/2026 12:28 PM, Aaradhana Sahu wrote:
> On AHB platforms, firmware operates in two modes: fixed-memory mode where
> firmware uses hardcoded addresses for memory regions such as BDF and does
> not request HOST_DDR memory from the host, and dynamic-memory mode where
> firmware expects the host to provide memory addresses including HOST_DDR
> after the Q6 read-only region and relies on host allocation for all memory
> types.
> 
> Introduce QMI capability negotiation to support both modes. Add a new QMI
> PHY capability flag dynamic_ddr_support which is advertised by firmware to
> indicate it supports dynamic memory mode. When the host detects this
> capability, set the dynamic_mem_support flag in the host capability message
> to signal the host is ready to provide dynamic memory allocation. This
> triggers firmware to send the HOST_DDR memory request and use the
> host-provided address.
> 
> For backward compatibility, if firmware doesn't advertise
> dynamic_ddr_support, the firmware continues to operate in fixed-memory mode
> where firmware uses predefined addresses.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ5332 hw1.0 AHB WLAN.WBE.1.6-01275-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

