Return-Path: <linux-wireless+bounces-30892-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E210D299CF
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 02:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFFCB30CD398
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 01:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60223321D8;
	Fri, 16 Jan 2026 01:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQ3bBfWi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XudcuC8N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47E53346A5
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526841; cv=none; b=YRWydndT04Bkhkx1DN/QDT4WxVxEy6WogVNFwQYhIc7y+76BTAmsuVGfrqw9WK1ADMEC29c65pkcSG+H4iIlAZwMPF2i79x/M6Q8GfLGKkzJWg1Fsw8nJhqyHCmjQUo35/AbFNMcPiA2LB93IE48HRSY4P3wAyPqX6qVD3liPkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526841; c=relaxed/simple;
	bh=iFnIwv4DqDUZPjpnQ2PUoKp5hD/ezTkHIvDHAUEvG3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XB6Eq9kTwKRLh9RQF31PYKNrbyoVsYUJr73QHlmAh2Yw4dxUT343odAmA/+6C5W8cujgXleDVAoHGC8p7fDTzSJqn4dJYmVHXUFNA5d4ol1So5s0o9ikyUf/0G70i6/fH1JG6S4HzNOpL1m+ZuBFdaFiQFYZxt05kMNhDBy+7Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQ3bBfWi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XudcuC8N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FMkkTn3892781
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+evrhVA9SDMLmwpBfRxsdGyCMpIj02aFaDnB+4kVeY4=; b=XQ3bBfWipwgjqIGH
	0NkbCQg4XNggUzxt+FoQWZ57NQIHCuUGcJhO/8sUkPaXhzNtvLZWYk47qOj8Zebh
	7td6mr6RHu4CdFm94XsrSoJzTwH25k6QNQ6q4JDrkLE0ey1H79l4exE77EQRIP39
	8B1iz4MA2dF1U8dOfNRk+/xmNSHEQtlpBTOdz+KuM5xTD/QJO2CBZobJqn99gEC5
	83nMQB3O+EYAh6Mn5bfGq36IkVeMusG//CPIGQAMraQ+T5hqGG7FjUrI+FXa+Rgd
	DAKGellZGVNo0Uo/LekMtfhb3th3W7UlZFJvuKo8EaeKMBC7DGU6co6nyela4OQh
	TiD9aA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bq9b08ajv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 01:26:58 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2b6b9c1249fso209297eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:26:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768526817; x=1769131617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+evrhVA9SDMLmwpBfRxsdGyCMpIj02aFaDnB+4kVeY4=;
        b=XudcuC8NN3Ex+cY2RDOFhz0qeFxvV6G67kf13HjmQ/VTcTXoXVajhQkYzp4iumZMKK
         BljWTIWX//LSEHVygy0Bhx07MWm1FjL5r19HDBQ/LczFNaXdjTse1BbkPgOIH+J6OyIC
         OLaBNr7afaxYNz5bOUQ3w5ScBtsb/BL8gYOxaLrzXoS/ZKhcwmou+QisHuwzVloVT1kn
         AVso1Xx2HZUr85D4rNt60WqSPl/zYKiOwtm1oURpLXGu+uANQlWFx/VvSsWt+RSke2fL
         VbKiWzZt1S7iF4NhhSfxgN6QJI6VWocpBX56kNvGzjlwvpih+JXHLd8apZHn3/4nUxTz
         B6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768526817; x=1769131617;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+evrhVA9SDMLmwpBfRxsdGyCMpIj02aFaDnB+4kVeY4=;
        b=PlfLp3gF+9wEs77LYQi7Z30byn6tYbz2N4jKvrzcYTNmgYPZS2X1OCcFBwt82GRyct
         xKHTPhBWjw3MJo8NK46HzkTug++R43QTGSsMXF3wF0knUZMsoIHeXJA9vZ8PP/YjVEbU
         8fEpDF9SkLaGe1iPfncz+8ZSOHrhExPUdgkJosEbd+zQdvOUQv6WypKSrONZg45Hw4W6
         GUA3SvBZastrwrnPNHm8IFT1MvrAXGWAcs+lGDP058grCY3UyRKE+w7PKoBRdKQaoNSL
         UiTmjKe02ECgttZfu5d45tDorpc4LRcNeg3zIwZtaaltYo6oS7kX8Z1cn/nrieyq2l40
         2cuQ==
