Return-Path: <linux-wireless+bounces-30185-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C783CEADE6
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 00:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17C2B3010FD3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Dec 2025 23:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833A12D9EC8;
	Tue, 30 Dec 2025 23:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IAq3OLI8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/AW4XqL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A0D1DF736
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767137771; cv=none; b=UP3qv5axqtqO61By7mGUzLyrkAHcRzfAQ+25j/OE9OeLT7raX1FciR+ZyxwOq9w9OiG4xUwbGNCOeWjqFg5w0NCrwxvMD0niZb6aeHyxjqQO3O1GOF61ortkkDqdKKJ6mOG+UfeBXDFWz7l5iv+l2N9ugNpsF11JvrH3KD2/+Rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767137771; c=relaxed/simple;
	bh=bXiffYe+pGwR6NdvYFKSdqs2/i01fTSO8sfcFDANfYI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mDoph2kpo2/fnb/rJ8czVke0YmCjJH4fM4qIxFkkwXOf+qlg9w6lY+SFIlP83CMvAqAd/KGV9Fyew6Edxm17VKTAR4shZCYONmioM6yeOxyq1xdTmPBFfyQONg+Ldfaz4rmpxDw/Rbuc7unohznfXfEJoCYuQGiKpPOKSv0nUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IAq3OLI8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V/AW4XqL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BUFErns900113
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iHIv9QUmmytm0fzr7fSOVg
	rYUmUk9Taj3QlV+Tv7v8Q=; b=IAq3OLI8tekB7DP40aAgXOSjohTykJApdWvsHh
	e88tZb15sVvCKc3AxCjYAPVG1l+vJwRXuccUzFBCBP1BYYDSTiG2r7WAmz70Gbk7
	N21QrpFGF1sU3eUpeFYep5QsJgu+afeVcwUK3pgxqqquTSTD2qdFG4MqKPiVT4+0
	OMlZzJwQnRvUUxZ92s2GZPao5CQFyfvjN3HVNeOekpn9B6I/eXa1tW50iKuWpgDY
	YQ5kOR0mxBxWhKFeaY6cW5r4ioCh0JOvYtyYv3pER6gzxtlb+kttSuuu+Kji+WWX
	dt3PM7b12P45+rmXKBVkyr5mx3cA+M/ts4e4p5q6vQNyao0g==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bc8ky26wh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 23:36:08 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-88a32bf024cso104112536d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 30 Dec 2025 15:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767137768; x=1767742568; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iHIv9QUmmytm0fzr7fSOVgrYUmUk9Taj3QlV+Tv7v8Q=;
        b=V/AW4XqLUVRiFKk9D+m4HvNoBOaCvl+XAK27bMnmRAyTWbDUEtR+klBGYxUqbrHw1J
         t4LEdS5QC7zRdA0aQAYaiUujAcPjuE0byUkIh+EUYS9M5zgwsKEJ5Y0o+f82RPTyUGIA
         fsrvWffKCKMOnBNW1JBnnl065owpVtt84ILrgwKHCBpJqdt7JYtpG8zsJrjedtz21RX+
         tqctS2jhJHHxKSKQOOxE+sGVh2kivQ06oYCSsHfUIEYNmai+zcTppxkjI0woeiSOTsY3
         Nj8tJKpe+XFuRWleOyBdQt+5OGVB8sqLC7WUS4zZV9/1JLzPJEsz6eRhmv+Qo0jQFAbA
         RcWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767137768; x=1767742568;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iHIv9QUmmytm0fzr7fSOVgrYUmUk9Taj3QlV+Tv7v8Q=;
        b=fYDIeef07WGgFjx1twHeM2MzrNQyUJiGYSJAaiR1UMWGuOULFCKCFXkUdTbj4huS7O
         AXaKMCwx7hHm1xsJH53eaIeTbJiFRIVd/wRfKy2rh3EkG9cTchBr/8H6zNcVQjaSLfQo
         7amsPy32erj6LnWaqB5gLKjGoLNeanuXxGYDZMmMhv5j+lKIjbY7841xUQjte3qJ+b1R
         1cPdjndKkJMCgA7u82o7V3JAL5zQpQ+aW81C8m8H/6wU6xiQD35LarWXsSdq5oNJm1KU
         ZkRfqS/4yWFICgfGMOqSpLYLlvACXQ71imXyxgjWRcRtn2LDxhTuG1DQFgBOduej58aq
         p1GA==
