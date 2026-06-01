Return-Path: <linux-wireless+bounces-37245-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OM2GKPtXHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37245-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:59:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470A61CEFB
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9FBD2309C56D
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF35399897;
	Mon,  1 Jun 2026 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QkqXE7X/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xa9PDqir"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7130533A708
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307237; cv=none; b=SAmL7lXat16C2gUZx5aePgHTaVv+DI9qVfVRmb8FDMP1HhoGYd9eIkgjJlPFRR/w4ZKk3ozMj33cNQ/wS7zU4ZVvJ8ghqAxW1cZgvqJeZnMqdhNfxZ4p2rtv+wVh+hvB/ua1hUdZWcDij+hpZValBGP5mDrtXGLp4GktJ1MqDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307237; c=relaxed/simple;
	bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TzUTdKZJXeeVTxA0n8P5oCyo2CaC2d66iLE5xea4vjlSb/sO5Jsidv5sOanjKEJJFvj9UHQBLj/i2KrT10eMEiaYQeEyictRb6R6N7JwbJtAW7a7j8aM3Mgrq0VPpmgCRMY3YANMIW30hNWJy5xrdI0/YFchlUtioCzgoh5jVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QkqXE7X/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xa9PDqir; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518dPXo3563543
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:47:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=; b=QkqXE7X/qkvx0ziN
	ZALrVq4dwcXffYJ+sMpIvKYY9Nv7bZqBzuA9+RdGdBlaM/yKprK+rmLiAUBPAV0I
	Bz8vxf8EYMmTT/Vz4RCtMo8ZNWmalfy52aN07DqUw3FDgjy3pqLEEUmcPzemeOqk
	tNP6viGbB6yro6tlx02KMgzCkgcohEVIzC8jkd/TKN/wQnrBhWweMX9OzLpZxMi7
	EsQR16u4DxHCyDsObMgi8+DULFdaY797NileZiifPDByLSkeitOLgTcgq/3Kp7EN
	YQG6ivI/AlDKzoVTOFma0oZGZhAplOJ6LgDlu+B2akIROsTODgB8zjSkMGCmWd6R
	emW/4Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6rxr9wp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:47:04 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8cce1cc8cb2so61780896d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307223; x=1780912023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=Xa9PDqirXFpL0UVJASlvEmEmiZw/T6O6Bg6tSIgFonEaq/acMfw/bAFkEeSzR85Hx7
         VrpVlHeh7tyqU92BDn/ziTXz0tAP2ghXLrxw6UpMYNIRYveLmAxSi1gLqc2dVFHvrMP/
         wLEFYHiQY217i8esn+YcYLk10w90wEpV14HW+GodhwRtS0m2Z1UgbIMU0VuynS0/hb4V
         Oo3075xBfxY4FeqnT7zvkXISs//7iudAelbTqonDRf1UkGkTMsAYxFRIxMMFpqTsmdfo
         y8zIWLP+9bwBe1oKCslVmDu17XBg7xBPcF8OzcdGC7GJpK3gBGWjrqeZ4mIPw+kuF7aw
         UB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307223; x=1780912023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iAynyGPj/m6HlAQLnycghU+jkG7FRJqT7laanFnpBMc=;
        b=BHRaBuc+N2fKbpMkAvW52+8wfITrhVJXxpFQFMsUziV5qw/QDsz4a4XHluc9Bvwi/i
         ybebbQJs/6v28Zk67wQUlWSPYN0rQrg7hlRWVOVDYGBAdNbcW3+2RFXfFk5dgplZC65a
         Emp/yO2S+xIvJ8BN5vslfjQY/ajjNrs7XfcRRlNGyMmKFpeK6LYztXIGKQ/0ZSoJlb1C
         L1B7A8ec1WySzD8+3BDtVa4L3N+xD9xpb0iqbDy6bMzfrqQWSXaeMIu9jKaS0YVHZiJI
         NFtGfDIdHxkas+DwLDb87mRcitTo1+t/dVaPy0HJiQpgsYjgd9qKyPY2oL6wQwujcaq6
         AWAg==
X-Forwarded-Encrypted: i=1; AFNElJ/i0qFuT07GcJd+pwyOE8cIT/Rma4kRlPvhgKhnJQ4T+JlLNfKaadZ1n+maIAy7j7wCiCoYsmwETzKc7RCgfA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxujtiAlsZUu12ZaenpqZarHsZSNI4Up1JYoP2OEjTNlSvQsMBD
	vYkFwn/XqWbmik+yeWQI1dRYoJVTMp3puCQWl002l2k3oJ0FJBSR1jPZtvdJSC1EH5mn5hGI24Q
	iyxMApnHEjWDk9mkH1TuUvOAG9bffg1opEOpLy74zoTRO8ctEmBHT+xHYgbgMvft2DUo6/A==
