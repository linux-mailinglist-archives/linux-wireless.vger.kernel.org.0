Return-Path: <linux-wireless+bounces-39105-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IkEYFZV7VmrM6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39105-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:10:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A24E1757BF1
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:10:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="CWaQF3H/";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="J77/mLr+";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39105-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39105-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEB243188FB9
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C874F3CF207;
	Tue, 14 Jul 2026 18:08:02 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4322D3CF96B
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052482; cv=none; b=YZUd9NAiPuk/I9rOXs9+4pbFJlskoqsyaoRiw9czIaSDGVffzLP5X4WDPfCz8iBdHNfbAgATPpOUvx9cjVshW8y82nmLAUt6W64mfZtnuuQmjiK6DexibBMDTyr9dtqLzN7PNdpKlS3motSjx5eqJi/iSah5LJ/U2k+mm5LSarc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052482; c=relaxed/simple;
	bh=+trhIffx7jNI4ghFUWbBz/8bZxos82fPXIHJLQikdF4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BF3mK5+iDd22AguTKHMQLG4j4pid2437BuIKuwqqXpEnBEdrsm38RahccOz66Olo+vgNy/ff/N/EjMhVUv74fGQ72KWjpHR01vBhG4Djach/x+rJ770OIpPyR4i0ad4muCgs0xwSpn9BIGjHGYRX6eKhHB8UDKvjTATryyX/iNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CWaQF3H/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J77/mLr+; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EG6vUW975528
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ORWwFTyU8ydlZKKZaPMxmUSXVMyqCzlxGKqNDFWFPmk=; b=CWaQF3H/uZje7rtQ
	MDhoYnzT0Vnd+kcz2ij3/+Dzygg3j+UsiiHcuy3j6FfcfXLJcnd8X3ZYtwVTcb06
	pcC5nbk8tNMRNFJFtpYaJgEUrQa4/wel+yjgX36UqmaHnfGo41TqDuplKVrLEJVU
	ismxUTyXU6gt5IrRk03hNNFHTN0NsntgI63yYsligCj8f1YdI8IHSxyG/6HNluSv
	7fUs0X1Iisam8nZge0rjmsWGXhesM1lltmWaUmYmCJGTvKsujRmX4j1ryuGDiPvr
	y4PBGl2/lv3eUJNDdS0vek1kEene4w+cgcKFYzM62v1j4zfR45lyo5csf5fjCIXM
	/FStlQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgeq2k9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:00 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e8004d60eso250380585a.1
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052479; x=1784657279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ORWwFTyU8ydlZKKZaPMxmUSXVMyqCzlxGKqNDFWFPmk=;
        b=J77/mLr+aT9Lc7Tzdk3L7a6/fCAVMW9q+nEO7AkSntIcZhsR1JOpGtWomJM3UfC+Hl
         wJ6qO1DjhSWT9bujAqD4tjTyHVUXcsRL0tOIP2UwwNCnipVg+jT9usntagRLVi5YL+n+
         U4+4aQPu9dICdiwZY4RhZXnAtfNFdhzPBuE6yD09C0S/89UpMpMwcSxLuRZgbNfXJDIH
         d9n7X0yLzJN5H9/jPfJfheobDCzkP1sn6UmgGg+oRKzggWya5IqbckbobF6WV7/Ebkdw
         zTEP0ALS4ToT/2ux7zG2x1D6JCAPuBxgc3OWaO+uPLZG0us4UTlqRaOltY6uvrabjY+2
         DZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052479; x=1784657279;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORWwFTyU8ydlZKKZaPMxmUSXVMyqCzlxGKqNDFWFPmk=;
        b=R/vtRew5y+wOWgfP//PXT33yfzS2MmPhTuXGzVXHyqD8YPdq6cS3BHVcAnYr2RW0Hg
         aNs+A9i6vPLBgW/rsemMaUwp06BHaoA7wEdJRL3DOp2x4Whi1WzgYC8Ao4crhewvrEBl
         S6QmkjPtSfM0oD046aG26KPyRgsvTQVzSL3aUcw/ijADoU5t1LTTlOtR53zAY+AJJxpI
         eb5VMxQuo9pq+JVXplY/jTsmxXIjmKNYWB4KEmz9jRyS00qYHmB7VWXHZpAY/GSFMtlG
         V+fHTF1SxUOkaA6ORILkeGRmAxAczcWbXq7agOvswYF9/T0hgifcuKADUy5OIXWB2ToT
         nyeg==
X-Gm-Message-State: AOJu0YxAO01f/0+vHN1EoncRFLVcBjwnhJJan7liGD4Hjctg/NmiW62P
	4emC94xyvspXDYtfsYRijzmnOteMYrFWC7KGXPfWxL2SLfyknrz7umgu07RLy/P1hExElcwR3S5
	wrx060LxSyK7XzpMGGVbRp9s9hIUVZj/8FK5OuFy5Hv2052uV/LaWC4A/zfBDFiICaRm/aw==
