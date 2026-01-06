Return-Path: <linux-wireless+bounces-30407-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AF3CF915B
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 16:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D91E30B8F41
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 15:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BDB3314A8E;
	Tue,  6 Jan 2026 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JiE8UGA5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fZJ4DDhv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6331345741
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767713132; cv=none; b=kZOp2uCSjbTxLtUepa33PH4580i1dHBbjVdjaAF3JEIJPIbEduzVTaC9uI42F/eTTGHvmNPaNKxQDU9yeZYCD063OE2rQv+W6Mf7QtDLniAKap4qlhCnpNEQR39HYG3le0gBtDPAq1eOw3iUDKwjbH5OIz2wyedzB+PhYQ2+oYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767713132; c=relaxed/simple;
	bh=NhVtziSLS+H/CN4qE1XqrnTx/DavfkxoWUlFeuYEeck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y6y5YagpqTAQ6+wundScWWfFbrXlGVmzLPl/nMyILwPhEqOOuX1YT6SryCdG5SgdYzumUAZb+mrDxdSvMk/38MiktFh78LsjYScdWg90h+XiTDIpUCvJazGbWbECOvOzoxBrPXX+y1qTouQZtnZyRxPEgeKT471kgwf/WGlv+BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JiE8UGA5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fZJ4DDhv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 606CAFaH4048690
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 15:25:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o3s40Mqdbn4
	jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=; b=JiE8UGA5GnDK+hbZt4Y+OKcE7vF
	7Ap3sAxPJNOW05Rrfbcoj1iPtZY0jPUgPYBaD+PxDsMsPcNiNVGAtNBxTffyRt9U
	JPwaMr3WVQnMwginDphs6GLT7hNuukD/dZ7IAHAjNJYySO6jIIunU5KTOwNHKWPA
	zpK+o925+9EJ4+0BtaJoq+X6UOLUbThAd3e1rcRqGlTFUDfRLpwfF1/YT7UpnbHA
	DOpG14Iik4NunVkyFLwAX4gCidVhHtpfEdc0FqGm6nHeeZ7s6RPnz6iWCXIP76YN
	ZIKxlDKOst7DJ2jU8h6CnfCBmR+N5m1+fjPKBdBYvzaiHBEVmUM45ChHSmQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bh25rrj48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 15:25:29 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a090819ed1so9071355ad.2
        for <linux-wireless@vger.kernel.org>; Tue, 06 Jan 2026 07:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767713129; x=1768317929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3s40Mqdbn4jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=;
        b=fZJ4DDhvpzunXc5bK5s/2hGISl6gyC0wMzqJlnroys/flu2jqTyBAjAdLY1i9HhfQ6
         4wchF8ASzDgnD7CyJKixjijl0cFV0NGUv9rpMkt6dSgBznNvrLrtodZGA7scx7Th5yf9
         de5d3koaxfgyVsocCFiEucRJE2fz2r/qPg24O3QPht6+gAVh4MNjxov+ygKotSBs/oW8
         WyrEpnryi0tkwBV8JrKci+PaXslvvOBrWbcn1ILakH169L3avwf/dsPX84FoIhNliqr9
         zChFchL/5dAG3nMKbpF1i823K9x0kg5B8d8OzQquKREX6PiGIaHtT+XGYPdok+GqwG1a
         hRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767713129; x=1768317929;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o3s40Mqdbn4jif8lMjdVZbrCGlXLLFCYvsBOMfLzyug=;
        b=Hp42pHNG58EZ1QVaSAaaApUAii0LSe97HDv5bwkcN/xqo78pk4S9EhWlFOQQqyREcp
         HKYIL0UfjUV14vPEK1AeokElx1pr/b7K1Pb6euA8mQXrWbzcAEJZ7uFxjKqiYQxaN/He
         /CefLXFXS1PucNV3/0EOflPBdIdH3vMOR3nDe2H9P2fjkC6BQSjwIoYmHNARxG2bAJs8
         1UchcE6FdPzsHbVHq8sQ7lUfhF+lq1isCeAf/z7V85on+OWkOnOdYnsQGUYd2qb0qRGG
         SUZJnzDDS8w2iBG7Zxvmbm3jMmgGWRc9aMfUeXou3Y9xftbUdM7qHMyZY/pZVH077XML
         sKtg==
X-Gm-Message-State: AOJu0Yy/iyrxTTaXW2FJoxCp2PDojKZvl+6EFwqdyIL1IYfz/QR7f+Ai
	HW6oX82Sro0ECnJn2EVh9WdBD7xikTctbkU1iFub8n7sylicuzPlK5aAbgAapIqp2plEeFXBK22
	+gbgBlCY0pDlnIUPck1c/qkO8zsAjrKTyIM0WZeNun26Ixv4SyeX9u2Z5d1AWghiUsDiLYg==
X-Gm-Gg: AY/fxX4TnpR1Ui2VCoTrM+aQJgFNZX0W1kBKBTk2a3l/t10oxGelVBpc60QCjd+wd+x
	ht79hha1nqFh5uvXSZRJaxQTWX1WYIPvbFTivWOHMKFP3RezWypbJn2dQAHSU5OfyXtTq5Gpg8o
	zXslJwvFxPkZ7//cSrxcjlngvougdcu22cNqN3NQiT7NTakcBNPOYbNX1Im4jjDhSYSAi5sh2D/
	bWWP0aed/CMOtWEbf3KL6xaQEFtMHjG3u2NhP6DZ49iKaF+6V6+xmnIylrDifRuk5CfQJ48soV3
	nxfyrOxy/CZU0WRaa69Z2Cwn1TSGsmUHlCf6pQpFSyRSQ+N+yIiqYX8nvoZkIn8zGTBUS2anWaS
	Pnm6xniUIc/lIFrd/vW98l5wP+1C+l855VbDR6mpV0w==
