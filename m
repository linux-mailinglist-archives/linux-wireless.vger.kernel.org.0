Return-Path: <linux-wireless+bounces-37246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0IyFNiRYHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:00:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FA61CF29
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D34A30207FB
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF8C399D02;
	Mon,  1 Jun 2026 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z9ryOJh4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PaIFQwc6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2301439A04C
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307240; cv=none; b=KI1FEcVpzDtPhyNS8+DW65q+BXxwMTK+70XtCVhzX1UH8ThCforQZH0EMCafl8o01+GWCVjhNpb1YJIK0rFPgB4eB9jiJ2MOQ+37wmp6tw7gsdHAgB67W+oHqIEX41zijkQuOnBUJLW5rU27r+0aYXWOn4jGXcxowsoQjgECfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307240; c=relaxed/simple;
	bh=docfPpUXnI1XHz/OPdL2Yqjd7jogAI8PSdedpaSUSzg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cq8mSn43OxnTTW4KlzJVtW3ffARFcbfmd0MAxkhE/G2qOn30oNvWaCM5jqej3nuh0M5RWGeXR3g34+rBBS8DUsy/HYyzdtzdPChhGYoPb3Gy3o1NTtvKEsYyziI4XLm4O1XXfpzlJx5E2Qh9yYqFyggQ1GIa2V3S7hzzhQt0qvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Z9ryOJh4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PaIFQwc6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6517VmQZ3029821
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=; b=Z9ryOJh4vNQVtmxk
	JR2e68TNAyMQEm5TZPX7E7YplmiBGGLi6PwgQ/PDDpjdSpLRZAM/VvS/KNAMwJWq
	/eis4SPu9oITqsZjztQfNgp2TaJ20ODaKiUAyy8uwbXfAbRJU5LARuQOvGkGACnk
	S0yPiK4M9rHcOTWZerssJMFEFUoCeRp+dyihmrRZ129epv7LoaA9vUs9ynnQ5Ixn
	N8K+ZkrO/xVFKiHXkVBSv9FmUTs+2PwRp98qRhfjyjRgRVtAnzEH4QKgGSorkjRS
	L0TtUqkh3X/FV4Pd2xWiWdFHghHcE/Ttpl8tAClYl49R+4jDUxz33SKNSrxLS/eT
	O1tEfA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efqyuy004-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:47:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-516d13328dcso200665911cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307225; x=1780912025; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=;
        b=PaIFQwc65lakYkb3a2ZeDTi5sWSIC4QQangAXzlo18b+GOtiVNaA8V90/FhaLWUJl8
         y8bkGV/kgxRJnIhZXiTHkzzPKzuVvq0wWe2VzfRlz0Fk0fUSdStpYKzWqORmN883sTQk
         0wUkTihNuQ9Rt3KiNKdMbMBf30p1AN2dfPg29v1cywVf6rT+qQFtJzsV+GR+FpXo78bQ
         hCTG/Tp/WKITW2+3FFfciRWI6C6zW3kgf86UBOu35DGWpAao82FJQnpwH+s1BcSs6hgC
         NXN2/UnZXm6pzQn9rcqHdjm3CTehs38ttBDJzaYOBhO6CUahkA38TFF1tNENPa0/XNeW
         XidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307225; x=1780912025;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=60CRMLwoH22MNuhk43vWwIeN3bSXwFAvh1cnlrI6z9M=;
        b=KSQA+8nReJkAsweuUfnCQRxQvAmLrPGYjxA4qRxYG/rKmZrxwbZLXg9DcBIbr7sloW
         CsWJJrphDHTA48gOC8EMckJ9YQslYmIXcxc8nGZ9rG0GUFUxMt7ujW9nhfwMZaX2kG8c
         E/cLRQi196GY7aBJ9l9b5VYCcoD/JXJuIH5VKWkCfgHn8T/8qCZ97Yl15kn706icmvQW
         6XTvIuNZ9O3mw5rvOpzAgZyGRORN8swdmbeY7ARK0fiGu/pubENl/sIdTBsO1Ooc7f5X
         j3VkhbaqVS5Dj5ZFPTWj+/jkLTOb1xNpM+As6irsjOJSHj1WJQz1pJ1tBosMq+K4UuRv
         MLYA==
