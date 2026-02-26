Return-Path: <linux-wireless+bounces-32222-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yH4PLEqaoGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32222-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:08:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C508A1AE31A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A21130A664A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6A13B5315;
	Thu, 26 Feb 2026 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T22IshfK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SIWVxmk1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1377D42B748
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132189; cv=none; b=Qu4N0IwUw7TP5I2Xmz6I6F7YYIK+T9PxVInGJ6HJrz13F5lWTrwJNthI/RgnS/esFSCNoHpWfyVPurV399txyULAvDuVrWHTwVFHuq0bg2TmSzDLsy8NjJ5yEnErlk3k7vW9XysoAWAB3Pymfftn6V3iTRrnP9Sg5uawPB4qsN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132189; c=relaxed/simple;
	bh=lUdZQZJ0PKGs+DtbdS8idl3ZBtUd/9rNXKL6guFfSEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E1nLaJOkd8HAADpKzVXF1+ei3PcT1+ErwANBeJ29zH1jf1uDr41IrhgkMv0hXYqgB4mkcStaw0N7jFX9lxWvrStaPBFIqZe1RKg2ntENGmkMakmA26nlQqr7cqYaQe5NEwHXIrs3Ptulz/Ac+n7dg47pjZeHjSRTkhUjCMgX6Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T22IshfK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SIWVxmk1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHEeOL2608759
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=do1JZjgEFS9
	YSM7ehpCWbEonaP1SDiDcALYiQZx9YbM=; b=T22IshfKRzH7CziL/dUsC8QXEqi
	tsdf90V/rjDWOsCoYS2lHFDW7Az8QKJkei5nRFEdcUOMAkwWWKguZIoNMyrOJgoq
	x2eCEjALcTs8I3gCwtpLJAtqSft6ixNiGMCYUMPaEexHRTpSI2PweX/QkxZqduFv
	Av9kRV1KCiuZTpC2mbwcc9KZ7Lx8YsPNgQ03l0ATkOBMeQMt5s1Of0hvRVqKhLPC
	BsG+HuG01Py281QIYIBsB8KSbOTWybL2PIhe8v54BraPV2555QjSWNZcEViaCo8c
	gDNDZ7EdWWY2X6S8cw3JcGrMYVwuE1ennG2zo2xkXJ/8qT/0NkQUUj4kZDQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjt7y8h8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-359124b11easo1195049a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132186; x=1772736986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do1JZjgEFS9YSM7ehpCWbEonaP1SDiDcALYiQZx9YbM=;
        b=SIWVxmk1dx0JUagV56kGMVpyO8bJ4WUExAKWEnAqvzrIIBGoS3lUWLVpfdv2rKALVD
         yp/spYtMLCL2rRv0q0Y3teMKuYV1M4VSh8zTsF1vDozX8EbVAkAHKCFpv5HbxofHprhg
         87+PZAV1lmYWEfj178aL7Az+UqZStheynHYdeV6ybeeuMS1bJcFtGfRQEQn4SjE8VMBc
         TCQQOSraZohwhcrN+bD63cBb8ddwWyWlo68hHvrQtnBh0BlSfL+MrQFwZkagCxOBjeqU
         y0buiSRUt31ogdO0FB/tK79NJWAMXZ1JVTRfhem6e3SoQW28priJ3vjuGP2ynf0lDvJT
         22bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132186; x=1772736986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=do1JZjgEFS9YSM7ehpCWbEonaP1SDiDcALYiQZx9YbM=;
        b=fQedg2imbtkYFlT9emkp7WuX66zQKnfYp8TBmTb0urdLNx3HF5p0gDE8VugyTqs/ch
         VcCySgJ7XQ/9smbS+lhPgjZn4MFVBqEIe0E90yr6labgfgbm59Woj0dHrUEbSh+uQhFu
         QSf2CNN/SXudGvVERDkULeY+Y2GCn1dBfk6wrGJ7DlU8WAC/Z2OCZo85gnGXPxyibtTP
         rn5LWYvrt03vouuXUpNTn14QHbKoJgJ0OVvnKv2I69glKm24+AM5Iw90J8D79B6smpIQ
         xxHlCt3wfOj6JDA0D5//7BTNiKjGZA+tDOfbWfPTpX/EU97/vVYr7TzLnuy/T43cJbaJ
         /06Q==
