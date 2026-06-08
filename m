Return-Path: <linux-wireless+bounces-37484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ijLOFshoJmpGWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:01:28 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB61C653516
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:01:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=gLwKCEW2;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=WgjoX0pl;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37484-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37484-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 58B7E3008D71
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A838C42D;
	Mon,  8 Jun 2026 06:59:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0F39D6D9
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:59:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901988; cv=none; b=shpTGcUCzkFFYNe5PYstS0XJ+UaQSrKUeRLh4/esg90LQXe37iQMRMXJHMc5xtumOvf7ibNXGqeFwWdyXNfnUHLraTd3uQI7lkO0eP+9NpKO9m7BA8VdbmUYwa0j9f5wk68fLqKcerJ8coa6/aU2l8ce8TapEf2V7KZRFNnhKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901988; c=relaxed/simple;
	bh=ivfez+E9B3qAfRh5L70SB2bSHUzO4GoveMoTJ4pZ8Vc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ntsZuHz+ByI0Aeq5HsfN1KPigH3Aw+rDLBXeMndTt2tYSmE+VKtpwTcuObt3NF2Mf2QzQ28Tvf5ows7Eu5tpJpMA/jGvAQ4bUKJuEvijN1b8VgNkOUdrTsbzFdcx91KZHuaDsDFr05Ou44MfKLzGKwCb6I6zZrJBKPeg2W/fm60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gLwKCEW2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WgjoX0pl; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586PjDJ2733088
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=; b=gLwKCEW2PQCeQqva
	NS9QXhcWMAFJYCt3Ee6FPAJqCW5CTFsfrMtgC/znIDmEHt/IZyEm03DkAA5KGJ/1
	5/pRX7IO5XHkSXjmiOu9qYe6De/Y93LzCYg1xbo9zhYga7NksFr1SWrpm7gn1y07
	uRSPpNt6EAbmOFdnTPnou1nwDppjVJjafGEa23+o/r5Kb6goroP80DimL/E88YXD
	W0Q6Sn+PnZHootbHWjf91m2/DOs+sBrdxV40ituPeG2xBOxjY+6/VaX8Xm48w/T6
	2pollpjB1KvahgeFe+4v9aHCG7Sny//Yum1GzNiIYsgq3t4fmkROSc6ohANdv0oJ
	+sNNSQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emavf6gfw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:59:45 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6cff652cc58so6518653137.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901985; x=1781506785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=;
        b=WgjoX0plvX9hDxG+KGeXkihOmxiUmHoHjT/l5RBzxHYARojYXvKMx3Iue23CZ9aj8m
         FvxZcP7BKQq7b3uGiwVfLrnXUY/7s3jm83WVMPgYiBGchLJ+NGP194oy7gS35oWRp1LI
         Av+hCJaSDI7fqGZHTamj73mWYZ8XouZPZO8Bv4TgOuWp+hgMoxNUoDPOzmIy+NJWuHwB
         wSX5qkN0lZL7+X8GPEcokP1XovCrnWxAaK69i53k28GN/rS7kMH8E2IRECCUZp69Ttbi
         /IcYmHVaec76cYjFDxAjmB57KNNX4Rlvf7cQdnKdSU0rhew5svXen+OFrDM5PtNoFejj
         6jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901985; x=1781506785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5UUGNkY7j3/4zh2rLPHPzZHPlPL1HtPoB4XrZlt6ez8=;
        b=cEmzf5KJlbI9zmlPeOQGBChCZLoGNrNloQ3ILZs24KAHx7OhYb5EIocjZEvQGUq3Wo
         c5JtMvQ4M8OZmm7FEWfICtXVhn+/REBtCwIqRvS8Cu1M+XwPAzrxfP9I6VrmlKHajLqg
         UcBxyzyNjLglRfBX39WcUHcyH8FtPSJdUuwW/YFqDM1uqgHkmItl3J1YMxZSMcsOElu5
         TNJ8W4U0nytcLjsh498adbd7DX2KyNQAxihByQKjgRD3w/igb7NPHlO7qxXW6KHL2Ipi
         LNDMbBhCF88cF94KNhyaVjbI3OeHMpuQseaY/KBazAWbAcVhnAI5iieTOtAcQcFFE5cJ
         uQCA==
X-Forwarded-Encrypted: i=1; AFNElJ/b591tvhYdzjTJ87NZvUNLchTdharOOHQamiDndnWXhhBMY8LG8vaXS3L6MOb/YtfcR4znUVxvmNjphhIeWQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzIYd7V5BAdw7lzMWr6S3dYmrWybCwnwNlU5sPJfEdkRkr/tx3A
	1+i4UYeSRKxFKfGT/J1sUWFmYaUgpbRBJAxg1H0hSK2zozwnWUrqwWO+AIrVuXUuBvUSGRNxIHW
	+PPE3VNkTJTIGndXCC+ENaeyKnlmhC1DUdnUFwBwezVeLLPKrQYwqr3V0rs6Hh01BCGeCMA==