X-Gm-Message-State: AOJu0YweyKeVN9YNW5bKyVN+2m2Xh3KjlQ8kG9e39gtm8hWrSxJYgLfv
	E5+vyBfxm8VE3T1lWY5OF/NfvNhxxHHey+DHODhqyiXUzIw4zfxF7KjZq4/q2vo3Xe684SGm30Q
	/T4dbyaZpnbvGQgArcBSsMCt01ALSxW1m33fRZ15JK5dFOeKMGjfKTdPPPQ6vNcaIombvq0EwIf
	qTNQ==
X-Gm-Gg: AY/fxX4W0e3ecu7x0g+eWKInCD4di3dTNVNvNHddujKnSAg47QyS8Q6mcEWOv1vCnFs
	hHKAfSSrBD0HVUff7Cakge4yG92I9y/jxCuJ4H3b3Lw5iKb8Swn6BltovH6RrJmQxbgJ/KB2s1r
	h3xvd0Cj9TS/aHM4dvRoXu3sYG1AemvJnW6JNEY/Cgu7Z+cK5VmA5LE2y16mOXgiWHycv/8sWdH
	q898do0Nw1M0rWpD62tZWNJRnx6JR7MSXzaF5qIPSDvQ8eHkgo/MqqD50v4WLh+uFD/X6bqjEDC
	LKQhve2Qwd77V9BQIsp+se3DPV6GYsuc+EbfCCWvuf/SwMIZpYTAPHFGfKokW1hbQ4aBmE3Cjfg
	JsjKKH3Kc8/CI9zo8DBk3FdgT0WutggbpVksKl68HQBSpQ43V4dVUkfeSoYchm3qS
X-Received: by 2002:a05:7300:372c:b0:2b4:80f0:3bf3 with SMTP id 5a478bee46e88-2b6b46d359dmr1041562eec.1.1768526817477;
        Thu, 15 Jan 2026 17:26:57 -0800 (PST)
X-Received: by 2002:a05:7300:372c:b0:2b4:80f0:3bf3 with SMTP id 5a478bee46e88-2b6b46d359dmr1041537eec.1.1768526816412;
        Thu, 15 Jan 2026 17:26:56 -0800 (PST)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c91sm884104eec.9.2026.01.15.17.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:26:55 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
In-Reply-To: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
References: <20260112-ath12k-support-qcc2072-v2-0-fc8ce1e43969@oss.qualcomm.com>
Subject: Re: [PATCH ath-next v2 00/18] wifi: ath12k: add support for
 QCC2072
Message-Id: <176852681535.1143034.7459833525580352635.b4-ty@oss.qualcomm.com>
Date: Thu, 15 Jan 2026 17:26:55 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: gHtXSpM5TIleadNzm_R1IG2TrJYfufNl
X-Proofpoint-ORIG-GUID: gHtXSpM5TIleadNzm_R1IG2TrJYfufNl
X-Authority-Analysis: v=2.4 cv=TcmbdBQh c=1 sm=1 tr=0 ts=696993e2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=pnWoMBQVS5ShONBjoI8A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDAxMCBTYWx0ZWRfXyfwyvcxRmOE4
 9jmxwBc72J5Yn83jS+B+ghrJG2LRk6DrQP/AjAoN17ksmi3AHDJUvSjs7dCQkQCgM47+WuOtezM
 Pw1+rsMvOdy5Q9EwfKA7y2BOYWTp+XsZmEhIfopspFqN4dBCxhPjMD/iOiM3adMoEioEiVlhbrh
 qUJPeirnzbAeUIHGpNLgvNfn+0cvFNvsViRE/BACIbN8vEL91nlA5N5N40ZNNHQ8Xv+Z7il5Gzn
 LywLXqe2CuuUAKyUsaucILTzn46CfS0B3yIe2Ajo01jeWjF/fxqUYyigeU/TnqMbC9F1FXjYnR5
 6BG+zXez6/GNqhMAR2OGtqsB4xBSS0lxS/4X44/8b3bLFhEQd5DXL+WRta0xbyHxDKmRuR0Lnys
 lpvn4AGj1EwFXjYy20iShdMzhU+icBp9BYEHdk7McMSwVcSMJSXbpD/NM+AAEGQQreu6wGkTBSd
 TAmNtUzc/WK82p2Oj4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_01,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601160010


