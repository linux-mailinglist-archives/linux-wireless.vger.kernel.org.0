Return-Path: <linux-wireless+bounces-33614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FP5KleUvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:39:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6552DF8A7
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B278F305CA86
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA0E3D0902;
	Fri, 20 Mar 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YrsaBUI0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CZP/owHk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E0E2BDC2A
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031622; cv=none; b=lGuPLeMA5U4Nca/6dPrtn47sGwtl+8j4aPb4vDLvZMpOU7z7kYVns6kldAiVEoNwBegtSrVmZrsKvgPtMr4lBT7fXlrs9pprd2Rv6kPsdzVA6oVBiCrbfYVYMnlqCmrL827/W8WMcVKA7epqx9yn84eeg7yrVIwWaurFfem3CZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031622; c=relaxed/simple;
	bh=IMF86n825m0PFBlW177MHVwI5tJrDzmpvkvBqnzUgUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LtVSy5bNa7ActI8EXtvAPYap0gE7+xrCPADSHC38NcfdaaoNBjCZPtxmb2PVuHtS55pLyjiODVAMkg1piVzXJFZqUwy2pWqOY648WbO2Mg3Vu7HL/8bnke5YxIhaUtaMrEYgfNF09/E3+B+DZrMSRHBsat6IPMQEEiY8dlaY5xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YrsaBUI0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CZP/owHk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KDn8e4539238
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HSDSnGzebEXKs7PENOQJ18AR9SFDydAcLmKFeO8zdzA=; b=YrsaBUI0GSfHrsju
	4Vm+YabN+qZ7zHfgtKHzy5n3h+Ynx75xIbC340Gv4UR9hxCEA8t0tS2ipW37KqTW
	G/fAvyLGf0hKD7YrHL8RqngPl/BZ/kyF0O8ThVcpx2rGRud5SMTlccSKGCtJyn/t
	uVmA2CcICqIkcfe4YxP7wtfJc6vCwu0s80KA7JeMZkwj3CmEzHldulE+wPPCWkf1
	h54AN5/hpQ713qFdEHBu4PaF3kG06GU6PYC4l20crnn8pqprxrnD62uPM6Uc9A2Z
	IwcsR40yzhwsTox2S2l0gOSK/Td89WsxV/mZV/HZpU1zB8oJBRZ2Vq6K8UMQwjEF
	GMqTiQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0sm6ju60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:33:40 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae3badc00dso33081455ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774031620; x=1774636420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSDSnGzebEXKs7PENOQJ18AR9SFDydAcLmKFeO8zdzA=;
        b=CZP/owHkfVpiTN3orBvzVLxaQXuSrS4DL1i9P8Lu1SxXVGMJNS1QUDIaQL1d6Ce10r
         828c6uGA8cthLAIerPOYFOZVnbfeyYxHLuvy11kwfNJts49wjfU38R7Va/lDRvRMklWl
         9pSt/V443oZbhH8Gw2t7lLi3AUjRosFQwEbanOdJ3/D2u11DZ45FxczkG1+og7QEAylY
         28mtgivTssS24hq06xiCjiveZn7O1pCf828R3zRiB/vIspaoGaePqeic0VPG0ZOHJrFD
         U+AA6ULBetGUBqm3p/Scej+IiCi2lQ1Z1yfB0pe2R7Wh82Q88fXDXSE0k2D5JErikL4n
         MuCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031620; x=1774636420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSDSnGzebEXKs7PENOQJ18AR9SFDydAcLmKFeO8zdzA=;
        b=pMT4//tuqgS1FbLU+LyLjhDk3vwmD+voXPRc8iuvhYTpVzM/dw0qiDtqAWRRk6jus9
         VqqkEAcMZ3K0/Dm/jxOf/dIn8/nqIUjOsh8//S5JMBhivfVo8O+Cs234GOAWyTG886MP
         53aR7bGkHVC9NW09YsjW2XZwBNNbCbTiBSXRKZS/fRDGkPe0u/xcGO3ZPHeZnqPN54ze
         e6+REIqV+somh04Q/hfkpvvkxoamVMA6O8tm6H2Paml8ef4UyDd2C7ihIOXLRY2VAl7v
         M9bEea/5zocY++dOD2XrEx24b9D9prLqqi9WzdHalNA/UJcUWSPAlLAezPkt65H8M9UL
         i/Hg==
