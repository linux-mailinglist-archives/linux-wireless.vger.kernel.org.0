Return-Path: <linux-wireless+bounces-34623-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0En6Ey8n2WkPmwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34623-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 18:37:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6063DA766
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 18:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D699030057B7
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 16:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481A73A8757;
	Fri, 10 Apr 2026 16:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I4fI0yvC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dH5vj9kk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B54A2DA768
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838357; cv=none; b=l11AKkuC6+zXypAXVzcTCA1ynGN5qSjliGg7dJdOyVsF/Jj1CKuS58mGFedzzKTIXyL/1XB2ePAHcM2USfXBp8mSTiCN7vXeT2xAOIVAwP/BB1E5hbiLJafSOrcrSrp5EvYT6pekYuYDpO8A4FsWb9f6DhJFzIYGPIx454I7pJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838357; c=relaxed/simple;
	bh=eaD86LaASeB3Y8XE4CVKKJQaPjEk94hYAAjJc8Fmau8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N5qZzP+gVmVvQKj8t6Zdz+JxTspq0MrrLRFtGTM2XLHcWi58Oj126W5s0LRsCl3o5K8/hhIQKGurdRoaANyfuK8RjAbW5Xb4x8NX5XqwaqFTC7u4zZzZU17YIFgm9h4oQJ9VDodH4XN1h0Z75bZcqE1rZ5V2sLbyuiwoAnzRvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I4fI0yvC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dH5vj9kk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63AA9ihD2047753
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 16:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OlhlFH6bwXmezaphpwpChPsxmeGk2maLYkli/F30jLA=; b=I4fI0yvCiDreY0uT
	/e0axn0L+EgAhLSeLcPIz9LH0owbOHaU808gIIp16WyYMYpBVAH2oAKz7pcymgMa
	G5ydGOzAZzVa7RnyoP9pZSb6hfF32qpWPTu/vgPVSrz+FnN/fMM180zle56rx8Rk
	fsH0sKvosuxyylxSY/bBbszMOxqE45dWQMnTjn0VBoybd2iWvjopVCvfaiqUTwxW
	Ec3Qrftgo38a3+dfcvlOFhtHWv0vqctX9cCZAVmTBzH6WKT0d9ry5mxiXbW1ebvd
	rMzrNJp9UeUMukdwVs+V353jKyR3BTP0upOYCBWzgN1Tiz4TgwDA22APlXtg3E/N
	ojOFlQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dey7795q2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 16:25:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2d5de9deba9so1360276eec.0
        for <linux-wireless@vger.kernel.org>; Fri, 10 Apr 2026 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775838354; x=1776443154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlhlFH6bwXmezaphpwpChPsxmeGk2maLYkli/F30jLA=;
        b=dH5vj9kkWA7NJNztNgbP+7wg+LBC431RkD38nozaErH8AgB1ZKkJUTY8T00b7IsPbC
         x/MFDQkmq111vi9lsJOwQqWV7+6zEY8ZyAK5R0p+4gMVLa0zvtUW8mD6ethaDdF1ErEl
         utuKaOr/6e8oRMnAupePmvRBrq3cV3QaqZTzZsjzKFty/6NKetVTsKsZ6xBVd4eS9eYw
         q+7wnSttn2u4XOhQtubEGOXTZ5R1cqwklIx2U/3goTC1c7kateZqCQYQOECU7/KG2yet
         r4Dg3W0/HtzcR4R0bbPLOisIBYtD9Gm1Hoybl5Ws493Ci/BukaA9xU8kcr73Ihx3OueF
         DUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775838354; x=1776443154;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OlhlFH6bwXmezaphpwpChPsxmeGk2maLYkli/F30jLA=;
        b=DFAXkFkJrd+7y0wovTw192R+F9zTp4q0HibdrJgRGFajTlDBr0jwexKQFir5nfk1of
         4ukZBpT+0l0LqqPfEpmi6fS3sJMuNUzTl8KlbzALetkSXGT9h2cCAFwtxVJDYK0ZhyHr
         xLhcUI9QwhAmFYoHW6cJsEtIxmkqRSQkbMMddfogsdo787hzQHcXUzT8HDEoDnkAhAoZ
         KXNtOon/loeb8pPCZzVKhtvO/8XvSMFZgRpuVAA7xDt+JOxp9wY0L8kOaucjEvJ3s1VF
         onZoLlU8vsUDJqbo3IW+FGFTE6r64NMIrlfLrfOMW2ql9pl/4vokL8BAOKC6vn9TYcE5
         jTdg==
X-Gm-Message-State: AOJu0YzquinoA0c769l4Z8j2ZFpqILtlWMgAC5mZJ6IGwi7Ud/wAJDJw
	Fx2Q7VTDCBYasGzHAH0lG5hpttQrNzANmt5TkXMb8OVi3rW9PLx3lNSaya7fqL2/8yEVr0aNxhZ
	cu0fMatkoDoaud8CNdSUlX0iMo+S+xbbDMtApaLoXkMTk3IEM7hsHLVUWvTWx5yDFZOhc7Q==
