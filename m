Return-Path: <linux-wireless+bounces-31403-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOggJ+L9fGnLPgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31403-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 19:52:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18275BDFD4
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 19:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF286300CC82
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 18:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0347536A030;
	Fri, 30 Jan 2026 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iaU6QfaS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UBkKT48j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F29369975
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769799135; cv=none; b=XoGbgVb6VVaAQR7fX5M0h4oXeFGwFwQ5gUzxsosngTwFo5miIzhMuZV7LGO6j/mHJUPh06Q7uDIJSLP/iSUNuLQWiMJJtIU9Z43fQxBYTAAtINv2nJgiQTbH9/5Lc0m+gXrqiCf8g9Q+wHob8/5Q47LsoCoNlDXlPyZwo579CPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769799135; c=relaxed/simple;
	bh=bECntDhr8biNGIDu/za6KIl7cqZtAIqLgWifJ+QN7uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhTtcdH2SQRXNqsQxanDGbNeQs3kyOq+wopCCs217qhJR62D11QLWthk8wS43SsCW1h1sWhQvS8oPytLxAFyZqwwwjEAnUxB4ib+3gsQwjv7RZ2ttxwWyADrSnWCmGdhrIX5LNWo+QuS/NA8MuzOUKgKJv/CMGosb8heNYLWhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iaU6QfaS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UBkKT48j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCSCST555440
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 18:52:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GD89lK3+y0l+o8oseKro/pou2kAKD7jJPPYaliw6MWE=; b=iaU6QfaSg6VSxhbN
	eebSkomemmYNLOYjhKq+ex4/yMp8UNQD7xxEXQZam2pIWliaj6fh93/JHhg6S3Nl
	6j7/kKbZqGxPb3elgrCVrUOHbVRtqsgPQZWrXSiQwzsGyv4BfuXsEE+hH+xH+1OM
	GL0juqqxz950eytgXaIE5LGsHa29ZvnB/rovD5tGdJT+skxTMdFh8SN8zAy1rvkp
	VIo7/ztGNZOJTyfcFdz/R827FPxJ41ylu04HhiwuG5j9ooffyumiw2awKGpfbS0e
	qEOMzbKtb0HqSV1gSFr3C24tJDYqgztDV8+UsZEjwV2WjP7vj0UBUrZqGHw6StS4
	ewOT0Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59jg1n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 18:52:13 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b71c5826fbso2850631eec.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 10:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769799132; x=1770403932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GD89lK3+y0l+o8oseKro/pou2kAKD7jJPPYaliw6MWE=;
        b=UBkKT48jnVFHd/TYRlOnGfm0MTgAGX040kqAvDYVONQjBLwixBVirPNkePO2/ReDhs
         Rx2AUruqRlBgpQidTfH3XEBKEJQNH9O0tfkDqIzu8MqbdBik5uEQu3WTEfT5IXFwc6uA
         k4drSvlu6XRocHTeEETw0EuPyeXXVxFdtOOcWA+3LEhznPCBXuQH8+cVVXJZzz8/wpzu
         4ZdP5bxyDe/BGEeqmMz29n/KBlcz9kyjBOJf+s4ikMIgpW+e820ZgQF5T2FYUIoEiJ5i
         07mJ5aYyVGKNwnXwSGQh6Cd0KTXb8xd1JNCh+VYma8yG1tXFSXuv+RTaxHpgmEkg0qAD
         H+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769799132; x=1770403932;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GD89lK3+y0l+o8oseKro/pou2kAKD7jJPPYaliw6MWE=;
        b=cWz+cpa+yQNrEQXFLxWmhVNYToFdvAFeFe5QdHUE5Qj2ZHkhwQMRxGvArfkxsw2+dT
         t/OQLlkfu1yoW86Fa5G7/U0L2cBdkFEinxROik0HEQJHZVdZywo6nM1aBdlCAoIEJip0
         H7gLWB6eO3DU0BIwcPoGtdmjqSq2cc8n86zs/OqKXf0ID3JNiXnmmwa3hVS89HFwAvIU
         UAzL7NhZiQv3LqSbdZ+8r9Cs/srbk/etDyh3F3FOglXXxEVcOYqkdPrP8AbpS6V6aFo3
         eV4A99M3YGpHKqoUCV3BJQYYHrPuer3BL09WF8MMXnyIUzbvCjuriLGOWh2Qr0XftKVt
         eL/w==
X-Gm-Message-State: AOJu0YzC85CY/0p+iypLQ2mVqe+aTzD5L3VHwRqD+9AcQj/HdRsM3sI1
	ViBOnOuQL71flXMXkfcg3DxU8Xgc8WrUGSXn4EOstanemSNZSAHjXnataUW80t35Fupq1Caf+1u
	XTRsp7ZeX4ydv/iDtjnfQgoUoIQKL02/j+XpyeDuwM5BgwwP0TsPJffkwByJy6t+0+2mUhw==
