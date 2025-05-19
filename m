Return-Path: <linux-wireless+bounces-23149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3EEABBA28
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 11:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 054B91B63CE4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 May 2025 09:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9AF27586E;
	Mon, 19 May 2025 09:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RS+YL75N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B1275857
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747647807; cv=none; b=kn/YkokecbwS5LrmUymV33s0qAMtXgirRr4PWWrrGPAG/Lkgtvx4IKKLkMHsPaxkRnhvhLSkiYM9xrRhEzWqcxVMbW6eoH44XbLf9I9OhDU+YujTJrakOfn2eVUPh3Z5JWuz3FZoxBU+4gj0zuddUXlQuwVKX2//76hSrxwAKjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747647807; c=relaxed/simple;
	bh=xsy7qnLw8evkZCbeD6p1+RvCRcE2R11sd9iRKK+i99A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+XPAU1Mo8wuIxQOM86BX4iZz6yk/weMH8sP9EFNDMTH6OKlcXj9E9u59HfqbhXGHfoAU5gmddegLM0T7XxE8ZqgzHKEdFhC3TDV9oHLKGkiF6Z55axmoTFfpgxasWJDusKvFY29N34W9sR62q9LfQjP1LHF03t5vTQmaU8tHZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RS+YL75N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54J8fe2m031683
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ms4AsHGtqF6++l3IqWfdW5IwKyh+gOLE1wk2h0gxx4A=; b=RS+YL75NsAXYwD4h
	vOPSfO9/6++DZ3QSQOHFI3BvzmyhvOLwftO0SdfpaojVaKKwo+DLzSzf5UAMdrTC
	dVp/5+XMAzkHxzkAIj1asWiL4ieyPHUAmeGaIZeDfdiuNd5CpGhqAF59dl1CJj+z
	3azDRP8Pb6ASd0YVDXk6hRUn5qE4j0ZPh/WvSx3yXiaX569rqAPVzC8FOsEhIK2G
	7kr1WNkoE57X30ufXmItEnIG0xJcM1YbN1b2Xmfz/UVoGab5Khn8c+Q3NHNe8uIL
	DBI+TErcBCECOPK+P5C0pY9oXss+JRRw4c0mPVh1/3mx7xe+sNtVOURX8Q7WwyDg
	d5n+NA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46pjkykyhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 09:43:25 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b26fa2cac30so1324901a12.2
        for <linux-wireless@vger.kernel.org>; Mon, 19 May 2025 02:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747647804; x=1748252604;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ms4AsHGtqF6++l3IqWfdW5IwKyh+gOLE1wk2h0gxx4A=;
        b=PCd1pCGP57003J1CBMmNK327nCxdEeHzXeDe7nSJ+4vaMbL+so+3fPqw1MgdjjraAt
         YTkdMzzUhG3EkkqFDa3pQl4eFKjtUzWjI2UQzjyRqBimmxA+UUbhMm0mTpKV2ld0AKBz
         /FYlckGAAWsZYQA5pbaZAuINVyI+80LvZdxwfGtD50x/GJXhGf3FmDh4TSnTG1vrhxC8
         wCKJn/QoQYzPxBjuOj5BsViEnk0pIEAjgOx0KLJ91x9SYgtKCZEbr3LsNfq1P7rHIMDI
         MEDnnHbPtNQesZc3fIv9M1UeNqOFh7DdlSjw8UDHwJwEpE9Y7+7lqOU/jUrt4yquC59s
         YWbw==
X-Forwarded-Encrypted: i=1; AJvYcCWtruP+28vafVhVo12hPZV6LS4xu0HCg83LUZ/fGwngxCGOX71P5cn74pyr0hAApxUybDhQEScXUmbXK91I1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBFI97lIrKfc5nnKKN45QnReyO2vOXeVE92IoQjT9Rpf0FEY6x
	8bBWAujyvtanp8kC7cmliNBebaht37JVdJLFcD9LlwxtFuHqKcZp9jZNfAVnbojV42puEPmeIt6
	M+goBAso+AKivXcnNaznN6NBjV4VBM9Hk15qstd4Tyssn6UwW+LbAPkVoYM0Hx6iI2hCnLA==
