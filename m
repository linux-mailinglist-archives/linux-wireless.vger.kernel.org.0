Return-Path: <linux-wireless+bounces-28966-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B42CDC5C930
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 11:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1560F34FC0D
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 10:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0820130FC24;
	Fri, 14 Nov 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGxL+MnQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M6FOnSvL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D230BBA4
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115754; cv=none; b=b1wt8ZN60oL6cXubHLAr3K0nN8U4xOmnasU9dLGQzxSbEEe91hH/aFHUBSpTcRxZX1IDJSMQBcD+X3/nFUvhE1hEXrUcXLM6rqWEyBEzYm89dvbjuAWadVs1yhV1bKlgx99hnZqKmKgu5IVcpaZuZ1PIXpN+Pc/zNJwGJvIbV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115754; c=relaxed/simple;
	bh=j/PKjIKUfk95DiARFEqBQvQIr6HuYNqBqicJ5GkXt/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SweRBMwcvrRUywf8iBItWooQZ2racHQan9fMPs3rCsSHF+GkJazaIlQrNDUbS9nN5poAJIy3bljsp+f9enjAeeVHN2MvjZRD0CBs5tXs1kpLJ+mnsj7BKMsxYPxwAF/BzGY8b0R854OdwcP5SUG2hhQEo5A78UQ0eEF8cZtu6sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGxL+MnQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M6FOnSvL; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE7ux8e1699548
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uIlFMtE7+uqEi2dqO5eRBa
	DzL075sUhviJNTRcYSEtg=; b=pGxL+MnQF/1UYj0MQNAUqKavZKYwCdgzgnnD5L
	JrYWe7kd9HWeGc7wufPRrNx3RWZSrj+wRFf8ya4vHHI8O74jquUixEC9xRVi9zbz
	wAh3VnXZHW4CxIqrAZPQ1T9XaPxBZq/lWBMfF1ZS2mPOkb+6eiMbU3gAZw6u3Tfk
	NBXUgEM8Hh69vl+CXI1x1ogFwbbxLrYkpV/9NErbAzU/ANNo9xP6VUwkflUViRpK
	ZkG3JdaEavXimsaB8xoqWuEL69FZd1wlDuI5nKDEJydmWeuxnLT5qZInF7GhlXKz
	1Sp0BvvryDCZd2YDXUjI8eZ1idpghST4ZRbTpvE37jB8glkQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4adr9e1tjx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 10:22:32 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297f48e81b8so35046465ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 02:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1763115752; x=1763720552; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIlFMtE7+uqEi2dqO5eRBaDzL075sUhviJNTRcYSEtg=;
        b=M6FOnSvLRgh6G3uJMlPWQy+2y3moAfPJMrZLGm3DzRaqI1Rj8xs8Q5BUC4h8NV1BpA
         Wsmmv9cESIUcXc00GvJ0CXg+rz08Z0kKduwALR+xpdtTNfuLoZ02ygJf12DmBOzu4fV/
         vLH2hHnB8vke0pxp50lY0fqkoyGCltVLv0Xl14t7AZpUX8rOqtPUstibPdcVDiF8gcib
         Sz3EBnA4rMxwXwxkAOqIjr43VchRdipldnkOlJ+ImDso7GkGHXQbJvkX5MVuFNHwpaxC
         U7A5jcLMEQJZgH+YBg68uqGPtnBhleTqS+fGcQb5v+upwNM4MMawkRlHxb9zFC5FMSGx
         p1Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763115752; x=1763720552;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uIlFMtE7+uqEi2dqO5eRBaDzL075sUhviJNTRcYSEtg=;
        b=ngDCWe770viLaELjRFYmuV3p7VTP1CBcW1Moq4Es9BH8n4xSotjA+RjE5prYlHZQAy
         B/fo76KGndZ+HDwmKbDReFQXDtFAcz1OAyJ2PP1PwjZuW2Q0gumbXKkTrilG4u/6xNDs
         2eFsDKUx4NERstmeo3x5mJNT2PUSJUM4RtPi7+SvvOV6ibVtBv8L0t8ibrwjVVQ3Q3EE
         v5Jm7MhJTXKVCnbBg/Jgg/RNmi5EcE5LSC48d9G1oQ/f7lmO2u86HtG9pZqFAwh153wR
         0Sev23a1ZdeROQzDUXAAhMOZwTt9W+qqR9/cfQlDjzipDOBpEQeZeyWjN2YjkoT+yz0t
         x0YA==
