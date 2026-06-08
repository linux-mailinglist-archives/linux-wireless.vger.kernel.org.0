Return-Path: <linux-wireless+bounces-37503-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vWeIOZKfJmoNaAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37503-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:55:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9025F6555C9
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 12:55:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=mtXioEHn;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=TkIHFkrr;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37503-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37503-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C686E30394FE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 10:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDB2305665;
	Mon,  8 Jun 2026 10:50:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8A2E5429
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 10:50:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780915845; cv=none; b=jf8FTYESulfXIt3qP7a5yAcOM2qSrX97WI7Rnr1eF2KBOOW4X8StC7H6VQPbWKQHHcj4CTSDEC9tjUw8F/lzqqVhMCmCl8TSwdG0D9UN1N4R7HxRCXh5V22cHPRrVg6mwrYcCYazGhMF/32/8gDUFzfw4pnuSTMcFj1OHMm1RmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780915845; c=relaxed/simple;
	bh=jaf8PFyJ4WPDw4q85PUXH2HS3A+jjIMPeI52wtzYaWo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bQ9TSAIWRl4WED5YdTcmhJ8xARvdsEddhJqsU4fgCGaI+xzIG5DkB6dyhbnh+HcB3F9jWe7JlIL0+f2DPrpKsTSH50aO+6SPRz9tF+IsUoLU/9+hHMCTTG+Z18+oJKGMZMxEeQ0tRL1Psl2U1/rQ9SDAj5nLh23juyUItXyzecI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mtXioEHn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TkIHFkrr; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A3Jjw3308842
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 10:50:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=hw/eHeJkR5tO+NdQr98v8w
	mguro8AATIDIzpZLKzK2E=; b=mtXioEHn1HMmoInhBE01qgoDocjx9KnU89yr8g
	QoN5WkV4prt+rvEA9e0SfeLQEvEzM3zgMsBNPckmdH/3BxX8Wg0AAbLGSgSoF2+t
	LXDHTpbTItdGAB5qgRGOfVG67fJXuiDZt+Wmefo1FwYqnWsZDTqUXGUdnjjObmhm
	EdUHmTbG21T3V856a2LN4DzrRlDdmcxCB6KxG4v9jbe2jsjZOwR9qc6f8CoBCQHj
	jNcftOQKWCiRiJ+nfH6q4pSl49lY5gloMEZA72wj74W06dGE8K/1udrCWnkuFaQR
	ivxjhZbmi+AdVZlewSY4r2KR1wQneQJkBRmMpaVZJc/+djog==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun8g6vm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 10:50:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8cea4854fe3so81490076d6.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 03:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780915842; x=1781520642; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hw/eHeJkR5tO+NdQr98v8wmguro8AATIDIzpZLKzK2E=;
        b=TkIHFkrrCwiR2OE6L4SKgWmoMwUbfDKn5MLnYMJKLBiXIyEFTOW8vpetMBZZplXyzl
         jfXN4y98toxpv4GCZA9DLMB3tn5z4ca5gJDuXcZhgJZs5O3e9AwtRjJ3lIUdH+fjPOvZ
         WmPrwEVpDBWEsLz38CKu6eFJMfhSw97lEdIfvT+saUGXLwMW7CAaEF+kZJwdrpCVw4Y3
         7eh+TQF4SbiurjYJ8cJukWavJFHU7t59AA2Nd1rP+WzgYGUn32FCQwW7kaycBpLK2R/b
         h2wBaGmdJ8xdfU+VC9ISuOhlpw+phpAzHGfVhUNPRNNF1pzOAr4vXRjJlSIagf3GgbhK
         rnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780915842; x=1781520642;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hw/eHeJkR5tO+NdQr98v8wmguro8AATIDIzpZLKzK2E=;
        b=LZgxB+mB/89NOFT+OlEEEywTLES7Adu7sbu5LE7XiE6Q7aGUq/WWuWBGP6itwK+J0P
         H/efExi8qj/TBiCz+0Zgs4802KKjjGaSIi8WrtnOgArZZHoLswHI48hUhQp2jPx+ROdb
         7x8X/jtXJ/d4Ao//mpeE4Q5hjdyjnJpdbdLzdn3Rw6VzbxQUvNyaxv3RxAXk4kjoxHUx
         W7/9X4+rE28/Lw+Awf22pgy6HAw8YqfWfZXt0o8wkUHGbLoxOs+qYhHjXvVs8786wfMq
         YukDIyLYEsTs8DtGmgBQRp57GNtzkQkrONy8QZQXWkS6HNTSsioVkwwwBWEWDMZR8qP4
         En4g==
