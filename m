Return-Path: <linux-wireless+bounces-17116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A71A03179
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 21:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C11C18806F5
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Jan 2025 20:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CD61DE2A1;
	Mon,  6 Jan 2025 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMychppz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47391C69D
	for <linux-wireless@vger.kernel.org>; Mon,  6 Jan 2025 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195648; cv=none; b=OfP+A0W7vV4KlMK9hNJ23BbjGSrgrupvJJv1DuKj4bvGSY7w/SEEvQel06sXuj3yuG1qNzrrjQreKlzdExRo2S9xQCgBPMKB8z6Y2X+QTdMnpOJTSfAjKaSoDj8VFcTt7fpkADTj/EbvTlDfmpD3ADIJqXq/2x8n4CrwsfvpJ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195648; c=relaxed/simple;
	bh=5BevhNW2iK55uA4Y0c1MHgtpjZI0IOrACQc4C/pl/l0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hC+Vw7KMkZSIVstlA2zCm7suhO804sF3EVqsEFjS97YZlr+4tTkYVo3qH91bAL14yP7WZFFTcEgDKIrZt6eTyuf/Ouiiq7uxZjxp1XGRIvJF5E/bSVH16H+n3dbptqgLutCZD9vl+BUwOAKJJFvih5XkQzSllbLLSP99SCv6Xb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMychppz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 506E5bkv004556
	for <linux-wireless@vger.kernel.org>; Mon, 6 Jan 2025 20:34:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=q/INDQ7qjJ0ZJyPA3Jb+3D
	Xmxw6G5RVrvKrAA+KLfMo=; b=FMychppzcMZbzg0Rar8uO5wMwUJhKvl0gjGnWK
	a9eCfncGDekyUQdTy46AeFyXFh1b/a2oBGMplqjsla4j0In88TSBGeT5DBby7Dlr
	8nb6HbGR6RLN/rQ9VLnQCUvuKSrPu7TFZRAwzGMlv5jgt2udNYueuPN/YSU7bn2Y
	GYyUUS4VO34xzyxivMfV7BV7wAPn55L/VCkn/O8igzUfMD5STVa6/wXNYzVGIoif
	ta22mO7d5xJMNtCqSk2neLcZzKEFFJ+AAQfwIZPs35CzDLamLNco+iTuSWYFyL/P
	nspBiNjJS5zA/5QKljjSYWvOU6ok2r0o28M64FlnGSWXm3yg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 440gmtgtf6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 20:34:05 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-21661949f23so351866795ad.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Jan 2025 12:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195644; x=1736800444;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/INDQ7qjJ0ZJyPA3Jb+3DXmxw6G5RVrvKrAA+KLfMo=;
        b=s0rUbF65q2kwg+54ix0pYF+rWXXmBjGI/BgCWs+XtvSHiTxvrAaQ4PUfcjqeZ7Hrxe
         SRGzrlcVOXDWDCgeycXu9m3toKpJokV4RC3B8mPgDIOVgVriAXc2vSLa2E2Je14jR/Uk
         4o33d1W8KZhuMQ53ISEvowdxTUFxZgTHbjCUKh/krQD2zAk8tyXA3c4QOWKd1kIfLutF
         ZBRP+oA7EinEq+MDpgB+9hwIj6V0wZHyCxG37SjBhW+rxfKfdVIbl91nu/UW6rVqlF00
         Ib89qRGQ6UTOYd1k+GWYyYVE3+4MBJzF9jYP+ZmfrXFNS1p71Gl/359r9WO9CKPNz8wj
         TS7A==
X-Gm-Message-State: AOJu0Yz77Gn0FfaMZ3+aDZRqBPzbTKjdxXek0AYy/4oBhJ3/AnxHxnKq
	YjGnl01vj/lqkVd2QBKhd/vBXx0xnDFgz7cbp+sFp2en/sJE2bdhakx34t4cAbrVZRWx8PFrCd/
	dgwKk/4yKidHtMyyPgxLW6ml9K7SaMBIBuY3XEN7BbQaWvICcJtDH++gkBBCkU99wZw==
