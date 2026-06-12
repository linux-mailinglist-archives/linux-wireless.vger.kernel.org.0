Return-Path: <linux-wireless+bounces-37734-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QQzaEJQJLGptKAQAu9opvQ
	(envelope-from <linux-wireless+bounces-37734-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:28:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CED679D10
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 15:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=UXPv4vG6;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="Wd/koqgr";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37734-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37734-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 86EC332210DD
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 13:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DDF3FBB69;
	Fri, 12 Jun 2026 13:21:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172533F54C3
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781270478; cv=none; b=Tw4aZYcazivZfmDistyaBjiXmiD+zx26NXAFh+8tM4Qh17AXGwbzHUEe8vLHB5HpjaNllS4oFV3B/q5F7M5Evu1eCeILsZyRGbi1trZAnS+/ZNV0CJq7mj/eZpJruqdFLTrGMQhipRBWaA6PWgHEb9XFGEtZFpRHHSYkUuBJZ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781270478; c=relaxed/simple;
	bh=ypWJcxTFcoficSRoC35+QGJSmgp4rbapgzdY+p1eZdM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ltta69xrwnNwbIKyVLZDzw60NBP5QWQxJDHd0+MVOXI9JK+tVz6qKQ3BgvlZ6XNp4yhakVdyH8DhXVP+sN/e0+nDLXGFzgVR5URe9QhIVE28IV9wI9bZpBL1SQBF3QrrxWPhTmlaPAdX8oAAqrgQUBf1avxnEvS+cIhzbKCDbng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UXPv4vG6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wd/koqgr; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65CCiooH3748038
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=; b=UXPv4vG6UW7DSy/F
	p+Csfp/Xgj/fdj7Pl6lFTvxuCHZpG0BaDgnTcFWCTGWnsaF+q2JOb7HBj2s4kEQN
	oH32LJ99f+p2UOBZiLVPMnK6iDIvSd61kP0rpPye1sddlUGszwiKi5nGtjCJ2ocZ
	TR+nXNy5DBjEurEck0cr/aWBwyurge0jXsiVSa0JtOQWb9yS2xeve8q1Knt5HNyb
	gdyyNFtMzW5z0jZjnOGq6k1kAOUcAhnkOuXe1MYVq9uBItznisQMzVyRr6rAVr97
	HiQdyX0/PDdKK5KNmserwSqyFnpAZ+xpJ3L2k7Iu/s07I0JLuHq+ETwZecESy+ys
	KHAbTA==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er76ehy92-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 13:21:14 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7e6f7f4e47eso2038960a34.1
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781270474; x=1781875274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=;
        b=Wd/koqgrut35vc1ucCYTB3UNHmX2QaDsAFKVEIZLufjQLQje3ePK55q4LgRpBNtMqe
         wSWfz30jHvxjsrzABi5PunKRwFjCgspn17O7qIqpMcx5Xa/Vv3SYBtfv+cEEnBHGb+gj
         FuTaYwXJHsTGKUSWGNbjtoMKcWnA3wb1NPw661hRoF0fWt9mKMkjA8ASxTF3jIeUIsAW
         Fk9FOqxT4RGkwIp0b8HE65IpeEUaV2+/fUcpwxm+WMYm6+iV6lR0bbNJNeNvGdhPLreD
         q0y1j1NB2418aewjlDB0JYERB6EMecAdtM7IVffZbzgcfIIv0hIBdrmCfIA2B+u0AChV
         98Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270474; x=1781875274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WA3j5D2UTvJeMm0sKJI/fgSeryn3GsGPtg1BAGqRz9o=;
        b=RE2d5T52uBSRQlHP/2COzt5YeSnqOHqbD28MdP8ZLfZr83R2D+Bo8MNa5Kc9zJL7tS
         RU8cNKvIMI6qZvdkIfKZP0rfiyW1HPqJ+GzDALKFqOn1CwRZ3ZMtE69Hiy3HU6ogExf6
         zfXkrckb0VZY/DHjuOj57T7dDQDuSrI8sHAIaRxmkDj9jfHb0x7UHW4vNe9FVlNwR7Wm
         KY2rHsmMgQRFLv22cq7wNW/rOFsGVvJq8JQVG5MhTupBJYvKB+BTsTSHLT/dgFU5zxuT
         rra1ybryC/90dQ9Xdg+x3Z5ijGP+TFDgEYMPX2ucQfVs/uRFBInBKNkbZihbTcWgemXM
         5Kqw==
X-Forwarded-Encrypted: i=1; AFNElJ8+6ibhBcrcRiTIytH4SvYNyDQxFWl+4pWmNNVip6ETSU4IhWm6dIFmCh00TvYysgZ1fBYqxRGnpWDbf38kug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFwP9NoCyFySnnudu9oblTV7ZfjNR/CZkIyOsPCPZHGCQ6hCgQ
	NxT04OeekudKf8l6wVZH2c++Zc+/ZLJit0NZUGHgKySCXl87zygmkfWMNiDNB835u58L9EJKBcV
	9qPZAoX9Q2a7y56L5eEuo0z468RA3+b4SsyPEgLsD2FdI34Y1ICc5SBnpvIrkpq5lLWzg9g==
X-Gm-Gg: Acq92OHi690DmDKkHQ6VfG6W+XiRXy3Zrr+EAO77uZcZknOkf1Uw8X3nkFUkc7BO609
	H+86TWasbePTitXuGuKFbe+N9MIyuu1XfLRBQ8qWNihprv0eoac8q8HspIz3i+vwqLwgIZn+Wk6
	KdB7O+3tvv8muP4howM01cVekNZ7b/z/m1Vje0QBnR2kwGAcoKPXwKegofM5txZ6NXQYU0yW3fe
	v7BYmJIjnVsuxEvN9xmV/IaDZbDxU0kebRcJhxCiOQSRgAUsYw4yckVujNA99TSodJAxdYwgnO/
	xLGquSe9eJ61ASX343z4wYAzOH2KighJfeVKMhMdUTPLe4KozKxrEy/pkJzFZSAAJ31zVl/7AZs
	LsEfr1INj0QuAxwXtuTGzTEr60PHpcMsKvFDQk9jS2JNPlq8O9AlD9n9txsW3SYA8dvOoamoAMw
	Stj+Ns7TR9J1DuYlXLS7IICDygL11dVjdcHGbr+5rtbxs49shEzI1IYQWZsau9TBvHu3NP+TQb
X-Received: by 2002:a05:6820:2108:b0:69e:98c0:a9a with SMTP id 006d021491bc7-69edc62d4fbmr1893551eaf.12.1781270474207;
        Fri, 12 Jun 2026 06:21:14 -0700 (PDT)
X-Received: by 2002:a05:6820:2108:b0:69e:98c0:a9a with SMTP id 006d021491bc7-69edc62d4fbmr1893500eaf.12.1781270473640;
        Fri, 12 Jun 2026 06:21:13 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:3510:32cf:db6:13c6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfe6f9c46f0sm59986866b.1.2026.06.12.06.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:21:12 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 12 Jun 2026 15:20:57 +0200
Subject: [PATCH v5 5/9] block: implement NVMEM provider
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260612-block-as-nvmem-v5-5-95e0b30fff90@oss.qualcomm.com>
References: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
In-Reply-To: <20260612-block-as-nvmem-v5-0-95e0b30fff90@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=O94Jeh9W c=1 sm=1 tr=0 ts=6a2c07cb cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VT4XjZGOAAAA:8
 a=EUspDBNiAAAA:8 a=QS6QONgytJYYblx7mpIA:9 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-ORIG-GUID: mO-LDrIS6p4d9Wt71rQkWSG65UZu2rdy
X-Proofpoint-GUID: mO-LDrIS6p4d9Wt71rQkWSG65UZu2rdy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfX5DVGc0DioCnV
 DsqN7iMRwKHisfU5LtpjCX3uzY0MxClbuaUaRNap80ZqsQxnMWmVELvGb+B+j3VzSN3aFghyHeK
 TFCOuSXBd+/icH1/wESQnE0mVXuIRXdTTM5IQM6/qz6wfvn6YnUO3TIpSh51Try7RxCcW3Xm52D
 jcs159lkjYOs4kAW+hUmYNqzIoKDlAWaUplUVS3ISkWrUz2xUaoiOxS1WpoJZn1QK0VxGMZLH8Y
 CWNCE0n18ATfLLe4guh7jug7cpcEcihDFrADcFgiVDgt8JQZMx/Vev2Rbudaj18sZxSMlIwpaoJ
 lz1nWm2sbbnZ/KJLIcA3Nhz5kQ0JS9alitL0FZ95MH9r4xp0JApk+KSqtYIhbGq7f/wfEGztQzA
 whP+qaRKLaUC0bhALDfC3FeOKoTnOG6oKnrkB8jAHOklVQhPKTPXg9I9EJwXw3BbCBwMuGUvXmU
 EBIj0Pk3IJPQKsbXcmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDEyMiBTYWx0ZWRfXwaxDGNQ5hc8m
 vxM+Gbla6etzgwNEAPS1q5OFVLPeGtvVvK+x5UE0jyNP9fsLsVrYPH+UiOoqJ6X2hzZo5qVaB3b
 rJn8LWNt24Llg3FsCK4awGje7rUIcV0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120122
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37734-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.name:url,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,vger.kernel.org:from_smtp,config.dev:url,qualcomm.com:dkim,qualcomm.com:email,makrotopia.org:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,config.id:url];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: A9CED679D10

