Return-Path: <linux-wireless+bounces-36072-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0L28KGmv/GnlSgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36072-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:27:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 177304EB055
	for <lists+linux-wireless@lfdr.de>; Thu, 07 May 2026 17:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A35030387B4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2026 15:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537F46AED3;
	Thu,  7 May 2026 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NAq1Uehi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHe6yPKw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0E4611C2
	for <linux-wireless@vger.kernel.org>; Thu,  7 May 2026 15:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778167502; cv=none; b=GPVxwjXAKHYufVv5XBFcjUSkXC3nJnK5OIoz9IE0mFWUwoR67dvkE80GadMULK+mnLkRYOueWCZYgBfXQ/Vj3tYBCJ4kh7uX9sq/rA/WpwNGhzQIcUGHDcBGxqF2MADSNY7PdrlpnXhjmqQhV98YWjP56/TLzeX61Etryqi7Lgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778167502; c=relaxed/simple;
	bh=RM1D8OBCAOaFvaWlmG/BF9szeghRU3UqO9TQZXq+eUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gw3gG+SxThdSxj5sLpy5Lq+eokbe+y4myCQsLl17E/aV+K1KJElBRP7v7eQJEHMfzElz1nkudNUrM5HowJ9CLqjMHTcJuU+Vs9ABBxHqCuMK5HR+lrjVv5sF3t5AXapISi0aUMpEh21wkJJ+X6GSBYJHHUJB8nVaKDMWEMe5Kks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NAq1Uehi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YHe6yPKw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 647BDt6b3924161
	for <linux-wireless@vger.kernel.org>; Thu, 7 May 2026 15:24:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Nv8kxkOoxWLas1bms0TwZMzIY1MQ08eWrRceN3ebjas=; b=NAq1UehidFfBq59k
	bok3F7/2xbm5kG0Q/N0IZnvVvoc0zJaPtR6FO1GRkpRqISb2G2gt7NLJLaw1HTkb
	4AthaN8kOQGdBpz58AvMAMkhSH384aFRRKr2OPPsHJEbvjiqg8URGK0xGFOp/tZX
	UWhLYSnGBQHuHodbYrgbMi2zABK16FD+y/GTaxvtaBsv8CLi7ZTBR1ipKcsICqsd
	bILYnjygMyUB0h6tr0RQjlV/C9eDaWTio2dM5KY6I0KfMJdt4PmKeV4ni9wXI8In
	MxYvhSh1pSddXjSUZ1alq+OqN7eU143mCSJFgFQNrV6M0c/u38XavhR2yXezu1R8
	JseW2A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0c88bs3k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 15:24:56 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-56fa1c1ae6fso2273842e0c.2
        for <linux-wireless@vger.kernel.org>; Thu, 07 May 2026 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778167495; x=1778772295; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nv8kxkOoxWLas1bms0TwZMzIY1MQ08eWrRceN3ebjas=;
        b=YHe6yPKw6Q9d9sd4iPdkksRJuQvqpiUpWKn2sh0WOgCX8wt+htByAMTlvei3k6DII2
         ZPBgkquQ94libdcaABL8D7zsCAbO2DvT0VFt8IgVjGGjLJHqIZvJEyluyD+aXQoxJ7M/
         HXEZbtqGGI0edAkkeLb0FSUrWYkTK2Khvflr1d2Rf/Faan5I/FRik4Ex7KmucutB/CxR
         O2c5R0pzwg46fnkdTssOuXWGZ/fUVgGkB7WUH8AWrjrIu8Kff5Wn8AvWvh3iE5dD0Pb+
         yV+MjXs9+2WsllBBfv8ksIh6Hb49SMjcvLILn0tWTju2qPk2qXBQmlQCHL9/kp/EAPM2
         PK3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778167495; x=1778772295;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Nv8kxkOoxWLas1bms0TwZMzIY1MQ08eWrRceN3ebjas=;
        b=i0B2dR1gcizR/v81d2D8uw2dsKB0r33WOso20JLYHa/xXETlSrqCnWUb5SLrjyLgcK
         MhKKMDMbPE9q+AePnoWqL6LIbi5WLwJ0yBsS8a8Q8RUekHsQVzR/M0LQixn4hgFKA33a
         +HNUhrAAFhOeySbSxjsRf6XOQHITPR5yVY0rq/MUwsbFF9RTgk5SAAVrbYm0IrDuaTev
         pqbmo/YTZDmznHe42pL7jUZ+6BKnEIQJ+5EGi1xbImZjhAPFZgeXXaxEMXcDbcTgqaeL
         nccdpkzw2EcnzquE8HDkRQIX1oiBf+4dPKxnqULrlq0f/WoiNHcv3dFmxsYcJRKVZwC4
         Zmrg==
