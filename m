Return-Path: <linux-wireless+bounces-32435-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEppO+vYp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32435-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:02:03 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 587A11FB5A6
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB910302C6E6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC141C71;
	Wed,  4 Mar 2026 07:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Js9TCxdo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TaAOVVc/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19623368BF
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772607720; cv=none; b=XlmL/puRH3ksDFogCuY0QJM7cWfS6ObwapTG/SfLX1E+U2fI5TDO9xQB7KQqN7Uu5q/nJ1BYVRdJP0WFOvLHWYapA4pRRUm69x33aIHuVMbQMegF3+s0COsr7CjKe3u/AIh2E8/CHq4uBU9GwC7BpNZ71J/mab0FdX7vl8hpoI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772607720; c=relaxed/simple;
	bh=fqEMrqKee8ednJl/5kkRsAYnLpaa7zU/rYuIHF08lRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5j/NKNlBHMfCMtJSJY4BapVZ7W5VIILHZRZzbXhuWhA6TGZ5nQr1sQ5NR9qj0FRZbnlRMSJDrPR4YkVn3xBoe3Rz+Xwi3QXzOLYhHAyNEuQmNhXM6ST2C1XMa8wEfqVuO4NP6DYMZnfhRw0kCRkgfjXVRESVc0ChBLSWCW+gPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Js9TCxdo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TaAOVVc/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245ScQO957475
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:01:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NiyhfbAnlkrRzOYJtZl2yOKSQKSGIPz0JF/pTZv4Q9s=; b=Js9TCxdorN+y5OIt
	9T/2lyotKgV5iCFu5QK59nwNU3Zgr2QkVdw/BkXf1dDqVODJJgTUtJo39C7NnGoC
	7bK8sXlAZ8PS3EcZkmrnN5Gvv8LZorkqfYVIvAsBLwMhz/3z3G3Fn/4RY3wslWzH
	EHQ2ax5b03k8loJbn8oII6vznjdphl9wNOaDyu4F0WETpGXpznrPwYMp2IBPBLfY
	XV5OM49J+gV60hpDPEeIi2JLs3wthflwxtO38bSFaeqZtyEVRgkYnTQQ3He1RFXm
	h7DqfWfUmFOF5H56bAAj88DCIftptrEaX1ZMU3f0geDWs2O8JOUzn/sazF0kStKW
	end8Xg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp6qg9rtm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:01:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35982c5940cso2652756a91.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772607717; x=1773212517; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NiyhfbAnlkrRzOYJtZl2yOKSQKSGIPz0JF/pTZv4Q9s=;
        b=TaAOVVc/2u3m4qtexWatPoLJtl2lc2gERnnudpE+8IBXOT+Ybu6A+n07be03nlLTH5
         zyDVCv/sr9oV6ATlj7wOjQ3lBFv3ZF2e5nKyUH4aje5gxTpkdFWBDrTv0uzIu5GhiIYn
         BYo8ky8BaGBEv02wzHpLrpDIWX7VYb5Cl2dDOG36EQoOwsDq5JHPOAVPeC+g4ulLSZKH
         xKbQOccPWjrHsoIhS9cypl7bWYQ69xipBj0Dn4T0yRgeNwb/S+5aP1HuwC7zl5cBvRmp
         w72YmZMNEk5TPTk4Exq1G1CwEw6k92jA+RWrUigJ72yiTv+dXogvSGcYJwx+XKRRiF+a
         XBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772607717; x=1773212517;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiyhfbAnlkrRzOYJtZl2yOKSQKSGIPz0JF/pTZv4Q9s=;
        b=M8sjTX+e2A15EechLH6/BHaBlBeWcfbgSLxbBbivJT0ZquQ7J5/z0JcdliyGOhGtnS
         yrjXH/I/dr1BjJOBS9QYnf/dxiMTBrc9zy3VRFFjl2176gyJpbVv8yl+JV5J+E2bptTF
         ZHuHqktgUlSuu9xkrDjQwGVEKl/OyB7HwaVzX+oQANkkrmY4xUCJpDS3a6BvqKt5tQqO
         aHGvBWZXU06PyAzS/s++ceZgwQfPgNeNObVwQ09IeCpCunPqMHk5F8IbrxRbAe7SZx8W
         f/RE961K0CpA8/K1unFgqYZ8YbnJJ/pyHSOFA5a6uf9FbOc/586fFdFrtjnnBbvAFf86
         uJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDSgFDlIZJzH/rhp0yLgDOjg3nP5zh/ca9WBgp63mSf7QUjK0deMo7hfOwTnlEvmb8kQepuioHGoF3XHIrdw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwV40Qi7+5QjddWolqZQTctFxFke54fpfVBAVTOLmjuvDxFWXNc
	te2SDkkobzbSjdGSOFIx5E6PKM0JXD7M4fWlMc25Xv8+7eC3XDh7QSOWinP8MXVRTlTI9PRpUTC
	ilprA0FXY9oB/Bdbj0xJMSqyLEtNr7vuiGqI+Rj5jwK1DWEBuXZm6v0z46Qpkww7xKD4Q
