Return-Path: <linux-wireless+bounces-37541-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IcFoBy4SJ2oBrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-37541-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 21:04:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 644FE659FE3
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 21:04:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=AKKucsqt;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TNI8j3IN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37541-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37541-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5B34E300F976
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 19:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3D3DD506;
	Mon,  8 Jun 2026 19:01:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A47A35DA6E
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 19:01:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780945304; cv=none; b=swVmwW3t2vNLZRPGHXKmek3Cb+bMY0tCayC0YqaPcovecYBeq081uuFleuCdLGb7QizhSXJWf/csHfP8phQnZka0LpEEbS0X90RqaIswPYnIuRuordnvl+F43cc11A9i7Lw5t3dnkgjyd9FVMVOdpXWWteer02N/N4AcmjMghDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780945304; c=relaxed/simple;
	bh=gzLWH8P2e065IAtRFRjgQqE4pT+Wdul8WMeujZz6xT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KLyZTy3PKSmaenldLPPrOSCBIIFXSylRpl9H82novpXkHL8iH1n8OK+OD02v5h61dZZDzalFSLLWl1neGuPhcb8OKzy3HPmKLhQrnvm64Xwrgp+BhO930h/wWeFy6rjAbKOzyD1/ghs00crpodMKWD+nJUEIAkx0Z/K/A5BRKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AKKucsqt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TNI8j3IN; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658IvB1d4049401
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 19:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XehZ6lg7KmMORG6Ha+/J71PUihEbRUaSfLz/3oRcnkA=; b=AKKucsqtMGlOSP2D
	e7D0Rw4BbF3CaBrMkjy2b5KtF2tXo/+pRn/5aeM4lih3u5GzyV/EJXaHM03p9Ck/
	07gu+oqh+fkc+4HEspQIX8k9SMUy0QRfKXk8c0YJ2D/C69IE+J99vAXCV26xVCh6
	qfXl45+YAtTBaJpvGqaPMZHwIVcLuFYPxqosl6g1yXN20ytzl7ja05vBzE8FUU6e
	SMhHHNN0AnkVKmdtAGqp4saoDDWxJtn1KattLKMxjw2YtIJMUxB+HZ3O7Si9Hy1n
	TlFp1/ScViLAsr4nZYciDgfzlXYvc4E96xSjllh0F8vu4lEls84HjlXAtbEctJ6K
	mFyzVw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enunaag6e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 19:01:42 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c10cd7df22so60426945ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780945302; x=1781550102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XehZ6lg7KmMORG6Ha+/J71PUihEbRUaSfLz/3oRcnkA=;
        b=TNI8j3INipF5G3aWUgqSyzt1BP1YmGujPVxek+WLdvlZa/XhucgRT8m+0SePNDiZm9
         16/X0uQqkysfoFY/RPZcSPOBRYSla1FreQ3gX6tOt8onRckU1z7hffoEqwW4lnFveC5j
         j4QbqovLZEH5/g76ZiNlbjpyXC9b1YUEzQiVxNR9CmqI39fBF+LQgb433LAWXO9ChjjP
         /UUwy03st6Bm+ZyY8uD3p292pAmiLx6v8a3zS6zbyXuMeCTDuETAAPZ1Y1NcGi69qw1H
         yRJ19skMQlnJBQh2LuAFKyqsQ3uhJRX99ZcFlI03bp8dAy8iRa4/fXtSi8D1RpalVeAm
         UEQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780945302; x=1781550102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XehZ6lg7KmMORG6Ha+/J71PUihEbRUaSfLz/3oRcnkA=;
        b=a2ZVRBVX4+qT2mVEiVLyEigIu+31kp7hCPH8DlpQlTOn12n59Ck91JFzNw6qUK+E8m
         fCp3V4hlGlZN82bkqK5XUQ8kPycubN197/ej6eQ0m3/MeQ6lx0E4C1hdSe4hu+fXIowX
         bLYe9FX8gQnMPzK9MGgJPB3nb8SQPkuG9oQweHLdQk6TYDpVjVv/7DvtN2uvPPCDAYY8
         bEz7DoHdM3DzDb3ULlAgrAbHxIJSvem6wnhGHVl/P4XlAVh60f7FIldQzYVe0VLrMGfW
         jqXrRru4dv7vlW/Yo3tspLO+um+rTvMkuJ6/mhx6iiRImqFdvEQe4Cx1T9ZD4OUQ+jxy
         M/WA==
