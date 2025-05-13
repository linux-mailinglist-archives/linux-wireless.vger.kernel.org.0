Return-Path: <linux-wireless+bounces-22894-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E36DFAB4A49
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8437619E6612
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AD9D1E5207;
	Tue, 13 May 2025 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J3gWvTkj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B488F1E3762
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747108633; cv=none; b=UiNoA800yPT80aWTLyHLzfRsOAhCtYxVh+x9StZiTfYEprF49VQjfvjur76DD6EedG4SdLnVdth5mquMMK7JcTHPyhD0QVLM3jJjGuwT+1QEKMSFHCtxSaKBhgr0JOtXLgmymNM0krHWx0mzNXyCkFStlc751XeCLZ0nLIvGmMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747108633; c=relaxed/simple;
	bh=2aCYsID7h6PKzoWsDWjEbsYtZRpxTQpf8z0Sn6LvenY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KcHy7DzL3v3Pox15sijcr2gLEwSTsVn7rHgMPws25O+horb/FMFGH+pXELWLC9FSZx4TT+FuQOgoCDzbKzEJPH5ny2ZPOfb9h7pbmLfd8aSaG4n0K7oFKRqJ6MMPIvhrwg+tJ1WAQZ3vkS1lloI9opb7LZ0bqz3lSy0AYMUZFhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J3gWvTkj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54CIW1K7007509
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5DlwmdNmedCKJPdbWIvXijFc/3cbsfXTmrrSp5SO3l0=; b=J3gWvTkjeC41C3g3
	vXGl5y6f2QrIORcM4lazgkzTALowgwk+7+DZs1SjUk/ezjZcEt85ZXgDGbJdGTGl
	rT/SDCXKEy+tpljW6ErsUvy0L0dSKayIDCHqtKgwnllvBq9L34LSKtsBY4OaTmmz
	CUhT2GOyBNoeZtfO/B7yrt1Me/talScAM7WvyzQayw8S78bB3SWVC0/9Joe5lbC2
	LrCa8B4pzlJyQAgBjxX4+tjlJC35WkAD2cbux72KYmrt2feTW655Q+OBrhYUjw1c
	GSOgE1GBnLqiGNSZf+cY5HHTMnWzX/saNmD5fP1EBr6fM/aJbd/58fiTWNLfdzVQ
	sV+0Cg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46hv5qemnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:57:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b2002bcaa55so2934128a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 12 May 2025 20:57:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747108629; x=1747713429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5DlwmdNmedCKJPdbWIvXijFc/3cbsfXTmrrSp5SO3l0=;
        b=XAAMngkbdb5eyF9El9UrrcGZ8r8T4zetTmjBTU7kccY2nctNiKCuUPhbw1jFUNOqXP
         +bZ+lN6RAXKZhqmqlQtu8o752PteZuiHwxSAhTF4Tg5F/8ddbNaNCwK2aurpJRgPEzyU
         Ah0ahGVJRBaTv+OSILkIqbtrORYgnVZ4K8hj+G9t+YQ+3LHCMo4WxdQC4knPXOwX91ry
         on6DauCrmEunghCZlyVFAtyassUbFRoQzrkUEmNYPFX/B/mlHs57CSF6DsJX0PnVRxMK
         bpoqKFEnkWBs/9O8doi7SNqNqI71YprIGV5RIsRQCutp3gcgWSvw9RrfFuPwD9Vz2NzW
         tS3w==
X-Gm-Message-State: AOJu0YxepCk732ZB02E9vKXbTbVHIv//PThOqykpbwTQVtC3HSFyYrpj
	g0cmP2ZDsKqURSm0kJrkFL/dmW+DuI2AJUr/BtwX6UXvbb26mCDcljc0WVL4GPyJl2RMU7lVo01
	kZlNrKVMFKtYVVGXV8kip1EfuY+nqJCS83mp3aYyeqvmyG0f9Geba5c0wNjSfnQAIxA==
X-Gm-Gg: ASbGncsceL9jnQCkfI2SiUt1mbfiTPjyN3GoT1Cby4llmThjvJP3FrmUwn48t8USpIV
	xIgfebXKkmizVjTGQRENwNrHGpFpdSC395/7aODJqqD97JBdsKSqZ3k7EjE3MfTa3NYicqbzLnd
	3v7uoCW8+sLf9A174WhTWNzO5TEvpkrTzCcmonNooo08aJLjn8qyCM2KwYbQOWSprCJyhd4PgfO
	z7VUscJCO+V2ERtTjWYbJBfGfDri+CX0kmm+UhyI/6wfRsqBuCR3C8LUxgyypadvHzDHKym9n0O
	aKxhd0YhHMSWH/vruhFm5VwAu/TWaKoQoaZfa7y//Hg7EFom1tOxLK/yV3N23lSUDb/4eURCwSu
	WdpHI/W6BFW+D850T+GfqcL0ap8x32WI//P6D
