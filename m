Return-Path: <linux-wireless+bounces-38464-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VduBCA88RWoU9AoAu9opvQ
	(envelope-from <linux-wireless+bounces-38464-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:10:55 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF6D6EF8D6
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 18:10:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HRY1uaTe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=G4jr9sqB;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38464-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38464-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 847C330FF9AF
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585B54A1380;
	Wed,  1 Jul 2026 16:00:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0684949E3
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 16:00:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921646; cv=none; b=Oc0yAZtMd1zynXOqF1BnfE5O+0J9XZZSTd+GMT0HVrtYy8kN+6LrFVXGIKPSie7YEgqmoMKGi//BauH+5HO7HpBGXwcMECRk+gQ5b6xLHs2r9WpQLmAU5NzWSkACBChKTV2NgiANv/yT2NJVGZgTmg5q6Vjzba7kmHCm5jE+sCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921646; c=relaxed/simple;
	bh=GWTkfYePYPEGTpO3+RiqLPCaGCSmezUWdnppwKHAMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I4KZ/37WPedQw6NMo9jwQzX9w+mJw+Zaf4uJ9qLqb7ZdlSSnhQraXtl0rOhNLxq/PzaozI4OySuWEG3v6qf9+ropTwO/CsCllRGwurjYmba6jIxaVSMfwSgxk9IyXYPOhvNlYMItdcQCngRD7hGD5C95fCiPhCqgAvEiBsm7Xyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HRY1uaTe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=G4jr9sqB; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 661Fo9f91428990
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 16:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=; b=HRY1uaTeGIIRXKEL
	6wsaDKZf2cVplnvu8A7vouedWY/oJZ9OBdObNQEd5NXv59+E12gXEZG2Pue3jodZ
	Bf9nuB74OOOyxq3OY8Jnt8//r1cOb5bzbB87nvHHzfO+zPeP+gIGxBWsXvnSGkOB
	2sC5Leun+VnKFM05qXn0uwb/uc/49eaUxgwfH6B6lFtaXTBwCCWPZQsULNVLy1It
	7+iLF/bWx4bxIcjYIzCL94f3uW4Vsgk9mMqVs2JtjJHf9HuhdLux2WDTPsfCyZ6u
	1cNFycmRWxPCwad87+4Sxcdt48EMG54PciKP0BCWCVCgOYX4Zt3uVLYeRRwTEMPg
	qjISzQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q08n4s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 16:00:39 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e663c29f2so101963285a.0
        for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 09:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782921639; x=1783526439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=G4jr9sqBOCNTTwTPNL/ZWRVlo9MJvsG18rxBhDk29o4qOLQ1N2fX3OvgJPc2nsqaiR
         OGJT/WcP5C4UyxJ9cCbTGnAdkSC3/4pQUTZrAhVELUHaov5j5lHWOJEEZoF8T6H6YnmA
         0a/in2sbFiHySuRJYE2GIRpd8zYys9n+Lu12R7r+bLeprahp40jZbKqsjyXX990Wfi4v
         ABdDVScFwQ8RgQ4oREuxV3Oc+oONIYuljt+sN2yr0ffUDOZBwwrfYwDxc8qwmmMykypV
         yIxdg5FBmbK+s4oLXf/Z3n5mq1WwFSpkgAk9o33K6PAUKnS2qNQVFifImepl1ifQmbz4
         ZA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921639; x=1783526439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SfsW6X2TQx5QMgjWUIDIGuzTP1nyEzhwdW2gsqL49+Q=;
        b=JdvBVbzHbriLzKNJauO80rwvtfAguNAlX+ssOJyHziFXnEZpQ8PVQOHLLU5ZvcW9Yo
         DlARosrzJzxrrMqHuw7jyIUnguapDY5raCCnqwcN2NVAKSUZLWa/yYVhFxc0sZlzMAUr
         k9BYwQ4eZ8TZWWsN3b5KAaaJ22d0tXevk7Y+qmF9KAWPhdCYpAIIt7Go1Ol1Ogve1NOh
         SLEy7zMA2G9y3V4aaeHusT+iO3KxzTp0ZBo0EP244pz4SFfwgzwMGrOpe4dqyH5Quhmr
         qRDd8W2bT4xLdRmuP40VcfSUdjoTHIrtwptK7Bqjy5JIkiMEj3o81eHUiPJfsEpkxlpQ
         KEPw==
X-Forwarded-Encrypted: i=1; AFNElJ+p4tDuFuDb8sOQZ85OzIpkYa4Ue1oSxgMpjkiDLCuWXeua/oLpAo3ztrpBvMKRvo2BcKXQS8hUpqebD20ofg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Ykpyabsp0Bl8sc1I7pN9wwb0ccqkw1WW2r2WBdoRVZ7nBDly
	TjU61u9j8J34Ex41Mq9eZxzRw0LxjoflS59dZRbwTD/lbzrVFUJQNvI7Snux90HafNpex5DXmE9
	/ck2BiEfNrgMNPOPhW1oNNDuqFuvDJ3YEhiKKeph5weObMUwdfYSFaj2/v3YUqHy8dqoyCA==
X-Gm-Gg: AfdE7cl7YYWT5oOa6gsa7MwPP5uNaLXDYwnFNrbRqYE156c6K9Zs2mpkY8JzYh2ofKS
	/SBcnk4vu9OaxkJAaoCU0sy4rrRPSmrS3W0rFnBUXRgnWwfFCNetuWqJ0AAYG7QxbXvEjDP/PDT
	pkVPrHzdMkDWrxRi0GG8lHZSHW+2riEVsS5ziqUFcUsosFnvDdB4docXKU1rt6i6nx1DLkoiNI0
	3eEplJzSBjp/oCNDYnb32xUS2Hp+o1vgLQGbAdbh683DIPjEaT5A/Ku+BsWdRne+U8Bz7Cw0ace
	BPZJTgKyxZMoooXZh0wBz+ccPQf/WcIiukAeZQkdvk5k0fiE7AT7dP1dvFNclm44vl0EaioxvEe
	e893kQxzPxSa8zPcdh81/0LOyurQP8R9rfhGtfEC/XSVS0p8jcBiKVm+Yc7lzrL9KNr3OexSP8d
	zwgLSzkunEEmkJ+idLOO/6DgDtaAQOBfH/a4kl0DLdp44O0JBDEQGR9dwynvbCpBE=
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914773685a.20.1782921638192;
        Wed, 01 Jul 2026 09:00:38 -0700 (PDT)
X-Received: by 2002:a05:620a:4096:b0:915:6ce1:3576 with SMTP id af79cd13be357-92e697c6671mr914758385a.20.1782921637397;
        Wed, 01 Jul 2026 09:00:37 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:809d:5d56:19d9:ff8b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288d19e03sm296613066b.4.2026.07.01.09.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 09:00:36 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 18:00:26 +0200
Subject: [PATCH v7 2/9] dt-bindings: net: wireless: qcom,ath10k: Document
 NVMEM cells
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-block-as-nvmem-v7-2-3fe8205ef0a8@oss.qualcomm.com>
References: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
In-Reply-To: <20260701-block-as-nvmem-v7-0-3fe8205ef0a8@oss.qualcomm.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Srinivas Kandagatla <srini@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Saravana Kannan <saravanak@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a4539a7 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=Xy7nGJaRzBGhkMsTZAMA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: XU887GVdt5mnLlqtTCjY2bfM8b9Xuadl
X-Proofpoint-GUID: XU887GVdt5mnLlqtTCjY2bfM8b9Xuadl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX+DS0tQxDcR+4
 zuMi99EtD/bPIKdZtnMgJ50JCx/AXY/GQdLLnISAhg+r5bv/H5Vr0ABJ3YtZiHdkdRichLRhArf
 RVvYlV3yYbjwkd/VHw5dEusuSixtm6bwMHK3bk/xYZ5i64g0fbKfguKYFTYTcbv5CxAPxZQwsBj
 zFB34XEK/io+po5fR8j19qkjwWq6NufEc7mddxSILUESZIFwmJvJPM+ItBwl/HRRZA5UEzIACYs
 IHV0tCXlwVRXXooZ2RY12Kru8BJ6xNT+j3Vz+do5WBPkVj8zVC4EZ1AsDnTgxljORA75cB8B4CI
 AHMmucPlLahKRheSReKwEydPugyN5rM/TemkMIuYrdZ+KbUYIOGuMdwCoEn78fyUedK83FHoTFH
 DRcV7B5CcAXhZFWnnRbVJGHtY/0dOuqR0YiO+LGIHAwu5eJIOXCXAro3nNVsSXqrFelJe1ft2R9
 z9z1Tsr89uFUc7k9Zug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDE2OSBTYWx0ZWRfX53vq0TtEhHN8
 p/KoQkv536F2+3jN7Ws8efQ73W1OwwYL5D2WMs3PQLlwa5/+2S1gLFiiiszk8qyMDRlF2N9iUJG
 MLHQdf0qD2j6TSfP2UPBuCg1EN51ZO8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010169
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38464-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[38];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:ansuelsmth@gmail.com,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzysztof.kozlowski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@
 kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BCF6D6EF8D6

Document the NVMEM cells supported by the ath10k driver, the
mac-address, pre-calibration data, and calibration data.

Since such data may also originate from chipset OTP or be supplied
via other device tree structures. All of these cells are optional
and can be provided independently, in any combination.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath10k.yaml    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
index c21d66c7cd558ab792524be9afec8b79272d1c87..878c5d833a9cb073520c256c1b72d0f1489e7f4a 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath10k.yaml
@@ -92,6 +92,22 @@ properties:
 
   ieee80211-freq-limit: true
 
+  nvmem-cells:
+    minItems: 1
+    maxItems: 3
+    description:
+      References to nvmem cells for MAC address and/or calibration data.
+      Supported cell names are mac-address, calibration, and pre-calibration.
+
+  nvmem-cell-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum:
+        - mac-address
+        - calibration
+        - pre-calibration
+
   qcom,calibration-data:
     $ref: /schemas/types.yaml#/definitions/uint8-array
     description:

-- 
2.34.1


