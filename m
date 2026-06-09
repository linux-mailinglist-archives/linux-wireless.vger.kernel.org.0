Return-Path: <linux-wireless+bounces-37582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iLRiJpn1J2ph6QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:14:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F8165F609
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 13:14:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=o7JacjhU;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=glj4AWeH;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37582-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37582-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C70313149AC1
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 11:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DE3FB06B;
	Tue,  9 Jun 2026 11:06:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A4E3F8EB2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 11:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781003173; cv=none; b=mfx0nBtCKrLucbmgYYXi+M7758/jcS4BLPq4p76Y/YLBsrhV/8DAITUve597u5MfGvv5muw1e+tkppf9QqhkYco4KsfdeYVCsf7TZtzHQkkadj33y2hKWeRVmUlrmRTHs8YBHdl16FIO4QJepp0Yp5V9+tn0Tnt1kcra1zPHqNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781003173; c=relaxed/simple;
	bh=ShvwJMOJQDvAsG/6pLWxQLkQZSBkfRBu1iZf7virf30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rlz9PQxe2yOvijVrtDEWCoZDrcGd9WTYpyhmots6M5/w1/t0BCsM80g9L+E7xXDLz70kDsJEcodvXkntDS0KhJJmsfeekMDsLlf7lUA4jcRBFn/sSfewE4R06L+9cJaIlX/vHGurQnV/AMtiH/iBDEngyJJQ3YHtGrhs02cQbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o7JacjhU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=glj4AWeH; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6599vNBx1868984
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 11:06:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oDB1dEHH2BhhuQ8aVpHpSbKQtwpVexmrNc4K+WJYSl8=; b=o7JacjhUJBxr2Z1y
	erJe0qdWA93RJaH4eN9GTOl/KDhD1NKlG10UpJY6ktNKjK7phpfuNbKtC+LtQxMf
	VMlNxG8vOmj2bZolmzqoCdIcoVGYoe/hx7HPxYwn6aWprdLUDSFJirLqJ2/5M9Wg
	uV+uWvTfClhuPfDGVnIGfIhxH2tpiJl29RsFaW+R+tvfH54E77Jpa0DgmJLxBk+a
	3g2PDnr27nN0F1l0xeBV4q9P34MhinEvsYIu8AZ/J0VoF4KBNPL3NAMPuZMalDrW
	CZt1c+5jaeQrtb0oWtxWmso5zAwlZ9UL3o/JYdfSBVybwdi8GqcGf0xTqkPQnVpp
	M8TPJw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3wgcf5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 11:06:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bf1dece2ecso56321925ad.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 04:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781003171; x=1781607971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oDB1dEHH2BhhuQ8aVpHpSbKQtwpVexmrNc4K+WJYSl8=;
        b=glj4AWeH8l2Oo1jWsfFNB7AMA0axIdbZRB0J8Us52CE+Muoxp6EYbNqA4KuxAGDrNW
         5Cpq98N7NVPte/+Xw/AJURxLM9Z3UMJ1BqE2WdLhzsVhelxEkJvkI+0Q3BIyK2hwnfl3
         kzGTU4A7z1eWYXXMrbS+KXrHJTV4o2VK2BJVa+dPKo3w4jiIggW5d4F2TsuF+15jaaTp
         cY87xdYgZotQEbGPiqHOwM7M+gz7JuHk3MLkXcaa1bAF/4jxRD5GFmqgdYMVv6SLfLIW
         wV/FZBnV/6vfqSZixuHTW/CKlyruTlUmxel83poqTFKji20nSvYe34S+RECch7tR3hB0
         yEzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781003171; x=1781607971;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDB1dEHH2BhhuQ8aVpHpSbKQtwpVexmrNc4K+WJYSl8=;
        b=q7jI00vUVluwolboJU3w/qqY2Tu2Jlh2ET6fGoKcU4qK7IxLHuj4h9jMvSG1bv6fTk
         bJ22kAMpXUgcy2vXGOzbSqyrad9BEX9fbLC0pCkZW6b6Q+6KD2O2u5fepyfOdBXglQ3R
         oFi2fw7xc+SBRe83VzXyzF6kyKA4tWqzDvj+SwdYRwZjbWPFdzAqWCiHHu5yo5tJzFwe
         I3jrkPlPeHNXvObiczS+77EDVSGIQYwS+4B9bz6jqHCekACFPG7BPG6bcNtty42VXN4U
         8LN3qqoR63f2Vj6NSAqytq8YBMn8E1uwe31i9afD0IbZwZPqcUjfdOACgkFI4ji4sGZ3
         FXfg==
X-Gm-Message-State: AOJu0YyP87XMlvrJcyOMBsybLd7frez8zNeU2fw9I0+ug8DuNnrI5ly3
	lguMbd44OG59g4D7HW0IzmOecy65yBCj3CK1CQ3k5tI2Lz4hJrwwqo/eU0b38N5IMp//rFAlYMg
	JFqVZ65Is11t36T11DtbfOyH/YuFpYUoh3e9t+LZ9D6RZO8Nvf94BT2kSX1wY1UhcIf81vg==
