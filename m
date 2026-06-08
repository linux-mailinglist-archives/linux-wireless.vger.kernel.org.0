Return-Path: <linux-wireless+bounces-37482-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pO1AIAdpJmphWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-37482-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:02:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E16A65357F
	for <lists+linux-wireless@lfdr.de>; Mon, 08 Jun 2026 09:02:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZXCMHTXj;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LO0LSlwC;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37482-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37482-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87CBE3019FD3
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jun 2026 07:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F874399359;
	Mon,  8 Jun 2026 06:59:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13873988F8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jun 2026 06:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780901981; cv=none; b=ax5yl639WQiCXyUHrjLjjclk+t7MhVKWFeLk3LtveXimLnclaVSJIRT5LY3D+SajRrwiSvztE3u3Qg0w9ImAQyzYRrPLPMBHmenignE3EzS8cuUUKT9UvAJU/8MYgw1H2BXgF9Wcbp5XF4+CUrR7qlB7xaicbUfbkIizX0SWJrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780901981; c=relaxed/simple;
	bh=K+dgZNHY5hnIkDIrCn9f4ZsTwh2z36hnTVJH0i21ga4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bOwwJmDIzYoNKvErVc9tpSpoSK11/rwaCnVOjBy9WsIW3K67noINH6WKRP4DrmIOituCU7ICRacRaJedXUArMaq3l0oFoFTKs3jpSh9KgZ+fGpe2SCdIhBNVSevIq3pCDRoeH64OQRwWD3jDquPl2L/VeUgZQW45WHapnXWxmA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZXCMHTXj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LO0LSlwC; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6586R40I2771849
	for <linux-wireless@vger.kernel.org>; Mon, 8 Jun 2026 06:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ijJ2Fs7y6o0l/NRnU4TC9ZpeExxhgCsJvN3KF+zKxuw=; b=ZXCMHTXj0KwyxOuU
	UxMnzDBkxzD7Fnx1REV+YmBYfyJjxrx4BpiTe4PUEFV23hes3ftNHq1zMOY9E5aU
	QCsrFGwOzW8a1HfGxknJuvlI/QP6qSoBu9rKP7crGoBsg+ost5oDB+AaPfZtbeGQ
	gL6CL4VzNZzxMphuT5jPBPlma1qj6EuRYAitDcx5y5eXqTmCRaulI+N2jEqULSDP
	UijczHrBNIOgrfaQF4a/UsP+UJoB7Zm84Mqi+jlR0VCyd33XWw7QXe/MKBKfER39
	hRWbiOqd4HiIFRs+9nndFTd5w1r48pSYftGQ0IVAUoBL4WM5XHiW+YHMzhPg4BqW
	9jgWpg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4embx6ea9h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 08 Jun 2026 06:59:38 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-59eba324559so2444965e0c.1
        for <linux-wireless@vger.kernel.org>; Sun, 07 Jun 2026 23:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780901978; x=1781506778; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ijJ2Fs7y6o0l/NRnU4TC9ZpeExxhgCsJvN3KF+zKxuw=;
        b=LO0LSlwCBXkwPiJ08w8rhr5kfzZrzn3l/27TDxMT6986Rwrvr7YsCc9T8aNC/IvP/d
         5j+nI8sv8qKutNiBQXoburOEH48ul3bdIw5tGP7MpKKpVHmS/BzYL4tk3GZUB3zAsJSu
         rTPOwcIUsZPwgZfRsBkD8VDP97/Q1H583CJl7qUHv8JbhVNgJ2+BsvuKz85eoHXhoXSY
         qBSo8s1+AkPpu0LDO6/zeJqwlDi7jtMOk2CJIzignIWNZNydIzQnL5hqhGOk6Nmudx3F
         fnuwFxPUwlt8G5OtqX0bcNzWCyp+J4oXFS8TB8fn4SUSMcO/SBgLspBA+vhevT2u0VtT
         iQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780901978; x=1781506778;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ijJ2Fs7y6o0l/NRnU4TC9ZpeExxhgCsJvN3KF+zKxuw=;
        b=fzwukg9bX+BAKRsZWUfIH/dlEugbYCEPSe2mmoRIECPJNfkSZ7l97cCrVeXIyDbC2q
         JoRBitYY+jJYl4Cq9DES7zrrwk6U7XSuCP/37XacLOXAA7kXtKAqvjWUdSo8FKT6HG4M
         E+uXRwjv1G5Olt5+6hmKCgL8Q+x1iiVfCvugzU4MFfe07JOVC5S4cwYQuFH1m+iqFoiP
         mGK8YRjH396PmRTx9eOjd626JJSuOC+76Iowdy6Ct0CUFqW1HJnN+95ROA1WcJNBDcQ+
         bcMBHQ28Qvj9Un30Q+jRzjyZCzMgH6k3gG8+NjrfLz3RPkRbLHprdjIx+j1A2D4xcqdL
         lPpQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Lln1PxyicrazB7CvyscvfHf2vgU++bolmWgx8CbiPbUlOdYKjNKU+uSA98iutlPINDbJe0YtRs+URzbuwtA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoa+MJjcj9J99J8T5+Rkrj2gzxLNt8xIkNfl7e/oft4B+8g5EI
	/QLf0KWJHfkICd7XOCEo8wkMVcXrXtIeDZO6zJSYQ6sXjg47Ycpdcf27MLmTSffdFoiN50kC2o+
	8v/RtLhEcJFEXlyNJfoUlHNgZiNp4GCsqToWhfWQo664f6C6uEr8OyNZkTrp3nlVN7LvA7g==
