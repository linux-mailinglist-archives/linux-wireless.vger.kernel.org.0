Return-Path: <linux-wireless+bounces-35430-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKwNMp0Y8GmNOQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35430-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:17:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 569AC47CAC0
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 04:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75564302DB5B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 02:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD50B38F25C;
	Tue, 28 Apr 2026 02:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AaUC161u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ib8Trw5Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E32361DBA
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342618; cv=none; b=Un9PrsNzaGBEeEqTQq2OsO6eiqMObjY/A7OL5M2hlxmUVnr5lYeWMberypMIe/zy2qleGhRlDcM/Jy6cGN+oKaTvBgLyYse8BJPN606zgDu722UZ8+kX8M6OjPac9Un+eCklYQzX3w3CGmOOJmuECMG+C7VA2v25ycKjPuDK5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342618; c=relaxed/simple;
	bh=3HJsV+ysGFRCMdrcbWS9a4E4fZu1Q6coCzVmIl1Stbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C1xwyzABWB1PCjLsdUT5Fp1u2qGABEduH7VqeSVVvxu+hdSrYW/mVxZWrdSLnMz3bV24OTJmjQwj2vB856D2Wj7BpNR4QhgJ3m7EDO9RVbfCIHAkemJ0xYZF7Y2RZQFfiehli6VcQ3dZoyTTIT0kxcZwsZ2kKoaODl6PQn+xw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AaUC161u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ib8Trw5Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63RMTxV41627362
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ol9xWLn6aYKX8+YID9JOnFOXJDXILYdNP80VNwE71jc=; b=AaUC161usZ7/3QeC
	EnaD1f5yxuozRy5yT84PC5i1dMSZiTELM4LHjKLdeN7JIql1nY5fHZaBTIftTmQO
	oAO9g5Zz/cv9yODV9dvQIuAXKoNNrYWJ1PhLOYbjcvOYu9RIOiph+nK2rTnodCIc
	0RR1P8jd5CCvAWcVrUogFuQU6mqvxi0JKI2i3yiIb16QY4jTFpUu21lTy7I4TI48
	HXfunUOB5W1YE6nrRiAgFUzi3XwkC+ZrzJwck0WddszIWZiUWEgKDfwpE8Z1Pb35
	+2rLz5QFflViMHApILzcersyUbNdBrete7kD9gGM+HfpoxtoJ2jn0cgoZMjPS0tS
	iFyFrA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtgms8q3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 02:16:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3614272b00cso13400963a91.3
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 19:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777342616; x=1777947416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ol9xWLn6aYKX8+YID9JOnFOXJDXILYdNP80VNwE71jc=;
        b=Ib8Trw5QHEmI9vj7/VT19Kt+gGu2T6Mc/w7nivt+tSbhOGHHn63JGxXtb2iIzfFtdC
         +iKnmKl2eiO4CycunPOytIzD58tTZZXvGYkHOMVhqKBbHMO80CrspaGHe7Qb1qtlC3Bo
         uZbdzY/cGx8Oz7d+XOPR7ocLBDGuVlloZ1Trg+gc3Ln/NvVcrVaqvOsPEQiPclCK0cg5
         3vEjVR411mgNDZS0lI9W2ZkT3Js74VBnRv4AzlOulGLeSsfo2ccgTfv5QHxqXLX1auu0
         RzRhNS0rPA0YWZaa8/kN/kNUrZK9r6HdCzJ1qWTYoz5xSs//vHl/zGSRyGtr5egB0MK2
         5NJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777342616; x=1777947416;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ol9xWLn6aYKX8+YID9JOnFOXJDXILYdNP80VNwE71jc=;
        b=Tyx4k59bTCUlCh/YZVd7OO97jqsLt8kFCiP+OQrXlbnOOyDKy8RaKYAUqIddYSEVjZ
         o1FaFSoLBWXc1+uvOQ7duSsn3eQ0Dktc1F8WxJkytNLvDEdt1lp7vxe6+W5f2b98EUCg
         i+eme3zhMMJxzgvU5xlNu6yB9SmgpWvU5yeB7wKQZqCjtT5mmIck7s0RyCXGfzqVXcuz
         lGGB9VjuFE8O+uVQ0DLiPJAxyte8TPcMeeFVlChn4EebWVO/2yGC5RRu03Y2LXrNTmqX
         yVSNz9369Q0NRx/2akkYKWNDOWO7tt1bbm9zlUrA+PsUEZf4f4DUtJ3yVepyfezBBv0i
         So2A==
X-Gm-Message-State: AOJu0YwJ/cgvjr6fvcl1gesjwe5tDGcbO8DMDB7cfnOfQmwap4aqJ07v
	LcAawbFLZic1LvNoJkEqMPY9VVu4JyNYs9ufWccW0qo9vUyvgyDqcjI+FBKN75RfSiqVy7kNdPY
	mBHTq/WWbABPzNRvL5pnZJdvOwKmPUHGK/vLUqSUfl8g3xc8CsSAL9/5j+mlasWZY0vUMn0Vgss
	hWcKgL
