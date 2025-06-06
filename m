Return-Path: <linux-wireless+bounces-23805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EB0AD00A5
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 12:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5FF1891748
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Jun 2025 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51BF214209;
	Fri,  6 Jun 2025 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Cg4BIity"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDA28750C
	for <linux-wireless@vger.kernel.org>; Fri,  6 Jun 2025 10:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749206752; cv=none; b=pKIkdYbfAXHwMqp7a9R2gL+AYI6CA3wxyEk1XgOLOjl8HOzl6MaMlVoJkU3szUCaMDEhQS5f8gTqCRqdNWSBNHPiFc4DHskp4VtR5f6nQ0Fcb42Z7lGRheg57+KTtZ8MNw3W7y0BINA5piLW3H6BKm8etZTlW/h2+ujfTFX6E1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749206752; c=relaxed/simple;
	bh=Z3EkmEbQQd+DR8U7MgQkqaVCo7nBJG8lzMdS5q21sOQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ArKSB6i+4yOFsoyiGYQD5cJOLH2iQL27VNQd6LQrqySS8k6xsMkcI/ffuZN/zr33jMk9tz6Pv2N4EISwztYrSwaTVLkMpV/f/4gMB9IBNhmbSoKBUm6lTsYBk6XwkuUadZ0UjoypIUkhvqjng5cH6JSvV+cih8m3m+KfgPj0ETg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Cg4BIity; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5566FIP3005224
	for <linux-wireless@vger.kernel.org>; Fri, 6 Jun 2025 10:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RiBYZRux2krim4omi6G8gnoAS9aRSpEXR13
	/fn2V0+w=; b=Cg4BIityI06+m1MnvXHuq1rdW9yBei+hqUQlVx6TjYr3wLbhz5S
	Vv1os6b1ZLcatPu+jfXNztZ4LHnYA8I/IbCZjBn0H8R9Q8Ipcm7fyOeKQdh5BweM
	HUnZ5mHqYGYZRd60rTC/+kEQDw08ubTxld4qm3hnwgs2Qju6CdKNlozJAHxC5Ag6
	Hz/KF0pX9gk+zxDa82vFMWLT8WLer2cTGQNqYCpFEofhahomAnFBGJheEcS47da3
	S4hrbvC+prNBnD4m9Y7jMlmMjsiaKUJN5R+vWEpz+UKVoNb+fbE0NDxdFt4Fvmzj
	WdriVy6UQxMqID8xysKvMfGI4AwedyxeZNw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4737me3sws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 10:45:49 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235f6b829cfso12582585ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 06 Jun 2025 03:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749206748; x=1749811548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RiBYZRux2krim4omi6G8gnoAS9aRSpEXR13/fn2V0+w=;
        b=sbFtblAs6TjXjjYwAOu9itxxB5RIexb8aS5csTCVFuUBTRmLcpLCc2Xzr97BvbUGRZ
         cx/htrj285HMejIEM7JAnB0Dnett7Sqaat8XRiJeSK1IGEuCVfYjAkyMN6iWMWJ4Hrzh
         ejlRK+/CE65gG/tAsNlaSvWvWdhWs+UrNP8v2aIF+qwFbDYFWZfLaUj7wVXV/4/GauVu
         oP+EKfMH+TjLYqH2n0sg1Z78VAn5zsxWwoQr9gT6znZZB6IRdQ7o6Ah+SWcJmP6nW0Jg
         l0iJlumUUmZQiOV33ag7MV/rUftRWSZ/F6L/rp4w8UxnKQ7lLj0nOaRDkRqtxeIXj9rR
         VP3w==
X-Gm-Message-State: AOJu0YxLZ8Ex4UU72PAVBQEJj9YIdeMChi3jNoFxJgncK6JHRqTHQOww
	rU+2HLOaLyAHmrVgMyC9qxN4xWRzEvomXoUqFWK7S5x90NvQ83HXxxLTVSQngAOkHdaT5aFlH3o
	az6baX3UDVZoJBm13ZZZ/04pxjMDjrRKdVYXJW0HnC1K+3lpXzIHUl3buay0wuU6IvoEbYWA9SA
	bn8w==
X-Gm-Gg: ASbGnctwtiAYFQjDstcMiecHq0x6y8up87QIJbS/oSFvm2cIJtL0gZkpO4EUKqIyxi5
	Y23z7GFzr+XG74Q95craDL/eIZ5S6wHKHxfzKyaQ9PVlbwkq1TgU1yWKINKdqW0hkczhODllEm3
	tHxXTAsyolhNlZ4wV4QTY+TO4qfqCCD+59bBUQjclBb15XD9GixHwiq2WzcLZLggwS5uq72KfK2
	oP09TDUF5Jo5UstGUvG4SVJ85DQtzepS/G8q7BdXo2zuSh6MICnD1Y2+NF5Z9U0jPnngHaWMchF
	azZR4tO2N1vqV6NGiKrz0mo+Ec0wWu8vb0SDQPjP+SA0809uSYBxKcAA3pWX5aY0x4nDYYKx9sH
	QZISlbx2Vihy6BJNQmuQNby1fq02yM5+YazuJFIuv
