Return-Path: <linux-wireless+bounces-36126-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFTyNQaj/ml9uQAAu9opvQ
	(envelope-from <linux-wireless+bounces-36126-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 04:59:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F9C4FDC72
	for <lists+linux-wireless@lfdr.de>; Sat, 09 May 2026 04:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FA03012E85
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2026 02:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB01837BE83;
	Sat,  9 May 2026 02:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="krltR/1E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wz59frJe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236D1AF0BB
	for <linux-wireless@vger.kernel.org>; Sat,  9 May 2026 02:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778295554; cv=none; b=cndfoyIdkJS0XkXHe4HS/KSeqHifphL/xCGWC1t/7tPQ3hkG0WyJ0UxuFxtojeZNa2d+oFjCoCrtdAfZGrqS+fVd6C4BOZiIotNTHNuIebhilVy/JAC85TyaDWojFJ0MO03cMSD1j0igP3DtFmeK9TtjFszWrhhhYxs1+jcUlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778295554; c=relaxed/simple;
	bh=hKmrbggCsqwl3xa2oDVrVxZsv6Y5w5qqL4tEUmmu6YY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DfvlizLluX5Jr/TTHmrUvHHbMSyjzoKYpC9dwLjhqvbnwY9mT9VB5CK+GLBfLdnmavkZxj0PUOxgyfMX1JPPaT4v7BZPBRyZh+i2NKiTsDqKyCWdH6WJsGf4A81TWIbiWflk5FOLSLuCnMIp6WDsNsEni72HhHyEFvhjKqaTiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=krltR/1E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wz59frJe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6492ptv62866686
	for <linux-wireless@vger.kernel.org>; Sat, 9 May 2026 02:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=6XRFZm0NAsuadaRmB7wsJfGC93yIK12OgGY
	kO6e1tTE=; b=krltR/1EWggIRgNE57+uc70XKdLsXQ3MlhXU9uJGjRRW+8p7ec1
	PLD/a8yG7wK0DziZ4t6rTXAkYZqPa0hqS+ts6yLBbYTfn0BGsOLS/5wS8/joCzZK
	DVy7ADCPcrNhmd3pSQ/yHJ9BPWXTiQqrfLJL/nFJMzOkTq6RfhXNhZahNLm0qebE
	C0+GOxwNi6+M890QaU60uzu8KQpJ39FJBN8PxemKbN/3yUblyM9kBLMk6DCPGveK
	m1Jey/ZAOzSeYeZykCTDZlxrxRLkEKSx1ek++L2Ia9Nr4And7Ozl1OvLSWpPHeDE
	W4GdmazRHChsby/scEL5Zg2EME8OrfI8bqw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1vgy00ek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 09 May 2026 02:59:12 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-367c2d149efso540553a91.1
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2026 19:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778295551; x=1778900351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6XRFZm0NAsuadaRmB7wsJfGC93yIK12OgGYkO6e1tTE=;
        b=Wz59frJem/Wx1CXLNh45ZO7FBq43TgTqc/UEjfDYZqwOCfH5D42QhSov9DFfeNL4GN
         dxkrg3NOjgHpIYFIn3V/hlXv1O7fbAU/sNWkciGocctGeUOtH0q7hnxwpsFijeJT5WIH
         +6ER94CqEVE239cUrqmhcWcDtwTMrd1FIFbPLo0MEgTOPhnvlXqo2FCYty91dzotDs/O
         4cyK/msJ4Zv3kBd7ffsd1hmhvM9iIR8fD+uNYUJPs7oDxkqveQ8RdLCYSbKjPLFOCpwz
         EANRgoNyJImv3lPJsNmZ/Jv6vhnPAyNurVUg0JJ2DHFRZombeiyu/Mf96M7q/L+Thb6a
         UY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778295551; x=1778900351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XRFZm0NAsuadaRmB7wsJfGC93yIK12OgGYkO6e1tTE=;
        b=i3Mfh0WHH8p+gFdHabrDU6BvD9MRwDCZNT9AFzliSJhpO2MRSuAWLEOVvmd5tYzqYz
         4LnaM/w6BD3nHT68jq7fdc8ZgxcUSjgm9gSEm3QDskPAj8w772bGXRPJjNDcyxd8CdK4
         k/N2dURZ1NPTALlWiFr8Yu+rUQxmk8nmQj5J5DPEDtpToukFDysrYcYt5y4ngXHyCTjz
         8asnX9AV5pvedZix5/6XrGv6Z/xH15h4M8Z0m1H9umdSibrECcTGh6HBg6pTMFTL8ByQ
         JV+u7VkcWmK0/nZ4zxZVQ7P4oAlmfvfVlfpd8x49rMTAEzhI5iMzk/9+3HDR+5PmH2Mp
         9jXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9+QMyKgIE25+aYsvi3RAMb7gV1h8MU8LVAbQ2CJL3wugZ4AALvUTQ8ICXiFvaGFQXv6PI0Ie7OBQqZ820oTQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbquOzM2wE5yHhctVmtj+wpEyzLkedzqqIzzWbS5G+yhYuTPIq
	Yh9WGCqF8aNVpOOJRj7L7gyfOhJmxZH9MfVgql6SUocyrbwg6h+VHiEhzTezNd8A1IC1Eicb94P
	xN29QYuEiYAHnvOspPxg/FYxRw0IkjqxBB65K5DiKR03zl7+KKvEIshr2JkY8CXvE3r0yPQ==
X-Gm-Gg: Acq92OGm6U2PYabWFr5XzDxOTuaLmLAIzyb5wk7HVQUeMzDC7G84S09pxImqFLSSbPl
	L8imQo7KJ7gCko1GGGHquJQRa7jzJChEspsRmXZi+UCZKOF7WC2Y8t8/EcBDFDAWOOSVH0Xczzq
	m9aGYQ4HRiic1SAiFI9xIh/IuxYLeAmiw9Xg77mcDgxoIK5FjyT8xjB/Zwb76dbtDqIL1NdZrhE
	KY+NPkIpHKRueIa07kRGEg+8rE9dI9j73IZ2mQzdUQx+4cK3Dy08vrTOL3Zv3uvjosWn3DNT8iP
	G7YAUsxWfi3j29uDJtYC1SuU+T84rlhvLLgxn5XBoEayiXsilKJ7yZubXMAGL7/EeKyqP7VU4F9
	+UCMmvmrQLyaoS+iR4c+26OdvELybxKbq+hIAy2Artb28Kn5YYO8oaEM3gNuv7QVM7+7SqBgmYU
	yCVdXM
X-Received: by 2002:a17:90b:5683:b0:35e:576e:5bc with SMTP id 98e67ed59e1d1-365ac79c531mr15966869a91.25.1778295551214;
        Fri, 08 May 2026 19:59:11 -0700 (PDT)
X-Received: by 2002:a17:90b:5683:b0:35e:576e:5bc with SMTP id 98e67ed59e1d1-365ac79c531mr15966839a91.25.1778295550772;
        Fri, 08 May 2026 19:59:10 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-367be8be938sm750899a91.4.2026.05.08.19.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:59:10 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 0/5] wifi: ath12k: fix dp_mon RX parsing for 32-bit TLV