On Mon, 12 Jan 2026 15:36:20 +0800, Baochen Qiang wrote:
> QCC2072 is a PCI based device that is very much like WCN7850, the major
> difference is that QCC2072 has only one phy hence does not support DBS.
> Due to such similarity, lots of existing WCN7850 code can be leveraged.
> While to handle the difference, separate operation is added, necessary
> configuration is changed.
> 
> Overview:
> - The first 6 patches refactor/fix current code base to prepare for QCC2072
>   support.
> - Patches [7,8/18] add hardware registers and parameters for QCC2072.
> - Patches [9,10/18] add support for new QMI memory type, new firmware
>   download etc, these are specific to QCC2072 hence necessary configs are
>   added to make sure other chips are not affected.
> - Patches [11,12/18] add new callbacks for QCC2072. These callbacks are
>   actually taken from WCN7850, with modifications due to the different
>   HAL descriptors.
> - Patches [13,14/18] add 32 bits variants for QCC2072 REO CMD/status ring
>   handling, as existing 64 bits functions don't work with QCC2072.
> - Patches [15,16/18] contains changes required by QCC2072, but those
>   changes are made common to all chips. They are not expected to cause
>   any regression.
> - Patch [17/18] add QRTR node id register such that QCC2072 can work when
>   firmware-2.bin image is used.
> - The last patch enables QCC2072 support.
> 
> [...]

Applied, thanks!

[01/18] wifi: ath12k: refactor PCI window register access
        commit: 7a6b6386deb71908181adc26c6ddbe9bc6cef169
[02/18] wifi: ath12k: refactor REO CMD ring handling
        commit: 9615a6727e9d836e60dd4c7442bc8c16f0382203
[03/18] wifi: ath12k: refactor REO status ring handling
        commit: 1f165022d5f06a420a2257d7c38e3d19e16ef071
[04/18] wifi: ath12k: fix preferred hardware mode calculation
        commit: 7f852de0003219c431a6f2ffd951fd82a4673660
[05/18] wifi: ath12k: refactor 320 MHz bandwidth support parsing
        commit: 6281d4f4df228b3588eeb3186d97e195fed07d35
[06/18] wifi: ath12k: fix mac phy capability parsing
        commit: b5151c9b6e3a347416a4b4b55fc00195526d8771
[07/18] wifi: ath12k: add hardware registers for QCC2072
        commit: 089e0e746d598b5d305dae366e022dd90e1bd4f2
[08/18] wifi: ath12k: add hardware parameters for QCC2072
        commit: 12048e2c052b1992857fb71a86d13e0e5b65e5da
[09/18] wifi: ath12k: support LPASS_SHARED target memory type
        commit: 68cc3ac88118ee9ab797aadf15dd30a8145b4be7
[10/18] wifi: ath12k: support downloading auxiliary ucode image for QCC2072
        commit: b065ccf4193ed5f0c224b53fc2cb829a0e2b701e
[11/18] wifi: ath12k: add HAL descriptor and ops for QCC2072
        commit: 28badc78142e4750136ae51da474cdc150a8b3ff
[12/18] wifi: ath12k: add hardware ops support for QCC2072
        commit: 023ace9f9232d43137f346d908996a6fee4de70a
[13/18] wifi: ath12k: handle REO CMD ring for QCC2072
        commit: b7ffeb0f62fddc5f21c6ff610d28e08247b6b9b5
[14/18] wifi: ath12k: handle REO status ring for QCC2072
        commit: 37b34a1c545aa2ab94f3ce1aceec3f00d6f8e039
[15/18] wifi: ath12k: limit number of channels per WMI command
        commit: d518b2d601acffdea6d50ff951cb1344a4807976
[16/18] wifi: ath12k: send peer meta data version to firmware
        commit: d6c5d412f60007e23bebc4eba1de2530a7651962
[17/18] wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072
        commit: 853deed04be384fde9138e0442630b5bddf2e418
[18/18] wifi: ath12k: enable QCC2072 support
        commit: d8e1f4a193101a72235416f189b01131a57e26e9

Best regards,
-- 
Jeff Johnson <jeff.johnson@oss.qualcomm.com>