X-Gm-Gg: Acq92OFYpM4ptqtA8AQv05KfEKYcOnZydUBg0TzNB1hmioedg8bPjKaEqFeIFQEnToK
	F+3m9dVyLKK/qvyPEosA5nE75zPvUFxcPC4Zd3NOjfoyrz4cygtnweMd/gWIHjwxUAAmY3Pe7Nb
	Mtw2onj+88KDe57NXEeFj8W0fR8VA20Me+xEkldf1HcDpywlOA1MDn82xShldrjQJSrHFuHzOb0
	NnRLgwEZJ/4d5JICJ2VUJueEttcTnd3a/II6pXhGZoic6//gTZHBIb9eI03XHKD05MnbDoqK2Ij
	Vgzecwazbwk66m1g/zIi1YeBcl/+A7adN+3Z1qtAKz17/dCPBmOBjVAFuX8WJVrrPj8eTHAuaFN
	0CF7um+JbrTpGB7OkAve4KWfddr9QxiWFROb0E3x0FmahcC6Qglua03Anlmev11/6xwyDkKdmpY
	IJeFuFyfpZqHfz0VxPUdeWdfyTUDBuDS+lWlPZmmdnYq8AMQ==
X-Received: by 2002:a05:6102:4189:b0:631:28c1:155c with SMTP id ada2fe7eead31-6fef118d103mr5591735137.7.1780901978120;
        Sun, 07 Jun 2026 23:59:38 -0700 (PDT)
X-Received: by 2002:a05:6102:4189:b0:631:28c1:155c with SMTP id ada2fe7eead31-6fef118d103mr5591717137.7.1780901977643;
        Sun, 07 Jun 2026 23:59:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8ed789sm3638621e87.3.2026.06.07.23.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 23:59:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 09:59:23 +0300
