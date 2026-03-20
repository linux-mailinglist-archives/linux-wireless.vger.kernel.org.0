Return-Path: <linux-wireless+bounces-33613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA6nG+mSvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:33:13 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CB42DF7A6
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 452C631E5255
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C77B3E6395;
	Fri, 20 Mar 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2v83CMb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ELCM7Pjc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49203E2766
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774031132; cv=none; b=OPS6jP+M4OEw80RbMCIC+Zz22w08DIkcfsXRBe+vApKmntvKthqbsHTVbw0HyvdCVowJBR0Xienc73nZ5deLv9o4Gx4a305AjeZehfU7mg580M1E68HFzF/hbzgl6awjOQTsQx8KlD1jbO5bAZDFzYqYejlPrfBjPQop3yrmVbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774031132; c=relaxed/simple;
	bh=TwDYGmesuB5JvA+DPmgeYwuCk7gUsO2LKYA0i+nlBRg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QrVBoNcLRt3QE9lHZCW0KqPz6gjI4d+8XC3fC/3285cNuPiDWmOGZzRW7DlejZZm4Vlx7KLnIQQxI/N3+e6/zkzCFPvZ2TXDV519zfT2yoyfSh6sPyDPWHLSBqblNKkP/Le8NqWrWLAuzGvTZiM1jbcN7hIQOTy/UvWYq1rAMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T2v83CMb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ELCM7Pjc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KEeRos989544
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:25:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RKoOYgDuBvMZcmJdvc33FVClSJPZ6O7/i9tV97+vN5M=; b=T2v83CMbZpcgYNv/
	oC1qETRPNqbdIfLkV/Qwj0BaSR70wXoQso2dncXcnURWDIpMlDIY65+LGKZ8c/Jw
	VmfaiqxNmvwAs83t2znFZJvJ3xOzUu8Daoc+yYPvGFiEjKarfANYmSZCYPTaS4NE
	iPw4hI5WTq0rL6RKdL6axNdh4ObO/E1dKO4csP+y1IPO+9HBoPnTYLvZvp++URpX
	djeWLfqK1QcH41lQG+oQ+58+kk5zv7faMOy1/CRv7XyDB3cC8x+RqmdXHYhluXlO
	mLzosvLIuGo89LF9PV4+TRa8v1fDbnUwWrkTyIMW7OHoqnZnTWlV4QEVeGqT5BSi
	4wuycw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d0k0vc87j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:25:28 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aec07e8aafso8176425ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774031128; x=1774635928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKoOYgDuBvMZcmJdvc33FVClSJPZ6O7/i9tV97+vN5M=;
        b=ELCM7PjciUrLPs32Okf7fW15xcGFzgD0kC6SI5PySIjZ6B+DenbnHG6tpr0RUJXdYX
         X9Mo+F/B+19KYoaTr0iZ2wWrZix8EZ5nPlqSOFkr6LTn2vXUSfic2dcgA5j4jwvYc6nn
         bK/EFVV9CKhp25/DBjLHLY9DJN/17PyqTQ85ZjsM1ONUQI8YO0T1OfB8MT7vdbahn5GH
         Iw8L62AyLBSawm65vvgh54HzZF10M9de6YSCYXEwMcJM09iJWCzZ/DG4hUkiqOBnhDVo
         8bZ5autL+xyuXKcqg4/uXCpxcuxEpv+uWACQWzRoBjuBU+xxUOpAkzzjgB1UUc4pWUEg
         jiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774031128; x=1774635928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKoOYgDuBvMZcmJdvc33FVClSJPZ6O7/i9tV97+vN5M=;
        b=pqgMnndUrd70pxSSzsIPGQ9PyEp7SREDhQdRYaTSBC1OJu85SdWTmxrDcTJzYaoVD4
         VAtAbGHh7YH7gM4JScusepD0cFDZv7LOnpCJlbmV0Jb+yN+c2zHxepI+preyy5kuxHml
         kLpg8jw6y8EOdiWxerpxK07QApjleYeVYp63b9HJJfM/FnInqiV6MUcIvV1K5/ozjHXe
         h1ihOWii5Y27flI14mzB+QoinnKBS2uEvMSfyrhaHU7iU4ywOPljM8OFUPw6tNV5Fwno
         zl1vjVyAbEeDK0BgrMGI3EKXSgCKvkugvouVpeO4claYEuH2MZ5wR7SNNhXFbkhJW8NR
         FAeg==
