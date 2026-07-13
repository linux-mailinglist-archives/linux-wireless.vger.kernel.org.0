Return-Path: <linux-wireless+bounces-38952-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nDCmGpWUVGo1nwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38952-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:32:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E227482E5
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=guCW8lQ9;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FzLgNykq;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38952-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38952-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3550C301AAA9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196DF365A0B;
	Mon, 13 Jul 2026 07:32:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75623563E1
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:32:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927932; cv=none; b=dXeJagAMH5YRKPLcK9BzAL2kEJJyt+S7sRf/FDLhukc/TQZ5W4sHbq71xXvAxDNOlLjxQdezYye6UjV2sZznGLLvuJYp8F24IplwDLu7iBUcGH5x3O2S0MgKQBEB1u2yQJytK14uU542YUO0kPbnKKhGa2bwHd6HXZTZ0LPQdt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927932; c=relaxed/simple;
	bh=bpcBYRCdjIVvtUbet1Hu+jda2+i3kPVAbwS9lGHlLGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AOcDINtfU0AztBAYGcl0mctpYt0V8JfHSP/Iail84Ud9VxECzPHdKYrBKf9IYFEcsIKj9QHN9m3/DhPQ263B+YVwCkDsVLj7TFyeo1ftIEbeso7tnGOAsnAXSOBO+Ae+Na/22Iz4jelOw67xSuHGFOouAckoooLe8FE1ko9mPaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=guCW8lQ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FzLgNykq; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7KZ59774574
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oDPxzBtU90wclqaKo2TSOT6TO+880sfHe1SFtealZ+Q=; b=guCW8lQ9OcGw/NEC
	ioGpc8LNS1M/bRYJxewFTbkZzhvaM0sTpVTj5LWNj3cof5xVuat32N4Sng1mG3Ms
	4ddUaOy6PsSf9WbghvFwRiWOhazey4wR0aVzSGpnCOg+cs2eXev/g8nEV1Bu04Bd
	sk+7jMXJzDMqveCwcbO8O4X9WgTqRy2WL4zuoLrdK47quXczXgoDKlYW5SRpF+TN
	9Erd8eIyjJMffgTRY9iMlkC5sls+0FdH1M4X1r0ugxX4RArSMYhOSDgSJj3wknrp
	nCMoYSA4x3F7Rh61x0lsewP3vSJeG2tGUJhyztpAIB8T2ARpGCMyF+iZFlHTk8Q9
	rwNkRA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcuj001dm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:32:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84870e7f498so3259908b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927928; x=1784532728; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oDPxzBtU90wclqaKo2TSOT6TO+880sfHe1SFtealZ+Q=;
        b=FzLgNykq8Dlq5yVQV9ixl99w8gb+2zhCSBLizCtO/VQDKCmsiwsRDcqywlyFEYXYfP
         IY4ycPDG70MuryLF7k4CfxLQqIQZngrpd+paxTLubK9XxNN7Bt2xG3bnZ4E6WZMT7xJ8
         pPNeFktDiqkuCqXCc3Ge0UiJqYEMB5bGLk7g8bZREhyUWVGhKqhApAgtpwsbEC2RviS/
         b0rnY++XBdHoB9gH2iGz2bcX9djzdOqa77h4Iar0VImB/N32olnh7194M8bUuZUi4kcH
         3sUC9GN+ucX/dcc7SrT6dmkt/AtJNFRdXltDKjCwFwKWX8HvVC0BN4M51jlPqLs1ooMy
         E/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927928; x=1784532728;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oDPxzBtU90wclqaKo2TSOT6TO+880sfHe1SFtealZ+Q=;
        b=HmAQpwZJdzr2jDCUsmnLeHWV8VHMGxrlQL5rZiPD81Mo6zhMN1/OlxMjKeh5hb6CoP
         ezItfzQYBBm5ua/A6EWqniXA/8tObXNo3wJnOzlWz0LABg+coBGHC17uDcfrUrCnHdqQ
         6RtaXhZi0htpgGyY0UxniW0S9ycJ1wyLAmivb1Ir1ZqR6xc90chP7/NO8rjz5DYNrq4f
         DTNiQWADI5FoEvpVQJoWbgxjEgrEVXzh8heJbr4xYhKbhd1dsz/UWEEcUxYzy6FqZMP0
         7gdVx0FGOdsqQ0pCJoQQk2rE/KLBQdn05CqYB1lDQV6U00Qv01ro08+czwkXdfjQK/Sc
         PdJg==
