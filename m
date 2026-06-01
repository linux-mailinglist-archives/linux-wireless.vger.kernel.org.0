Return-Path: <linux-wireless+bounces-37247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN/JBe5aHWrnZgkAu9opvQ
	(envelope-from <linux-wireless+bounces-37247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:11:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146661D1C7
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FF9930E8569
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B94039EF35;
	Mon,  1 Jun 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iq3Eq1uJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IeSG4yNS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5D939A4B8
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307243; cv=none; b=fCcChdtlo7ChcHPAYSvuoTj9bNmN8tnpIwcu5OTHcnRbm2IwzLZcyf6mKrAz+EKKt3K0XZEcZsTjaiD8KGIQEUxdxYczpmRfb0wTgO3FRkjru4SN8LhWxRZ+/cp8xsXgubuF40gQdePAfwIJHUke2x8BtaYHiTAwMjrtRDSsbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307243; c=relaxed/simple;
	bh=p/vEWXfWcfITuHPO9mfDyXFqaiM3ASW/1cHspYUnUG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qg4Lrc742wmOn7f0bX9D9NrUa9onFIFIy22ER1P8VpLeI71jdN4HyI4XxIDeAiA9+i3/QkdgZf6YIIgLjDvs6nTYUsAPxJMKxKYV3r7vGcMEP86XvUCCl5rHfsy7f7yVJsnpgvFt63Mi3EKIsFlcLRBEUsQvsgqoNPoDKtXRa7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iq3Eq1uJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IeSG4yNS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65177Vs62948453
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=; b=iq3Eq1uJy5sqIyaB
	HEeTyGysoJFEbltXLV4EGShG2OY1eXw99X6JDSbw21wY57+Ry8w7iqhCG+9pc7e3
	WTNa9kgWHeLANCjlgSA1mPJQUkFMOPzJShC78ifs1DNraLkHfqEAVLiBMbtFVrCq
	ZPUxTEi1AVKlWjoHniamktcwbrcGahmyziNw/5CF6V68ltzeyxDo9VU7bydmkJGs
	dqBtOwayhiZokYmcjfP1rmTJ+DbSWLcZKPAR8nOfV4y6IDrpD68FV/UAsTQVp9ex
	zcGpwK3XS2dGoXKO+/0lV7vqhQ4y8b1210ygEdjfdIcPyydmQRfh79lAKR+taZiK
	LTRoAA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efq7ff0w1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:47:07 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174d1b326eso30035401cf.3
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307227; x=1780912027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=;
        b=IeSG4yNSeqImHHiYB/YQ3mjNpOKrAVvbqGFOKQrHJ0AtUj82M1Rp14aiAuprhD+f/S
         39I4qB07aZ3kxWHBXzSYojF5yr3A7qIvzu9pEi4HvQo3DA4CeEuWN2nxk5ITZ7qqw4ly
         SUVwcLgNQoOFirj65IjXxfrs/S7aDYnjaqGnCjGkMUcI1uTLMOdwVtRq8VJg/rqODnBC
         fTFTsJ/K+SJ3DjOOTZl4bsW8JQigPO/vd2REf+F7yNN4lvnZsx57QPTkFhq+q7uEOiX8
         qALLO42aLMVs2uLgekRzrkMHr4gJgco3VZc5aWE/Ev2cp3eWXSxlZ/5JSmTsVc44VnTI
         zTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307227; x=1780912027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=32iMDaQ3qO7lDTIoDuzY5zW3z4FbD3aMPXHmlVvtKpA=;
        b=MqlOyKlRyR9vawbU48hHr8ji52OifFMLJC0bG1XxY9FXnm7EAhxoaXje0NuptGDOOz
         3eQreUYuyPsEdEzeAPrGLsQ8lsp93LtQGVfnr+NuMjtE72sluBdo7EKpa/q5k++GCHaT
         /RHz9VUVU4cybiE5rSkEituAEVZxVtUuSvr+YYGasYJ/QJibZMhIlJ5ciW8H8KLcKrJR
         jXBuFdpZLg6KDEcNuW7Vr/tM8RsgILwbb8W/fzyyetw1raLYLx7aHwNdk4NDyPILMz2P
         tP4iMaKnZgCubzKMfaF7gDreWBFYoEgIeacs6IVinI6Gv202+j5p9waL9PDYnxRjgFF3
         iQpg==
X-Forwarded-Encrypted: i=1; AFNElJ+p9dDfA0i1OrXsHmrFtpUrxHHoDWzdtS3fne8k8T/QqlKfW5ZpSH9shAzY53SE4LeeuxoMLOl4Ihiu4oDWtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YymQxfKfLQGQauokW4pZLJdoNWRmSCr/4o0hAua4KC9CF7cokdt
	trXVJ8CDjQlMMwITqbWwk4Dog4ArCk6G0qZKL1WYnek448LhhKYKWZi8+AmMhC2L4uMH3wIJdE9
	3FgsWdPnxWoEWmNHOgKrRai0cvRd29PnhP+WHYrO+u5U3+uyQEHJsJRgaNjxpMnEwFrY1SA==
X-Gm-Gg: Acq92OGKJ69TX5FVBAwCcvXwJFAkvb3q3WVNAxGkTBbaFStO5ErjDo5Q1vkwvtP0rBE
	UFPUH41aur4KN/FCMpDpd1kRFXWaN+bRx23MP/k6XvbOAGPbM9ieDDB3MPFKaarDBOso4EYf6Wx
	zfa4+aGYvaVsCSqQmTC1C5RoyncEDQWv+mgpM/y+lGWJ9uVGHVt2n+0P5Osui1V01yzSAFkvId9
	2FOBI1VOBwLGoA1GaaSqeN4RiXDzuKqO/JRD/VibPr9xC0On4HZHfenR8VjLCg10yVFEJevsCI4
	aqeJB1EIH4tnN5FYvKUC00zQkhQKVqj+B3BniR1VRdayhJv0ElVnthn7dnPppt6qs2FQ1OvKXNI
	oZLQmla0q2WxLai41gzIBIwVbdAbfdKPRNBCNCUjh0pn5Xi6jck01NTQptBX7pNvKMDLa7Cjw3g
	SuwSJ2XWns4aZTPWu1Z3FZqJpf3H5WMDbKGpufWantGbg7tQ==
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr25765641cf.32.1780307226578;
        Mon, 01 Jun 2026 02:47:06 -0700 (PDT)
X-Received: by 2002:a05:622a:299b:b0:517:58f6:29c3 with SMTP id d75a77b69052e-51758f642edmr25765361cf.32.1780307226184;
        Mon, 01 Jun 2026 02:47:06 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:47:05 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:55 +0300
Subject: [PATCH 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-7-242917d88031@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6120;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p/vEWXfWcfITuHPO9mfDyXFqaiM3ASW/1cHspYUnUG4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVULHknQTeqgXWLpTQtoBAPOcZ8nrUprloMHR
 HJqLRInYkSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCwAKCRCLPIo+Aiko
 1aswB/wLWeCDt7fqtyhpWQItLB5x948RgkF3AfS0s+K8vCNS5F6wN12TNHhnvx6N92e7SeuS4/O
 pbuLBC4kiL5kaoUWP2Y2zQ3KSWOUJWD+rWVtpA48mrHt41PQJIlx4L+YFCCLVPhZYsJwM9AsJFq
 0Z0rXdQuurtvBjuJbjkZEra7j+3bJMC6mOC+vkVWFisrSPB8txE20LJCRlZ+T8zT0MxTNw+g4Mv
 f9qnmUd5tW+23KQEPL/PK8+GbLTgxdPT7RqFbxhnPP+v+txO1Ku6VgmYnPSDBsruBI0FWtzcq3q
 EtcYzFmbprwQUCgBkP1sBKeckGK9uTFw4M3HA2jL2HVKUFn/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: I4_W8Zx50byn-Xhs38nRb3g6pVXjYWjF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX5n9iBJWiaCDi
 TuR7MhJyqtH1GnAXMxrG9GPmkalE1x9GWL02XRUkP/RPvZ/6Y5ZFGL4m5+d5wPU38MTCj0Tkw3l
 jYbkM79ckIelTqggR2X4KCphYDH1zlJeLfj2ifTVkZLdCkEwsxoTTHwRAasDkVxnxnheQilc2dO
 vTQllJjYlbAaD9fvAnTgGTJuC1ZQGsN1nowI/scl2gB1ov5umXZ/IGdXTjsNW8nGnSaQ1mbX8dA
 6p+JRF9J2z/CzyKJ3pvTaq1yRPvpvdG7Ri4j9wVxQIwGR0YqWPk+W3HLxRqNdINrN7GQ23h+g/0
 APVRW4FzZk2NT5UIyUdwbI+6/oUrX57ZPlFL7gYd29j0DtvbLvTS74kLAOr7n6MpwqySVxTPH0s
 0iLZpdrDh+y3fqNwW+JPolPgFlFb+XMYdNac/ubBemwgfH0ZTHfvNbjLONYESnm+mwWr4TTUAMB
 vC+pUeB8ygTa3m8ngHA==
X-Proofpoint-GUID: I4_W8Zx50byn-Xhs38nRb3g6pVXjYWjF
X-Authority-Analysis: v=2.4 cv=XqzK/1F9 c=1 sm=1 tr=0 ts=6a1d551b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=o9ryCBrv46mMSQ48XGcA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37247-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,0.0.0.0:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7146661D1C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The SM8350 HDK has onboard WiFi/BT chip, WCN6851. It is an earlier
version of well-known WCN6855 WiFI/BT SoC. Describe the PMU, BT and WiFI
parts of the device.

The firmware isn't (yet) available as a part of linux-firmware, so it
was verified with the firmware files from the vendor-supplied package
(wcn prefix was applied to Bluetooth firmware files to make them follow
upstream driver changes, vendor provided hpbtfw10.tlv and hpnv10.b06).

Bluetooth: hci0: QCA Product ID   :0x00000013
Bluetooth: hci0: QCA SOC Version  :0x400c0110
Bluetooth: hci0: QCA ROM Version  :0x00000100
Bluetooth: hci0: QCA Patch Version:0x00001017
Bluetooth: hci0: QCA controller version 0x01100100
Bluetooth: hci0: QCA Downloading qca/wcnhpbtfw10.tlv
Bluetooth: hci0: QCA Downloading qca/wcnhpnv10.b06
Bluetooth: hci0: QCA setup on UART is completed
Bluetooth: hci0: HFP non-HCI data transport is supported

ath11k_pci 0000:01:00.0: BAR 0 [mem 0x60400000-0x605fffff 64bit]: assigned
ath11k_pci 0000:01:00.0: MSI vectors: 32
ath11k_pci 0000:01:00.0: wcn6855 hw1.1
mhi mhi0: Requested to power ON
mhi mhi0: Power on setup success
mhi mhi0: Wait for device to enter SBL or Mission mode
ath11k_pci 0000:01:00.0: chip_id 0x0 chip_family 0xb board_id 0x6 soc_id 0x400c0110
ath11k_pci 0000:01:00.0: fw_version 0x110c80c8 fw_build_timestamp 2021-05-25 21:43 fw_build_id WLAN.HSP.1.1.c3-00200-QCAHSPSWPL_V1_V2_SILICONZ-1
ath11k_pci 0000:01:00.0 wlp1s0: renamed from wlan0

For the reference, the driver looks for the board data for
bus=pci,vendor=17cb,device=1103,subsystem-vendor=17cb,subsystem-device=0108,qmi-chip-id=0,qmi-board-id=6,variant=QC_8350_HDK

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts | 126 ++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
index 4973a3eb11b5..8e35216e4272 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8350-hdk.dts
@@ -115,6 +115,70 @@ lt9611_3v3: lt9611-3v3-regulator {
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6851-pmu", "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_en>, <&wlan_en>, <&swctrl>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 64 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 65 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 153 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b_1p8>;
+		vddaon-supply = <&vreg_s11b_0p95>;
+		vddpmu-supply = <&vreg_s11b_0p95>;
+		vddpmumx-supply = <&vreg_s2e_0p85>;
+		vddpmucx-supply = <&vreg_s11b_0p95>;
+		vddrfa0p95-supply = <&vreg_s11b_0p95>;
+		vddrfa1p3-supply = <&vreg_s12b_1p25>;
+		vddrfa1p9-supply = <&vreg_s1c_1p86>;
+		vddpcie1p3-supply = <&vreg_s12b_1p25>;
+		vddpcie1p9-supply = <&vreg_s1c_1p86>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &adsp {
@@ -373,6 +437,13 @@ vreg_l7e_2p8: ldo7 {
 			regulator-name = "vreg_l7e_2p8";
 			regulator-min-microvolt = <2800000>;
 			regulator-max-microvolt = <2800000>;
+
+			/*
+			 * This is used by the RF front-end for which there is
+			 * no way to represent it in DT (yet?).
+			 */
+			regulator-boot-on;
+			regulator-always-on;
 		};
 	};
 };
@@ -499,6 +570,23 @@ &pcie0 {
 &pcie0_port0 {
 	reset-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
+		qcom,calibration-variant = "QC_8350_HDK";
+	};
 };
 
 &pcie0_phy {
@@ -763,6 +851,20 @@ &tlmm {
 		"HST_WLAN_UART_TX",
 		"HST_WLAN_UART_RX";
 
+	wlan_en: wlan-en-state {
+		pins = "gpio64";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
+	bt_en: bt-en-state {
+		pins = "gpio65";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		perst-pins {
 			pins = "gpio94";
@@ -815,12 +917,36 @@ sdc2_card_det_n: sd-card-det-n-state {
 		drive-strength = <2>;
 		bias-pull-up;
 	};
+
+	swctrl: swctrl-state {
+		pins = "gpio153";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
 
 &uart2 {
 	status = "okay";
 };
 
+&uart18 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6851-bt", "qcom,wcn6855-bt";
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p7-supply = <&vreg_pmu_rfa_1p7>;
+	};
+};
+
 &ufs_mem_hc {
 	status = "okay";
 

-- 
2.47.3


