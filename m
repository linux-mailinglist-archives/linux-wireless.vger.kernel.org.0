Return-Path: <linux-wireless+bounces-37276-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIJHLGW8HWo/dQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37276-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:07:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A96623070
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C41230B1543
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C9B3DCD81;
	Mon,  1 Jun 2026 17:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LM3IbbwM";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DlrGeHgr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6453DBD55
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 17:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333241; cv=none; b=hVqnx3KSmySrZV0ogC5BsPqLmg/hmUqZSshy/woFrYSx/wAobmjP9ZXZrJxwyh/317QBcL8jN1Zjczhtu+HRVsFzGZkEwGk2B0Qic9i/3AGOIZsRcFc9QDfx+LhDE5yvwP5493+taPcjBfqbkFtHQv8FyfSxrLeUEz6vcYrqZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333241; c=relaxed/simple;
	bh=DaE3HpCwrUmshkBUliISibJ3n+/ZAwmb/zPiVmY22WY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HsIIaAj5ObvCuCZVe48zVTlx1pJ++Md0u/J3AeDjzZAxpxTevK1j3MzEtfpBKPnnjyEt0iF8/NUXkpNgWyYq/ccd6XFNXMw9JWcU85bwG2gioS2C2ho4F4dxapKJ1gvstRiJp5Bfmv6/8S7JByAHdCQmsSwVgrj8GleG+/nmYOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LM3IbbwM; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DlrGeHgr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 651Ef3OR1257597
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 17:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/tgTqJZZ4hdDQa1pyin7GcKIAoNcLVYXlrapflaewZA=; b=LM3IbbwMsbYqIP0o
	s9da7RLsz2jfXauf2H8xyVlRTHSFp/74Pk3ANxpMaad42T0KVl46G21j56LnUrMA
	6XXcbLjG8T98asxYc2P7gO4onkyw16J8JPSMLUMGAIjgleO7A6mDaM5K/uAQMHeT
	dcYMuyhimnfxCkdP/K4f+S7JwgoBRJz4ZfmrJJ9BKFYXaRgpGabIhitQ9ur9f9Jb
	x2Rq5W7OhquXoStwIxTo9NOM359uawCaLCC4Fvb8svSzRMaOXeVgBUQ31n+Y8zW/
	mxsP4LW0/BEtN7hOxe6oul/r91aNTKHlYi5al/kzHi6+u9ShDIbpFN0uKI+m1NDY
	yR/Vcg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sst2w8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 17:00:39 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-135f2aa4742so7423079c88.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 10:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780333238; x=1780938038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tgTqJZZ4hdDQa1pyin7GcKIAoNcLVYXlrapflaewZA=;
        b=DlrGeHgrnUDlkbW/Vus38/gYo7T/fi1bbLdEGhcUMTA3Hxq4q+1n96KjXV2v0GgMOA
         iF1L4qlDqycRypyaIfqI6YOWjDtn+p2SU6wA/AQXQSX+jUbNA3ysVg4fCJbK6fZKdDQP
         zzrADqovo3WvJw29QNvV33MCLwqezl4y431ZK+6lKApAc5McD4BpIwcZJX04MqKvCCMa
         +yjnevzF1q/p3f0TMjxTq92Mjpb7pFCElqnfxP9tR80X1PGOBW4OvDo7vGDZJbhwYgaU
         ZFE9LvfewUfEHE2o+emfYDtW18/2y7vfwy8EG+Gt+qYbJOrMRKkHHZ2lC3VUbobkW7nL
         luGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333238; x=1780938038;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tgTqJZZ4hdDQa1pyin7GcKIAoNcLVYXlrapflaewZA=;
        b=MDJnufRrk/mtFz/CyBmSEXI92MnCFw4MZ7tUBe6SnXE9pZ2RIF4r5umZ0LfQ5u+UVT
         JaiSDnkXcxdr/xpVef22xSbO/TOi3UCpAdR8Bnauy723LmjQPzGFeiJHo1cJcLIhC5m4
         lQ6e8TxWAy9a/sIHm2Pz8K3J8/QWVxQif/33jXAYCYEpbDAmlnG8u5XdpVynP5wWwREs
         I/qKw+Z1DrF0XLRjtEPDQ9gajX7KqV7zwxyjYTJSfxAYIQ0zt5t7bu5t7NRsNf8bWMPw
         xItgX4y430cPIiQgoLnZi31mlwmJyYLCDapLwhZDfAXhxNoffxk2Q25ixNsKmm8yrXaW
         VAEw==
X-Forwarded-Encrypted: i=1; AFNElJ8ICvNNCJNGy7EgfuHvMZjkCsTDS1oc8QPI56aljff5KcLIQPuSYzA1KLxm7oV2ft4cZdzLQi+Hj9pQLuPG1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm57wRHllyyE6bMdLmiyNnenqArbjwS7a8Zy+Ir7XTrKs4Vcdm
	+jqZ1ko5IdMHs8J+HXtNbYgUQYBg/Ny/wb5OpUf+eAG2Y7h30aC3kmxpfdmb7yIvEFS54TSEpQ/
	qYyk5PPKAc1Fc3Jc1ktYSvm40+GmLMfv1w6Q3O6fsFCzroxi32NuBv3GXSRRsHvYwElaG4A==