X-Gm-Message-State: AOJu0Yy6yUF9bUxqiDCBO5TW5Kru/NeLUjOOk09N6PREpHN92QNrzZ8r
	IMNAM37DfdUiWY0pLXGTezMalNp7qqX0kQvqck5sdyHXPm7k3D7oAbLLo4EgDm/cdJjhfQv8Mi4
	G5UwInhU9NboKQxFTUUapbjuS0sjWywwLOsD4ZJdAY/B8wifkZbQtKNc+6ma/7WZI9/7QFg==
X-Gm-Gg: AfdE7cneYA9pHnRxK5e1+8qSip1t1SlagMhx3KnyZVgZ20ttoVbriLlPQ4FY/peZ/xq
	ev+NQcGyeMnX2GV/nyLtctuJQgANI4X7jmjAenI2mU+P7O6TvCPlzsb9IXPEjQmlhAywjq5zN2V
	qrFUxzgEaQFDI1S+fbt7MtQmEobPg/+P4dtEln45gW/PnxHwLQKxmaeFdLtqKt6ZJryr+aIWXOF
	qP+mSDsRagcMdgdRJotVlh5H+mxSHTXruUm+z8/uzfY74i5EUD6cbNSEz31Rbhg96mRXRm1RdqV
	XcT7T+4ACKyO0YG4omzKBrquGat0dvPijYN6X1Werq2PxUdzmQmv/8GuZEo34ov6W0r52daVufc
	1hkiyaF64spluZ3I1WrnwKsOdkVA0u0xS4YH2YwdCnKz0B+8ezXKfTrDGTu65kH6TzHnwjXTda+
	9+KErtA6M=
X-Received: by 2002:a05:6a00:c82:b0:848:57f3:8f99 with SMTP id d2e1a72fcca58-848897a0bbemr7033975b3a.56.1783927928339;
        Mon, 13 Jul 2026 00:32:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:c82:b0:848:57f3:8f99 with SMTP id d2e1a72fcca58-848897a0bbemr7033942b3a.56.1783927927860;
        Mon, 13 Jul 2026 00:32:07 -0700 (PDT)
Received: from [10.133.33.33] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5afdb7534sm8020259a12.12.2026.07.13.00.32.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 00:32:07 -0700 (PDT)
Message-ID: <0e412b03-eda3-4386-8009-d23460b8d2e5@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 15:32:04 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-current v6 0/8] wifi: ath12k: support
 firmware-allocated MLD peer ID
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXy1cG+7QHgXEh
 gQLc9mwb6vBRYLqiaQ/xpuoCl3LTsL4I9qqIJOItTPG1qDORaXGo+1mKNEAj9CUiJUgAAaQwGSf
 n10cny/mhCojD5UVRwwAThpoLH+Qks0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXwE3FXxt/SDX7
 +NHsB+kqwrSK7BuTKaM27Ta55HNauPFNwRXqN8wN4tdGunMiKKAP3CL0jkqyrQ9cDY7K/zIZh/3
 1W8sOmR5KT0pN4kV19VFS+s51nkmkcN+DgP/uXwLpFIsOn9vsYkVCeaBVyVNyzeLfZgXtyCSi+i
 E5WmllFYJpTQMp5CrigYXFZDsp3CftoJZPECVsURmFDm/mfnWx5pXEVP5qvbr5Z7Ufx+objyrKM
 vJPaQOVsBrR8GcY+QCO7/8aGaxLLZ48asY4YGzgMx2WOEnJi4/VtP5spp01sHokExDUVYIeo9T7
 d0G2DfvZt++aPAFG1kh51La9kAGUKy+LRIR8YuJX4075Q2ESLJRENSEBeOMe7aaLUW7QH6aE87D
 qvQEBfJMocg+c0Gv4uubzYVCssPqfH+M33ZxmPE0CrhwqS1gdEfgeHPHiuDz7FfAHWzvCU4V6Gn
 c5wPwJ1Y/JaZR0eErDA==
