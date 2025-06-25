Return-Path: <linux-wireless+bounces-24482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1FCAE8387
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 15:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142271887394
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Jun 2025 13:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB5225F998;
	Wed, 25 Jun 2025 13:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a28DAEAK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF627713
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 13:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750856486; cv=none; b=YfMPt5rgLmRgLXvJHFpUIhY8NWygPrjuahHhS5SSpB7ANYUHi6U4x9icYQnhQxSXAy2rKPGvHsLBTbaWhNjJeKWHYRg/4pv6g/f8A1qwQuAMw07Ps1HvtkTBaPozrWwM4SCyThT9h6N5YDwMm9s5qIpRCSej3kqViCxjFZ/NdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750856486; c=relaxed/simple;
	bh=PZJSsD/pDq06z3wAaRS8IT1Y3CKfoyhoE0l7xeGR9/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZcxWQ+8xTLLp5FfasBW0slH3iQz3T81sRiH8Uv36ug2o750MX/vsWKymvRSOpCcitsLh9YPVYgdAyxvamIqVXLbDltg/whouHZ+nHi9DqGckj+YL9QO/nEUfm4phL/7t+CsM5nqNPyvE+I4YDe3qZd8ocnWQWKoAMxeGy3QqSSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a28DAEAK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAH8g3001108
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 13:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZtJ0xS+J0+LlYMK62oSQSc
	AP/5HSBxdnyXR6EOPjrMc=; b=a28DAEAKGuP+yTCMWnK5d8izBqbQIKK7IXkWHS
	nT2ataklJs5zGwbTljNK15/ug81hpWQg7WC2TQd0dcBmYc7qtfvPdpMoQljWH3t5
	8+hwxhOM2x8IUGm7+MsKZvoU55Opq31Ys3niI/BUWGqzhqJQhLll/aAh5BKAuK3z
	mw+U+5mhZwlhLdmD9J6GkbQouvXfzOXCTmz2fEd0zm/CBn7j9cRJR1lfXBm9VCJh
	HDzcrM6rvDxq5q98VOBER9BgHU09WKVd/kw+Vr37wt2eXWzUPXZ9HC+GB5Km9HMt
	y4HZ94l/uKoEAkVOlC5EaLAR4HV2yPjmMnDo5Pnn95Q0B5eQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47fbm1xgpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 13:01:23 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-31215090074so8983109a91.0
        for <linux-wireless@vger.kernel.org>; Wed, 25 Jun 2025 06:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750856482; x=1751461282;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtJ0xS+J0+LlYMK62oSQScAP/5HSBxdnyXR6EOPjrMc=;
        b=pQ4wciU9JBx93rn1BRaDjHJbwIAJntc826o/WnE0NgMKqLEZGVUHXizwzTDFwdPpM7
         65c0JN1hOO4sJAnMWzZC8jLdW8vhewen0S8Lk38u1eh4VAjL0K8ZiJ6vrHVLUcVTSz6d
         BhsgejHvg0I7kjC2KyLu7KQFO5YdY2pObaHHxLsklhRc+rT/lTM6+ycJMTsVRVOOYRFR
         4eNVIHbB0k+uqQkaiyLEMCKjBvUObIR0uoNMFUorLgwA0Y6kApOxFUZoToCclVWRMfuV
         K250nXg16OWliGh0S5xoGeR5S9Jf5fA5wpvn4RF9picbtPa0xfP8pinTte91gBYoGSvz
         nlgw==
X-Forwarded-Encrypted: i=1; AJvYcCWOgo48DusfUAVSxMjAqggEfqlf4KCJXCmIDtX+j/n1jisXTK5siZzNLpK+VeTIqod1gVlHO77uSOkfCVXQbw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzNG/OM1AW8DeJg14aEYowudaMMEYq+DxCGLBk0srkJzPCHP4UT
	QVRCrwKrcLVO4oWw3t299E1ryeicO2A1ibbzNUbrvIkDoEe//MfyrzNeA970VexS1vjtVJKDAgM
	45SVqkqDDhVlo/KWdtMmakCuw5HsM57ZwuYTaYzzlJIDbv6EIhIOwmWsqJlPX0OLF/DpVPQ==