X-Gm-Gg: AeBDievI5yqQSm7XBJHD6nuTLQtqOca/UfWZK0KFPe96+SfcRQ+NInbX3pxbApf24dV
	/k3ctwLjZyR5qXjxf60ccjzF5epRWKFGeocglgFByjJJiUAnuOPslW0YDfmbvtQrLsLoJCgHztU
	r45B7vzZyAzG7LTY1dZkW4cPnxcKH4WTBbdHvBNdL+6XaG2Y7dXEFrUEYqyG3l6YTjMylbobpZ7
	AW2bueBKhvIUMHdAC6efI8vn5aSFzBCqotEZpmTGZKdj0sfyZcY6CpiVfGZEJrClPx0IAKkW8JR
	eprkvsNLzSoInjhQ6sS2IV6iV5wT1SNY8Ycd2/OGxZ/ogkllWw4G24G6tDn9MOyNmUK9KdPX+p5
	9GfMno+7/lmtLatoF4eU7KhrVP9YZDVYU+ftForAAS9SwiSiZ6cuWH68bAeI5gnugHYVjhH/IMc
	F7mc5YYZc2UneNfgHYQLZa7a374ctUGQ==
X-Received: by 2002:a17:90a:fc4d:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-36492077fe8mr1131004a91.26.1777342615737;
        Mon, 27 Apr 2026 19:16:55 -0700 (PDT)
X-Received: by 2002:a17:90a:fc4d:b0:35e:57cf:c0a3 with SMTP id 98e67ed59e1d1-36492077fe8mr1130972a91.26.1777342615242;
        Mon, 27 Apr 2026 19:16:55 -0700 (PDT)
Received: from [10.133.33.153] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36490fbf832sm897549a91.15.2026.04.27.19.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 19:16:54 -0700 (PDT)
Message-ID: <4a59fc51-2b57-494d-bcda-1060de1e863b@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 10:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ath-next] wifi: ath12k: Handle DP_RX_DECAP_TYPE_8023 type
 in Rx path
To: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>,
        ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
References: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260418163620.3633959-1-tamizh.raja@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: jpGTt6DVn8vHWKdmiWAJWANkUS0EjVx0
X-Authority-Analysis: v=2.4 cv=R4gz39RX c=1 sm=1 tr=0 ts=69f01898 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=M6RSCC_QK_m3dAS1aMgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAyMCBTYWx0ZWRfXwLZDxuShBXUM
 VbB8MeVwB5wgJ7AN6e5zTRRZeZjweEbMThveLVBS7itGnx6NcorOxP+WcXfJQUjaGIU/TevPT7/
 BgZ+Igb7z+LYs+bLhnaQyAum5uTxHWOd9nwQvegrVF1GLiZ6mO5fcRECLobEoNsdRD6D+6WjiM5
 vCNTM9EP/03/ZEWnG/l7S/Mx8fN6iPLg/WAfkjqC5Mu0FP7MhGiM+TlL9zagFz7zGHxswkHVds0
 dRfmf8XuZDlNYzust0u0ceYzL9xibhu83H2KsG+pu9cDmAQM7M14rG71cBpPLx3Dbb7XJIBy9Ok
 l4sd7UMRHyWIa+tUeM3s0BM1W9Mx5A8TxH1qRgsKnOBaB9CxYNlP/qPVLoG6XIFJDSGvGnGcGMt
 3fsJH5YZJDWjpW5FQ+320tS7POzZa2tWMpUp1NSXkIApelP9c6I+9YIELCkIAwG7u2HSPllYkCy
 uv6Ey+P0RkZhXZ2tyjA==
X-Proofpoint-ORIG-GUID: jpGTt6DVn8vHWKdmiWAJWANkUS0EjVx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280020
X-Rspamd-Queue-Id: 569AC47CAC0
X-Rspamd-Action: no action
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
	TAGGED_FROM(0.00)[bounces-35430-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]



On 4/19/2026 12:36 AM, Tamizh Chelvam Raja wrote:
> The driver does not currently set any rx_flag for frames received with
> decap type DP_RX_DECAP_TYPE_8023. When the hardware reports
> LLC-encapsulated packets whose length field is below 0x0600, the MSDU_END
> descriptor may indicate decap type DP_RX_DECAP_TYPE_8023.
> 
> These frames are effectively equivalent to Ethernet-II (DIX) packets,
> similar to those decoded as DP_RX_DECAP_TYPE_ETHERNET2_DIX. If the
> driver does not set RX_FLAG_8023 for these frames, mac80211 will
> misinterpret them as 802.11 frames. This causes valid frames such as
> Bridge Protocol Data Units (BPDUs) to be dropped. BPDUs are exchanged
> between switches to maintain and manage network topology, and must
> be treated as Ethernet frames.
> 
> Set RX_FLAG_8023 for decap type DP_RX_DECAP_TYPE_8023 in
> ath12k_dp_rx_h_undecap() to ensure mac80211 handles these frames
> correctly. Also add multicast packet handling support for the
> DP_RX_DECAP_TYPE_8023 decap type.
> 
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Tamizh Chelvam Raja <tamizh.raja@oss.qualcomm.com>

Reviewed-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>