X-Gm-Gg: ATEYQzyoQocCCWYw9PPljtGaDWmJGPfh7Ymg9Ll/U8fKq0uqEXeTzMTPnLET7Ijx9aY
	hriZAZ70DvJdMBEFy358uiIMI83XAPkbk6SID1NNPIwFEAED2XSsfBQLEKox+0qn0TsWZPb1sx8
	zgn9UqpfSi4Yf+XqjkuYJ/80VuVl9q3iQ6tPc1zsQ5gzC4Rd2stBnbNWyQvA0gRp3V0kVLu78rO
	vVeAXu8lVQdEFqCs4WYKYSbiXpPMAKlCci8Gtwxoy2Ytj44N+u28TDlwnTTKL9EPfN+Qazjxrjy
	Szie8xJ84MSFKm5V76/L/m0f85Ri0g5XkVXXk22TAAQyixw+94odMvtVQpAGF1h+dlir3VnjjXY
	M6aUMyhZi6iJQuWipAqUxWnL75THqfCLuxyl2AknnoXmboNda+tyk
X-Received: by 2002:a17:90b:2c90:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-359a6a66a89mr983857a91.26.1772607717489;
        Tue, 03 Mar 2026 23:01:57 -0800 (PST)
X-Received: by 2002:a17:90b:2c90:b0:358:db7b:f686 with SMTP id 98e67ed59e1d1-359a6a66a89mr983839a91.26.1772607716964;
        Tue, 03 Mar 2026 23:01:56 -0800 (PST)
Received: from [10.206.98.136] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c07d40dsm4234163a91.2.2026.03.03.23.01.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2026 23:01:56 -0800 (PST)
Message-ID: <e971a8a4-dcc8-4484-9da4-513c34a87c0d@oss.qualcomm.com>
Date: Wed, 4 Mar 2026 12:31:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Ranging support enhancements
To: Lachlan Hodges <lachlan.hodges@morsemicro.com>
Cc: johannes@sipsolutions.net, linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <gxhpubndywl7jrqb6rmvta7yzcyid3drr5jtsz6xfiel7aiaig@q22wvfrfo3ik>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <gxhpubndywl7jrqb6rmvta7yzcyid3drr5jtsz6xfiel7aiaig@q22wvfrfo3ik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1NSBTYWx0ZWRfXx15ZmgvDwRWD
 gxPPYh096c1Zg4t7xl1RG7Pdq+3YoZCQGiXO52yKu5hjAdK/pjOosP+mIU6YiVySOqWcUgtbBQm
 X8W5R+1Jggn2CIY/+fKYdqwh1qZZ1eEqQ9HAle0NaVkFJC7CBjPiza2ajW7yYZB+XSPFVENZBCe
 OCWoAGeq3oCU/RhGl4Yefh3eVjHeiftSDQEYQ0cTu6KK3A+Pz86n9jLReIGVQz6OIamQWRJwFVu
 mnnZSwjrs/Y58KEa7dt8IKtH55fPcdIkgHhkNij29vD3EdthaKoZokv+vXxNy8jnadjN+i3g4CR
 6fSI37e1NZPnebNhnGy3KhVfRwXoE74z+bttC7ZbEnSq3WY1Qzx83GlZmA252EQDX03M0y9vuly
 kcgcTU68ZP9571X88bdTWsGju2KK8+zKW+r87wCljaEwdgHwASxDRe+x2MtWZDHLOGPIbAizpd4
 w+gWHL9EMb3nRWwn8EQ==
X-Authority-Analysis: v=2.4 cv=UJ3Q3Sfy c=1 sm=1 tr=0 ts=69a7d8e6 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=6dzjlLvKYtg3rFF0l68A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: uTX1zDIrspZrGKCUqQK4SpDKvneoiOnv
X-Proofpoint-GUID: uTX1zDIrspZrGKCUqQK4SpDKvneoiOnv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040055
X-Rspamd-Queue-Id: 587A11FB5A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32435-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action


On 03-Feb-26 5:10 PM, Lachlan Hodges wrote:
> Hi,
>
>> Peddolla Harshavardhan Reddy (12):
>>   wifi: nl80211/cfg80211: Allow RSTA role to be enabled without LMR
>>     request
>>   wifi: nl80211/cfg80211: add proximity detection capabilities to PMSR
>>   wifi: nl80211/cfg80211: add continuous ranging and PD request support
>>   wifi: nl80211/cfg80211: extend PMSR FTM response for proximity ranging
>>   wifi: nl80211/cfg80211: add peer measurement abort command
>>   wifi: nl80211/cfg80211: add role-based PD peer limits
>>   wifi: nl80211/cfg80211: add ingress/egress distance thresholds for FTM
>>   wifi: nl80211/cfg80211: add PD-specific bandwidth capabilities for FTM
>>   wifi: nl80211/cfg80211: add FTM range report negotiation support
>>   wifi: nl80211/cfg80211: add result reporting control for PD requests
>>   wifi: nl80211/cfg80211: add MAC randomization support for PD requests
>>   wifi: nl80211/cfg80211: add LTF keyseed support for secure ranging
> Could you not just have "wifi: cfg80211: ..." for each commit? I think
> having both nl80211 and cfg80211 just adds unnecessary noise when
> ultimately this is all within cfg80211.
>
> lachlan 

Sure, will use "wifi: cfg80211: ..." format, Thanks.


