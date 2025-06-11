Return-Path: <linux-wireless+bounces-23995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67BAD5B96
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 18:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E90E173BC5
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 16:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B94202F9A;
	Wed, 11 Jun 2025 16:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E+UlaHD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CD1F8756
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658446; cv=none; b=HFLO3iOu/u+2Z7oFYS9LgwJOZHYCBgVKmImv7BlPG8kTckHVyt2+Fa8DA+rhK+kkhtL5ldEQkGPqvvn3qpG5710WYjT81FX/LBmQT6F7yHPYjXXmm6EDQJPoCpgVESE9ylbsY4IVLjB5dBf2TbhRytGB2IWYcSypVg0u3ny4uTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658446; c=relaxed/simple;
	bh=vcsYkkT3PzhwTboVZCTSdHIbRa4L8/yfe7DOCfmDlFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ib1N+abTaYKEUPzwWL/dHarNvEQ8xAs+amePj50j5HcQAY/UYEXBauyzczvoy9O0aNfnD8vadrNDI+DlLUji27qkLBQuOW5zVJQIylXuIkmqNfuTZbimhxtz8WJvIRymhiB9E6YtJEcZC0nQUCV3bqlqD/+lsP1conAEpAlKUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E+UlaHD+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55B9DLnP011142
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Dxy553rnl4iOCCwPBHilJZl8dv8tb7Ojmt3DJ4lr9Cg=; b=E+UlaHD+abXN/FqV
	KGu70ycRKjIcsBjDL9u1b9B38gQfKZI23A1mdIIdm7HDI2wckVfqiXQnIR2dPtVO
	K4elVVlWcNt1Mpg0THT2y+fTQGgT1RjDqph4a/QqfjwxLDe97URcD/19lnMG8zjI
	pe1yml7lh0QT842Ubjm3JgmlbyBwTiDdTJj8kVBTdnTGR5FqUmb7CustPBjixSN7
	yeRJi/iMDQiQbD83PQEmpugOl+WA3aGnpqPvEJfyQv0aI1MNJtRrHD617lEC39a+
	0rZbTFvC8qDG4t2gaG4c2xpYjrCDIglRhw62yjhYaU5hZK64MvOj4WYjGB2BRS1c
	DELFsQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 474ekpw938-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 16:14:03 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7462aff55bfso30885b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 09:14:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749658443; x=1750263243;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxy553rnl4iOCCwPBHilJZl8dv8tb7Ojmt3DJ4lr9Cg=;
        b=X7XUf+JGlo73+RniWhn5KpJjbLDIZk1qmaMq40USi3EbfOrmIHHAQUM/MIZEuqiAgF
         B9R7lzDH5+YiUT4uBbqDy9U91+WxtQxhUUQdMZI+XepMGmrJRGseXv/kZ4KKYKKt9snr
         KwLULoPFhiYR3wIUofBMimucd9dm5b22xPif40Q2IJ+P4yczVmPb0gSJtUSvxvZSr3SX
         g8gI/jN+GAp9HokSuLQTRycV+YwMaU4f/opcwv8+QKyPW8omDbuAkiSM+5THkqOpjWN8
         6qHE5e2ovCp09SGwMKftQ7RDxSh9Cjg3l86AaN4LJMN09TmyQ8E8Gri6Qk7j3czw6YpG
         6KZQ==
X-Gm-Message-State: AOJu0Yyh5R8It+WLbXBaqPDisDDfs90ltE/HLNSPVSPwHtAAnBG28/sv
	1oI3x8q19wsq9gmcOZwAdpkhfUuVg7sYO/+bdj31Z8e2Oo+dTRXkgo6yyZ4HTREI6QKgisUkTm1
	8Noq6Lxe5PI+E5DdC0oeuIHI0s06OSXLWBppNJxHQSousOer2bWkAZPFovQeS/DYmllCevQ==
