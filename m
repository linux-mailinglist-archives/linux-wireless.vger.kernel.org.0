Return-Path: <linux-wireless+bounces-32035-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kE3yAjZol2nfxwIAu9opvQ
	(envelope-from <linux-wireless+bounces-32035-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:44:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332AE16222E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 20:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA9C63066E6B
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C4630BF79;
	Thu, 19 Feb 2026 19:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P49Taiin";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JFJL9trI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9467C2D0600
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530185; cv=none; b=FD2Nk8b3haPR/mJFFsLAHVESdWzo68TxCUge3f5Z4Mcd3sM0FjB9z7B5Eb9ZgWHSzcAUikk44QJU6ytTQZRKK9s2ofMnz8/LeqoV16Ztc3IJPyXuCFk3k9uRvLi5Ijcmp0cq2AJrJEtAcHa1p1ADieiWOq/Yf2lliRdDIGSZSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530185; c=relaxed/simple;
	bh=01W00KA19CzfPhCzkXdPK6TmMqN+jdXBBWmRF5bs2p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NOGYgEdR+qQnIFboKZ+THBcbY/p0S4TppjqVGttIbTfDwK2a0boWr2sAGYoOvUQRiNhzawdYmjPFmUHcnjtg1mMpQTmR/872BR6A/MF71c2R+CTU9CUhAyE2xmrV7nNna0es/nY/mbZjPqQHzHutGGt28W3ufnDhqPOOf1mt/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P49Taiin; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JFJL9trI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JJZGUk408593
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cw6oegE7BJrIH7ye5GHNWs5b/IUa25g+uNiuS7o/4uw=; b=P49TaiinQnf3Zapr
	kl0aQrMx7MQCzXDWhzNBGjFa4GzzO/I4lQvuwv3gn7t/7dpgnEnkeel3bzzDzUg4
	pLJSxmJrd4JCG/HxHovQxHBl3sphHqMcvXyngw+pFxISyHvk5VEqmmRJewTGRgHc
	VLqDrcUcqo68tT0NYr26VQc1dR/U0X0HKfIbTO6hXpj/Ikr/Os1OuMpojd8N6Yr9
	0AkfS0F3ztsEz43MAlkJ0hwqQXloESXfWNiiOe8YFnGejoSCV4D+6I0b+oNlTebv
	igMzu5rkmODUW1b+cOLY66Yw7bCZje5NqJfSsxF+iS0O0fvo8v68jFu4m/ADArv1
	Qnn0tw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ce2gehe6c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 19:43:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ab0b2e804cso15446625ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 11:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771530182; x=1772134982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cw6oegE7BJrIH7ye5GHNWs5b/IUa25g+uNiuS7o/4uw=;
        b=JFJL9trInjT44dmspCZ5DxLoi3N+2gotydi27ynAkuWeaeFrU/KmKvK07GiQhz2Iw0
         DwavA5pJjPc8O3JL5MMEHRGxQ1AZyEnBCpLjEjJwFLuhWwjeJ5P7/g58oQXOdqphZ0zS
         JM0Nw1w6EcF0lWt0Y9qNGotkkM51+kAIUngbCevn5FQUKzBUtJjolJFI2pj4eAmQs6KU
         U934OUmjFcRdmkET8DFT0ARk+tP4OMOpst0xyDxBarwrU7vlj1+GhYIdsFBK+HiGH1af
         vwMrAiu9b/ZckuWis/+fgwBKjRJ1BgYQI7unyrVlBmMvmkMkIGBDMiMLW1kBGpWyTh6A
         kstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771530182; x=1772134982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cw6oegE7BJrIH7ye5GHNWs5b/IUa25g+uNiuS7o/4uw=;
        b=Q3EcaYxqWa6iRitKvi/qZmKqijO219xZMSDGlnJGikOzbQr5Rln187gNULzCPmqXrJ
         JBx9VAgdBkQoFDcl/78GZ1noo2NgThmwsOjWRbqBUqPpdH2OICFwLyXY4O7sZXy0Rlxf
         5GSLQZJcdCOgSNwDMJWLY3m1CspI9zR7AnbVxClZm2JlinAXM+iyJN1qIvvmiXw/A6Nj
         iJfYLwgx/+/q9JxGcClaKwhYdK/oh0AiuO1W6p6oSz/6FU43dCx0dh486+7hy1GZjTOu
         GGamDszAWvrUaTvudzvTGldlPzbNOrYfGjEd2hpyS0Xab++kD2OdX+fzgwKquqN/P+EL
         naRg==
X-Gm-Message-State: AOJu0YyDym6J4gEqGGHV2GofLPHW49JLaoaI1VxffJPEemEST0dWcYlH
	r0TYAbdp1y+ntxkLZLres/npvHA+DkT+WpdCQu2M/fSFE6FW1YenvR9f2LxxbAKPMSfaIpz/A2T
	dspV5b6hDQ/1E2ijTxtv3TpxlTh6x5gT8Va0B/TSYAZLsoXb3pdNWGo/p/zIDn2Fy8788ZQ==
X-Gm-Gg: AZuq6aJAt/XIsV+evMGzppV064bAhx9Z+puzkN3FUhvSnzixeqa8fhZLQLc4fLo9HzH
	mKl5H/Gf63C9+Er2n3Wp++nMUzOyaTl2b1zcP0a1KkseBT1jtE+zHcSwMvwwJQSdF9Su8KFReSz
	zsOq62ur0WRIf8GzrmX/CMdVztSft2P7ohCnCg55NwfHRQMFUSrhGJhbdaObpjwpNBGtHzWGzCI
	tpa+p6R1IIcseyyUKM/i27ktyuqMbduld6MXiDturFYj68F7iW7wk5GR+dWQUc9LrTxHnZH3yEz
	3b0YDpsn7pGBxHes+ChOgKDoeAlgGcX05INfnd84XtcOKaqTS0RBW28pDsIEHjjiaQPajU8ODCO
	RBKMcFVwlgwaaZUJNpG578Oh9nKEEgnr3rVeFhwID1IsIsMYCNdhOVu5GhcOUyZH5cR9iQard9I
	PhwEM5Ln3cEFth29p3yi4J/THUxcLHap1pTI9PPBQ=
X-Received: by 2002:a17:903:2ec3:b0:2aa:d630:cd5d with SMTP id d9443c01a7336-2ad5b144c92mr33071595ad.44.1771530182049;
        Thu, 19 Feb 2026 11:43:02 -0800 (PST)
X-Received: by 2002:a17:903:2ec3:b0:2aa:d630:cd5d with SMTP id d9443c01a7336-2ad5b144c92mr33071375ad.44.1771530181608;
        Thu, 19 Feb 2026 11:43:01 -0800 (PST)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a712ed9sm264404225ad.20.2026.02.19.11.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 11:43:01 -0800 (PST)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Date: Fri, 20 Feb 2026 01:12:42 +0530
Subject: [PATCH wireless-next 2/2] wifi: mac80211: fetch unsolicited probe
 response template by link ID
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-fils-prob-by-link-v1-2-a2746a853f75@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=Z5/h3XRA c=1 sm=1 tr=0 ts=699767c6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tVayKBx9Dmlhv4CN5F0A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: qlb51n_7J7tNtT_Nk0fFaZEu5m-3XVD5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE3OSBTYWx0ZWRfX/r1mRivOvTm6
 yEKw70H1JMzH3SFowBQ4Y8tsf/6wn1DUsyHtocTEgcHupImWCRNnQDqFhTy0GbUsnmvjnrlpf9O
 QX6HSw0YT8UsG8HSnKJw6RnCMzX2nUAMB+hw2ezn9292VJ0c2cf6A8xphAuNn2GtyIiQ4iIY/Je
 5dyMbTLgmNxzEgNbhJ0J+uothIdZULVVXGS/9JWg32IBGM/K798xUh9XR1Atc/5lsd04o2ATKqr
 450PoroUiprSDNm2E0GwUPH8OMlxjBDbkMA6jw/Cy2BVxfOjlkWuXhWX+aM9ybX/S6cRNxFlfFo
 p8MkGDcR2lvpMiA+X21lb9OCNXHJHa3r8rayJHx96hnyjn3QRuFv7xL2EdYBFs/3qGYiR6wgzUi
 Qw2riKsrdR4Bv8f58UeuZ74r6wFe+zn1Ebj5jbe5u/567P/9iR5KGhew4u+xVUQxN9ETNoHoKux
 fY7GY5VjXe2MsJ8qHpQ==
X-Proofpoint-ORIG-GUID: qlb51n_7J7tNtT_Nk0fFaZEu5m-3XVD5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_04,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190179
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32035-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,quicinc.com:email];
	FREEMAIL_TO(0.00)[kernel.org,nbd.name,mediatek.com,gmail.com,collabora.com,sipsolutions.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 332AE16222E
X-Rspamd-Action: no action

From: Sriram R <quic_srirrama@quicinc.com>

Currently, the unsolicited probe response template is always fetched from
the default link of a virtual interface in both Multi-Link Operation (MLO)
and non-MLO cases. However, in the MLO case there is a need to fetch the
unsolicited probe response template from a specific link instead of the
default link.

Hence, add support for fetching the unsolicited probe response template
based on the link ID from the corresponding link data.

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
index 4776bb6fc889..d9b5eac6c7bb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3314,7 +3314,7 @@ static int ath11k_mac_fils_discovery(struct ath11k_vif *arvif,
 		interval = info->unsol_bcast_probe_resp_interval;
 
 		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(ar->hw,
-								 arvif->vif);
+								 arvif->vif, 0);
 		if (tmpl)
 			ret = ath11k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
 							 tmpl);
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 34f82cda4197..b281f81039fb 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4320,7 +4320,8 @@ static int ath12k_mac_fils_discovery(struct ath12k_link_vif *arvif,
 		unsol_bcast_probe_resp_enabled = 1;
 		interval = info->unsol_bcast_probe_resp_interval;
 
-		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
+		tmpl = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif,
+								 info->link_id);
 		if (tmpl)
 			ret = ath12k_wmi_probe_resp_tmpl(ar, arvif->vdev_id,
 							 tmpl);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 83ce06857a1e..2d2f34aa465d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1981,7 +1981,7 @@ mt7915_mcu_add_inband_discov(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
 		   vif->bss_conf.unsol_bcast_probe_resp_interval) {
 		interval = vif->bss_conf.unsol_bcast_probe_resp_interval;
-		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
+		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif, 0);
 	}
 
 	if (!skb) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 795a294fa904..c3cb4a33cb3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2868,7 +2868,8 @@ int mt7996_mcu_beacon_inband_discov(struct mt7996_dev *dev,
 	} else if (changed & BSS_CHANGED_UNSOL_BCAST_PROBE_RESP &&
 		   link_conf->unsol_bcast_probe_resp_interval) {
 		interval = link_conf->unsol_bcast_probe_resp_interval;
-		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif);
+		skb = ieee80211_get_unsol_bcast_probe_resp_tmpl(hw, vif,
+								link_conf->link_id);
 	}
 
 	if (!skb) {
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index d36c14a86c8a..89027e94ba5c 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7781,6 +7781,7 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
  *	probe response template.
  * @hw: pointer obtained from ieee80211_alloc_hw().
  * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_id: valid link_id during MLO or 0 for non-MLO.
  *
  * The driver is responsible for freeing the returned skb.
  *
@@ -7788,7 +7789,8 @@ struct sk_buff *ieee80211_get_fils_discovery_tmpl(struct ieee80211_hw *hw,
  */
 struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
-					  struct ieee80211_vif *vif);
+					  struct ieee80211_vif *vif,
+					  unsigned int link_id);
 
 /**
  * ieee80211_obss_color_collision_notify - notify userland about a BSS color
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index f547cfb27666..9f2363a34511 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -5874,21 +5874,28 @@ EXPORT_SYMBOL(ieee80211_get_fils_discovery_tmpl);
 
 struct sk_buff *
 ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
-					  struct ieee80211_vif *vif)
+					  struct ieee80211_vif *vif,
+					  unsigned int link_id)
 {
 	struct sk_buff *skb = NULL;
 	struct unsol_bcast_probe_resp_data *tmpl = NULL;
 	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+	struct ieee80211_link_data *link;
 
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
 		return NULL;
 
-	rcu_read_lock();
-	tmpl = rcu_dereference(sdata->deflink.u.ap.unsol_bcast_probe_resp);
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
+	tmpl = rcu_dereference(link->u.ap.unsol_bcast_probe_resp);
+	if (!tmpl)
 		return NULL;
-	}
 
 	skb = dev_alloc_skb(sdata->local->hw.extra_tx_headroom + tmpl->len);
 	if (skb) {
@@ -5896,7 +5903,6 @@ ieee80211_get_unsol_bcast_probe_resp_tmpl(struct ieee80211_hw *hw,
 		skb_put_data(skb, tmpl->data, tmpl->len);
 	}
 
-	rcu_read_unlock();
 	return skb;
 }
 EXPORT_SYMBOL(ieee80211_get_unsol_bcast_probe_resp_tmpl);

-- 
2.34.1