X-Forwarded-Encrypted: i=1; AFNElJ+mOkfqdMvmzjbKFjIJcDXQo6RKHKSnE+IldbCXOx2UINKt0rguzcVbtQ1UAw8UG4Cl7NNq5dE4BK3dpMntOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyLhAyYwOHqlmh59mVI2X2razKvTnL/XBssvVvncvIeeo0mDNhm
	rjKGQ/r7THfn+s2PhmBBkD60HEtxs2kNmQ5FaMQZrqCIUD+7yic4d+h+fj1IVKYNtB3KNEAEwoI
	EamUgXYwqKgCseXqIVpyt7UICvEdYnYA8rocJx0BwtoEnsHsK7ImGkY8rva+g1jZ6vQcDCA==
X-Gm-Gg: Acq92OHTsjoVwI06D953VBlAFE/P4PWaxcYO5+BH1v1oGREEHYcY4+Pu2f3PQynwB3c
	5kRJTeqr4eGMWxDamdMOb1Ltxeh6dz3bGqSpakYHKIlI5LINmqIGhJJ2e6JBhykxgJumbqWWoDR
	n4LN3IU/NxY0XkU1cvxTTP6DNVXGsdUXFIBDFd+ywamZvoQGWvDdjk0rpsP0QBCHXkCgWg/HnR/
	49QGGjrjWeft9vAMtPDrOvExw8sOEWJEblMHzqAUM9zt7gLW5PyxDJcit/Usroa9gyYvpPaVj5Z
	70Q6rlllCmFH9RIGnFMp1OYkwrTEaslkNT8DesK0fy3zT4E18RDIzo96+rijjAKLV8UUpaHZmnO
	JD3GhXtJROIdZxErOsgQwxCuoEN/x5DjaR8rX/6crdxWJxPNb9dr7y+wEctz9vsRTr4L8xnZPUW
	RwM+YDRwsNvw4MyEL+dsXMuo4+KixNEP+iiwF1wVmZ57VxLJC15PSljifsLgGBKJPlkIfa5u4q7
	tQn/1Exj+Bt
X-Received: by 2002:a05:622a:6096:b0:517:917d:e3d3 with SMTP id d75a77b69052e-51795bbf2b1mr200561731cf.36.1780915841916;
        Mon, 08 Jun 2026 03:50:41 -0700 (PDT)
X-Received: by 2002:a05:622a:6096:b0:517:917d:e3d3 with SMTP id d75a77b69052e-51795bbf2b1mr200561291cf.36.1780915841490;
        Mon, 08 Jun 2026 03:50:41 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf051e9aa33sm850399866b.24.2026.06.08.03.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 03:50:40 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v3 0/7] Support for block device NVMEM providers
Date: Mon, 08 Jun 2026 12:50:37 +0200
Message-Id: <20260608-block-as-nvmem-v3-0-82681f50aa35@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH2eJmoC/3XMyw6CMBCF4VchXVvSC1dXvodx0dJBGinVjjYaw
 rtb2LhQN5P8k5xvJgjBApJ9NpMA0aL1Uwq5y0g3qOkM1JrURDBRsUI0VI++u1CFdIoOHC20ZA0
 02qhWkTS6BujtcwOPp9SDxbsPr82PfP3+pSKnjFbKCAl1yVumDh4xvz3U2Hnn8nTIKkbxUUpWf
 ykiKbrnNRhTclnAD2VZljcPNGyg+QAAAA==
X-Change-ID: 20260428-block-as-nvmem-4b308e8bda9a
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEwMSBTYWx0ZWRfX6LG+AzGtAwf1
 hxInN2V0mXUUyYIU1vAm7EfBwc1jmAeem0O83Gmd/h8GW0rAS3fUkkC5NaAW8T84v19xrQpv8ri
 s/RSbvA4XxPRN/FzbLRyLzJBPQHnRoHXRVc8DRG+hsgkf2VJZ4Dq0M7l4B4BSlb1939VCo1eREB
 F2/TiqYEyKUMTxcSg/5ITgHVOVyZ3RCmjLuxEdACXDPAee42VzqTppWPM4q+m8CwsRe+uNwC9i3
 zEHOBUys2sBmcxUoFgIvW0fEX26lvnJSAd8aIwCpGHLlsoSlp7HUKgtt/UmhBCQlWHDBS3inVmd
 IbYcwoxZckManpi4Jow8YIJCnWxM2b5tV7/gQQBQZ4Is+/OvEYThUrhTerL/Pp+UcST7Q/gLrvB
 yPVpyaBQXGvQan4NRMViMnJA2PMjtIi3Aa+hPFYoA04IWs6wrQiHWDHwkOj73WjwbUDtxlEEIU1
 IF2mhKNspkLr4QfSM2A==