X-Forwarded-Encrypted: i=1; AFNElJ9dkpoB8AwXltg4rFu07K3vLvQU/RIRLFcRQUBX/2TrzWPDe95BsTrxrMMBGkak9BYrfbHPoXa/CWAUicpNnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7iCRbeBshgmEyUkidgN/OpSjefE1bHhx7F3Vi5ngIs9NYvQM
	g4SST33xwlkVOinRPd/nqADGBU//BANegCtcRI9OJwJ02bYkArAByQf/VRBGEjpDOd155vsVQj+
	g2A3URRYmG34eRek7M8Ue13X9OiHwZgeS/MmnbH7CVccNf83DTLddSMr/zISzIFgEQacImA==
X-Gm-Gg: AeBDiev64QaJi7DQrFRFkAZfNwtrlw4i07rlzt9IG1Y9gDrfrZu9MaAj6IN4wGkoNuU
	/EdxTr+rSMUZmK1ocwflpfomGRroEA6tjcZhBjG7bg6p+umkvU5cOPU0IFqPlVRUrBbv1IzJBqn
	cxuVIxtkgwTwQb+ND0/Lhqk8tT1LRDA7Y+8YYMRBbFVQ0MM07mWU8Pzt1ac2jdhrGqrpfUoLN3o
	+BFnhx5qkJMjFKqsq+AfxAV9+3WmjMVPKyCqirC53XlebcuTC6kS+X5Mhb9MLirQzDkt8nrzK9e
	lglHbV7A9hEYao8NcSitAWosCisweIEF06Xe3SzbO4MBYTqbPLeielSkh1bSPtE6UCTgs229y92
	skInDDexXIcDET0P7yI41poU30PA4hvTlEsM1tyLw4VXGnloiW3doCSfYzFX458oSidcAdLPkNp
	zlAAmJzbjyBOpM9inb45WNVQ7fB9k=
X-Received: by 2002:a05:6122:9001:b0:56d:8ded:796c with SMTP id 71dfb90a1353d-575596399bcmr5099016e0c.4.1778167495036;
        Thu, 07 May 2026 08:24:55 -0700 (PDT)
X-Received: by 2002:a05:6122:9001:b0:56d:8ded:796c with SMTP id 71dfb90a1353d-575596399bcmr5098940e0c.4.1778167494472;
        Thu, 07 May 2026 08:24:54 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:b16a:3475:ec42:bcfa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bca583dd7e4sm240966b.58.2026.05.07.08.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:24:53 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 07 May 2026 17:24:39 +0200
Subject: [PATCH v2 4/8] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-block-as-nvmem-v2-4-bf17edd5134e@oss.qualcomm.com>
References: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
In-Reply-To: <20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: IFxngvyvpi3hZqLp5f8xl4nR7CV9cMyg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE1NCBTYWx0ZWRfX+xvx4EtB0TxO
 F+1cGvF9wtE3cGZn8dYlrhWbHp8ekKksT9twyY0kKjx5Q7mVND3VGLpvnocKPIVQGGsKHvRWufb
 RNLai8cCivNz71TetkEOlxHmiPzdKJV0NXtcRU1qJEZ7Z+Ls+aCWuX2uUGIz80HZC1fZe7HShsC
 zqAw2PepvpBQEP7zi1zo3BR2Y2i07vtQH3q/hFcmn3DIKY0fCiwcwbpdVBNKCs2syCnqImJqtKo
 J4XDeFHQmugDYFIgbYDEdpssm7AP/SGQP5/O3Prx40M29ftmZHa1zbQSWCI4HaeOdbz1f9a0Eqk
 Q4h+RykAW3ex02heR8n/XQgDXxQHm6uPgsUG5u79dqb3asfwuh17vgnLmmnWd6PuW4zSa2YFsas
 I6dIu08jV9qgWQan4vU3WzbC+0xTTzlYZECUbeoYNmr/bC8oiuKbeADvNwmrBdcFc3aXI+nHRWN
 lZ2A+iFxlZfw6fEG7jA==