X-Gm-Message-State: AOJu0YwgMlV8SGeymKORUUJv/LRzFdG+YMrw+qOYk+9Aqs8nUjwTzBko
	PQld2pd5e9N3ZYMItK18XemVhD75slJWrJ0Oo1K/VETmXWyJgRCyS1xFL44LDsJeVnshvdCgiK9
	EYWuqyS4t+oiPOT5AUF0dcT9l7nZqx42endy1BP1W/SVNp1elA//rY0W+DOoQVsAzvHudxg==
X-Gm-Gg: ASbGncs0J0ffl2q9zJzYXIt11al9PHyx3PZihsFwbuHCdP5P0uWp/OqbAhVx51TZE2X
	8eHn8hrv5uQOtEMxptxk2NNwYY4VuFeXomYFIVD8hHC68llYfJU4hlGYpw1Sp7/J1qWZEwyjXLL
	YYT8ysl2aJDzeZuOeJy8LJvzi5v/2/Iy5oK5SNkaEm0iLuIYCokzwRASnbEVUtrqkxuAt3eQ0Cz
	i8MIZQEF1Sg3G2jkNozdn/MccXUoYnio1j6c3ixb1cgJdpz98PHgx3//EzumfzJPwq9otC4oDoo
	9/DGPGd6k8WgktWN0bk7Y0JtJvq/1sF1bpNStBhGe4NtCJD9ExAO2H6g62VdbkLSZsG9c274T2k
	fsFzbLA5ol1nDgiTXQa4CpYoWRnr3
X-Received: by 2002:a17:902:d48c:b0:297:d764:9866 with SMTP id d9443c01a7336-29867f96635mr38151655ad.18.1763115751671;
        Fri, 14 Nov 2025 02:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDSKi26tdukeeIUa759YbAGm8in+yeMJs9CiwD9zYXP0yERmgL0JB9clxX4ocd5//gfGhRzQ==
X-Received: by 2002:a17:902:d48c:b0:297:d764:9866 with SMTP id d9443c01a7336-29867f96635mr38151365ad.18.1763115751169;
        Fri, 14 Nov 2025 02:22:31 -0800 (PST)
Received: from [192.168.1.102] ([120.60.77.228])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245edasm50883705ad.27.2025.11.14.02.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 02:22:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH 0/2] wifi: ath: Use static calibration variant table for
 devicetree platforms
Date: Fri, 14 Nov 2025 15:52:18 +0530
Message-Id: <20251114-ath-variant-tbl-v1-0-a9adfc49e3f3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANoCF2kC/x3MMQqAMAxA0atIZgM2tCpeRRyiRg1IlbaIIN7d4
 viG/x+IElQidMUDQS6NevgMUxYwbexXQZ2zgSpyxhiLnDa8OCj7hGnckaitnXU1O2ogV2eQRe/
 /2A/v+wETW05hYQAAAA==
