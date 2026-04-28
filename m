Return-Path: <linux-wireless+bounces-35493-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHgJJz/W8GkSZQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35493-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:46:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F70A48826F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 17:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 765BF313F763
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9EA44D022;
	Tue, 28 Apr 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WW78sBvI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VfEeCoYe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5A44BCB6
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777386200; cv=none; b=Eps2lL61QJZWAyksj7JI/9PR4bi7u2/18pL6uMPnlBXzWSwqGkcDg0BowcRTN+9VGag8/QMyputWzFsgsr0RLy6THGggUC4hpproK1c80CdqpTQ0R4cm36cLon7MvZQDeDqOikPbOSNs5+vNMT3taerLSo1KC3HZT7Isklzcq00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777386200; c=relaxed/simple;
	bh=dzIl8YppqJhB6Od+T2zCGC/CJ+cKszHfDpLPF2geGtk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PioeJEPhbtrU2qwRBl4XsJWo2UnFNc8RFp16nign7J5DIwYSmWgFGGc6ETAanHXoqhAqVCumhLnw0mhlGl2eo41EflqfJ48p+GprdkNB5vwxafL4Aloyp2JNJ+cipaJCUlLImFqqiniuvYLx0PQXejuHjZiSd6SVCGv07S9UreE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WW78sBvI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VfEeCoYe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63SE48T43454693
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=; b=WW78sBvIUBy1eVFU
	njJYuxlMhWipbbcVudjhYGGP+XiDYinoeKFVUBhnPDAEGLfcScUrldggbPiLQx4w
	yRGYnTpOVRigSrjJgWenphU9HcLPtD80UsQ0NPNBxJCNY+Y2nRA0oaebXe1yf2ET
	XnvV+zwf2g5DC3bcqTe4l+IIwbQ6DCiXA1shrVwUbs6Je2t1uHc0Urky9gWUYWuV
	TWmdr6s7Zws1UD2ea8CbD5W5+zyyqfWV/QYthqt5G2CR7BfPyZYhNd+ZBIO8Mmek
	Ci+ElfzTMJxdzLH8mj+xDSTUQDkGLtZwg4YwdNwabusIJW1pSgyugppW5hNzLx5u
	Ey/iMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtxb502xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 14:23:17 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50df4c130dbso200061771cf.1
        for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 07:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777386196; x=1777990996; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=VfEeCoYemwkTM59YTf0RVou51QvqCcBtqzIklZk7eUfFk/u/P1sJaeKwZ4ID0BT5aG
         RSwxEQReUAdmnQYKwKrhsCAb44buIOCLX2sSggIvrRASgtkc8LqLVR43JbzcwAyeMF8F
         4XN9Su5y+RAc1sgudX1dTFpfvN4RrOhnLIVatpRnC8oXYW2F/miRyXpffCqluLU2f3uy
         Y/IurEEyTmGO0psUeAAhAaQzdQbxK7YdsprsS+Q1P4VWbBOpjOSeGV/Ka98DIflKk6fJ
         JjM1WHzd/evBduwmKHf62e0wyZmaIBpbjd90oDShmEiBcTd3GYmWcI9FDk45kYYK6bek
         jOFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777386196; x=1777990996;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yCqCzlz4VIr+zRAIjiPoA3dsT7YZuy9FJGQk0vmxxKY=;
        b=K1TfJlbNMZyz76rlukQ74HjmjxZyUxintWndysROVYInGHr6HNgKjy/ZZ2+d0/3bQ2
         fjYfIrDjmvqnZGzO8dF53E75uQYx7KC9aSONxbiHeeJKTlyjuORdFNEGhs0gZN9LZGUP
         0BN0fenSulANPdmpmENyX+Ot7V5nALbQIfc/8G5x1rCpa9VLETS6vXRSTdqGDvRYi6NQ
         OYQX/C81hcIGDwGRmgwxKSkgl0xz8gvgLsdnAs3KBdNYMi2Y2awa5TMy+aAWq7UYbT3c
         THiNZP+aAmCu6cLxo7nxwBE7PdJtBEs99r8I5/k+0KNJ8T082vVnhsz7bOBlpc6rMp9I
         l0yg==
X-Forwarded-Encrypted: i=1; AFNElJ+pkzqBBnLEnz5iYkrXjpUAXigc2qApQwv1qGT4Ym1x6gjZyqhziW7qEwio8Djh/ADhjSoSVaWXBt4DIjoFNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLVIAM2AoZ8ZMUoqytywgDFdgyQiATHn/R38eQ8dENFpp2bXL
	/u8d6JcV03s8i5z/lP8+IVuRhthwtMQXemFaHcuRX5kgIrdcjg9cTzxXk3O1QhQQUEoDiIhsDFb
	xE1FvZNqS5KarLTBPzZOLWFlFBck/1eSxV3ihS/KG4rqYImbJxYc8VkaOAMLGL6jBmBeE4Q==
