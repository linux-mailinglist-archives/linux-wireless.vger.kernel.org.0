Return-Path: <linux-wireless+bounces-33620-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPiqHcqdvWmW/gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33620-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:19:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1AB2DFD74
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 20:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7771A3033D09
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA3F33C1AD;
	Fri, 20 Mar 2026 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BCCFEgkJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NtwUj485"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510481DE4E0
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774034311; cv=none; b=JrBOZC3LxvIsRSg5NyJw5H4ITLYfjLOZSx/TMWss7HaVkM9Y0i+huRxJZKh24ezVTW7EVZJo8qNl+JKWVdawQ/B3+j3H5quNjXSymq1Lp+8Lmkc6TU9g/qWSa0fEtcalVMPSHRVEHmaF+f/t5Ot4/7rw4pOD2RVM/gMIjyY3lhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774034311; c=relaxed/simple;
	bh=v6Iz0At26NL4SQVwHOr+hdXpPZ68R3+zizxosbCs7O8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TR23GRxkyb0OPI/QKJA/dy2ObpQZoEF5gjPQN4gJugN/eaS/rJzFLj+F+qeQ9925tErBgz6tT4bslBu1ku+tJyX2Ro2454bePS2Vq4qMMsfDllj6tcXtltB7AHETPYb0UhTi3GBgtY5F/HXNX7SUSdD9t99M+aqbQH8p/Hv5zDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BCCFEgkJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NtwUj485; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEXatn1691830
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vYxWqiqEBKAvcbgcD70qMUhuhVypXuVwcKQlcTRFtns=; b=BCCFEgkJwibwxu3I
	fBva+5PX+NWtJr+iVG50BrO4y63r0QsnYR1+zsbXGDXNw1LYN4E53j/LR1kIeHjz
	LEi6C0Fu0ccWJLKkvHLgfcEFJweKkJQaaN0rALoCrnGmSYB+Fx2Dxmycz3gDKdG7
	WSxNfanDQ8fxrK3WdNxsvBaKEdoAAxoI4HGV300L3nzf/rBX2Bx3R/3wEHfxXe2A
	DLvKxjcCtkQ9KTCOcoo/YciYjTu+poBOyTWMIi2gtY7KZw9sXMJ7e+ZsfYzpc6lj
	CcvG1UEqGvZVyP22SJOt32Ae5wIz54/k2x686GOHAfLWMHWHqxUhLVBiKE4n1rto
	1AlUxg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0s5d30a8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 19:18:29 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7424d91b2dso1342745a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 12:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774034308; x=1774639108; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYxWqiqEBKAvcbgcD70qMUhuhVypXuVwcKQlcTRFtns=;
        b=NtwUj485FcrMXZtsUllyKsQVGj9EBO0lVfV650akoEXxRTlV+cg1sYMs67khADr/03
         mrzEODo2ObsdMNkiz1wRJKJHWABHpSqaw1YYFrrN/n2PAfvv7XHDTW9Fk6gWlHOcE5ZV
         oHXNIYhLwKu4ivUP0FylzMlLaOrNIQDjJr+S/I1g4FlwOiLDw1T/CO0Yd+Q0IRRPHcCk
         VxAaivLx+XQRLTyr3kFyY6wrRdIVLNnSiXDskz9YJMIOUmwTbpUuDsT2XK0nyRf+ybqb
         CUSXG2EHG/lMtGkn2GbphcmBdBLEoAxuEQsAEwtn7T8EeZ2d/yAyxrCd+6U31akOr+ju
         ovog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774034308; x=1774639108;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYxWqiqEBKAvcbgcD70qMUhuhVypXuVwcKQlcTRFtns=;
        b=mDUGR+nFsZcn/w3m9rrDS9PBlNP3teBETcGekzSlEXRK6mpO3y/wJP+Yve2Hl88mwr
         7VEeN0OrvY7Xe2d7rL6XPdeu6hHFSXO1xXPe7Q5a8VoiUdLUYiVEEPUlWs9iTDci0Xxz
         m3ZURu7HrJkJEVE1p0zSF40LMWNSZXuXpXWIHWh744os5L9fULLNw088qnmGwkjo+j3o
         MCWCzGjH98I0upvlC+EvfNNjEfMRnVbW1fHZnp5w9CBeH8Q9ra3vu9883P/iaa1Cg4+o
         zens4G9ppzGqhkbW2JG4w0JoycopjglIte38KTL56viPFSaYcduGNYsRJHlpFrg30LB4
         It4A==
