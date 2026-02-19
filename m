Return-Path: <linux-wireless+bounces-32034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPuFKxRol2nfxwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:44:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 580AE162217
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94B61305AC9B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 19:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261F330BF6F;
	Thu, 19 Feb 2026 19:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DANjuMZW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QK6IgbmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1156309F18
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530180; cv=none; b=Z8P2Hwvt2ZJc2hpwVebhEQPvL37Gh18mkYHLrkbeFhdycqWF6e0EnxdKeJQM6lLv3EP8OTZROK2fXWVpyZJB3JZHMSiocdmz1PhQ8xK5ssIyGqE0cFlF93f34PG2ZwgJ21LcR5103yUjzT82pJPKhOjJbJKvYFfniax6UR/gGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530180; c=relaxed/simple;
	bh=5Xq8cH8UextoMw31S+uSZYrM/9dwxqrsXMjrbtcbjrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcfFfmn+cHHxaHrjN43PRKCwWOSOiUxCPQYFAhi1m1KZpGNeuEG97U8/ACHh3PXv8Vseda/yEywokMMB+zPRLz7adjihgj4Wu7pKRtPhAwScZr2NRgnwfrlBRvDxTujnf1syW2hi8pQ14pEO0HqxAb+R0nNcUyxY+TiwcinAcSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DANjuMZW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QK6IgbmI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JBMFAQ3564388
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FmxNHp+wAQ9sYx3bt/fGgakAW78bGdOHRXPUHaz0Tz0=; b=DANjuMZW7UtPXq/c
	SnOshB5sStiI8ii369enB5ysZHnVGjAO3fw+HMIkz9Qczvxc0b9CkGC/x3eK4yF9
	L1KZIRy2pBdgpikbk81lgEXK1Kbvhl/tI1dJLev4DdHU/Os77r3OYKoJCPeIsM2M
	+3IDo88SPE3ZjRw3EYYJGFTElsBpu+/44PZc+9PAlemMRrEr7pDrmM9WPN9dYGl7
	18MokW7GyVgQN4yf5e2t7QzHBaPuApVBBJrhj5yl4jIi9E016NXrudaDe8kgvMeN
	6Y6hI1SGw9VxtLm7UhsqYesdPhmvWdnns9QJhTRLk3NS+ibTmxW33xtWk3DhIgkh
	5MxJ5A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce1k81hy5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:42:57 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f2381ea85so102140515ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771530177; x=1772134977; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmxNHp+wAQ9sYx3bt/fGgakAW78bGdOHRXPUHaz0Tz0=;
        b=QK6IgbmI2Y31vUUcoseqgraUl/cJQePzv3Sgr7f6U8lOD8WeFXyZjbGD0Q3eRMwvxe
         eUnDmBIZOhVsxv2Qqhc6AoBZ2jE5n4o+sj73ZhBdCusSCzUz/kA8YKlaYDz5ZV3wdTmw
         7NSETiUVBKmr3WeZy5ixZutcmGMCIE3ok7ATb3iUABUNBKSJNaAA1OhtQkt5TB8WU91R
         2NmpJklyOpUKdTi6uz8T6BOvQWfO9W8RvveQoRCfZ6SInCD2YJnFKDFdhCODXBBMu/97
         AYPf45NrFOk58N0vjpk3o4qvkIQ/mqN3Rz5r3QvjTuSEhZYvUGIrnw0XJbwJTTJcYQKN
         Be0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530177; x=1772134977;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FmxNHp+wAQ9sYx3bt/fGgakAW78bGdOHRXPUHaz0Tz0=;
        b=TDTehCOTS29tpaXUpdQNnmZZDrNEFP3olOCReDXjrcQF3AGk5acqKDCE2nRa3Y4geO
         R5OrMyOiX59rDOauMKhPV/NUERG2ajaTM2ZJ6mERKeaojn17sr+zSkuhJv7JvyZQnC9d
         yTAS060weZifx0d5VxKFrsYN67+d6Awa4erUMNgU1eV/jWU1X/6IGpMu/ihEV/OugRZw
         /QhRSC9ZVYkKv+1/nXAS1JKoQJ64kiNNwMriFkF9mARy7FBzqscbSCJE3prSMjn8eGD2
         eN/XOdfBCpMUFpkQEJcFaiihcroWRIoWgMFwrp9Lkq/a+pBIAAjH3W8H3S4x84o/W9p3
         eHzg==