X-Proofpoint-ORIG-GUID: RKdkrK6V5_KyKHWoLV-prUSYI_P2g2ZH
X-Proofpoint-GUID: RKdkrK6V5_KyKHWoLV-prUSYI_P2g2ZH
X-Authority-Analysis: v=2.4 cv=Z7rc2nRA c=1 sm=1 tr=0 ts=6a269e82 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=VT4XjZGOAAAA:8 a=EUspDBNiAAAA:8 a=K84096E0MCUURokRqYgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=6CpsfURP9XNmmWg3j1mJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080101
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37503-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[36];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,kernel.dk,sipsolutions.net,holtmann.org,gmail.com,quicinc.com,davemloft.net,google.com,redhat.com,lunn.ch,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:ulfh@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:axboe@kernel.dk,m:johannes@sipsolutions.net,m:jjohnson@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:srini@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:saravanak@kernel.org,m:linux-mmc@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-block@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath10k@lists.infradead.org,m:linux-bluetooth@vger.kernel.org,m:netdev@vger.kernel.org,m:daniel@makrotopia.org,m:loic.poulain@oss.qualcomm.com,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[loic.poulain@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 9025F6555C9

On embedded devices, it is common for factory provisioning to store
device-specific information, such as Ethernet or WiFi MAC addresses,
in a dedicated area of an eMMC partition. This avoids the need for
and additional EEPROM/OTP and leverages the persistence of eMMC.

One example is the Arduino UNO-Q, where the WiFi MAC address and the
Bluetooth Device address are stored in the eMMC Boot1 partition.

Until now, accessing this information required a custom bootloader
to read the data and inject it into the Device Tree before handing
control over to the kernel. This approach is fragile and leads to
device-specific workarounds.

Rather than adding a new NVMEM provider specifically to the eMMC
subsystem, the new support operates at the block layer, allowing any
block device to behave like other non-volatile memories such as EEPROM
or OTP.

This series builds on earlier work by Daniel Golle that enables block
devices to act as NVMEM providers:
https://lore.kernel.org/all/6061aa4201030b9bb2f8d03ef32a564fdb786ed1.1709667858.git.daniel@makrotopia.org/

It also introduces an NVMEM layout description for the Arduino UNO-Q,
allowing device-specific data stored in the eMMC Boot1 partition to
be accessed in a standard way.

WiFi and Ethernet already support retrieving MAC addresses from NVMEM.
Bluetooth requires similar support, which is also addressed.

Note that this is currently limited to MMC-backed block devices, as
only the MMC core associates a firmware node with the block device
(add_disk_fwnode). This can be easily extended in the future to
support additional block drivers.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v3:
- Fixed missing 'fixed-partitions' compatible in partition (Rob)
- Fixed clashing nvmem cells, document calibration along mac (Sashiko)
- Remove workaround to handle dangling nvmem references after
  unregistering, this is a generic nvmem framework issue handled
  in Bartosz's series:
   https://lore.kernel.org/all/20260429-nvmem-unbind-v3-0-2a694f95395b@oss.qualcomm.com/
- Validate mac (is_valid_ether_addr) before copying to output buffer
- Link to v2: https://lore.kernel.org/r/20260507-block-as-nvmem-v2-0-bf17edd5134e@oss.qualcomm.com

Changes in v2:
- Fix example nvmem-layout cells to use compatible = "mac-base"
- Squash WiFi MAC and Bluetooth BD address consumer patches into the nvmem layout patch
- Fix possible use-after-free in blk-nvmem: bnv (nvmem priv) linked to nvmem lifetime
- Simplify nvmem-cell-names from items: - const: to plain const:
- Factor out common NVMEM EUI-48 retrieval logic
- Reorder changes
- Link to v1: https://lore.kernel.org/r/20260428-block-as-nvmem-v1-0-6ad23e75190a@oss.qualcomm.com

---
Daniel Golle (1):
      block: implement NVMEM provider

Loic Poulain (6):
      dt-bindings: mmc: Document support for nvmem-layout
      dt-bindings: net: wireless: qcom,ath10k: Document NVMEM cells
      dt-bindings: bluetooth: qcom: Add NVMEM BD address cell
      net: of_net: Add of_get_nvmem_eui48() helper for EUI-48 lookup
      Bluetooth: hci_sync: Add NVMEM-backed BD address retrieval
      Bluetooth: qca: Set NVMEM BD address quirks when address is invalid

 .../devicetree/bindings/mmc/mmc-card.yaml          |  29 ++++
 .../net/bluetooth/qcom,bluetooth-common.yaml       |   9 ++
 .../bindings/net/wireless/qcom,ath10k.yaml         |  16 ++
 arch/arm64/boot/dts/qcom/qrb2210-arduino-imola.dts |  39 +++++
 block/Kconfig                                      |   9 ++
 block/Makefile                                     |   1 +
 block/blk-nvmem.c                                  | 171 +++++++++++++++++++++
 drivers/bluetooth/btqca.c                          |   5 +-
 drivers/nvmem/core.c                               |  13 ++
 include/linux/nvmem-consumer.h                     |   6 +
 include/linux/of_net.h                             |   7 +
 include/net/bluetooth/hci.h                        |  18 +++
 net/bluetooth/hci_sync.c                           |  39 ++++-
 net/core/of_net.c                                  |  49 ++++--
 14 files changed, 397 insertions(+), 14 deletions(-)
---
base-commit: 47c4835fc0fed583d01d90387b67633950eba2b2
change-id: 20260428-block-as-nvmem-4b308e8bda9a

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>


