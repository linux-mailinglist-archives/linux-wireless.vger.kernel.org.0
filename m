Return-Path: <linux-wireless+bounces-33618-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJa8NiqbvWmR/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-33618-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:08:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F0E2DFBAC
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28C3230347BA
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1CE322A1F;
	Fri, 20 Mar 2026 19:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Maa63I+D";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkdbSPqR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F4A3016EE
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774033499; cv=none; b=iauuATLelhypxJMDvLnbP8YHxX6o7hB2fIiIAnIoqCeulWASmceLPFd9PTuH8FXNGj35aR2zkYWkq8Es2nKdlo+R19t3FZ9MEFyObrla22RKlbS0RGwXs/F8Vjkl/zYkU9g8+g2YrF9o24p0COI603EuvA2Iz/oSanQK//rXdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774033499; c=relaxed/simple;
	bh=QoEWvLKLnsbwigzW5mFwE/PzZrolP7So19e8UasWp+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWI+2GBOkF6bx8703Dt9yjNPXYZ3WOuwDPm9u8KE/HICTjPJxhS7e7ymfIPdWqMk3LZSfAdR6YmMhEhIoC9disRYRYIG3+dyUU46wv4BKrEcWQzLFcyFsBuBwZbZv+U5KXD0NkIYISoMmQWxpkYSn6rMePh5+1FZwmFajNw/Hnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Maa63I+D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dkdbSPqR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEC0R53557777
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vgW3HKgK/7FO69CDE3Yu0jRrt4mYjcF41UTG7syrNZg=; b=Maa63I+DtFiv+Lvj
	3DXKcQIS/18Ps39z12HafNnfF4mX1EUxruZ8f4UpgXdsRXUezlqyS3qVb2dpNzHv
	fJHyQbOhTTmmad6TwnFfBEr0SPBfk8AIsluLD9Nmc3XLIXoHSBLQ+dt/Tekl2CA7
	jvQQZ42ya7453m8rxZY1xXoLOlP4sDmD7ne1eI2nqmIIAjYqZtMxspA2CJgfeeX6
	lP8WY7f/pIGpRJMptBH6DlPTDaSK1Kj0w931rfO21qNV8h0myaLEE/S23qDiO1de
	0u7uNwzFlC+oLekTovBe5DcgFOqUgFOqD2gXUZwQVQtRNAsFsh+Q8Ve45kpaCAP+
	o1p/PA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0r1gu4bt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:04:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7414179cceso545892a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774033496; x=1774638296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vgW3HKgK/7FO69CDE3Yu0jRrt4mYjcF41UTG7syrNZg=;
        b=dkdbSPqRV67h49o+U9Jf7y10kGEUNpWxot8NqACOfaOayHP+HwrX+HXlr+FAMmrOaJ
         JkjpG6685wgh2pOTJk3ta4pS3oQNb1I/X9N1YJoefS51nfkpNLY4wDzdEiHCsvMatKfm
         dRKG9N6+7Qe1u8tQHq5sICxWn18FmBL81jd8AP4/fts9MFHCGxf58e0i9E1RP/W0FTH3
         VqTdRm6UCI46xd7G39C9HXCqnqu+u/P3QRa3a/kTVfJGb2nR7HKTz6tOGoypHKZQIMKD
         IcbLQCvfG2lt7t4W2iF0hHyqTCFJQajDwmHL4g94QVp4EpdHbSVvvwM/xOzY/TO4jMgx
         nKOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774033496; x=1774638296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgW3HKgK/7FO69CDE3Yu0jRrt4mYjcF41UTG7syrNZg=;
        b=QHq7DkIXR/jwwRee4kwX29TVzzMHwJ7Dlv6/dZvX2eMUX0hM2uQlCI1a6PjlLfUNri
         vNqLJBoyaJtTk/KMkCIhKrL1XFNTUHVnpAmtNUxLEcz5QRHrF4/YLiKgvxVKUYmi6gAv
         LuVB2CLD2U5KeyZH4u9+sLuv1YsH9qsgx08XUoh9Sml4ApxCPFfPcGTezglq9u354tt7
         5OdbqPdNEFoOpnGN4xGpntIPL0UWtZAt4JkkKcHm9S5+sCq12tkQ6WpnaGS/z38cPRB4
         mZ0hgpQnA3mFqADaP4a051REFNpBl/zeF4BCqOEeMd+GbmkBYpZBFClFzUnfqFlbP55U
         gtWg==
X-Gm-Message-State: AOJu0YwC3XT6YGvBG3vlFCci4Y5EiHThwPIvBq3PDiGG9uPcHV59sbJz
	p04GPLfutDWrqrgUuutqVCaHwa5VUP7KElPT4d5vBJW0ulYu+3DiquOadyRE8z+SFUkR4yvl7+e
	+2xa8fT/87RG3ia3lfbPH3YUcm0N4a3NcPNVdCGUkjHXGWKupCsX/89Yn7lqPQpd5v5js
