Return-Path: <linux-wireless+bounces-35573-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDX8D5y18WmjjwEAu9opvQ
	(envelope-from <linux-wireless+bounces-35573-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:39:08 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE7049092B
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 09:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38AAB3009CC3
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2026 07:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABC37E30F;
	Wed, 29 Apr 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="prRYYcvW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zxw0vysW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906EC3890FC
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448192; cv=none; b=szRxW7Y/9fOA2NXpmAQPB6dKa0nS3k+0d05v8tkLN2YzmKd8rctsdMxGyxpU4cWB0+UXd13uv3Eurqmz6kvDOU5I44x2XHgMoV15VweblNghkaZrzZG2dtfKs4kSlIlSexL82XuJzPWy6KIgnMVkUKNA7zxqN63E16OjyLkhRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448192; c=relaxed/simple;
	bh=mlLkDuHz0/eaR4+ixi5FAogkfeWosSCmuKz2boLoMMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq9vxPNCUbLBJoUt97XkmUMIzy1D8daRbY2Zi0Ww0iM4ubp5PjKMDgvZywbvD+73RbZ/4MW9EpogAMlG72wiDeDO6o4EfNezuWGZzA+OReHeruQT5RGbizdK0E6XIX3nmtLd2w1yU50/cfkisD0Ibr1vMgX3Lq85hF3yNrChsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=prRYYcvW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zxw0vysW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63T3sVkN018575
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sDWgIDq5XCnUvo9INAHbb5YVPgRJthGn8S98sJx+YIg=; b=prRYYcvWAHrxiQLO
	Bni57N/Mib0yWKf3XhN0nypyILeai5UBJeS5K3poYhFPOY2jQBaU8lPpUqolY57J
	SJcngiS5wzAkFS4La/BgyHINalMbDrFSg5Ok1HshSbcVup+M3fcd89UgfPUk1MXe
	wWEz4baRVV6VF0pclWim+8NhnlhplDCHUmbJT1/b7lF8P5lPtuwi+Rf010ds7lrm
	LVJDTK13kPRc8V+B2jxaCpY4ILmtGsNkv/oxL9dsQ0XEfQchT7rMuSusW9vxZMSf
	0r4KNs7sEH3hnp72Uej7z8nno6amO/u1nOGnXT+RdB3imr8RqoPlGXu98glXKBH5
	9AJnrw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4du1eeak4f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 07:36:29 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b2e6ee9444so6074085ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 00:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777448189; x=1778052989; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sDWgIDq5XCnUvo9INAHbb5YVPgRJthGn8S98sJx+YIg=;
        b=Zxw0vysWYBWHH+2G7ntsop/w+IveO+gAZo1lFdhdhD26NPFPVGc5bbD7WUp02H5orT
         6MII4y2b64sLTMiAmbj117tnBMs6jF2pMY3rrSaivHe7/RUIr5p1OvAm4V+O94XQMKA6
         KGvnTSNXYWORmIK6nNLw/SlaUGH2TSPVxIyjBhW9LO33wf/J+z/kVC3nT9WKq2OPfYkK
         Wxw+m2TH0SxWQpRX0Bg3ARj3eeb1tpe/p48w0Y2Qn6piqL1iPHF2qQj4kTVVhzGea77a
         pHKwsMahpwCkycWa6S3OkSYwvdQi0rmoQgtvZcw1Z/K08oKxofWZEFYjLCH2MM92pgtM
         rnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777448189; x=1778052989;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sDWgIDq5XCnUvo9INAHbb5YVPgRJthGn8S98sJx+YIg=;
        b=Kez9H20DgmygIjY8aan37aOx8tdp5rBvmQdreEcddVcIScC9JyH+hRbNwH/ns0AjAB
         NnHkH4DjwVWbADsU6c/WZQQ9k9AJ963e2vS5gMdGQIE4KwCrC7zZKQovxrtwWvseY69o
         1Mo3tiaJWMtcPahP/re3bGfveV4WZfjxlgldhaIE7ovpA4xfaA4PgzQugJS9MLSnDyGc
         LWIqx6J8d1c85kkcGSZboVEALTziD7ks1uz2xdteu8/PPIsjMZtwaskIZU/W+upqLOdl
         LtAuaEEN7/sCwYqjsURfIjwQ4kiJJL7MM0izGbI5srXc3wWw0f+DqMzF/mTA8+3C4jfQ
         fEdg==
X-Forwarded-Encrypted: i=1; AFNElJ/J0+iAONF7y7/tBqAce2paQONQY3OlMgNiZxzbpulWfhHcrozWGJYhRtgocat7Ty/CeHcXryl+CkOmrtloFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZXvi2ELXNsQ2j6qReINKh+0F4djrj/PeEqyTR4P18xLe2mlGZ
	grk0cXMrOGzTZazcMQ+0ElZeUSl81WjUxUCeyHNjiRGt2ZlIi1ePMZ6d9t2jjbm9UDPZy6hUu3l
	fnHYDts2GszNDwYQHYGDkBdjeiNg54KWX0N3REGJHry0bdgd4WvE+tz5Wke6YbCNI6ZoaCw==
X-Gm-Gg: AeBDieuwKojiZGx8hCNDLA+/y779OsaVdXpBmDheJ+w/dSUmXrEL7ypYHrgiNvZjAZ9
	myACjMGWk8WqLRATbrrgJjdlXp9v1taSDOXgZUVPFzY7XHrws13R3SD2Ee7mucUIDyBH5f9yWqc
	DHnMjfkg+F1bAf+LqQuvu9OWjH65cZlVe9qkKgn2Dkztjv+h9GTgdcsbODz/gkAvsYvj71+N1TL
	FD8FiYxlyCbIOz2FV6DEtKYRLbgMeZOggdY1ndTJs11x+uW88H2Wbt5xCUZySiz1oTP/dQxAets
	W2I09dnJ0pf6gsjebM7cmc1YFynWklTEG3e4ThzGUHfamzh8+9xATYSnrRyU1rIyx54kMTuiSjs
	/IN8pVPB1xDgLD2cg6g22YXHxmg/+VosziHehlxky637KYTUPjEbvqcQfPIt0mC5SuXyonllHwB
	JvP3Tcg44oO8gJchrweTWRlNHPHYcLKg==
X-Received: by 2002:a17:903:3c23:b0:2b0:506b:e6f8 with SMTP id d9443c01a7336-2b988188786mr19793495ad.5.1777448188982;
        Wed, 29 Apr 2026 00:36:28 -0700 (PDT)
X-Received: by 2002:a17:903:3c23:b0:2b0:506b:e6f8 with SMTP id d9443c01a7336-2b988188786mr19793235ad.5.1777448188427;
        Wed, 29 Apr 2026 00:36:28 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9887a6cb0sm13376865ad.33.2026.04.29.00.36.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 00:36:28 -0700 (PDT)
Message-ID: <530a9e0b-ae5e-48ae-a2c8-73152e2dd6df@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 15:36:24 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: ath11k: fix peer resolution on rx path when
 peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424-ath11k-null-peerid-workaround-v4-1-252b224d3cf6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C/7ZDwP+ c=1 sm=1 tr=0 ts=69f1b4fd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=bC-a23v3AAAA:8 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=JfrnYn6hAAAA:8 a=4RyH2EuIL7uwbwVYth0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=FO4_E8m0qiDe52t0p3_H:22 a=AbAUZ8qAyYyZVLSsDulk:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDA3NCBTYWx0ZWRfX0xoiQVd8zOj8
 oHwUWVkBWo2mOc6fTnuLkSSJLbVTVvNcJBhc8jAby69JMhmrlTj8Si9s8LeyS0VH/55Sa7zRZUL
 agbODdJGMNDDsG9D5oXZWbAudU3kP/y73kjRK2h/aXM+jXet7svoAzwHM3HGdvZfNbfyxfVGh1g
 LEGbgDky8EnO8xnUiiabom+6GrHf36Yx/Ora2sD5OlUdKNgd/bo61jX6hTR+CJ0udwdQ5LpCXSR
 D+4Z3Gu1uMtlQ536lD9XrdOHC8DttiNAJ3RPOVk2cOO/JBmFqPJb0wh1DwWYXf2ZKOeSeyt9bG3
 cuZ+6Uu3+4ZupX3sVvS5CKuXgiLTplzhamKPxDOoJ1DBG8vxLozeN8Dw4Ojpdye2fukqDQyk4zf
 H4wQQAFsG+u7laPFaly8ltfYBRTcJrV5f8GAHpRLCpTvVLuF09W2Sc42hnihbY19D3tyaJj303w
 9ahSk3fECuaQ1X7DDDQ==
X-Proofpoint-GUID: rooAbDYfvP3d_G4mm_Au-pJaV4xKnnTg
X-Proofpoint-ORIG-GUID: rooAbDYfvP3d_G4mm_Au-pJaV4xKnnTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604290074
X-Rspamd-Queue-Id: 8CE7049092B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:email,collabora.com:email];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35573-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/24/2026 5:50 PM, Matthew Leach wrote:
> It has been observed that on certain chipsets a peer can be assigned
> peer_id=0. For reception of non-aggregated MPDUs this is fine as
> ath11k_dp_rx_h_find_peer() has a fallback case where it locates the peer
> based upon the source MAC address. On an aggregated link, the mpdu_start
> header is only populated by hardware on the first sub-MSDU. This causes
> the peer resolution to be skipped for the subsequent MSDUs and the
> encryption type of these frames to be set to an incorrect value,
> resulting in these MSDUs being dropped by ieee80211.
> 
> ath11k_pci 0000:03:00.0: data rx skb 000000002f4b704d len 1534 peer xx:xx:xx:xx:xx:xx 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d1a fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 1 last_msdu 0
> ath11k_pci 0000:03:00.0: data rx skb 0000000038acd580 len 1534 peer (null) 0 ucast sn 3063 he160 rate_idx 9 vht_nss 2 freq 5240 band 1 flag 0x40d00 fcs-err 0 mic-err 0 amsdu-more 0 peer_id 0 first_msdu 0 last_msdu 1
> 
> Remove the null peer_id checks in ath11k_dp_rx_h_find_peer() and
> ath11k_hal_rx_parse_mon_status_tlv(), allowing peers with an assigned ID
> of 0 to be resolved.
> 
> Fixes: 2167fa606c0f ("ath11k: Add support for RX decapsulation offload")
> Tested-on: QCA2066 hw2.1 PCI WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.9

