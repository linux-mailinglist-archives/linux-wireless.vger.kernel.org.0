Return-Path: <linux-wireless+bounces-34735-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NBUB5Hp3WmulAkAu9opvQ
	(envelope-from <linux-wireless+bounces-34735-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 09:15:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7094B3F67EB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 09:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BDAF30E9EB0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Apr 2026 07:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B39C35FF57;
	Tue, 14 Apr 2026 07:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R6lCWZri";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Js7y4XEJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD82035F176
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 07:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776150401; cv=none; b=hbdH+sx1/AdChRWokMHN6GbNF9sMprLkb8lcto1+w5maBzg9fpcdxi30TbjbgLKHbDIm/9bz0OTfVPHbo7YPJuTY2nDx0SsHy9o/++WxvovYlsOcN53l5EqIAH7U2H5Dvaghe0wBOQFfczb+qheuS9uhUDdB7wbOFS65VeUcE/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776150401; c=relaxed/simple;
	bh=G1W9A9uCb8lK7c30w1M2HPrNk3TrsUOno1j3S8BH1PE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A5a8+QXXjuIiIaWPoCKoVg7gs90tWDkX6o8Y+af5tWFByOawDPGGei3YDrg7QhHx3qMBaecTYVB2otApYbMSKbT2j5cQNg6K/jKSGhxWrT7CvqqdgIxWm/Z4DN8xg4iCeCyGIuyLDZDgpSz0ro81r2/CNMEPzhNZ0S0jYh//nNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R6lCWZri; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Js7y4XEJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63E73J4d362226
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 07:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dBIASGVnE0aFQr/a2JqCXpFWZWEJCZAiv8D1/xC8KcU=; b=R6lCWZriAbPOeJH8
	Wy12cvaj6HVWnB+TL8YNy3fq02sW2ZsYZo/XLTKGGwBztPnTnVuc+CWP5+iwfUbc
	5szWkXz66iDZCQqbdL11c6JTS0ZE6pEh5pgvt1oN3q0ks2eA1MmoV6g9fWyt/NGr
	4ge5EldxGu1Vc4Djgnx+AT9f+10Xliz/2uT+viZEsaRgBOqTXJ7ouN8REpsxjoJw
	HErWzRsjx3Z/wWZFV6UUakJQL/Iwp4TJnayQk+iLgeQvHXOkvg8wq1rdUlaXOAZW
	P/qEQU2a6aqJbEwxIWfmA5fF52O9uNc+IbNTpbnVa3epSuXorLuPm0QkvPl4/ErO
	Vl9hCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh870sg1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 07:06:37 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b45cd0bb96so20337805ad.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Apr 2026 00:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776150397; x=1776755197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dBIASGVnE0aFQr/a2JqCXpFWZWEJCZAiv8D1/xC8KcU=;
        b=Js7y4XEJ5XS2m8eEXfpWMsYhWyZfmjnozyYueRDeZu91SksAUtO65V8UO4jIt1eFqa
         I4zKDaoGjPVLZnsykqTsXCm+z3ap+ldS7mKJlEhYiihqk65nLMDN3oLMkMMTQH+aFOva
         lkLxwpSusgwqwipaDPY1xrpmaaQB0WA9SAjroMJtRgVMF3v5OvMzzxLClwvtnnOx/MiQ
         oZ2A+MhTG2G72JYNqpzg3CScPbkkh9NfPCs+oWFsqWTlhdpMYoDAr7yiIZC+VohkU5Pk
         61AV7pWgypdcH23fqjvbXYdjAzn7amwQ+fFB52r/TjvQJEvvIphgubYpcd2DDYncEBrU
         HdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776150397; x=1776755197;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBIASGVnE0aFQr/a2JqCXpFWZWEJCZAiv8D1/xC8KcU=;
        b=G+2LvoFWeG8gW0Dl68Ot9+YAhYHqIwGFfuE7bcS3Vj47f9PJM46wHLy2QpUDmG13n3
         I8TYasHi6xwkv2bgNMefMDp57U+gJgEKbD2Uwq22vpnFmn/sCWRrFEPUde+yhXaUxGtE
         JjtHZSo5SwhGUIGbt6baKlpwbSKB3i5jiZQxdM1AGvacs3unigdbTwltt4k9odr+mflM
         dXKWjBvgww1DczeAR9M13dsDQHRwnjaQFMHZZZ6S0aCDQ21QyU6GOG5IH6NeRjP00UWP
         XfY+7A1wq3kxRJKAl9WO3s/wzj1SRJwHTl4FC9xl18JeP+Ud8vLNSwTc+64Q3ogTBSdA
         hUGg==
X-Gm-Message-State: AOJu0Yxk6M0e3cCfKDxZaF++YerMeC+1Z+uwBohImrhMpMreIElY6p/D
	gNQFgzXXNeDMXGVhdHpLFBNOqtT4RrJ2JDZ1vc3HHWiZ+mZWcx3FeoFROGcRCwuJTyCS8bbRvP2
	1u/v+l6q2dPz4HPSccQTa9kRNw8knz5MiGSrLb/2Wxhi/i1YUcvALu/w6blUwTuoa6mhKzQ==
X-Gm-Gg: AeBDieupOabVQtre7uwbsHxEx1Xys91E5qb3ZlFgDnTji4NRWGQu5t+tLL0oTAFSeDK
	yYHzT2DFy8PGL5EfWaO3WltUl4Eb8m8Wpmr0QQyyXzyTyEIfjnmrm5C4uphd3HUI+/H9KlJr4kK
	5zxCI+hqMQu3OHW6G6j4mJ/C7fri0KlOGGdjnzDzBhUq/cJWJ6rwif51jZY2XDt4/2YCeHkqdtg
	fY+DId7VmSXioctZi+AGJpIsTCd8bWcnrlGBBIr6Zq0AI30/iCO5bmZk8F+2xn4I/nJe21XlJK/
	S0v1jlhXRK2N0pwg4rJCQrMyYIEM6iJmP5U0uWEHCPGWwSwXcUfcZPTKKnXxhzSM8TGL0EVoTdc
	TwRhug9GskokVynu2KC0cDTTFnZX/QuLbvF2zucwkbIG5bIMIxLheBxRAzD0fXvQwLmAtQJPxBJ
	zeeEPdqACfjB3w7EOPtduWt5GXjf0w6Q==
X-Received: by 2002:a17:903:2f08:b0:2b2:4d90:98bd with SMTP id d9443c01a7336-2b2d5a64ef6mr163953915ad.44.1776150397196;
        Tue, 14 Apr 2026 00:06:37 -0700 (PDT)
X-Received: by 2002:a17:903:2f08:b0:2b2:4d90:98bd with SMTP id d9443c01a7336-2b2d5a64ef6mr163953605ad.44.1776150396698;
        Tue, 14 Apr 2026 00:06:36 -0700 (PDT)
Received: from [10.133.33.118] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2d4f431c3sm131161045ad.79.2026.04.14.00.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 00:06:36 -0700 (PDT)
Message-ID: <7dbc3836-c42c-4cbb-a50a-011d82a0ee81@oss.qualcomm.com>
Date: Tue, 14 Apr 2026 15:06:33 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ath11k: workaround firmware bug where peer_id=0
To: Matthew Leach <matthew.leach@collabora.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20260326-ath11k-null-peerid-workaround-v1-1-0c2fd53202f8@collabora.com>
 <87h5pxlpg4.fsf@collabora.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87h5pxlpg4.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=C9vZDwP+ c=1 sm=1 tr=0 ts=69dde77d cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=QX4gbG5DAAAA:8 a=SC-YAkXmNWsgAJuF7_sA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDA2NSBTYWx0ZWRfX4bcLtpaQ7aCn
 HJDSv59P2D9kIgnvQorhggZSYJJ6kGVh2XPySHCDmMR4Ly2g9Gx7VWoKRVHtL4S9+YCAUKLWYM+
 TpSLcbFLluZ14U/52y5tXdmEY0MqsL4LNsOAsIEz+eRyGoi8GOWw2KREjE3UVfyKEaiRDhcrIEN
 jrRdyx5qi4AZY9UORHlBYQrgm+oTEd0zdTsgdXGVez8hAcSThIlFTx3qioW/EiQlslc96dVuIFE
 HiEahNOaPr7sSEFw9apv72cRxsk9rQLOmaZUNrwzv25iJo9KCWVVPC/xNFQIbDVxLYeu73i8HKr
 dsYDMuygTv8wNtyEhoOMw8s806uqaLWjQ7kWFYKJAH2qqc4pMn+KSRx98MuqPPBmXNoHgVv5lQk
 iTfQrwhBMQBC6rtbBu3uJAl1BJLpZz29O31Gx5/Vq1Wc3w/0rU9Goe7fezfXfJyZ5zuZ+idvhOy
 v8q9HOwbWav4QW3Kj9A==
X-Proofpoint-GUID: EYEfW40a1cuXjU5fiBRZyR63exvBwJ3Z
X-Proofpoint-ORIG-GUID: EYEfW40a1cuXjU5fiBRZyR63exvBwJ3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604140065
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34735-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,collabora.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7094B3F67EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/30/2026 3:57 PM, Matthew Leach wrote:
> Hello,
> 
> Matthew Leach <matthew.leach@collabora.com> writes:
> 
>> This patch caches the peer enctype during the MSDU processing loop,
>> caching it on the first AMSDU sub-frame (is_first_msdu=1
>> is_last_msdu=0) and setting the correct enctype for any subsequent
>> sub-MSDUs.
> 
> I've been looking at creating a patch that addresses the root cause,
> rather than patching incoming frame's flags:
> 
> --8<---------------cut here---------------start------------->8---
> diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
> index 6d0126c39301..98348ccfdfbe 100644
> --- a/drivers/net/wireless/ath/ath11k/peer.c
> +++ b/drivers/net/wireless/ath/ath11k/peer.c
> @@ -347,7 +347,7 @@ static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
>  	return 0;
>  }
>  
> -int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
> +int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
>  {
>  	int ret;
>  
> @@ -372,7 +372,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
>  {
>  	struct ath11k_peer *peer;
>  	struct ath11k_sta *arsta;
> -	int ret, fbret;
> +	int ret, fbret, retries = 3;
>  
>  	lockdep_assert_held(&ar->conf_mutex);
>  
> @@ -400,6 +400,8 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
>  	spin_unlock_bh(&ar->ab->base_lock);
>  	mutex_unlock(&ar->ab->tbl_mtx_lock);
>  
> +retry:
> +
>  	ret = ath11k_wmi_send_peer_create_cmd(ar, param);
>  	if (ret) {
>  		ath11k_warn(ar->ab,
> @@ -427,6 +429,18 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
>  		goto cleanup;
>  	}
>  
> +	if (!peer->peer_id) {
> +		if (retries--) {
> +			spin_unlock_bh(&ar->ab->base_lock);
> +			mutex_unlock(&ar->ab->tbl_mtx_lock);
> +			ath11k_peer_delete(ar, param->vdev_id, param->peer_addr);
> +			goto retry;
> +		} else {
> +			ath11k_warn(ar->ab, "Null peer workaround failed for peer %pM, adding anyway",
> +				    param->peer_addr);
> +		}
> +	}
> +
>  	ret = ath11k_peer_rhash_add(ar->ab, peer);
>  	if (ret) {
>  		spin_unlock_bh(&ar->ab->base_lock);
> diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
> index 3ad2f3355b14..6325c4d157c7 100644
> --- a/drivers/net/wireless/ath/ath11k/peer.h
> +++ b/drivers/net/wireless/ath/ath11k/peer.h
> @@ -47,7 +47,7 @@ struct ath11k_peer *ath11k_peer_find_by_addr(struct ath11k_base *ab,
>  					     const u8 *addr);
>  struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab, int peer_id);
>  void ath11k_peer_cleanup(struct ath11k *ar, u32 vdev_id);
> -int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr);
> +int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr);
>  int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
>  		       struct ieee80211_sta *sta, struct peer_create_params *param);
>  int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
> --8<---------------cut here---------------end--------------->8---
> 
> This patch detects the error condition at the point where a peer map
> request reply is received from the firmware. If the firmware maps with
> peer_id=0, we request that the firmware unmap that peer and map again,
> hoping it selects a peer_id!=0. We attempt this up to three times, at
> which point we give up and let the peer be mapped with an ID of 0.
> 
> This patch addresses the root cause, but I think it's more invasive. I'd
> appreciate some comments as to which approach upstream would prefer. If
> the preference is for the above, I'll send out a v2.

for chips like QCA2066 and WCN6855 etc 0 is a valid value, however this is not for chips
like QCN9074 etc.

so a possible fix would be to add hardware ops based on chips: for QCN9074 we keep the
existing validation on 0 in the ops, while for QCA2066 the ops is a null func. Or even
simper we can remove the validation for all chips.

> 
> Regards,


