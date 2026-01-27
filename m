Return-Path: <linux-wireless+bounces-31197-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGGPNTMyeGlRowEAu9opvQ
	(envelope-from <linux-wireless+bounces-31197-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:34:11 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 526E88F999
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 04:34:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB334301C92D
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 03:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114B92D24B7;
	Tue, 27 Jan 2026 03:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AIgaAaH/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfkOZ2vg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F5280CE5
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769484849; cv=none; b=ekkzT3k5ozLIgn4ULe56djO5o8uyG6wVZvAIaYCpoL5Sz36GbucGrlj5rvlNF5BquGz6tMlgs/VQxcTPX57pKlwnSwMOEobn4CMmLQ+C/2GKiSergynDFBjilcrtH/wwN4ht4vjfm/VhszzAY3y5jgsxHXcy1SVW+2LRIoXwKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769484849; c=relaxed/simple;
	bh=jl/rJfb1UxscEBaSjSdrwhDdZOC5zc+QFiSovZ1m/L8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t74Y7HNj2S7shlak59bIOFzab/8GXiGARLiHmxVtgWHrPJRiidW6K5gxAjs7iLnV52yuxhKXFzvlJNrfOwAhzpaPTJnGVVkz9NjwplV6H97ZvptC2yWWuhuvFgyK6MfElPZIcec3mAZqhnwoaSFPTygBvYgis+BMNVbsK6AERrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AIgaAaH/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FfkOZ2vg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60QKgQq13384643
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=lr2+tNxH4fOHIvQOeYoJgdvCBLvY2/PQOfo
	BT4idddo=; b=AIgaAaH/T5bYvOrniiEjPifgU2BpvnWQQURxZl8CzSwnhWHNZET
	gabng2xqaeMUttIstbv1NiBn2Gj+M/NcyeCEhDwHKphiSE50p9+bogvEsdXvBN1M
	1M9bwlOvAUSFzYjPkPsQx/QhGwpdVYqtdkQ4SVUocdvlCF1T11+9wbzNDK+3DhHc
	sGRA6NxjE+WBdy1I3o5V1VselDagGgs3T9wqgtDAXWnPCPuaUEjHAWYqwNPZx+E0
	16hEXJqG/w1TI9UywBGzNkUGN+yi2BrVCVDealtpr+ZkQ8CclSh304m0rGSkn2qL
	mJ6GxbWAfk1QeRRLza//xzTbqYToS3kl8fA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a116w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 27 Jan 2026 03:34:06 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so3391479a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 19:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769484846; x=1770089646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr2+tNxH4fOHIvQOeYoJgdvCBLvY2/PQOfoBT4idddo=;
        b=FfkOZ2vgxfkHjzqFHeFmf/GdgrG/PSTdZM4bro6pKSr6ZIIN4kH+0J7Ap0I+8obNKe
         +cGIk3eLxfC2rP1Z+GI9XR4GzLRYn/MQaYAY89Zpzsx7Lij6GTX5W61PgA8mzOZd6DKs
         HBJJA8+HkMMki2oMzCnMbDFGnOBWG1oCOlfUNduZZLxDg0SRSF0NEqogrOyGDcLca+q0
         60vtBaWV8X7TL17nEIJQo63wtB3s7mnVFtBRskK+RslPMe2odDNVM+BcNjRsDtRa8VC1
         EuZ0HSgmTVkwaI8ZKrVK+iTNPkczPgUUL03tgkbvRi++fJJUrVClIan53PakDza4jPS/
         fl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769484846; x=1770089646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr2+tNxH4fOHIvQOeYoJgdvCBLvY2/PQOfoBT4idddo=;
        b=YtL46HKocgAWGa3O36Lyo08tMmDzVRO35JmVM3i3t0iQtki+n/Z0xxEvV+1jDN93h/
         aJSinTg6v1ZzrNpww57FVNsmHLfE6QFYcyJYDzxgbXlvpIDOxvEa1SoIAj0sYPt9+hte
         HUe3hvvQTgVPLAiwBjG7ooE5hyLapfNQv9wwYtBmJsWq5778Cdfxwsjen/7EnCHupgB7
         f0zEsQXOFjSvs1IrBMZZMOROo4UIb1wT5LVAneHQ+qmVjWY57vIQE9tecB7TIYfmQCwk
         AMFvjyQt113YM2eTzW2wZhioPKbjLe0uNsFWOfCR9Dj8Ouj+KqC/uGOQWWONR6FPSRvJ
         qn+A==
X-Gm-Message-State: AOJu0Yw+OTS9YhRh6dqx0DjufemS1KcSg2z8BbFLobIxXqzFN1BskkEH
	bjsAILgmLsxSaNyWIHnYd6p725I9XVyLJJm4iX9x0HZvFD+mJ2rwh1AViZAIYXtAJOGU2NcpnI/
	nq1XTBUzJStvkTG/EbuRtz/VLbNDe+7lEK+KOgDPYxKFA2MPOl5Hk5YFSPdO9Rk9mZyAfLeNYDc
	SjIA==
X-Gm-Gg: AZuq6aJQV8F/pRzoww6DbF8ya39T50P/AslD/lCJgiLWyX3AXtjeDShETFJ7MjNycBX
	gzx4qOEn6RA64euMrAJTvhM52vIRt3BHwJsO3WwnkzUZ/2plEUgEYAFqePMhYMdNRZYgFJAB1RR
	P9+3mrAXoDP8Z1/SamDiuWdf2djSTxqishRaVT58zxrdBJQ3tQvAp3fftEx18190TGe5sRdQaAL
	G1wQrOVtaQfiBoXQKufIt3tT366ZA+tZvD+iaR3fDNOr4AjCIR/mTd1MlHU40Ql2AN5B2E0ajBy
	VvzsEbpu8m0daN7QzUUXfo0yGSDtD0ub8BEryFM8heFYnUDcumMO3zkUnAa7jPROd9FszaP9Ewj
	q5z5Iy6j8AitZ1NS7+crcHuzJVFt+y5b0BzWj/9E4dGQN7sMF8lZrt48XHm5tgXICA53VYvXypM
	sRksZXtvAxUWUNGB/TXIbV3PAsNznbQx8Z
X-Received: by 2002:aa7:88ce:0:b0:823:b1f:893a with SMTP id d2e1a72fcca58-823692c3a61mr411949b3a.48.1769484845926;
        Mon, 26 Jan 2026 19:34:05 -0800 (PST)
X-Received: by 2002:aa7:88ce:0:b0:823:b1f:893a with SMTP id d2e1a72fcca58-823692c3a61mr411919b3a.48.1769484845436;
        Mon, 26 Jan 2026 19:34:05 -0800 (PST)
Received: from hu-aarasahu-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82339095c85sm5934929b3a.67.2026.01.26.19.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 19:34:05 -0800 (PST)
From: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath12k: clear stale link mapping of ahvif->links_map
Date: Tue, 27 Jan 2026 09:04:00 +0530
Message-Id: <20260127033400.1721220-1-aaradhana.sahu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDAyNyBTYWx0ZWRfX4Fc5cIKaUjlS
 Ye8rL8KkdSKRngowGOInedfnZ9jABwaXI0JN0h9KH5nEDog0cyZ+u+usQQo0kwyQao2tu2ZWRzV
 7sr/NwmiQKIbj2mQytk0U0awij81PYn2H20F+29LL1BN/O7qQbOhLoJbc3wWIT+k2ozhOSBayhh
 w14RkQsZV1l7yKpUcweyVzBr7lDPVchE/19cGEw+s/duwLuG9BZM5DSHuZjqbJULExBOo8BRXTi
 sPDg5JEVOnnD76Y9tydxb8sUOPoOpBUd/RRRpVjFO7gHo7Ljs41XRb98OBHXWqJwMcpGAW59KgY
 A0uq5xSB2IFMrXHO/Ukp2LUyCrciACWZ/M73EGQXrl7uGErFrcczpXd6lhrYrFqNqff46DqFmm7
 k42X8FTMosFfQWL6UZ6Pk2270mAOpYFOkqCPtUOP2zW2dRFox+BaUFQjHQabNUHC05ijlFzdUGW
 +KyT52f70MR3qE8t6vw==
X-Proofpoint-ORIG-GUID: RcDMxli92AcrH_KrMbgHiox7yYnMyRO6
X-Proofpoint-GUID: RcDMxli92AcrH_KrMbgHiox7yYnMyRO6
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6978322e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=eHKh3QcvEQMPWO9sNqkA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-27_01,2026-01-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270027
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31197-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[aaradhana.sahu@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 526E88F999
X-Rspamd-Action: no action

When an arvif is initialized in non-AP STA mode but MLO connection
preparation fails before the arvif is created
(arvif->is_created remains false), the error path attempts to delete all
links. However, link deletion only executes when arvif->is_created is true.
As a result, ahvif retains a stale entry of arvif that is initialized but
not created.

When a new arvif is initialized with the same link id, this stale mapping
triggers the following WARN_ON.

WARNING: drivers/net/wireless/ath/ath12k/mac.c:4271 at ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k], CPU#3: wpa_supplicant/275

Call trace:
 ath12k_mac_op_change_vif_links+0x140/0x180 [ath12k] (P)
 drv_change_vif_links+0xbc/0x1a4 [mac80211]
 ieee80211_vif_update_links+0x54c/0x6a0 [mac80211]
 ieee80211_vif_set_links+0x40/0x70 [mac80211]
 ieee80211_prep_connection+0x84/0x450 [mac80211]
 ieee80211_mgd_auth+0x200/0x480 [mac80211]
 ieee80211_auth+0x14/0x20 [mac80211]
 cfg80211_mlme_auth+0x90/0xf0 [cfg80211]
 nl80211_authenticate+0x32c/0x380 [cfg80211]
 genl_family_rcv_msg_doit+0xc8/0x134

Fix this issue by unassigning the link vif and clearing ahvif->links_map
if arvif is only initialized but not created.

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.5-01651-QCAHKSWPL_SILICONZ-1

Fixes: 81e4be30544e ("wifi: ath12k: handle link removal in change_vif_links()")
Signed-off-by: Aaradhana Sahu <aaradhana.sahu@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index cdb72439dcf4..9a926f5b7e8a 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -4281,8 +4281,10 @@ ath12k_mac_op_change_vif_links(struct ieee80211_hw *hw,
 		if (WARN_ON(!arvif))
 			return -EINVAL;
 
-		if (!arvif->is_created)
+		if (!arvif->is_created) {
+			ath12k_mac_unassign_link_vif(arvif);
 			continue;
+		}
 
 		if (WARN_ON(!arvif->ar))
 			return -EINVAL;

base-commit: 13f9e5344a517048f3d8c61e49a9a72f97410de3
-- 
2.34.1


