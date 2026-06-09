Return-Path: <linux-wireless+bounces-37564-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RoIPJEzIJ2ps2AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37564-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 10:01:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3452E65D7E6
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 10:01:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=nhlzDDIK;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Z3pA4ggM;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37564-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37564-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5BBDE312B953
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DEA3EFFDE;
	Tue,  9 Jun 2026 07:53:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95953EFD37
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 07:53:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991607; cv=none; b=l2pxdNNXLHxVAU22gJ4ATPXWgFr7GLfyxeeeohCXNTBBvTMb0G5AHWdY92Qom5et/lEy/UNoRREXPpO3SZLopuH2psLUmCjx+N1e5tiobWzHL3S2v1PtPawucjO/IEjW59oG6dO1RPux+y216i6Ec1Eha71W1r7twAkUg0C/z/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991607; c=relaxed/simple;
	bh=ZvvlPNqqkkVbksz5kyXL+Qu0qP+YhN+IDwhB95LLzt4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtaqMHYZiXH0zW48Ht6zTyyX49Hp8qnemwzl0x/+R8Dmu7JwUuF6bzU5NOexdyId+URImgkvTfD8tVLweVD6+c7Wt49BeoxuoPvURoxWpP63mz64+4P9BX47VAOur+PBmOivUXHUOmc7oyA6ccH1FX72eNBMo/Iqt2JJSOBf3BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nhlzDDIK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Z3pA4ggM; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597P8gH1859695
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 07:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=; b=nhlzDDIK49NjGM7u
	e2PSjBmJIGKIWvCfTnk67JWHJ9Y6TFJlMPNk0Y3byb1iVn2pvmbKDTq6FDQt83Y6
	wayhxnRgDSjAk7i/B+dCm5NtWo2jnu//kftijgs/cWhzgn1dks6D9+LEEnze5aHg
	9ei5fqC81hF6Uu/n9diNdARwOVyQA1l58NN0Iz5RHSBof1PEEA7EHzo7xoPjU+uo
	XQcugnRwIkMu6UG9Qsh4xlQtS5djE13aIivUnlPeV0NkkIiG0kA71k6Upk31EmsN
	yAqQIzZ1fyDJnBEaIrWmNd7TnKaL0HVCt7uBFLjUinhXrDi25J+oeP/E85YA7vkO
	2xmQjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epee4g3ht-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:24 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51760f997fdso160840491cf.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991604; x=1781596404; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=;
        b=Z3pA4ggM6gcwmTFLHMVNNULCrNVnn43itHiibyniAro2nhLwp169ijXguaY5PqpSyy
         zNeRAzwHYQpj/fbHHHnEb1fF1tPyaBXJfvVGrCnuFSiniZqzGN3GvQcchWp+jk88hVn+
         SqxFJyTZH1/MyzYHzEpFTF+6DTJSluhAmmLinxdhu74tMmKQx/6AYDN2CzG3T4rEiBKN
         F21HCmW4tb8u4IOuXHQxtzmzKXI6hXez0EiPB8AZMBGg91BiLuU3V/uZ/CsLonQBYNiz
         UhmqdGTcnNKGVyTIQ79ACYRNIrAbaD4gc4z0TEocxzGAP1P5azewCR+qZ53TAR0fwlqp
         YOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991604; x=1781596404;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMh93vm3egRnMVo/u4zkORrzzjLIq42iI82oCTBPTEI=;
        b=p9MjUyEru+/FetsHMIPihwQZbX5Foz8VKr8mdMpTCSqSxLYDECvwmagEydg3ktPJiB
         thM8DsVkRGRitbwdHxqop9df9xCBCccxR9yBCTUAz1fC7TwFZ08e52iYGFMhJ7e8me81
         Nynr5nKrDXvq8i9j+439wHx6ulWgEZ03FYoSugEJUpBgsY6WKRBqVV0H5/fBJuar0biP
         avNtBumvvBNwSUm6oZP8M0tmL+mR5ICFstI0moeRtvb8pcS9szV/3HkosHPBJeeQerpq
         UFltedlu0mOyeLBNjPjNPzvLdGMHimKm/xccKYiwiNXi2sSOTM8Rp7nNJKE4/jFzbwZ7
         e9jw==