X-Gm-Gg: ASbGncsBhrDj2Oh0ewdr2j1N/uqrn+GpV4ofYMp3SGANkd1e8U5fKjQ2kFyzOcj4ndM
	Yzhj0hBFPUSBZXlrAhZcDyRkMM/95073jFrpg4jRbxPk+7Vyhlsa4r6qwjK1PH1EVeyCIq3gj6i
	7rCn4FtC1pLOxy6nKplnRcF1+1RaVLXTAL2BBlYtI2JPrKhSZwyimJw/kMIrrkr28hSnu5xzekt
	YjFeU2Bt0Er56vgRBLgBLOHlqF5YKlpiTJky/Zbm32906LbwBx8SMPTGWovn+v+t+R1l607O/4W
	Vo4FiYSsDJNSMyZRH8g6qqqytxAqjFzOx7pGngbiPcyC/3CcNY58+oeJS+0=
X-Received: by 2002:a05:6a00:1490:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-7486cb219b7mr5179606b3a.1.1749658442755;
        Wed, 11 Jun 2025 09:14:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExcLPif8UAuX4ZoswEaY25R/k69NLePm004lZfTnTJsqF+aqjn9Vn3sVFV0N9NDcXgNtJ3aw==
X-Received: by 2002:a05:6a00:1490:b0:73e:2d7a:8fc0 with SMTP id d2e1a72fcca58-7486cb219b7mr5179579b3a.1.1749658442306;
        Wed, 11 Jun 2025 09:14:02 -0700 (PDT)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7482cdf1c41sm9443708b3a.149.2025.06.11.09.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 09:14:02 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Wed, 11 Jun 2025 09:13:55 -0700
Subject: [PATCH ath-next 2/5] wifi: ath9k: Add missing include of export.h
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-ath-unused-export-v1-2-c36819df7e7b@oss.qualcomm.com>
References: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
In-Reply-To: <20250611-ath-unused-export-v1-0-c36819df7e7b@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>,
        =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=JcO8rVKV c=1 sm=1 tr=0 ts=6849ab4b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=wX-X5SGVYUOQdF0mMgYA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjExMDEzNiBTYWx0ZWRfXyUHEnZbf+cQC
 8Ol6cSdJ1EO3kU3BkJgL3UXKorjIyPVNlQsKkaZlQEp4p8Luu/xUKapBquyoYEhz5FkxOugFO8O
 8VSoLZ2OEcSDELQWATh2G/kJb5BT+spfd2a1j8n9lUjHkQcCMqAuQyisY6GvsF5AzPY49dTOaI8
 Rg62sUqkCApzKOJ2q+2HZkpogNBj/7JnCEfdEmSUVmGvOUBnxGuFDMp9oo1oEeVX3HhzzqbZ7oR
 GF6acG8wd6FPj2DE9fKS7LtJi+4dyAdUC3d/HCfTkD8cuatvXOkFQwEJCtGyYm/i1bolAziOHyh
 2tEw7lPCu5TtT9k2QJ8KBwPg/XYSJ8CH9+erMRwTdKqZWgoKufYbM24VKHtzzXoG2etvBhp1VuB
 5H3AixOUupqRvS/HvAOitMXpBt8F/4b8u32ed+L2URKEDP5PJSyQWOIs1+URxChRP2PVFqb/
X-Proofpoint-GUID: 0e0_plLf33STcL-rE34EJVnGMqqXdcyU
X-Proofpoint-ORIG-GUID: 0e0_plLf33STcL-rE34EJVnGMqqXdcyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-11_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506110136