X-Received: by 2002:a17:903:244c:b0:234:986c:66e0 with SMTP id d9443c01a7336-23601cf2f46mr41497605ad.4.1749206747899;
        Fri, 06 Jun 2025 03:45:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPoFHk9tqV1naHY0v4dmHqxCZ3XFh0TpGDeRdlrbzloMQuGEmKOxIgH8RWJo77n9nqRQUKaA==
X-Received: by 2002:a17:903:244c:b0:234:986c:66e0 with SMTP id d9443c01a7336-23601cf2f46mr41497295ad.4.1749206747549;
        Fri, 06 Jun 2025 03:45:47 -0700 (PDT)
Received: from hu-ramess-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2f5f66a88dsm944588a12.40.2025.06.06.03.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 03:45:47 -0700 (PDT)
From: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>,
        Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: Fix 6 GHz Band capabilities element advertisement in lower bands
Date: Fri,  6 Jun 2025 16:14:36 +0530
Message-Id: <20250606104436.326654-1-rameshkumar.sundaram@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: O3T4QjNmzEXTA7rat6I7gr1JJdjyOQxL
X-Authority-Analysis: v=2.4 cv=GPQIEvNK c=1 sm=1 tr=0 ts=6842c6dd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=r8_1njx8xgN6E31q518A:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: O3T4QjNmzEXTA7rat6I7gr1JJdjyOQxL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDA5NiBTYWx0ZWRfX+YJ+9JAgH5Ek
 ZcgOEtaZbHwq3D63+9oHad+36qCdDx6nxbn/n/V/xzS4x3V4D8GypIuZq7xza5bIaIA0b1Q8GwI
 uaOXTA4fgOX9TPUGgNz0r7dpsoOw4U88jf68fnkgk4AC7rJBuXBQrPO5zaPIYWUgFSjspS/kF3W
 Beatjp28yw+siJbLEZzdDRPB33iLCisUVumDeb6hAPOJQUm1iKDLLs2ko/Lzro8IL3KZvUM0/eg
 lyhfccTUZ6bBXtKpr9TNON4u/4eltdPS/X97rU5dO6zP4r1rJXzP5m7NnRrDIzweW7pveB7/eU4
 cIl1y/2w/gfY8fups3AGxjA0G0jXUdPZbXRnoPfv+91GRpBPxoN+UPkhVv+g9YWrs95U/3vhkKE
 KvtqhMBMgt9+Eq85B0IPnBYzMH9Hsc3xITqIO0ZTF1/hYl9KWntbzPTOHCi1+Q6QGCo+17JG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_03,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506060096

From: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>

Currently, when adding the 6 GHz Band Capabilities element, the channel
list of the wiphy is checked to determine if 6 GHz is supported for a given
virtual interface. However, in a multi-radio wiphy (e.g., one that has
both lower bands and 6 GHz combined), the wiphy advertises support for
all bands. As a result, the 6 GHz Band Capabilities element is incorrectly
included in mesh beacon and station's association request frames of
interfaces operating in lower bands, without verifying whether the
interface is actually operating in a 6 GHz channel.

Fix this by verifying if the interface operates on 6 GHz channel
before adding the element. Note that this check cannot be placed
directly in ieee80211_put_he_6ghz_cap() as the same function is used to
add probe request elements while initiating scan in which case the
interface may not be operating in any band's channel.

Signed-off-by: Ramya Gnanasekar <ramya.gnanasekar@oss.qualcomm.com>
Signed-off-by: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>
---
 net/mac80211/mesh.c | 3 +++
 net/mac80211/mlme.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5cc56d578048..d10f9e7f0ea2 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -624,6 +624,9 @@ int mesh_add_he_6ghz_cap_ie(struct ieee80211_sub_if_data *sdata,
 	if (!sband)
 		return -EINVAL;
 
+	if (sband->band != NL80211_BAND_6GHZ)
+		return 0;
+
 	iftd = ieee80211_get_sband_iftype_data(sband,
 					       NL80211_IFTYPE_MESH_POINT);
 	/* The device doesn't support HE in mesh mode or at all */
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index b84150dbfe8c..47b3a559073e 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1802,7 +1802,8 @@ ieee80211_add_link_elems(struct ieee80211_sub_if_data *sdata,
 		ieee80211_put_he_cap(skb, sdata, sband,
 				     &assoc_data->link[link_id].conn);
 		ADD_PRESENT_EXT_ELEM(WLAN_EID_EXT_HE_CAPABILITY);
-		ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
+		if (sband->band == NL80211_BAND_6GHZ)
+			ieee80211_put_he_6ghz_cap(skb, sdata, smps_mode);
 	}
 
 	/*

base-commit: 1b98f357dadd6ea613a435fbaef1a5dd7b35fd21
-- 
2.34.1