X-Forwarded-Encrypted: i=1; AFNElJ+euFrRbiO+vAhJH91JZX9qyd8+LuaXHynzCkD5f5df4mQ1K6gYVBeO+4VtVHEZxk0Vq0whKCs4lfHbTsWnyA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd+DrS3UWgvCrFPvs1xx8PxWOXgG0K6FxR+CC5QMrhMwqm6CnW
	JkNPbt18DvANqTV7o3Kn/SK6VMCas7gw2E+jpAnTPGttAiuqDWOsO1RljdHHZsuVxz99TEyLVBZ
	A2I2v9LpjD1DI84cQaKA4lbz6sv/7EbPfEit47MSa+6XnMEz8XUp2Qanw2rNNbXOtK9/RjQ==
X-Gm-Gg: Acq92OHEvjUgKoKujvcK+e4KVdbY74SPGkfLz8rWMUy9SfrYnhDd+p2aAGllgkPoWo1
	+VFc4438OvlKoZ6vjbhoXl2KSVTbpMHsmz8vHzoWuHeynNvqi9fmx6H5rK3XIfT1cHrlEJQZ6Yz
	wDuVSBbmlx31bpVf47zPqStnRBnEmVLbA1mzeFExoihreKD1PXNBxRNey/QXJ6gR95GZdwcotTp
	1sTuVueIh5i6O/Ai8INiZKXh4B4st4r1nUmaEyEgOQNuY29CDcZnnaJLlEPnj6SFDzmbAnpBXVW
	lY3I9b1Fy1Ok0ZSsi0TpUo9wtpc1+LqWurTl2YqwAil/Myqq8vHySpq9v/Mwkd5zmbPk9gt3m90
	qrlin975AIa9P1zs/8jvARGogVDfRIpTgMRHPbEBPVk6KIU+KodVkI77wsq0o7CKAZ3fFYR4bdT
	VqLrYoAjrVya3tTcj68yS9FeraXIfkxT/JsElcAtbyk8F+qWqsrgBR+2olSQRAv9+jiYKliSZj3
	sDcNKHQCIAh
X-Received: by 2002:a05:622a:2b49:b0:517:8c0b:66cc with SMTP id d75a77b69052e-51795be3940mr295718101cf.25.1780991604166;
        Tue, 09 Jun 2026 00:53:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2b49:b0:517:8c0b:66cc with SMTP id d75a77b69052e-51795be3940mr295717581cf.25.1780991603748;
        Tue, 09 Jun 2026 00:53:23 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:23 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:29 +0200
Subject: [PATCH v4 4/8] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-4-45712e6b22c6@oss.qualcomm.com>
References: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
In-Reply-To: <20260609-block-as-nvmem-v4-0-45712e6b22c6@oss.qualcomm.com>
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
        Saravana Kannan <saravanak@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-block@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
        netdev@vger.kernel.org, daniel@makrotopia.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=PIs/P/qC c=1 sm=1 tr=0 ts=6a27c674 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=0xOXAJtWE3glxeOP_3AA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-GUID: -osKrGnDjZbuHuiIPs4kdqIQ_Bt0Zf1d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfX93yyWZBzYHTj
 XbscqjynsMzKHfJoU/Y7Na8r4+Znsm2HVrrWHDvZ5M70xnlYIXFYOKP/GDW9qZsvEpTDxAl+1t9
 LUWD+VQ7mB1KXl5ZJPKRvM3r8f9DU7lAm6AKN/9dp0/j6Hx2dtlhpZRcbmjA47MQikQtBMGdl8v
 ECwPyQmIGS2vvqzimzLg6PELfnjRU1HdDT5jkgat2ocox/uoFD5Yp/YQqYwH4MUYEXQLsD+b7Ow
 Q9onhDFDLEBZoP5VNvZ1zaBkxw3bWJ0+hz+j1Up/+vm12do4PhoV/gcY5f8LzvSjRPZx5JQyQ0g
 PweQz2OjuZ7jiMlAhv9oBpDMkR1Bep0IGKgVSOxhjCXpT9HKt4XUJqaPqA6PbcNLa2QH2PtYpag
 FN5iBGzhJGfTGBVImW447rjzUtqgD6mjqY1sVAfVqQvvl2vzGz8PbATS6gRlgEBFMoePqwIaitd
 LjQBPf6LX99sw/Sb4Wg==
