Return-Path: <linux-wireless+bounces-38224-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlICOhT1QGokjwkAu9opvQ
	(envelope-from <linux-wireless+bounces-38224-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 12:19:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A176D3947
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 12:19:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nyu.edu header.s=20180315 header.b=Md+xHcmJ;
	dkim=pass header.d=nyu.edu header.s=nyu-googleapps1 header.b=d1iOmTAO;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38224-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38224-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nyu.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F6E1301014D
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jun 2026 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C009D2FDC5E;
	Sun, 28 Jun 2026 10:18:54 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-00256a01.pphosted.com (mx0a-00256a01.pphosted.com [148.163.150.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8942AA9
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 10:18:51 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782641934; cv=pass; b=LmJ05lWYW0ZVRkrzQSvXeskzTW2QrAyjjyKf7dkj9yAP+f+Zs4PmUUhIztJvxL1+TrCDQ/eZ9oOCGtSRz9Tqp4JLoG3frQVj3OsWLAHiXsKCTsHg2TzRJDclPqz9av0N4+FN7osWwQBWF4R9MWkDoXmOH9fOS/OlHRbBHijXj58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782641934; c=relaxed/simple;
	bh=DvFXAFCO9tcZqdlLmhVk/h5vnLge5f1OqFfZkggU5zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QC98/PmlOvZFTZO06EYG8570vYfyYyscBEb+heB7/L9KWg6CL3kL1lLQ20jcXMxZSuTaXdrSYsicrnTX73gv7wohLvGwsu6KjtxRsu02LBVr5Xsj/Uprqa1BeNMtN0KPFQV42e5upKM2RkysCeYLb1Eolwua95Orhpat1v3uvIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nyu.edu; spf=pass smtp.mailfrom=nyu.edu; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=Md+xHcmJ; dkim=pass (2048-bit key) header.d=nyu.edu header.i=@nyu.edu header.b=d1iOmTAO; arc=pass smtp.client-ip=148.163.150.240
Received: from pps.filterd (m0355795.ppops.net [127.0.0.1])
	by mx0b-00256a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65S9W7v23847988
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 06:18:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyu.edu; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=20180315; bh=IqIUFv8eyNO2DKWR0kEueaSzy
	xNdYsgSTleO4QX3P+k=; b=Md+xHcmJaAM5DZklTrqr+kCJUp3Ox9WP8ZyARl3zZ
	hrhv9GzB5beVYuals8qVoylFKSErqAIzaXkvgOnQ0gkTXaxLv7P5ZJQxBGy7VlTm
	UQWmiFAena6dZQVPGIVC88O/kz1claUlC3IWFFT4rjgxCol2magmsFgPZCQkrzhI
	3xS892bFQ3XDXBGsNDnFyw1T+TanAaRm0UjyytuQtya9d3Pp0avttC+Ka+++vNQk
	J6wUDeH002PscOoTVF5kG/HihChHjWVvsNjYq1xYluy2dRCwxUQS3Rf6xT192U+4
	yb7pLEnPGOE/jzjwi2h2WL3HdAZGNg0qihHRttOrEjxEw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0b-00256a01.pphosted.com (PPS) with ESMTPS id 4f2v2mhgs6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 06:18:51 -0400 (EDT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38001e788d6so42436a91.3
        for <linux-wireless@vger.kernel.org>; Sun, 28 Jun 2026 03:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782641930; cv=none;
        d=google.com; s=arc-20260327;
        b=mLit9szjgK9+sCR5MVQh9jGaYmT3HZfsRmkBktU0oUjBeLHHu2XGhECG6tk/5DqX+b
         5r426JMCvgYc439rsxc4jdFL4LGED2hH4Nook/H1cTsbw83J42tdZQdaWHhtQf9z0wGM
         R9V7570hNIb5v9WFrApcOhU/8VQDPklET2QefKr3NCIWPjvGBwSw6zDloPm8ozDtExsR
         /ezch3F/6tfMfltCooA9sqTxiR3/qyzvA4VScOl8nu29763bNvI6nKqrDKubkZlQEn1R
         jbVssy1LFlg/yhRObUVjXqZGZZvnf1ByKOgsgPaBS2ffh66/cbNrOK98asPWnftYaQ1Y
         rfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        fh=ZHgB2w6rI/FXuEQtOhXX4gN78MqoZc8e75NYem3pRDk=;
        b=W60AN3Tyww63tEI5mldpKxKQ/nLRiPhOJndoSuMV8UJpJx5KUd/2EP0A4ChRx4bOyG
         OmGPPv7cJn7zDLhCHPD1XP92qscSL+Povlp60XhsygJzZca2j5EYDak6PrxlsakM+BI4
         jQgPUqm23MDkNvSugdLc+q7gMMBtsUdZnsktC5Ft/uAlotguSw5ryNTSitAcOTq0dRrb
         NMntvz03DFQaw76jhC3a441jZosqFw1CeNOkQZ37TGR3rxhz2ulshdvJs0451khr3l90
         I0Vt5/agsAziEjFP8cfEN0jp6SxMV2sUREWMazAuDhBme5BSSqwKbBj3kDOXbT6pn4pX
         ygaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu.edu; s=nyu-googleapps1; t=1782641930; x=1783246730; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        b=d1iOmTAOoQA+TT9ZAudDugMB4X0BNgjxADbfRwKnswAD6/2XxtuVKM1ZtA3HDhdNtR
         3FgGakZP1Mc+f2mGnx40EfWSQUBprZHf1W4lY3T7vqT4IQsVc7sdjePDGILS0TiNKkVH
         aCAeXb6Jn/dBH4AAxE761G1HBohjIWJirAM/rZh2Qyur69rufv2etnPFAtGDgHCrHPp6
         Gd07w76lzOzxvU8ZJMkFcARoyyyXwAkjeJvIe3knF0dzjQ0QpjmLHuUd1cbtZOtnSnKv
         PYn0LO7rFhMFrxrzXv2dsB5U93h0s8ax+288ndp8yDwjdivOg1aebkeZV37M1Tq4f0uC
         Iz6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782641930; x=1783246730;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqIUFv8eyNO2DKWR0kEueaSzyxNdYsgSTleO4QX3P+k=;
        b=RY0gd4+YmV8rUJq2WwkcNMatJKzOdF81UL2drw+P1rl661l4Xfqt7pVGaDPJu4Ob74
         uOfb+tYlDZOy7/F9m/Qt7Yu1dkZkSBXX61GYvo3wpiMHODAhdHILU/Uc/zXOeI282pHn
         RZo2BInbkCiwV5FL9XLxGc95iwNn8GFcVV99wLE2+MMdexaLSzORCf+ISYX63mMy7C6d
         ZlI8WtMe2OfVkOTdxLEznTXIji8wUu2gFRyh1Taazylt7v341IChGM8D4ID2+Mdkqgyk
         N7n4oFW973qfcxQCi4h/cVzdXeRYPZVOx15U+4d1p+vrOAgp6QAGJMS1G6KIuFwk+lgf
         7/Jw==
X-Forwarded-Encrypted: i=1; AHgh+RpfEVvvhPn2UX/ZHKYk6Byq1A7inZ8HgXH5+hNO69QUHfq8w2uGRvuYBp0EgOXOeeGNTJa3nicaum1s2g+xVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSBBR0PZgnfwOWqKiHhh4EHN9POmSHvcWskLoIGL+mFXl2KMX
	tTpyCH1g9Enw6pWobFANu/KgOGwvBz4jw2b35AHIOcaAVqNxFS2dW65S0EdDFUx19H/jEx+vSFk
	qoXsouuerxwcM6imx/QFOMz3HeYsmOSm7dkwBTFPdZsURzDSmNvDceEVWU7M/bhGdNJO8+SVAGE
	+8fRgEcwETJbXAs5000PTTQdyiaEr4hN7dgoAY6DYX+CHx3jkEUEo=
X-Gm-Gg: AfdE7cnwABjhg0GK7mZZfmDCawp2MzhPKbQcR3xQMvUu629koCNw3Cu9by4KT3mO4GK
	M0tSiDPImoBEy96F74NGtXeQ8SI4kPy1cbYVGMfR5DMtm0KpYGUWx/gbpRTK8kLVPFsJ8AY7mhw
	PeReo9TgPrJBEBoOTFDbgJUSyIGh4qYo2vYYg4Mq08dXFrTWEr6tKHw6xiNCX5AJRfLJGg
X-Received: by 2002:a17:90b:1c81:b0:37c:6910:5758 with SMTP id 98e67ed59e1d1-37f7a52c19fmr5834465a91.1.1782641930520;
        Sun, 28 Jun 2026 03:18:50 -0700 (PDT)
X-Received: by 2002:a17:90b:1c81:b0:37c:6910:5758 with SMTP id
 98e67ed59e1d1-37f7a52c19fmr5834447a91.1.1782641930109; Sun, 28 Jun 2026
 03:18:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
In-Reply-To: <CAMt2zv5c0cYzfe0RQ5AfoUdm+b4bAshgjCs23NjFBhQXDKLniQ@mail.gmail.com>
From: Yang Liu <liu.y@nyu.edu>
Date: Sun, 28 Jun 2026 03:18:14 -0700
X-Gm-Features: AVVi8Cf8t9Ato-3g7XWUk93rEfgPTT4Ew3KvNQiLLSuTjXEG34M_PT0p9XJVcFI
Message-ID: <CAMt2zv5gsy-vbjfZC5jQaNsOj1NnkhNrQuCKSQ2Sn32gmnCcag@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: fix TX DMA mapping leak for ADDBA-req frames
To: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com
Cc: shayne.chen@mediatek.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDA4OSBTYWx0ZWRfX0eUWCj14lgZb
 rOAC1OhY01TyC8+tWdt1mBCSftd2mv484d+pKu0SKtoeffZNtgXspQ27hYAjzs9UvYHQkDoNuVR
 bX6wBQiPCxVIb6KIAbthZ5oDiHnXRMY=
X-Authority-Analysis: v=2.4 cv=YfSNIQRf c=1 sm=1 tr=0 ts=6a40f50b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=x7bEGLp0ZPQA:10 a=S0S_EcBMpFAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Se5WoFf3ZZRiLcel0nel:22 a=Lu3rmdZLeA08KL8VqJdF:22 a=VwQbUJbxAAAA:8
 a=BIFNTvHFq2Y8mDqsfgwA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Qb8PouD8-X0Rm2BeA6nS0yapMdfER3aM
X-Proofpoint-ORIG-GUID: Qb8PouD8-X0Rm2BeA6nS0yapMdfER3aM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDA4OSBTYWx0ZWRfX2GBQvWmtdCqn
 gET3k6Q8REvb7+Wv+Mbd5KWYnwzrSp9xiNa4+RihpCHbQQ7hqNgtVhaeFk5ZWcpZ6aaQuT7g10W
 +ddBWrHaaiU5GFHuzdNoUKfH0Wj5iQvktVuHnUiNBTzqebTMnnBcKUm3TGMSdSC/giJOG97CZib
 nlUuf9h4vHcRadg2Oa1yRuwfOq5lNDFYflS/OlOCiVENCqSIwj6gJc+yLXBxC/LE8K9b/hkzNSv
 85JS4Bv2bavL1Um7C0ZZ8nOEQVnIBNqEUBipNuWAPQefOO5d5NgZ+sZaFv+fSQ/JB5cWesL85Ez
 VxnS2p/j/sm6l8na1QRTdvuPZPmSz/eoKNscJeNCsp6/5bDBtdyPaOejp+UemOM/tCK2b3pMh5T
 ZO/wPrpqs9yDcjgv3nCJa4sfOef2GGMLkEvWMJw9PRjFYS5w6nKrCPjR8yTjNHlX76FVRbFhyFt
 OtPC1GSYc59RYjez/Jg==
X-Orig-IP: 209.85.216.71
X-Proofpoint-Spam-Details: rule=outbound_bp_notspam policy=outbound_bp score=0
 priorityscore=1501 adultscore=0 clxscore=1011 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280089
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[nyu.edu,reject];
	R_DKIM_ALLOW(-0.20)[nyu.edu:s=20180315,nyu.edu:s=nyu-googleapps1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nyu.edu:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:ryder.lee@mediatek.com,m:shayne.chen@mediatek.com,m:sean.wang@mediatek.com,m:linux-wireless@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38224-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[liu.y@nyu.edu,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liu.y@nyu.edu,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42A176D3947

MT7996 hands the firmware a HW MAC-TXP for ADDBA-req action frames
(MT_TXD7_MAC_TXD, set in mt7996_mac_write_txwi_80211()), but the chip is a
FW-TXP device, so on TX completion mt76_connac_txp_skb_unmap() decodes
the per-frame txp as a struct mt76_connac_fw_txp.  For a MAC-TXP the
fw_txp.nbuf byte aliases the high byte of the TID word
(MT_TXP1_TID_ADDBA, GENMASK(14, 12)), which is always zero, so the
unmap loop runs zero times and buf[1] (the skb DMA mapping) is never
unmapped. mt7996_tx_prepare_skb() also sets buf[1].skip_unmap
unconditionally, so the generic mt76 DMA-ring cleanup skips it as well.

Each ADDBA req therefore leaks one TX DMA mapping, i.e. roughly one per
(re)association.  When WED is enabled the mt76 DMA device bounces these
mappings through the WED swiotlb pool, so under continuous client
reconnect churn the pool is exhausted after ~1-2 days, after which DMA
mapping fails for WED, the WiFi MCU and other on-SoC consumers.

Only set buf[1].skip_unmap on the FW-TXP path. For MAC-TXD frames
leave it clear so mt76_dma_tx_cleanup_idx() unmaps buf[1]. The FW
unmap is a no-op for these frames (nbuf reads 0), so there is no double
free.

Fixes: cb6ebbdffef2 ("wifi: mt76: mt7996: support writing MAC TXD for
AddBA Request")
Cc: stable@vger.kernel.org
Assisted-by: Claude-Code:claude-opus-4-8
Signed-off-by: Yang Liu <liu.y@nyu.edu>
---
Tested on a Banana Pi R4 Pro (MT7988A, MT7996/BE14, WED enabled, 6.18.35):
under a continuous client (re)association reproducer (~51 reassoc/min),
/sys/kernel/debug/swiotlb/io_tlb_used grew ~25 slots/min before this
patch (steady leak; pool exhaustion and the resulting DMA failures after
~1-2 days) and is flat after it, with no double free.

 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0eebc81..962dad4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1010,6 +1010,7 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     struct mt76_txwi_cache *t;
     int id, i, pid, nbuf = tx_info->nbuf - 1;
     bool is_8023 = info->flags & IEEE80211_TX_CTL_HW_80211_ENCAP;
+    bool mac_txd;
     __le32 *ptr = (__le32 *)txwi_ptr;
     u8 *txwi = (u8 *)txwi_ptr;
     u8 link_id;
@@ -1096,7 +1097,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev,
void *txwi_ptr,
     /* MT7996 and MT7992 require driver to provide the MAC TXP for AddBA
      * req
      */
-    if (le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD) {
+    mac_txd = le32_to_cpu(ptr[7]) & MT_TXD7_MAC_TXD;
+    if (mac_txd) {
         u32 val, mac_txp_size = sizeof(struct mt76_connac_hw_txp);

         ptr = (__le32 *)(txwi + MT_TXD_SIZE);
@@ -1167,7 +1169,11 @@ int mt7996_tx_prepare_skb(struct mt76_dev
*mdev, void *txwi_ptr,

     /* pass partial skb header to fw */
     tx_info->buf[1].len = MT_CT_PARSE_LEN;
-    tx_info->buf[1].skip_unmap = true;
+    /* MAC-TXD (ADDBA-req) frames use a HW MAC-TXP that the fw-txp
+     * mt76_connac_txp_skb_unmap() path does not unmap; free buf[1] via the
+     * DMA-ring cleanup for them instead (see commit message).
+     */
+    tx_info->buf[1].skip_unmap = !mac_txd;
     tx_info->nbuf = MT_CT_DMA_BUF_NUM;

     return 0;
-- 
2.53.0

