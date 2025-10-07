Return-Path: <linux-wireless+bounces-27863-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB87BC1BC8
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 526BA34EC81
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8029D2DC34E;
	Tue,  7 Oct 2025 14:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ji/NlOU/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE329374EA
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759847351; cv=none; b=OJ1aTFwYS1AA29aso0bvP3eAMbb2GaJdu8x5V/LkkR8y0AqvOheI2SDeC8Zm+pyHfQ5l90CwSupeAWS8X2/HSKTERQbfO8WFG50F1ufY6DV7pWlsd0T6x0S8SIRNEHxJsqfyXi3DYNi+3LIOlsuT1EL5Ly2JNJMAbubixyzyglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759847351; c=relaxed/simple;
	bh=azDxkrKipjQWs/+TIUw4aozhS3iCe7GfcOB//f9I2BQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghTpsOc2wNnsEIwa87HUyv67IgJd35gY7gQzZlB621wZ2ISo6OYKrqWigVWPbs8v/88ZbKM5gCMEEpAKQAHjScb+BMHsTbLZY/5U5S8c0J1VxVT57fKrjwJYQ0ELZVvyYm0D1u4vvJR/1fJPtRLVNj80y9rkj6ShsphIfjfhrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ji/NlOU/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597ET4li029338
	for <linux-wireless@vger.kernel.org>; Tue, 7 Oct 2025 14:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	i15v0MWuPu/05mOek3M80W24v7ARsRO5z1xG7TxMnfE=; b=ji/NlOU/ACDQ58Xw
	G4XTlIfuWWOjpTAwaZCacbqS23w/McDW5rgFJl7YPFohjyuJohxzHeWejRNhSts/
	v2JjXDL6itJRNeF/efgOT2vy3o82FxYFZKuoKkkxX1QaZniMtXASriEmgudlBJ8j
	j/MJqkaCmh34GFQPdoF7dagvB69QjiYQQLGBYnXE5KmPa+OpXCm0hrglt54066DJ
	s0JU46SidhvgCyKynUhiF8o/aMWMCicgl7ocyTZ/R+wBJNu1TmyOcwAWAE5pXdsq
	vzJwTZFI7IfCJfLOYFKBLIjVNIU81zS+pkmfZsHlAGMXnpkSGyfI9jl+yq/KkDaf
	LS4CoA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49mnkptb7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 14:29:08 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eca7298d9so125846555ad.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 07:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759847348; x=1760452148;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i15v0MWuPu/05mOek3M80W24v7ARsRO5z1xG7TxMnfE=;
        b=pV9c0POyLX2VKZrkVuF3DgBAQX8hSAQ1T0s5WVWFM1B9TYBd121/ptEM4soYFl0ZWj
         UxLty3grDQ0ptD24/U8NOJbMiY49sGSLJWoqFoXcjRcdS9CxlXKKesBcJSzrtdn3j/Hd
         x6dBXzi7G0AeGj+bS+r656Cl1rkaDmjKca78GhNokEjxp4dGTkIUY0b6VSZTHOa0cB2I
         DXgj6sks7lOKZFnznS2dCIEHuAHfcI896CogyTthSN17yUxtKL00rP2w7WwQbNV1l5wF
         br5aUCFe5R9WtfYN+s3KKYE9nLekJzpXp2pfJkPHVpEKkYXhI6cEFayo7uvwrFWFi+EP
         4ZcQ==
X-Gm-Message-State: AOJu0YyiOsf2sRRuf0cf2J/mIoFq0RpU8a4D1kbGprI5eylOwflzBZoc
	KuQFPxxarCCjgZQj3YJ8RUEX/AfUEkLSqlx3Gjh84cit4L4UC3xCfUXzXFuiNIfvmonC4wl6IBX
	KIz1B3keVq8M8dII9DnNqUw7pbZegdEkBbn0ga5Q+uUqdR+yxXX0qyEF3p7ihqsJXn7vMGg==