X-Gm-Message-State: AOJu0YxWEG25/yPa/B8iDPCH7pRpto0YJbphNmO3xkNnQPevJzyA7Pdw
	M36gMpJ3WWZ1BfDqdVo59Lp4VLsv8Rj1jWeMEqAfrJ/RlMAkrtUEj2Yid8ePWj78lLrEfscvNxe
	FzN3KliV4ipBnC82CuJPvH4BFnLhlmwWoyrHAt/k1Uu/zZBr5McwN/40I7NWWAqPPauZBdg==
X-Gm-Gg: AZuq6aJ5tqf200V50+uzOhJZE2+2/Z3DIyLA222VxIPdv/EDOLm6FyrTSQfciuepbIb
	BlE6aO4yxIPz9iF4r7uWcR9IkHx9j6J7+jh8VK2NfPKupKpOP0hLw8eTEbK6Vk9tm1IIcJH1sxa
	6Izq7TEMCAO8E4JHMkFv5JKldxy1Bh30oyERZpNcTmkBYDrsZ9ui96SisX2PdBjz+3PR/CQu2w3
	Jp+iyDhYS1OyFUk2IVte5K91qiHM79k2SS2AC+SBLUgb/1ZxdZwpYSYFPdV7k37nnwJSWNTrz3d
	0nLLvORSUqFSzDHqxHLD2Wt2lFAmvKqAFCH8N1nOZu9OkRbqaHn+VQUtYyMn6/y+zQgjwcGdhXN
	EGJQkJZFXEDz2ZAm8KIyqlYMxBlY/Zw06WN+/s4yzslCmaE8b4Awgx7FTcB065IiGDmPim8IZrT
	dYJz6XZvbhd11paAOeZgXjLpHecs8MdMCpPFL5rUo=
X-Received: by 2002:a17:902:d591:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2ad17591077mr197413015ad.52.1771530176614;
        Thu, 19 Feb 2026 11:42:56 -0800 (PST)
X-Received: by 2002:a17:902:d591:b0:298:5abe:4b1 with SMTP id d9443c01a7336-2ad17591077mr197412775ad.52.1771530176165;
        Thu, 19 Feb 2026 11:42:56 -0800 (PST)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a712ed9sm264404225ad.20.2026.02.19.11.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:42:55 -0800 (PST)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 01:12:41 +0530
Subject: [PATCH wireless-next 1/2] wifi: mac80211: fetch FILS discovery
 template by link ID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fils-prob-by-link-v1-1-a2746a853f75@oss.qualcomm.com>
References: <20260220-fils-prob-by-link-v1-0-a2746a853f75@oss.qualcomm.com>
In-Reply-To: <20260220-fils-prob-by-link-v1-0-a2746a853f75@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>, Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Sriram R <quic_srirrama@quicinc.com>,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: ugokkfQqm0MeOKeWpkqiyiMfFYTZiDLP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE3OSBTYWx0ZWRfX2C7IdfXyGmKe
 TZeBr+XMTgyj04/GA05Hj+GwLvt3viwKT8Ac3XMAjvfsWWaDB8vw25qSp99SlEtn0+7UEXUewIF
 VZxLAgOUExlW+BX9MhKFNkCKxQhjSdCOX6XfsNh+x41038PjDMi7JlJbiSc6zTB/DNHde8KSex/
 AIbMQjMu++0eBobfr1mNcogMs5sCbeo9Nl3fe8BgmbR/oT144gkrcAfmDdCY2IYiVRvICfroOLB
 CRTH5xUBnnLhR/NVYhTwe58WWiFHs4fKebQbYNcHutgG0VxeZ7FqEpBLt4nblaX8nIkF9xh9rq6
 9DDXGLEDz1o27xA6NZ5PBoO2Cicort/eTeHJpHk8Hz5vJFcQqP1c7fDurtcY4E9KosgI2e/dHRE
 h4JR4XcIdKNlplnnY1xdeh5zZPmtotS+fAnkChLJNd+bsPx7ZPYJC60+H7duGNUywnsijpjsF22
 zBya03eZtrey2Omaixw==