X-Gm-Gg: Acq92OEb5dnarrgqy96dx6wEBh5TQ1tEGYW9LQQv23SttSuys3gOZZlhMeavaRAnvU4
	x8xaZM+/iuzzfgWOggJbD76WqwZG6tZMaoJjEm+U7rY+I2N29oEm8FUswEd+F1bWiYaVy3Yp2lk
	1TjgoG/GgQXTFcNBLUefC3M4P0mBhTTqnyJv/EMOKQSJAxqhwcf+CxHEA+mtsdfMyx/gT242NrY
	0gNjeiERXIq851DA4ZVinlHW4y78sRMSQXOV3ogQrd8n3ZrLge8VyqI+KBNJlOtleMfoXZL38CR
	mw4PfAaml+VVitWSETGyw0aQmpAGQRLkyA4bcyAeOJR/MHsg3XWHr/H8S3xZVufheZTf8VSYEaN
	w7pUo9bqAkBOaHN3Qa4BHjN5JcXSz/4is7PUr5jGsfqQaML6guuquRi9SbWk5LEHwr2NW2zkIdT
	D8jrHx4VqG7wF0yRVpTPpnBmA0byafZyxUSFMqJcLIGmQGWw==
X-Received: by 2002:a05:6102:3e0b:b0:6ef:d9b8:88d with SMTP id ada2fe7eead31-6fefc8b6fd2mr7182304137.8.1780901985346;
        Sun, 07 Jun 2026 23:59:45 -0700 (PDT)
X-Received: by 2002:a05:6102:3e0b:b0:6ef:d9b8:88d with SMTP id ada2fe7eead31-6fefc8b6fd2mr7182278137.8.1780901984873;
        Sun, 07 Jun 2026 23:59:44 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:25 +0300
Subject: [PATCH v2 7/7] arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-7-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
In-Reply-To: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6193;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ivfez+E9B3qAfRh5L70SB2bSHUzO4GoveMoTJ4pZ8Vc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhMuqGfQoyOCl1z0/vW5dE+0jogozA0K9B7r
 kku4lpySs+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoTAAKCRCLPIo+Aiko
 1XabCACw2Bp0Gz+PrGS7tDbpoA4CbJky6pod9M426pAO+JrCgMofF5yNPYfSbJdixO6vvT3t004
 XRNGoysRpBKyIrZCROWXoj8W66wckYFcKMntiwBCl3OZmZgoulp9sfIA4Rj8S+96k77801TNZNn
 K+BpDr+GcMfk3eH46QBM3/5wO5zmglfFTWmIwiQ5l5kb+Lq7f79XetrIglxNYnEPp/NzBLFToJg
 cXIfLqhtff6pRJtjSGY370yRkPgjeW+zV7D43PVBb7q6Z0SAtdtlkIUfLAgDAGGJ/IHUbKsMxb7
 sq1NwizoyGv4tyXrnlNYcGR8MH9VmN0DFZ92s8nFLlGbKCl7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=I4JVgtgg c=1 sm=1 tr=0 ts=6a266861 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=o9ryCBrv46mMSQ48XGcA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: A-5OnmvHn-wsH5Yx1d-CoM1VY2Z2AXvX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXxyFZI9F5Wr7f
 MFyr3Yx6zcdhlV6VjBbTM9kmkSsxFNMHpQZNQbZIAufmc5J53LuBQx4Cwn9ASV/p1u915jR9hpo
 NtFArYvNbGyRawqTGcJeSpUJL1Lun+7WiFZJ8CMREuUqme0PJN4tGJYZyvcUtJKW/ALVyphcvMg
 rrTaxdDCRVZkjy0FSVLsXISBU8Izi2TEfeJC/kfX41GF7R7OYGscG4EiazY9ZPUs7TW0mCkG47/
 vrPo0GyEPgol32H3GlJ/pETcL7sFaQgP2Yr/Bt53jQqCUUGwgEzuCukpM8KDKwc5jn3QrjgkE5Y
 qjHydO5mgSMrzFF1BX35MMTfgoqYpqpJqEaszY7HA62lGf3SCBEGVk1M0PCoWCBf7gp9bfiRN5x
 3VsBlFDvWUcZ5qbhbP2A1jYX4IJDJxsOEZ2z7ijIBpMQOajWCQUUVPNDVEmSfxxMjPueDrtaVoX
 4ianndmUxqIjzChysTg==
X-Proofpoint-GUID: A-5OnmvHn-wsH5Yx1d-CoM1VY2Z2AXvX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37484-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
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
X-Rspamd-Queue-Id: EB61C653516

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

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
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