X-Gm-Gg: ASbGnctTyH6f4+uZx4g435O50hjGM6fbRpe2R9YOUXv/uufdbohCGaq0owBRbPsqshW
	c50B/0fMYEl78jQ4UgJ5v/x00e+PHsLHqwgsBhmSjMYPJgnyHNdlmfECZeQWdcrJmFXDN+zgW9w
	t/RglqWgn+txNf2SaBDHUsLX/B9uNz+D/85u29/7OXDTZGtA++9O69mR5PFgJCBO2VSOPAX4rjr
	TwiTMFON2RQJzAdK2OkDtRI/vvkwvcwgIve9vb52969eoieyKvQZ4koR4GNebe2M3pwXNDrZfrY
	8rh4XKvy24Nixje3C5cBG0gG3gXCZz0w1Tbe5UqrmjYe998+Y6gTGmuNsAco8mKZaLBlulSQdRZ
	hAYybylKpD1gZWB0c/wrusPwYLqRQHQFqhs5CHXK6dA==
X-Received: by 2002:a17:903:2404:b0:28e:7567:3c4b with SMTP id d9443c01a7336-28e9a58ff08mr155376315ad.16.1759847348075;
        Tue, 07 Oct 2025 07:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGs0+TWsXuUvTzAz5dQmRGsuU94EuL/oTLXvIRyJFFJl2oxGIM6M7R0ris5ccZO7NqxHE0/dg==
X-Received: by 2002:a17:903:2404:b0:28e:7567:3c4b with SMTP id d9443c01a7336-28e9a58ff08mr155375955ad.16.1759847347468;
        Tue, 07 Oct 2025 07:29:07 -0700 (PDT)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b9e4fsm167381275ad.73.2025.10.07.07.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 07:29:07 -0700 (PDT)
Message-ID: <29a30250-137e-429f-91fb-1f509a55746f@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 07:29:06 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ath11k: add ath11k_mac_op_flush_sta to properly flush
 pending packets
To: Florian Maurer <f.maurer@outlook.de>, Jeff Johnson <jjohnson@kernel.org>,
        ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <GV1P250MB14333A5BF24623C4753A10E1E8E0A@GV1P250MB1433.EURP250.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: tEpWhxdv05q77Ua_iYB7aEb5Ya2uEeVC
X-Proofpoint-ORIG-GUID: tEpWhxdv05q77Ua_iYB7aEb5Ya2uEeVC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA2MDE2OCBTYWx0ZWRfX9H5cEIdalxfx
 1cNbtrf/JHuBxsE65E6m7q7w2g0VIEafrXP83XMwz+wgYH/UPpxckRNrCdDAVYF8wi5gFd/xeu2
 ab8aOza/fUocb55SVVjBM82jqA/2MkFxUVdXPCRX34HscwRfa7I5uuB4ECNLwyKItXnzVerZyJk
 WxfGI31Zn8L8+nFNirtHVSsmxSkDO9vkW5EDVobz0p2AFhMZFaDZRL6JLcH7n5GJ0xiLDzLugz9
 erETA5Pg2CbekSmoxgctTYei8tUguDQenc8WmxC/03cTQcOqWs4Y/wYQ+U4AMzzvovrjl8RiQaj
 NHtrFokRc8fb7iM9hEE0fEWiFBNLArW3a/TDP1COd5u616TKg5W9negCzUtIAyf5XwgMJ5qKT+f
 3KBpRUreMDzwv+EB9fdFnBHUpq3Qaw==
X-Authority-Analysis: v=2.4 cv=BuCQAIX5 c=1 sm=1 tr=0 ts=68e523b5 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=e70TP3dOR9hTogukJ0528Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=stkexhm8AAAA:8
 a=xfCdrJMBT71qAiTnbiAA:9 a=QEXdDO2ut3YA:10 a=D0TqAXdIGyEA:10
 a=xa8LZTUigIcA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=pIW3pCRaVxJDc-hWtpF8:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510060168

