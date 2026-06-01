Return-Path: <linux-wireless+bounces-37243-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHJFNtZWHWpLZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-37243-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:54:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DE661CDBA
	for <lists+linux-wireless@lfdr.de>; Mon, 01 Jun 2026 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82798308B739
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jun 2026 09:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B639B4B9;
	Mon,  1 Jun 2026 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OSXPRiVh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Tr0zOkBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F571397E88
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jun 2026 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780307233; cv=none; b=Ly+E5kaHte/SgSrwLea9VGkefBzXwmqW5A5elmuc4D3Ww/4qa+r/DDRem05ijoY3X0TNWrH322NJtuY09tluY+rXdJZRo9/Tf2x24c86PAJMlKIcVYcZ6Y3yMYrjG3A+gv7WRsUnyeJhgHfRdVeHBTTLk2yDzK4JcTDPMgfPZ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780307233; c=relaxed/simple;
	bh=i6kjUXsWMMvGZpVkGZgoZuYG86BurQaFVacwcpsLGpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b8WNLZTfiFQdEHedLOGyxfyw8o01Qz8+wNUlemXtSqcnYAsCKeVowH5KaCGSi2IKWkAh/FshClSErfuih5Tws1guTFkEGN2bRLab5+gk5F6w05yeWeTEgGKx+uMHEvay2phqfxyYnUfbhLgYlbUKK7eEYYoe230AI6avKZ5RxwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OSXPRiVh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Tr0zOkBJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6518fdLd4065896
	for <linux-wireless@vger.kernel.org>; Mon, 1 Jun 2026 09:47:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=; b=OSXPRiVhNRnIuaFt
	/jcJLl1uTz1vgCteCW2TVILz4LUaqeb78F/8e1kA+LFt9iOriTBRbvnVPMo7S3WD
	EucL4DJ+Q3UeFkKW0OBUIlJIPZ9WIsiCDRhMeuSmLuBTfj93IxkuO5xC2EBPqqKw
	4QSzBa/wUwoL6osegGrgwbeBuQX3vIJKE41C2qhQ6P1wrP2WABBcCS5A6adZWT+4
	In5J08VCcgwDxJYQdNeccZSkdpg+KLjbbKKsR44xK7KvVylkcefk5x4al/5kYyWc
	ZyGe3+7dCSdQG/rgmyUah/PYPc5DUgBoTWmwa+Mg9EvknrnCQ+Qx4dz0ycQiCicW
	9B396w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6swr9eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 09:47:00 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50fbc70cfbdso191828751cf.2
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780307220; x=1780912020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=;
        b=Tr0zOkBJeHphvTytgoiYr5qnL3wcr3YRmqPPucMbotR1xxDuN71KHnMxAG4bchNzpt
         NGhIGdR1tsGlqkxghjKoSZhoUP3PpxhHgQQgr/KL2t0PUb5Yn8aQ+zySVhBr/fMOMxbY
         iLHmnv5e1TMaoYVQrmn+UMI+vgEQ9PmIBRi5iWElHq6E5II4bKzyBsK5nQA1fyvSO18H
         loVeArV5E8r++o2XoENHiyMt8iAMJ0N1zYP4cIx/Z4HBsYRX14gHzN1SMzld3MzTGb4Z
         5z2HOrVCPAq1c3t2y/R38FstKF7p2ZY+jO6PMruz8OQ75fka+figlCzeNcHulJ/mKWb/
         A6/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780307220; x=1780912020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jBqAtuuc8EnhubMic9V4p6HI7fal3LjjEneRXtxWqdw=;
        b=iOGqzzF80ql+NjB76y+69TiRk3mqDwT49d2KhKyUSnWNSkerXfPRqSqzS9Btwx+3G+
         F2XMYAFiJqjsc34cceNFr+hiVyMYwM9uFtA3YjQ0d3u+RJRYB+odnTefXJzef4VtjgPi
         MQWLyMts6XVGEF3pkl4xzVUZ89MriheOosvX3Ql56VMycBJ19yVzHmrkijn5KuiHJNnj
         Bu3j7kgaDBsIvJTK+BFWxhHbCcw830rBQ3tQl573U2C1pSN9xAoiclgr229MUY3jnkx7
         MufkNZU1vRDgb8cDqJNolEkr0pdwGBTHtM1T/MBfR3rmkG3oK41j1JRKVsYWwtBUWR44
         YTZQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GiuOKEwpvy1iMWM4sA9hYZXmOhqbTZRVeB+GvRYwYKcB3zC3PaT2SHKjlz7wmWt8HFTF/nv9UmDjODe3dDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRzwdMRYcmYb3AvSTo5tn9b47JHBgziN7EeUCqPd27dPTPMq1
	qbffwoi9DTcOuXhLPb6xFvzOKrn5J93oEe72ZTSgPt4liXCyCdGtIHz3BO/1eIV1XUr3W3rtb7U
	Op6eVB9XJ/Sbs12JPkn8Gv4zemPZktNvgnMMr3pZMRV//0F8nhP3kGQmyjM84bZd3eoI0xA==