X-Authority-Analysis: v=2.4 cv=cdrfb3DM c=1 sm=1 tr=0 ts=699767c1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=uhjc5PK_p913YsLhG_cA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ugokkfQqm0MeOKeWpkqiyiMfFYTZiDLP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602190179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32034-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,quicinc.com:email];
	FREEMAIL_TO(0.00)[kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 580AE162217
X-Rspamd-Action: no action

From: Sriram R <quic_srirrama@quicinc.com>

Currently, the FILS discovery template is always fetched from the default
link of a virtual interface in both Multi-Link Operation (MLO) and
non-MLO cases. However, in the MLO case there is a need to fetch the FILS
discovery template from a specific link instead of the default link.

Hence, add support for fetching the FILS discovery template based on the
link ID from the corresponding link data.

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Co-developed-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/mac.c           |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c           |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  3 ++-
 include/net/mac80211.h                          |  4 +++-
 net/mac80211/tx.c                               | 20 +++++++++++++-------
 6 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 4dfd08b58416..4776bb6fc889 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3305,7 +3305,7 @@ static int ath11k_mac_fils_discovery(struct ath11k_vif *arvif,
 	if (info->fils_discovery.max_interval) {
 		interval = info->fils_discovery.max_interval;
 
-		tmpl = ieee80211_get_fils_discovery_tmpl(ar->hw, arvif->vif);
+		tmpl = ieee80211_get_fils_discovery_tmpl(ar->hw, arvif->vif, 0);
 		if (tmpl)
 			ret = ath11k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
 							     tmpl);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68431a0e128e..34f82cda4197 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4311,7 +4311,8 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 	if (info->fils_discovery.max_interval) {
 		interval = info->fils_discovery.max_interval;
 
-		tmpl = ieee80211_get_fils_discovery_tmpl(hw, vif);
+		tmpl = ieee80211_get_fils_discovery_tmpl(hw, vif,
+							 info->link_id);
 		if (tmpl)
 			ret = ath12k_wmi_fils_discovery_tmpl(ar, arvif->vdev_id,
 							     tmpl);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 00bff4d3aab8..83ce06857a1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1977,7 +1977,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	if (changed & BSS_CHANGED_FILS_DISCOVERY) {
 		interval = vif->bss_conf.fils_discovery.max_interval;
-		skb = ieee80211_get_fils_discovery_tmpl(hw, vif);
+		skb = ieee80211_get_fils_discovery_tmpl(hw, vif, 0);
 	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
 		   vif->bss_conf.unsol_bcast_probe_resp_interval) {
 		interval = vif->bss_conf.unsol_bcast_probe_resp_interval;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 14a88ef79b6c..795a294fa904 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2863,7 +2863,8 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	if (changed & BSS_CHANGED_FILS_DISCOVERY &&
 	    link_conf->fils_discovery.max_interval) {
 		interval = link_conf->fils_discovery.max_interval;
-		skb = ieee80211_get_fils_discovery_tmpl(hw, vif);
+		skb = ieee80211_get_fils_discovery_tmpl(hw, vif,
+							link_conf->link_id);
 	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
 		   link_conf->unsol_bcast_probe_resp_interval) {
 		interval = link_conf->unsol_bcast_probe_resp_interval;
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4e..d36c14a86c8a 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7766,13 +7766,15 @@ u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
  * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
  * @hw: pointer obtained from ieee80211_alloc_hw().
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO.
  *
  * The driver is responsible for freeing the returned skb.
  *
  * Return: FILS discovery template. %NULL on error.
  */
 struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
-						  struct ieee80211_vif *vif);
+						  struct ieee80211_vif *vif,
+						  unsigned int link_id);
 
 /**
  * ieee80211_get_unsol_bcast_probe_resp_tmpl - Get unsolicited broadcast
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 007f5a368d41..f547cfb27666 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5839,21 +5839,28 @@ struct sk_buff *ieee80211_proberesp_get(struct ieee80211_hw *hw,
 EXPORT_SYMBOL(ieee80211_proberesp_get);
 
 struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
-						  struct ieee80211_vif *vif)
+						  struct ieee80211_vif *vif,
+						  unsigned int link_id)
 {
 	struct sk_buff *skb = NULL;
 	struct fils_discovery_data *tmpl = NULL;
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return NULL;
 
-	rcu_read_lock();
-	tmpl = rcu_dereference(sdata->deflink.u.ap.fils_discovery);
-	if (!tmpl) {
-		rcu_read_unlock();
+	if (link_id >= IEEE80211_MLD_MAX_NUM_LINKS)
+		return NULL;
+
+	guard(rcu)();
+	link = rcu_dereference(sdata->link[link_id]);
+	if (!link)
+		return NULL;
+
+	tmpl = rcu_dereference(link->u.ap.fils_discovery);
+	if (!tmpl)
 		return NULL;
-	}
 
 	skb = dev_alloc_skb(sdata->local->hw.extra_tx_headroom + tmpl->len);
 	if (skb) {
@@ -5861,7 +5868,6 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
 		skb_put_data(skb, tmpl->data, tmpl->len);
 	}
 
-	rcu_read_unlock();
 	return skb;
 }
 EXPORT_SYMBOL(ieee80211_get_fils_discovery_tmpl);

-- 
2.34.1