X-Gm-Message-State: AOJu0YxkFGdeE4yTV4i/gKbj2YV5NP0porDAqYZsyxbnvZ+7MCi/7dt4
	5mojGa43g4i7nGoSieWqLwmZ6THWbT7gvKIBOAmdtwjZVS0lNe9kOEfLuW50mGG4m+iWMczVT/g
	dAmXjMnDLL17HsAW5nZV/NeCulNhmXLgGgC9euF1mt8BoE/jf7PpBWZ6xeKPP7KN4945pFFEABI
	Jg
X-Gm-Gg: ATEYQzz8FYsMxrcvCQuP8c6Nrk1raheBvShXtaPjNgTfLLZBG4nfgoKBpiiwEwLDMTA
	2Xi7arxM2JTALIn0sYiUM6bLkBaubxwNrtF1QIJQmK94Yc0zpYdHJrjXjodbX26mH+f2VCbH8en
	68rx33qhvqVZKCa67YLZxNu+YxXouAb19BriJ7meGUYzzJNWYfQhMx9kQefZl7tWz+vPy7n1sAr
	pqei38hA+xynVASBmfhILEpWq0ANa4PNPrFsnX1g5VtEZzI+4kZp80OSDYcGQONUF7qPusL3EV9
	PZmBLQ5DdKXQXZImmg7SUtsbiMv0CDPk7afweNbSuPc8+zJiXKVVGMYiAh0A/AmuO/GiazqjBsb
	gBaTXj36UETBzevYq8tbZiWp07yuKdTKDtXyKQXJomXCmBWx58aWAL/Y=
X-Received: by 2002:a17:903:244b:b0:2b0:775f:febf with SMTP id d9443c01a7336-2b0827e31acmr37001395ad.40.1774031127553;
        Fri, 20 Mar 2026 11:25:27 -0700 (PDT)
X-Received: by 2002:a17:903:244b:b0:2b0:775f:febf with SMTP id d9443c01a7336-2b0827e31acmr37001165ad.40.1774031126985;
        Fri, 20 Mar 2026 11:25:26 -0700 (PDT)
Received: from [192.168.0.109] ([103.88.239.213])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08368eb9asm38759285ad.69.2026.03.20.11.25.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 11:25:26 -0700 (PDT)
Message-ID: <48b2934d-dfd0-4f83-b298-4971d337051d@oss.qualcomm.com>
Date: Fri, 20 Mar 2026 23:55:24 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add
 NL80211_IFTYPE_PD for PD PASN and PMSR operations
