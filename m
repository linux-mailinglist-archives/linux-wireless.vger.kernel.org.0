Return-Path: <linux-wireless+bounces-36598-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMGtG9PsCmo89gQAu9opvQ
	(envelope-from <linux-wireless+bounces-36598-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:41:23 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C172E56AD9F
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 12:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA2123051289
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 10:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D753ED5AE;
	Mon, 18 May 2026 10:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FVwlzaC8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kpiR2kmQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA602FB969
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779100298; cv=none; b=VwNStNySa+AP7YBwi97RMgTFCpDdCaQFZ7MMhH/lXIPrSDeulllvtVresRlp/L3Z1UBlqgUNUvwLywr86MonzlIyZsrmkMbam6D34BMNsQvSV4vfA/Jan9exyswT7vpUJxgAttoX9OXpCO5g9caNhlqYzixZk2QsVm2uWPgzjGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779100298; c=relaxed/simple;
	bh=AyR1nfNOOB2OmgVPXbtw2qMwCY2l2jq7GZh//B0ZdLU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzDbMTkcvUwoXHth+P7Q48LAJQBsjtfKKfZm/zdQ6lZT5kWP0ruWrkw64TlVqz63cJlMMwZRLO14s8OVKh5sq/VlcFsqdwKSf02pDPnQTrrTCtPWMlF1hX+d6XDOXaP0FKw05gwOC+UR3q/AX0nfhMeb2h7h4uyBGntznXzM9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FVwlzaC8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kpiR2kmQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7faKW2188804
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UsrB8P290O/
	USMAC10uk93dQneTBe2ZXxLR/4g7icds=; b=FVwlzaC8QAHryHSNTnQ7g5Kq+63
	ocF70WZr/HL5jHVWQHLheH2Wq39Frq3fIyrsOSRr2XvKEvJcWc9NB8oEQWCHvxWs
	0nGXWaAClx5KWaU0dSNXR2qyjLdhffJ7P1cnySIvSAscbIyYJ1Ox7f34hV7UojFI
	MVXJsjjvPYh4OoS5lz9yKb4FA9utkoYr7mpzSCCDhOyx2X9Ndmy1h4FaGpXD6crw
	pa6JFnyYLz2mhGCNGDHN6kGMDCg+wq+RMKcdd3FTRO7RNOv/72qGOeG8nE51XwGr
	jl+336BrDLqhDWdQVBd3YDIeQuhZIVXV/uzp0ddrXGZFU0WizVfr9/zWo5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e7xkugqk7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 10:31:22 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6a5b4f88so3599169b3a.2
        for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779100281; x=1779705081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UsrB8P290O/USMAC10uk93dQneTBe2ZXxLR/4g7icds=;
        b=kpiR2kmQrItLPLgwfVeIn5Oa3DKOXOD9rws9xCvEGIADYGd18HR1XjrpzpqGKnws3F
         zGohzSFi0Maus0yjs2O2I0BHJw+SK05zaz8iwcmVXQcukAsy9ASnF3rnRdxRAiVmwV25
         +bXCoIMbfxQY2j08VRV7Rp67Ps5GBlERoh6SalVqvgLCaHSAbsapTqr3JiaCc1TEe5lZ
         VbzTa02kzQmvzlNZDd7jOkwIcogxjwr8Ns2kp0rS6jMIxzSEuFa24gKyHabWuQsyx74E
         kfpRl4QUI/Xq/E5onYpuVgkbRm+9p+ZIUTjnG8Tqi3R/BqU9/WzjU8nyaBgSsTHuEAQY
         3WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779100281; x=1779705081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UsrB8P290O/USMAC10uk93dQneTBe2ZXxLR/4g7icds=;
        b=h50b2cfw5i+gUFWVB6UxogzUSBgynXd6UZXbNZDk+g8FWxe8aa/oNKHvJttLMXG3lw
         0P3bGDdl+0vCzmB8EJ0l6xMPZxo7FGYEv5cSr0dCQ/cROYYeYjat+NBR/8ynRlfI3JEb
         PhB772U7L1bJ5Iyo5sGxQU+duzgdaGqI37U9Xxws7Ao9vwMNAluADgySr8CebVj68Ihy
         QQ7sIflZD5w7caorfQwuMm3sA1uwRczCdLeYWmRIIWsdyul3GWM58E3C3BL542xZmgUv
         hZisyC1GAXM/r0OEjX1puyQaq0sTxH8ZjWCyWvg6NoOLvAijtLLJ8zU43uY7by6RiT5c
         IbSw==
X-Gm-Message-State: AOJu0YwCF2ZdT84vmRkHRIgngFbw0dd3OOUSOMmtEd2u9lw2IFA2Zq+4
	9b02TJjcCm7KkAkYtUbC3I+br9UElkM+NUgIYgkMsAtAYI1+QO8M7eaLZqpgutW8z/E+SYGQfyk
	2Hd+49/vjgQmbY/ULVjiO+yURL9davqpBAr4w6fqxInSa5MZx1J8dicgDD3qEGqI3JPGx
X-Gm-Gg: Acq92OGubUaqgkjiNaPcB07QV8EfeVg83zAWVRcmuSsDoUlyyHaiVUNIGSIm5NDyjw2
	GAEvNMH7dkGJBIaghuOEVW4sKXKhKHr8FfQ5Kc9UUC6ImXRH67dK6k1VGI5W+a/z56sP6Qx36Ke
	Aqix/Qu1LS8AK6/K/nOzJDDG6zTKb9JovRA4/79+KxE230KCzBLOKhK+dRAWu2vfYMTNcDWumxY
	29fekZqe5VbpNnU02/sXi7ckZdDssoOJBUX1bua971RdM4xvd8uEkWawZXFagA3cwU4+srfks5n
	OZOQA5Hg5TWTtmPO5YCC/rY0QsYGrn3S/dsl29xjP8CYAVZLq25zbVIwX4ykJcIqRKdb5QkDvJL
	uKIa1LFgxFfGyp/5ui6JouPilN7f32LFFrvi9Dha2kAGR+CRS1/AyjrJpBDKbZcgPiEQR6KNIcY
	xxM4dqm1EeCYWF/oQK17mzT4I6r9SidneO9ONDWhdWYPyZfk8=
X-Received: by 2002:aa7:88d1:0:b0:83d:b0a0:90e3 with SMTP id d2e1a72fcca58-83f33c344a1mr15052332b3a.31.1779100281040;
        Mon, 18 May 2026 03:31:21 -0700 (PDT)
X-Received: by 2002:aa7:88d1:0:b0:83d:b0a0:90e3 with SMTP id d2e1a72fcca58-83f33c344a1mr15052297b3a.31.1779100280558;
        Mon, 18 May 2026 03:31:20 -0700 (PDT)
Received: from hu-pshashik-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19775ca3sm15107597b3a.14.2026.05.18.03.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 03:31:20 -0700 (PDT)
From: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, vikram@qti.qualcomm.com,
        kiranv@qti.qualcomm.com, pshashik@qti.qualcomm.com,
        cgopi@qti.qualcomm.com, ybasamma@qti.qualcomm.com,
        vthiagar@qti.qualcomm.com, sivad@qti.qualcomm.com,
        uvignesh@qti.qualcomm.com, mohathan@qti.qualcomm.com,
        abishekg@qti.qualcomm.com
Subject: [PATCH wireless-next 2/2] wifi: cfg80211/mac80211: Pass MCST element value in ch_switch_started_notify
Date: Mon, 18 May 2026 16:01:06 +0530
Message-Id: <20260518103106.1462604-3-shashikala.prabhu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
References: <20260518103106.1462604-1-shashikala.prabhu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEwMSBTYWx0ZWRfX2K2SoRm6EFYg
 04fXZ1CYSFAkFLMVi5pTLrqNu17TxTaH/l/kGed+J99YZeRao+82X53HlsRFKIe9y4Enc9CZTl2
 RvP++sWEKCEGVqg7KNxnshR0XU/jnjFdP04ytIHTIYRkjUvh9nIuWHa3UO2XxiQNsrjInSMG3ji
 QMLC98h0whw96sOgghmP2O4K9emeOJUMPGk5IfD8A1YxORANcNySBWeI+m2RnhfxFx/effJPp3M
 pTt162UyCzTHAKR8/LZuFGSJKfM+ka8XEIe7fLZMPHUyKutY6De2DmlZKey5mrnsKm308sCE2lQ
 1z9ncl8pd051h1/VPD8z5tx00YfOysm53aiSxnkNaDBve17DuwObNSOfU5ssKPNqesYd5Dmjbv2
 ZXNeYqK/oDNl0NDxH6dIg6JC0oYkGLYbD2Q1oIrq7M0Q5D/bmfCUYi9pTQQR6zbw1C/l+B3ZsxL
 FPdpWeJnkg2EkMAEedw==
X-Proofpoint-GUID: zU5S4ZU6BdfkSMdnpUSKgcTMdGa6PJuF
X-Proofpoint-ORIG-GUID: zU5S4ZU6BdfkSMdnpUSKgcTMdGa6PJuF
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=6a0aea7a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=XG50IErifMXcszP_SugA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_02,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180101
X-Rspamd-Queue-Id: C172E56AD9F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-36598-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shashikala.prabhu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Chandru Gopi <cgopi@qti.qualcomm.com>

IEEE Std 802.11-2024 subclause 9.4.2.216 (Max Channel Switch Time element)
defines a Switch Time field in the Channel Switch Announcement (CSA)
element that indicates the time delta between the time the last beacon
is transmitted by the AP in the current channel and the expected time
of the first beacon transmitted by the AP in the new channel.

Forward the already-parsed MCST (Maximum Channel Switch Time) element
value to userspace via the NL80211_CMD_CH_SWITCH_STARTED_NOTIFY netlink
command. Userspace can use this information to decide whether to remain
connected or disconnect before the AP moves to the new channel.

Pass mcst_tu=0 in the __ieee80211_channel_switch() call to
cfg80211_ch_switch_started_notify() since the AP-initiated channel
switch path does not carry a MCST element, as this element is only
present in Beacon/Probe Response frames processed on the STA side via
ieee80211_sta_process_chanswitch().

Signed-off-by: Chandru Gopi <cgopi@qti.qualcomm.com>
Signed-off-by: Shashikala Prabhu <shashikala.prabhu@oss.qualcomm.com>
---
 include/net/cfg80211.h |  4 +++-
 net/mac80211/cfg.c     |  2 +-
 net/mac80211/mlme.c    |  2 +-
 net/wireless/nl80211.c | 12 ++++++++----
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ddcf559430dd..c55b7f4ea48a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -9979,6 +9979,8 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
  * @link_id: the link ID for MLO, must be 0 for non-MLO
  * @count: the number of TBTTs until the channel switch happens
  * @quiet: whether or not immediate quiet was requested by the AP
+ * @mcst_tu: max channel switch time in TUs, 0 if the MCST element was not
+ *	present
  *
  * Inform the userspace about the channel switch that has just
  * started, so that it can take appropriate actions (eg. starting
@@ -9987,7 +9989,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet);
+				       bool quiet, u32 mcst_tu);
 
 /**
  * ieee80211_operating_class_to_band - convert operating class to band
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0b1291ff7a2c..0cb6d949665a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -4768,7 +4768,7 @@ __ieee80211_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 
 	cfg80211_ch_switch_started_notify(sdata->dev,
 					  &link_data->csa.chanreq.oper, link_id,
-					  params->count, params->block_tx);
+					  params->count, params->block_tx, 0);
 
 	if (changed) {
 		ieee80211_link_info_change_notify(sdata, link_data, changed);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 5b02141b0cb2..76f3c3a8feba 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3182,7 +3182,7 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 
 	cfg80211_ch_switch_started_notify(sdata->dev, &csa_ie.chanreq.oper,
 					  link->link_id, csa_ie.count,
-					  csa_ie.mode);
+					  csa_ie.mode, csa_ie.max_switch_time);
 
 	/* we may have to handle timeout for deactivated link in software */
 	now = ktime_get_boottime();
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 14d41142cf79..a17e87e782e4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -22271,7 +22271,8 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 				     struct cfg80211_chan_def *chandef,
 				     gfp_t gfp,
 				     enum nl80211_commands notif,