X-Gm-Gg: AeBDiespxti9fBBUvWDHJuNaKmQvsxZyIIU8HLrlDQHkPVvxR/ElyJNK/JRy+GKikr1
	3z1/EpbU4gzjNNnKKIM6DJ60PRjImXBCYEdWPp+IWRBf/kcuT/hUYyeLXnkJPEmbl1c8UplYbxQ
	mCs5vshucPCpTHh6YBWUpodQABr/wTVoU+MnUoN44mbhDM1C+Uv1IHY4mcg3GXwp8fpnDZ5ZMU5
	YxaMq22cvFdOKfUNKLQ9N4WuonFmYw0O9MboAENooBliWviHv13BunbBRl4byarP1+ZO4kzrF2L
	f1l4QDu7n5IPlsQ2uLEsAnnyrQ35Mg0gmkV3HlkCmiIVsiklXAAeel2adUrjVV8oS7F2I8aPwhB
	cLKwgSxSpCnOF29KZpH3BCvpO++6QHFMTfXA7LNQuOV84MK0JfLIKmihcMPSfzl2j7GsKUZ5ZE0
	dW
X-Received: by 2002:a05:7022:6088:b0:12a:6fb7:8801 with SMTP id a92af1059eb24-12c34eb603bmr2209336c88.14.1775838353772;
        Fri, 10 Apr 2026 09:25:53 -0700 (PDT)
X-Received: by 2002:a05:7022:6088:b0:12a:6fb7:8801 with SMTP id a92af1059eb24-12c34eb603bmr2209311c88.14.1775838353133;
        Fri, 10 Apr 2026 09:25:53 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d561cd2c09sm6023181eec.18.2026.04.10.09.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:25:52 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: ath12k@lists.infradead.org, Nicolas Escande <nico.escande@gmail.com>
Cc: linux-wireless@vger.kernel.org
In-Reply-To: <20260407095426.3285574-1-nico.escande@gmail.com>
References: <20260407095426.3285574-1-nico.escande@gmail.com>
Subject: Re: [PATCH ath-next v7] wifi: ath12k: avoid dynamic alloc when
 parsing wmi tb
Message-Id: <177583835249.339192.7078755593589068510.b4-ty@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 09:25:52 -0700
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: GR7pK0VzR0c23MwsdD-HL_nmHjZIHM31
X-Proofpoint-GUID: GR7pK0VzR0c23MwsdD-HL_nmHjZIHM31
X-Authority-Analysis: v=2.4 cv=VN/tWdPX c=1 sm=1 tr=0 ts=69d92492 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=UDkKdCGfVg8aM8bNbj8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDE1NCBTYWx0ZWRfXxLcuGglHToQF
 0WalgR1jPogYsM+WJ4t1BCu6Kbj+oGGBl+iHH1qHpeEiK6QCry0uiN7YggxwmkF3/ngHN243DaP
 QhyW6iwbxM/JVowqiy2mQ6YAcna8bEM6yhE8yZcYlosnKaxklhsd3lHnzzE2h/SnA+jwJJOUr4H
 esExcNCyiJ7rskIz9jssYmu06cMH+n3bsfO9cakRBoqidRdJM4B4qAz65ZaLVwlxT/jrXZennmt
 oEnS//eluG8W66LQosDO2TYXbQUhTHiHeKUTiFFg2U6XGVjClXZDHu35V9xJAxvQ+zFYweCaA8a
 zTUuyXnFVBO577Opa6/eYxS0wmKBwO1ircekNwXZ4znya3QOBrpAi1BsXNIkqG4HPti0SLwDzHH
 6hVGwzjeQPfo29Q0SBLuKuo0lq33d3fqjGKRZvK9jolE+tZaTrmMWtyt9I4eAd88795XYFoA6gC
 rXJdWlX1Lnc7LU6SIdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100154
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34623-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lists.infradead.org,gmail.com];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9F6063DA766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, 07 Apr 2026 11:54:26 +0200, Nicolas Escande wrote:
> On each WMI message received from the hardware, we alloc a temporary array
> of WMI_TAG_MAX entries of type void *. This array is then populated with
> pointers of parsed structs depending on the WMI type, and then freed. This
> alloc can fail when memory pressure in the system is high enough.
> 
> Given the fact that it is scheduled in softirq with the system_bh_wq, we
> should not be able to parse more than one WMI message per CPU at any time.
> 
> [...]

Applied, thanks!

[1/1] wifi: ath12k: avoid dynamic alloc when parsing wmi tb
      commit: 9a4f673eb08d2a7713b258d671b4a45f2a6e68b7

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


