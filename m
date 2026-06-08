Return-Path: <linux-wireless+bounces-37477-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8vOjGFloJmoZWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37477-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 08:59:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A1E65349C
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 08:59:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Pd7Z+oYL;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Hrl0+v9x;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37477-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37477-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7849A3002F73
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 06:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974B038CFF8;
	Mon,  8 Jun 2026 06:59:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283112609C5
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:59:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901969; cv=none; b=sq5knN1BHnhQgpbPzJN07lT59r027FeQ3ASC6/oW8FVR2yvJ2oxelcNgeSyT7s2LAsdkVjZx9Mi7Vwr9AZU6DQUOyTqdFy4qK2kI8l7OntoVQUyfwY8Ox5hnLUSfAWSYRHk8Fx5FIQnbxy01OHZODto2YtThdZ4e7AVUXLTtxSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901969; c=relaxed/simple;
	bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=upNUZvBaWYGsHtqrhsCDw6U1zf1jcgEHgqFJBVF417/EC/FeJs2HdwsB9ImXNPTk7ai9EjP8J9fNPgHgy4hhuMXOUxjFOQGCg0PuX/Q3NUPJg3wljAD64788PR0xiq6kxdWUOYTqD3bSbmYv5GMFLQuRcknudtk99FVjmSUjnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Pd7Z+oYL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrl0+v9x; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586Ralc2833828
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:59:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DoLbGeNFDGlHR+89QHRczU
	z9SK+zm6OjHb7++b63eUk=; b=Pd7Z+oYLLpo92FhhBgXxctOptCvzfHaK0jKa46
	z6i9ZA+O5LRmjVc+ab0pJYbzXpfeLXJS6p3WLmwOD8fx89qT6TaMtMCyb4e0jvt0
	OquOQG72MPLa3Jm2VhlUx/6R5Vq05nifGYP636KhjWDZMvv8kZCo8sbNJcA7e4KP
	uJuWwbNj+emnIwr7UmHWAqfU8GFLfkhLG0giwcvSA9rJYFukBGdvF6WMquUX/uAV
	C2mOd2utnUs0Ads10bV8h+o1sMAOQDG4XsgzTgCLF8i8Po5kMIL6F/TyQ+n011SG
	IR+g/PFb0F9zlBCqkbeFkkVg78CEMcdPKnhcYoTQ/V8mxkvg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emaj4xp4r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:59:27 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-963c12f125aso4422564241.3
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901966; x=1781506766; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=Hrl0+v9xAUcy0CULmPh4KiUmxLCYuXPh4mDAo15rThCe/2bup7Lpz6EBYsRBcb3RjT
         x9mglnB5O5Re/1Em1XRJw+qvEtR2gJ9p3orqYrpflZ5H0wM/087hL9tyO4GMcx9EMxFo
         aqIXD7y4Zb7Z9LMTRhCcRcHBMjjO4g2HshV/BtSmDXlXplNoUjxtjMd7+9Olc1IpqtOB
         zVWbfXKK9DCNhmFj42Ih0gWLY4lj/81Qhc/YRvsl3qCW4GGIAKwhS+CDXTW/xA/ERXQ8
         TpBU2hZ2cN+aYq52u/bwgBIOMe7HZ978/TwXYRRY02mO1D1p/33wHfluhR5jAnY0lvm6
         cqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901966; x=1781506766;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DoLbGeNFDGlHR+89QHRczUz9SK+zm6OjHb7++b63eUk=;
        b=mhUHGkeQyS86whOz33nnEwHPMG2VeNfQUeyVp09nCtg2fmhdn0XFBinWHT4hnfjKqs
         YjS9Xu+oFRS4sraCiZzeVBfSOmfctHZrkUf91M6oYTUcaIx2PuVOGdYm/m0bWdH00kSC
         WGGFcbzDe2UK2SxraWVad2a1DECe7Yh1sGWou+QaQSBiV4KIDjYkf78961KnKbJL+mLw
         RyjkHd4qjmYGVfa3x1or0tXXt+mZzjoDTxvnqayx0nwswqZ7f24E9gODJ1QNUjllZ0sC
         kmCyIvOxLjZAZL1ZAGpK3lxKsxfxJjhXz71Xi0qyZgSGwutrag6fUbRawgTjHHk6fgju
         nfBg==