X-Gm-Gg: ASbGncsZ2/UNhGU+70CUw7y3O5NWkcjO/dfphxs4985EpA5Hq7+TeLENwY4RBR8Jxq2
	W2jMCOfypabyWJOmziis01rgIaWJ0WFR6p6sJBmyThdRg93NXNIwghfDPlfNP9Cuh2TvKDYpIAG
	6qugToGNdN60swpVXRp1L/yLWDABTDNp2oQi0H/jzOO3IuIefn1IP0t1+W1ZC5jIWjsWlreNLvn
	INuDS2rq91xCtJovr5RThuiUv60fVhRGhMdmYCpiEK0SALffQk1etCBUXgTHX/iQFk96UPzBBy7
	uGPDrAJOPyB/rRCzQA==
X-Received: by 2002:a17:903:120d:b0:216:5af7:5a8e with SMTP id d9443c01a7336-219e6ebdc17mr897346985ad.26.1736195644262;
        Mon, 06 Jan 2025 12:34:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1weE5s3+aLjElRwpdx44ObYuQj/BDyTP7J1GtI39oyYh/6nED8ahsQdSpNFr2DPhdiLxiTQ==
X-Received: by 2002:a17:903:120d:b0:216:5af7:5a8e with SMTP id d9443c01a7336-219e6ebdc17mr897346725ad.26.1736195643802;
        Mon, 06 Jan 2025 12:34:03 -0800 (PST)
Received: from [169.254.0.1] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9d44a0sm296196145ad.165.2025.01.06.12.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 12:34:03 -0800 (PST)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Mon, 06 Jan 2025 12:34:02 -0800
Subject: [PATCH] wifi: brcmfmac: Add missing Return: to function
 documentation
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-brcmfmac-kdoc-v1-1-ed72196e21a1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADk+fGcC/x3MSw7CMAwA0atUXmMpiSi/qyAWTuJSC5KiGNFKV
 e+OYfkWMysoN2GFS7dC44+oTNXgdx2kkeqdUbIZggu98+6AsaUyFEr4yFNCn/fn0zGESDGDNa/
 Ggyz/3/VmjqRsCdU0/i6zNH6yKlZe3lhIKmzbF8JMt++EAAAA
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
        brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.0
X-Proofpoint-ORIG-GUID: pTFY0G3TDupUx99pE_OAw-PIsF2gjzmY
X-Proofpoint-GUID: pTFY0G3TDupUx99pE_OAw-PIsF2gjzmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060179

Running 'scripts/kernel-doc -Wall -Werror -none' flagged the following
kernel-doc issues:

drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:823: warning: No description found for return value of 'brcmf_apsta_add_vif'
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:907: warning: No description found for return value of 'brcmf_mon_add_vif'
drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c:7419: warning: No description found for return value of 'brcmf_setup_ifmodes'

Add the missing 'Return:' tags to the kernel-doc of these functions.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
FYI these issues were observed as part of my internal pre-commit
checking of an upcoming cfg80211 change that modifies a driver API.
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 902ac3108782..4b70845e1a26 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -814,6 +814,8 @@ static int brcmf_cfg80211_request_ap_if(struct brcmf_if *ifp)
  * @name: name of the new interface.
  * @params: contains mac address for AP or STA device.
  * @type: interface type.
+ *
+ * Return: pointer to new vif on success, ERR_PTR(-errno) if not
  */
 static
 struct wireless_dev *brcmf_apsta_add_vif(struct wiphy *wiphy, const char *name,
@@ -900,6 +902,8 @@ static bool brcmf_is_ibssmode(struct brcmf_cfg80211_vif *vif)
  *
  * @wiphy: wiphy device of new interface.
  * @name: name of the new interface.
+ *
+ * Return: pointer to new vif on success, ERR_PTR(-errno) if not
  */
 static struct wireless_dev *brcmf_mon_add_vif(struct wiphy *wiphy,
 					      const char *name)
@@ -7412,6 +7416,8 @@ brcmf_txrx_stypes[NUM_NL80211_IFTYPES] = {
  * p2p, rsdb, and no mbss:
  *	#STA <= 1, #P2P-DEV <= 1, #{P2P-CL, P2P-GO} <= 2, AP <= 2,
  *	 channels = 2, 4 total
+ *
+ * Return: 0 on success, negative errno on failure
  */
 static int brcmf_setup_ifmodes(struct wiphy *wiphy, struct brcmf_if *ifp)
 {

---
base-commit: b73e56f16250c6124f8975636f1844472f6fd450
change-id: 20250106-brcmfmac-kdoc-1d498722babd