X-Gm-Gg: Acq92OFUDERndmcY+fvHBqThK8gtCZf69wEsnxJpK7OPT04YPownTelhBMqQtXRRuqV
	bI36pJEcNGyGvxx4qQQTPjKCbwJs9dWo3Xvq5U+obckpPLfcU1qX564UgYWap5xlqGhSd0CJ1gq
	mEhn6D5eL369usfp5KN1iTlqdoqs4R5E1nYr1C8OSpILDFHn9Fcc4gSb/czZSjg2197eU1ZFITX
	ygR5JTm9bGrPWZN5XaJf2Dl4wlm6yGc0P1UjeOAgPChxCndlOmvR2OGYr52KU1+jmCVy/s/NUqe
	DsBigPjS3SH+d3j5CRUPgZQNpsbTuTz5D/PGJ8QTfYo2gdZCA0taVpAV9Lc+rWzXd4XqWvpAIbA
	/x0dZ7GfaYtuPGxCnCxRRQaPApiv3NUF34N+JLg4mYk8zmFvSvU0KrSAXAfFnNWVnbU6fosQ6Z9
	431sNg5aY+B/wIUNdgnlhf1+FYGTzq1D7j6Y3CzHxbQDuapg==
X-Received: by 2002:a05:622a:a887:b0:517:61d5:2f85 with SMTP id d75a77b69052e-51761d53795mr1967971cf.33.1780307220294;
        Mon, 01 Jun 2026 02:47:00 -0700 (PDT)
X-Received: by 2002:a05:622a:a887:b0:517:61d5:2f85 with SMTP id d75a77b69052e-51761d53795mr1967561cf.33.1780307219912;
        Mon, 01 Jun 2026 02:46:59 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39672802651sm15355201fa.1.2026.06.01.02.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 02:46:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 12:46:51 +0300
Subject: [PATCH 3/7] regulator: dt-bindings: qcom,qca6390-pmu: document
 WCN6851
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-sm8350-wifi-v1-3-242917d88031@oss.qualcomm.com>
References: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
In-Reply-To: <20260601-sm8350-wifi-v1-0-242917d88031@oss.qualcomm.com>
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
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-bluetooth@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=972;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=i6kjUXsWMMvGZpVkGZgoZuYG86BurQaFVacwcpsLGpY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqHVUKv+ohTcsEMq/gMqjLvJIpmvW0bhyzz1rra
 Zau+IHCLCKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCah1VCgAKCRCLPIo+Aiko
 1bnUB/wLeiJktyGGPY4RKsuvLJcAoQGkQZ2y6YnS6kBfDk+PqAEP4E9tvABS87UPQNzBkz7dswi
 1QqhKybyLK+mnYwrtDDXhsvf2VoRJmi5aB++NIpfdGVEHiXdMxUF5AS1W+rDHHufWgpaGnu7tjC
 2z6jdD19j21jrbDJXNugJ0vqMTREb4DJdU4F6XwHn+fZug/DND9RTLR3Rwdp+Y/b4odBDze3n9z
 N0qozm1xPRUodqPHVrA57id/TE3sI4sVSYd+L+fCoW+Mae04ma3v7GSg9jH4uQviowH1dAZjaaL
 zY+PMnTjXfiKTspjputgXGs/F9wRj0j5XIQxm5Af+X8X8qq3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a1d5514 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=NEHNw5bNxon9FmZXvbQA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: HCqKOGXvEC4UK7tS56Mb5ZYpxpijCBhd
X-Proofpoint-ORIG-GUID: HCqKOGXvEC4UK7tS56Mb5ZYpxpijCBhd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA5OCBTYWx0ZWRfX8GpJS3DzKbjY
 f8DWfF/70kvyQYIsSRzG7Mz1zazbyP9FIDGmwx2bM3dxTWGkB6RTbkDfdLX7c5YJfBa9p9gxJMf
 amXLrJUrTGXmzA46b2XWH6JSvFkp4RgOcTeD+dz6JDIayFMRdd8d2AAS+vI6UltGZYLA/tyO79t
 iu4FcY/78CwHwPOjJfO1ZqSBCxW2WtbeKdxG9a5vfF8qCh9rm2TMLPEz5nywzqq4hav54Y35TKI
 mMp4qJwxkSLnQMgjB7Yncsyw9EGMtgwxqXrHP6hq0gDrx4jW+HPXmQryxGORXDz80trAGdxgzYf
 dDLfQJsuvpmv9G2zisxsbcH3O3oa0WNJphrFrltndoS6K5fRda1gsTn7N0uH4QNfCX5O32N6f0E
 iIICHmutgHdpwodOLqA+/Kx919eTVERLYDvCR5Rfm6P2u3yhqj1Z0LTl5/2gB/vwIMARnbKbRf+
 WwZ6SSVSh9Thtd3zymQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010098
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37243-lists,linux-wireless=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,google.com,oss.qualcomm.com,gmail.com,holtmann.org,quicinc.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 92DE661CDBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

WCN6851 is an earlier version of WCN6855 WiFi/BT chip, compatible with
it. Add a device-specific compat string with the fallback to WCN6855
one.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
index 105174df7df2..3d3c6fa7ecbc 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,qca6390-pmu.yaml
@@ -21,6 +21,10 @@ properties:
           - enum:
               - qcom,wcn6755-pmu
           - const: qcom,wcn6750-pmu
+      - items:
+          - enum:
+              - qcom,wcn6851-pmu
+          - const: qcom,wcn6855-pmu
 
       - enum:
           - qcom,qca6390-pmu

-- 
2.47.3