X-Gm-Gg: AfdE7ckBG5TwUxZq5aXJc9z7IlOiZ9gH19BNcvM1Sg3bCtPCUmVCZEyrrqftWKnossk
	sZm2CCE078ZqCfJWPX1woWo4nWwqzPScZwMCMk3iX2r2ZUowJUN85bmFEb+12k+TYT6AGeWHDvY
	gODmziFgdk6Doda/snHb8rx32I98l60a9Y1XP6lLvHn3vbbQjtfELJJLQwF2NjRc9HfRf7tU46k
	wWIyz7DugGjCYEj32gYqCs1LBav1xQYR2ghit3ozIJFrOY8SeXxxuyV/RMPWBixdKiWaJDKK1Rc
	dG4b5DJ9+1qp25rE6KN0y5CO51YtSXucFk0eFO5rvqs5GinzbmXv8NZfCGAU1yQC+tFHk+yF1jP
	G2hbFW+rzd9m0HPTkM/XJjtr6HqmPQWN4hGHT7QdSP5LJyKJzKcM/3TMS8iUVxnxG0A==
X-Received: by 2002:a05:620a:a806:b0:92e:fe10:3f03 with SMTP id af79cd13be357-92efe1040d0mr1018223585a.53.1784052479604;
        Tue, 14 Jul 2026 11:07:59 -0700 (PDT)
X-Received: by 2002:a05:620a:a806:b0:92e:fe10:3f03 with SMTP id af79cd13be357-92efe1040d0mr1018220585a.53.1784052479130;
        Tue, 14 Jul 2026 11:07:59 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:07:58 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
In-Reply-To: <20260701-ath11k-invalid-he-mcs-v1-1-7d963080c079@oss.qualcomm.com>
References: <20260701-ath11k-invalid-he-mcs-v1-1-7d963080c079@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath11k: cap out-of-range rx MCS instead
 of leaving bogus rate
Message-Id: <178405247787.4102418.12391638022889405750.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:07:57 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfXxzQy9qvkmm2W
 XqHDMHJSmLElk70VHYYyTrDtqRvI7dpyAU19xbcEZC4FYIJAz8qWbVfYC/iR7urCRQshkm3POTi
 tKGmFND+yz48I6LEt4cTm7cTBCz16n7ob2lnuK2QavT0MIkAlb1HyUAS3hBdh9p5bny1PawfFGQ
 JxM2emPncEo1bwoONpNR6Hv+gcqKjwgRZxU0NGtROkiJZUNJ/ws9+bkxcgaASimp+qsHttz4h2z
 TvYDBYWxlDOAzo3UaSjxm9WNTYj2h1nKGhiOEqLGOsA/oObB+gFMkXpdgcaIWnWS98YKToNzi77
 ycFAEC17HKBp6fKRnIVrfZLebV4tUmt71ud8KdgMqZpfOZ0IPnGAvESlFSqTuS8OYPI0YFFpqG3
 Vzyqc/5HpD1q/EvN39SPRDwzbEJe742kNBgTLoKDc63bNUcH/9FAyBfI76YpU6bi8wFnZF8CzHn
 6s5JCZO0PR67rDUysCQ==
X-Proofpoint-GUID: 1_XNWCX991U3tErtOmoNmXd6CfaV6Xa8
X-Proofpoint-ORIG-GUID: 1_XNWCX991U3tErtOmoNmXd6CfaV6Xa8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX1dSb2DJs+Pcd
 4NRYjw1r+9f/IKpvkdI0auOXLSer9q1TruNSWY6G/yBlJFYinbk/8stAbQeIN7tps601GFiRpG5
 T/72X7qw/bOGAJ2V7KY0axBE7QiHRs0=
X-Authority-Analysis: v=2.4 cv=V9VNF+ni c=1 sm=1 tr=0 ts=6a567b00 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=TnFpVpZPzLH6y39Q94sA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-39105-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:baochen.qiang@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A24E1757BF1


On Wed, 01 Jul 2026 09:49:13 +0800, Baochen Qiang wrote:
> ath11k can receive HT/VHT/HE frames whose reported MCS is above the
> maximum that can be expressed in the corresponding mac80211 rate space
> (e.g. an HE frame reported with MCS 12, while HE tops out at MCS 11).
> 
> The frame itself is valid and decodes correctly, but for such a frame
> ath11k_dp_rx_h_rate() leaves rx_status->rate_idx set to the out-of-range
> value and never assigns rx_status->encoding, so it stays RX_ENC_LEGACY
> from the ath11k_dp_rx_h_ppdu() initialization. Once that frame reaches
> mac80211 it trips the rate sanity check and the frame is dropped with a
> splat:
> 
> [...]

Applied, thanks!

[1/1] wifi: ath11k: cap out-of-range rx MCS instead of leaving bogus rate
      commit: 12b09e478aa7459b7893a695ef77682202f2da83

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