X-Gm-Message-State: AOJu0YxfqNxPyy3iOseuhJlKgTMfA64lqK1jB7ADzzP+P8f3GhkEMPkU
	a7n+Ay0vudOLLsm35rpXsptp9JBRU83cW8oWRI12NnaVMGzZeMgQSBJueV/aZti0g12N3N4h4Op
	ku5uYsKiLI978luEUksYnTWuNUHlfMCV47HWNYodabZMLxQdG3+mG2B+vAVOU9N0wUsrg
X-Gm-Gg: ATEYQzxCCtseLhU6svt5zifdEj7C5crMAGDes2YFpCFy6Jq6ccW4+/xkMw8kaRuHdvY
	4eSFcKxNVSs3kMt5QD9G3Fk5XoYkeCRIFzny8I1qF7crjCkuMCFttNgAqPDAejqHRJ64ZgSmePi
	ol6r/Jp6GMbatLMpZzX0lgr3AiO69YUkO84vLmeMUUIqJgDDglCbnEc0o7L/HxLXInJR5y0v3M1
	VRbi+hhOdxHVtvhHAZWuCv4ZJbEVGLhzgz+CYUsXoBef51eN1Drr7Qn0JQHiGTaih4boDM09nBm
	LIdvaUiNTfmS55wnxTqhuPa3JYUIRBBvVsK5CR1RbPdg4xwNSBIFs28FAC5G8n0JfUWwu1a8sJ7
	PE6MPRLT03JhhikARfqPPCAdKLmVlmUwdzz+4rhWwchf9HvFoiLMOdhQ=
X-Received: by 2002:a17:902:d506:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b08279a40fmr39077085ad.36.1774031619995;
        Fri, 20 Mar 2026 11:33:39 -0700 (PDT)
X-Received: by 2002:a17:902:d506:b0:2b0:65e8:4041 with SMTP id d9443c01a7336-2b08279a40fmr39076895ad.36.1774031619493;
        Fri, 20 Mar 2026 11:33:39 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm35244525ad.0.2026.03.20.11.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:33:39 -0700 (PDT)
Message-ID: <53e97866-0ef1-43fa-99de-ff4dc8a38bd3@oss.qualcomm.com>
Date: Sat, 21 Mar 2026 00:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity
 detection capabilities to PMSR
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-7-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383D7E5CA78D822A9FD8A1EFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383D7E5CA78D822A9FD8A1EFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pxXJLEINodE9pePTkLxmq0CtBhiZKJYV
X-Authority-Analysis: v=2.4 cv=Rv/I7SmK c=1 sm=1 tr=0 ts=69bd9304 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=3EOg3nSskSvkHBJLo7AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1MCBTYWx0ZWRfX/6JKCafhtjfw
 fcXelJrrzn3BOoara8K4jlkC58exoGMyQ+DZQTH0kCyhhRHwDD7Sscw6K09REx8w7QorkEDn0Si
 i4NgvweUCbdoXNBPqfmBaa/O8B0vEbp37vrRwG94gXKzVnt1cPvEuHIMDgnkqnwuZF6/bTixvKC
 eXYClmPKwUyWGeFS1/Mn5aB/pOQpp7KdyseHfuyJLQddziRPxOlg1w+pQiwEtjbV8ap7rGSnphr
 eqCXS6LGNdjyKMDxyTZuLl84wy4Yk8sMpakZu06e+/IRIyuQyYOEDuGKcNDwIl2Y5ZVBtm8Xl6w
 vrl5DG0O9rvWk3W2S8YJ0if3og3WpkEglHtgONhJur6XMEePG95Gg//jCcEWLTBxcCrnwH5mf4Q
 IXm8rKiyjSgzKXy0ETau2WKfjdt5wavHu58MnHWPoHb7xmGHNIWK8vTEakfZN0vkWBXmx0FX0q/
 t/GeoAAj8iQXE2uwsWA==
