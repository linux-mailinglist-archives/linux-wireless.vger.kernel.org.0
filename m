Return-Path: <linux-wireless+bounces-26938-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D49D6B406F6
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 16:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79ECE1B20E09
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 14:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1887A30C341;
	Tue,  2 Sep 2025 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jbnJZJnQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7093331DD9A
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823556; cv=none; b=rJTXXl1cqpnLUedByeYlU0a1CVH4Rvbx1HkkKj1yJJTvad9fO3A/k7g5wHIWMe+NrPy1rPsBdW3VtuwsIHFYiGjpDavpTKtJ4r3IQLTq2xNyUioEAMu8QWJGVcTjcvfqS8z+iiXKHXDx+3isLMdAJobb22QyeYRuOm0ft/LEIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823556; c=relaxed/simple;
	bh=DL3t47TztyX/+3qfmis+gRL7NRk8JLcX1UPIa28Todo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ev84p6FDKzuE5uDMRfXXW1oMXiiWsmsk5V4Rr72Ai8rqLJPgCL5ptEJh71151m3Us6nTaE6rpnIutdiBfjsnMUSZ8Jb4GGNmp4xb4+Se8uijWdB/N+VpU3KGpDKkoGQasa4YYQlK16Ge/FLTaFLaC3cqoMOkezXurPl4QL0s/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jbnJZJnQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582AqqfR021885
	for <linux-wireless@vger.kernel.org>; Tue, 2 Sep 2025 14:32:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=X4XULKWcRpDQYnkzfpkgr19me4kCAmTTsNT
	E2ipwu20=; b=jbnJZJnQX/vNfNYz/OmxcHDOGbQAWsLF5mI/XJZC2OmZKgR+dF6
	++YIZ03S+NEbkkrYD8slEBNIGB8XxP84ulmGDlLnlnZoHirdqneMNw7hR/vrZeuD
	LMGw8yoogr8KR9APlg/nyHOrOdLKaRceNPm0/r5cOlfvzaG8rnMSMc5AxROPCsqF
	jtKZ+FpkGBJleFiisD2uyGfKbLYESeewBk1mRPy033YT74Fa+jjRhK1js/RB6ksf
	+ElTLzHQz1ut1m1OAHdnV4PhdOnLrFpPBlgJqszdKGgBe3Gxi800JBCYPg/b1gg3
	Ttb+jCYb1ZAfwvCov4+bdTIdxeD5d3640BQ==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8s06ku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 14:32:32 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-89606a4fad2so237165241.2
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 07:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823551; x=1757428351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X4XULKWcRpDQYnkzfpkgr19me4kCAmTTsNTE2ipwu20=;
        b=PfcU11YgMNrmPy4o8qge3FlhYBCnMsXlDz9r8KjuVj+JsOojBbCvpBqOdTc0XjwK6c
         65rKIuGM4ESlUF7KtMoYfcjZ/Ln8nhg+zWwiRnWQOckOgxbHY4d3KJn0ejsKVzKT4VKJ
         T9PSOLmtCS7FZYqw3m/G+P/ghrXC3uK4uATLf6iSV15oq78bdPQnlkVt8hwv7kO0/Ge5
         U0zCoUii07wX5Ka6+Cz6jxgXN1vfK+jZrwAXey0i1/2FcdES2po7AiKJezEeK/YKzF+i
         UOuqHyULKcAGwFjD/UmXZkN3DZ8SZPuc2pm1qMFL4O7I6/EGjd0povYjBvCclQaJPrb/
         tkEg==
X-Gm-Message-State: AOJu0YxiYcq5I2GY1sQxGktpJ+jsc9lNx9AKlOLi2lKpyOkRp1IOrRwm
	TgU8Jm6ko1DAjNFKO0qZ2KsiW4Oxirqkkh0TE3nKQlNPxc90cWNkj6jMCHzeVq8kZZpqVQuk69r
	8G3TFjUJEB0bBANiiEOOzFgpVNjB4K7PPPOVFjsnVIVBmdRIdoNIT++UjLHTVdGRJQBYhaA==
