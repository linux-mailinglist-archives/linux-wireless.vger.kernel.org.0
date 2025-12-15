Return-Path: <linux-wireless+bounces-29759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA0ECBE99D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B68FB3079243
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Dec 2025 15:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5503730BBB3;
	Mon, 15 Dec 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GLk1U8Cd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="daWlrqK0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98A30EF7F
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765811510; cv=none; b=ltuncI2nC8Gnl8jOzWQsngQMwrudbhD0HSUtvFeVtV9BglA89bX5fHdax/r7rQvKAcOQ7+2VmzLQDTzz8KduU8hAjqk8GSALd8N4rLd4NcHx+/rKr30U0UaF9zk1wAe0xLYz9C1lx2LObqXYxNbzwE8jYGQiho1LHHL190oiyIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765811510; c=relaxed/simple;
	bh=nFswQCCXv6LBLb4DJ/i7f/SyWwcSSCKCe+7oLtWL8GM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCOTnmKPTDaMl3rPEnbhSYAwLgR1Sn4EqSgXK0ELtcjegx401neIljEMCFZ8YWrRU5XAbnnYWfS/u95ByaZgcv7XyEQootIkMudKjOm8HwK1n0g6/BZZyDkg7xeew4/k4y/Fq6FjjWOANG8a2KuXqF9YmLz2RqMkZtdNYDitGYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GLk1U8Cd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=daWlrqK0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BFANrP7985021
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 15:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=eUbWHFvU7FR/0Fy1jqHfKqKPbImUVZ4OGOn
	1w6YbVxY=; b=GLk1U8CdivxkGgwfiF6TdamdBd5Jb+HRTZR+R/zE/r64pZDpLYP
	WHUdAHn+lOoy1tpPG6YAkqaik/dKRDg5a3d5rgY9C6KJXtt/D4JaLVcJloJRrFqm
	qweacOtkVydxklD2pP1MeQXHj0C6LKmOStjnF2gdBrGZ9BIIgUTH63zQB6uAqYgb
	db+A1ERCl/xHFIq8IiXriEwPAILHiwRqYmOtdQhfBOuJzaIF/rK06MHBelRVU1HF
	9n2W2nmVPYqy5SZp5bXmIJRU/WpJqEYgpG6sZmF8kB/4S8+XE85Q23p9QXPFQFc1
	8MLM5FafRJG3w/HYA5eb212rm6GrR2qyTjw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4b11a7vyye-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 15:11:46 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-5dfaa434109so5841082137.0
        for <linux-wireless@vger.kernel.org>; Mon, 15 Dec 2025 07:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1765811506; x=1766416306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUbWHFvU7FR/0Fy1jqHfKqKPbImUVZ4OGOn1w6YbVxY=;
        b=daWlrqK0KiJbmX4c4GVdIetkhmWv3nltjm6YcGMqtyXWy+41XkijanHPQZwLjQXeuC
         HTAlaTHsQlkwYDGwXWwUyVjddIBSSUyQC0zB3ajrFTVwNjjUPaNU28YcBaxTVRehYIYI
         qjhwqQzWf+pqY3gAl/TW4QcFZN7AysOg9vVJdbc6LZbXl2EJYRlOk4k3nEH3pxQm+2kh
         PgngUFqavLk0r4XkHUc2Nz3hUf/gaIStNgzS8REvWfZLuQ1oT/DOwt01V+rnc64sVuln
         0N/bp6fOKI2DhZRsEP8jznp8QBVQgKStsEj5pOEpIN9du1l6TbMz04zx0+jv80/eJQum
         m1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765811506; x=1766416306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUbWHFvU7FR/0Fy1jqHfKqKPbImUVZ4OGOn1w6YbVxY=;
        b=kAOG5urGJJfoQWW055gHTBHUbNCmms1nkzqjGSwF8l8gEMJYbCmpQG1SSxZka1KQYR
         sTtDFQtSuWkGo9Tq3ekomkvn5c+5G0gbt+eWgYqUsQ81HEXfaLEGasGwMc2FQEw0kFJu
         l/rApSJqVPh7QkazmqvnC3vlEmDo4UCwDL1Vq6HcZ6viHcReD0WALQqMFrd8aZjYG1/B
         Rz0x3xHV4CW+y9HQSBFNVitsYZVB50dAUbjJv9BGH05TgPNS4fZUImeURpsulPkn6sLA
         JJXXke178s30vnZqF1CAKMAUzFp1/h8xidppQCahpB/bUG80IBRW9rXxK9gvP9d243Fv
         IplQ==
X-Gm-Message-State: AOJu0Ywu6JHk537uaxtwwC3xmXpcgKqNpLApdS0SxXeoN+Byg0570NDc
	WKdb/Mjwdb+E3Rid/R7Tpxs+IKQTiFwYOo8ff6G6YXlFh40uApt424qcwTePQZiGeZ7WClMemHn
	spBAihMPDQcsddGlGLUqXA9dfN9RnI01A8+7b8A27bDlwYIOtdAVSjbS0XjVfh8+dblIxlg==