X-Forwarded-Encrypted: i=1; AFNElJ+IH9UbRoCgnKfRIF/chLzGVRRWwYZHvgjd/pSMwuG2PX1MYWF6EtPVxBsOqQp2Pj8mbX+t7fVOXdNpiXPEVg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyWf/4r+/f0krvpgEsTkJRXnGcHNEzkkXUfIhuNPith7UhuAx+U
	B0LC/Zx4+gCOK7GU0aK/ZSh6en9ZdyjE5gXxUwTkpfr7Qua/8uY5T3NchxleIrSxgJzaWt/4kZN
	RX5nICdKOzLD1I8vNm2d6nhc5Dy5aNILTGXB7eDdh7eDx2kSlcVoIiPcVUervkccvFye/UQ==
X-Gm-Gg: Acq92OG7kRaOGrLLHFThjDkFKSQ3avmNgI9mOKMA0scilq7MJi5Y9VKAvh5DHJdJfPR
	mOK5ZeZopRx9WBwTttUlwUX97H5RQhTyTfb6AQ6SM6r25GAxjNkxM69RUFWgoDsI1o/RH7m+Zrw
	vH2jf44rNIDtUY8Krd4YFrxFRMaZC53hdVZcZ3qVVuxG4qUb/RtYLI5C4Sh+J+tqvWlnRh3+kM/
	NmkXR/k31gKKdSvDptkFlqQvVBgD/v+Yc6E1CRMs2p/hsO6FPxapuSb5DNkFvZAEgZXDC7bjnHL
	TchsUXBFsxF+LQMNF/o/Xx58qujf1qGoSNG9C3pdUCEpshQUrq5FCwlG0/Gw0ELmtiUhicNziLn
	8C7cY7TDOP0hoigZ8KjxF+6DiSXzn5SPFL0z92sJdm6RJRTaLweeebdU75I2qbF3gVIG/p46vSy
	WPYhPjgittBdACoaPcfSqg39QLpDX5QYkV8W+YuomcA/w+WQ==
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670973137.9.1780901966540;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
X-Received: by 2002:a05:6102:148e:b0:633:8c42:183a with SMTP id ada2fe7eead31-6feff8177bemr7670963137.9.1780901966202;
        Sun, 07 Jun 2026 23:59:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:24 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/7] arm64: dts: qcom: enable WiFi/BT on SM8350 HDK
Date: Mon, 08 Jun 2026 09:59:18 +0300
Message-Id: <20260608-sm8350-wifi-v2-0-efb68f1ff04c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEZoJmoC/1WNyw6CMBREf4XctSV9CBZX/odhAaXINUK1F1BD+
 u8WWLmZ5CQzZxYg69ESnJMFvJ2R0A0R5CEB01XDzTJsIoPkMueZEox6rTLO3tgiUzXPs6I2Qqs
 K4uLpbYufzXYtd6apvlszroq10SGNzn+3u1msvd2c83/zLBhn8igLcWq05kpcHFH6mqqHcX2fx
 oAyhPADyvkjMb8AAAA=
