Return-Path: <linux-wireless+bounces-31475-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEiHGJnhgGnLCQMAu9opvQ
	(envelope-from <linux-wireless+bounces-31475-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:40:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA191CFB21
	for <lists+linux-wireless@lfdr.de>; Mon, 02 Feb 2026 18:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D61FD305580E
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 17:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF6B304BB8;
	Mon,  2 Feb 2026 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="geNLLVtu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwPbIXUl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40D2798E5
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 17:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053820; cv=none; b=oUxx9EzoGW9Im7OvXhzpluz/hbWncaFBw31wYgGKYiYS9DRGibu5/S7vadg2UJjl3uDEXIjiqpFMNVXe9EYXdjrXUE0s70BQKBrPfgwpOiTh21KT/AUYowY/PYitCp2iC8IHH6t1v/3xSRQoDN3JlmIhOeeC1j6WHElZpcnUR7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053820; c=relaxed/simple;
	bh=RadjGQfsAR3AUbA+1T3tORsQ0s+JQxUUxI/ZudOjd9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PjeOdVsPQwNcEVePa3PogtOTWWkV7kRV6sHgMsi9lGEWZgejz2BOVun2rV3G/gBaq19p/kewVoq9+zm060+tTOjh7KOCAAzYg8tZXFm88MRUOX0mUQmgW1tIXmFFe8CYq4i+keSmOVLEkwaoQ+R0R5mPVIwdp7lR5gUlLLqJSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=geNLLVtu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwPbIXUl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 612BAQm93082911
	for <linux-wireless@vger.kernel.org>; Mon, 2 Feb 2026 17:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f7+JHIyrmAOjeQGwaoxdMCsuq2E53N28ME7+UV1tYNg=; b=geNLLVtu6YyN16wI
	I0KarTDFObOlMFMdFC0TPEAA58mD4hT8Eck81PqkfZggEDd+YnBNRMfFafA7Rt5q
	NJnhq0SYe54SdPV26ffoLCh4e5Huu25Qwqz1G66WMihSMuYJXlTasXQO+9lIENPh
	6PUCC3Er7zxqbn1zBWbttkBdIHBaOzR0y/BBFcKW6L61ZwHDUx8+i23ZTyHCVsbC
	eXhY0po0euM9iNxfz2PhqZwq8Tog9CtQMZxk3GIwAnesnOijA7NaS3k/lCGomRCc
	jTMz8GU637FBp8Dc+eHQftFzEGeQycT+MQRgAOsC87gN6jH4qpTIE20R5iZ7uXI3
	Cc2HGQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c2ttn168u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 17:36:58 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3545cc84ab1so3882155a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 02 Feb 2026 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770053818; x=1770658618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f7+JHIyrmAOjeQGwaoxdMCsuq2E53N28ME7+UV1tYNg=;
        b=ZwPbIXUlhtFgMg/GOKZrnOma2n2ldJX3YeUYJkBVeBA6HTGFbh8VPKm2RSMaGlDklR
         eTlTU9nwRUwVJoLg8hQyUxnJ4UxM8kvsN4fH8KHB0oJcjbQXbsrKrID7E/0Kw681Imoj
         9dJZVeasIH8B9OnFke6E9VJAxzeiha98O3oiCGcQIUWOMKx59mxgJ5g6TT6rgVl1fJoC
         8AmnXl93V+msRX1Swk8tqpaeEvHass15NMTklS+nbBsw8Ihlm+1gqLcww4pGgpzg97Zv
         aCayxtamP0/EAUixnssXyP+F8c295L1z+8E34Gdzec8SJFUkccWUScotTQkZr1OSy7ym
         REdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053818; x=1770658618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f7+JHIyrmAOjeQGwaoxdMCsuq2E53N28ME7+UV1tYNg=;
        b=neXqNs7c2+H0GIoHAU6d0pqdrF5rsGkJK4QEVAUA+hPgsonBagGEuPuJOtgPBSPHo+
         Ukry8iE2WSIGBz/MeGOrFvFyyJOM9HlOsdKdYp8v6LXGLseHACI+rgPNXCF6ydOUg1KM
         DaDTaU3ymeowsQYf4qdZoljoMd7FA43XuUri2KvbI8h2lKxw8H97pyULsD89aP7nUqCG
         UAwOQMj9C2hMpTKJb5sDF0+bvCyDTHaHa5B5Z7x1UhT/ZHPC3sgm1W7HW+dSgcodDL8e
         WYFkwgcmkuWy0c+I89CYIMF4JXHndjl8Ohvf5PWJUuKzus3NZMMkxcDRdUoJ6jlyWZuI
         ESJQ==
X-Gm-Message-State: AOJu0Yz9gHLwTqA7N7iu9yM84RrOTOimVViEol/2tqzVEh2Sz6s8NAIl
	4TnAVOs7nQQXzzw97cpsf6GjREiLrpzhBaU5Hb/JZ6Gxhgks7ymwv7K/I2amr/kXSNgPnKCXzp0
	GS7YYMg1+4MJECJMjNCln72yiVKjAxzQp42GTMVLDKOn/MT0EYbYTw4cn6sg07dEZSCmQyyTLUP
	QqTA==
X-Gm-Gg: AZuq6aLwy9kR+bcsODG2uGwTCIlRYclS35SYBcoRLXg89B6nL13k7Um8i2cUl0nybsp
	yrXHctKYbcMs565v5DX5nHj7EAXAtNUxyewdJ5xWwT60JaEUu5+63SOw4bpVjbMXT8zHBTkJs9S
	NVj3bc1YKL/droZhSnRNHs9oWaIisZXLoA4st/fWbsDyOiGdtIgZLt+gTaDlhWbOqWlG6t5q7HF
	WYPPJMbUvFX2lJ3zXXcgiaOCH6W8/ESAC70OLePGpjXws7evQJ8pMe58dYQnjQkG1ZxEbvJF/T8
	XVoF8xTVbaqi5TjRIH1RKxcAgJU7chUx7U8H0tMpjA2C1c+5U4yaHeSVz4HWQwlDVLgxYrJvUZ0
	DlsZQxB/jgu/Mh8PJZ+S9x+PHkoJJwBQMFENWERDOEHEvWaf6yvQ5RgZTYe6Y
X-Received: by 2002:a17:90b:518e:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-3543b2dcb97mr11742173a91.4.1770053817889;
        Mon, 02 Feb 2026 09:36:57 -0800 (PST)
X-Received: by 2002:a17:90b:518e:b0:341:b5a2:3e7b with SMTP id 98e67ed59e1d1-3543b2dcb97mr11742144a91.4.1770053817441;
        Mon, 02 Feb 2026 09:36:57 -0800 (PST)
Received: from [192.168.225.142] ([157.49.220.36])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35477615e26sm95773a91.2.2026.02.02.09.36.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 09:36:57 -0800 (PST)
Message-ID: <79513966-f167-4347-a7be-8b5279607a43@oss.qualcomm.com>
Date: Mon, 2 Feb 2026 23:06:53 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] wifi: nl80211/cfg80211: add LTF keyseed support for
 secure ranging