X-Gm-Gg: AY/fxX7eNLYGfh0Py7f2iVJbrese97i2SJnTsMSvm8VgFCN1oR+M7793hr1V3YSMY0U
	cGVXSKNPNj2hJkL10J/kP5reOcxLtaCPwnukHZwq/s3av/EwIXL2akPOXFk5+3PtbfGSCRHmk8P
	t2MKIh64SQpa3axpjplgBLnr5WWMxBXOZdUvH8UNcLOMjdWXHvz7N+kTlbME0hc6ATYUIzaMQml
	2jlgtUZWKYLf3Jn3iIwsGXmZXAwJpfNC/ZS02pkrhOyLffeUmYd+OwSYbwZ19/0NcBn5JOL4ZE8
	jxgJS5Uxcii4Hqcr/6tqIP/3WItRQd2yjKsYUQlucjqfU+xulPiJ2vZ3AJwn9NDmHmdXjPcU4w9
	V1GwZgiz37tUAesyNBgw1MfHBRAKydcPmwuQw
X-Received: by 2002:a05:6102:f0d:b0:5db:f897:59f0 with SMTP id ada2fe7eead31-5e8116f5526mr5136263137.11.1765811505637;
        Mon, 15 Dec 2025 07:11:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfQPzRMDy79X95Om0UjDNXy36Aq/16ODIbLX0C1hqSYuFRkR6HPNM1Z1sdLtSRg5l+AtIn+w==
X-Received: by 2002:a05:6102:f0d:b0:5db:f897:59f0 with SMTP id ada2fe7eead31-5e8116f5526mr5136225137.11.1765811505176;
        Mon, 15 Dec 2025 07:11:45 -0800 (PST)
Received: from jouni.oss.qualcomm.com ([83.245.230.71])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-598f3194dcesm5543209e87.79.2025.12.15.07.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 07:11:44 -0800 (PST)
From: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mac80211: Discard Beacon frames to non-broadcast address
Date: Mon, 15 Dec 2025 17:11:34 +0200
Message-ID: <20251215151134.104501-1-jouni.malinen@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDEzMiBTYWx0ZWRfX5V8Fr6RotSCp
 NJTYTHTbSs/rh8dCo78i+prbKeNSJTNvNk8MY1BIJBVSvyT8bA7O+MChOfWbtuIZLGZPXSNaTu/
 dwsjCdx1Q6wvUfbU0SPes0GC8AhP6RC13ZOkhtSREYB92g1y87A/Z08CfDYinHixUoSUfVltv0+
 5ezS0rBCIPxF8TWoihpq9Nz+m8RV4Sim4EAqdcSzdoB1s1ePh412LfO9/T1HNzhtFaLpexqtgnt
 r72zqgelIaF/8HLaThjx0rZZkx30695COMbhkAqGi00piNYQUYxPokxYUde6WOt6NBhDdCTMJ9B
 dLFCi5Y8HK4ueIG7m7i8bJbnvETYe2Ob79h02yG/p1UMBCQWD25MWbcIY2WGzwj00cvCilefBmj
 YaV91Xd1kZ2ci2WJBqVzfvPACn6Nhw==
X-Proofpoint-ORIG-GUID: 9g5xkUpQEhnQXfTF6hgaSgToXImLtLpF
X-Proofpoint-GUID: 9g5xkUpQEhnQXfTF6hgaSgToXImLtLpF
X-Authority-Analysis: v=2.4 cv=aOf9aL9m c=1 sm=1 tr=0 ts=69402532 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=X4Mu7yV/aqFzOGIJAjKMGg==:17
 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=OxrFBiIj5yLKQ55hnisA:9 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-15_03,2025-12-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1011 phishscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512150132

Beacon frames are required to be sent to the broadcast address, see IEEE
Std 802.11-2020, 11.1.3.1 ("The Address 1 field of the Beacon .. frame
shall be set to the broadcast address"). A unicast Beacon frame might be
used as a targeted attack to get one of the associated STAs to do
something (e.g., using CSA to move it to another channel). As such, it
is better have strict filtering for this on the received side and
discard all Beacon frames that are sent to an unexpected address.

This is even more important for cases where beacon protection is used.
The current implementation in mac80211 is correctly discarding unicast
Beacon frames if the Protected Frame bit in the Frame Control field is
set to 0. However, if that bit is set to 1, the logic used for checking
for configured BIGTK(s) does not actually work. If the driver does not
have logic for dropping unicast Beacon frames with Protected Frame bit
1, these frames would be accepted in mac80211 processing as valid Beacon
frames even though they are not protected. This would allow beacon
protection to be bypassed. While the logic for checking beacon
protection could be extended to cover this corner case, a more generic
check for discard all Beacon frames based on A1=unicast address covers
this without needing additional changes.

Address all these issues by dropping received Beacon frames if they are
sent to a non-broadcast address.

Signed-off-by: Jouni Malinen <jouni.malinen@oss.qualcomm.com>
---
 net/mac80211/rx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 6a1899512d07..e0ccd9749853 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3511,6 +3511,11 @@ ieee80211_rx_h_mgmt_check(struct ieee80211_rx_data *rx)
 	    rx->skb->len < IEEE80211_MIN_ACTION_SIZE)
 		return RX_DROP_U_RUNT_ACTION;
 
+	/* Drop non-broadcast Beacon frames */
+	if (ieee80211_is_beacon(mgmt->frame_control) &&
+	    !is_broadcast_ether_addr(mgmt->da))
+		return RX_DROP;
+
 	if (rx->sdata->vif.type == NL80211_IFTYPE_AP &&
 	    ieee80211_is_beacon(mgmt->frame_control) &&
 	    !(rx->flags & IEEE80211_RX_BEACON_REPORTED)) {
-- 
2.43.0