From: Daniel Golle <daniel@makrotopia.org>

On embedded devices using an eMMC it is common that one or more partitions
on the eMMC are used to store MAC addresses and Wi-Fi calibration EEPROM
data. Allow referencing the partition in device tree for the kernel and
Wi-Fi drivers accessing it via the NVMEM layer.

For now, NVMEM is only registered for the whole disk block device, as the
OF node is currently only associated to it.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Co-developed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 block/Kconfig             |   9 ++++
 block/Makefile            |   1 +
 block/blk-nvmem.c         | 109 ++++++++++++++++++++++++++++++++++++++++++++++
 block/blk.h               |   8 ++++
 block/genhd.c             |   4 ++
 include/linux/blk_types.h |   3 ++
 include/linux/blkdev.h    |   1 +
 7 files changed, 135 insertions(+)

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
index 0000000000000000000000000000000000000000..c005f059d9fe56242ebaef9905673dff902b5686
--- /dev/null
+++ b/block/blk-nvmem.c
@@ -0,0 +1,109 @@
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
+static int blk_nvmem_reg_read(void *priv, unsigned int from, void *val, size_t bytes)
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
+void blk_nvmem_add(struct block_device *bdev)
+{
+	struct device *dev = &bdev->bd_device;
+	struct nvmem_config config = {};
+
+	/* skip devices which do not have a device tree node */
+	if (!dev_of_node(dev))
+		return;
+
+	/* skip devices without an nvmem layout defined */
+	struct device_node *child __free(device_node) =
+		of_get_child_by_name(dev_of_node(dev), "nvmem-layout");
+	if (!child)
+		return;
+
+	/*
+	 * skip block device too large to be represented as NVMEM devices,
+	 * the NVMEM reg_read callback uses an unsigned int offset
+	 */
+	if (bdev_nr_bytes(bdev) > UINT_MAX) {
+		dev_warn(dev, "block device too large to be an NVMEM provider\n");
+		return;
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
+	bdev->bd_nvmem = nvmem_register(&config);
+	if (IS_ERR(bdev->bd_nvmem)) {
+		dev_err_probe(dev, PTR_ERR(bdev->bd_nvmem),
+			      "Failed to register NVMEM device\n");
+		bdev->bd_nvmem = NULL;
+	}
+}
+
+void blk_nvmem_del(struct block_device *bdev)
+{
+	if (bdev->bd_nvmem)
+		nvmem_unregister(bdev->bd_nvmem);
+
+	bdev->bd_nvmem = NULL;
+}
diff --git a/block/blk.h b/block/blk.h
index ec4674cdf2ead4fd259ff5fc42401f591e684ee9..cd3c7ca723391c40be56f1dd4810e641b7c8a2b3 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -757,4 +757,12 @@ static inline void blk_debugfs_unlock(struct request_queue *q,
 	memalloc_noio_restore(memflags);
 }
 
+#ifdef CONFIG_BLK_NVMEM
+void blk_nvmem_add(struct block_device *bdev);
+void blk_nvmem_del(struct block_device *bdev);
+#else
+static inline void blk_nvmem_add(struct block_device *bdev) {}
+static inline void blk_nvmem_del(struct block_device *bdev) {}
+#endif
+
 #endif /* BLK_INTERNAL_H */
diff --git a/block/genhd.c b/block/genhd.c
index 7d6854fd28e95ae9134309679a7c6a937f5b7db8..1b2382de6fb30c1e5f60f45c04dc03ed3bf5d5f2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -421,6 +421,8 @@ static void add_disk_final(struct gendisk *disk)
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
+
+		blk_nvmem_add(disk->part0);
 	}
 
 	blk_apply_bdi_limits(disk->bdi, &disk->queue->limits);
@@ -704,6 +706,8 @@ static void __del_gendisk(struct gendisk *disk)
 
 	disk_del_events(disk);
 
+	blk_nvmem_del(disk->part0);
+
 	/*
 	 * Prevent new openers by unlinked the bdev inode.
 	 */
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c09e0ceaac41ba59e86fb0c4efc64..ace6f59b860d0813665b2f62a1c03a1f4be94059 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -73,6 +73,9 @@ struct block_device {
 	int			bd_writers;
 #ifdef CONFIG_SECURITY
 	void			*bd_security;
+#endif
+#ifdef CONFIG_BLK_NVMEM
+	struct nvmem_device	*bd_nvmem;
 #endif
 	/*
 	 * keep this out-of-line as it's both big and not needed in the fast
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 890128cdea1ce66863c5baa36f3b336ec4550807..f15d2b5bf9e4fd2368b8a70416a978e22c0d4333 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -30,6 +30,7 @@
 
 struct module;
 struct request_queue;
+struct nvmem_device;
 struct elevator_queue;
 struct blk_trace;
 struct request;

-- 
2.34.1