X-Proofpoint-ORIG-GUID: pxXJLEINodE9pePTkLxmq0CtBhiZKJYV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200150
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
	TAGGED_FROM(0.00)[bounces-33614-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 0F6552DF8A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:38 AM, Stern, Avraham wrote:
>
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> 
>> Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 06/15] wifi: cfg80211: add proximity detection capabilities to PMSR
>> + * @pd_support: supports peer-to-peer ranging as mentioned in the specification
>> + *	"PR Implementation Consideration Draft 1.9 rev 1" where PD stands for
>> + *	proximity detection
>> + * @pd_concurrent_ista_rsta_support: As the peer measurement request can be a
>> + *	multi-peer request this will indicate if the device can act
>> + *	simultaneously as initiator and a responder. Only valid if @pd_support
>> + *	is set.
>> * @ftm: FTM measurement data
> These should be part of the FTM data.
> pd_concurrent_ista_rsta_support is only valid if ftm.support_rsta is set.


Fixed it in the next version.

>
>> + * @ftm.max_no_of_tx_antennas: maximum number of transmit antennas supported for
>> + *	ranging
>> + * @ftm.max_no_of_rx_antennas: maximum number of receive antennas supported for
>> + *	ranging
> Supported for EDCA based ranging

Fixed it in the next version.


>
>> + * @ftm.min_allowed_ranging_interval_edca: Minimum EDCA ranging
>> + *	interval supported by the device in milli seconds. (0 means unknown)
>> + * @ftm.min_allowed_ranging_interval_ntb: Minimum NTB ranging
>> + *	interval supported by the device in milli seconds. (0 means unknown)
> These are not advertised anywhere, and time between measurements is not part of the measurement request from the user.
> So why this capability is needed?


User space can use this to calculate Nominal time or burst period as needed based on how quickly can the driver/ Firmware can do the ranging.

>
>>  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
>> + * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
>> + *	request for EDCA-based ranging
> So support rsta means supports RSTA for NTB only now? Do we also need support TB RSTA?


Updated in the next version.

>  
> 	struct {
>  		u32 preambles;
>> +		u32 max_no_of_tx_antennas;
>> +		u32 max_no_of_rx_antennas;
> u8 should be enough

Updated in the next version.


>
>   * @NUM_NL80211_PMSR_ATTR: internal
>>   * @NL80211_PMSR_ATTR_MAX: highest attribute number @@ -7841,6 +7850,8 @@ enum nl80211_peer_measurement_attrs {
>> 	NL80211_PMSR_ATTR_RANDOMIZE_MAC_ADDR,
>>  	NL80211_PMSR_ATTR_TYPE_CAPA,
>>  	NL80211_PMSR_ATTR_PEERS,
>> +	NL80211_PMSR_ATTR_PD_SUPPORT,
>> +	NL80211_PMSR_ATTR_PD_CONCURRENT_ISTA_RSTA_SUPPORT,
>  
> These should be under nl80211_peer_measurement_ftm_capa


Updated in the next version.


>
>> -	if (out->ftm.rsta && !capa->ftm.support_rsta) {
>> +	if (out->ftm.rsta && !capa->ftm.support_rsta &&
>> +	    !capa->ftm.support_edca_responder) {
>>  		NL_SET_ERR_MSG_ATTR(info->extack,
>>  				    tb[NL80211_PMSR_FTM_REQ_ATTR_RSTA],
>> 				    "FTM: RSTA not supported by device");
> capa->ftm.support_edca_responder is only needed if out->ftm.non_trigger_based is not set


removed support_edca_responder and added separate ISTA and RSTA based capabilities for TB, NTB, EDCA, and added new validation checks in PMSR request path for all three.

>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