X-Gm-Message-State: AOJu0YwqFgdLDswXtILLq8x8SKWOf9q+GSjTmsv0uMXZBgxReSQAIxm2
	tHtaSSnsdsyZkw3Y9FamE2ha5SkhRmlU8ySEfVZKG+K1CIrW/Q53ud6y88HTxKYEEdqG9iSkJT1
	19ZYBijRQ55JGMC+5GCPfOPSwm3bRJxEf6GcUy8LsROi4n9YET1M2YNZjfhVU7t97wPzESp/8h/
	guIA==
X-Gm-Gg: ATEYQzwnTan3DIgOfEX47UtRG5e+qPx+MZwJEwk8c8oPUEEjM9SYuK5UYYScOfQQe/J
	yZbP5rRb8W2uQuC9cr7k1TUeZFbWhxJ6NMwCKcWFcT8RycWd7mvZaBRgnvVpgTCNAHr/5dbLUUV
	2dG1rN1xqDXg3LXLFN33MDriwkfestksa08Xs8ohGxyJ/7IssjbrVCdTEPWSgaeVhbYs+8ZyQLz
	xMWDqnHOKPo+8T+pqmRIqGFDbjdMJRQAe8rgQchDNb1Uvn//MZTeVmYhMY5d2fzfKwR0AwsRbKU
	M2kJI6ri9nxMxlevStau6brfGI//BS+W3IR8sF5klSk1QEvWRNI0S6lpMr3oh+8xqsehh+SapKb
	geDFGBpbNXDBDFIp550zL/iMchRmywweJeBNSDwU=
X-Received: by 2002:a17:90b:524a:b0:355:35b0:8b78 with SMTP id 98e67ed59e1d1-35965cd1f74mr156429a91.27.1772132185954;
        Thu, 26 Feb 2026 10:56:25 -0800 (PST)
X-Received: by 2002:a17:90b:524a:b0:355:35b0:8b78 with SMTP id 98e67ed59e1d1-35965cd1f74mr156417a91.27.1772132185451;
        Thu, 26 Feb 2026 10:56:25 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:25 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 5/5] wifi: mac80211: Advertise IEEE 802.1X authentication support
Date: Fri, 27 Feb 2026 00:25:53 +0530
Message-Id: <20260226185553.1516290-6-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
References: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: wgX-eo2IdkBLSp3JKzaOlL1NVSv575mZ
X-Authority-Analysis: v=2.4 cv=N7Mk1m9B c=1 sm=1 tr=0 ts=69a0975b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=DN7Bwe6pV6g0LqCHkYoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: wgX-eo2IdkBLSp3JKzaOlL1NVSv575mZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MyBTYWx0ZWRfX65uMdCpRb5O0
 AmJ675hQT/J+jVZUFWu8+ZALYkxQkYOt2spBUtQ6tYQXGPXhEdjYo+N8KHFH68XaQnWtT6ScXPM
 szEJc0hmiXB3guVgz5rkC/9h/aQhVTWeYoDbJg+tIW7pilV/QQ7Hq/nDHue8L6KjQ6XXgEj5Wjw
 790w24HQCHuOrcoDMlFB96+zft8IDhvyza7BKQT1AwtiT2Ch1Lk5+Ia5fIdJXVW0BzeuiiVNoAm
 u+ijrhCff2yxd/hHDOh6pd5E3uY/3HRbOtDQgoqSB1/qF2cSOSUl7+tpj1PFkEf04JiQWeCDLRf
 16LOKku1IRfyCJQ/KqXCKEIruZdXW1Ra1mRSciKufOl1gXrWnPh1cM1ehghYbaQcm6xninEMhtD
 sCzGnvQVlqaOQy1Wl4LOBJ0In64VEvmVwNF1cPgmk/66SXw6VsD3lIQGVHW+Vb9rxB9M5rGR1Bk
 Ua1NUepwXzEm5tPABfA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602260173
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32222-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C508A1AE31A
X-Rspamd-Action: no action

Advertise support for IEEE 802.1X authentication protocol directly from
mac80211, without depending on driver indication of (Re)Association
frame encryption capability.

As specified in "IEEE P802.11bi/D4.0, clauses 12.16.5 and 12.16.8.2",
IEEE 802.1X authentication can operate with or without (Re)Association
frame encryption support. Therefore, mac80211 can safely advertise
802.1X support independently of driver capabilities.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 93af2f58d7f7..10ddd261b084 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -915,6 +915,7 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
+	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_IEEE8021X_AUTH);
 
 	wiphy->bss_priv_size = sizeof(struct ieee80211_bss);
 
-- 
2.34.1