X-Gm-Message-State: AOJu0Yyc+ZyeTiKZilgx5aBnaGZ/u47QbNHg9AgR5dqgQ7e/moW/h0NN
	MxBPSsbBwT+7mdnjz2KJ1gRvg5U95aUhseUQXworhDAgjpDhbzlZmb/anIwbAioWdmNeEH4DxL3
	UpvZeZrEKQONWXt66KU609lwiRZNRZgw5dl+kTkyY7EIPB0DTmiHWXjhCRWeSkUYRJb1EVCUo1/
	85cQ==
X-Gm-Gg: Acq92OHyyaYG64NagwzM4FoEey0DPx5Jbmjf2qhkvtZN77w293zNCn103OWPYIaeK8Z
	ZrXlATKodGKxdW72bJGMat21zIB/fxZ60/dU5uao3OSFzJJxoewutn9kU1g/c97YQLJEyzgBDR/
	78LYpx3nilGiYQpb6wd3ZjFZquKQUSKCK/mFSqd1VVHota/f8i6Eb5p3gZ/QkMKKWcmLm0VmsHL
	MA4FOHn/2ywMmxw4Ciu050mu7yEnJ44dlVEtKl2e3Sqgi324PpXFxOMXuNL/WbcD61G1dphifqD
	ndGHxCXGXjuxsNtrkY6ypYVU1291iLiRw9s7SEyh8H1bo/JMLwjYw4o8onI80/WKXFXRXIcepXR
	Xrsght9pBBq76OFiW4y7/BhhkdUjUYIn1OcaY+HtLwZLPwXvj7eLtNceCbVo=
X-Received: by 2002:a17:903:3847:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c1e80e429amr194966945ad.5.1780945301488;
        Mon, 08 Jun 2026 12:01:41 -0700 (PDT)
X-Received: by 2002:a17:903:3847:b0:2c0:c262:b917 with SMTP id d9443c01a7336-2c1e80e429amr194966435ad.5.1780945300884;
        Mon, 08 Jun 2026 12:01:40 -0700 (PDT)
Received: from [192.168.1.8] ([116.73.159.142])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166391d53sm244633755ad.65.2026.06.08.12.01.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:01:40 -0700 (PDT)
Message-ID: <19098782-24e9-4707-8207-6244371a904f@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 00:31:36 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next 4/5] wifi: cfg80211: Fragment per-link
 station stats in nl80211_dump_station()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260607175912.2266215-1-praneesh.p@oss.qualcomm.com>
 <20260607175912.2266215-5-praneesh.p@oss.qualcomm.com>
 <88c183f827eb184e6d471964662b7ee89caf63ad.camel@sipsolutions.net>
Content-Language: en-US
From: Praneesh P <praneesh.p@oss.qualcomm.com>
In-Reply-To: <88c183f827eb184e6d471964662b7ee89caf63ad.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NyBTYWx0ZWRfXx36SCsBDSlWS
 iypfA71E9HO+9ZuhBEXRRGC8MPY6y4X2VH11wP0gpOrdkkbkT0AwwzF77SyOaoRxeAfL7ATx10p
 eu3em0sQeuBe9z4oE2ytuidL3BgP1aIdhLCrSMeEKttKIzFJgq27mKUV+l5sBcnW6NEda+cM3iK
 0hCKX/UPNYFgNJTK/SNth3KRIqizUJvxnd1U8rv7oCnf07Kq7E/SiqX6V6ojllm0cmL/y9reerH
 OGUyci7tfKwc45oVM663M4Sv+9gJtPXQ7CTi5Nv7H+mdM1jODmOdVB3BjDwi3NqYGqy5mJfOeXi
 Mgo6IKvUAz9ujYgxWCil4JumLPeuy+BqBBABbpnnQAlkBnVEUKoLdQ97E21cps4Vk2oN7f3N8i1
 avg/JJcNR33B2HCCHnsqcGOzJ+FL/tn7ybNB5ONHcLCqh5t2vI3tmEUi/fGstOHvbkkm7oEnngh
 xY4QTiqj5O6sNXrXORg==
