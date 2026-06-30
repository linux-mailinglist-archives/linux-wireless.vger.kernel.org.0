Return-Path: <linux-wireless+bounces-38406-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hBLfIEQ1RGoqqgoAu9opvQ
	(envelope-from <linux-wireless+bounces-38406-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:29:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D48FC6E8263
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 23:29:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=e5QRvE4k;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=RcIS9pos;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38406-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38406-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94D7B30ACCA9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 21:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05B031E828;
	Tue, 30 Jun 2026 21:26:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3CC2DCF74
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782854781; cv=none; b=e1jkjWOzliY+l/kSd7ATFbfUkL/lM72BkztcvOeY2wJCNaFWRu7yZNxgtDDlkyjkpEl2akjz8wnG0JvvTZSTv1NGw4bgrE4fmE4ckH6d0DtCK/JJ4jOMZdL16hPHHNZuv3PNJwcLTZrZDFOmvLfahG8HP34gbGbQN0fCwY1kups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782854781; c=relaxed/simple;
	bh=frKy+V+pXBsDY+8wpMyWJ9Tg+S8sKrPd3Tvk1vsOpkQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kjeub/ak+oM0tIWOB0nVGvWKRjKK7SxkeY915lGzvmiZDsCk2PMSZnX6tAkHltRsK0DAGBgrSQ6ls8jNSn+2SVzC/HBRXWPRy1lveX+DZy/MXwtHJUx4tISPJvgyOcDGh7Rg/2YuPnKnOvrylUj2mPXa3DybTRr6i3elNNZTtcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e5QRvE4k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RcIS9pos; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UJDkJv2942727
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L7t+uhAr4n6UmJjPAB/Y2zDizxoBpf31JurKCJxnvW8=; b=e5QRvE4kRpZTPdTv
	c2/KPwDfznC8KRsj2IALreL0fLb/t6s6s1Oz033c6FcLLD9FydAP9/zG7vxtDlsN
	xPx1O72BJePepOuL1/qOCqMH3j8z4b+l8YTGg1v46+L45uUvy0fgO4T/M5Id8fwi
	DDXaCDNPl9pBV+oZqSWSmaRHUSdv1cajIAsmy4lyGSJ9giZV8IGRTLXX5H+tnZ1I
	/qutCj4dHSvXJoV4BYPMuAaQAXr9tE9nBu7eHqLrJ4PmSsmMCGxEhUSxTlyc8zON
	K+JbbmQkTgpmhHD5p2xof4mdobhRTLZhUB4qW9iY13QMxdYXojJAHphyPP9p+VU3
	RpElyA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4j99h0f3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 21:26:19 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30ed53abff8so2685914eec.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 14:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782854779; x=1783459579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L7t+uhAr4n6UmJjPAB/Y2zDizxoBpf31JurKCJxnvW8=;
        b=RcIS9posFd7LbJ1gqhKgbo90zAzMIdcLFDX+9TuVAicmtKN2kR6Mj56tLHt5+2XG67
         Yqy9p24gkJ+ds+b5cBkGbp3/9W7lhTXB8vn9m3wnlLBc2MfLYd+O9cE1HWh3AdY6lzAz
         SiK6Afq/mVxrcMtM03/cClP8Vua/TvC3N5O9vljmZhmAOPFNgQxGActLbh92m5uaoTI7
         n3BD9kIyrA6XFUpIqB6zUM+preQ254O/janDoNYumFFOCqLY0SxxeNrnpjq1uOUgoD2c
         WBiGaQwdStUQaOkejc86hTB4hqN46sN/wRqGyP2u+QEVTmzHtE5jHQ2PDOQTqH1M5Q+m
         zmEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782854779; x=1783459579;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L7t+uhAr4n6UmJjPAB/Y2zDizxoBpf31JurKCJxnvW8=;
        b=XN4EvR+pmODhX04Y6tFtZqVoUvNF6WvC9r4KnyHx0ic3KsyJ9nVbhWQh4lYxGPouFi
         FoqgOyIzTBM4fwYXXaNv78M0GrH09cRYbfyN99JJ3MVb2rjlPd8o7/y9tgx306ORGAIN
         s+waSLDoqI+Erj60gMV9TnqIMuooAOo5THRP2/xjba8KGZ9NwugemkMy+waop+hPYKIR
         ut0fNxzyr9dZ5zho5mMyeATxWMmxV9dpd43ouqxtgF5df2nOK13zYpbo4XZw/L/iDEHV
         NokJiku/cgC7P4cV2FEGSlP1sgmS+ndwAcX3j/kPi0z2uvGx9A2TtAntPoPrk59avfFb
         7Y7A==
X-Gm-Message-State: AOJu0Yw/dzSUMnJUt2tI0Pn9/jLGj0sIi/hd++lR1e3SQuv38UuFO7gd
	eGwPJ2Rb6qFs6HAdeskzpQSq5VXjDWkDJjubARaAlKfbyi55/MspbKU+PWxNQxJc1BkX6RL8cKf
	gbV420xLYFPrEZa5l9S39HIouKbLkCijWVtq6+xZmjc11oqWQvMT+v6Y0SlHMYfbwE+/EUw==
X-Gm-Gg: AfdE7cl1ZZGhaKWmvvMpv3PD+Ss0B4sjG6A4IHU77cBLFuxqe70SirIBPU60zAJglfx
	pVK9QPfZOFmg2H41+lfZvxtB4+QqZF4E0aV/o18HAfbIylenX0MdFWXZ3y3DmglIaLKxslnfvvt
	Nutht2VtRqG+y95+CDahYms9jLjL8TgSjQDDM8bgtTtmQXbnoc5ogrq7VlDPEPvHyBo3qtyw9Uv
	kh9q2ZdeQXIJFhm7S//mPq+P5oGSbxp5rpPmfsAsTzOpjj/DtttzbZ/ZvkAXmDDTXzqinhj8WHk
	18636d613JzeeTjHw7L1mwA3A6ADiSFt4s3eHUcEaGl929aZzpFoRji0Adkab7N4VsW/lPasTNd
	AmLK+QolKWgrVBjZGlc9zGTp1cLT5dybZtuImGsG8hhRtfdX0QwvR+xsxFEpXo5FHyA==
X-Received: by 2002:a05:693c:41cc:20b0:30e:f0f2:5b88 with SMTP id 5a478bee46e88-30ef0f25d35mr1054949eec.36.1782854779363;
        Tue, 30 Jun 2026 14:26:19 -0700 (PDT)
X-Received: by 2002:a05:693c:41cc:20b0:30e:f0f2:5b88 with SMTP id 5a478bee46e88-30ef0f25d35mr1054922eec.36.1782854778785;
        Tue, 30 Jun 2026 14:26:18 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300b286sm11604046eec.12.2026.06.30.14.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:26:17 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20260623-qmi-inconsistencies-v1-1-0fc17f2b8338@oss.qualcomm.com>
References: <20260623-qmi-inconsistencies-v1-1-0fc17f2b8338@oss.qualcomm.com>
Subject: Re: [PATCH ath-next] wifi: ath12k: Fix inconsistencies in struct
 qmi_elem_info initializers
Message-Id: <178285477754.1590147.2554100101750757747.b4-ty@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 14:26:17 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX4LImbgicwq5T
 lsjs8GQ6+uQzjSolzUKreUqg4joRB/7IdVcD5yZHqaVkPIfNMteFvzZ6wCFN6JgBOONOCdwk0HM
 8RgedGmjZXg9TrXLvkCkyg/4Iks0yF8=
X-Proofpoint-ORIG-GUID: uN_1rQ9lufqPX-CkEXJTv7iVcQ9_Gquz
X-Proofpoint-GUID: uN_1rQ9lufqPX-CkEXJTv7iVcQ9_Gquz
X-Authority-Analysis: v=2.4 cv=bNcm5v+Z c=1 sm=1 tr=0 ts=6a44347b cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ZoZKXFMULng3zEwbkoQA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIwOCBTYWx0ZWRfX3pHTy3Z8agRn
 yrYHMZGW514Q0CtSMge1c7rqTBrrpgyvCaiFTbVcuePGJG6d2hpGg1vXJFPHBrxPJWK4c4Ta5L6
 bN3bvfNhXtwP5lrahJq+MikSUs8LW1k3EwYzNo2wc8x5y3Zi3+OKdAni4ym25e99f5J86Rwai/6
 jRFiXtH308zssSJPYxvUfc0pCljSJreu5qgPE+tHRazbQ207tPyHxQtAECFAnrLjrCVJEyEVuW+
 ANurbDxpkmDib8b0aJN0Z4zWjE3m0/mvxx4jwMZhXEY7tUz4ZD8mcUwgaxCDLQNy9LWPVUeE2km
 1KdRiNOLfkUsGA9t4Oc5SeNC+UeKdpDjy7UE8m5uqZ1YI52WA4lBtPF/RhB/vWth0L/2dEi3wkC
 peRYnN596ZRAavRtVET5RlBfrqihjd5HwfYCAngYjXMyoHSqXiLOWddZ2uh4Wl7zTgpZMSJkjx4
 iZmQosqQmX5MCQs2+dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300208
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-38406-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:raj.bhagat@oss.qualcomm.com,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp];
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
X-Rspamd-Queue-Id: D48FC6E8263


On Tue, 23 Jun 2026 09:43:09 +0530, Raj Kumar Bhagat wrote:
> Currently, the struct qmi_elem_info initializers in qmi.c are inconsistent
> in how they align the assignments, with tabs being used in the majority of
> places but spaces being used in some places. In those places replace the
> spaces with tabs for consistency.
> 
> Also fix incorrect and missing terminating records in the following
> qmi_elem_info initializers:
> - qmi_wlanfw_shadow_reg_cfg_s_v01_ei[]
> - qmi_wlanfw_mem_ready_ind_msg_v01_ei[]
> - qmi_wlanfw_fw_ready_ind_msg_v01_ei[]
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: Fix inconsistencies in struct qmi_elem_info initializers
      commit: c29d1550e166598b9ee6d48c488eec0e79f98d52

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


