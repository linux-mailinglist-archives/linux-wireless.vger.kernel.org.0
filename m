Return-Path: <linux-wireless+bounces-37568-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ryxjKeHHJ2o22AIAu9opvQ
	(envelope-from <linux-wireless+bounces-37568-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:59:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C54465D77E
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 09:59:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=HCH16y7k;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BV3nU0QN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37568-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37568-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D39BB3065A0E
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 07:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A41A3ED3B9;
	Tue,  9 Jun 2026 07:53:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931473EBF2F
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 07:53:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780991625; cv=none; b=GmcEXnI8lXK2nLnbA2xDlUtjATuhirCC8fmq4VINbRbOM69+nTjS9UdTThJXRPaOwdOzuKldenlKW0H/WHfhnopE/OA5eIB3CprxC2ft1Bn1z/7HJ0ZqVYlqRHn5f/IXWavzeiYpWnARYefw7Ukowjm+YHHRGxYQ+fmM0le71U0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780991625; c=relaxed/simple;
	bh=jD3L8jwoh7BLSovJJN4zvcH6m1V/AR7MZ04B9wQ9s00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j9XYCXwsZXxPnnLOs4lmNj7c+TkKAWFrJjAJETD9khKlW9ExF+WV0gK4XQCODyw54BXYq8u9zJ5AnWADdCFmLOqP593xi4JG0b/XkDQRGXwZ7PqrYTjju4oyWBYdsg+QfRB4zxV+ZliTv+nykPRV98SLLH3MTo1zkT4+27HPYTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HCH16y7k; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BV3nU0QN; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597rf7D1568413
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 07:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=; b=HCH16y7kViKLrFhs
	7UsBAF+HpVtfvq6yHiDLxz+pt8PFwySxN8mnpW1Gdfh0XVDOyxaWimOZPRIb9Y6l
	WuYg/+wd1oCH6AjumAJ2aPpG7xkNc2YACExFChrPhea6T72oOfpaFljXnqD0+aUD
	Z1fYgJzF6FAhZKI16j4THgQ7UwvIjlAQTd7Xifd428Jf/bnFybCjkE9lIi+uqpaj
	o7nWVA2f5XcNAgEXv+ZaYAZxwkA4+j4eYpdeLUIcZNmJkqcI6sDBCvKiKnQhx+A1
	LsgMIy0sOAE7ML6VDQ5/2TQqt8u86ih7bH1BBDHRJ8S0ExMqnVRPrbZrU2TtWXee
	bcEBug==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx45g8w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:53:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-517ac42d958so52121591cf.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 00:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780991608; x=1781596408; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=BV3nU0QNgD8Z+bgP0Hh0w+aaqs6p19Loj2q/6Pe1t9pGd6+wqaM2rthY1M4VWbKpGd
         tpCcTJQ2gPzvdSdZAN0uqHbLkcJbvG8rLpIo2DFHClz1wdKGaeYTzRcE3GzXwxrdrjoR
         iSLZESwwxUhvbjl8JQqEKbBimA3FnF+fSsHtc0UtiW9tx3bYv1qO1ryEe+XO4388/ZQG
         dWOyD6pbRity/HpaRbcKUsEyUqfK77jKTvwbmGsIeBPB48sOCaza7Knt1sj5qB45kQuZ
         Q93yZL6ruXPcDzL59ivbsJdIY8xyhaFQM7epV9GTu/DpvCvm3XS7LwJEV2h49RkfXW68
         UQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780991608; x=1781596408;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=41nbnSBEwQElk6GtkzYHQTOlycyPOuLRHHoqlbc4AwM=;
        b=lU8Gjx2Ygz/tvrVFKjx78hUcWLJAMsPu5OE+gd1rwLW5TSytTJngcFEalJYduhqaof
         sjPr9850Mu47e1o01WZF7loWunxSOtvfUES/HT9od0aNVHPRwUMyP29IdMBAQHsZVzxC
         MneAABX/jDtU0gc5rWX0EPwczmArf+RP10n7gZZ3oFbAhbqWdMZaO2Cz5AIRnmuWuNxc
         p2oFrEguCKxAuB0ZOwqNGJp4ZtOd+D4f5Vgz/xginDK2ltFDDG1JQfN+43w5g8o/8ru9
         eJf24yFFa47zJlvrPXbEtlTB4VJZqOBTCc42DMbfaAraXKC+6t+dEXlJR5FX+b1PL5HE
         nV1w==
X-Forwarded-Encrypted: i=1; AFNElJ/RnxbsaPOsgiXv349BiXDNSiINXZ55+rtrLgX2JRfoPLSAHNzxg+whYpNMRQIDKxUwVFbzo6aoagbZ8HOC2A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxH1mGrhqNYu4JQ6bZa5S/EJOIofBos6C9uiv4PA3yKOm0WuQkc
	tw/DkhlpwxeBM/7xWqAaHbvL3FptUDXizZfFhiEuJHeYo+UZk3smBsx7HwOyI4iTn37vA9IE1qV
	S5byQXgBDNdYCsphG1Pto+mP6keP5r9WqgnRDcQLg/TM/ipBG6GF8zaK1XvA8Nk1Jvk6/zg==
X-Gm-Gg: Acq92OECZwF2FN2G2rh3guI8yMb+JgoPY7w6pwi7qqlRV6cjeuTXFDJbGnTq+K4tPmZ
	s5peYHPiikffWpLkv+eO9RFXLLFAAcrvsSkZIrLudreLXhSiSMcR1UBT7UAUa5+ms3qz4RZk82+
	2YuNf32YSCAWBPmlxSjFOf2uS8pr5xtcMNk/pnd/+cbTGf7dtAPpoQAFyH6C66NszIAGGD11Zjd
	Nx6UbfERbH6kUnqT3Ya97ZLpBc3pXexpKnoiyBp+5Xe+KymbqxYbnIeF3akEqQh+EnISSKDw7Su
	o2rzajS6ttpFEYQMiGf4RvXbSMQHo8JtCTJpZWI21HD4uoGYPf4O79GprL2ifPB/6nh6WacnAQ9
	PeyLSUdhSwGyPRM214FYgNO5cIhPEK9NtFvMRsND/n9ba9sFDznFb/SannXNmda8sMVl868CFx0
	Ig88rqXaZ5B9Yd1Z27dei1Uvk/NKK+EIlMXzEhkk1Hu0dCk9rDzfCxscAgxODMgzXXDfibxf/HB
	tshgGqEVk96
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821571cf.36.1780991608574;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
X-Received: by 2002:ac8:7612:0:b0:517:a02f:171a with SMTP id d75a77b69052e-517a02f1d7bmr164821031cf.36.1780991608169;
        Tue, 09 Jun 2026 00:53:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:cc96:22ae:323b:9eff])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68e64303892sm8121631a12.0.2026.06.09.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 00:53:25 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 09:52:30 +0200