X-Gm-Message-State: AOJu0Yw1AdzSVO7VBUCdEEU6E00dWawUomOn1NpgeJQpQfk4zi0+WFVp
	sIZKbME5jbmBT0A17C8Hga8Ir7LOARBcvxpIMZYwdmpFIgG312fKGcu15RPMIl/SFdIg1yV3EA6
	jXSINpyjcwu5OndNpjAyBTgUJjWeV6u6GZbUcojN+PpU+ogAulLGwNS0LTnS8U4ALALcjULfylP
	Ty
X-Gm-Gg: ATEYQzwqDQINjnGxQ46hFshnV7E72rmNJtwC5+YIKO+hSfoiLbi/TbLfu2nsGJ5jjG+
	pbXFEaPxwMrnwWrgz0TAymyzFWaVsspAhNg6Fk1i47muBqPBXtlXQ1A4WQITEEDch5jD1+8d2hr
	+L2ClEnC7qtfZgT7y2SDqv0ziwyP3D3xzceX+VHCICzMGC6S7yXVMo9hm90UjJ2LMEYR+3p8bl9
	CvIaoKQtAymVln2CDFHIXiqon1RcLkw9glIeIYUXCgCRXwb6n+3zY5O54Y+tn8AiAStM9SPF0BG
	PIpLDSQLyVliJr2bCFYWoRzRz0vcmss94TGnzZQPXXKaGzpBta/QL62vTaVvUkc1W9dBZkUUqVV
	r9dl+/kGo/il04gp8xUmSy5mL1ii7Aeqze4MuU56OqbU3PYlEnjyyq84=
X-Received: by 2002:a05:6a21:6da6:b0:398:7ffe:472f with SMTP id adf61e73a8af0-39bce97cfd8mr3896325637.2.1774034308447;
        Fri, 20 Mar 2026 12:18:28 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da6:b0:398:7ffe:472f with SMTP id adf61e73a8af0-39bce97cfd8mr3896304637.2.1774034307980;
        Fri, 20 Mar 2026 12:18:27 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b040da3dfsm2653687b3a.45.2026.03.20.12.18.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 12:18:27 -0700 (PDT)
Message-ID: <55051906-cc13-4dd2-ab15-99b4e3226b7c@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:48:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 10/15] wifi: cfg80211: add ingress/egress
 distance thresholds for FTM
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-11-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383572815565E924067C267FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383572815565E924067C267FF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: hXaKwvLeouEbQ4ZVaWOoG6wdj3p5ikVV
X-Proofpoint-GUID: hXaKwvLeouEbQ4ZVaWOoG6wdj3p5ikVV
X-Authority-Analysis: v=2.4 cv=CqCys34D c=1 sm=1 tr=0 ts=69bd9d85 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=VSCeRQfBNntvLL3gq5i/+A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=OtRVinzrR0dndKCyBQEA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1NyBTYWx0ZWRfXwTiZuKFepugV
 bHiYc0mjLRGFt+AXSq4ZDTBuCv5NQqzWz8MLO2R4zGtORM+wBHHgzYSHTtsgwdDiYSUc6iiQpJU
 jYwP+MhnzL3FFgzay4u+KwTC8VobeJFdh+RsolpkuW0mgqGF6488I5SgA3xsIaROP3cnI5irUFW
 sCEUgI3DzEmd2BqDFz5J9zfgaOOCZTv08XhE2B9d3Q9GLe1PjGaQDC6aVXTV+2565IlVrIwImat
 fXn7XCp+iG422AJmeu3ZvxABw+38WaSpI6Sq5den8ve3YfspGoutyyT1PZsIe2E5UsR/rLuLtiD
 03yZkqjktiHAmp2kwxogQlbPinE3YLrQNEqCdjWPvWLA5iZ/l/fD+6lWVVGHikF3sN9wBlb+4Yp
 4rMklcf1mca/Gv0WeqkJWPkO1tIkJa8OH4Vw+NW6h0B/3tkBCYqe274RvvBt+q7hr/FxOukwgzT
 vcIKYqDp0wq7/9RLrQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200157
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-33620-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,sipsolutions.net:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DA1AB2DFD74
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:44 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> 
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 10/15] wifi: cfg80211: add ingress/egress distance thresholds for FTM
>> + * @egress_distancemm: the measurement result of the peer needs
>> + *	to be indicated in case the device moves out of this range.
>> + *	(units mm, u64). measurement results need to be sent on a burst index
>> + *	basis in this case.
> Not sure it makes sense to keep reporting results if the device keeps moving away.
>
This is the real-time usecase.

>> + * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer needs
>> + *	to be indicated in case the device moves into this range.(units mm, u64)
> Need to add "measurement results need to be sent on a burst index basis in this case"
Updated in the next version.
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

