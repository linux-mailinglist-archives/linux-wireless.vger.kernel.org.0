Return-Path: <linux-wireless+bounces-34454-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCtrGvXP1GksxwcAu9opvQ
	(envelope-from <linux-wireless+bounces-34454-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:35:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 029DF3AC1E8
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 11:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CBEE30008A1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 09:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82BA3A4537;
	Tue,  7 Apr 2026 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RzepB7am";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lj1+CMts"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971E239C010
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554543; cv=none; b=EkcPqi7nxOZyNb4f1JNdk4cctRQkB+GPs8fNqYIsN2Ymirg0+0lLwjsYv3E2q1HorvZz7OnURYSy3TKFzeymoI0q1aZ5wzd/hxpT+42qdjrhRg5b0Y187RJoxu4qEmSI7OLrsu0nraejj+gyJupuI1wR5vuhe8Y7ze4vbekn5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554543; c=relaxed/simple;
	bh=MwPyQOiSQ6RdUeIETXwp4mpKmHfQUMEjHUb4gqtjrKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2Hptl0CAuoTGlODcZM8HcXZ/aeyJRatupgEiIVnCHbA7EFCFj8Wpc+6l2DgzMZB+aGYMLyvP7r5SrORqav6VmBb3Uvigu3FCLezzA0uUli86N3OSf0ckKDuQISTfYXmbfkKO2IM0hgBTZJIOAe2vVKp+g87H9+2spwJgaPi8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RzepB7am; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lj1+CMts; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6376ZGAr2009903
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 09:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqtu1eJUvsKIn439NOJePeGFRD35ZTFzSdDBFTmlzkQ=; b=RzepB7amkneQ4mjW
	n/kBSwAwbeYO7us94i62DaMBfxEnQxK5hvTc84zycMW29DKt0PJoK6I7EEwm1e7o
	62G1hmwSs2O7XtdoKM5mmSABd/7kEGkqiL3XkCpir4eVow2JwLeCiyW38YRdc2aw
	2gLiDBSNnrM1UGS3PgM1CadkOWVY5OVvV6tb9CUSb8sUFYgeRnmRTSH58PhmylHe
	IXo+Zzu/acsprtXbOlCCRlCqc67BPeUe5ytuFOOAg8ahlJcUc3X+lZfm5cPk14SP
	EMLdi3dBTQb0dcZ02kdufIyJ72RQD92spN4WqFYvPOjUdYW+iMqqBXjNVWKqUKNL
	Wlq6Pw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmrrt2wy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 09:35:41 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8aa34663273so7160416d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 02:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775554541; x=1776159341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqtu1eJUvsKIn439NOJePeGFRD35ZTFzSdDBFTmlzkQ=;
        b=Lj1+CMtsPfVEjDCfYdBeA9uEyulZqZziVDZUuF1Ks2Eeq9SnFTuaC3DYy/zVBDkWnJ
         GxQdQzFI5Zy0zVQOMv5ZBi0q+fXrE9ZdHr7rJlCyIxhUL1lpKH1Co3JKdu/odqECQI9d
         WBmJeHO8zhb7fzcSIqvJov0LpkD0/3qktb2gFMFl3WOcM/1sRFgoraj3BKOESxnO4SHn
         WZw2KZF/sn8DxtluTa/DyhDR3UR7jwaIRu1zQUSWhbRd01bLGypXBaBaHT8LN9/nCa4z
         5171DMW9l/h9oL2S3YYRuPI/rkzmKYgFGJAlBCk4vbOsm7UxQiaKwGThpFhmiwhoroTp
         WsyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775554541; x=1776159341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aqtu1eJUvsKIn439NOJePeGFRD35ZTFzSdDBFTmlzkQ=;
        b=B6Tj4qmSus58qCwZRgp9hRE3zW0lgoKvb3Ai7u7JeKOetlO5jOP01T2DnzFGgksswa
         X49wfRuQ+xCnpkmJeg+iyMnZsDlxg982sPKRtRHWAp8TGQwnsFfZ3v1zjqhsb2IeBVkG
         PjYHQIGBpOp3pGNiR4ti84wLSdWruJXAzCsVxQ70rx/RtmK331n6kBv46TRQthI0Ch+n
         eQV+tXEZ7onsiWRpW8LMcZAiYvaaAWPT5mziVmchEFu8fSfdJMfOeVKVJues8pC9WU/6
         hygNN5WdG4bqiVYGlGQxRsSWlTayCs0umv5mrQRZySLWHz6EHF0+yE+XGwjVyV6FzGOg
         p25w==
X-Forwarded-Encrypted: i=1; AJvYcCWKSxlLUWb40eiub58AOZ5vjih9Ufoeh42rg6+BS6gCCjK1EyVYp8F73D7JuozqnRvFNaBVlclUNHGEuof0ww==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96AxamcPOkH57r4C3e0NJDCqR1Sv3Zyvhy2shZfIgcg1SVSBB
	hckn/md9wI1NPhUSY3qr0Hh1br7kEfakUTXlqwPQCwXreD9bsAwgtUR2SyTaE/wo7XHs4Ki9NpC
	szVckPKIM6C43qJHXdbn5pKkq4Y/zzga8xhQVxBzS9qebaWNXUoWULrXhFB14u9Act0JXSw==
X-Gm-Gg: AeBDievaFzICEkw+UHMRlp08KuR32QBh+7F41mseTqqqc3MRvG4acKOJRxZd/3uAtwS
	y/mn4DK8bjZxvuhehTLqNvtO5TWLXpt8d2l1mMgalgWJoROgiviJGRS6tsHrXg233TAZfHPR/nY
	C0gVAvdxJWaRC42ouIizZtqlgZxb8zlj+UCCAcYyxjvD6ZX8s1hQWX0INo/JFBbnwZOEKSeM1Ly
	qs/DePwVNfFr/XlnhBKZ/5J+G/hXt+q+szfVAER+nwJint+EZLfIXPBHVk17HL1yACRD3wXd/eL
	KevBUZW8eiIfQMFjivjYJxpYJ9NQPMMjuOlxMPmssby2v0ZIAkKhPwXhKxsfdV/4qQ8D6sQ74hc
	Yfm988jVz0RSdFJbP1MIqDlmyMS/PFmdVUFMAxrRhHy4xIyYnLlaZkowdvUKlvvcILJzJ29TRwj
	0ZAS8=
X-Received: by 2002:ac8:5f91:0:b0:509:3601:cbf1 with SMTP id d75a77b69052e-50d62d1cac7mr180451821cf.7.1775554541027;
        Tue, 07 Apr 2026 02:35:41 -0700 (PDT)
X-Received: by 2002:ac8:5f91:0:b0:509:3601:cbf1 with SMTP id d75a77b69052e-50d62d1cac7mr180451421cf.7.1775554540574;
        Tue, 07 Apr 2026 02:35:40 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66e033a780esm4156402a12.19.2026.04.07.02.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2026 02:35:38 -0700 (PDT)
Message-ID: <14c61b77-d790-4e75-be79-caf8b7ee8e4f@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 11:35:35 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: milos: Add WCN6755 WiFi node
To: Luca Weiss <luca.weiss@fairphone.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Alexander Koskovich <AKoskovich@pm.me>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann
 <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260403-milos-fp6-bt-wifi-v2-5-393322b27c5f@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OCBTYWx0ZWRfX3aZ0fDpJIk54
 wenCR8sx51YlfkYiDYtN0uBaeeYD9qBOr1j/yW8BvRFLDcvL75PhqxQbf99l5AnbMm3oTznCWyB
 j/Bd/w5CLs2giocPh/NgzmF9Twb1KV+9bIYkT/S0imVYYI0JGKHd+g0SJY7nDFHpWy3FFjjj1Ru
 UMDx/F6Wp9gn/VI98AwltQD1Wsvlb2FDIf4aH/aejl2DrEqIleJFP5sPIEPMZwtrEpP+oRVd3dX
 PYaD+YQyGNItDKOzXUndgotkfXqEB1nWcYvWU5MiIgPv7+IfLdjYcdyU3I4QYyy4QbBzZAg2zAc
 EczIkP0vPtbic+FcWRY20DzW65HOoPq5V2bb8sjSd1PEXmtzJL3JjB/3RDQXjGbS2jXFXLpk3x1
 vHl50DEZNh6fKqRutHCs3fHmM/U4qEFvINFQhc84RRArYYCn3TQQ2wFGIsfJMZIzln+xmpzcIrx
 YqgR6hpcKWxfWOIBSDg==
X-Proofpoint-GUID: TjKTgKWOjbaqxkdl9rVaqBnChooJ087h
X-Proofpoint-ORIG-GUID: TjKTgKWOjbaqxkdl9rVaqBnChooJ087h
X-Authority-Analysis: v=2.4 cv=LquiDHdc c=1 sm=1 tr=0 ts=69d4cfed cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=6H0WHjuAAAAA:8 a=EUspDBNiAAAA:8 a=rDrCEZzy5hQS5nTwK98A:9 a=QEXdDO2ut3YA:10
 a=AYr37p2UDEkA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=Soq9LBFxuPC4vsCAQt-j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604070088
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34454-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[fairphone.com,kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[konrad.dybcio@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 029DF3AC1E8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/3/26 3:52 PM, Luca Weiss wrote:
> Add a node for the WCN6755 WiFi found with the Milos SoC.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