-				     u8 count, bool quiet)
+				     u8 count, bool quiet,
+				     u32 mcst_tu)
 {
 	struct wireless_dev *wdev = netdev->ieee80211_ptr;
 	struct sk_buff *msg;
@@ -22303,6 +22304,9 @@ static void nl80211_ch_switch_notify(struct cfg80211_registered_device *rdev,
 		if (quiet &&
 		    nla_put_flag(msg, NL80211_ATTR_CH_SWITCH_BLOCK_TX))
 			goto nla_put_failure;
+		if (mcst_tu &&
+		    nla_put_u32(msg, NL80211_ATTR_MAX_CH_SWITCH_TIME, mcst_tu))
+			goto nla_put_failure;
 	}
 
 	genlmsg_end(msg, hdr);
@@ -22355,7 +22359,7 @@ void cfg80211_ch_switch_notify(struct net_device *dev,
 	cfg80211_sched_dfs_chan_update(rdev);
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
-				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false);
+				 NL80211_CMD_CH_SWITCH_NOTIFY, 0, false, 0);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_notify);
 
@@ -22402,7 +22406,7 @@ EXPORT_SYMBOL(cfg80211_incumbent_signal_notify);
 void cfg80211_ch_switch_started_notify(struct net_device *dev,
 				       struct cfg80211_chan_def *chandef,
 				       unsigned int link_id, u8 count,
-				       bool quiet)
+				       bool quiet, u32 mcst_tu)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
 	struct wiphy *wiphy = wdev->wiphy;
@@ -22416,7 +22420,7 @@ void cfg80211_ch_switch_started_notify(struct net_device *dev,
 
 	nl80211_ch_switch_notify(rdev, dev, link_id, chandef, GFP_KERNEL,
 				 NL80211_CMD_CH_SWITCH_STARTED_NOTIFY,
-				 count, quiet);
+				 count, quiet, mcst_tu);
 }
 EXPORT_SYMBOL(cfg80211_ch_switch_started_notify);
 
-- 
2.34.1