X-Gm-Gg: Acq92OFIHBeaWBxWzAmqlgtWE6LziVL7sbd27htRNV1q9qsf6pFfLuzKlQ8gGUKXooO
	AwnDWZkRdEfYLqTwGzUXvkGj2ziMRO20emeTqCsqEVWCayGtftlw0rvrp2FQf9aOJYdRPlpTyxx
	7nC8CYP/mzhp+EZj6AmQ5fWxp2IIKWcHXmrlQA3fe3DLQNxItGpmWHKJ/OvaM5h4CthyEN3XYff
	fUGW0Q/WH0PXBv+HW0QNArJ24BEiXPjzH9hJM5kJsKLSbeA1hE0H0nX+2hoQSt51z2aVxfrJrth
	ut6M01/P44AmGKmSYBpKdjJebwslR2Ba1pqMpZVzudPcqiYiuccwxNl0vVAFGw1W5DgK/uK3qhq
	YaldMpcZjAguRinitdu6/4+8vk4yH2ozZCViil/uhptkDJiZaQBVPlaNT6Smcdn9GQmwuGywG
X-Received: by 2002:a05:6a21:2d42:b0:3b4:6265:3788 with SMTP id adf61e73a8af0-3b4ccdcb24bmr24335885637.21.1781003171120;
        Tue, 09 Jun 2026 04:06:11 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d42:b0:3b4:6265:3788 with SMTP id adf61e73a8af0-3b4ccdcb24bmr24335834637.21.1781003170595;
        Tue, 09 Jun 2026 04:06:10 -0700 (PDT)
Received: from [10.152.199.23] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0a4e59sm18488529a12.16.2026.06.09.04.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 04:06:09 -0700 (PDT)
Message-ID: <c5105488-7ba0-4acc-bd65-f3d53aa900e5@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 16:36:06 +0530
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current] wifi: ath12k: fix EAPOL TX failure caused by
 stale tcl_metadata bits
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260609-ath12k-fix-eapol-tcl-metadata-v1-1-d47e6f90d4ee@oss.qualcomm.com>
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260609-ath12k-fix-eapol-tcl-metadata-v1-1-d47e6f90d4ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEwNCBTYWx0ZWRfX5HPmfVHsT4rv
 7s26J79cR/MtPPkJX3N9mWK0YrwnQC+Wgh3DzPU3RwdxcTxXCK7qrCrO1b951Kqe3uCAUwtOha0
 A76KlSYp8PgQgcE8VqSz6o6FB8L6lfH6N8oOFFGsyRoHNqB7AEtLwnPP/NEycBeTTil4C7OuB5H
 15MX3fubGQ8UZaHbuJwuQ6IG5UutB02/OR/QHXsT3YVx7mXgSlOH75LfOFlSW/Jl+56LireNol5
 JTqPg0/omzGKPYmfjAUAOaq2d3IzbIwD3jGt5kzACYbg4xw0gIJBqCmk9ptZwpwmSfjLe+4vVkC
 YvYXZZkPQt0DHpQrZt3GozhVjh3jfvuB/mbc7zofOAtErCLYqOdDJjBAmss6FFkeHxIsG9a/FIc
 CTI9fHBOzLDioMP1z3GfHqGxASgc6PHw51aHvFJXrknHLV4dSHjssXMqCYn2/LkxYW9jEL68rTW
 gQdvDSI2NlD2S3hFV6Q==
X-Authority-Analysis: v=2.4 cv=csWrVV4i c=1 sm=1 tr=0 ts=6a27f3a3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=pbvH2K571lt4oqL5DtwA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: WP3m-W96iEPBYodqFbvDaQaktlMJPIMr
X-Proofpoint-ORIG-GUID: WP3m-W96iEPBYodqFbvDaQaktlMJPIMr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090104
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
	TAGGED_FROM(0.00)[bounces-37582-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:baochen.qiang@oss.qualcomm.com,m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rameshkumar.sundaram@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06F8165F609

On 6/9/2026 7:40 AM, Baochen Qiang wrote:
> On WCN7850, after the following sequence:
> 
>    1. load ath12k and connect to a non-MLO AP
>    2. disconnect and connect to an MLO AP
>    3. disconnect and reconnect to the non-MLO AP
> 
> the third connection always fails with a 4-Way handshake timeout. The
> supplicant transmits message 2 of 4 four times in response to AP
> retries of message 1, but the AP never sees any of them.
> 
> ath12k_dp_vdev_tx_attach() composes dp_link_vif->tcl_metadata using |=,
> but dp_link_vif is embedded in struct ath12k_dp_vif and its slots are
> reused across vif/peer teardown and setup. Since tcl_metadata is never
> cleared on detach, vdev_id bits from a previous attach remain set when
> the same link slot is reused with a different vdev_id. In this specific
> issue, the same link slot is used for vdev_id 0, then vdev_id 1, then
> vdev_id 0 again, the OR yields tcl_metadata == 0x9, which encodes
> vdev_id 1 in the HTT_TCL_META_DATA_VDEV_ID field even though
> ti.vdev_id is 0. Firmware then routes the EAPOL frame to the wrong
> vdev and the AP never receives message 2.
> 
> Use plain assignment instead of |= so the field is fully recomputed
> from the current arvif on every attach.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c7-00108-QCAHMTSWPL_V1.0_V2.0_SILICONZ_UPSTREAM-3
> 
> Fixes: af66c7640cf9 ("wifi: ath12k: Refactor ath12k_vif structure")
> Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Reviewed-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>


