Return-Path: <linux-wireless+bounces-34629-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id DNEAOgAz2WmjnQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34629-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:27:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B1E3DB092
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 19:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38556301ABBA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 17:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C625B2D061C;
	Fri, 10 Apr 2026 17:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hR0x3ssg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kKo+vE2E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2BE3E3170
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775841901; cv=none; b=nLbw2kLx9O7ppS51UNl93Q6rqdNWQbIqEIlRmapTAG17h9Y38qvop49p6egvX6gnw5V2FF3PLw5HGp2LhGdpRSzEXKlDpw+GXP7IFw1Ht5G6zec2Go4/bxzi/K6tux/1ceIPF+oZ1ObAaKiPKfIljsywpQ+ouo1JBlMeXueEAr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775841901; c=relaxed/simple;
	bh=JKSnDDrZ6Lv1LamS1CZSeQDsS6ISs3SMwbKJ2qiI76k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LzjKg8Q6+iF+U4rqeyGDkWg8Q+eJSWG+BnjeT96UHeZaALjYbFyDQoAnUUbdAk+8pKm/pb215o2vv/kby8nUkJmn3QPNMrUNDU1ufKTR8b6o2QWxacTaFBSNNEF00mQotlbTrkzNWkNxMPD3LRq9hNU5Gt/pym3o4peacpR7cSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hR0x3ssg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kKo+vE2E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AB1EWZ439252
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	00GeDMNx7RKmjuMjFBmecTqNfe6Wa/hevNh9tOoGk0A=; b=hR0x3ssgyyaoZqTE
	ENBBmU8k4mYN47sGCcoukhdpuye2KaH8s1vSefhWM4J/lQsIsJ3fEjwXoLITBTIc
	9Q2An2d9CS2RiUHrjyebeQpzMvOOG1hHCsCUBv/avSPKGltXzyd4P8wXRwa5ZGz3
	NyJmEW662stH/t2X1idJo7AkNH9ZEm8/Hni8TY2XyjiU7NBa4cvnt9N+tqFv7Duo
	S4uu32lvTm4ErWwy2gfY811JI4b33LtWcUXBST6FClicLXPTZBJYFPn1xOwLwVpV
	lkvmElDuryexpv8ydp+mJr/ldpi3SQyRzt4Yb4V61+tZyREnmrGVjWiwC2T94NRe
	sqm6nw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deyy9s6xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 17:24:59 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-126e8ee6227so3233700c88.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 10:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775841899; x=1776446699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00GeDMNx7RKmjuMjFBmecTqNfe6Wa/hevNh9tOoGk0A=;
        b=kKo+vE2EAJyEJ1EX1LDSeYU0BoEG1dmiXaoReGhFtwW5uCzpwFTpQSe/xLT9bhu3y2
         FwGWcXkUiohpPBOrys7SdpxhqFXHpYBkKqITjrCKSh1354Lv9Xe93djMEtJz2j6vq4Te
         tS0lixPEd/+nGT9HQfecoyBzHUt5JDiacPdPtMVPfvf/0IhPIaEnqZbxrdcbCXWhtFXA
         YtKbVkGcL7Zu03Kf+L8CwVi166ca2lWFDN8n3+6Lu3V/iCFHtMy/nPurqvBfDedt+2t1
         BbW796YioKR9Og1325KFY3QZ2q676F4/1j35LbhzA6JxYLAJzVQe8csQLe4O5wxXMc93
         pBtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775841899; x=1776446699;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00GeDMNx7RKmjuMjFBmecTqNfe6Wa/hevNh9tOoGk0A=;
        b=LH/6/IWsC/EVIgxuTGi/ZUKpipZNu7KiewCUIRyWC0PgeRw/WV6jOSrZipa1SsTFwB
         fzZN1/L2wJ03lYeojvldwe5MF8vN2MsL4N55lpQ3t/IQkLJgr8/6Z1OI+allkfyLb5XM
         o0x8+xczAJDj33joJTxK72Fe/ZV40I4tx04pa0OUtWeqTTTT7qcqNd5DE++D40SbYwcy
         auK3Xoo8YJjFd2NVqV9ya7lNhWNkiUkXL0+VRchLUoLCKMd3Ngv6p1oBIxvgXljZ1/yu
         ZjRliU+JXJfNgm5UdwGv0jetgXqYS8Sh2bk3v1YQIM405X6fE1OtJ3VIbnPlPTUmAJrL
         y2zA==
X-Gm-Message-State: AOJu0YyDYRsZTU8JpzGB3KIahkm/74/NlO8NTAHjTcZuxXiSvx5j4z3v
	RsGeQEkDkX4cMa74NumkLY5bmPDKg/uMK8Ns2C/Hkuq5fXzUK2ycrLF3JT6rtWg8vsMaUb4sKHa
	b8aAraHEs51sKW7a7P2nraG21Lw1sIqw1W4Y1Wl1gNa/F0Gv+m2JVYrd57wiZTAOCw3WLgw==
