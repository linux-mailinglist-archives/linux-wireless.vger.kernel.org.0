Return-Path: <linux-wireless+bounces-37240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFewMGlXHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:56:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC1661CE5B
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF5F4304B7DC
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB1A9463;
	Mon,  1 Jun 2026 09:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fw1ENjO5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cz5syKpG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643C396B9A
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307222; cv=none; b=B0TEtaiLf38IEcpTH2f6bq5hyJo/JIYiK/KlolWUQtI2mQf/u6MbiQR9kCPjxRIU0AL6bCQ5jAjjHfcwTus+/w+ewbZn7qrSeLFYKa4jjp/UG1vCCoNejctcjgyjLsccq429a27VlPxs/Ea2Hko10vI7j7fPmFnAI47daPK7ols=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307222; c=relaxed/simple;
	bh=7IQl5gBCstIzsB25wxagTUyFt2zOmpRhZY2BOPvDRsk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lLHElJZajAGbUAaNa9Cu1O1jqTKLbYjgEk8VITNoBbTPHARCKlgIWx4NfB6EpN53obn6yTU4o02/05OuPvZhmxnW8NQLl9D1DNShq6ri7MExrwHbsiAK2GHf0acZj1WolHeqnjeDEDuV4uRkXvDHB1zNN1GZTba913am9Y46mFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fw1ENjO5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cz5syKpG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518eDDh1214152
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bQKthfhJHJ/OKF7Yf2J7ev
	+iNLRDR1B1zOFtNrqX460=; b=fw1ENjO5pfCylBBNsHQKFNcEffxXp7oHYd4ydD
	J23U7GKbOFGjNNzHFJIG2ZN1mMWAmFxo6Jk0Cy8pZ1IRLRBiiQTZCEKvs0WV7WJB
	NWZW4Sso0dfkrYFXu/WrhEnawt3xv0EJnubx2hIcNz+pOIVAinGRLyuwIdyOINnO
	klaIG6H9xMJI34y1kAkAlub1d2EZXaIPIi3lKvKpX4shkvnOz/5iyruFYCUESust
	M/aVEqKNej/338Os9eCUBGYtPKzGzy+rE1mkJR8mPL4YhV7MM+I4nhvg0CpMjEnJ
	H18LM+R2dvONtm3TJ5wW03fDye5Upe8B41DzxOT/k7nMQLMg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6s989f1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:46:54 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-516d13328dcso200664131cf.1
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307213; x=1780912013; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQKthfhJHJ/OKF7Yf2J7ev+iNLRDR1B1zOFtNrqX460=;
        b=cz5syKpGNFSctP1iiLUGH9YG/N2Lp03pnCqa4o2ZDPssmgBN6XxA62gLLPNquOfzrL
         taHNvCatkIpgV0lSzF9Py0vUlOjwvTy59WjTzFDFmf1Q8CmpixcdXbsbbKzoN96y3p9u
         H036c3d1TEVmcbYvLQLJZu77npCvopCBjQ1vN8tA0ouLmPuVnZg8YLFPtfEHZ7NuZPOQ
         1eAiYXWgGFWzguFxbiGz7ecrnnCxEHUd1QMCx5nX8+QpQvTQ7J6gG5snqL7R+BlBAWxH
         Duqra/ZLzCLjCIlDPno6fuSVkXNRDQivtsw72TjQyGJBfrDhyJ4IqJpieLYNzZDFoGu6
         fLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307213; x=1780912013;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQKthfhJHJ/OKF7Yf2J7ev+iNLRDR1B1zOFtNrqX460=;
        b=oNCDpO2cJHkghuAzBoYbfDszFWMM/uK6Um88dh219E0wNiqMXhfDIkj6Aj9r8ujVnQ
         VrCejMpG05eNGwn1fqMEreV+k3rUImszMg4Vcf6BhHfnIqnem0nIHG8kxvASAuuahuC+
         UtAc+gPcXYoWHn/pMvk2UfONH4+jl47V3WjCM8Jvq1NcIInOzpJjs9MGzYrVB3QXAw0M
         mEfFeWbGZhXk8fi9c4G5QccdHVRRJYcea1b/ERKFe4fttZRvMfhTxZYzjSrFh3zJSu9R
         UBH/NSBpvL8HLYZ1wuuxa74xAcsHr6ogmx9Rb26O3rieO1TzC2anctVZ9EDNhBz84ZWO
         KIew==
X-Forwarded-Encrypted: i=1; AFNElJ+02YX6zcXctk2+XAe242/tn0Ny8Mu26y7HQQHgh3hP4pxMWpfTwtqZymF8IrN2db0FDhpIW2lgMIiwCk67bA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzOEInKVWIxZfiq4z/Sh+Kggs9kHOdxxannSjhpwydoPvbsf2HR
	iGqXUIOCV3CiNcM7vGfX3RHnj/3KtIoy18XKLQAmdYeCw236KXvTUhsgNUHU417TBJ3cxu+GiLW
	+L4p4M4qjnIg5bloYcuEDUtclqiZrJ8t8G5+qLlsvAGc8xiZ12YPi7mC/O+kNUULJprbkjg==
