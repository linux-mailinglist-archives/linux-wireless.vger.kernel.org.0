Return-Path: <linux-wireless+bounces-31772-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEfcGxbqjWnG8gAAu9opvQ
	(envelope-from <linux-wireless+bounces-31772-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 15:56:22 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D83B512EAAC
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 15:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD9C9309E7BB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592D435CB8C;
	Thu, 12 Feb 2026 14:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWe1v2Jk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XEBGYoEo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73511DF26E
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 14:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907977; cv=none; b=h0P19ITdB2PynzssI7pqJ4YTcw05W9X2rcjECFCsNhpao8V6NeqYKemYceJRaGMpsCUbj0sAR3xjRvm2gKDnWwPYkCQsobW8VplLt+z2KCWGtIYzUQqvLYOilAPkOyJSoe54X8FkOWW/y0N0DRH7nyBcr8w7qSTRKGKGHWO/EGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907977; c=relaxed/simple;
	bh=YH0qLB//qQ7m/horvPIK27mISPuge4JVMkCyR+WpoSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=r8vxeX0n42bU2hTotvZQhwF1vuvCZY5k2LdL8drKYTC36p+8UwLh5w7aoApoP90v8DxYhfJwztbcmELXA4R5rkqTJQOmh/G1hiwEpq3BNvIg2IDJ10Qq727tr20rlc35YMX+Hzd8OLMkdeoMe1DL+3ZAlPGx6Rv7jB9YmFGocr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWe1v2Jk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XEBGYoEo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CDRfNT1339724
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 14:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MBgjDmZh+H3sq7sNeAtoBF
	hewZCG+YCTubP3p9PnOD0=; b=FWe1v2JkXX+O1J/mQiEiCcC++BI2v1m5Er32DR
	Qs4y/34uTg+a+w36YRCMaByWWXAZS5XIeJKkzx5NZkEKadf7sEV4Ju5ZUn7l5I3W
	ZPojMR8a6tDFeqJXLkXlG1Z2mdMp9u2uKpYbzDOEh0JbFxDnWSoMluBvZth0iQnR
	kBjBcVOfbKmCiuui1rBUEHjwNixWRXo+5yq4qRfaxV43HgqyT1Ws1WjE62SSnigR
	HJeFhn9xNKWUu1/Mmaff9QvNzIasmInFsoLaFgoKhRgPnPPE29ox4EyCh3G1pbvx
	k8/wqdc4sk8+WoOx1EFiwN8eSwtD3BGHNlnXcikLqr4iJ8fg==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c90wjb15g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 14:52:55 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7cfd0f67288so19981632a34.3
        for <linux-wireless@vger.kernel.org>; Thu, 12 Feb 2026 06:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770907974; x=1771512774; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MBgjDmZh+H3sq7sNeAtoBFhewZCG+YCTubP3p9PnOD0=;
        b=XEBGYoEod/75HN7i+yEOhCwx/xbc4FlwpXoPOoueHO3Fu2IRxOBfG4WbT9gwJjFOyg
         bb74p9CBM1V4aGx0NCJFeaAg7pMIxAJ6gjtEDUAD54KrkrbAM+fA8DnOcKwe0bHxoaVI
         lYgherbyzfLHGPKzowaQhItrC3ExNAhaDFkviz/Hot8sg/Xs9lF8D550yi5z7vymSvi3
         Orth/w70diHZgnjr/1XokkPI/m8KMkxoKzn6DyUMEqAKNjVgwBz5ke7lUuufgemaOE0A
         KWGP4wqr8y0hbTKwd+abxIE+BFLNmJPJT0jlU1c8DIn//PFdo5SP6dn44NsiF0LgMDUB
         HguQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907974; x=1771512774;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBgjDmZh+H3sq7sNeAtoBFhewZCG+YCTubP3p9PnOD0=;
        b=naaRMU/9+9Z0apmzW8tdNemw9rfA9yxhDLzChWYysT9lq2stU/vaYJScapE3SZaJO6
         W35nmngbY9mQ3bdRC9T/L4a+9LSm5srTV7PixNBeu0UK/hZq29ofDb6IdnPoIbmm7VqT
         kmeOdxASNJGbiW/WVtV9L4vPaJwJvZzhgwArZ53g3V+DHKuSluKac3LTaQF4aO5WLv22
         B8D1V+3EFI8S/euQphsOOcy4e7JyuTf9uporCyf0JXt9VA5GNON4rHO3ANXjT+LT+dGQ
         OUTNdaHhIPX8dtslMzBPzX9Jj8UHqc7tlGh/82VYm8As9HZb16vdyqUlCRY0/zhvwONa
         qsEA==
X-Forwarded-Encrypted: i=1; AJvYcCUKjOyL8llmlh0CfYurAMc379hS10hMmLmgvYAfGZqCyR9o0ZhA18IpNgxU2aAPAOJaptiNupOj1dmvGqVM/g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnWTfVNKrwBdG3lCeUN75h1xK9+OoRGBK/4NZrbj59EoR+mVe
	LpOUzXGZGcT8PAmC1SeL5YxUzBRs2z7E8d/gG94ERa2emeU3ytsTYFLTTfV8AONATOnku2gbezK
	R3h8QGqRKOfS7tFVNAMDNUhWcfhKeSOL4ldZd7gpN93Z2wNmpTtai3jPWK+RkMZK8CK95XWETix
	DXPQ==
X-Gm-Gg: AZuq6aIKP78Gb5jWuZjM2Ok3rk+6YpArE3LfGp6Xh2tvAmkLySqEeN+E3MUOjBMprS0
	LiYTGIu9pfeAi0jI6kuYYh9SdWSH8FQwHRHSn4m0qAjTz0JudQj9k03T7/8KRSSWx9re8I+1BSr
	PUsVY4WWHH3buzL6WpQtr8OfFzcej8j/ZP14Nkj1wDydSK/zlrJxjP+xaMAYQye3u71tEVbZlZT
	rJnPGvXnjM0pXMAJg+E0Dq6/9SzbrLFaxX8NqFPWd7kOk9xs10hy4+NaKxxuCgX9Ra1BPzGPeOW
	O1pGbStxk1SPKulSvtIDHxzPCTBpB3zU649cQWzqRaxSGtB2mQ9HdBMaZbCiDntCj4D/vmjzx4k
	aSEFyFjktN1vJOLCKVsk8dIQAvHsc1Qi0ekPoWCNZk1PfF+NIWR5ogGIw/mV2RuPzfyjyfzYSwA
	gvyOMbTQJWW8ktYg7NPkIV
X-Received: by 2002:a05:6820:6ae6:b0:65f:7470:38bd with SMTP id 006d021491bc7-6759b9b5adfmr1154799eaf.58.1770907973918;
        Thu, 12 Feb 2026 06:52:53 -0800 (PST)
X-Received: by 2002:a05:6820:6ae6:b0:65f:7470:38bd with SMTP id 006d021491bc7-6759b9b5adfmr1154790eaf.58.1770907973566;
        Thu, 12 Feb 2026 06:52:53 -0800 (PST)
Received: from [192.168.86.59] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm3972026fac.1.2026.02.12.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:52:52 -0800 (PST)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Thu, 12 Feb 2026 08:52:52 -0600
Subject: [PATCH] wifi: ath11k: Silence remoteproc probe deferral prints
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-ath11k-silence-probe-deferr-v1-1-b8a49bb3c332@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEPpjWkC/x3MQQqDQAwF0KtI1g2YSIv0KqULzXxrsIySKaUg3
 t2hy7d5OxWEo9C92Snw9eJrrpBLQzYP+QX2VE3a6q1VUR4+s8jCxd/IBt5iHcEJEyJYe9Nrp6O
 ZJKrDFpj8998fz+M4AWwbtQNtAAAA
X-Change-ID: 20260212-ath11k-silence-probe-deferr-28c2532bcc1d
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1664;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=YH0qLB//qQ7m/horvPIK27mISPuge4JVMkCyR+WpoSo=;
 b=owEBgwJ8/ZANAwAKAQsfOT8Nma3FAcsmYgBpjelEIncAHdd+PJNineoJBlT0bNSaEOVScRXPC
 pe7AzA9t+uJAkkEAAEKADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaY3pRBUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcVUOhAAtOzj7Ka31JGpJKXMb23IuzgITB63HmmhUV/df4i
 hHd5XW4OeWU99vZaNY4Tzw1tOBKXeNu4RKwT+HzK9w7gTmlPzBbNzOTXlRHp+rKnk76Lb5lCXdE
 DO9B4zKEaMXa+hzmM17uolcIKM/J6VBW4rt6N0Ti0dwCpaQRPSwH7R0MBafJGA92+Q1km8h6Mk0
 CVk95IwjCJG+Nc+obZcKJsdT5JUl5MgYO7Bqiak2b1apfgi9bQZ+cavyJFi+FKOKW10m96METy8
 dqPghuDQJDQxyRrbuh4wMPXHiRZKNo3lzlZUidhJEilWQdN7yD6jc488YyRN9f7FsyUGRhm0jGL
 CKpODLovGU/x6C7fFHphnNg7GGDVFRpeLEieMuzjZ+aVtnqZqMfnRUIo5o9/k7lZr/gLp+7pW+0
 mm4UzHV7N2nDecMSRvkzzvKJjFFOfCs9K7frrpaEb87v5GXk1brR8j1PFKZEmFpfL6PNE5giAys
 fXb0JWBhx2rTU6o9vvE7JJwrp7X7xoQ7ZOgsj0jBDFq4l4P0fPr8h8pu5ydDNDLHyZ3p17nXYj9
 b1t7rjbTQUT2TSwLU3iR7E4IyorHPPr0swdQyxJ+/czpoNALWdPHNN6V2eeJRnyIcN9xBT4682l
 hpsQHwQ4HOskkay1+kco7PK+uZ99u8AZE76h5RH2HjWY=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Authority-Analysis: v=2.4 cv=DtlbOW/+ c=1 sm=1 tr=0 ts=698de947 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=12A6hGN33XcstJ_aBzoA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDExMyBTYWx0ZWRfX/8DfSDgB/1my
 8lkRQYR+I99hNE9RGQb8cZEVUiUlC6qU7ULHRASY8xm4gF+US2CPUptIZi78D5XTjOIgNx5tUWC
 sB/nKEZRw92zLfsLWJxP3OLtrhup5irlWv2soqNGhZfar8aNU/ZWhcGXMySG3zOcBkOTAm5Db8j
 M8hMJOTikxfpW4GcA/hwy49F0H8AVYHAbOT1t8ZxvZb/DMly9aQZdztX7vHQd79IASCu8kT8Sqp
 Fik1tecFyXkOA+Rom2DZ0l1/jjBWFmHtKuR+zbnlPZDMVaz4JpP0Aki46gtJpILnZW0WnFNu/jY
 TmSbyu63hgI09PxawTND20w577L1SuV0QgM7kgwtDZjFZ1tFaXxzp2/LnKDnI8wg3d/lC/e4SFj
 ZdTqJnYfyEG+Yf5pLkgX8/STNTRdjGq476/r+DP6Ds14bRLiSHB6d1Hk0IrKh/BC7eYSeaYmNXg
 sitOTxgCczKm+velA+A==
X-Proofpoint-ORIG-GUID: OqkENLmMZFKiwk6IBKYMjvJ4HwjDRv1p
X-Proofpoint-GUID: OqkENLmMZFKiwk6IBKYMjvJ4HwjDRv1p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_04,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602120113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn.andersson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31772-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+]
X-Rspamd-Queue-Id: D83B512EAAC
X-Rspamd-Action: no action