X-Gm-Gg: AeBDiesk4JAwkpO2fx20Ijg+ZI0oLr/vaRe3NHmG9FHSE1xe4CvxsdSNf1Nkn9NfQh0
	nFGYvTiuaJLE3rDO5rEAd7sNlmjqA9hZxxu9eZz/ElocEB8cYwAXly+7sOYzphfClCA4k2xil6j
	h/l1UgT4Q5V/TAyLIdeERDoO9lOECOhyWgEHy9cYHYTASRwYeMXpqA/FMQP1PZtUOMiS6O6427g
	JAZk6Ok0iJ9JvYGEylyiQOs/yNSeIR9O4yDVOyEKCXduLoupAviImbT22+oazSeR2Di6cCbiYuC
	3nB8af2VcYkXxXM2bDrQ9g6q4xJ1o3zzr7O23gPZc2E97SsaO5kn5Zim+rfmu6Q+uXQ9JPbth0B
	TQZajJZ1HQ3vaLqpaDVUrqEN2cn5l64mxccdV0WARmWUO8jeKxpxqEosqmbf6hHJS9cVDO37rPY
	RyGEqgrLYC5Ba63Q==
X-Received: by 2002:a05:7022:e986:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12c34eddbfemr2201569c88.21.1775841898578;
        Fri, 10 Apr 2026 10:24:58 -0700 (PDT)
X-Received: by 2002:a05:7022:e986:b0:11b:b622:cad9 with SMTP id a92af1059eb24-12c34eddbfemr2201544c88.21.1775841897967;
        Fri, 10 Apr 2026 10:24:57 -0700 (PDT)
Received: from [192.168.1.44] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c346eb228sm4763760c88.9.2026.04.10.10.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 10:24:57 -0700 (PDT)
Message-ID: <bb391f8d-e385-42b6-adec-171c21c67246@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 10:24:56 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next 1/5] wifi: ath12k: handle thermal throttle stats
 WMI event
To: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260331142446.2951809-1-maharaja.kennadyrajan@oss.qualcomm.com>
 <20260331142446.2951809-2-maharaja.kennadyrajan@oss.qualcomm.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260331142446.2951809-2-maharaja.kennadyrajan@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE2MiBTYWx0ZWRfX3FQTrsEJkYI1
 SiD9fZvK514gJf7Hf3TUkTw3nYvgpnRWvfYNgE6tZ87auoZ2mqsEgP8/8/61mHnYTLuSds9Syla
 w/rnKHgLNKjRD2VODBYOfFCB11qHwxIGYKC4n/zVykXU6PVPDSlJGTjrVjQ3l35nU5k+Jy0lJzQ
 s5VURg6MY1tmZ0Vz3k1Lbtge6Bjsm2QlD+QuAh5ykitETRjBWnu2YStV7gFQ3LpivkwSD6Sck4c
 iQnrXzfcdhRpVzx2QjJ1YylGZ1I6qvk9c9gZSxOUKUqSvZZquNqOCH9DfU7iq+OmybaFYgxhH62
 h3IDtEzkacgUYjP2FZSOYcYemHHoYPHbJPlWcfoG08nm6+GchfTfczocrFYa7Jf+x+hl/JoIIkK
 QKMaVaSD/dT70Ch2Tj38mkBZA3fU0l/1c+gtpgOk3ygu3F8+cJDNss98oTHFNPN8niy2SITDVdO
 DVyDEtkvQtZB3dAHkFQ==
X-Proofpoint-GUID: 3zZIInljkVjNMGNDmoYQcJO2tUxerxby
X-Authority-Analysis: v=2.4 cv=d6fFDxjE c=1 sm=1 tr=0 ts=69d9326b cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=pGLkceISAAAA:8 a=Gw0FSAZAoS1PqQJKRVgA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 3zZIInljkVjNMGNDmoYQcJO2tUxerxby
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_05,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100162
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
	TAGGED_FROM(0.00)[bounces-34629-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 40B1E3DB092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/2026 7:24 AM, Maharaja Kennadyrajan wrote:
> +static void ath12k_wmi_thermal_throt_stats_event(struct ath12k_base *ab,
> +						 struct sk_buff *skb)
> +{
> +	const struct wmi_therm_throt_stats_event *ev;
> +	struct ath12k *ar;
> +
> +	const void **tb __free(kfree) = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);

please rebase on current ath-main, this interface changed with:
https://msgid.link/20260407095426.3285574-1-nico.escande@gmail.com

/jeff

