Return-Path: <linux-wireless+bounces-35501-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LoIBCvE8GloYQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35501-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:28:59 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC371486F79
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 16:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 307CF30379CF
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8823746AF38;
	Tue, 28 Apr 2026 14:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YeSWX8zH";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PepiAa20"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FEB46AEDF
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386222; cv=none; b=nOwkkeLgNTd+7bgc/a2wdr82PvKhENvDdND88gDlJZmIlL/yOMMEapOpIMHuq6cbj5r1kedj20a1GDOexML7CXcV/cUh0TwEOIYSoDy92Um64UaeWZui8aX6cWPrsGfIECy75QuBhLW1rUdk0XUm91MiXk6y1n9EGtkuhnjBuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386222; c=relaxed/simple;
	bh=2YNsiTXzXOv2m74/OS8Ei+h+JPVuKtHh0iQ7A9nDFxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gWT1P+zLYZgzNiNpFdGOxzMPVW0dXc2VDEEQWsE9le1sRENdL1Au7xM42sjOY4tFtW9AZhSoLvVlo7PF8guVu8CGEfONc02OkIP//+jQoOxeKkvvUI9r6ihn7i2BbbUOLgkfcRmoTGy2baEx6NksKuO0oxlDTtPnSWkOczinPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YeSWX8zH; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PepiAa20; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SDovaG3967993
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=; b=YeSWX8zHTFpVjfOZ
	1TvwasJuLc6tZR6qWVFZ5/D+VqQMOc5XEvweZtcjneATHIW6Qam1L/asVbiW3AFZ
	26ZbDI5WXvtwX75MY9/gSWNQZ81zHkfIhQT9B0H8JthJVrJ3ECPsvANPZwBTtYC0
	rfCzp4COezjGHZsbLcyvA+x45yKA151lSZTykgAGtkd+lnzXjjkPRKZwoGH58sx3
	4nU9qonJVXMWLo1C6xMuYNaY7IrL48Aam/0GCGn/EM/YdT9ZeL3OSeeqxAzhr6XM
	lq0NmTjSP34soslkXXI37NPJo0HbNZsMFHnRwBoFdVIo5R7Q7h9SiR/oIdiwqz7r
	wyvXAg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtry0hgsu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:35 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2d93379001eso27343606eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386214; x=1777991014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=;
        b=PepiAa20QXOwsbUCYBuK/ape8Nz2spomDgKN6X3hemnWovCIG9/OO48ohMtjrY4TrT
         HeGuWYc3+NI639YOoa4C7lfNCRXIMAzo9X/Ng2TDM0cwUvv/UriqXMToA+aed98B4F4n
         GCmCpsuw/T6sQ717FXUAptQDo1K0TpKa4cUmIPAfoXNAeiYnDxlln48ROOpYS8og9GtC
         jrpqy3fXUknZMNHzM4YZrk/NgVL8et8Rt3LtS1oUzMfAJZQuxq+CRH/BM/z2lDGG8/tS
         Af0jQceVsBYoEuk6eQ682wR0F3X5QzB+LYFLd9gs8lng/5u6a8+lLgitl/OS7UJuaHaC
         8GQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386214; x=1777991014;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jmxuff+2VurCFsBMSjVHjuC/5j3liv6ORO4lRuTXi1A=;
        b=PAfYb+48ZExYjfTwYpPMvLiAWioKYVc4G8qh6RL6ZbRecrCscvtEdeIk18Cr1/Uwi6
         FhrdHu/UIe5SmPgTem0PMDi2keluKUb7DSwAFl18c134txPJRbxpMmRzaL12iHMX/6ux
         k7k8wAoJNtYbYkJTw62BBBlIb9fhMXNTdD25dSP5R+DlfVCYARrPH9bHbMdGkRodNLo9
         oO9q3Wcel423uO8NB3xprAwSZjpAj4/tHqfIOVdqs8Sti4lghGfdRk1IE1YiwQEwpwmu
         v+al2Slllv+7EWvjnfSyL0O8FUQAGf5UPTCsB/lS3cqoqRxoXpWyghBXGOMoQ5S3Vh68
         GPpg==
X-Forwarded-Encrypted: i=1; AFNElJ8UdCtEmSeijOSEE/MZ1LRF/0h6v0X6K92kUOMHNceMiLojQHuuEQcJpLGK2kC9zhGumHPWjkiWMpfXHV2dBg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlijTofPsrlSkzqsw1N5VyZIuDqZPD8+4+yl7/og9GQYRwdBQr
	EqDnFIy5np2+OIbk/4kQKEiAOvZ4+5YGZ2qiNbVOZT8OsvwyKK8lfr0ruirxJAeNbh4PBTzvnv8
	3g9L65+uMNLJmiJJ7m/hocM9TF+ZJQHSdRz9VfiHwTqfYvCqystDjJ1qdfiE5h/mD94zNIw==