X-Gm-Gg: Acq92OExlwecvjBlqczKDRIaDnRD6dnZt0gHRTEUA3m2HgaAx0g5ojpFCv9mNBXUnpn
	yuL58+FFU/Gze/T7cQ/9vAfIbaCSRJGPGSr+twjHjMAgEnIfvqmD5g9F9F3tCje7wXY/vvBJPXr
	JSfCXftIshwarLntjsmDtt8i3gOrApHdy4w4JsCuC3nA5AuZTYnsZXRCqRwsX7eWE28fi9fWIGu
	N0C06oJf0tO5XM6VyA5TzkVdTbBLqCeicT4BP36bPDaQ5MyxNdQObD3cnXRy3b1eNMQ5UL7MulW
	da7q5uZ9vCXmCGQS/FT6OhAZhZb9n+mgGf+LtD1jUEdNepqdfOKZJzTovkaDK2AmgnFqihNZKki
	9VQeJwBJD/0scUFDZOlZj67Nx7vnwJMQ0635PJcGyEtLsnOaOyi83Nh5dsy17sKAIklQYwpiECw
	Ze58kkvBJPQ338USRte3BTz1V0eAH04sfArn/OIWvSKurtgw==
X-Received: by 2002:a05:622a:4e98:b0:517:5aa6:acf3 with SMTP id d75a77b69052e-5175aa6ada3mr18890051cf.12.1780307213397;
        Mon, 01 Jun 2026 02:46:53 -0700 (PDT)
X-Received: by 2002:a05:622a:4e98:b0:517:5aa6:acf3 with SMTP id d75a77b69052e-5175aa6ada3mr18889581cf.12.1780307212935;
        Mon, 01 Jun 2026 02:46:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Date: Mon, 01 Jun 2026 12:46:48 +0300
Message-Id: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhVHWoC/yXMyw5AMBBA0V+RWWvSair4FbHQGozEIx2vRPy7Y
 nkW917A6AkZiugCjzsxzVOAiiNwfT11KKgJhkQmqTRaCR4zbaQ4qCWhrUxNbp3KdA2hWDy2dH6
 3svrNmx3Qre8C7vsBHvXkXG8AAAA=
X-Change-ID: 20260531-sm8350-wifi-3b0659bc183a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7IQl5gBCstIzsB25wxagTUyFt2zOmpRhZY2BOPvDRsk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ5ZsKFf5IqHd3afcHFRblpsxG6r91a8WNJjg1xtg1Xc+8
 1202rVORmMWBkYuBlkxRRafgpapMZuSwz7smFoPM4iVCWQKAxenAEwkqo79f1StnvUu9p28ewx0
 pvAtL5unt3uFx92tDfXqV08E93y4Z7/C4NvbTW/iki7VzG5L5CtpkxT5qr1onur9l+U5Sco9UXo
 x3ZOSOf91FtWxHAv/LbeO15PxtOKqxmTTVdu4GBhd9wSGb1yyPTvHLkqAZ9OJK/t89T89XCkQL6
 Yi3T/pW/xv6QKug53v2vIZzjPmBPX9tt3Rt5/r8Y9/nm5vdNOTeXyNVv6RuPRejudV5e8Hn+3ky
 73z1D7k8H3a9erdMtcbzXYvWVxTT2+Q9VJkXyac1NGc+zpO3adZLdXYNV8nVezQ+tkbW1c6zvC7
 xPU87lhbqGdI/EweF+0DgqwcKgm784Su2k41OLnhmy4A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: JN9cstsZMzEeOZQ1fQZ3H9zEbCu8GxRl
X-Proofpoint-GUID: JN9cstsZMzEeOZQ1fQZ3H9zEbCu8GxRl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX/i1HYsF0UB8J
 w0F8cLibhcou5pjpVHWVxVF7RUA0DEA4hlxtw5YPQBC4+lsn1iIIUgdoGlSdGOHxCTQg2IR0Usb
 bfqUjZryPQFt7KnivCvs18OT0FPZ/bXjSFLiVp5qJL4JwT3ZjsMO1nRliuJxU4ACSYSiSBrtReK
 OxIDKQq5iHZO/0cpy4tvlKoYfW8AZLLV05EKuwxGuNz5GZuJAWOhG1jByDw8w8hRalk3nzKWPdD
 0mG27YQonKQmgQiZ7m7+QrnuPX3SD9YytST6HNQOITf5KPHj85KUWuk9KiLTAVRyJoqEiyAZJv4
 DiPiZDOmHlMobpuKxOxIZh5YuZ1XXcbRUIof6H+hfLZN89Tf8ajNC6e2OciRgCPriXsbdNHR7+S
 4Wo/6SUEQSEDXYes32Ub3hFORN3/+q5o18WkFQ6r3h+kQK6oVru9m3Kj9Qu/7SrFoG+QG+1FUBT
 oorME1eugNUh7hIcfDA==
X-Authority-Analysis: v=2.4 cv=Zo7d7d7G c=1 sm=1 tr=0 ts=6a1d550e cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6KS0kTMdj-vf8_meW0gA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37240-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 3DC1661CE5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
time was not supported. Bring up different pieces required to enable
this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (7):
      PCI: qcom: fix parsing of PERST# in the legacy case
      wifi: ath11k: enable support for WCN6851
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
      dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
      arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
      arm64: dts: qcom: sm8350: modernize PCIe entries
      arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |   8 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 142 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  14 +-
 drivers/net/wireless/ath/ath11k/core.c             |  92 +++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   9 ++
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |  25 ++--
 10 files changed, 275 insertions(+), 32 deletions(-)
---
base-commit: 7da7f07112610a520567421dd2ffcb51beaefbcc
change-id: 20260531-sm8350-wifi-3b0659bc183a

Best regards,
--  
With best wishes
Dmitry


