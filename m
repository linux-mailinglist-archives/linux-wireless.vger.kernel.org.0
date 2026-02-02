Return-Path: <linux-wireless+bounces-31465-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFgXHMC9gGl3AgMAu9opvQ
	(envelope-from <linux-wireless+bounces-31465-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:07:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145A0CDE49
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 16:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 38479308899C
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 15:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2FB372B4D;
	Mon,  2 Feb 2026 14:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JDf16Nco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eQvtmaVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B937734D3AA
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 14:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770044345; cv=none; b=IJxMe5HTLZHAJw0Pbp4EO7zYUOoaXx6jLsR2sIi/DOlRL7qJEFTKOmPBqK2O841JJF3RP3ZURZ41pAwZX23gC0DnvD6ijtPyYVn9c/Xz4gJnPwgESemO2TWiYKiyJGcVFrTc8AJ7cWbXnAb8Z80frlpoBCIJ4qMohyGj9xUKL50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770044345; c=relaxed/simple;
	bh=ubppEABThm5I1xUctkd+0mBZdN1gwm1LLiwqS3R+RiE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sN8u0FOdlzqaJJ/kqz1P4goVOMVreSoTTM4WCyEZTJpOsopjNJYl08t22czGqF0onaHAVKYzBlWX6kehZKE4qhM9YTYINRt8YEpQPrib6VuXYv/FyiN62qiM3P2EtCmjwzNBNu4BQv9a8cvjr3yoCcjb9F0jK3KfHpm33NISVd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JDf16Nco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eQvtmaVC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612BAFup3082673
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 14:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mLPFwv3AAwyyP27oI++i5Ku5Yds+CxHyahu16/9DSFo=; b=JDf16NcoGUeJnhBw
	A/Ja3hdjllzNFuEsAJvW+EvNiIMdHIEPN8p0sQY3SaKkekx992KPTXtkaa7XknsK
	gErBdlcJQqYXQG2QyaLAj1KOBeYHEzZ1O51SY7VaPbhzfuGC1HcSphjQ+8iLMVIx
	uJ2apmnHpwZ+tXpvfXraAwPFw3CFXE3+XNMDLHaC8NtCk4yb5FJCGCJnhsWgxIgy
	ZkBi18rWhP+Lx/cEKqtvgf2lMCN8eFdYERYs3HG4b782xQnyWV9ezJqulrdT3ruF
	3Q/CqMpf6D+44fQnHmQVpWmxBox6Z/VaignN7edelWHyNlRSs7WpIdNE1gBZ1eV9
	a0mbwA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2ttn0khk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 14:59:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b71bdcd037so3166862eec.1
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 06:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770044343; x=1770649143; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLPFwv3AAwyyP27oI++i5Ku5Yds+CxHyahu16/9DSFo=;
        b=eQvtmaVC2179eNw+lbDaeodlbFs4rdcFdhNWJmQfBK0wWJFzWI+sjz58KHvhWXXdXg
         Xo5o14mvtW1owC1v8OC/1UPcSlgIn4TZlqAQLzvvlwjOa2NJgNs+l+iJD9yQvsOChlBC
         G99Uv+PZ+oXggHu2Z6w8U4vz/SQpk5sQI2v7X09/q7UQj38qwZYWtdH2uaYQV/5JC8KT
         2uuQ/4FxTMCp58R2QS0eGADOyakAWZCzJM/WyW0Mc3aGsc2VzbJBWcrCI2Ipand5nk0F
         KiIB0/gOlb3syscuDftpXu5p3SQZA4kYbzGhwnbD8jnA/hGMZXNRVbgS5ZWB1gaRq2g1
         LDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770044343; x=1770649143;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mLPFwv3AAwyyP27oI++i5Ku5Yds+CxHyahu16/9DSFo=;
        b=kS/Xlpyu9Y6shSR8lgi4RORFAloJ+hs/XRWpPshULI7vWtA/8s53BEiGJdbeMI017S
         DGtZLoL17s8dK+eKHSiAngkpKUZUBpq6AtWHaOTgYA5DfHD6BDTKidgPNbC464WPpu5X
         MLsukjcpoD+fihyy5ibYlikVv99za39rRyQtJqiUwhvpEN2poOyQpr13AjI7zXUynXoi
         L6BiU69DoNLyspN/EeQaF9RhGlny9h8qS9EeS3QEf46HKuo0jyl2ThOjaNjsmmMfeT/i
         HEK2f5KaWV/u8rKHlkyk13pG/syBkig6ei4BhwZ549Ymq3dcR9OcthNEzj9VIjSuhMhM
         2snw==
X-Gm-Message-State: AOJu0YwbZIGbBg56ExC/tmKQRK7Ocv6/ieVpQJktc7CoTf401jTZXCBD
	jMm5mOl5yOljUQAMljMUEHYFkmF2uxbxFl5gHWS38puqwD1zjMKlcs/Q9g/3Frgsb1V5Qrb9Z+D
	hQiMmJOQTg+1K3buotdG5SIoKbbsSFhemytyAskPhAThroBXh75BTvfefC2EzwjzUQv2saQ==
X-Gm-Gg: AZuq6aIFN4unPJVaOyD+GKT9Pi+EDFTWsbXNmm5NdowPKbVWYPHCZF3i4LJWrxy40Bc
	eTq4Nujh2AkW2gjPWntrX/AcaDOaOpZLcSfondsoVSQD0AQI+k1EyZ2TLBtKg5/me8UxVPEgGHV
	Yytb9aqAzcgOcoOz4Wn/hjfPVSAdKT6Uc8ZsTkymHHZDWD7QERquqluKxIzYygzPcWaO/CZgPAJ
	gAVV0EaU7c/GygZaJCDwhLKU/Gx2DrEfigjtDKzdrtyf0CjauKL/rC2hSI458iC6wgk/pNQMiWQ
	g97N/kAInO+mzJQUlVEjO/iuvex2gofwtOXOmeWMzhN2Zr79vApfCj4EXpldAlzY3lxz9RGSMGs
	S8MlAipWkSCNoP8zK9DzVSkkgVNek5ecmd5pxYNWQQq0Ci2KNnrYIsgSVXlNod1UuIwYY0Q==
X-Received: by 2002:a05:7301:6097:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2b7c9124e92mr4388026eec.1.1770044342735;
        Mon, 02 Feb 2026 06:59:02 -0800 (PST)
X-Received: by 2002:a05:7301:6097:b0:2a4:3593:ccba with SMTP id 5a478bee46e88-2b7c9124e92mr4388012eec.1.1770044341768;
        Mon, 02 Feb 2026 06:59:01 -0800 (PST)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cfaa8sm19582564eec.4.2026.02.02.06.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 06:59:01 -0800 (PST)
Message-ID: <c069c74a-3a0e-4067-8d29-4ba894ead78d@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 06:59:00 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] wifi: nl80211/cfg80211: add MAC randomization
 support for PD requests
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-12-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-12-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=6980bbb7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=RPI7tyx9PfwCRmZe4zUA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDExOCBTYWx0ZWRfX4RO5mNRps4v3
 T9tgBBwXjysGF9topGk1CKreY1IFeVtBhFnwT7Im88DhmQJIoztwbzjTd6Wmxmxibtnq3cO1zTP
 8yJYDXHFzqLX5yvJSmoDMbiPHU8heUiIWrM1hCOV9jlICX531QPwIPfLyJgnH4/pgeZ22oUCPS5
 1KWoN23KTsEErO8OA00WCg9eHEv9X5sqth6GLxrl3Z8gHSSG9EWoyk803BEmCcgQg5kcjaZyHOs
 TVhkyoBmfebvP3/zDGOEWn7SfjiJl8i3Kuw5JPnV7arccQUShgB8ws0JEcfbdyb7yn7r+RisSoE
 N8f1r6GkHQ1TQUndZd0uUuHFumgIIknXUHOtJQ5Sib1nsj2mjhcvnwCOD7eT4e2BsaF6Y6AbRuL
 ytXjHjLj1cjrdVW/yBfrL46E1p5A53+OdIhXnuI5ik76rK1ytMKst26bQkrtBRCxPlcgJzKCCgD
 fYNrjaTAOJ2Suh6jo5g==
X-Proofpoint-GUID: vtPSR2j-pYiMT2POVqveYyHQCcqmxE7_
X-Proofpoint-ORIG-GUID: vtPSR2j-pYiMT2POVqveYyHQCcqmxE7_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020118
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
	TAGGED_FROM(0.00)[bounces-31465-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 145A0CDE49
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> Add support for MAC address randomization in proximity detection
> (PD) requests. When enabled, the same randomized MAC address
> used for discovery and authentication phases will be used for
> the ranging measurements, maintaining privacy throughout the
> entire PD session workflow.

describe the problem first

> 
> The implementation adds a capability flag for devices to

use imperative tense

> advertise PD MAC randomization support and validates that
> randomization is only requested when the device supports it.
> This ensures consistent MAC address usage across all phases of
> proximity detection while preventing invalid configurations
> where randomization is requested but not supported by hardware.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>