X-Gm-Gg: AeBDietxc/QTuqpmPoX7ZanLELDXd7xcfveb5XoIeEmQGmlhyBqE7pvMroyx1PN4kPo
	wryDwKpZZx7OT/eakRoh7JrOqrPfXVYzIFTwpMFisDhFTnJN28HAHNIwZ8wISPSkW8UaMS5Cawb
	VIgKjPXdKLZwDOHZnGfAxMt/HNOCbEE3rCD7HrS9bq0mvAcz/GtGLutj4ISKtqzZIviu6WgSszP
	og9pBQpxqFQ9GJxnxpyyF2BBe2DBaC5n0mcDob9LoqmwKktl6rqT6iSeYzBXlOznHTMp9PzvT2+
	Jwadf5M3adHB2IQkDQzyxsTA/H6riEWMjZbAC51FcHzun2r0FPEZrRqtzWYnNYWmsOyqRu76hvd
	vLXottH53RBXXzPadbAAUX7LJycw+SN7BYnGNQGezykXp8ZL6JbPAJnjS442U8UqDNy+Ac+8ruM
	BlASa9jPLYtFTctlJ0PDgAmUpK
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id 5a478bee46e88-2ed09fcf030mr1547166eec.7.1777386214144;
        Tue, 28 Apr 2026 07:23:34 -0700 (PDT)
X-Received: by 2002:a05:7300:a148:b0:2ca:8099:ffc0 with SMTP id 5a478bee46e88-2ed09fcf030mr1547152eec.7.1777386213538;
        Tue, 28 Apr 2026 07:23:33 -0700 (PDT)
Received: from [192.168.1.47] (c-24-130-122-79.hsd1.ca.comcast.net. [24.130.122.79])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a10678csm2467904eec.24.2026.04.28.07.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 07:23:32 -0700 (PDT)
Message-ID: <17d5b91c-026f-4539-a39a-cfd976860273@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 07:23:30 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: drop stray 'static' from fast-RX
 rx_result
To: Catherine <enderaoelyther@gmail.com>, linux-wireless@vger.kernel.org,
        Felix Fietkau <nbd@nbd.name>
Cc: johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260424131435.83212-2-enderaoelyther@gmail.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424131435.83212-2-enderaoelyther@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KuJ9H2WN c=1 sm=1 tr=0 ts=69f0c2e7 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=Tg7Z00WN3eLgNEO9NLUKUQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=vluirgkKQf0QiLCMEdgA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: pKUL7TOrP1NyP3sjhwbZnnsQWRBdosOs
X-Proofpoint-ORIG-GUID: pKUL7TOrP1NyP3sjhwbZnnsQWRBdosOs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX8hVsfAs9CU39
 5QdAL32PjnH8uem8V9kzGpgu+0sK7YkwRmVgwfy7ayb8Jcb57Lx8wV/lGVMdExWlDkbETM0+iDd
 eZBmmzL6WZuXVXXLHpw2IkvuuZDgPAnMX9h5I9dqEtwtAI6ox611Rfvsut/9TcYxtySu2LBXOcp
 InMypzeNh5u4n/FmUn7jbKAxrd2o8Pv1wHUGLpE4R/V4COv6dr33cWRbg79d2dGQKwM6DIDXn7I
 9Np1zngPKONwRkFoeGWkoskU31SA/lIGeCBqEg2lxYK/+QN7FiUq3G8s9TNodCN1cLLKpFpd+c6
 YX1w/dcGc3UDPpXQ6+M7vdvMw1tP9YvbV8OFuY+IlyA3YIjssQuEPyeFA+I4ySJt6ZS1vNU1jv7
 bRqyCDirbKXvbOMwyOKScORFp4+NYpJUf9Z/pehYzkaRWTv0emq0ipiS3XnDyeIog3STaPqIT6b
 BBTNNc2zHGl2WCQpOfQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280136
X-Rspamd-Queue-Id: BC371486F79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35501-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,nbd.name];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/24/2026 6:14 AM, Catherine wrote:
> ieee80211_invoke_fast_rx() is documented as safe for parallel RX, but
> its per-invocation rx_result is declared static. Concurrent callers then
> share one instance and can overwrite each other's result between
> ieee80211_rx_mesh_data() and the switch on res.
> 
> That can make a packet that was queued or consumed by
> ieee80211_rx_mesh_data() fall through into ieee80211_rx_8023(), or make
> a packet that should continue return as queued.
> 
> Make res an automatic variable so each invocation keeps its own result.
> 
> Fixes: 3468e1e0c639 ("wifi: mac80211: add mesh fast-rx support")

@Felix: Any recollection why this was static in your original patch?

> Cc: stable@vger.kernel.org
> Signed-off-by: Catherine <enderaoelyther@gmail.com>

Is this an identity you commonly use? Note that anonymous contributions are
not allowed:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>  net/mac80211/rx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
> index 3e5d1c47a..8719db8f3 100644
> --- a/net/mac80211/rx.c
> +++ b/net/mac80211/rx.c
> @@ -4971,7 +4971,7 @@ static bool ieee80211_invoke_fast_rx(struct ieee80211_rx_data *rx,
>  	struct sk_buff *skb = rx->skb;
>  	struct ieee80211_hdr *hdr = (void *)skb->data;
>  	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
> -	static ieee80211_rx_result res;
> +	ieee80211_rx_result res;
>  	int orig_len = skb->len;
>  	int hdrlen = ieee80211_hdrlen(hdr->frame_control);
>  	int snap_offs = hdrlen;

Actual patch seem reasonable..

Reviewed-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>


