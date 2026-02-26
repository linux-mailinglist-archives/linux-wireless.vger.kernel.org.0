Return-Path: <linux-wireless+bounces-32206-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I5NIXJRoGnriAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32206-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 14:58:10 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C6B1A71C9
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00664305128B
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF7739A803;
	Thu, 26 Feb 2026 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WRy53d+R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ePYaPPQf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE672DEA74
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772113818; cv=none; b=Ng8Rs86+7GFrYsHXzi/YSPomFwqmVHFJP5NGUrVzwOujI/FM7aA9VzXMy4PuRuGZT3Ms6NC6B+4fBs/EerdA+jpjJcQUa7Q3Y5SqIFzcUCx/f+RAD+CWVaZH7yjQn7ZBqg0FH4kNxtT6J219K+TC2kUHF+/6VuLXyt5E9D3D55k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772113818; c=relaxed/simple;
	bh=PpxfN+/mSEFn99Ce9gx0cOPfcwSK8IUrBlTdwkkJcpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BtmZ+vupQ+UwdYI+9yb/RiWo2bTOtWJNJ1l4BXMPiAtGaLPRAz7KBC06Ev8CgNQsrzhHyBrBnqphaAaHz4DRpknsnmD0cOWUWN7dRnvgk8+hHU+lw2Pp1ev/9H3klsQvH2sRt7xGFIGE3TWxlyvD7hw/CCIdbiqm7ReMuS/L9ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WRy53d+R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ePYaPPQf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QAKjUx2376147
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LE5hBlLTLqBNZK3z44k+/Vn42uoIMCEOpK8ph2BbgAw=; b=WRy53d+Rd2wBTa7C
	Xljw45Fat/D2/CoTfjcEW5HAT8ARM/8FEUmWQFTSAwuiw60eBZeamMh+mxmUVvvs
	YNLZ0Ofat29cvtomNKdqJIWkfhAIQYDjiU5xoMyMx2qxoj1ydHZQwZPX3HmryHAJ
	RAZsU1dxokWzVmog5+H4r8mz+J7mWyry+ZmaVWoKcvuH/OfWG3KJiiFp1zb1vCS7
	rP14EzjcrjkF19qnDQAZb9jKtGEh/0z5CfqnuEoMgJWuk0TJsG6LDZ0gAbs0WCfa
	1ti1rSOAsZCA4CStkPs2xx6luA+oZGn4kza+o/Y04d8Ro0CB23iztPz/IKHNp9b0
	k0MPtA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjm8d8kb5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 13:50:16 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2adb1bdf778so8802165ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 05:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772113816; x=1772718616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LE5hBlLTLqBNZK3z44k+/Vn42uoIMCEOpK8ph2BbgAw=;
        b=ePYaPPQfzvdj+AncEc+zTTe0NQN0ZpGE3Bm+aLtGoDZGwFcVx7dYzmD6bFki2/LklZ
         GCzpHN3KS5iGcV1h4DQG145pG3e1EDTpFAXv5sK15wLwlfBn0L7xKKBhnYTI0b3WyzUt
         MQJ9BAJCs5wuN5PHjKzyx1uO/CWpnm3wcgBvt86Uox8p45RMmOV6AHRm3Hj1dQNzETRi
         Mj1x8bRKQhWlB1/6C1wwrY4fr85aDOa8xM9JzJlCHpwiIRvOG8el6sMz99Y8bPu7CCch
         ba/1VJxUKA2DtAgAW8fBlTy9484VObztHEmAJsFEEphZ4gPaCxbDEw+Y0d9TSFPFdAGs
         A/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772113816; x=1772718616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LE5hBlLTLqBNZK3z44k+/Vn42uoIMCEOpK8ph2BbgAw=;
        b=qQR5CQtBK+MRVvhRSKDtOBMNUHS4+Ecq+rWmuU22NCKFCF5vc12/HuevYIknbjsdFp
         ToQGi8uTKt+807TJrzznzZEVgEs6M2PzQhrsBOpHCRz+YLhgJYztCo58f4IprxnqtHwS
         W6nehQiP7tN5+7G1eJynIzUfARIK8tN5jvTi/mkfmbS9ON3DxMBAwUMRhuAzjRcimgIa
         jR9uyYjjBrJMjh630PvyMhA+1NCBTbJrrURlYFgBtvWcB7mH0rd137D5Qmlv8U+p64e4
         L+JqR/v7kW9R7540rLi7CO7s+VEHYckzwNHtWhwaaS6VYz6l8HdS2TW56rhSrArUNzVc
         jI8g==
X-Gm-Message-State: AOJu0YxslPe7L4mQWqJ/UdFTIWYCFBcIic+2lrt8O1m41LwaVlmzo8Ur
	DERwpqbuXlorWQBWWYNpBUq4IbUsPH7N0yGPr8WprI16BISUc4En8hujfF3sEjACKpjNmITRYkX
	bWEwgI9wbs9tanXOTVzRq/yPhWEdiwOMsALO9LVmyRGoBjmpwtu8yb4RNGSiu2XXnHakHEcnbW2
	jvrQ==