Subject: [PATCH v2 5/7] arm64: dts: qcom: sm8350: expand UART18 to 4 pins
 config
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-sm8350-wifi-v2-5-efb68f1ff04c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=946;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=K+dgZNHY5hnIkDIrCn9f4ZsTwh2z36hnTVJH0i21ga4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJmhLMPpbd/iMy/AOpMuLuKYEOLwtm4UqjGzc9
 c2zxSS9/baJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiZoSwAKCRCLPIo+Aiko
 1ZeYCACypuX/NOMni2S+nKV60V4Uzvrud9ETiK986sgV2kEiiqR3Irz5D9bjUu1QyFC+dxgjMLK
 fGMJqgWJ43PFl8xeHndud30r9tdgXfgppDFyKaZYq1FslQm17WnlFeMXcZNe4Ra/WZR/rBOuuk3
 mlnHxU/XnUBR+lkYkZUeY3twUskOluahTpW8iPGoVYhVSR7G0xsNEFhT2tdn5RCXQ7/s1lWXREo
 aSLJWYYNrMjuW0joWOScuInd6TzzVh4dY9JNAWLqg3H5eKwxHZ1E25Ml2kSpUmfoXHIpYLD+qt4
 tVVA2Tgd2ufVZAljVuyoNBsRV9IFVNyFf+0sESlL/d+1ce03
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a26685a cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=GNmHCbt0ONPBLg8daWUA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA2MiBTYWx0ZWRfXwUvkJ8KGsOM9
 Mxjy0t87nI2vtODXe6rUTeSMh2k+XF8LcNPuKDhtaGefdERyeV58LnsijHBdKJhPOFh0jXKnxm2
 ndG0Dy90M875TAuBLjIa2zoSMgYtCgdqpFvAfbNRLlzyTyr0W+sKaU9dwUIzlxILWEWeIOHb8RF
 icQ0ELd5aa+SFzNAoULOe0qlRIXXSpTROEt7Qz2yDPldc2o+OO/pq7WzvlnLo0VtyMt6E6MOwhg
 igvZRNHN4Z60DaBuciVYTEjLUOkwk6vQ6IF3gE4VY9hFlfQsGJ8KYzuARVHiKSCtfW2dkl8Tsgd
 OjxAGzLutZdrLwF7JGT5z7LbHQMkIOoTL0fBBy6kpuXx6jBPACx9hxmQbPd8z8613QnJOzpeEAl
 mM0KiSeAfTv1LRqcXVvsD4qkzfwzQ4IaXH1yu+tVwOdelnhg/w8kGThbceEaChOTttpuv7XiQUL
 /9fwulfmpUxm5MmbqDg==
X-Proofpoint-GUID: yZq58wZXewORcAvxdIe2HmsF0zN_VtzE
X-Proofpoint-ORIG-GUID: yZq58wZXewORcAvxdIe2HmsF0zN_VtzE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080062
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
	TAGGED_FROM(0.00)[bounces-37482-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:lpieralisi@kernel.org,m:kwilczynski@kernel.org,m:robh@kernel.org,m:bhelgaas@google.com,m:konrad.dybcio@oss.qualcomm.com,m:qiang.yu@oss.qualcomm.com,m:jjohnson@kernel.org,m:lgirdwood@gmail.com,m:broonie@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:brgl@kernel.org,m:marcel@holtmann.org,m:luiz.dentz@gmail.com,m:quic_bgodavar@quicinc.com,m:quic_rjliao@quicinc.com,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:devicetree@vger.kernel.org,m:brgl@bgdev.pl,m:linux-bluetooth@vger.kernel.org,m:bartosz.golaszewski@oss.qualcomm.com,m:krzk@kernel.org,m:conor@kernel.org,m:luizdentz@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 3E16A65357F

On SM8350 platforms the primary use of UART18 is a 4-pin UART (targeting
Bluetooth or other similar applications). Add all 4 pins to the default
pinctrl entry for the UART.

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index c830953156ec..eb2a795d8edb 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -3309,7 +3309,7 @@ qup_uart6_default: qup-uart6-default-state {
 			};
 
 			qup_uart18_default: qup-uart18-default-state {
-				pins = "gpio68", "gpio69";
+				pins = "gpio68", "gpio69", "gpio70", "gpio71";
 				function = "qup18";
 				drive-strength = <2>;
 				bias-disable;

-- 
2.47.3