X-Proofpoint-GUID: IFxngvyvpi3hZqLp5f8xl4nR7CV9cMyg
X-Authority-Analysis: v=2.4 cv=X8Zi7mTe c=1 sm=1 tr=0 ts=69fcaec8 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=71DuYGxFrHUPmPLwgxgA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070154
X-Rspamd-Queue-Id: 177304EB055
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36072-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.name:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,config.dev:url];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

To safely defer the freeing of the provider private data until all
consumers have released their cells, a nvmem_dev() accessor is added to
the NVMEM core to expose the struct device embedded in struct nvmem_device.
This allows registering a devm action on the nvmem device itself, ensuring
the private data outlives any active cell references.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig                  |   9 ++
 block/Makefile                 |   1 +
 block/blk-nvmem.c              | 188 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvmem/core.c           |  13 +++
 include/linux/nvmem-consumer.h |   6 ++
 5 files changed, 217 insertions(+)

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
index 0000000000000000000000000000000000000000..96c0ffc51b1862a75644f3f94add35d59577d86b
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * block device NVMEM provider
+ *
+ * Copyright (c) 2024 Daniel Golle <daniel@makrotopia.org>
+ *
+ * Useful on devices using a partition on an eMMC for MAC addresses or
+ * Wi-Fi calibration EEPROM data.
+ */
+
+#include "blk.h"
+#include <linux/nvmem-provider.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/of.h>
+#include <linux/pagemap.h>
+#include <linux/property.h>
+
+static void blk_nvmem_free(void *data)
+{
+	kfree(data);
+}
+
+/* List of all NVMEM devices */
+static LIST_HEAD(nvmem_devices);
+static DEFINE_MUTEX(devices_mutex);
+
+struct blk_nvmem {
+	struct nvmem_device	*nvmem;
+	dev_t			devt;
+	bool			removed;
+	struct list_head	list;
+};
+
+static int blk_nvmem_reg_read(void *priv, unsigned int from,
+			      void *val, size_t bytes)
+{
+	blk_mode_t mode = BLK_OPEN_READ | BLK_OPEN_RESTRICT_WRITES;
+	unsigned long offs = from & ~PAGE_MASK, to_read;
+	pgoff_t f_index = from >> PAGE_SHIFT;
+	struct blk_nvmem *bnv = priv;
+	size_t bytes_left = bytes;
+	struct file *bdev_file;
+	struct folio *folio;
+	void *p;
+	int ret = 0;
+
+	if (bnv->removed)
+		return -ENODEV;
+
+	bdev_file = bdev_file_open_by_dev(bnv->devt, mode, priv, NULL);
+	if (!bdev_file)
+		return -ENODEV;
+
+	if (IS_ERR(bdev_file))
+		return PTR_ERR(bdev_file);
+
+	while (bytes_left) {
+		folio = read_mapping_folio(bdev_file->f_mapping, f_index++, NULL);
+		if (IS_ERR(folio)) {
+			ret = PTR_ERR(folio);
+			goto err_release_bdev;
+		}
+		to_read = min_t(unsigned long, bytes_left, PAGE_SIZE - offs);
+		p = folio_address(folio) + offset_in_folio(folio, offs);
+		memcpy(val, p, to_read);
+		offs = 0;
+		bytes_left -= to_read;
+		val += to_read;
+		folio_put(folio);
+	}
+
+err_release_bdev:
+	fput(bdev_file);
+
+	return ret;
+}
+
+static int blk_nvmem_register(struct device *dev)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct block_device *bdev = dev_to_bdev(dev);
+	struct nvmem_config config = {};
+	struct blk_nvmem *bnv;
+
+	/* skip devices which do not have a device tree node */
+	if (!np)
+		return 0;
+
+	/* skip devices without an nvmem layout defined */
+	if (!of_get_child_by_name(np, "nvmem-layout"))
+		return 0;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices
+	 * which are using an 'int' as address
+	 */
+	if (bdev_nr_bytes(bdev) > INT_MAX)
+		return -EFBIG;
+
+	bnv = kzalloc_obj(*bnv);
+	if (!bnv)
+		return -ENOMEM;
+
+	config.id = NVMEM_DEVID_NONE;
+	config.dev = &bdev->bd_device;
+	config.name = dev_name(&bdev->bd_device);
+	config.owner = THIS_MODULE;
+	config.priv = bnv;
+	config.reg_read = blk_nvmem_reg_read;
+	config.size = bdev_nr_bytes(bdev);
+	config.word_size = 1;
+	config.stride = 1;
+	config.read_only = true;
+	config.root_only = true;
+	config.ignore_wp = true;
+	config.of_node = to_of_node(dev->fwnode);
+
+	bnv->devt = bdev->bd_device.devt;
+	bnv->nvmem = nvmem_register(&config);
+	if (IS_ERR(bnv->nvmem)) {
+		dev_err_probe(&bdev->bd_device, PTR_ERR(bnv->nvmem),
+			      "Failed to register NVMEM device\n");
+
+		kfree(bnv);
+		return PTR_ERR(bnv->nvmem);
+	}
+
+	/*
+	 * Free bnv only when the nvmem device is fully released (i.e. when
+	 * its kref hits zero), not at unregister time. This prevents a
+	 * use-after-free if a consumer still holds an nvmem_cell reference
+	 * when the block device is removed: nvmem_unregister() only does a
+	 * kref_put(), so reg_read could still be called with bnv as priv
+	 * until the last consumer drops its cell.
+	 */
+	if (devm_add_action(nvmem_dev(bnv->nvmem), blk_nvmem_free, bnv)) {
+		nvmem_unregister(bnv->nvmem);
+		kfree(bnv);
+		return -ENOMEM;
+	}
+
+	mutex_lock(&devices_mutex);
+	list_add_tail(&bnv->list, &nvmem_devices);
+	mutex_unlock(&devices_mutex);
+
+	return 0;
+}
+
+static void blk_nvmem_unregister(struct device *dev)
+{
+	struct blk_nvmem *bnv_c, *bnv = NULL;
+
+	mutex_lock(&devices_mutex);
+	list_for_each_entry(bnv_c, &nvmem_devices, list) {
+		if (bnv_c->devt == dev_to_bdev(dev)->bd_device.devt) {
+			bnv = bnv_c;
+			break;
+		}
+	}
+
+	if (!bnv) {
+		mutex_unlock(&devices_mutex);
+		return;
+	}
+
+	list_del(&bnv->list);
+	mutex_unlock(&devices_mutex);
+	bnv->removed = true;
+	nvmem_unregister(bnv->nvmem);
+}
+
+static struct class_interface blk_nvmem_bus_interface __refdata = {
+	.class = &block_class,
+	.add_dev = &blk_nvmem_register,
+	.remove_dev = &blk_nvmem_unregister,
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
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 311cb2e5a5c02d2c6979d7c9bbb7f94abdfbdad1..ee3481229c20b3063c86d0dd66aabbf6b5e29169 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -2154,6 +2154,19 @@ const char *nvmem_dev_name(struct nvmem_device *nvmem)
 }
 EXPORT_SYMBOL_GPL(nvmem_dev_name);
 