X-Change-ID: 20260531-sm8350-wifi-3b0659bc183a
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1711;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=kX8sQsZD7+GXxK6scrMwZsmWM36HVbnaMaQ+ChX05zw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhJ62EPLw2wHCOzmMHkygIyfRi3VNIwoeZ7n
 XMzCJgYxB2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSQAKCRCLPIo+Aiko
 1aWWB/9q9FMl9zHtWaCN27mxlfW4OEuabIPIMZoM2/kXkQzi9TkoXEnIPjkwhXeEMPLRuJ89Vte
 lWl6jykC6bN6e0GDhye7fIZdmt8GIekDsZ/OzX5BxqoSsBgVSRlmlhP6rV6StRnkRhPb3peMVzn
 I9ErCOQyoxPtixjB4mVZAGqs8O/rTE2LAtdLQR2BhOpNnDxLL/S4al+KhAKzpoeLZxU0TteasLW
 gOVd2QDSqGUYmo6xTb5jbHNBMpvyVQKGlMnR6wjwHg5U5ra0vE54cneYutMDigJNxVR/xPlJeg9
 GA4vhuuZTwRz1aJNPRfnxuwDXYtGRAu0BNZP52BVtTj2KOof
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: HEI0URukqReKQdiNyxwJL-Mry9gZ5AhA
X-Proofpoint-GUID: HEI0URukqReKQdiNyxwJL-Mry9gZ5AhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfX0tbiCXI6pdkw
 cmN5rkj2FE+aoSadPPNRtPC2DI58X6aSqLdVvNsMqTWUqx/tPcFvk7U6Qn377TErVtQn543dO42
 EfYugKWnFPO9uJMtn/TbusSsA8636oZl1fZLnNX9Rn8iacVHcp+4IBO+EpgC34VN94Af6OU9/8e
 xEPkVxvKzY/6SM7yEO/dw268QM5uf+oOxr4hq9/Pi29VHmWPjx47xzmAiBuink0FFnQDdD+ypSt
 vtxIMYaUlLOblNkGpWrWsyxDQRWjgjjvawd87upuc6agno2aMRB0jzXzxNKJ4DZWCtdTWQ+YC+/
 QwejvHyOELkf/Bppgm17KHFMWu3DKvu3UHW0pH4eMk3QNtVpllJX7147jP1DD+CP9cmbdn/xPFj
 0UUU/Ml/P388NdCZSo0iPlaQB18WrBfmKCVWK9VyJW2rPTNO0fv5S93r40ejs6bjY39ExPieS7+
 OMEyhyA/cRus1Uoz7RA==
X-Authority-Analysis: v=2.4 cv=TLh1jVla c=1 sm=1 tr=0 ts=6a26684f cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=6KS0kTMdj-vf8_meW0gA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37477-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 61A1E65349C

The SM8350 HDK has an onboard WCN6851 WiFi/BT chip, which for a long
time was not supported. Bring up different pieces required to enable
this SoC.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Bumped num_vdevs to 4 to follow other similar devices (Jeff)
- Link to v1: https://patch.msgid.link/20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com

---
Dmitry Baryshkov (7):
      PCI: qcom: fix parsing of PERST# in the legacy case
      wifi: ath11k: enable support for WCN6851
      regulator: dt-bindings: qcom,qca6390-pmu: document WCN6851
      dt-bindings: bluetooth: qcom,wcn6855-bt: document WCN6851
      arm64: dts: qcom: sm8350: expand UART18 to 4 pins config
      arm64: dts: qcom: sm8350: modernize PCIe entries
      arm64: dts: qcom: sm8350-hdk: describe WiFi/BT chip

 .../bindings/net/bluetooth/qcom,wcn6855-bt.yaml    |   8 +-
 .../bindings/regulator/qcom,qca6390-pmu.yaml       |   4 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            | 142 ++++++++++++++++++++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  14 +-
 drivers/net/wireless/ath/ath11k/core.c             |  92 +++++++++++++
 drivers/net/wireless/ath/ath11k/core.h             |   1 +
 drivers/net/wireless/ath/ath11k/mhi.c              |   1 +
 drivers/net/wireless/ath/ath11k/pci.c              |   9 ++
 drivers/net/wireless/ath/ath11k/pcic.c             |  11 ++
 drivers/pci/controller/dwc/pcie-qcom.c             |  25 ++--
 10 files changed, 275 insertions(+), 32 deletions(-)
---
base-commit: 6e845bcb78c95af935094040bd4edc3c2b6dd784
change-id: 20260531-sm8350-wifi-3b0659bc183a

Best regards,
--  
With best wishes
Dmitry