X-Received: by 2002:a17:903:2f8e:b0:22f:b69f:e7fc with SMTP id d9443c01a7336-22fc91aed27mr231332145ad.49.1747108629165;
        Mon, 12 May 2025 20:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYx9rPWYpCahLURbksqyMGB16+552UoK0wJFPuqnnX9kUYEP1Xof27IXrnXei37iJfIHAIuA==
X-Received: by 2002:a17:903:2f8e:b0:22f:b69f:e7fc with SMTP id d9443c01a7336-22fc91aed27mr231331955ad.49.1747108628790;
        Mon, 12 May 2025 20:57:08 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271d98sm70236515ad.154.2025.05.12.20.57.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 20:57:08 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Tue, 13 May 2025 09:26:52 +0530
Subject: [PATCH wireless-next 2/2] wifi: mac80211: accept probe response on
 link address as well
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250513-bug_fix_mlo_scan-v1-2-94235bb42fbe@oss.qualcomm.com>
References: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
In-Reply-To: <20250513-bug_fix_mlo_scan-v1-0-94235bb42fbe@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=DqtW+H/+ c=1 sm=1 tr=0 ts=6822c316 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=kffUEhMhicqf5g7Do04A:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: mdRkaSNCaUZzX3upgp6Pl6Ehn28ys76L
X-Proofpoint-GUID: mdRkaSNCaUZzX3upgp6Pl6Ehn28ys76L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDAzNCBTYWx0ZWRfX5/BJDR6LrAbL
 6sneVMsm3O5KLSiao6GJZdF+EYXlg/42QKk6Bwwe50jqLSQSJEMZV9F8E7WTJ8CSYPIKizPVTM9
 vxWwzZ3GG8foBLQgc/08GokbxaULUIcZPp7RV45cKJ8ZOnU8A2g+Vz9fOHcpkU63Ik9/fPqHghe
 s0LJo+uwJ5qeEEAwUPqNaOTH2CFuuh4uATlYrHVEyAjE0zT8+02mqvgradkqfNFY/B0gVc2LDWO
 My2S+jWwg0tT+RhRz6LlcGRvvpdlCDKDyk5Sc+vtCUF44LWj/xUGhk3YzZP+Sir7IKiVjoVQb+l
 0uX6gFpqr2E3rqZwsHYsLcaRRxME/eVsBHM22CnKxhf3B05rOA+p9K7VBA7UyUjJjsmhJwIHQJm
 kampiunycEJLukq6rwEFQG0lN9AOnVqZwxtgfG5l5xPEaZEDQ0CMDJSqZOJEqPGIRlZSTvU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2504070000 definitions=main-2505130034

If a random MAC address is not requested during scan request, unicast probe
response frames are only accepted if the destination address matches the
interface address. This works fine for non-ML interfaces. However, with
MLO, the same interface can have multiple links, and a scan on a link would
be requested with the link address. In such cases, the probe response frame
gets dropped which is incorrect.

Therefore, add logic to check if any of the link addresses match the
destination address if the interface address does not match.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 net/mac80211/scan.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index cb707907188585d6874bf290874bdb0ca33bb399..7b8da40a912d020f229a74c67bd5a57fb513a72d 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -240,6 +240,9 @@ static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
 					struct ieee80211_channel *channel,
 					u32 scan_flags, const u8 *da)
 {
+	struct ieee80211_link_data *link_sdata;
+	u8 link_id;
+
 	if (!sdata)
 		return false;
 
@@ -251,7 +254,20 @@ static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
 
 	if (scan_flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		return true;
-	return ether_addr_equal(da, sdata->vif.addr);
+
+	if (ether_addr_equal(da, sdata->vif.addr))
+		return true;
+
+	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
+		link_sdata = rcu_dereference(sdata->link[link_id]);
+		if (!link_sdata)
+			continue;
+
+		if (ether_addr_equal(da, link_sdata->conf->addr))
+			return true;
+	}
+
+	return false;
 }
 
 void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)

-- 
2.34.1