Upon failing to resolve the remoteproc phandle one ath11k_dbg() and one
ath11k_err() is used to tell the user about the (presumably) temporary
failure.

Reduce the log spam by removing the duplicate print and switching to
dev_err_probe(), in line with how ath12k handles this error.

Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8dfe9b40c12626649639fc1dd9da0e5e0c2dcaf1..08d3a0c8f105b26b1548c5d6006f6ea162fe58ff 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -807,10 +807,8 @@ static int ath11k_core_get_rproc(struct ath11k_base *ab)
 	}
 
 	prproc = rproc_get_by_phandle(rproc_phandle);
-	if (!prproc) {
-		ath11k_dbg(ab, ATH11K_DBG_AHB, "failed to get rproc, deferring\n");
-		return -EPROBE_DEFER;
-	}
+	if (!prproc)
+		return dev_err_probe(&ab->pdev->dev, -EPROBE_DEFER, "failed to get rproc\n");
 	ab_ahb->tgt_rproc = prproc;
 
 	return 0;
@@ -1190,10 +1188,8 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 	ath11k_ahb_init_qmi_ce_config(ab);
 
 	ret = ath11k_core_get_rproc(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to get rproc: %d\n", ret);
+	if (ret)
 		goto err_ce_free;
-	}
 
 	ret = ath11k_core_init(ab);
 	if (ret) {

---
base-commit: fd9678829d6dd0c10fde080b536abf4b1121c346
change-id: 20260212-ath11k-silence-probe-deferr-28c2532bcc1d

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