Date: Sat,  9 May 2026 10:58:14 +0800
Message-Id: <20260509025819.1641630-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fpHsol4f c=1 sm=1 tr=0 ts=69fea300 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=-ltJWcRUgt1K9avoLbMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 1iNgaoPXNCLsIkZUFI8a2mZV7tYed_v8
X-Proofpoint-GUID: 1iNgaoPXNCLsIkZUFI8a2mZV7tYed_v8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA5MDAyNyBTYWx0ZWRfXxZy1cwXl/NC2
 eE6xIDTz3rX/PxHCxAuEfH4t1JRl9GQK644ZhuL7DZ+e43O4V5VYgwPSTKcZGR6NzWVl0B0OJZI
 6VrOJg129IYWJV589xsQSBrxVDDvs5+0f3awlBiwivuL4tjGm568xsSA3Juo9g643r35tfQzApk
 NX2f8Rzxwg8V0si2QAERoOgA2HYErdh86AGn9kCCF1EGSWICgGEucDK1AjDSowefn8NT7330UXT
 SjuXVXsI/5b0jSMovOdwe7qugq1DguY1EcSFXvOodUi3lplE6T2zcboafppNr6nprxRELsEXdSP
 xSqqJwDhYU0lGrsiVYWpl17UlRznDB9QgMPbGCTinZIC3GUKzlpqOLbZWB5D6jOi/dh/6pp0lAl
 WV0kZWKQ0RgB6jl7yicXMZ7hq1zzt4qbrGlnenxI5wu5oBvBYNMoIJH6DSKW/ulkLiEG9g4/O4w
 MXq/EhgNS9ZPa94ikiw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-09_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605090027
X-Rspamd-Queue-Id: 27F9C4FDC72
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36126-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This series fixes RX monitor status parsing issues on platforms using
32-bit TLV headers (e.g. QCC2072), and tightens TLV decoding robustness
in ath12k datapath monitor handling.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---

Miaoqing Pan (5):
  wifi: ath12k: fix TLV32 length mask
  wifi: ath12k: refactor HAL TLV32/64 decode helpers
  wifi: ath12k: add HAL ops for monitor TLV header decode and alignment
  wifi: ath12k: add dp_mon support 32-bit TLV headers
  wifi: ath12k: tighten RX monitor TLV bounds check

 drivers/net/wireless/ath/ath12k/hal.c         | 42 +++++++++----
 drivers/net/wireless/ath/ath12k/hal.h         | 13 ++--
 .../net/wireless/ath/ath12k/wifi7/dp_mon.c    | 59 ++++++++++---------
 .../wireless/ath/ath12k/wifi7/hal_qcc2072.c   |  4 +-
 .../wireless/ath/ath12k/wifi7/hal_qcn9274.c   | 13 +++-
 .../wireless/ath/ath12k/wifi7/hal_wcn7850.c   | 13 +++-
 6 files changed, 94 insertions(+), 50 deletions(-)


base-commit: 14d99bd40a8e3a80398dc597375fc7516ca488dd
-- 
2.34.1