On 10/7/2025 1:11 AM, Florian Maurer wrote:
> When a STA is marked as no longer authorized, if the driver doesn't
> implement flush_sta(), mac80211 calls ieee80211_flush_queues() to
> flush hardware queues to avoid sending unencrypted frames.
> 
> This has became a problem for ath11k because ieee80211_flush_queues()
> will stop all traffic and call ath11k_flush, which waits until the
> whole HW queue is empty. In a busy environment this will trigger a
> timeout warning and stalls other STAs.
> 
> Fix this by implementing flush_sta method using WMI command to flush
> frames of a specific STA.
> Flushed frames will be marked as discard in tx complete indication.
> 
> warning print "ath11k c000000.wifi: failed to flush transmit queue 0"
> was observed on various openwrt devices, and is fixed through this patch.
> 
> Signed-off-by: Florian Maurer <f.maurer@outlook.de>

Your SOB should be the last tag in the list of tags since you need to sign off
on the other tags you have added

> Tested-by: Florian Maurer  <f.maurer@outlook.de>
> Co-authored-by: Benjamin Berg <benjamin@sipsolutions.net>

This is not an upstream kernel tag. Perhaps you meant:
Co-developed-by:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

Note that a Signed-off-by: tag is needed for all contributors

> Tested-by: Flole <flole@flole.de>
> ---
> We tested this patch and it solved the problem of flushing the transmit
> queues taking too long when the AP is busy.
> We did not confirm if this flush is implemented to guarantee that no
> unencrypted frames are sent out on station removal.
> Could someone with more knowledge about the firmware behavior check
> wether this approach is feasible or if a different approach should be
> taken.
> It is not clear to me if the approach taken in "wifi: ath10k: Flush
> only requested txq in ath10k_flush()" might be better.
> https://lore.kernel.org/linux-wireless/01d859e8e574a1f5d0b916333fe0b5cda859af9b.1732293922.git.repk@triplefau.lt/
> 
> Regards
> Florian
> 
>  drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
> index 106e2530b64e..a94649edd4ed 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -8330,6 +8330,24 @@ static void ath11k_mac_op_flush(struct ieee80211_hw *hw, struct ieee80211_vif *v
>  	ath11k_mac_flush_tx_complete(ar);
>  }
>  
> +static void ath11k_mac_op_flush_sta(struct ieee80211_hw *hw,
> +							struct ieee80211_vif *vif,

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis

> +			    			struct ieee80211_sta *sta)

ERROR:CODE_INDENT: code indent should use tabs where possible
WARNING:SPACE_BEFORE_TAB: please, no space before tabs

> +{
> +	struct ath11k_vif *arvif = (void *)vif->drv_priv;

use = ath11k_vif_to_arvif(vif)

> +	struct ath11k *ar = hw->priv;
> +	struct peer_flush_params params = {
> +		.peer_tid_bitmap = 0xFF,
> +		.vdev_id = arvif->vdev_id,
> +	};
> +	int ret = 0;

unnecessary initializer that is always overwritten

> +
> +	ret = ath11k_wmi_send_peer_flush_tids_cmd(ar, sta->addr, &params);
> +	if (ret)
> +		ath11k_warn(ar->ab, "failed to flush sta (sta %pM)\n",

avoid unnecessary parenthesis, and include the error code, i.e.:
"failed to flush sta %pM: %d", sta->addr, ret

> +			    sta->addr);
> +}
> +
>  static bool
>  ath11k_mac_has_single_legacy_rate(struct ath11k *ar,
>  				  enum nl80211_band band,
> @@ -9920,6 +9938,7 @@ static const struct ieee80211_ops ath11k_ops = {
>  	.set_bitrate_mask		= ath11k_mac_op_set_bitrate_mask,
>  	.get_survey			= ath11k_mac_op_get_survey,
>  	.flush				= ath11k_mac_op_flush,
> +	.flush_sta			= ath11k_mac_op_flush_sta,
>  	.sta_statistics			= ath11k_mac_op_sta_statistics,
>  	CFG80211_TESTMODE_CMD(ath11k_tm_cmd)
>  
These are just cosmetic comments. I've asked both the infrastructure and the
mobile teams to validate this proposal for technical correctness.

/jeff