X-Authority-Analysis: v=2.4 cv=RfugzVtv c=1 sm=1 tr=0 ts=6a271196 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=0XKIscjZuezYqwSxLmfFhQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ZU5qrAxbi5h8eASNLEsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 4K95EDMfZu_29Dl3ITXQTWUDT3r56WZG
X-Proofpoint-GUID: 4K95EDMfZu_29Dl3ITXQTWUDT3r56WZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_05,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080177
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37541-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[praneesh.p@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 644FE659FE3


On 6/8/2026 1:12 PM, Johannes Berg wrote:
> On Sun, 2026-06-07 at 23:29 +0530, P Praneesh wrote:
>>   
>> +static int nl80211_fill_link_station(struct sk_buff *msg,
>> +				     struct cfg80211_registered_device *rdev,
>> +				     struct link_station_info *link_sinfo)
>> +{
>> +	struct nlattr *bss_param, *link_sinfoattr;
>> +
>> +#define PUT_LINK_SINFO(attr, memb, type) do {				\
>> +	BUILD_BUG_ON(sizeof(type) == sizeof(u64));			\
>> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
>> +	    nla_put_ ## type(msg, NL80211_STA_INFO_ ## attr,		\
>> +			     link_sinfo->memb))				\
>> +		goto nla_put_failure;					\
>> +	} while (0)
>> +#define PUT_LINK_SINFO_U64(attr, memb) do {				\
>> +	if (link_sinfo->filled & BIT_ULL(NL80211_STA_INFO_ ## attr) &&	\
>> +	    nla_put_u64_64bit(msg, NL80211_STA_INFO_ ## attr,		\
>> +			      link_sinfo->memb, NL80211_STA_INFO_PAD))	\
>> +		goto nla_put_failure;					\
>> +	} while (0)
>> +
>> +	link_sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
> See previous note about _noflag() in all of this code - that shouldn't
> be there.
Noted, I will address it in next version.
>> +static int nl80211_send_link_station(struct sk_buff *msg,
>> +				     struct netlink_callback *cb,
>> +				     struct cfg80211_registered_device *rdev,
>> +				     struct wireless_dev *wdev,
>> +				     const u8 *mac_addr,
>> +				     struct station_info *sinfo,
>> +				     int link_idx)
>> +{
>> +	void *hdr;
>> +	struct nlattr *links, *link;
>> +	struct link_station_info *link_sinfo;
>> +	struct nlattr *sinfoattr;
>> +	int err;
>> +
>> +	hdr = nl80211hdr_put(msg, NETLINK_CB(cb->skb).portid,
>> +			     cb->nlh->nlmsg_seq, NLM_F_MULTI,
>> +			     NL80211_CMD_NEW_STATION);
>> +	if (!hdr)
>> +		return -EMSGSIZE;
>> +
>> +	if ((wdev->netdev &&
>> +	     nla_put_u32(msg, NL80211_ATTR_IFINDEX, wdev->netdev->ifindex)) ||
>> +	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
>> +			      NL80211_ATTR_PAD) ||
>> +	    nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, mac_addr) ||
>> +	    nla_put_u32(msg, NL80211_ATTR_GENERATION, sinfo->generation)) {
>> +		err = -EMSGSIZE;
>> +		goto err_cancel;
>> +	}
>> +
>> +	sinfoattr = nla_nest_start_noflag(msg, NL80211_ATTR_STA_INFO);
>> +	if (!sinfoattr) {
>> +		err = -EMSGSIZE;
>> +		goto err_cancel;
>> +	}
>> +
>> +	link_sinfo = sinfo->links[link_idx];
>> +	if (!link_sinfo) {
>> +		err = -ENOENT;
>> +		goto err_cancel;
>> +	}
>> +
>> +	nla_nest_end(msg, sinfoattr);
>> +	if (!is_valid_ether_addr(link_sinfo->addr)) {
>> +		err = -EADDRNOTAVAIL;
>> +		goto err_cancel;
> That seems really odd? why even bother going into the whole thing if
> it's invalid? Also, doesn't that ENOENT get propagated all the way and
> it aborts? I guess it does but it should never happen because of
> valid_links? Still seems a bit odd.
Both the link_sinfo null check and is_valid_ether_addr() check
will be moved to the top of the function, before any header or
nest construction. The null check for sinfo->links[link_idx] is
already guarded upstream by the valid_links bitmask so it should
never be NULL in practice, I'll add a WARN_ON_ONCE and skip rather
than returning -ENOENT, which would otherwise abort the entire dump.
Will it be okay ?
>> @@ -8354,13 +8616,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
>>   	struct wireless_dev *wdev;
>>   	struct nl80211_dump_station_cb *cb_data = (void *)cb->ctx;
>>   	struct nl80211_dump_station_ctx *ctx = cb_data->ctx;
>> +	struct nlattr **attrbuf = NULL;
>>   	int err, ret;
>>   
>>   	NL_ASSERT_CTX_FITS(struct nl80211_dump_station_cb);
>>   
>> -	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, NULL);
>> -	if (err)
>> +	if (!ctx) {
>> +		attrbuf = kzalloc_objs(*attrbuf, NUM_NL80211_ATTR);
>> +		if (!attrbuf)
>> +			return -ENOMEM;
>> +	}
>> +
>> +	err = nl80211_prepare_wdev_dump(cb, &rdev, &wdev, attrbuf);
>> +	if (err) {
>> +		kfree(attrbuf);
>>   		return err;
>> +	}
>>   
>>   	/* nl80211_prepare_wdev_dump acquired it in the successful case */
>>   	__acquire(&rdev->wiphy.mtx);
>> @@ -8369,15 +8640,22 @@ static int nl80211_dump_station(struct sk_buff *skb,
>>   	if (!ctx) {
>>   		ctx = kzalloc_obj(*ctx);
>>   		if (!ctx) {
>> +			kfree(attrbuf);
> perhaps better to __free(kfree) instead of doing all these kfree()
> calls?
Yes, will use __free(kfree) for attrbuf.
>> -	/* Phase 0: dump aggregated station info */
>> -	if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
>> -		while (true) {
>> +	while (true) {
>> +		/* Phase 0: dump aggregated station info */
>> +		if (ctx->phase == NL80211_DUMP_STA_PHASE_AGGREGATED) {
> changing it now also kind of argues for not having it in the first patch
> in the first place ;-)
Noted, the loop restructuring will be moved entirely into
patch 4, not split across patches 3 and 4.
>>   			memset(&ctx->sinfo, 0, sizeof(ctx->sinfo));
>>   			for (int i = 0; i < IEEE80211_MLD_MAX_NUM_LINKS; i++) {
>>   				ctx->sinfo.links[i] =
>> @@ -8428,15 +8706,45 @@ static int nl80211_dump_station(struct sk_buff *skb,
>>   				goto out_err_release;
>>   			}
>>   
>> -			/* Reset ctx for next station */
>> -			cfg80211_sinfo_release_content(&ctx->sinfo);
>> -			ctx->sta_idx++;
>> +			ctx->phase = NL80211_DUMP_STA_PHASE_PER_LINK;
>>   		}
>> -	}
>>   
>> -	ctx->phase = NL80211_DUMP_STA_PHASE_AGGREGATED;
>> -	err = skb->len;
>> -	goto out_err;
>> +		/* Phase 1: dump per-link station info */
>> +		if (ctx->phase == NL80211_DUMP_STA_PHASE_PER_LINK &&
>> +		    ctx->dump_link_stats && ctx->sinfo.valid_links) {
>> +			while (ctx->link_idx < IEEE80211_MLD_MAX_NUM_LINKS) {
>> +				if (!(ctx->sinfo.valid_links &
>> +				      BIT(ctx->link_idx))) {
>> +					ctx->link_idx++;
>> +					continue;
>> +				}
>> +
>> +				ret = nl80211_send_link_station(skb, cb, rdev,
>> +								wdev,
>> +								ctx->mac_addr,
>> +								&ctx->sinfo,
>> +								ctx->link_idx);
>>
> I think conceptually this code is structured a bit strangely. It would
> seem a lot simpler to me to do something like
>
>
> 	// not literally such a macro, just the while (true) loop
> 	for_each_station_starting_from_idx(...) {
> 		if (ctx->phase == 0) {
> 			// fill sinfo etc.
> 		}
>
> 		// common stuff
> 		nl80211hdr_put()
> 		nla_put_u32(msg, NL80211_ATTR_IFINDEX...)
> 		nla_put_u64_64bit(msg, NL80211_ATTR_WDEV..)
> 		nla_put(msg, NL80211_ATTR_MAC...)
> 		nla_put_u32(msg, NL80211_ATTR_GENERATION...)
>
> 		switch (phase) {
> 		case 0:
> 			nl80211_put_sta_info_common(...);
> 			phase++;
> 			ctx->link_id = 0;
> 			break;
> 		case 1:
> 			if (!multi-phase-requested)
> 				break;
> 			nl80211_put_link_station(..., ctx->link_id);
> 			ctx->link_id++;
> 			if (link_id == NUM_LINKS)
> 				ctx->phase = 0; // next sta
> 			break;
> 		}
> 	}
>
>
> or something like that, more like we handle wiphy dump with all the
> messages, for example?
>
> I think it'd be better to have just one place that creates the header
> and all the common info.
>
> But maybe it's just my brain pathways being trained for that scheme.
>
> johannes
ok, I will try to align with this suggested model. I'll refactor so the 
outer loop
produces exactly one netlink message per iteration, with header
construction in one place:

while (true) {
     if (ctx->phase == PHASE_AGGREGATED) {
         /* fetch sinfo from driver once per station */
         memset(&ctx->sinfo, ...);
         /* allocate links[], call rdev_dump_station() */
         /* apply cfg80211_sta_set_mld_sinfo() if needed */
     }

     hdr = nl80211hdr_put(msg, ...);
     /* common attrs: ifindex, wdev, mac, generation */
     nla_put_u32(msg, NL80211_ATTR_IFINDEX, ...);
     nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, ...);
     nla_put(msg, NL80211_ATTR_MAC, ETH_ALEN, ctx->mac_addr);
     nla_put_u32(msg, NL80211_ATTR_GENERATION, ...);

     switch (ctx->phase) {
     case PHASE_AGGREGATED:
         nl80211_put_sta_info_common(msg, rdev, &ctx->sinfo);
         ctx->phase = PHASE_PER_LINK;
         ctx->link_idx = first_valid_link();
         break;
     case PHASE_PER_LINK:
         nl80211_put_link_station(msg, rdev, &ctx->sinfo, ctx->link_idx);
         advance ctx->link_idx to next valid link;
         if (no more links) {
             cfg80211_sinfo_release_content(&ctx->sinfo);
             ctx->sta_idx++;
             ctx->phase = PHASE_AGGREGATED;
         }
         break;
     }

     genlmsg_end(msg, hdr);   /* or genlmsg_cancel() on EMSGSIZE 
break-out */
}


This eliminates the duplicated nla_put_u32/u64/MAC header blocks
that currently exist in both nl80211_send_accumulated_station()
and nl80211_send_link_station(), and makes the EMSGSIZE bail-out
uniform since we return before committing the message.

should the rdev_dump_station() / sinfo fill stay outside the
per-message loop (as a separate if (phase == AGGREGATED) guard
at the top), or is it preferable to fold it into the switch
case? I've sketched the former above since fetching sinfo is
logically per-station, not per-message. I'm also ok to adjust
if you'd prefer it inside the switch ?

- Praneesh