X-Forwarded-Encrypted: i=1; AJvYcCVr5pK98rQTLjyOwP3q8L+GDMayi02lty9Yq8JDlakUIEYtuy/VJ3VNu31C+A0WNhqt9dUeyENnPfTp5RnH9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxfjSFfOYsIIqQ75pgRyKj1ob4o4HSHWstST5Fdme/A0hRLhKrB
	I7Zuy1KCr13uE25C9ksXPVQiRyG7w61JcZKTcSwCqSeaYdRxpj0yPxUS21EWl88H46Ruq+eipuL
	sULQ2NrUOfgJv4i5AyAsPtOIFu5FbexF1i+bmT9YdqAhRTDgBnpWQSsxIcn9IvewIv+d3jQ==
X-Gm-Gg: AY/fxX4n9PwDMvLyx7FeGkPBRYY8MwJMhiUe/TXs4xMuVaVSgRI6u4XK/trknCJaP47
	Jo+dFblReIZZqCq8tYY4YLCTGy7z4d7peqe5jpljtPJCBYy9eFCYBL6Tmzp0IoZx4UWrFXkWgkz
	iy0d5TaEMwzt0tsvCmBRVgKq9KIxUAeY06NDXPQmA/OrXTq2C35sqOkxVgaLJwCDDr4Ho2cdv//
	PCY46R8BXBFOKqj2g3baOxkb51MYVqHh67sjAStOOPaaeoQXmhY7PZwyR+VBipK+HZSuslcdbVB
	4M8Ul+KpfEVqonbHLp4O4bLWubmTHCRK5oazPyDn2ulS8lC7WUW2+W2KTq3oM6rU/rhrUoqD6X3
	ar+zrM6M11c+9o3oDVFkVKGKiMGV5Zv/Kg3bZakCn4oO+Mwu9TptagWSd35jQv0c8hyPy2YQD5Z
	8/rkU4JK3qsVItiVBl4JjSNUo=
X-Received: by 2002:a05:6214:5346:b0:88a:577b:fa4f with SMTP id 6a1803df08f44-88d816677dbmr455657526d6.12.1767137767738;
        Tue, 30 Dec 2025 15:36:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFdnza02N3sSIYqg8QIbbm0Oq76vXy4hsYlfyFT5vTsSTcIzXDSLfcpiTPdwPf76j1mcmQ+Ew==
X-Received: by 2002:a05:6214:5346:b0:88a:577b:fa4f with SMTP id 6a1803df08f44-88d816677dbmr455657166d6.12.1767137767195;
        Tue, 30 Dec 2025 15:36:07 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18620337sm10349574e87.86.2025.12.30.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 15:36:06 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/14] power: sequencing: extend WCN driver to support
 WCN399x device
Date: Wed, 31 Dec 2025 01:35:50 +0200
Message-Id: <20251231-wcn3990-pwrctl-v1-0-1ff4d6028ad5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZhVGkC/yXMQQ6CMBCF4as0s7aRFkXLVQyLWqY6iS0wrUBCu
 LuNLL+XvH+DhEyYoBUbMM6UaIgF6iTAvW18oaS+GHSlr0prIxcXa2MqOS7s8kc6b5uLN/1dNTc
 op5HR0/oPPrrDjNO3dPMxwtMmlG4IgXIrIq75HGzKyNDt+w+JUlN6jwAAAA==
X-Change-ID: 20251229-wcn3990-pwrctl-cfa64f9d8167
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-pm@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2926;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=bXiffYe+pGwR6NdvYFKSdqs2/i01fTSO8sfcFDANfYI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpVGHjsWqyWw8firHhZXjG//YGd+ddG8rzLWWCL
 WXNgAt92o+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaVRh4wAKCRCLPIo+Aiko
 1dM0B/9/9lvHUyWnm4IW8UQUVd6Ydzg+g+mgeLq4Q3CFWTqW9Ic1I/uar9yFDIiUOKm/1iqlvKu
 XzHHVPLclr7szWyZVYQoGRDbpQBulW9Gv9dLrugNavrtjSqXG1A/O/eZa/P9f1efTR07zOXsMBx
 ZK5ecfcSL+j14c6PNvQpqXRaR3NDjgtqcj6QRTX+5oiaTTsfdGFjoZYCN0vZr5c+0aOlWgXyOdG
 TzywGECxV6EHJSutjs8MgHgjyrVeiGTFUAxKYZ0nrp6mghBowjfA3aWRIgbRzJqwLr08OZaH687
 gv0DA0MhoJeg3kRPZJYoRGKy/UFCIz/lzBcyIAwmF9KPMGM2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDIxMSBTYWx0ZWRfX3LgbbaTwVVp2
 Ynf/JqXdE8IePfAeHpY6IQw+fu0mN9x+F22bF83gOCei83Qi2nZB1yG5WHy01gh5TqsUEm+wde9
 kYsEnvBx6ulA+wwJUvxHXccbVP4vJdVnxcAz56rTZveYkWanl0S7wH7LxFgkFCr6ZTqAUK5vBbY
 i18FgrTo9gYlaOH55JIxtfIWDH8X5d9+xJMBbdd/caEDR8FkFPhF92wgvYcJk3r1yped+JkuqEM
 mhW0rUE1oYtRbIK6CPwuuqIik0I+wINcPSbxe6nijyYf2UMJcjQSK9LOYmcB32pkLjCRuhJEvex
 P99E0YspPJPgwryhS8dqDL/XmyTccRi3MwriRDGGBO2l0QsfPJcfv3w5QHbg0mis+xO9WsUA6hJ
 FWRdgGTVsmYMDdWTYwrnMGBAWbJr4IJB24K6idmwWYkkOi3ei5R075vKI0HNzXMXb+x/l+1h7RC
 I8cYJpSr/qPSp7hTppA==