X-Proofpoint-ORIG-GUID: JpTvbA1Nu-E5BxALs2ZSnsvFofNZkZRq
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a549479 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=qiebmGgv6xejdxd45h4A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JpTvbA1Nu-E5BxALs2ZSnsvFofNZkZRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38952-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8E227482E5

wrong version number. Please ignore this series.

On 7/13/2026 3:29 PM, Baochen Qiang wrote:
> ath12k currently assumes the host allocates the MLD peer ID and passes
> it down to firmware via WMI_PEER_ASSOC_CMDID. This works on QCN9274
> but breaks WCN7850/QCC2072, whose firmware always picks the ID itself
> and reports it back through HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP. As a
> result dp_hw->dp_peers[] is never populated for MLO peers and the data
> path lookup fails. On QCC2072 the firmware additionally crashes on MLO
> disconnect when ATH12K_WMI_FLAG_MLO_PEER_ID_VALID was set in the peer
> assoc command.
> 
> Add a host_alloc_ml_id hw_param to branch behavior, defer the
> dp_peers[] publish to the HTT event for firmware-allocated chips, and
> propagate the firmware-assigned ID through the existing host
> bookkeeping when it arrives.
> 
> Patch summary:
> 
> 1: fix for an out-of-bounds clear_bit() in
>      ath12k_mac_dp_peer_cleanup().
>   2: group peer assoc send-and-wait into a helper
>   3: refactor, keep ATH12K_PEER_ML_ID_VALID set in ahsta->ml_peer_id
>      so later patches do not have to OR or mask it at every call site;
>   4: parse the HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP message;
>   5: introduce hw_param host_alloc_ml_id, set true on QCN9274 family
>      and false on WCN7850/QCC2072;
>   6: on host_alloc_ml_id == false, leave peer_id_valid unset and send
>      ml_peer_id == 0 in WMI_PEER_ASSOC_CMDID;
>   7: on host_alloc_ml_id == false, mark ahsta->ml_peer_id and
>      dp_peer->peer_id as ATH12K_MLO_PEER_ID_PENDING and skip the
>      dp_hw->dp_peers[] publish until the firmware reports the ID;
>   8: in the MLO_RX_PEER_MAP handler, propagate the firmware-assigned
>      ID into dp_peer->peer_id, every dp_link_peer in
>      dp_peer->link_peers[], and ahsta->ml_peer_id, all under
>      dp_hw->peer_lock.
> 
> ---
> Baochen Qiang (8):
>       wifi: ath12k: fix out-of-bounds clear_bit in ath12k_mac_dp_peer_cleanup()
>       wifi: ath12k: factor out peer assoc send-and-wait into a helper
>       wifi: ath12k: keep ATH12K_PEER_ML_ID_VALID set in ath12k_sta::ml_peer_id
>       wifi: ath12k: add support for HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
>       wifi: ath12k: introduce host_alloc_ml_id hardware parameter
>       wifi: ath12k: do not advertise MLD peer ID for firmware-allocate devices
>       wifi: ath12k: defer dp_peer registration when firmware allocates MLD peer ID
>       wifi: ath12k: resolve PENDING ML peer ID from MLO_PEER_MAP HTT event
> 
>  drivers/net/wireless/ath/ath12k/core.c     |   2 +
>  drivers/net/wireless/ath/ath12k/core.h     |   3 +
>  drivers/net/wireless/ath/ath12k/dp_htt.c   |  49 +++++++++
>  drivers/net/wireless/ath/ath12k/dp_htt.h   |  12 +++
>  drivers/net/wireless/ath/ath12k/dp_peer.c  |  75 +++++++++++--
>  drivers/net/wireless/ath/ath12k/dp_peer.h  |   2 +
>  drivers/net/wireless/ath/ath12k/hw.h       |   2 +
>  drivers/net/wireless/ath/ath12k/mac.c      | 164 ++++++++++++++++++++---------
>  drivers/net/wireless/ath/ath12k/peer.c     |  31 +++++-
>  drivers/net/wireless/ath/ath12k/peer.h     |   1 +
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c |  12 +++
>  11 files changed, 292 insertions(+), 61 deletions(-)
> ---
> base-commit: 951dc0a744e4dc8490935316d3b76e23990bde3c
> change-id: 20260527-ath12k-fw-allocated-ml-peer-id-2b456891157f
> 
> Best regards,