X-Gm-Gg: AeBDieuI8DeI8SINLHpqKd1yDgwMRhtNH7zWlPnO8O7/67oLzDschPqE5uDMgNErefg
	vlrmK6EG3m79dX110tzWFolonnmceTm9winBR+yZHD6PPszeUCjk6sGd8qRcjii/w1/l2C72d4A
	SDrrRGBjmhW1w5sp1FLtquUGtHuR7/fwCxhzcgs/hnHO+nxjbwUf1yDh57lnFMxmEpAq92PjM//
	Ehxk/KJWWR12DUayTuoKG8aL/36MF8u4+LAInwK7Egpqoh5okLGzZU65iYT0qdMoY9EovK9nuZT
	NzvAgSmMNZpf/kYHmeMeGL+EqiFncgz60HpsWZt5XrgOQ6iGbzd4PgoEUYWeLQqFW3gwd6SZgUC
	0KBoB1Hc9KjFu1D3u4sEq1pce5vha5n5vJzd3savJgaRdP7zZ3/fHpHy6LUSqiEk4S3ySPA2v5u
	4NQryJFEy5PwLK9ooUixv4zrcl5UE=
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39311041cf.37.1777386195921;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
X-Received: by 2002:ac8:5750:0:b0:509:5c6f:c0e with SMTP id d75a77b69052e-5100da85790mr39309901cf.37.1777386195170;
        Tue, 28 Apr 2026 07:23:15 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:653f:4d28:6a78:a6ca])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80ba9b8c8sm107072666b.48.2026.04.28.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:23:14 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 28 Apr 2026 16:23:07 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: arduino-imola: Describe boot1 NVMEM
 layout
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-block-as-nvmem-v1-2-6ad23e75190a@oss.qualcomm.com>
References: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
In-Reply-To: <20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com>
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
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDEzNiBTYWx0ZWRfX2m7GjduLvecm
 Bpe1Pwb7ZvP0oSeoc4RU9Kosyif6VpmD2D9xWd531A7Af5Xl2IqLsAlScNl82LBaH+H1uDyKcwx
 BQnfJe316MCpWbDYeAIRI0Hj5Z5qCF2PvN9eMwJlNhOLfuDh8sHP9luHY8feLkxfza4mgJctrmL
 TGGrSzz3LH5KQ00yuKtN7hD1pVOC1h0YFdnsx7BtcZizhTHPPPUiXVIqtKG/uy9LV9aJ7i0eB3W
 XnO3X2VKVQ9wkIvmV/+lMYKrJu0XLAA0mODALmZogbvxVDmtVi5wDpTu2ykwrHM4tvGj+NbgosY
 J6WwY+cq3fBL0Pmeix1XulW5qcVKvt+jrb6l6CUewv90Ac5pVdA2qxutU/9PYyAZjLWRB/g3Lnn
 MoJydxS2d+K1rWFJZxgMh4iPQo0RlNbzy6jJw93gk4d17Jg2NGlKP5ucppEWDpymu0DXEvs9AdM
 XcvVZ/2iOFeuqp2YIrQ==
X-Proofpoint-ORIG-GUID: ip4i6WgsFcBffu-jNH3nHsPYt_iEOVgf
X-Proofpoint-GUID: ip4i6WgsFcBffu-jNH3nHsPYt_iEOVgf
X-Authority-Analysis: v=2.4 cv=A45c+aWG c=1 sm=1 tr=0 ts=69f0c2d5 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=gjCkitBQ8UzLeNF7HDgA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_04,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280136
X-Rspamd-Queue-Id: 8F70A48826F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	SEM_URIBL(3.50)[0.0.0.0:email];
	SUSPICIOUS_RECIPS(1.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35493-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,0.0.0.0:email,0.0.21.24:email,0.0.17.48:email];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[30];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	NEURAL_SPAM(0.00)[0.071];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c15:e001:75::/64:c];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_COUNT_SEVEN(0.00)[7]

On Arduino Uno-Q, the eMMC boot1 partition is factory provisioned
with device-specific information such as the WiFi MAC address
and the Bluetooth BD address. This partition can serve as an
alternative to additional non-volatile memory, such as a
dedicated EEPROM.

The eMMC boot partitions are typically good candidates, as they
are realively small, read-only by default (and can be enforced
as hardware read-only), and are not affected by board reflashing
procedures, which generally target the eMMC user or GP partitions.

Describe the corresponding nvmem-layout for the WiFi and
Bluetooth addresses.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
index bf088fa9807f040f0c8f405f9111b01790b09377..dc85cf94f71cac8666cab30ccf37cc2d2f8fd941 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts
@@ -409,7 +409,31 @@ &sdhc_1 {
 	no-sdio;
 	no-sd;
 
+	#address-cells = <1>;
+	#size-cells = <0>;
+
 	status = "okay";
+
+	card@0 {
+		compatible = "mmc-card";
+		reg = <0>;
+
+		partitions-boot1 {
+			nvmem-layout {
+				compatible = "fixed-layout";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				wifi_mac_addr: mac-addr@4400 {
+					reg = <0x4400 0x6>;
+				};
+
+				bd_addr: bd-addr@5400 {
+					reg = <0x5400 0x6>;
+				};
+			};
+		};
+	};
 };
 
 &spi5 {

-- 
2.34.1