X-Proofpoint-ORIG-GUID: 5zZ6YvI-U2YwmDflQfRfJWeiNkbJECAv
X-Authority-Analysis: v=2.4 cv=BuuQAIX5 c=1 sm=1 tr=0 ts=695461e8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=qrAnp46GSAHW5yBWPzcA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: 5zZ6YvI-U2YwmDflQfRfJWeiNkbJECAv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_04,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2512300211

Qualcomm WCN3950, WCN3988 and WCN399x families of WiFi/BT chips preceed
the later WCN / QCA devices, but they still incorporate a very simple
PMU on die. It controls internal on-chip power networks, but, most
importantly, it also requires a certain start-up procedure (first bring
up VDD_IO, then bring up other voltages). In order to further unify code
supporting different families of QCA / WCN chips and in order to
maintain the required power up sequence, properly represent these chips
in DTs and modify drivers to use power sequencing for these chips.

Backwards compatibility with the existing DTs is retained by keeping the
regulator&clock code in the drivers as a fallback.

As a part of the series I've converted only several boards, verifying
that all known instances of WCN39xx family works (fixing the issues
meanwhile). The rest of devices might follow the pattern later.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (14):
      regulator: dt-bindings: qcom,qca6390-pmu: describe PMUs on WCN39xx
      Bluetooth: qca: enable pwrseq support for WCN39xx devices
      Bluetooth: qca: fix ROM version reading on WCN3998 chips
      wifi: ath10k: snoc: support powering on the device via pwrseq
      power: sequencing: qcom-wcn: add support for WCN39xx
      arm64: dts: qcom: qrb4210-rb2: Fix UART3 wakeup IRQ storm
      arm64: dts: qcom: sdm845-db845c: drop CS from SPIO0
      arm64: dts: qcom: sdm845-db845c: specify power for WiFi CH1
      arm64: dts: qcom: sm8150: add uart13
      arm64: dts: qcom: qrb2210-rb1: describe WiFi/BT properly
      arm64: dts: qcom: qrb4210-rb2: describe WiFi/BT properly
      arm64: dts: qcom: sda660-ifc6560: describe WiFi/BT properly
      arm64: dts: qcom: sdm845-db845c: describe WiFi/BT properly
      arm64: dts: qcom: sm8150-hdk: describe WiFi/BT properly

 .../bindings/regulator/qcom,qca6390-pmu.yaml       |  36 ++++++
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts           |  60 +++++++--
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts           |  62 +++++++--
 .../arm64/boot/dts/qcom/sda660-inforce-ifc6560.dts |  66 ++++++++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts         |  75 +++++++++--
 arch/arm64/boot/dts/qcom/sm8150-hdk.dts            | 141 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8150.dtsi               |   9 ++
 drivers/bluetooth/btqca.c                          |   2 +
 drivers/bluetooth/hci_qca.c                        |  26 ++--
 drivers/net/wireless/ath/ath10k/snoc.c             |  43 ++++++-
 drivers/net/wireless/ath/ath10k/snoc.h             |   2 +
 drivers/power/sequencing/pwrseq-qcom-wcn.c         | 130 ++++++++++++++++++-
 12 files changed, 596 insertions(+), 56 deletions(-)
---
base-commit: cc3aa43b44bdb43dfbac0fcb51c56594a11338a8
change-id: 20251229-wcn3990-pwrctl-cfa64f9d8167

Best regards,
-- 
With best wishes
Dmitry