X-Gm-Gg: AZuq6aIDME0OEPyOrhwn8HmqPvROArJvDyxqnjCTRICyy2ImZ0QHGFo+zsevx4oA4zO
	Xbo6vA1L6gD2r0gNxMsG5tK497tCccR6f3Q1zkJ73rFWSnz//rVAlcfP0UU1Ei8kDtSUbRvnalR
	7xi1JEUgIEu5KQc+ABB4N41kycR9zldkDy52SGakJ5MT3k6zB17rYQsyCjaCcZBLkaxNY8KrcQq
	8M3DRp03lZy5rmGJ3s44WMbGwknGdyBOXAY+0WJmBT82vCMRJNZbDNMxmzyqNAXy4VqkTJYIqqo
	KsZgaop1wfhjkRgLM63Da8wiJAH60PZCR3zH5M98eVMskr2GnfyZUW7NdFtrgXjuKvNqFnAsx3y
	ADRtI33YGuJ7U5CZf6IYTKhn65f1/svcXGhDqJJM4xRqxANob6yekUdrzOSLoushGYdmCix31Ih
	d6
X-Received: by 2002:a05:7022:6082:b0:119:e56c:18b1 with SMTP id a92af1059eb24-125c1000e70mr1897434c88.25.1769799132035;
        Fri, 30 Jan 2026 10:52:12 -0800 (PST)
X-Received: by 2002:a05:7022:6082:b0:119:e56c:18b1 with SMTP id a92af1059eb24-125c1000e70mr1897416c88.25.1769799131466;
        Fri, 30 Jan 2026 10:52:11 -0800 (PST)
Received: from [192.168.1.3] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1af8a7bsm12316186eec.34.2026.01.30.10.52.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 10:52:11 -0800 (PST)
Message-ID: <9d95869b-56a1-4337-8c2e-077a2397e47b@oss.qualcomm.com>
Date: Fri, 30 Jan 2026 10:52:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Ranging support enhancements
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: TOXjEIdcKdF0d-k8vvDmexRPA6y5xefQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDE1NCBTYWx0ZWRfX8+KY6WZNoGiQ
 7z6ck66I74shok722HKuOOgCnqKOysvb3OpGAJweAKLJ3caF3F7jxzVLw2rzob1rolR5UQhJoOL
 d2VPczcGG6Eh2LqA073wkvU2MpLj5bYj5ZKnw2se/NPNK9sUTbCAjgzB01dDb2lZvdpf1zrKwBh
 rJjU8sp6B58FOYHOS+lqqnJHAFvnZEVncdLUPzA6bB9wwv1p4dxn8Qd7LNFsufe7TVQtosRTpza
 35UkBoKHub1BV8FVLgBuBd0riQ+ruVv6xCC0PRdWtfR1TJMNcNEU9tyXPQ+GmRCd03jH632ERVO
 dicCaoG1TzSdbtLfCmQf0++ET/6VlvldmyZY9WI0ydwx0ny77ZXId/FSSHld5LF3i9jWKPFZxtU
 iQANFDbNUJlomfmYgulRozDUN9KcaQ9C1B97pe88s89K4cGu2CG6vQHM5xEPB9zLCSxfND78aDf
 OvlsjjsnT+8DUoa1rcQ==
X-Proofpoint-GUID: TOXjEIdcKdF0d-k8vvDmexRPA6y5xefQ
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697cfddd cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=_uspzXG5sX9rdAaZTNsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300154
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31403-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18275BDFD4
X-Rspamd-Action: no action

On 1/30/2026 8:00 AM, Peddolla Harshavardhan Reddy wrote:
> This patch series introduces Fine Timing Measurement (FTM)
> enhancements and Proximity Detection (PD) capabilities. The
> implementation follows the Wi-Fi Alliance "PR Implementation
> Consideration Draft 1.9 Rev 1" specification and extends the
> existing peer measurement framework with advanced ranging
> features.
> 
> Kavita Kavita (1):
>   mac80211_hwsim: Add support for extended FTM ranging
> 
> Peddolla Harshavardhan Reddy (12):
>   wifi: nl80211/cfg80211: Allow RSTA role to be enabled without LMR
>     request
>   wifi: nl80211/cfg80211: add proximity detection capabilities to PMSR
>   wifi: nl80211/cfg80211: add continuous ranging and PD request support
>   wifi: nl80211/cfg80211: extend PMSR FTM response for proximity ranging
>   wifi: nl80211/cfg80211: add peer measurement abort command
>   wifi: nl80211/cfg80211: add role-based PD peer limits
>   wifi: nl80211/cfg80211: add ingress/egress distance thresholds for FTM
>   wifi: nl80211/cfg80211: add PD-specific bandwidth capabilities for FTM
>   wifi: nl80211/cfg80211: add FTM range report negotiation support
>   wifi: nl80211/cfg80211: add result reporting control for PD requests
>   wifi: nl80211/cfg80211: add MAC randomization support for PD requests
>   wifi: nl80211/cfg80211: add LTF keyseed support for secure ranging
> 
>  drivers/net/wireless/virtual/mac80211_hwsim.c | 141 +++++++++++++
>  include/net/cfg80211.h                        | 163 ++++++++++++++-
>  include/uapi/linux/nl80211.h                  | 177 +++++++++++++++-
>  net/wireless/nl80211.c                        |  87 ++++++++
>  net/wireless/nl80211.h                        |   1 +
>  net/wireless/pmsr.c                           | 194 ++++++++++++++++--
>  6 files changed, 738 insertions(+), 25 deletions(-)
> 

This was not submitted through the Qualcomm internal review process, and it
has plenty of issues that should be addressed.

Please follow the process communicated privately to have this series go
through the internal processes so that your v2 will be better polished.

/jeff

