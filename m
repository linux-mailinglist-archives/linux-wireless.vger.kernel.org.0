Return-Path: <linux-wireless+bounces-35982-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NS4BELN+mmtSwMAu9opvQ
	(envelope-from <linux-wireless+bounces-35982-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 07:10:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 957434D63E0
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 07:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00B1D30208DF
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 05:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E6282F03;
	Wed,  6 May 2026 05:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgM3wVse";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SrWlhf4g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E322754774
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 05:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778044223; cv=none; b=YhE/M46IQeO+lNEyhVrQ5S1eq3z0pTIZ99vTv2uNsgjsqdMlNcP/bzB1Ld4Y9aY4/3awmuJcEu9t/24lUOvKAT8mmTGPr2u3crAzvAkMwPtYZi/imUzKS0GpiUR1Xs3UR/cWIN8ETROTpZEtDZTvrzgDr4OmUIwWfBX7c8uqHQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778044223; c=relaxed/simple;
	bh=tf2ysqpk1nC99PdWwy8+u5jZHjbIHqK003EJ8at2JyE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dsAwYuheMhQ3pRKTE8Sp/mSkcBH/KHPz4l8Y8+qhhaqzb3IaPQF4klqv1DejslUo5QT2sjZ8AKNHQuoBEcEFGiryauL72NP6iX2BSc66RhGQRChefko6VNCmOekRWuaj6oUrBWV4nj8ph9R3UZkUW1pam3Nk0lQkP9lpTZ1iJKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgM3wVse; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SrWlhf4g; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6461o2Hs3740625
	for <linux-wireless@vger.kernel.org>; Wed, 6 May 2026 05:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u7Xtwxu527ONdwqq1IS7pFyONCSzk0/BWatqg2qG/+o=; b=hgM3wVseM00DhilL
	1jQXAN6r6e4MoIMoAagWXMk3bOy+pHKdMg6ALvEMM+CB0Px2GdEoEHo1r1Bvj6Ie
	eL7Vb08krrRE51Ui8AhrizZU0x/ysk58Ncdqdc5A/JRTErW/Y627OU7CSnr0Jm6N
	iaAFc6itzyck3p1NogjqLW2n+v7y0BYfL1o8UjBpM4DreNfSVHC0MlW4nLjtpfNK
	h0SDzqfTeior/ASzpXQ7sBrWoW+NB12Eq/6T1GnwzsRSk1aVWTgT94QK2jfBkzOj
	JcGMVgCk6yaJg01SQghBCFb3KtIi3sn0KmnmZPk8Y5g3PrVGouRZ8eKkC5CmbHtj
	pQTpzw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dyefqbyk6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 06 May 2026 05:10:20 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b9a6d84522so96184965ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 05 May 2026 22:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778044220; x=1778649020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u7Xtwxu527ONdwqq1IS7pFyONCSzk0/BWatqg2qG/+o=;
        b=SrWlhf4gBgnssCVu/6anCNxODzG/9uhFp939yDjreSLC7UAl6IyVksIJ5XGkd10DoO
         zJ7qHAm0L/3SLvuY0IXLciUKcJfA/qDHLWmavESTMNeQ/zqaWDWBeM0CsGE/U2S4dQ6u
         tVTI4tLnVZhYVUP2fhQapicTdZ9KilGb9FzC/qnFMY6V8Xbs1LQjapgMsNZrCPSLv27b
         cCftXFawgooKUekCRTnBtybmM8hvfhuhena1g0vijIJ+p4zGpaldRqKfCHJqyKzAMUAT
         xcumEzevsPRsB119AF+rUjBGuZ9dRYLPck6NFZuKU7425pRpcEtWNx/AuF+dA3/ANFuD
         ErHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778044220; x=1778649020;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Xtwxu527ONdwqq1IS7pFyONCSzk0/BWatqg2qG/+o=;
        b=emuN5Uy2A10swbhpIPbdeparVVI/TUgaSw9Ika7S8Ru8cSR6BVgOjRjwcqq8aj58Y7
         WObNAlyyjn58ItaTs2jFmsA/2ViwZaIf1zDA94Fy0ySw+p4qJJO9OiUT10lC9jsgiaOQ
         qXYw+smVEY5Xpr2uj5XPSjCB3sAKzey3IcXDdUodXP6PfcB4qc+srCiD5bCRVip/evjs
         BTzHl33cvR7di5KkGwLDvFCNH/6zI8n/BQdAxBB/oFh/kCDQHcAOd2PGSe5HKCNv+kyN
         2RxGwhh9YaD+2SvdIHTtJsOpUgNgeH1nVH8IMBS/Jl1J7mYJjZzDgB41BOpbVhBJ3GV/
         Y6HA==
X-Gm-Message-State: AOJu0YzufBIOpzeGp9F3IfTSBUfpiykvM1wg0JZt/eKwEjPzxll6zIRo
	SZfmfEfUUZAMmKEKiXdavd5iBLHQgiyD6aJe5ZI3QaE/YhTuArZNjU884TfXDIiFAUAJFNBMlpT
	15/j0Tc2EJ08AFWVI+PQBt3fouPPJodL9BwWqipVY1HNhtQp6lgYZ6EPdLE438dBwatEALA==
X-Gm-Gg: AeBDiev6arHnDuqyAhkHVx9xwaPMBp8uWdQE4tLzPs/IhGXLLLHTGDCx2aLnTKVQe66
	9SppQvRKgcAyaHhdvAyEC0MpSJhbeeAWHlAurAUo2DpyUlNlcl6mJ6QMHt19BmQPLHjIyAGHkSH
	9HUgJjT95ffDx0rfxMQfXil9XTs/niqKULkhkgcTB51efLdoDJAjMqClVbyABjTRfWSDq32djCW
	+5BBL31YmhcaKJ0JzmCKh/zH+bHlvP2JC/2u/Rh+NLRUMnohRe71yjPvF6IMI7lHYj45T26pZV8
	Y2eYNxnQsvOBS98+jXQky7FbnrGsrtqKszteJi0BRQu7qcq2opBZO4+r+5A+PAMVxok7A9DEcPO
	OXQjG4q86+3sui7TL0ZIN9mFW1/f/h9x9MPipD9tBZl9B2uaR17dJLzj39Z1TfDdwk6G1HfDt
X-Received: by 2002:a05:6a20:3d0b:b0:398:919a:ddf5 with SMTP id adf61e73a8af0-3aa5a9b7371mr2199506637.24.1778044219767;
        Tue, 05 May 2026 22:10:19 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0b:b0:398:919a:ddf5 with SMTP id adf61e73a8af0-3aa5a9b7371mr2199475637.24.1778044219304;
        Tue, 05 May 2026 22:10:19 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839681a9e33sm4773198b3a.50.2026.05.05.22.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 22:10:18 -0700 (PDT)
Message-ID: <bd36f7a3-ec5a-4018-8e53-a5f5cedc3909@oss.qualcomm.com>
Date: Wed, 6 May 2026 10:40:15 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2] wifi: ath10k: skip WMI and beacon
 transmission when device is wedged