Tested-on: is not an official tag but is ath driver specific, so generally it is put above
all official tags:

Tested-on: ...
<blank line>
Fixes: ...
s-o-b: ...

But since this is trivial I think Jeff can make the change when he merges it, so no need
to respin just for it.

> Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
> Signed-off-by: Matthew Leach <matthew.leach@collabora.com>
> ---
> Changes in v4:
> - Prefix subsystem with 'wifi:'.
> - Added the 'Tested-by' and 'Fixes' trailers.
> - Link to v3: https://patch.msgid.link/20260417-ath11k-null-peerid-workaround-v3-1-d04302284486@collabora.com
> 
> Changes in v3:
> - Clarified that the mpdu_start header isn't populated by the h/w for
>   all sub-MSDUs in the commit message.
> - Fix second null-peer check in ath11k_hal_rx_parse_mon_status_tlv().
> - Link to v2: https://patch.msgid.link/20260415-ath11k-null-peerid-workaround-v2-1-2abae3bbac16@collabora.com
> 
> Changes in v2:
> 
> - Since peer_id=0 is a valid condition on some chips, remove the guard
>   that prevented the peer lookup.
> - Link to v1: https://patch.msgid.link/20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com
> 
> To: Jeff Johnson <jjohnson@kernel.org>
> Cc: linux-wireless@vger.kernel.org
> Cc: ath11k@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/net/wireless/ath/ath11k/dp_rx.c  | 3 +--
>  drivers/net/wireless/ath/ath11k/hal_rx.c | 5 +----
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
> index 49d959b2e148..ff2c78a4e5f3 100644
> --- a/drivers/net/wireless/ath/ath11k/dp_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
> @@ -2215,8 +2215,7 @@ ath11k_dp_rx_h_find_peer(struct ath11k_base *ab, struct sk_buff *msdu)
>  
>  	lockdep_assert_held(&ab->base_lock);
>  
> -	if (rxcb->peer_id)
> -		peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
> +	peer = ath11k_peer_find_by_id(ab, rxcb->peer_id);
>  
>  	if (peer)
>  		return peer;
> diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
> index 753bd93f0212..51e0840bc0d1 100644
> --- a/drivers/net/wireless/ath/ath11k/hal_rx.c
> +++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
> @@ -1467,11 +1467,8 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
>  	case HAL_RX_MPDU_START: {
>  		struct hal_rx_mpdu_info *mpdu_info =
>  				(struct hal_rx_mpdu_info *)tlv_data;
> -		u16 peer_id;
>  
> -		peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
> -		if (peer_id)
> -			ppdu_info->peer_id = peer_id;
> +		ppdu_info->peer_id = ath11k_hal_rx_mpduinfo_get_peerid(ab, mpdu_info);
>  		break;
>  	}
>  	case HAL_RXPCU_PPDU_END_INFO: {
> 
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260326-ath11k-null-peerid-workaround-625a129781b1
> 
> Best regards,
> --  
> Matt
> 


