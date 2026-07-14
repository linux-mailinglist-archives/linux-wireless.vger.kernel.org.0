Return-Path: <linux-wireless+bounces-39109-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ysyxM9F7Vmr+6wAAu9opvQ
	(envelope-from <linux-wireless+bounces-39109-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:11:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E47757C04
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 20:11:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=pZFzR3bF;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=AjgzGupP;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39109-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39109-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 778AA304D5FB
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 18:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316C3D7D65;
	Tue, 14 Jul 2026 18:08:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4A23D16E9
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052490; cv=none; b=VFbFUSdvhfU4lxmEVg0CkddOI9mEMjML5EnihJOO5dEkv2/EBzBZSASI1YVcFUqqZ7P+s+94pokuBv+wZBVjlkNS6vVeg1Mx5DdwIkw66T3GcTPGn+62NFqSV/MjO0fonagAzb6q0ejGqQQ/k5R6+/r3LEF7KNXnnRnSUE0YKHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052490; c=relaxed/simple;
	bh=Umu6fQ4p+1JPqL/opNfP+Id73tqYM8OW8/lWV8ON6i4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Iqsp+59ySPu3aH3OwJcQuEaD9dirkEU3Xa4HJdcSXiroJ2lXU8pQbL1MpLyDwc87To+GXlS+9VS9dcpRGYbHsZT63U35pvRmxUyZ5rumQTNt2Mexo47VWkjTEGmT7gZfPjoOR8JYwjqWcBNVAPGhIPLzG24dFbrW4hMy2cqN31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pZFzR3bF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AjgzGupP; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EHZgRr1209855
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WLV1mDiBkZv+B5vStQykre0lNo0Sfl+ieKWnlVoNGUE=; b=pZFzR3bFHwTLWnWL
	xLq0qG19qt4SpFIDur4y9JySQUre+2umV4ZwCVoGjD8Gp8nTs4gmguAOrLH++5Wr
	5SpZZJNko7I+2wWhCeIwEOSDSz4A/EugVD1ZhhXlTIFVHibCXcWj9hX/Ad32Z3dR
	lEiovyWdY6CmPmanoCNIcaOleKztMU6mMeAP+gDraBLHqUsJpB+vKYlDl94AKkh5
	rbfIaU1OcZ3uAwZcKFw1dxKx2HE2313DNYrPa2k1dN9lrrdPRq370sgEtMtOn0YC
	kdvUTpKWF1l/qeiePT/kPDkrJ1lVi8E5DbOvY1V3GapBeMUQkZ0C8vNZeA4o+sSX
	TyFt1Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnnr1931-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 18:08:07 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e6a2f5995so722789285a.3
        for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 11:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784052487; x=1784657287; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WLV1mDiBkZv+B5vStQykre0lNo0Sfl+ieKWnlVoNGUE=;
        b=AjgzGupPBDruqIO2vJMs2LV+TIcArMtNYPmKIKFWg9bqpX4qoYpCiUS0n+hGkTu6R4
         XycMGLghmcCfS47MZOhccK0tuAZaTRe06jQycyn52sI7NSH0DFXcBQyZn+M2hgThf2hp
         WW4JZ6hagaqxMJyth5X+iDHoo6L0xI4DYIkVpjifo3El628UhPJtD3Ewj9j0YhXzaCi8
         F7nAphHOfL/4K4bApA/pG5ajNY/fRho8jjWZ2b/gx3kFd9URBScAFV39gvgwi+pdgE2T
         pOPbjZIt0ipVnvEqYOEHr9Fsx0PcMIMmcpcDoRMXSV4e0a3RwtMEwiDvSfaW2nd6DJ5l
         tgeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784052487; x=1784657287;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WLV1mDiBkZv+B5vStQykre0lNo0Sfl+ieKWnlVoNGUE=;
        b=ruDZ8uomTKwFWZdIVIr3DUjx9qE8qzQa5UzdHm/yTXRqHJ95z/3e7/we5Xks90MJZz
         O3b4vWKyIOlNgxR9Mg0+2RfMuCALV2SVZi5hOMIyWAZ9KCT3kNuc5B/KdEgo1JRP16eN
         AXtYb8wW0YhDxG+f6dqvV8doFwvbL1va/YFfrOcGbTB10CA7Cwdk5LssC1F4biv2wwH+
         vUVTUnvoBhltOnCOGSwRh3Gmzgt889SAhI2mFhyP7iOCPR9qxNiANJcff7nDMnluPUMP
         1YvqF3VKJyQqOdwUJ4Vaz+MNMjRdThAkDRRWeWjydZuM11/427mecAnou20VVej3qnH1
         Masw==
X-Forwarded-Encrypted: i=1; AHgh+RohaFvbHlcWLcIerOLplfjzAUasbx02BX7aYWOqUYvvC/9r3LL0kazfhnBwKnGo5tgr+gz3u855KB1/jgLWNQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMbvd2PrnMuMVQSAqY+Q6aeu5fFfzLsQI9lYLTdtFZdzGDk39C
	lgVPjo+TBd9KYiIkwdjk5FQijSxXoP4a/Zjq8TrnbWToKXATbGRyy/eaOQgHWCknEE8PR5Si6ia
	6o9119af6e0/wn2jSgRgswbTdLMnVkAR/iBlTgumo4QCyUiZ04d5UEZFmUrEu2IGoMSLAJodTJn
	zeiQ==
X-Gm-Gg: AfdE7ckQJB992HfzFor1s54Nka/sdOV0YKJRwBN9kp2mrihJXWd1wqsc120smDmZGmo
	bImO9YcKbvM1sJGGMCD/+ilky9ltO+dBvqNHBddqbs+nU/ugfikjOuau0FWS7DbVcpXfvwgtc6t
	7Op/FGSu6j+9P+OO3hVT/7wLRtGb/j91TdRUZW3aRfFvDN6GBcHc7mtqeDbZA2MHagx6J75YGg2
	r9+8wEa2l2R6l1SQsVycvTEOXOMgnOi4y4L6ZG+huCfvMgjauWOpGbOlZF8Xh3FUyxqCYFClUhi
	Re0FbEx3t1FXUO7ez/69kq20ta1Ctbea/i0QbAzSYNopdqEZRKOdPWLIOkuL8RKlzjci1R6IpOq
	/n8dVJ5ABXHDVIqPmgz8rgbly0egXq0xRpKnJReQK/dnBFD31RB05R3lLsw1LVP/EaA==
X-Received: by 2002:a05:620a:4453:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-92ef2cb163bmr1379876085a.52.1784052487088;
        Tue, 14 Jul 2026 11:08:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4453:b0:8bb:ac44:bd3c with SMTP id af79cd13be357-92ef2cb163bmr1379868285a.52.1784052486404;
        Tue, 14 Jul 2026 11:08:06 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930759c63fbsm465448885a.22.2026.07.14.11.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:08:05 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: jjohnson@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
References: <20260704073000.3300099-1-miaoqing.pan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: fix ML-STA authentication
 timeout on QCC2072
Message-Id: <178405248488.4102418.9268581656192808598.b4-ty@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 11:08:04 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX8cpivJCf3bMv
 fzH6bScjgkRhKUEtCtUqEXWnzKodi/ib8KmzpB4blhevnUer/ySnlXJPIFysXFxYk2wp8bSsMeI
 bgRuR3blDytALwtRVMLBFl5kSx6GF80=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE4OCBTYWx0ZWRfX8dS0qaUqIqRX
 QrZN0PHVHamWAvlTdWctC7CcO7LAjWfiqeKmnLo+/jiEB/aeNHwih5U7StgL0tFFJvl7YXBCPqq
 OnwQgbICGAwLatzu/vkqRfDWZgduhs/pSq/WLyWxMrkcFOy+a0tb//KXmEU6BBPsNMHZc+P7FTX
 ySRviEMTq8eNMBm79FJ5+PvcvojnKaW3B34rVhMDloxAb3qeKjYYWt0vL4nYEfg5ZJPMpR2lV/J
 D1WcY+criYdImKIj6BIHqCDhHgCLspBtx4KIKBnRn/l+1BpH2oFUitxE+bsypSF0FYXfGn4KtCf
 dlubgsbWuamuBMJpZlL9HYpLYgRPfSdqeeMusiLNDsck6EPzNhkSdU1ab53f3cC8kppBXnyuPyq
 VPDcGT7bN0gpJSZMR0MqBmdcJgcr+3fomMFgbnlGQkDxH1qEIhc1XwOqWJceT5asknrRrtbzAMK
 cYBpTEK397kw3wB8lNA==
X-Proofpoint-ORIG-GUID: DlAts0fQfRDpYNYHpFZooJ_TSbWQGZ8K
X-Authority-Analysis: v=2.4 cv=NfPWEWD4 c=1 sm=1 tr=0 ts=6a567b07 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=J60ckWpfDA7ZE0iGEaUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: DlAts0fQfRDpYNYHpFZooJ_TSbWQGZ8K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_04,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140188
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-39109-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:miaoqing.pan@oss.qualcomm.com,m:ath12k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	RCPT_COUNT_FIVE(0.00)[5];
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
X-Rspamd-Queue-Id: 23E47757C04


On Sat, 04 Jul 2026 15:30:00 +0800, Miaoqing Pan wrote:
> QCC2072 firmware interprets the MLO_LINK_ADD and MLO_START_AS_ACTIVE
> flags to control the link state during MLO vdev start. MLO_LINK_ADD
> indicates that a link is being added, while MLO_START_AS_ACTIVE specifies
> that the link should become active during the start.
> 
> When an association link is added without setting MLO_START_AS_ACTIVE,
> the firmware may transition the link into a suspended state. In this
> case, authentication frames transmitted by the host can be dropped,
> leading to repeated authentication retries and eventual timeout,
> for example:
>   wlp1s0: send auth to <AP> (try 1/3)
>   wlp1s0: send auth to <AP> (try 2/3)
>   wlp1s0: send auth to <AP> (try 3/3)
>   wlp1s0: authentication with <AP> timed out
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: fix ML-STA authentication timeout on QCC2072
      commit: 3567d90721a8a51f051bcea3937febddc973e14c

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