X-Proofpoint-ORIG-GUID: -osKrGnDjZbuHuiIPs4kdqIQ_Bt0Zf1d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606090073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37564-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[vger.kernel.org:query timed out,config.name:query timed out,makrotopia.org:query timed out,config.id:query timed out,config.dev:query timed out];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	RSPAMD_EMAILBL_FAIL(0.00)[daniel.makrotopia.org:query timed out,linux-wireless@vger.kernel.org:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3452E65D7E6

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig     |   9 +++++
 block/Makefile    |   1 +
 block/blk-nvmem.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+)

diff --git a/block/Kconfig b/block/Kconfig
index 15027963472d7b40e27b9097a5993c457b5b3054..0b33747e16dc33473683706f75c92bdf8b648f7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -209,6 +209,15 @@ config BLK_INLINE_ENCRYPTION_FALLBACK
 	  by falling back to the kernel crypto API when inline
 	  encryption hardware is not present.
 
+config BLK_NVMEM
+	bool "Block device NVMEM provider"
+	depends on OF
+	depends on NVMEM
+	help
+	  Allow block devices (or partitions) to act as NVMEM providers,
+	  typically used with eMMC to store MAC addresses or Wi-Fi
+	  calibration data on embedded devices.
+
 source "block/partitions/Kconfig"
 
 config BLK_PM
diff --git a/block/Makefile b/block/Makefile
index 7dce2e44276c4274c11a0a61121c83d9c43d6e0c..d7ac389e71902bc091a8800ea266190a43b3e63d 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -36,3 +36,4 @@ obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
 					   blk-crypto-sysfs.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK)	+= blk-crypto-fallback.o
 obj-$(CONFIG_BLOCK_HOLDER_DEPRECATED)	+= holder.o
+obj-$(CONFIG_BLK_NVMEM)                += blk-nvmem.o
diff --git a/block/blk-nvmem.c b/block/blk-nvmem.c
new file mode 100644
index 0000000000000000000000000000000000000000..a6e62fa98675ee9bcb9c7035a611b5a573ab9091
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,114 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include <linux/file.h>
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+#include "blk.h"
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	dev_t devt = (dev_t)(uintptr_t)priv;
+	size_t bytes_left = bytes;
+	loff_t pos = from;
+	int ret = 0;
+
+	struct file *bdev_file __free(fput) = bdev_file_open_by_dev(devt, mode, priv, NULL);
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		pgoff_t f_index = pos >> PAGE_SHIFT;
+		struct folio *folio;
+		size_t folio_off;
+		size_t to_read;
+
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			break;
+		}
+
+		folio_off = offset_in_folio(folio, pos);
+		to_read = min(bytes_left, folio_size(folio) - folio_off);
+		memcpy_from_folio(val, folio, folio_off, to_read);
+		pos += to_read;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+	return ret;
+}
+
+static int blk_nvmem_register(struct device *dev)
+{
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child)
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * the NVMEM reg_read callback uses an unsigned int offset
+	 */
+	if (bdev_nr_bytes(bdev) > UINT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return -ENODEV;
+	}
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = dev;
+	config.name = dev_name(dev);
+	config.owner = THIS_MODULE;
+	config.priv = (void *)(uintptr_t)dev->devt;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	return PTR_ERR_OR_ZERO(devm_nvmem_register(dev, &config));
+}
+
+static struct class_interface blk_nvmem_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_nvmem_register,
+};
+
+static int __init blk_nvmem_init(void)
+{
+	int ret;
+
+	ret = class_interface_register(&blk_nvmem_bus_interface);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+device_initcall(blk_nvmem_init);

-- 
2.34.1


