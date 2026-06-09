Return-Path: <linux-wireless+bounces-37565-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hk/lJcjIJ2qh2AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37565-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 10:03:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C2C65D859
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 10:03:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=QtSHxEJ0;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=FbUmFrut;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37565-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37565-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8D0F30CA72A
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 07:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FE43F1ABF;
	Tue,  9 Jun 2026 07:53:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B953E832F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 07:53:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991614; cv=none; b=kibtTaUO+n+bLkPEIzVvbH9nL3rwLLYwmdaN1dRlEC7kfnlxSj9z0G110zT25WNTX4eVoKkHPsfKmwtkGsV97K+FpDo1t5FIaZGzhzOdsuQTKREc821vF3A1V3610jd3BA1rzOwRKKPOcD3JKj049+aloMNIU1X6K7RY8ueM8cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991614; c=relaxed/simple;
	bh=DhpKvk+qKi33tdqHXBdyBn+qHlFJWo7f2LRbmA/QYF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rZv40DkIsXfc9dq2H8oW6HnPDwKjhcB5miz1Tjiqc0hIZpplMzTaRK0kPgSrh/hlyK9UoguKbmjXxUV46whRVYJB3Ks/q+HSHdLpqYXhUKv3EYSmZfK4hyMu5aE/cZZLcILXA1+VucpWHDZ+9oca9oYf/ntZnpHINLSVjpD2V5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QtSHxEJ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FbUmFrut; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6596xt3S1878659
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 07:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=; b=QtSHxEJ0Y6rPMv40
	pv0dZM8Puc4mUpXvZMddxvB85ke0qi44hnbXN+nnoKZWU6VwBO6Wsew4TtaqZV1k
	WXMqFWtU+n5WChEHLfVNyZmrXeW/ti/njqteaeD/GroXNwgDOaambGQgOKbz2zyR
	ZI5Wfdsxi97oraH/OTZhWkb7T6gW0e7q4+vAzZlrWxAkWmEVqEn/eGiT4U9MYbCn
	hSFlhRR3dX1WoJCJWgVyab7AwOE7FjvM/DAXlF1CjMxKGbibnPGASUvXjLqHWPrv
	cy4O6GTR9E6QgiwNFGV8n6VigUlp5XFxyThfhXKrQvPofiFPFnlGijeh5Lvk7cnJ
	6DeXgA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epe25r73c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:31 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ccd5491db4so39255766d6.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 00:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991611; x=1781596411; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=FbUmFrutRPh+sEBIw5AIewyiCaJngSR2NuUIhMpoTnxB+pUh/aVL3gT8+ZVIXll3i0
         G3ydsHH5b6KrlfGRJ61Ly8nB0wkTJOojVBcsWri4QzK2OfTe7pBHgHmLh602g0erVMlV
         EIf0IVS5kNNxt1pk4RPYsalzb+A3V5dTLCKJiJRvkcw/piSr0qvI8H724wChBpcVXR+b
         Tr/DpuvTrvIiB3XkKHWsttaPxYWV68DuibrOWjNkvGm6fyYWijeti8kUllszrRSHBn5/
         8M7XfFy855bNoZTGjP3NxZmm35YbuVClH4s+XF6bkpvu8iHUdV6WGrWgNgYGF1c7OW0j
         UZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991611; x=1781596411;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWJIctf3Xhmc1Sr2xNkWiIgvHAObX6zOuqPQdVoDfTc=;
        b=dmKOLJ7DCWtVAJTY2b2mTtOYAU9ay9yaNAV+wu0Qq8rOB477i24y7nlrW+BPVGyjrI
         l44DpquvtMzjK96YY6TDswe7utBk520WbgCEzyDWUXBli49EBHbbneC4tA6Uz+bG3bCs
         5B/WrJBT5VMa1GXJBZGcO8QGiIXtyl7Ikh59Vl3ZtPz87OdC/TpKpMGJ6XqBpzU9Ynvm
         p28J4QzIusTHh6FV32S/CZvCqqwCN4U6rNdI5tEc/fMgtLCMgvYvlYAfOD6Up1v943YA
         gn03eKd0J7+4rdpiMyCI1W2tiOZdPUnU9uuhR6C1NXQXgdeH2KNMcyxihAVL7Mow99CT
         3C4A==