X-Received: by 2002:a17:902:c952:b0:295:86a1:5008 with SMTP id d9443c01a7336-2a3e2cf827cmr31221295ad.38.1767713129165;
        Tue, 06 Jan 2026 07:25:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkkrRch2iOZo79OOBIjtBuMLiy7BoqrsAzu7t1SWVO1NtWhVmYbdCh2t12PCeWU3wtVC4Shw==
X-Received: by 2002:a17:902:c952:b0:295:86a1:5008 with SMTP id d9443c01a7336-2a3e2cf827cmr31221015ad.38.1767713128566;
        Tue, 06 Jan 2026 07:25:28 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2ea0sm26343595ad.62.2026.01.06.07.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 07:25:28 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v3 6/9] wifi: mac80211: Check for MLE before appending in Authentication frame
Date: Tue,  6 Jan 2026 20:55:00 +0530
Message-Id: <20260106152503.223216-7-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
References: <20260106152503.223216-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ze19XiVpaoGd6QdnZSjJYioDzigO_Af5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA2MDEzNCBTYWx0ZWRfX1gNy6JFwixYP
 XZ0DLTPWz9xaFf9dcqEGfFMK8qpV3AzFoW5VdxCHIUm7lo/VXaFcz81+DvcKx9MSm1nN2P82C3T
 idUv+3eXNnLCV+GlGOU7fr1bIWUQTK2SOdn4ZzouzAywxY7cSqlmy/esPTCDq6SKZStrnRyr25/
 m5akh1aicq4mKcX+9PPTgOp8ylSHm5jsrTx8+qiRCUSras9xkjAwJ48WLPllATcc+Abn3dx00f4
 Tdw2yWEAybXpHYZxMtQ7s9/TyCBEXTivzu5RMRQ5crElfXJaxcXSFmmK8rYGkVRXMv2fcVKm/Bj
 QWxe84wb1bnjyttInxvRlbkFMYf0ThYgE7shqBVUrFpmj5SimwuoIw4JaX4tARsNPOu9Zd/bSXF
 INCIFx8Cn2J0VY2yJX3Nn6qvxnvT5wM75uUOQpTzZ7Xs0dsHsC3lGX+BeSjdPHjWXj5iLvQZwAz
 6bS51XwMALWCZI0inxQ==
X-Proofpoint-ORIG-GUID: Ze19XiVpaoGd6QdnZSjJYioDzigO_Af5
X-Authority-Analysis: v=2.4 cv=G48R0tk5 c=1 sm=1 tr=0 ts=695d2969 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=nsG_Zr0jnLD6Zk_6mugA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_01,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601060134

Currently, in MLO connections, userspace constructs most of the
Authentication frame body, excluding the Multi-Link element (MLE),
which mac80211 appends later in ieee80211_send_auth(). At present,
mac80211 always adds the MLE itself, since userspace
(e.g. wpa_supplicant) does not yet include it.

However, for new authentication protocols such as Enhanced Privacy
Protection Key Exchange (EPPKE), as specified in
"IEEE P802.11bi/D3.0 section 12.16.9", the MLE must be included in
userspace so that the Message Integrity Code (MIC) can be computed
correctly over the complete frame body. Table 9-71 specifies that
the MIC is mandatory. If mac80211 appends the MLE again, the
Authentication frame becomes invalid.

Add a check in ieee80211_send_auth() to detect whether the MLE is
already present in the Authentication frame body before appending.
Skip the append if the MLE exists, otherwise add it as before.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/util.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 0c46009a3d63..3dc712bad8f7 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1096,14 +1096,17 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 		.ml.control = cpu_to_le16(IEEE80211_ML_CONTROL_TYPE_BASIC),
 		.basic.len = sizeof(mle.basic),
 	};
+	bool add_mle;
 	int err;
 
-	memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
+	add_mle = (multi_link &&
+		   !cfg80211_find_ext_elem(WLAN_EID_EXT_EHT_MULTI_LINK,
+					   extra, extra_len));
 
 	/* 24 + 6 = header + auth_algo + auth_transaction + status_code */
 	skb = dev_alloc_skb(local->hw.extra_tx_headroom + IEEE80211_WEP_IV_LEN +
 			    24 + 6 + extra_len + IEEE80211_WEP_ICV_LEN +
-			    multi_link * sizeof(mle));
+			    add_mle * sizeof(mle));
 	if (!skb)
 		return;
 
@@ -1120,8 +1123,11 @@ void ieee80211_send_auth(struct ieee80211_sub_if_data *sdata,
 	mgmt->u.auth.status_code = cpu_to_le16(status);
 	if (extra)
 		skb_put_data(skb, extra, extra_len);
-	if (multi_link)
+
+	if (add_mle) {
+		memcpy(mle.basic.mld_mac_addr, sdata->vif.addr, ETH_ALEN);
 		skb_put_data(skb, &mle, sizeof(mle));
+	}
 
 	if (auth_alg == WLAN_AUTH_SHARED_KEY && transaction == 3) {
 		mgmt->frame_control |= cpu_to_le16(IEEE80211_FCTL_PROTECTED);
-- 
2.34.1


