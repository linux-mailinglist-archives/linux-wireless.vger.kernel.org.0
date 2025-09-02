Return-Path: <linux-wireless+bounces-26927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5210B3F78A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 10:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABAB480A3D
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Sep 2025 08:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53E52E6CC8;
	Tue,  2 Sep 2025 08:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="St+jrdbI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F22E7F3E
	for <linux-wireless@vger.kernel.org>; Tue,  2 Sep 2025 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800247; cv=none; b=lr1H7GLI18KprmOSsfLMI575WQhOduQXSw5uu2e3IhczhmcGXHNO7WUN9p0clPNwebBekMm0lGz2n1jC1SGr2vMakQniitCQeeo3vOPDIJ8nUz+YSzS/iyyRSi/YsK7zeBq7/eePkE5bVPbU+7xYdDOSHUh2JRu0QlbPJ4/IA3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800247; c=relaxed/simple;
	bh=Pv4kdTPZB06G61BKL1Mej9xzcV4yEzcrGvUTPb6IPCs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=trdS1y0wRhqMGiP1YD+FkSm0uNMXb2yDjM3w5DfcZorABgXfn4jfEqcyvvFcNs7pMDILeKqOWBiVZSCspluZPmgasTFkhv9IzGqJVXT4oPujaiF7+XdwKyYV1822O9F1ej6QdfQn+wqMJIvv5mC1rPojuGcCyOXTYtoKBb/itZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=St+jrdbI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RkZ5020481
	for <linux-wireless@vger.kernel.org>; Tue, 2 Sep 2025 08:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WgIyomiDGYBeb6Ioi8MhbYgA0ptZ7Qj5Q0V
	JcD6VFc0=; b=St+jrdbInGJVPtY+eqAi8+mmpgllzP5yQmz3VawAPq8kIijP6Mt
	kYFx9ZONMCvlf48a8LtpkTwUWmlAWRdUmaP5xpM8hK7zBHm6Wcfdkh6mVnEJRBGw
	bk1YUaO01Op8vVzh2FM/Jg2vrYBQOMU7Cb8l+r7ZQQvpViDuexsbWQjkEyf1b1xu
	zw5pDUCyh4nfMaY9AzHenVbuwXBYJbd5FXqAbUSAjn7mhkcSh99tournldoO74eF
	Sxg3JfmefpdaJRwGOllR97Q4PSYlpy4FlPWGTF7cp11ixmnyx8pldOs2Ok20NHLX
	YXTE1xILhCsvbUKRWtTyWUuULrZMEqHlGXA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ur8ry39r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 08:04:05 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-721094e78e5so2997866d6.1
        for <linux-wireless@vger.kernel.org>; Tue, 02 Sep 2025 01:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756800244; x=1757405044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WgIyomiDGYBeb6Ioi8MhbYgA0ptZ7Qj5Q0VJcD6VFc0=;
        b=O+8jZzmIZ6Kt95/l5BSY/LwSwrNowV3uWS9Va8BoE5u0kG451Y2tfRaU4wAtrbTSWL
         hxPh4kxy4sUenqY4rOy3alTEkXQj74tNWJmhgn6846SdwndsTROTrf/snsetSXeilQBJ
         FHxtBYexjx8dGKPwL5bqw7VQaNx9rxLi+u1GMwnwNNbF6GcFSQi2Rjd4mcZsrPHVVabi
         xzMPQjDE3Fd5qRmjdkBnzu4FwH1b76ZybOUglJGyJre6HhFR5VPWyzmxOF1qVW6ZIXZl
         glSU4+SG5oJdfOu8zXSzigXJa8N0t6yRn8LTn687NhH6UKA7u9ic+e57XyyC8O6s34SJ
         2dOg==
X-Gm-Message-State: AOJu0YxvoP0QTei7y2C1t5n1RwfgO8NyYVUDUPG3T71YfT3fqDk5QWGq
	3EtNdPg9cPgJusW/x3zRr26mKv3DqfEnWY1xsVe1B0GplTCK38V+3y1HKuC0VltGXTU/OZC2nsS
	NNqGLF3saZ7/REyGbgeIt8pf8jqz86pmUmshnHmRvizvfb2I6ROZywny3QmQoVa6aosMKwA==
