Return-Path: <linux-wireless+bounces-37589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wxgeBO0cKGrI+AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:02:21 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D10B660D00
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:02:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=NBTTHkYe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=biVwdiWn;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37589-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37589-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B14030AC6A6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 13:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5450D42B726;
	Tue,  9 Jun 2026 13:55:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D01E42982C
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 13:55:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781013315; cv=none; b=nJl8OR2RZDnFNHDPUbC5Uj2ibeadvV1rkv9bDq2/AeMuGf52Hl5j3SmxWSliPFWbvO3vaeFWSfKCV6M2nvw1Puh+C6fcVK8ce2tn1B/vUmFsz92xaan4t7SaLqxB5zHPv4mX4sK4IhiDXgWYDGVhzXHoV51ldxF6ddlm9Xd/K6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781013315; c=relaxed/simple;
	bh=jd9UDLmaVY7ysw8xBv0WdhKV38CvpYUHm1gQkhfwwYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LUq/MDVkQxpp0PAb29RuMM1NGqR+Oplnv5dPKAXq+lsJFOsIKHRFaV6tNsQz6QNqVa0WJDZrQ/BsTDtL9ux7UT1yJjBpJVJ0oOYe7S4sQAwxgi0QDjcI0tp9cY1dyGoptlSLDv7VP4x0zmVSyX09P3WsMtWZDyCTmvJZd6LGybo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NBTTHkYe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=biVwdiWn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClMCA652219
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 13:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SSU/vrqQx8ikcCpgUp/sBgUBKKpDN58VUPNhL9W1xXc=; b=NBTTHkYeg+wTkAS7
	bEjlyZsPqghlwq4NUnqLbfOk7ifMNQLPEgkPynmFkhIoryQSIWvG90sbIqLZ5G/f
	fmGUElC8d588a3nA0nEwPFreNDTsuKai6shBs/Uv/NYtvIJI3Mim3pr4A6qeYkXh
	w2ItIv4cu+gmvo6vLt5cx7V8WPK+RQg3ElWTVH21Ys7VQR//1AUXd68twg1Jznj9
	qTSDLnnEDl9UQgq4pZ4A8dFEjDrkCzDo/QwFdQw3XxFvNQ+tzAhnNCx5isrhDW+o
	f7+eVF8Mg/Tm74NOyCOuOdfv44tOSQp0fNtdpTQy36aL+MkClNk+7BtZc/aka/Os
	DTctWQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epf0ssgta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 13:55:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-137fc6f8e9fso5854115c88.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 06:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781013313; x=1781618113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSU/vrqQx8ikcCpgUp/sBgUBKKpDN58VUPNhL9W1xXc=;
        b=biVwdiWnBuamprFcHEbThH/8tsGTuftdhu3SshmamFFlCdGpgv3Ddr2bMUe4izX5Tx
         peCRTK8Dty6KkfCt+R54PpZQxy2tl2Xd/lg1MJxLN2jfJ1Z5cQLTxfHDUkING+KNlyTB
         3BL3QNoD6x56BFfQV7IPfZjdr8BpHdyBAvLojfs2m3HosHcb3yKF1+UQrULLoG4JDQ4G
         uP0OPKMyovvDCNx3akAYlNMgdsJrRqjZls/0ahj0SduXbiSvGvKS7PzQx9J4w/GbfHGZ
         j+gYx+SI78GfZJMR0tibAwwQFVy/R84rpG60Mwo4mlEfq6c5W9GJxNenrSTPPZu7TiI6
         UHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781013313; x=1781618113;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SSU/vrqQx8ikcCpgUp/sBgUBKKpDN58VUPNhL9W1xXc=;
        b=NmUIdiQMU90QsQMyoVhsIFGV9F9kLLHytSvPaGyHZIBuwdIwj044CJI2hkrr2/1QGW
         QTtJWACP+kPlF8J4qXbkDJCFe9OEbDQOoCG6GDi95GhCYZudBtHQHPai5u5QlgIhPEgh
         a+3YfXzhQ4V7HVDrVlzU63aJNWjnzZsPs1Dx2KTZcD7zKPKnFB9/0NUYXPZ3Y+KiYLoa
         knPjhAtduX3RmLZc8efPsGjNisl5rmqr1THXnBK530ol+rovJACOZ+CT8NXD/00V73CU
         k42gG8lM895sWupzEa5ioShq8IlVy+5E22otSpY1rmOcXp28NEXMlTRQ0iEQoMgibXRn
         u9mA==
X-Gm-Message-State: AOJu0Yyf+l4tcafNPqT0W1/03sD8eCDUsCMD5PBguqEicr4hwEVKSS/K
	ae7564bRH4PP/6nM2O68KgFpnUjhikHHndeEcgPHw5jBigVyeliqq9m9oMjvFT1ezT9am9bn9oz
	bne3SVy7ln972ZJcqfvXWc2roTvlE5OuFi8NeTi+i9gYvQ+KVoOuKeoJ4bbtksGm46kP+Aw==