X-Gm-Gg: ASbGncswHpcm4jL6Vm9EGW7pAkXKklzSv0R8d22walpK6N0iO7uwFqEFoDVRqpt+gAW
	pf7h89m8OLhzzUveYeHKT5mj8NHCXzjySjajOUg1cyktHG/nQsVArvFPunb/ncLUevGdnXSNOK7
	RGvdKYO6OemsKLWlCj316NtoKm133ynFd7WrSnj2o/dSlj/6zZok4LR499E2JQrkwMCun1TSnSP
	IVHByALGvJhMx/kvzVw93TqWToRB0YfOC7b/YbvK68T11lgUVB2EUwYdOl3/7I23OlwrIwCJkFb
	9DhYQ4Eb6hLDfFt4ZUehKNetESvrSZO29IrRQXU4lZBurszQop2qFfqUwLbVZ70DWxuJbUM9q2V
	DfTucBWc+RPnpqmfTvcw/O4YqJ8IVYDOLQmd4q1I1rjZTAJ4=
X-Received: by 2002:a17:90b:2550:b0:313:28f1:fc33 with SMTP id 98e67ed59e1d1-315f2623c4bmr4903388a91.10.1750856482146;
        Wed, 25 Jun 2025 06:01:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiDa6U6OtxIRJ18P8EzRSmgiKQlZTN3JnTutGv8iOGf++pYBG3vzNIdSTgsW9lbB9Df8KxbA==
X-Received: by 2002:a17:90b:2550:b0:313:28f1:fc33 with SMTP id 98e67ed59e1d1-315f2623c4bmr4903316a91.10.1750856481522;
        Wed, 25 Jun 2025 06:01:21 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8753900sm132179335ad.253.2025.06.25.06.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 06:01:21 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Wed, 25 Jun 2025 18:31:10 +0530
Subject: [PATCH wireless-next v3] wifi: mac80211: consider links for
 validating SCAN_FLAG_AP in scan request during MLO
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-fix_scan_ap_flag_requirement_during_mlo-v3-1-dca408b10ba4@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABXzW2gC/5WPS47CMBBEr4K8xsgfnA8r7oGQ5TjtYCmxwZ0ER
 ih3HxONNIuZBWxaKnXXq+onQUgekBw2T5Jg9uhjyEJuN8ReTOiA+jZrIphQTImSOv/QaE3Q5qp
 dbzqd4Db5BAOEUbdT8qHTQx9pWzcWeFOp2nCSadcE2bomncg9G3pApAEeIznn9cXjGNPX2mPm6
 9HHkTOnnBb7gsmqBukadYyIu9tkehuHYZfHq8gPtvoMK5WxDKQRrmz+Yl8fzOK3dSH27+NFxtu
 KFWXLALhj/+CXZfkGwgtcI6oBAAA=
X-Change-ID: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=YYu95xRf c=1 sm=1 tr=0 ts=685bf323 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Zr3TjlwJAZfEZ8iIeDYA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: q8HAN5XSm0tatR_0CKvYqLpRvOWhAbhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA5NSBTYWx0ZWRfX+pMK9ZauK1TQ
 phl2W/s7rOtK18qwvsXHRYYp37nStIwTJBpuxBrb1YizxX9DbSDjHLxT8TInhp6YkwWFtPiNJth
 w5cgyNLCKbZ/chyS9JF/3aZphv6aE9xqUSUV97q6Oa66HWgKUXp1as64QXShKFuWl9wakAKKe3O
 OZWhOz3fwJSxvlj0Q1r2fc/LV/KvbWTv5n3h+D+P8orF36sN81DNcGG1TF0fE7luRsyzQWyhujc
 FeLu0T+c2KcdQacJib0kYZnziQzuqOOKhIFL4ipBFyJsuEqIyjcYnseyW3VNppNqteBNZPwdBXm
 lIIhi6HvlXjKR/zI6K0/vG5t1BQ3VT+9LNCanwcLlpOMW4HHkVxjfe63F6+HMmaBk2StG3NHKwn
 dMzjmHI9LrlgRxBXd/s5Tec/pJRsq/dkBbc70vvdIm/NuUY405z/Lwcx2NIoZ2t0EJXty6rZ