X-Gm-Gg: ASbGncuRgD9szz5xuvv+vlymAXfUXyxMnn8aIqu4KbT8u4M+e19HL+FsvlGBQMm+xMJ
	2hxXHaVbAUqO8KOmdZL0EViPPSW257UMhmgtuyDB6n3BafRmHjc8MbuTGK6K+nfG2HdvcIS+8Mp
	ZnPh+opnHSclEbr2zgHKXcOQS6jDo3WBEGxP3h0bHbTuwwmUBGWo4EWyu8lIhKgIklg88aPXqzc
	CiEwSFYD7VNlgrwJZvWjjCuzm+qvG4lmTLrMFwrvXliFIkw0+Mk4QQ7fOSceRdSv40TNBP/ePjq
	ZeXYyEN17rx0Am5Lnrw8sqbCstBCrn1EZpY7oFK/amH3occfstvTJKsAoUuzYQVyTqY/GheeRxY
	=
X-Received: by 2002:a05:6214:1cc8:b0:70d:f64e:d499 with SMTP id 6a1803df08f44-70fac6f8a66mr145364526d6.4.1756800243757;
        Tue, 02 Sep 2025 01:04:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKUomnfMNjYM9WFOvNk1clEAei1+fpKQQfJ0feRVEWDXTGiUE/1odwLcUTyZXAzdkg0MGjWw==
X-Received: by 2002:a05:6214:1cc8:b0:70d:f64e:d499 with SMTP id 6a1803df08f44-70fac6f8a66mr145364016d6.4.1756800243034;
        Tue, 02 Sep 2025 01:04:03 -0700 (PDT)
Received: from QCOM-eG0v1AUPpu.qualcomm.com ([2a01:e0a:82c:5f0:c58f:9eab:48e7:40ef])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff9918dbd2sm831672366b.103.2025.09.02.01.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 01:04:02 -0700 (PDT)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        alexey.klimov@linaro.org, Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH ath-current] wifi: ath10k: Fix connection after GTK rekeying
Date: Tue,  2 Sep 2025 10:04:00 +0200
Message-Id: <20250902080400.635818-1-loic.poulain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAxOSBTYWx0ZWRfXyIFERhC+IlSA
 Cnq6tVNmLnu8nW4z+r6T74WuTLfqKcrMyCdvPPYIUTMEG+iMTC3mITRXFDVZDO4bn+BnJyCst64
 DRzPU057DW0NFPvHvnv0MtvxcDbezemDQZ2PWGYKwupG+/WCsAG/CF9tScm/EfddzgChNy2BZJR
 QtDFBY+DUDL1See54s28gwYueXUCSt9MdT2hEz5iexGGUhBjmHBBBLCvoDNFsgviVuMTI+fgs/C
 zqEBJD/nprfOmz/X4JK1/fy9LqnCZpP7IS2sjx9tgcrYbQMVzekmQvKdzs/nQKOTAZl2Lk/NSJg
 YN6YPPR8phrYLYz+tOpuxzx7Fgul4M7IzxCF33jMzEG3vrlOfQh3/c9B/rtQLyAm2Zy3SLwql4q
 1TyIQwPZ
X-Proofpoint-GUID: ZBFlUaqGFveEiqfi6Ff7BZl__VRK9M6W
X-Proofpoint-ORIG-GUID: ZBFlUaqGFveEiqfi6Ff7BZl__VRK9M6W
X-Authority-Analysis: v=2.4 cv=PNkP+eqC c=1 sm=1 tr=0 ts=68b6a4f5 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=shBBdOEUAhiFnM6U-_8A:9
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_02,2025-08-28_01,2025-03-28_01
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
invalid (zeroed) value.

This behavior has been observed with WCN3950 and WCN3980 chipsets.

Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 24dd794e31ea..f33860784c82 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -290,8 +290,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
 		key->flags |= IEEE80211_KEY_FLAG_GENERATE_IV;
 
 	if (cmd == DISABLE_KEY) {
-		arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
-		arg.key_data = NULL;
+		if (flags & WMI_KEY_GROUP) {
+			/* Not all hardware handles group-key deletion operation
+			 * correctly. Replace the key with a junk value to invalidate it.
+			 */
+			memset(key->key, 0, key->len);
+		} else {
+			arg.key_cipher = ar->wmi_key_cipher[WMI_CIPHER_NONE];
+			arg.key_data = NULL;
+		}
 	}
 
 	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);
-- 
2.34.1