To: "Stern, Avraham" <avraham.stern@intel.com>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "kavita.kavita@oss.qualcomm.com" <kavita.kavita@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
 <20260305160712.1263829-5-peddolla.reddy@oss.qualcomm.com>
 <CH3PR11MB8383B129375415AB3B50C4DCFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Language: en-US
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
In-Reply-To: <CH3PR11MB8383B129375415AB3B50C4DCFF44A@CH3PR11MB8383.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 6y8CMrG9rOMmUwb4RqAsz0MW_8B6vD7q
X-Authority-Analysis: v=2.4 cv=EcjFgfmC c=1 sm=1 tr=0 ts=69bd9118 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=YekYzGz3bqI42vIqjoHHTA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=stkexhm8AAAA:8 a=VwQbUJbxAAAA:8 a=P0YpMXmqa0O8gAD5iasA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-GUID: 6y8CMrG9rOMmUwb4RqAsz0MW_8B6vD7q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE1MCBTYWx0ZWRfXyCj0iR7puZst
 JrjzZainlrcdcljxyqNZX20HTGbwIfngYmxfZ/z4UFBVLbEucaNns2H2bc2Gfqqwhz4jXuOTkt8
 NucNBcdEiZBaVfcJ7Ov1+qC+PHvyUBGD0clUljkqHEVbAKdFUl9cbVYI9fHXHO2Gp/sPv4+TyGN
 2VlWbWp6wKzQHnPzfTi4ZY4QSOq+/DijUMWeLuUw5J7SdapgIfHQZFvl3CP2nAPjX6i2C+lxGFj
 ju1VARfXRnh9g8NJLCYdkwXOjbIS/F4lAZKcQT8TkzpkPhkUQlj74QOENpcMReuvwTjukB8RrZQ
 RRhZiJpkdWgxATPJMu8dX9Ss+Qt8p66RLALoh+ZBaqzVo/V7izET4TEC/q5qAgvYa1xOZC2iLkX
 z/CSzpRY34z60LLQVZD74Qq6/xl2c4CgJKorjTTm7Q8uWGRVOPi6BjuKJud0TbBzBM65egS5Pui
 LC8m+3Udzf6N60AqdrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 spamscore=0 priorityscore=1501
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
	TAGGED_FROM(0.00)[bounces-33613-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
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
X-Rspamd-Queue-Id: C9CB42DF7A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 13-Mar-26 2:36 AM, Stern, Avraham wrote:
>> From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com> > Sent: Thursday, March 5, 2026 6:07 PM
>> To: johannes@sipsolutions.net
>> Cc: linux-wireless@vger.kernel.org; kavita.kavita@oss.qualcomm.com
>> Subject: [PATCH wireless-next v3 04/15] wifi: cfg80211/mac80211: Add NL80211_IFTYPE_PD for PD PASN and PMSR operations
>> Add a new wdev-only interface type NL80211_IFTYPE_PD to support Proximity Detection (PD) operations such as PASN, key install and peer measurement operations. This interface type operates without a netdev, similar to P2P_DEVICE and NAN interfaces.
> What about PD discovery?

PD discovery can happen on any interface. So we are not restricting it.


>
>> The PD interface provides isolated functionality for PD PASN and PMSR without affecting existing network operations.
> So PMSR will be allowed on station interface (for sta to AP measurements, when possibly associated and have security context already), and on the new interface type for non-AP ranging?

Yes, This is correct.


>
>> @@ -1935,6 +1938,7 @@ static void ieee80211_setup_sdata(struct ieee80211_sub_if_data *sdata,
>>  		break;
>>  	case NL80211_IFTYPE_AP_VLAN:
>>  	case NL80211_IFTYPE_P2P_DEVICE:
>> +	case NL80211_IFTYPE_PD:
>>  		sdata->vif.bss_conf.bssid = sdata->vif.addr;
>>  		break;
>  
> bss_conf is irrelevant for PD interface 


Fixed it in next version.

>
>> @@ -898,6 +898,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
>>  		need_offchan = true;
>>  		break;
>>  	case NL80211_IFTYPE_NAN:
>> +	case NL80211_IFTYPE_PD:
>>  		break;
> PD interface doesn't have a channel context, so set need_offchan = true?

Fixed it in the next version.


>
>> @@ -4621,6 +4621,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
>>  			(ieee80211_is_public_action(hdr, skb->len) ||
>>  			 (ieee80211_is_auth(hdr->frame_control) &&
>>  			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
>> +	case NL80211_IFTYPE_PD:
>> 	default:
>> 		break;
>  
> At least check addr1, and accept only auth frames (PASN) and if used for discovery, also public action.

Added check for addr1 and accept only auth frames but support of public action can be added if needed.


>
>> @@ -13954,6 +13962,11 @@ static int nl80211_register_mgmt(struct sk_buff *skb, struct genl_info *info)
>>  		      WIPHY_NAN_FLAGS_USERSPACE_DE))
>> 			return -EOPNOTSUPP;
>> 		break;
>> +	case NL80211_IFTYPE_PD:
>> +		if (!wiphy_ext_feature_isset(wdev->wiphy,
>> +					     NL80211_EXT_FEATURE_SECURE_RTT))
>> +			return -EOPNOTSUPP;
>> +		break;
> So not used for PD discovery, why?


This is not restricted for this interface, support can be added in the future.

>
> ---------------------------------------------------------------------
> A member of the Intel Corporation group of companies
>
> This e-mail and any attachments may contain confidential material for
> the sole use of the intended recipient(s). Any review or distribution
> by others is strictly prohibited. If you are not the intended
> recipient, please contact the sender and delete all copies.
>