X-Change-ID: 20251114-ath-variant-tbl-22865456a527
To: Jeff Johnson <jjohnson@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        devicetree@vger.kernel.org, ath12k@lists.infradead.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=j/PKjIKUfk95DiARFEqBQvQIr6HuYNqBqicJ5GkXt/k=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBpFwLen3xdeGzsMaTDYYCd7OIuj1AlYd42t7QKk
 jD2Kk+Aqo+JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaRcC3gAKCRBVnxHm/pHO
 9ewcCACmtiz0Gz3fOX7r5tZ+YWRiRMerLpeJA0jPU8AvfSaLdbbEoWDG9cAIv/KiRadqPFBf9Wp
 qjcSQYo4UVxee3OoblE295aPsQb1bKi1Sz1rqFJYQZljeAsf2w1E0WUBn1ZP+MGFAJj03yOrsTK
 xNUKsvXbOlk5iOrRyoa7rAhS2+O45RSL1zuRzBHkE2I00oBW3utGQr7hHUXtsgQP5qfSo8E0O4L
 AY4s3zF0p41qM8JzBD7nxmiacjE0+cRBpYpeoNvN3ii6LSFIifeTht2foBkbpiHbXLjZGCCu+Mw
 DzX/sLR4afzV46gQxlkwGYjZ6Do5PzAvcS39/jToYCd5Zd/U
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Proofpoint-ORIG-GUID: _Fe3Rn5Sn-hfX-Xe59XlWMql-JXK0oUD
X-Authority-Analysis: v=2.4 cv=SvidKfO0 c=1 sm=1 tr=0 ts=691702e8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=9R49FEQIXN7mQozuOwW6cA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=G88tG2J24DvW8zjn4CkA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-GUID: _Fe3Rn5Sn-hfX-Xe59XlWMql-JXK0oUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA4MiBTYWx0ZWRfX9OOdy6+Az/iK
 VLFficZ9d4Dm1Y+6pTDTcpau2itaHTweL7HvYKE3fXlKYj4QdfGFbtP1mU9zxAheJXmDLFTqpxf
 cOmYu+rg9CILauw6Q+X5Luu/7r89hUMW0fBN+BvqMEwWpTygYNZSgckJD+Z3cusKI+9wzYkE7H3
 PoLU71M0N2TzHCh8nL1fzxaHksuafJOmUmngyADSG1iOZmnXiM862J10mGypAzObTd3F5idBXJY
 tD44+ShaXB9L7yX7bgrIHkufsmADm7PJGwN6zsP07eluKFrEAJBYngI3qYG3OnQZZn3N7sSb7og
 tgwm+K6DFB6VJ0Jgo41tsJCzYzu4a7ej5lA0hmAAbo84BNRdhCO8f9KXbCFodFUz+R9yzDOsaXG
 X9cdowcqhfpaHmWNwHRVnMtybUbylA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140082

Hi,

This series aims to deprecate the usage of "qcom,*calibration-variant"
devicetree property to select the calibration variant for the WLAN devices. This
is necessary for WLAN devices connected using PCI bus, as hardcoding the device
specific information in PCI devicetree node causes the node to be updated every
time when a new device variant is attached to the PCI slot. This approach is not
scalable and causes bad user experience.

So to avoid relying on the "qcom,*calibration-variant" property, this series
introduces a new static calibration variant table based lookup. The newly
introduced helper, ath_get_calib_variant() will parse the model name from
devicetree and use it to do the variant lookup during runtime. The
ath_calib_variant_table[] will hold all the model and calibration variant
entries for the supported devices.

Going forward, new entries will be added to this table to support calibration
variants.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
Manivannan Sadhasivam (2):
      wifi: ath: Use static calibration variant table for devicetree platforms
      dt-bindings: wireless: ath: Deprecate 'qcom,calibration-variant' property

 .../bindings/net/wireless/qcom,ath10k.yaml         |  1 +
 .../bindings/net/wireless/qcom,ath11k-pci.yaml     |  3 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |  1 +
 .../bindings/net/wireless/qcom,ath12k-wsi.yaml     |  6 +-
 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  2 +-
 drivers/net/wireless/ath/ath.h                     | 98 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/core.c             |  5 ++
 drivers/net/wireless/ath/ath11k/core.c             |  7 ++
 8 files changed, 115 insertions(+), 8 deletions(-)
---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251114-ath-variant-tbl-22865456a527

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>