+/**
+ * nvmem_dev() - Get the struct device of a given nvmem device.
+ *
+ * @nvmem: nvmem device.
+ *
+ * Return: pointer to the struct device of the nvmem device.
+ */
+struct device *nvmem_dev(struct nvmem_device *nvmem)
+{
+	return &nvmem->dev;
+}
+EXPORT_SYMBOL_GPL(nvmem_dev);
+
 /**
  * nvmem_dev_size() - Get the size of a given nvmem device.
  *
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58dfa26636d2804fcc7e0bc4a875ee73dae..ce387c89dc8e4bc1241f3b6f36be8c6c95e282ed 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -82,6 +82,7 @@ int nvmem_device_cell_write(struct nvmem_device *nvmem,
 
 const char *nvmem_dev_name(struct nvmem_device *nvmem);
 size_t nvmem_dev_size(struct nvmem_device *nvmem);
+struct device *nvmem_dev(struct nvmem_device *nvmem);
 
 void nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries,
 			    size_t nentries);
@@ -220,6 +221,11 @@ static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 	return NULL;
 }
 
+static inline struct device *nvmem_dev(struct nvmem_device *nvmem)
+{
+	return NULL;
+}
+
 static inline void
 nvmem_add_cell_lookups(struct nvmem_cell_lookup *entries, size_t nentries) {}
 static inline void

-- 
2.34.1