X-Forwarded-Encrypted: i=1; AFNElJ+WphXMKGLB/zi+be1TDAOvNrbtCL2L7tFri1mDK8ZWpBtwfmaLVjSoD+ev4hT/svRhF+2qDLcyf5ehTxW4DA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkiNIPu7HkLWvtIxqaAHGCII8bthdVVEJ8hl++ZHPv/OusHGCC
	IHKuXrU7nXQYQbLabKYsqO9ROOQctLq+b2Jc2614PBDsF/U1ff9k43FPKHuplyRuxTn1lCiIh6P
	HL2ghZtgeAuHr1fwVRTSefil2KV8axkL/LTQJjQ4vtuANhH95I1pzUv9Zn4A/wObuCYGCbA==
X-Gm-Gg: Acq92OEpO/y0VLMjjRaHiTGmDZEEaqrW0Q+qa+1YnRyumOvgpAvORFexgpPrqubGeJ3
	q1WxOknJcQvuygI6M8hVotujLqvnCwhUffzgoMvanVkpcFnGTww/BEZigesSFIoGunFPvghUsJW
	htor6IRoT7LqRweoNYWL+1XdLvZDVxE4ob81O+ur3bbA3wZY3TGhrO8UzHUBpjklympSyI53ill
	v0y9mr0CpDik+CgQriWhnzEINXHBVNaydx7SdhmmVUm64z9225YfLDTmK2NZ7lA2A1jwEH3MNq5
	LEA+xkW2OYPa1/y2zUeARCm7YVBFmJ2fRh82GkZb1xNWo7edQjUE9MSWXC80ii7L9bYGdPaD2Fc
	PY9O13lOvbxYsFyAGVAmQpM6sxKi99Z/Y1vqUTOVNzTvERNtJXyr/Z2O+yfQgwG09MVf3zsHtTl
	9QkHYx+4GrmP0QSHzkUwb5XD9klsbRUbr75fszaZKaRui60Q==
X-Received: by 2002:a05:622a:356:b0:509:44c3:5ffa with SMTP id d75a77b69052e-5173a99136bmr153697901cf.52.1780307225013;
        Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
X-Received: by 2002:a05:622a:356:b0:509:44c3:5ffa with SMTP id d75a77b69052e-5173a99136bmr153697521cf.52.1780307224560;
        Mon, 01 Jun 2026 02:47:04 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:03 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:54 +0300