X-Forwarded-Encrypted: i=1; AFNElJ/RPySCVLTCCY94tB03MvJc7QCASh46+zs5foqmvcVFvuHZ7TR/YwcoamPKVlgij0gSU9u4PBhYEAM9iAJbSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0bSmPavkf5O7QHGj4nUHmLXw60WZy4rmUc042McFoRqd3m+x
	pjUwGMSQbWCMyhJQ6VtEHI2F91sR08fKTRPb5fyvpr33pfKqJLGH5aumE+Y4waKceMByMZ6PtRn
	/vt8LFU4WRwaOzf8ALl/2RV63w18EErJSD/pvwLa9IgevYZJ7C9HvA3Mjj69K1e8NkSmDuw==
X-Gm-Gg: Acq92OHzUOHC/3atR35mk4CVNe0hHojx4Q2Ek4PzmODznT7/aDz67rfBZrx1dIoWzPL
	yFSJ+WLgIx+jiappQ6AzBf5zOYYlvVjDdCiYNBzmhqpvANXBwe4zdENYLu8LENaCkdRRguqgXkh
	ic1kDubM/dofUH5dFgQ3+zHOnD/0krmbzx/dPsBDSCP1jzVvfyaAs46eMDmoi8JWDOGbc8wGYkT
	5aawlXWTFWsfUh5wTL0ThDoQMxAQYdGYoPJxTT+wTQLVhMkNNZIxn2zzz5Y1wfTWsDJ/82nh4C3
	g5r2A1yIUjhIiACK/hkjETF16q+w623ud+nzX+myyukUJ5wh8NMLIbG1u8MGQ4PUXVV6StN2XtL
	EUxCI4cOEiMzK8rZ0I/BZburdbJQhafNbobshxQrRvp+4zskEM1Vkbd+e8zzXmdUV12+oIlGDBr
	72NrDZPuOsA6wpiwAbwXf3cVSuYZHBAe6wj57jFnFtT8YrvkQ+L5waJc8Lbw1xEFJsgGDPwZ9aG
	2BsF426II83
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id d75a77b69052e-51795a829e6mr264738651cf.11.1780991611202;
        Tue, 09 Jun 2026 00:53:31 -0700 (PDT)
X-Received: by 2002:a05:622a:1388:b0:516:e031:9343 with SMTP id d75a77b69052e-51795a829e6mr264738271cf.11.1780991610728;
        Tue, 09 Jun 2026 00:53:30 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:29 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:31 +0200
Subject: [PATCH v4 6/8] Bluetooth: hci_sync: Add NVMEM-backed BD address
 retrieval
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-6-45712e6b22c6@oss.qualcomm.com>
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
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: GF_vXmCT-Cb-HJTtbYUMCwe-OujYNNdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3MyBTYWx0ZWRfXwsqBb1w0H3OX
 QaCwwNzhPJQmcTyueJoqM3HXAOVFwcS/5znR8EBwri5GuO1qRfH3Kz0t7dboksxFQto6HYrRAFl
 Bu3U0Mz28p+PdqzSe/cNES5WB7OYh/bmj47zBfKAvZcFSJ8kx485512r1W3k9kiTroL51/NT+rT
 GQiSFOep2bNvkqC2b81GmvF2m41UekCn73nuOYXJML0hCli5+uuUukZ92SQyWCHyRGLTCqOPADq
 FCEQuBR4mRllINvVgyXhyDJoCjAwXyLZEySvLIwrWubv+FBdnKZQoqBoCGZchH/WDHzgl5mBqNA
 Wl9OSiH7dnhLgjQEznsfiYFX94flXl8Gd2iIPhlF8+cD0270LH6vyI8a/BxEGOgoXO/eioFGhIw
 JIF96UovxsGBNlgQhJZ1L07wUQxXGiRHjuWAs/tz0OLTmPDbPaP7zTb1NvQgN5n2qO2EqQuR2Zn
 IYFQO0GCWYuDQMee3+Q==
