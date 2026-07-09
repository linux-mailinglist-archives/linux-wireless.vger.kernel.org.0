Return-Path: <linux-wireless+bounces-38829-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W7iQMjq3T2rQnAIAu9opvQ
	(envelope-from <linux-wireless+bounces-38829-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:59:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B85732905
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Jul 2026 16:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="c/QNLJ3D";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FfFpOPEm;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38829-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38829-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67A8C30EBE34
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jul 2026 14:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD4725B08D;
	Thu,  9 Jul 2026 14:49:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CDB3B14D3
	for <linux-wireless@vger.kernel.org>; Thu,  9 Jul 2026 14:49:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608593; cv=none; b=KSYRZKMnO2D+X0BqvT22i60FZtvIY6XuylkMM4xEsoPycHEMVPGl9B9mDjy4IyLYKPezgaEi+b59hrQWM9Uji2KzOGVlUs3MD15fDcriOe01T21Hsbna2Jt8W0zH+UemZixSiHzMR6qeO8PsmvCBh/ceBkjNQS5V+VYNnPue9OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608593; c=relaxed/simple;
	bh=3pR4EVIZ8kYMa9yuH3Gp3wqDSL2m8YCi0PdWgn158t0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rAIdFPRyK/o/N7p7cwUxx0vTooWtA3/oiAhR6A8txvIhRoIQ5pLrnTwrjyFSnH2OicvArg5LA2O8wsf6X8tbk4+5+1zLLB3Jp8qFz9qRewJNxB0o/QTUuy2j3eQGJS0m+EjEplHw2UmtoLyGZDN3AhrRH02ujQ5qBHHzk2Ffxuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c/QNLJ3D; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfFpOPEm; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669Dw5MZ1970748
	for <linux-wireless@vger.kernel.org>; Thu, 9 Jul 2026 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sTtNQqjhetqqm9GWeBDN1s3Bjp7OhmjhD8pX1Q9Zqgk=; b=c/QNLJ3DEmUr123P
	GOxqVCx6sXevhkMjObzoor32Aa0ElQW1qK8lVlG0+/NCAxwM2VIDw+VSN16OYW50
	s8hr3Qgk5MlfkVvDBmec6/5YpzoQcQXLUEwi43bjdZ8JZY33x8gvO5i4yiiB1nbQ
	lgLTjYdeNfbtbS8rEH+d4QfFRiEDkfpS+GRcHCFl9UpcfbdbSGn2KC9EgebMO8N6
	h1qmx3jadzG7XleyzzOAP85XxWxVddxywSGapSbuGrr3vC7HY34BKyTF2Ysi8Px3
	EZFdod/My1isp3SqwXKycnIQmxUskeufSfQnjuhvo72x3k0uc/kSt1dhPSctnvzN
	eKC3MA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4facqpgbb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 14:49:51 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e6bb29581so29969147b3.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 07:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783608591; x=1784213391; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sTtNQqjhetqqm9GWeBDN1s3Bjp7OhmjhD8pX1Q9Zqgk=;
        b=FfFpOPEmpht1+v3R6lr+257j4u9Yocv2l5DVXfFpePwhJRNoKItCpgU4j6M4MpjCrJ
         qIyvxzx42T1HxQsgNITO1Jw87S/4wV1rWm8Qry3r2s0KNWUdueV3EC2tp+I27Xm7RxPB
         zbrei4zusNlzQ/fMdPPXnN1/4UjBUs2bwA/hHn2qFVcN363j8njS8R2rjiGkW86zWDcu
         LhoeyQ98xmm+wkH+Pg37FWAGie0LOhbYZAyyvGoWd5XmO5il6zhNLBh7ddNGwqnnpqg+
         o6dEVPomki9Xs5av7SNkdan767oQNtESdixofsI0SB4uJ4jMgqAB2gZLDS565o8wjklg
         LIug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608591; x=1784213391;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sTtNQqjhetqqm9GWeBDN1s3Bjp7OhmjhD8pX1Q9Zqgk=;
        b=ONiL1a7wlbiUliBvLtym7/evYAgg7NZZ8UMlJpIHp6kaDOH2y9dPZtywVfcg42F+9v
         V082Uz7UDVgHH+48XASuCaIGPP0LVw/pVRpRUPv0Vr7M11P+hr/5CVixAr5BC6lgePRq
         xbmJvs5nad0sAUkIp4kvHuIPTlr7Ex+X4VNKkOSwuBKFszMf/yuhfJKE06ymB2+jdkRH
         TSlf+UB8n8Tgpymz9lyRCtsmd+kvxDP/uUEFsenw6xnUZ5Z/lnkRSkI3X5W81CXNHN6F
         EuVW3DAjR8CwFYwc18fIZ0pGSmqM6uQ8EOUohxC/WKJbNmQIMRrulLnZkX2oAXEIxx8v
         4sKg==
X-Gm-Message-State: AOJu0YyEPJhqYzAN1kqzB/qBkCKvOfDK2ug5ELnCfpISJrXKAn4q6TBB
	OGHEuIQXM68ccW22ytGxEAOjEVmFWHzLAj9qfzzjuCaYt9k6zqW+C01qwEPx/9vfnspooycNarv
	3hYAwJiiAB7LAFtxdzApYCKnjJaTnAl5zP2ewkXD7Rlrn/keXArelEkzcC5CIrQRceaOpWRpv11
	ntiQ==
X-Gm-Gg: AfdE7cmvFPUnRgRyP2wD0XRMDVb2RVUmbJhI8XhFYz29Oqm8WGoOpHi6IilBFPBC0OB
	ohne+NC9Zerj6DDfd7BCoOX+UdIeGWK+DmtERQyuekjkGP/yUKP/l2WGKhxwKMb2GDpl7dS+DRP
	ONVRGBZyyosWvyQB3pCvA7ccU4ELvRZ3e5lY5Rtxh6t8sbjw1fFWF5FDjksVeUfJgW45lKeZuEl
	8Wifrs9jfuZd7ojMEPc3ilZ71LOKTrQDSjRYn4fLWElvlaGep2yoYiZeWXb6+meH9gcRhpE1qtW
	bOFcuKfdFSEPK62IN9zXmk/9uhPDYi3lE+VC65xwqa6M1akNtjFmSviHmRBgmEuLOGgMj01/AI3
	Acn5EkC333klZ+yc/2t10C6wKtjNw4KlxvK9d+bkfwDnnTCslhUQzPovIDJMlMfncXw==
X-Received: by 2002:a05:690c:c357:b0:81d:d43d:d358 with SMTP id 00721157ae682-81dd43de3b3mr47084597b3.66.1783608590928;
        Thu, 09 Jul 2026 07:49:50 -0700 (PDT)
X-Received: by 2002:a05:690c:c357:b0:81d:d43d:d358 with SMTP id 00721157ae682-81dd43de3b3mr47084467b3.66.1783608590606;
        Thu, 09 Jul 2026 07:49:50 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e7795988dsm4989277b3.26.2026.07.09.07.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:48 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath10k@lists.infradead.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260623064355.1876743-1-manikanta.pubbisetty@oss.qualcomm.com>
References: <20260623064355.1876743-1-manikanta.pubbisetty@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath10k: fix skb leak on incomplete msdu
 during rx pop
Message-Id: <178360858829.1031194.14199001499185167674.b4-ty@oss.qualcomm.com>
Date: Thu, 09 Jul 2026 07:49:48 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXwkdHx8G5cUIE
 6N2XyKeT2Lh2LmmemNQIzLXDi0korAUoUHuhYtKZTUEmc4zWQij4hFKC7yQWRetJEdDIyoSkQN+
 8PMpc+VOlB1ktNYvVtYMuGFOcoR4V7LpCFZ2pdQx9Ey3nJSbJ6WdmeHFSYIvlD/Qa6dYtwdfNNl
 TmdAMMAVYQdP508RJIm7109lroU46FA8DWtCJTGSHAOqmSV6Bwr8LMhhaWmJUBgRFsywKCkWKVa
 C468wtN2mFb0EQ1O0Y+eqr3hrilbF8dMf7YUukviBwsMur5I82bndKAq38smRUdSjeu3l1ruj0c
 IzXMlFDQ5o+34OqWW7rK+1UCsv3X7tnOHOUgJ866+/WKSjfzLOT17vG8CWH1X15wOE4ELreS6Oj
 q9xKrc9mFt9k3f//9wX9Eq6K7SJkcsDdt8PqR4Bmboy6UFnv0G9Vo/hmsyikrIvc7G9N37ltEd0
 OxLYqxrFKL1NDgP01PQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE0NiBTYWx0ZWRfXxeRY8/zUN/Wv
 cNrdhiiPj/8Ns80rmv/wTqWpho8vAfzmS4oqUOzopgdAAHlsy5dwk/vSPr1wVshahL0rCrlKHrX
 7Fw+e4ewYkI5Nk/6lUuyvHDoUtkYBJM=
X-Proofpoint-GUID: cD-Ao7zvKW7UrfeFZ1lNThApHLzh5a8N
X-Proofpoint-ORIG-GUID: cD-Ao7zvKW7UrfeFZ1lNThApHLzh5a8N
X-Authority-Analysis: v=2.4 cv=GJ441ONK c=1 sm=1 tr=0 ts=6a4fb50f cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=PSAErUXHYyYb-UPQJNEA:9 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_03,2026-07-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090146
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38829-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath10k@lists.infradead.org,m:manikanta.pubbisetty@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32B85732905


On Tue, 23 Jun 2026 12:13:55 +0530, Manikanta Pubbisetty wrote:
> When ath10k_htt_rx_pop_paddr32_list() or
> ath10k_htt_rx_pop_paddr64_list() encounters an incomplete frame
> (RX_ATTENTION_FLAGS_MSDU_DONE not set), it returns -EIO without
> purging the skb list built up so far, leaking any skbs already
> queued in the list.
> 
> Other early-exit paths within these same functions already call
> __skb_queue_purge() before returning an error. Add it before the
> -EIO return as well to be consistent and prevent the leak.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath10k: fix skb leak on incomplete msdu during rx pop
      commit: 7393878255e492515858f751ba4c260f248fb108

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