Subject: [PATCH 6/7] arm64: dts: qcom: sm8350: modernize PCIe entries
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-6-242917d88031@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2793;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=docfPpUXnI1XHz/OPdL2Yqjd7jogAI8PSdedpaSUSzg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULFMkz7B2KUaWzp0dMD3c4J4pOVHVAE9ivW
 I1u0vWVJ3yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1YjxCACZ15J4fbUYzTAR/V7VUO95cRXGAnVEZVcCy9aRNacj+oQUbM8ZeOdKuCyhJJWAlezStTf
 Z40uMUE31aH7GftcJ8ijLYgXo6cpShIy05Ukm2kP5bvkratPZlxmtFGeLP43Cly2zxsyomVS2Nt
 hsYRkrNvAPlOYmc6PBoZw+kumrbJ6D6kzmrTEkm0PtFWENsETv6++fKoWLE1bmNlrywi/VQYzX2
 OnV3ImkPvtNEo3RjpvwaKkwCWfepEYablX98ZLwpNK924P9pAs0lUbrsnnV8FmViAKO6VLIu44g
 MCP4Q8gomOSy+Bsgcu1i5McYOgaT7JFoBDMf+XZ5Zc1OI0eG
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX/XRIHXNZCPPq
 MY59i2d3YRuyFo+8lxIckj7OGCLCu2t5m6eOAJc+Pc6VTIC5MIoA/c21BWhpKd4ea7nJ5rd9ch5
 co7DuSJMEFrG5EFtddA1Sx5KjDttr244dkm7CkU5xQLjYAKqBMUTn1hUAkxbK51QWdkQxPr2iuF
 DD8Y1tC9MZVcw+I8MBK+CIItiQqvapCfFgKrbA8mOkHNUfICRRH0m5syk8E/J8ncHdwVnV1FfCW
 7nXx/EAK9a+7VAufP6go6/CyMTOhHwZXIP16sZDx7+qNdhbjJACQpBCO7OvxsWT/iB5htZ3Z7h4
 SKY0xPp5FwAXiOUBDdA6EcszI+SAuIkFssyh6QRc3RSiHYkGL7qDNBufFGU3cDsV4zY/2H1i5xi
 35/iX7PoirMlRcwYf8f6y//dD17fkL/x6lkZNVmtvd+kmkSrf/tEpewkZv8GhHLz7hxjv6MCh20
 v2C4IMKZ70qkAC34CTA==
X-Proofpoint-ORIG-GUID: fMF5MFDC6IbGqbG8e80twNUcqc8AcDdE
X-Proofpoint-GUID: fMF5MFDC6IbGqbG8e80twNUcqc8AcDdE
X-Authority-Analysis: v=2.4 cv=B5uJFutM c=1 sm=1 tr=0 ts=6a1d5519 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=a-LFHBoeUMMLBGfzAX8A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37246-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 3D4FA61CF29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The recent suggestion is to have PERST# / WAKE pins and PHYs in the PCIe
port rather than RC device. The kernel recently started warning about
the older style of DT. Modernize DT for SM8350 platform by moving the
entries under the root port device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 18 +++++++++++-------
 arch/arm64/boot/dts/qcom/sm8350.dtsi    | 12 ++++--------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 5f975d009465..4973a3eb11b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -493,12 +493,14 @@ &pcie0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pcie0_default_state>;
 
-	perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
-
 	status = "okay";
 };
 
+&pcie0_port0 {
+	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l5b_0p88>;
 	vdda-pll-supply = <&vreg_l6b_1p2>;
@@ -507,15 +509,17 @@ &pcie0_phy {
 };
 
 &pcie1 {
-	perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
-	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
-
-	pinctrl-names = "default";
 	pinctrl-0 = <&pcie1_default_state>;
+	pinctrl-names = "default";
 
 	status = "okay";
 };
 
+&pcie1_port0 {
+	reset-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;
+};
+
 &pcie1_phy {
 	status = "okay";
 	vdda-phy-supply = <&vreg_l5b_0p88>;
diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index eb2a795d8edb..136daa444865 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -1583,12 +1583,9 @@ pcie0: pcie@1c00000 {
 
 			power-domains = <&gcc PCIE_0_GDSC>;
 
-			phys = <&pcie0_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie0_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1596,6 +1593,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie0_phy>;
 			};
 		};
 
@@ -1692,12 +1690,9 @@ pcie1: pcie@1c08000 {
 
 			power-domains = <&gcc PCIE_1_GDSC>;
 
-			phys = <&pcie1_phy>;
-			phy-names = "pciephy";
-
 			status = "disabled";
 
-			pcie@0 {
+			pcie1_port0: pcie@0 {
 				device_type = "pci";
 				reg = <0x0 0x0 0x0 0x0 0x0>;
 				bus-range = <0x01 0xff>;
@@ -1705,6 +1700,7 @@ pcie@0 {
 				#address-cells = <3>;
 				#size-cells = <2>;
 				ranges;
+				phys = <&pcie1_phy>;
 			};
 		};
 

-- 
2.47.3