X-Gm-Gg: ATEYQzwW/4yod5BIEOBHMItDsZ+tPCPonkdyKDe/9cqFLDCLK8AQivnlAv0FqeOwEAd
	Joi+r/hlihfbwnD+WfHr4oV1HUqFdBiZthgcMb3HLCeS9qWnj8T/YyEsLp0M7CEyTDsau+YyscI
	zkXGATKk8Wosr4Y59SlSHUdF6Xrqjzzx0w/LpINIx1kfmrQ9CnqBqJKek3xSXPfnuKHlS/Y23++
	OovJiakOszPn0J0fhGTnv546QH3akMIOti1QFDNbRzvsGME3/G1yICZAk8jInPory78hPPmIl/x
	3VKWks4eFM7lnp/mbjJu/6czwwELBYh1Q8JHcGj6iey/i0IlFFTy900QUYEYVqEWYEj3mAgt6mQ
	hYKa2SkZVBpvbzy6vkRNjG4VGRvg8+FMO+BctIaKsj8YhVGkDZS+AUL4=
X-Received: by 2002:a05:6a20:7353:b0:398:6b26:dbfb with SMTP id adf61e73a8af0-39bcebcd47fmr3907175637.49.1774033495763;
        Fri, 20 Mar 2026 12:04:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:7353:b0:398:6b26:dbfb with SMTP id adf61e73a8af0-39bcebcd47fmr3907148637.49.1774033495290;
        Fri, 20 Mar 2026 12:04:55 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc6881sm3140735b3a.22.2026.03.20.12.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:04:54 -0700 (PDT)
Message-ID: <1cf960e7-87b8-4196-a0a4-cf3ba3b0c6b8@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:34:52 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result
 reporting control for PD requests
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-14-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383F6C4E5840702AF996AB9FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383F6C4E5840702AF996AB9FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NSBTYWx0ZWRfX/DMTkiPa7NsR
 ldT8jfVsU/UMVGj0DOwbozMWGhbonVUyJJLlzLluOr3QftXV0o3q3GmVRFyElT53AcfIm6NwYZd
 seN1XDWS4lyGooXhpUF7d76X+sNfKdMn56EsfXuvir1WcdreSmtrQ1W+Xh4q6/i86CtFivZth2+
 HVJfFelq6jyEmbs1pbO0266NPFX0Z79nGAlzCg8EFMKtV3PRaytRB95a64elLdp0pj/BgGAf/MA
 Y8h5jSpmQMgnhpRk3ordrFneCcVNVPbWPdj5WPXnF8yNNRwUHBwXKSdl5ltH11CAAVJYHjUlwnQ
 9ZQ057HsbaNoQv01ZGV0KJM/9LQ0BKZPM6KXgAjkF+bWiZX5d837Dm2/pJA50qCpHu+0TkyYSBv
 Z9DG7fvllqTQR2AluKmddzPbxY/n7m6aYUP5KKyks1/0c4P4Np9ChtEqz0eMNYq/cwETHDPpXPa
 7uz35s8oKdDfv7UYGYQ==
X-Proofpoint-GUID: yLzU1NJPXTk1W7At_uiTfYEKjbm0Q3lG
X-Proofpoint-ORIG-GUID: yLzU1NJPXTk1W7At_uiTfYEKjbm0Q3lG
X-Authority-Analysis: v=2.4 cv=Y/D1cxeN c=1 sm=1 tr=0 ts=69bd9a58 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=tltu21h82NG8XwUORdoA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200155
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33618-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,sipsolutions.net:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 56F0E2DFBAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:46 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> 
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result reporting control for PD requests
>> Proximity detection applications may not need detailed ranging measurements for every request, yet currently receive all results causing unnecessary data transfer, host wakeups, and processing overhead. Currently, there is no mechanism for applications to suppress result reporting when only proximity detection is needed.
>> Introduce optional result suppression control that drivers can use to implement selective result reporting. Add a flag allowing applications to disable ranging reports when only proximity detection is needed, enabling drivers to reduce unnecessary data transfer and host wakeups. This flag cannot be combined > with range report or LMR feedback requests in RSTA mode as these require result reporting.
> As commented on previous patch, LMR feedback and range report are mandatory for PD ranging. Results can be not reported regardless.

yes you are right, fixed in the next version.


>
>> + * @pd_suppress_range_results: flag to suppress ranging results for PD
>> + *	requests. When set, ranging measurements are performed but results
>> + *	are not reported to userspace, regardless of ranging role or type.
>> + *	Only valid when @pd_request is set. Cannot be used with @range_report
> The title said "applications may not need detailed ranging measurements for every request", but here it says no results at all...
> So this is intended for providing ranging services to another peer?


Updated in the next version.

>
>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