X-Gm-Gg: ASbGnctEvmFMCYDsWR8233O37tf0j4u8g5kA7KnuHNNK2j80u6f+7gxXmMz71VicRS+
	ofWJb2pTA066lwmLDv1wFrNPI1NsGHMkiZdLytUja7CEaKJBJEHuhdoIURg9LU6dr05vygvlLnf
	bFwz4ORkhDqAa4p7BiUe6/bWnrzT9hqQjgWYAHWHrlBlqFUCYWJstS7H50IsPk6cDsu926YsQ1W
	8tm75bCsINMOcGF9IqCTZk3vC2QiKzgNjIeVHQWmNeGHz48VJtyipubO17dbtbm83lPzDPbtHjc
	UWGaaKzeEdOZxLtgdV3ipviqsCTynAlD+98BbZ8/RBrfOo/Z0GQ7oIT6m2wYQfZcGMOYkvKQqlY
	=
X-Received: by 2002:a05:6122:3287:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-544a0132b21mr3241781e0c.2.1756823550892;
        Tue, 02 Sep 2025 07:32:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2HxyqEkvLUFVM19sp4oReM6mrkkCmvMZlj/Hq753VsSgZDka4mXcCIKMqYqvfKXo9x+lJFw==
X-Received: by 2002:a05:6122:3287:b0:539:1dbf:3148 with SMTP id 71dfb90a1353d-544a0132b21mr3241612e0c.2.1756823548920;
        Tue, 02 Sep 2025 07:32:28 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:c58f:9eab:48e7:40ef])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61ec8516621sm786655a12.26.2025.09.02.07.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:32:28 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        alexey.klimov@linaro.org, johannes@sipsolutions.net,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK rekeying
Date: Tue,  2 Sep 2025 16:32:25 +0200
Message-Id: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfX/Lm+jdTWmZLv
 Kpunixq7rkhg6uNCKoN1eWucyZtsMekZ+fNJERILszd9XWlgD6cuNeB43kkkUkF3IUdzRt9POU/
 sAYBfzffViD6e25SHkMi8c8CNtR5XUpXsSENwvm7cKrPHbK8UvFLoAAq2gcpyzz/Ar8ew2RXfcH
 4Yi0Q+O296S64BZxUrrzuHip3ppGDTTbOzYEJAbVJo6LxLQ8aN/99uLxnfoq3nvhDiXycxyK+jk
 Fa/4bw8IyBgMNznp+YaNRb5GTOvq6lqlsOz7FxwaTJpp1fn4DNUiPPp9qoQ93/XBMgsRqi8qYSS
 Ht9Xe+q8Ulk2Vk4TAWwSVNfrziOrtmk4WuB8dU+f2VUyy0u1J45KVCfsN08RWgVi99O3Ut5+i3h
 ewWWHlsU
X-Proofpoint-GUID: Hroy9Um3ZC0Fxa3uWsgE0jVt8hVBNTVK
X-Proofpoint-ORIG-GUID: Hroy9Um3ZC0Fxa3uWsgE0jVt8hVBNTVK
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b70000 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=PE5K5WXOdT2j-IOiNL8A:9
 a=1WsBpfsz9X-RYQiigVTh:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_05,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300019

It appears that not all hardware/firmware implementations support
group key deletion correctly, which can lead to connection hangs
and deauthentication following GTK rekeying (delete and install).

To avoid this issue, instead of attempting to delete the key using
the special WMI_CIPHER_NONE value, we now replace the key with an
invalid (random) value.

This behavior has been observed with WCN39xx chipsets.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 v2: use random value instead of predictable zero value for key
     Add Tested-on tag

 drivers/net/wireless/ath/ath10k/mac.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 24dd794e31ea..154ac7a70982 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -16,6 +16,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/bitfield.h>
+#include <linux/random.h>
 
 #include "hif.h"
 #include "core.h"
@@ -290,8 +291,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
 	if (cmd == DISABLE_KEY) {
-		arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
-		arg.key_data = NULL;
+		if (flags & WMI_KEY_GROUP) {
+			/* Not all hardware handles group-key deletion operation
+			 * correctly. Replace the key with a junk value to invalidate it.
+			 */
+			get_random_bytes(key->key, key->keylen);
+		} else {
+			arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
+			arg.key_data = NULL;
+		}
 	}
 
 	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);
-- 
2.34.1