Subject: [PATCH v4 5/8] net: of_net: Add of_get_nvmem_eui48() helper for
 EUI-48 lookup
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-block-as-nvmem-v4-5-45712e6b22c6@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a27c685 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=bEbww9rD5qa0LKludeoA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: KCM5MbiUjzmtti4nbLuEO-PZKauPkbEa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA3NCBTYWx0ZWRfXyzTdlLhL13n/
 Ki8qiLemKHpfmyw/HxX+ZcQNDXY8S68CiT85ecpCmp0PuEg0CmKn1reJX3WMApqB4VXApxYgXJf
 iMG1zhfmqAknqZBLxQXQASKvwTDwSIrlXwTHibHkIppHeoAnjDL/NPg7Pd1vLqDyK9iMNHVPo68
 53a8oVZdi/fSttOvyU01sAPK8QHZdj5V8WgyuAlO2L4nt3ZVLRI4AQVCJWx3/Z5rpnA+/suFkSu
 JwE3qC9Bg2KK4cc31reZQz9lloF1a07vnQnnuEKimVkp3LPlhEJ/E4q+ztR7jhVjOI1DNAkugPX
 C9Nx6lueyY/w7LD+smIX8cAPvHAiAedscLePK7FGLG9w9d8M6tjuK6ISXp4gbaut0v1DMRmEElN
 ueO0KVWpqAm10MktFulshb1SviSU1Q==
X-Proofpoint-GUID: KCM5MbiUjzmtti4nbLuEO-PZKauPkbEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2605210000 definitions=main-2606090074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37568-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C54465D77E

Factor out the common NVMEM EUI-48 retrieval logic from
of_get_mac_address_nvmem() into a new of_get_nvmem_eui48() helper that
accepts the NVMEM cell name as a parameter. This allows other subsystems
(e.g. Bluetooth) to reuse the same lookup-validate-copy pattern with a
different cell name, without duplicating code.