To: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>,
        johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
 <20260130160039.2823409-13-peddolla.reddy@oss.qualcomm.com>
Content-Language: en-US
From: Vasanthakumar Thiagarajan <vasanthakumar.thiagarajan@oss.qualcomm.com>
In-Reply-To: <20260130160039.2823409-13-peddolla.reddy@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=ANnNY0ku c=1 sm=1 tr=0 ts=6980e0ba cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=QJnItKZWF5a8ZOS8l1mWfA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=wsImeYzS_r9ar6XK3RQA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEzOSBTYWx0ZWRfXympMD5TNiSV7
 u2ecarBfmKaz6n/9+HdeEeq+x/o+dPiKXHfC2RJavLW1ENlw3VVYkkBEPf1vbLVFkVDmT9xLWBO
 MuPZMfOF2oMwgPf+yT3QwLVR3vv3E6OJt+G0PBfNTNsux39P6+TxWyWQG6f9rVdwXZk3g8vBSMB
 aR8UmjBtaSU18gdr0tyMEXOUOirhEkqNd69Q0wcIVRzRZ3K1K5tXqSB8t1zo8a57FL9Yv2pCx+j
 WWTZbeMJ8zpWq7J9VLGNLMmLOyReDUUUiECMyo0KRdXVyBL7K6+jsNbEOuIktWfHvuGpoxKen1S
 SG9x/AXDVEs3xhocNFWnTqXG4wg/sfM+SoY17xwcwgTUsGA+bSJgH1GqDdYam2Ys4QVbzi+zgnM
 bazGVmBUlv3CR4yarWDN2cxenwVNiCgnPe23mLFyB4LVlaFilu50X2JUZ2LqyIPRX7lHYmH/4FT
 3h1wsbyB4VdeWW9txIA==
X-Proofpoint-GUID: DMHcYIKy4jffOLYidZtNzY9aSQNBPw89
X-Proofpoint-ORIG-GUID: DMHcYIKy4jffOLYidZtNzY9aSQNBPw89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_05,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602020139
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31475-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vasanthakumar.thiagarajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BA191CFB21
X-Rspamd-Action: no action



On 1/30/2026 9:30 PM, Peddolla Harshavardhan Reddy wrote:
> Add NL80211_ATTR_LTF_KEYSEED attribute to support secure FTM
> measurements. This allows drivers to generate secure LTF keys
> for PHY-layer security in ranging operations.
> 
> The keyseed is used with trigger-based and non-trigger-based
> FTM requests to enable secure peer measurement sessions.
> 
> Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
> ---
>   include/net/cfg80211.h       |  2 ++
>   include/uapi/linux/nl80211.h | 15 ++++++++++++---
>   net/wireless/nl80211.c       |  7 +++++++
>   3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
> index dd45dda7e619..ea6b9c994455 100644
> --- a/include/net/cfg80211.h
> +++ b/include/net/cfg80211.h
> @@ -800,6 +800,8 @@ struct key_params {
>   	u16 vlan_id;
>   	u32 cipher;
>   	enum nl80211_key_mode mode;
> +	const u8 *ltf_keyseed;
> +	int ltf_keyseed_len;

Missing kernel-doc for newly added members.

Vasanth