X-Gm-Gg: ATEYQzzRnelrHtU24K/Cju5q72BBe3VNKPEJrUTJnkc4ctyQUi18DstHqeogJpsWQmJ
	G3zFrx7Uh5zWi4t5XIrKRU1jtzQEpefPZbTlyJGyjz39KSqbJhupCSIcG3+2no87DCzJB2YAzuP
	HPAleH3kYOzjxd3D1DJgNAa3HHEt3T1ndAuuRb+PNl170RnFGrPnNorMAVf34vxGCXxcVDMR5Ak
	B0oj7NbUbSV8xZTYTwB/bxItU1SYmpphp37V1JiVyk8YJ7X/K5p79039buA4GQ0PGEqYnpCc87O
	xM93NqQgu9mGNRWoSeolKk9m52zwzI+38nRL26CPxLkeRitPwEaLkF9mFnbINKxQqGApp7uPLMn
	o2WB/v1bI9JOOiL3P1vN6jVXMBQ5ySI22vNPqXyZ1roa/cX0aVSbT/Rk=
X-Received: by 2002:a17:903:2f83:b0:2aa:d7fe:860e with SMTP id d9443c01a7336-2ade9aacafbmr35794345ad.56.1772113815507;
        Thu, 26 Feb 2026 05:50:15 -0800 (PST)
X-Received: by 2002:a17:903:2f83:b0:2aa:d7fe:860e with SMTP id d9443c01a7336-2ade9aacafbmr35793935ad.56.1772113814736;
        Thu, 26 Feb 2026 05:50:14 -0800 (PST)
Received: from [192.168.1.10] ([122.177.243.111])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a03fbsm35274985ad.43.2026.02.26.05.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 05:50:14 -0800 (PST)
Message-ID: <af15a01f-93eb-4c0f-b13d-8cea41f82703@oss.qualcomm.com>
Date: Thu, 26 Feb 2026 19:20:09 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 3/3] wifi: mac80211_hwsim: Advertise support
 for IEEE 802.1X authentication protocol
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
References: <20260226065442.4182232-1-kavita.kavita@oss.qualcomm.com>
 <20260226065442.4182232-4-kavita.kavita@oss.qualcomm.com>
 <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
Content-Language: en-US
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
In-Reply-To: <3ecb3d440ed3ab4fe4cd3765e0c8457ef58fd6b6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QMtlhwLL c=1 sm=1 tr=0 ts=69a04f98 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=RvLD6kXmVJWkDpkbezg6lg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=poRJiS7WAF1VwE7DA8cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: Dh-n1UT3rsyi5hCwRKCtFfZufJJFigzd
X-Proofpoint-ORIG-GUID: Dh-n1UT3rsyi5hCwRKCtFfZufJJFigzd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDEyNCBTYWx0ZWRfXwHIoShgw3EnW
 /hlXVQTW2PELe4AdhgWgWprTjy+2VlZL6HcuYynLygk7LrGc/76JIFygTkjIuiBSX8p8r6kjOkK
 Po0EL8PEr18w4wsSXjFoO0p0lT62Eyvx/EwNF6oK/6iGIzPTie0PUgfbNclFlmKiKvAzpOOp70T
 QAyqWLkGmsLEH4L3up978TA8/Z4JnL7TpsUF9+cph469BUWn8JvVQI2ABqT6XoqxvT3Yw1RkO0f
 OdGv5TfZT6bswVpUQ3vcyo1LOlR6JfRqsMPogthCs7gnz04R7zWFx7F+X+z58XTfdioi5uk2DZN
 sMG/fwZf2Fpg6ZWRfVhixwAQz2QaHjck0fweaVf209O1iWPNEKjPpaeD/xwpoJKc+d+3Jd7oelP
 QNgsEGRfQFV6W4juXTsrHLNO/rTMp7M9ugcZqdlEhYM8hyrXsRdZuf8br8NW4mngx3URaQcA6+X
 frX10vuRRwhdmuNVbmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_04,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260124
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32206-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92C6B1A71C9
X-Rspamd-Action: no action



On 2/26/2026 2:06 PM, Johannes Berg wrote:
> On Thu, 2026-02-26 at 12:24 +0530, Kavita Kavita wrote:
>> Advertise support for the IEEE 802.1X authentication protocol in
>> mac80211_hwsim to enable testing scenarios.
> 
> Do we even need this in drivers vs. mac80211 just setting it?
> 
> All the code for it is in mac80211, so it shouldn't matter?
> 
> I'd actually argue NL80211_EXT_FEATURE_EPPKE is the same, mac80211
> should set it instead of the driver (I didn't merge [1] yet anyway) and
> only NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION should be in the driver?


For (Re)Association frame encryption, additional changes are required in the
driver and firmware. Because of this dependency, we initially thought it was
best to let the driver set the EPPKE and IEEE 802.1X Authentication feature
flags as well.
However, since no lower-layer changes are actually needed for EPPKE and
IEEE 802.1X Authentication, these can safely be advertised directly in mac80211.
The driver should only set the (Re)Association frame encryption feature flag,
and mac80211 can then conditionally enable the EPPKE and IEEE 802.1X Authentication
feature flags based on that indication. 

I will send the updated patch set with these changes. Thank you.


> 
> 
> [1] https://patchwork.kernel.org/project/linux-wireless/patch/20260114111900.2196941-10-kavita.kavita@oss.qualcomm.com/
> 
> johannes