X-Proofpoint-ORIG-GUID: q8HAN5XSm0tatR_0CKvYqLpRvOWhAbhW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506250095

Commit 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request
during MLO") introduced a check that rejects scan requests if any link is
already beaconing. This works fine when all links share the same radio, but
breaks down in multi-radio setups.

Consider a scenario where a 2.4 GHz link is beaconing and a scan is
requested on a 5 GHz link, each backed by a different physical radio. The
current logic still blocks the scan, even though it should be allowed. As a
result, interface bring-up fails unnecessarily in valid configurations.

Fix this by checking whether the scan is being requested on the same
underlying radio as the beaconing link. Only reject the scan if it targets
a link that is already beaconing and the SCAN_FLAG_AP is not set. This
ensures correct behavior in multi-radio environments and avoids false
rejections.

Fixes: 78a7a126dc5b ("wifi: mac80211: validate SCAN_FLAG_AP in scan request during MLO")
Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
Changes in v3:
- Rebased on ToT.
- Fixed hwsim warning issues. 
- Link to v2: https://lore.kernel.org/r/20250624-fix_scan_ap_flag_requirement_during_mlo-v2-1-c8067d0ee1f0@oss.qualcomm.com

Changes in v2:
- Rebased on ToT after dependent changes got merged.
- Link to v1: https://lore.kernel.org/r/20250528-fix_scan_ap_flag_requirement_during_mlo-v1-1-35ac0e3a2f7b@oss.qualcomm.com
---
 net/mac80211/cfg.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 56540c3701ed786c37f946f9c4af820c15b5922d..290ae4ef02f5097a7efb7e4b9d3f846fc672679b 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2919,6 +2919,10 @@ static int ieee80211_scan(struct wiphy *wiphy,
 			  struct cfg80211_scan_request *req)
 {
 	struct ieee80211_sub_if_data *sdata;
+	struct ieee80211_link_data *link;
+	struct ieee80211_channel *chan;
+	int radio_idx;
+	u8 link_id;
 
 	sdata = IEEE80211_WDEV_TO_SUB_IF(req->wdev);
 
@@ -2946,10 +2950,39 @@ static int ieee80211_scan(struct wiphy *wiphy,
 		 * the frames sent while scanning on other channel will be
 		 * lost)
 		 */
-		if (ieee80211_num_beaconing_links(sdata) &&
-		    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
-		     !(req->flags & NL80211_SCAN_FLAG_AP)))
-			return -EOPNOTSUPP;
+		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+		     link_id++) {
+			link = sdata_dereference(sdata->link[link_id], sdata);
+			if (!link)
+				continue;
+
+			/* if the link is not beaconing, ignore it */
+			if (!sdata_dereference(link->u.ap.beacon, sdata))
+				continue;
+
+			/* If we are here then at least one of the link is
+			 * beaconing and since radio level information is
+			 * not present or single underlying radio is present,
+			 * no point in checking further and hence return if
+			 * flag requirements are not met.
+			 */
+			if (wiphy->n_radio < 2) {
+				if (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
+				    !(req->flags & NL80211_SCAN_FLAG_AP))
+					return -EOPNOTSUPP;
+
+				continue;
+			}
+
+			chan = link->conf->chanreq.oper.chan;
+			radio_idx = cfg80211_get_radio_idx_by_chan(wiphy, chan);
+
+			if (ieee80211_is_radio_idx_in_scan_req(wiphy, req,
+							       radio_idx) &&
+			    (!(wiphy->features & NL80211_FEATURE_AP_SCAN) ||
+			     !(req->flags & NL80211_SCAN_FLAG_AP)))
+				return -EOPNOTSUPP;
+		}
 		break;
 	case NL80211_IFTYPE_NAN:
 	default:

---
base-commit: 7322a7d80c48f81888414f347e88ebd4e49f7f56
change-id: 20250527-fix_scan_ap_flag_requirement_during_mlo-d9bce1b859a1