X-Proofpoint-GUID: GF_vXmCT-Cb-HJTtbYUMCwe-OujYNNdI
X-Authority-Analysis: v=2.4 cv=LoqiDHdc c=1 sm=1 tr=0 ts=6a27c67b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=tQ7bI2BnKgK5Av-YYOwA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_01,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090073
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37565-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 18C2C65D859

Some devices store the Bluetooth BD address in non-volatile
memory, which can be accessed through the NVMEM framework.
Similar to Ethernet or WiFi MAC addresses, add support for
reading the BD address from a 'local-bd-address' NVMEM cell.

As with the device-tree provided BD address, add a quirk to
indicate whether a device or platform should attempt to read
the address from NVMEM when no valid in-chip address is present.
Also add a quirk to indicate if the address is stored in
big-endian byte order.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/net/bluetooth/hci.h | 18 ++++++++++++++++++
 net/bluetooth/hci_sync.c    | 39 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 572b1c620c5d653a1fe10b26c1b0ba33e8f4968f..7686466d1109253b0d75edeb5f6a99fb98ce4cc6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -164,6 +164,24 @@ enum {
 	 */
 	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * retrieved via a 'local-bd-address' NVMEM cell.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_NVMEM,
+
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' NVMEM is stored in big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_NVMEM_BE,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index fd3aacdea512a37c22b9a2be90c89ddca4b4d99f..589ccdfa26c1281d6eb979370523fff0d7920302 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/property.h>
+#include <linux/of_net.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -3588,6 +3589,37 @@ int hci_powered_update_sync(struct hci_dev *hdev)
 	return 0;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_nvmem - Get the Bluetooth Device Address
+ *				    (BD_ADDR) for a HCI device from
+ *				    an NVMEM cell.
+ * @hdev:	The HCI device
+ *
+ * Search for 'local-bd-address' NVMEM cell in the device firmware node.
+ *
+ * All-zero BD addresses are rejected (unprovisioned).
+ */
+static int hci_dev_get_bd_addr_from_nvmem(struct hci_dev *hdev)
+{
+	struct device_node *np = dev_of_node(hdev->dev.parent);
+	u8 ba[sizeof(bdaddr_t)];
+	int err;
+
+	if (!np)
+		return -ENODEV;
+
+	err = of_get_nvmem_eui48(np, "local-bd-address", ba);
+	if (err)
+		return err;
+
+	if (hci_test_quirk(hdev, HCI_QUIRK_BDADDR_NVMEM_BE))
+		baswap(&hdev->public_addr, (bdaddr_t *)ba);
+	else
+		bacpy(&hdev->public_addr, (bdaddr_t *)ba);
+
+	return 0;
+}
+
 /**
  * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
  *				       (BD_ADDR) for a HCI device from
@@ -5042,12 +5074,17 @@ static int hci_dev_setup_sync(struct hci_dev *hdev)
 	 * its setup callback.
 	 */
 	invalid_bdaddr = hci_test_quirk(hdev, HCI_QUIRK_INVALID_BDADDR) ||
-			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY);
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) ||
+			 hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM);
 	if (!ret) {
 		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_PROPERTY) &&
 		    !bacmp(&hdev->public_addr, BDADDR_ANY))
 			hci_dev_get_bd_addr_from_property(hdev);
 
+		if (hci_test_quirk(hdev, HCI_QUIRK_USE_BDADDR_NVMEM) &&
+		    !bacmp(&hdev->public_addr, BDADDR_ANY))
+			hci_dev_get_bd_addr_from_nvmem(hdev);
+
 		if (invalid_bdaddr && bacmp(&hdev->public_addr, BDADDR_ANY) &&
 		    hdev->set_bdaddr) {
 			ret = hdev->set_bdaddr(hdev, &hdev->public_addr);

-- 
2.34.1