X-Gm-Gg: Acq92OFaJpRCpDNEL8m7g/T6imBeb5mu/Yv3pmn0UAggkR8S6TY/DKZykAIy1j9E4iA
	8gHeoPV1WxM6qJUlL3uWYY8W+FL/zhPZBwekdQ3NCZtmn+waF7+8dYqck3sM+LMQS0YxVFQJGL1
	wmqEcBz23XlUMaPi1sxf5r4Hoqt8CegvvpBznJG7ZwuGTMdM8AtMimXY9418kZ2+a1gRpteJXNt
	zNo+j/eCAXIVcuJW8VSL7Ywj8BJspYbRt0ry/mrqrEfEvjMOMxk8+eBXgleevecEg8q2nFQlBrY
	2Bgy8KCrflGEAP1psntbYtH3hVPSNIfRdZvY3JBQCrmpntnMzgfROqiJdk3IJUFKPEMp2JYE4s0
	2j6rojdZdtoBmf+OMNzcbzYtboieIcXRFlOk2pLTFvLJaoRV6XRdV6M6JsnIfW+xM9qv+Au1mUY
	skpbcGo1PmQ/w=
X-Received: by 2002:a05:7022:b9b:b0:137:f958:c072 with SMTP id a92af1059eb24-138066dfd6emr11400482c88.20.1781013312618;
        Tue, 09 Jun 2026 06:55:12 -0700 (PDT)
X-Received: by 2002:a05:7022:b9b:b0:137:f958:c072 with SMTP id a92af1059eb24-138066dfd6emr11400445c88.20.1781013312004;
        Tue, 09 Jun 2026 06:55:12 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54c9c12sm15289555c88.6.2026.06.09.06.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:55:10 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20260604095831.2674298-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20260604095831.2674298-1-maharaja.kennadyrajan@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: enable
 IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported
Message-Id: <178101331075.3249128.13745050048351876342.b4-ty@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 06:55:10 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzMiBTYWx0ZWRfX/r8zpLyhjmoN
 B6w9r3RKc/0UQKwOZNcv6RXo7/+wK3tWDuJRUw9gThjN6UQEAMXZQ+Nn8BQbvSamQON8eVE7Np6
 7P8PAnRfcoDb6knm8JKuEEcC529rmWxVUsV2OLxvJhqUB5Bc0IyrEFTmhvDrj/Ip5IKN5JPCAcB
 iMg1NKC2nYLXSV0l5OWpGvNsm0y3tqca0zh3+fQ65lT2goMtPFKa3KMGRBP4ksXTCZwWCJlaKWt
 Xg4sUu6BdqWGLiTsdqi8XFCZyB9UDuNaMWdJF2KBFdA6mxlOT7vJ9vPPVHQapjRnmOSmgia1r/o
 QulK9Sqz5pKlfIkve90n9y53zcvNGQaqoqiaTrjZ3ukuHU1ABCtgcOWT+zmcpM5hhxNupoZDMW8
 eN7ZtAT+pnGjw3YBSAmKc88NWYKiIOwDDcBwfmDCWYlstKcbg9OQA85sVUJSTJ6u58OYJupDSfm
 5Ncjb6i+rvGAKlwpa8Q==
X-Proofpoint-ORIG-GUID: jXboeThyEuk6CtGjqJkbc34HIjLOV4DM
X-Proofpoint-GUID: jXboeThyEuk6CtGjqJkbc34HIjLOV4DM
X-Authority-Analysis: v=2.4 cv=GeonWwXL c=1 sm=1 tr=0 ts=6a281b41 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=R7FzeaxWUBe8q2FKhjAA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090132
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37589-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ath12k@lists.infradead.org,m:maharaja.kennadyrajan@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:quic_wgong@quicinc.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D10B660D00


On Thu, 04 Jun 2026 15:28:31 +0530, Maharaja Kennadyrajan wrote:
> When firmware reports NSS ratio support, SUPPORTS_VHT_EXT_NSS_BW is enabled in
> ath12k. However, IEEE80211_VHT_EXT_NSS_BW_CAPABLE must also be set to make the
> advertisement valid.
> 
> According to IEEE Std 802.11-2024, Subclause 9.4.2.156.3 (Supported VHT-MCS and
> NSS Set subfields), the VHT Extended NSS BW Capable bit indicates whether a STA
> is capable of interpreting the Extended NSS BW Support subfield of the VHT
> capabilities information field. Advertising extended NSS BW support without
> setting this capability bit is therefore invalid.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported
      commit: 63abe299b12b317dfee5bcd09037da4668a4431a

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