of_get_mac_address_nvmem() is updated to call of_get_nvmem_eui48() with
"mac-address", preserving its existing behavior.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 include/linux/of_net.h |  7 +++++++
 net/core/of_net.c      | 49 +++++++++++++++++++++++++++++++++++++------------
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/include/linux/of_net.h b/include/linux/of_net.h
index d88715a0b3a52f87af23d47791bea3baf5be5200..7854ba555d9a55f3d020a37fe00a27ae52e0e5dc 100644
--- a/include/linux/of_net.h
+++ b/include/linux/of_net.h
@@ -15,6 +15,7 @@ struct net_device;
 extern int of_get_phy_mode(struct device_node *np, phy_interface_t *interface);
 extern int of_get_mac_address(struct device_node *np, u8 *mac);
 extern int of_get_mac_address_nvmem(struct device_node *np, u8 *mac);
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr);
 int of_get_ethdev_address(struct device_node *np, struct net_device *dev);
 extern struct net_device *of_find_net_device_by_node(struct device_node *np);
 #else
@@ -34,6 +35,12 @@ static inline int of_get_mac_address_nvmem(struct device_node *np, u8 *mac)
 	return -ENODEV;
 }
 
+static inline int of_get_nvmem_eui48(struct device_node *np,
+				      const char *cell_name, u8 *addr)
+{
+	return -ENODEV;
+}
+
 static inline int of_get_ethdev_address(struct device_node *np, struct net_device *dev)
 {
 	return -ENODEV;
diff --git a/net/core/of_net.c b/net/core/of_net.c
index 93ea425b9248a23f4f95a336e9cdbf0053248e32..75341c186123e949fbe21f1e51fce3ac74d4f56b 100644
--- a/net/core/of_net.c
+++ b/net/core/of_net.c
@@ -61,9 +61,7 @@ static int of_get_mac_addr(struct device_node *np, const char *name, u8 *addr)
 int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 {
 	struct platform_device *pdev = of_find_device_by_node(np);
-	struct nvmem_cell *cell;
-	const void *mac;
-	size_t len;
+	u8 mac[ETH_ALEN];
 	int ret;
 
 	/* Try lookup by device first, there might be a nvmem_cell_lookup
@@ -75,27 +73,54 @@ int of_get_mac_address_nvmem(struct device_node *np, u8 *addr)
 		return ret;
 	}
 
-	cell = of_nvmem_cell_get(np, "mac-address");
+	ret = of_get_nvmem_eui48(np, "mac-address", mac);
+	if (ret)
+		return ret;
+
+	if (!is_valid_ether_addr(mac))
+		return -EINVAL;
+
+	ether_addr_copy(addr, mac);
+	return 0;
+}
+EXPORT_SYMBOL(of_get_mac_address_nvmem);
+
+/**
+ * of_get_nvmem_eui48 - Read a 6-byte EUI-48 address from a named NVMEM cell.
+ * @np:		Device node to look up the NVMEM cell from.
+ * @cell_name:	Name of the NVMEM cell (e.g. "mac-address", "local-bd-address").
+ * @addr:	Output buffer for the 6-byte address.
+ *
+ * Reads the named NVMEM cell and validates that it contains a non-zero 6-byte
+ * address. Returns 0 on success, negative errno on failure.
+ */
+int of_get_nvmem_eui48(struct device_node *np, const char *cell_name, u8 *addr)
+{
+	struct nvmem_cell *cell;
+	const void *eui48;
+	size_t len;
+
+	cell = of_nvmem_cell_get(np, cell_name);
 	if (IS_ERR(cell))
 		return PTR_ERR(cell);
 
-	mac = nvmem_cell_read(cell, &len);
+	eui48 = nvmem_cell_read(cell, &len);
 	nvmem_cell_put(cell);
 
-	if (IS_ERR(mac))
-		return PTR_ERR(mac);
+	if (IS_ERR(eui48))
+		return PTR_ERR(eui48);
 
-	if (len != ETH_ALEN || !is_valid_ether_addr(mac)) {
-		kfree(mac);
+	if (len != ETH_ALEN || !memchr_inv(eui48, 0, ETH_ALEN)) {
+		kfree(eui48);
 		return -EINVAL;
 	}
 
-	memcpy(addr, mac, ETH_ALEN);
-	kfree(mac);
+	memcpy(addr, eui48, ETH_ALEN);
+	kfree(eui48);
 
 	return 0;
 }
-EXPORT_SYMBOL(of_get_mac_address_nvmem);
+EXPORT_SYMBOL_GPL(of_get_nvmem_eui48);
 
 /**
  * of_get_mac_address()

-- 
2.34.1