X-Gm-Gg: ASbGnctkLKxz9NQxEx0GvOlO/DgstGQcd4F6JBS5rL4Kutn0lwDbRyBFGNLe7FPbEh5
	ThJGxJy9Ph4TbKUIMHK3iBQ71lVemJUZ+9OG4sbOisKcAzsU8jCXsSZz/OuTCk/5ZPEAm/j5vpa
	LHSDulEKiBbOClsGsD5uLcXX3lrXMu3l8jmnoezvd3V2Vruq0qtd/zxi4NwKg2ly9UNmbxBmP6r
	UVrqPefmSNIYKjWALrSQEm3hDSvl4psyesEDVLI6DNol3l2oFDLC310rgSVKeD4cNMTcKEZr2cd
	O4qdO73L7lSfaqJjE62CKks9LoPjBdJDPbfyp+1qBa777sM=
X-Received: by 2002:a05:6a20:c681:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-2170ce8c064mr18624943637.37.1747647804348;
        Mon, 19 May 2025 02:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI8bB3sFr0+tAayp3kXPL7kM6eemjerF+In7kpKG9A5RQSxk/YcDRJJ2IJ/dU+O5cjxvqLww==
X-Received: by 2002:a05:6a20:c681:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-2170ce8c064mr18624902637.37.1747647803999;
        Mon, 19 May 2025 02:43:23 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a97398f8sm5809092b3a.78.2025.05.19.02.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:43:23 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 19 May 2025 15:12:22 +0530
Subject: [PATCH v3 09/11] PCI: Export pci_set_target_speed()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-mhi_bw_up-v3-9-3acd4a17bbb5@oss.qualcomm.com>
References: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
In-Reply-To: <20250519-mhi_bw_up-v3-0-3acd4a17bbb5@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747647743; l=732;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=xsy7qnLw8evkZCbeD6p1+RvCRcE2R11sd9iRKK+i99A=;
 b=RV/zKoNt4pz2Mou112fotyg8c0PTbzunkvtBsWXq2bk893o8qU7lN8dMiEzhxdflw+gCEpJv7
 9JVlb2oi2ZZBJOg4cF+FTL8G8iN1iD4P4HAC145b5z3tE5eyuOK7RZF
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: UA1sRNPWft0IuTkriagk3I-Fy8AFq8ar
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDA5MSBTYWx0ZWRfXxCXbpIpYFHTp
 PjTt7p5xVk9VmPZmmocS9PdN4Fz6TJAxs/Yr99f9JQ0Ep2cj+efspNLiHVKx1FDuT2HR3y6A+s7
 oSzpIOysEoHCBTyUveHsqhdYOCUxJVmlaW2JVvZIeH2NNKIYdPi2TbacGIBooa1rO6hh1OsZ+AI
 AHM+l2bEUT3ZUNnwG/mM2VYW9JG9qyOlOGdQEMgaXrNypr4WSWpc3V2KwlYo45F2oF+LC/PAEo2
 EjT0dg8IrctLF/nOpbAVvrFPvM1mCSzUPgM+2t5km5Lez8Inc1RU0/3zisprnU6XzLPYT1y73NR
 jJrfl6A0FDgHWvzSNZpCH3gKI1O3WIJcAPnuyJUT5iCSLWwYS5Onh0HaX2KlF7l5OKwE1c3Y3op
 1cLANzcW2i7TCswpG++ELjRZZfSjBzAayOOg56Niy84l34cxJHuEFbB3bZjimTfmVoO1JiDN
X-Authority-Analysis: v=2.4 cv=H8Pbw/Yi c=1 sm=1 tr=0 ts=682afd3d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=JOcJ30pghDwnvxMqNTgA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-ORIG-GUID: UA1sRNPWft0IuTkriagk3I-Fy8AFq8ar
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_04,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 mlxlogscore=917 adultscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505190091

Export pci_set_target_speed() so that other kernel drivers can use it
to change the PCIe data rate.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pcie/bwctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index 3525bc0cd10f1dd7794abbe84ccb10e2c53a10af..02c544c6186b8c6b87730d1c924f07858571d2ae 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -214,6 +214,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {

-- 
2.34.1