X-Gm-Gg: Acq92OESaHg3us45BcNECLL0MAG+pIYV7Ny53dXZD/j8vrmEBwszPbbr/vV45YPmTnt
	9HXsVJziVcTIif/l1PIBGenOEa7eWyfSo6kmBnBfpGxRolJva29Zh+mvrIevBO8DgBM4Y6ByVR7
	1ee9EqlZLLUzHxlwPdu+wtDLqll7FcAdFfgwx6Z7jmtR4yHcmWg7of4KRXzjVC1bL99CzwvpN+O
	37+mrbWQ38L4afwQezEIWew/ndR5NjYhYAGI94sKld7gDl+e3a+OdiK65SficLhKRECGtM3eD4/
	FImDnd35kpVWuq2/tEzQxYeI2S+FpH6yIa+ZOOULTpRW/iWlfTPqsPSVTEkiXgXYTEep82wkMRJ
	MuDE1/3xODdtBqNV9qGm4vfikYaP3XmGBkY5tIHmbeQYm646cxzg5+g5e2iGWVxPfioXqiVKNYm
	D1PhpJosQflB/JihmzW86gpmSR9q9eFXEkWJ6U6IC5METC7A==
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830521cf.12.1780307223353;
        Mon, 01 Jun 2026 02:47:03 -0700 (PDT)
X-Received: by 2002:a05:622a:2289:b0:516:e833:64f2 with SMTP id d75a77b69052e-5173a61b308mr155830221cf.12.1780307222934;
        Mon, 01 Jun 2026 02:47:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:01 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:53 +0300
Subject: [PATCH 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-5-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=873;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QjvgCxT4cjyfExqVSl23BqemGzEEeOq4tGjsEdwhVAA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULL9vA98gnb1vk5P6BUKdenYE36uwUMwczc
 eklc7UGkxeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1TcCB/9Ju6oFg8fhJQdx/b+0NIq/nalsJ7rHRSaj0cfCy6j/WB4c7RAbf/wVgPTuKG9aqavA9he
 9Nbn6yvgwTHTPX1HC1rY46piFDOkAlpOnmMj6vV+vSkCbzEDFaQpDXnUwouZ7MadIGG0ST/sXAW
 /sMDmu1f2KiaeB5VoyLAhuJZ/iNtUmEQPCDwzQskxbLE2UB/crRkEUVEa0sml95PLW2IULVYOOU
 bbrFoaVy7Y5JAFPN7FWkVZ2m5oWPVrZqPe/nMM4P85MGVfoIuq5RbXZdXLYGf+o1iJBWZVtFnaD
 ioQ09vSKsf7vxhefn0Ual5WTrmsIHgB0S5G7Lw0P/Gfdrtp3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: xUVwXR5uL6Cop4cPnuWUF-eC6UW87nyO
X-Authority-Analysis: v=2.4 cv=dsfrzVg4 c=1 sm=1 tr=0 ts=6a1d5518 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=GNmHCbt0ONPBLg8daWUA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX2m+397m5tjNz
 EDpu4XtxBkS72o4vGNYWCZdYork3oagPG1LgGc4iiUYaaiOiZeCZu97dQHtIOe83YBoFKhPMU56
 /WxiYOWf38nAmwT3NALjhZGNFMIe2mAfma2agQuVMKL2vNx5zOhpuLxgDBqzvdN5bMV00+nDMMb
 AZObwNTyS2/CidWAph5KPsndZ6trJwC6vmv1TTTWoyAuJJFI0vnGQE6ecX4lHx6jpArUIs9OTQ/
 YF5HwC7wlIY9KlVveFEFBgCPIiEZunIohhu6xHD96TQ+XkVRyt0vG5u+DzpHp3Yx0i6tOIHhonj
 E7bNsvAadrfvZgI+lDTBHMw4pITVUuiHZVUFV4tbJy8E7OoVm9kbNQIIgg7g0MaNjeK7y6pH64G
 6mSStXMnVdSyId7ebgOyjpjYAfp+mO1TjeaDtPIEFWQQVXlUiAx4NNX9VLQW/NpGXGHN9gLavHk
 skOPnwveoDDcj4YulDg==
X-Proofpoint-ORIG-GUID: xUVwXR5uL6Cop4cPnuWUF-eC6UW87nyO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37245-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0470A61CEFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
Bluetooth or other similar applications). Add all 4 pins to the default
pinctrl entry for the UART.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c830953156ec..eb2a795d8edb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3309,7 +3309,7 @@ qup_uart6_default: qup-uart6-default-state {
 			};
 
 			qup_uart18_default: qup-uart18-default-state {
-				pins = "gpio68", "gpio69";
+				pins = "gpio68", "gpio69", "gpio70", "gpio71";
 				function = "qup18";
 				drive-strength = <2>;
 				bias-disable;

-- 
2.47.3