Commit a934a57a42f6 ("scripts/misc-check: check missing #include
<linux/export.h> when W=1") introduced a new check that is producing
the following warnings:

drivers/net/wireless/ath/ath9k/common-beacon.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/common-debug.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/common-init.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/common-spectral.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/common.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/dynack.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing
drivers/net/wireless/ath/ath9k/hw.c: warning: EXPORT_SYMBOL() is used, but #include <linux/export.h> is missing

Add the missing #include to satisfy the check.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath9k/common-beacon.c   | 1 +
 drivers/net/wireless/ath/ath9k/common-debug.c    | 1 +
 drivers/net/wireless/ath/ath9k/common-init.c     | 1 +
 drivers/net/wireless/ath/ath9k/common-spectral.c | 1 +
 drivers/net/wireless/ath/ath9k/common.c          | 1 +
 drivers/net/wireless/ath/ath9k/dynack.c          | 1 +
 drivers/net/wireless/ath/ath9k/hw.c              | 1 +
 7 files changed, 7 insertions(+)

diff --git a/drivers/net/wireless/ath/ath9k/common-beacon.c b/drivers/net/wireless/ath/ath9k/common-beacon.c
index 01d6d3205a654292397557990ea485b074313341..e4df89f2fa031ad15a40bfb49ea7639b1ab72a74 100644
--- a/drivers/net/wireless/ath/ath9k/common-beacon.c
+++ b/drivers/net/wireless/ath/ath9k/common-beacon.c
@@ -14,6 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/export.h>
 #include "common.h"
 
 #define FUDGE 2
diff --git a/drivers/net/wireless/ath/ath9k/common-debug.c b/drivers/net/wireless/ath/ath9k/common-debug.c
index 7aefb79f6bed5b765de27c1e5d46c9f7ad62647a..1ea070200e4a32be34d2af6784f9196aab4e1925 100644
--- a/drivers/net/wireless/ath/ath9k/common-debug.c
+++ b/drivers/net/wireless/ath/ath9k/common-debug.c
@@ -14,6 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/export.h>
 #include "common.h"
 
 static ssize_t read_file_modal_eeprom(struct file *file, char __user *user_buf,
diff --git a/drivers/net/wireless/ath/ath9k/common-init.c b/drivers/net/wireless/ath/ath9k/common-init.c
index 7c13a1deb3acf1c1a1430a29a50f79bfb539e121..da102c791712e7f2eaac06d0d91b9ade08faf8f9 100644
--- a/drivers/net/wireless/ath/ath9k/common-init.c
+++ b/drivers/net/wireless/ath/ath9k/common-init.c
@@ -16,6 +16,7 @@
 
 /* We use the hw_value as an index into our private channel structure */
 
+#include <linux/export.h>
 #include "common.h"
 
 #define CHAN2G(_freq, _idx)  { \
diff --git a/drivers/net/wireless/ath/ath9k/common-spectral.c b/drivers/net/wireless/ath/ath9k/common-spectral.c
index 300d178830adf6aeda9bda6db2ef31becce9c917..ca01a07f6630cac3ca69b3fb64c5e51e983e1d81 100644
--- a/drivers/net/wireless/ath/ath9k/common-spectral.c
+++ b/drivers/net/wireless/ath/ath9k/common-spectral.c
@@ -14,6 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/export.h>
 #include <linux/relay.h>
 #include <linux/random.h>
 #include "ath9k.h"
diff --git a/drivers/net/wireless/ath/ath9k/common.c b/drivers/net/wireless/ath/ath9k/common.c
index 099f3d45c594d7bbe7c56aad7503627bd37d20d1..ffcf2276eb92e5f6d38eff13adc56c9ccfbba56b 100644
--- a/drivers/net/wireless/ath/ath9k/common.c
+++ b/drivers/net/wireless/ath/ath9k/common.c
@@ -18,6 +18,7 @@
  * Module for common driver code between ath9k and ath9k_htc
  */
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 
diff --git a/drivers/net/wireless/ath/ath9k/dynack.c b/drivers/net/wireless/ath/ath9k/dynack.c
index 321ff54fdb4237f32ffa7c3e52f1c2adddc729fc..598b3a2ad818db88337e74a37d68704e2e4dc241 100644
--- a/drivers/net/wireless/ath/ath9k/dynack.c
+++ b/drivers/net/wireless/ath/ath9k/dynack.c
@@ -14,6 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/export.h>
 #include "ath9k.h"
 #include "hw.h"
 #include "dynack.h"
diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index f9a774bd0e13937034989b772af2ab74e4cb3a49..14de62c1a32bd2459cc443028a4410cc2c6e4b5b 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -14,6 +14,7 @@
  * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
  */
 
+#include <linux/export.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/module.h>

-- 
2.42.0