To: Kang Yang <kang.yang@oss.qualcomm.com>, ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260428061737.37-1-kang.yang@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA0NyBTYWx0ZWRfX1abRr6Ue3Ydg
 +yKqepxwsBMcja0TW9bjQExwhQqh6V1q7WWySG/Ji7EkVN090uUhZQmcuRCSXZ5EgeNVf7sbrT8
 XYoWC7nPEGW4F1Cb50L79xkvlLvFgQbAW7Qzow/FvbVeUxz9uBim6FJTEsskaU6NZq7fmmMm2nD
 qBGpX9OVgTag0LVGv7dGjI7YL9wbXP2fS+OleCRW04XEqR5yBXpL3suW0qtepBAFBc6AiA8NlM2
 I8rtIDUNPoT4mINZNNrtNM1buYMMpvwevWrmA4SIp0x/czts77ec48QHn0hQRPamSB7Y/LZMt9g
 WwhwEsMawgk/dPHKbANX1/AuNKuIGr13hGk+ccmQZMxx6lrf2/SeCoKlcrYqToMjUgpJO9sj9lh
 IRE1LJe20ttYOPnwluj/OqTCE4hfnmCwDrV6qKJivUWKYDUGMSFPGNokPl3FarwULfYz4EOJj5i
 b39jW1V7zCer+O5j5tA==
X-Proofpoint-ORIG-GUID: UUVkFGIZcoIZr2TGlWlSSPXF7KcpFpfz
X-Proofpoint-GUID: UUVkFGIZcoIZr2TGlWlSSPXF7KcpFpfz
X-Authority-Analysis: v=2.4 cv=edoNubEH c=1 sm=1 tr=0 ts=69facd3c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=EIYY-h-vi8t0s74smRsA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060047
X-Rspamd-Queue-Id: 957434D63E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35982-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

On 4/28/2026 11:47 AM, Kang Yang wrote:
> In ath10k_wmi_cmd_send(), the current code detects ATH10K_STATE_WEDGED
> and sets ret to -ESHUTDOWN, but still proceeds to transmit pending
> beacons and calls ath10k_wmi_cmd_send_nowait().
> 
> This can lead to incorrect behavior, as WMI commands and beacons are
> still sent after the device has been marked as wedged, and the original
> -ESHUTDOWN return value may be overwritten by the result of the send
> path.
> 
> The wedged state indicates the hardware is already unreliable, and no
> further interaction with firmware is expected or meaningful in this
> state.
> 
> Fix this by skipping beacon transmission and the WMI send path entirely
> once ATH10K_STATE_WEDGED is detected, ensuring consistent return values
> and avoiding unnecessary firmware interaction.
> 
> Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189
> 
> Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
> Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>

Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>