X-Gm-Gg: Acq92OEmD1aJdHLroHgRQTMEIWxV2p/PVlEQ9McA5mLr1ExPClGFkMnffQ24M3YbHwC
	VYtguynzTO/BxMjjJ2NmhpUeSkkR+djq6YoRwKIq4/HGzPvPnBIBlu0CwRC4F391qADVnkqe/Y+
	Kh4X6yfkyjswI/0vrYPB4wu2IkK4jvgdjPrjJgpvrp12qj8AhHxAAb2eVy8841B7PpkgiCkFOf8
	F1otNGAPR4YG6y9iKukTWHjewBsBMAm5slE2EJq2Znus75a7i296Fe2NNqKyuPvtp3TVyHKA9KJ
	siplb7hd8jYowdN/YYntVa1xqawSV2+y+PXPGIwNOyUudikaQ95h0RGYVmugyNP3DwJIePwsE/c
	F7AD+6ZJEeNmv+wu6yaRynyKNbfhR4UTVcsvzzZQp7Ht7DNBSf7B7eLC6+rtT10dsawvkYvCy70
	okTuAhzD3D/uE=
X-Received: by 2002:a05:7022:2215:b0:130:760b:77aa with SMTP id a92af1059eb24-137d42a82c0mr4882310c88.41.1780333238225;
        Mon, 01 Jun 2026 10:00:38 -0700 (PDT)
X-Received: by 2002:a05:7022:2215:b0:130:760b:77aa with SMTP id a92af1059eb24-137d42a82c0mr4882279c88.41.1780333237498;
        Mon, 01 Jun 2026 10:00:37 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c69bdfsm7151625c88.9.2026.06.01.10.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 10:00:35 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Wei Zhang <wei.zhang@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
References: <20260512044906.1735821-1-wei.zhang@oss.qualcomm.com>
Subject: Re: [PATCH ath-next 0/2] wifi: ath12k: fix NULL deref when MLO
 link activation fails
Message-Id: <178033323580.2045173.13952603126118431049.b4-ty@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 10:00:35 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: 1DmnH7akuc_PpOalm_T-RmLb6HCQeqO8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE2OCBTYWx0ZWRfXxZLJxBUjAE4P
 mBIasCn4fkoCD5V5Eg5leSZwznhO89YjPMAHu9RkQvqvnOSXvkkHZ9RQXOwvFfvSR7ddrhORhhy
 e5of4oqh0hS5vNfhEln0ZCMB+6iA8eT8WtIkl7Kn5ubDJzYAg56kvcrsX7oVZhHZ8gUovQoIAmV
 RKZFXsP0BeQPfvPirgaw6j6hyxQEkoCK4ljRsGWkWPDTv1qTVeL0whBUkTFIkhvdn1P290chlZR
 Ve3iI6cRVVyer39NDtiyCCe3gble8NQFdeCwmySbzTFrQZmPF55BgH5+XaXP4q6dWV58vxhRwDt
 juHuJ+Idf6+VUTlUF2rO5XMYpTSsGDMP8WVM9IN04geUzIUrWjfszdXX5ss6HRF1aNkjVfEcx23
 LJDykUrquD7xVARBc6w8zLAYHnXiP5dSmG3m5qA0kDtyAVNOYfEjo176IG3nLUAP5RvVZjQoRLE
 r7kr3kKaE8IzYCjV6+A==
X-Authority-Analysis: v=2.4 cv=O5wJeh9W c=1 sm=1 tr=0 ts=6a1dbab7 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=snLEJlJ34RS3NJav8DUA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 1DmnH7akuc_PpOalm_T-RmLb6HCQeqO8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010168
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
	TAGGED_FROM(0.00)[bounces-37276-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 19A96623070
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 11 May 2026 21:49:03 -0700, Wei Zhang wrote:
> ath12k_mac_op_change_sta_links() adds a link to ahsta->links_map
> before verifying that the link's vdev is ready, allowing broken links
> to be processed by subsequent operations and causing NULL dereferences.
> 
> Patch 1 fixes three error path inconsistencies in ath12k_mac_vdev_create()
> that leave arvif state or vdev resources inconsistent: a direct return on
> wmi_vdev_create failure bypasses err: which clears arvif->ar; and both
> failure paths in err_peer_del skip the DP peer cleanup and vdev rollback.
> 
> [...]

Applied, thanks!

[1/2] wifi: ath12k: fix inconsistent arvif state in vdev_create error paths
      commit: c972636efc63f0f43d725b59805dd1ae5bc4b31e
[2/2] wifi: ath12k: fix NULL deref in change_sta_links for unready link
      commit: 47809a7c8348bc4a332ccc26a37c7145a5f609f8

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


