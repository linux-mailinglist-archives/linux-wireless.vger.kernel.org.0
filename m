Return-Path: <linux-wireless+bounces-18399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F0A26DA4
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82361885CF2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16C207640;
	Tue,  4 Feb 2025 08:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U31y1WVP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD0D206F18
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738659048; cv=none; b=owRh+ecymFMN1fY0FMo7Q/a6cAMcilPsDe3VZDcvJkT0m/15t0Rkpr1sSJIruKu1yvvBBxFj44AF+GTXMqqRgCyIqna9rap1WoPfTa1PaY8mFcwJh4eRvQJ8IPpJD4Sp9VThImdUL8Dl0BZGo16wn4gRWZmBqjlQ3/C+CsCJB5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738659048; c=relaxed/simple;
	bh=MkmpPn5yOdE99glzRdB6yL/Vht9lGTPzkEMEYBeuzz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JWzImPiJfvCdOcQupKu7QCndG/FJd3MAMZMLCWgTK3wxhEAkh6d2xxcVOpqs/haYnBUFc99xOjDyYSMXr4SJKmmDtZfU17kxsuQ+bRWHen0XjEryY8NZNUE2CGQLFSiDIW0xDlco+BPME36QjUZR6l5s6XdWZJvuvRX0dduVJrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U31y1WVP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5145e1bC009607;
	Tue, 4 Feb 2025 08:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pUUY+wW/9fhavdRYn4+bznjZo7PC/uIFmyw+KabJO2o=; b=U31y1WVPOm4iOHb4
	5uAgw25F9iOMvjipCJQhKBwjuuXoRww0AyfdBGxIXzkH9r/P1J3mJDOJGV1Tvzg9
	M+mCIVDEm6wGNfC28UXIsbw7GjAYRXcHDz8JhQ3r7G3c1pS/TeON5TJe8RT9TjNA
	MGIpnDFaHrHd9x0orWgOiXAHaEb3CKxS7fHpcIqe5ZpXxmLGVtWUSI2MJHcZ4kBL
	ShPAaFtO92QgPsYI4O5L3fnvK/WSf212yNHaeGhTFsjJsgc4ztGTHDrSrEYghcOM
	4oxXbD5DpHHL4hTw2Q9vvCaUz4obnNCVwdb7q114/hQFVHqmTmyB7gRxIqilTK/k
	htGc4Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44kcxm8c9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 08:50:41 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5148oeQq027962
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 4 Feb 2025 08:50:40 GMT
Received: from hu-rdevanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 4 Feb 2025 00:50:38 -0800
From: Roopni Devanathan <quic_rdevanat@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Roopni Devanathan
	<quic_rdevanat@quicinc.com>
Subject: [PATCH 1/2] iw: Add support to set per-radio RTS threshold in multi-radio wiphy
Date: Tue, 4 Feb 2025 14:19:59 +0530
Message-ID: <20250204085000.3809769-2-quic_rdevanat@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
References: <20250204085000.3809769-1-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: flvoQQ4l8YHtoxMaJ_AxvkM71mrY43Wr
X-Proofpoint-ORIG-GUID: flvoQQ4l8YHtoxMaJ_AxvkM71mrY43Wr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_04,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040071

Currently, setting RTS threshold changes the threshold for all radios
in a wiphy. But different radios in a wiphy can have different RTS
threshold requirements. Add a new iw command to handle this. This will
ensure that the legacy userspace will interact with traditional drivers
as well as multi-radio wiphy drivers.

In order to be able to set RTS threshold for a particular radio from
user space, without disturbing the other radios in a wiphy, pass the
radio id for which RTS threshold needs to be changed and its
corresponding RTS threshold value. The valid radio id values can be
checked in iw phy#XXX info, under "Supported wiphy radios". If the radio
index is not provided, the current behavior of setting passed RTS
threshold to all radios will be retained.

Command Usage:
iw phyXXX [radio_id <radio index>] rts <RTS Threshold value>

Sample output:
root@buildroot:~# iw phyXXX info
Wiphy phy0
        wiphy index: 0
        max # scan SSIDs: 16
        max scan IEs length: 339 bytes
        max # sched scan SSIDs: 0
        max # match sets: 0
        RTS threshold: 536
        Retry short limit: 7
        Retry long limit: 4
	.....
	Supported wiphy radios:
                * Idx 0:
                        RTS Threshold: 536
                        Frequency Range: 5170 MHz - 5835 MHz
			.....

                * Idx 1:
                        RTS Threshold: 231
                        Frequency Range: 2312 MHz - 2732 MHz
			.....

                * Idx 2:
                        RTS Threshold: 425
                        Frequency Range: 5945 MHz - 7125 MHz
			.....

	Globally valid interface combinations:
		.....

Signed-off-by: Roopni Devanathan <quic_rdevanat@quicinc.com>
---
 info.c |  4 ++++
 phy.c  | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/info.c b/info.c
index 986eaa6..cde3d80 100644
--- a/info.c
+++ b/info.c
@@ -905,6 +905,10 @@ next:
 				case NL80211_WIPHY_RADIO_ATTR_INDEX:
 					printf("\t\t* Idx %u:\n", nla_get_u32(radio_prop));
 					break;
+				case NL80211_WIPHY_RADIO_ATTR_RTS_THRESHOLD:
+					printf("\t\t\tRTS Threshold: %d\n",
+					       nla_get_u32(radio_prop));
+					break;
 				case NL80211_WIPHY_RADIO_ATTR_FREQ_RANGE:
 					printf("\t\t\tFrequency Range: ");
 
diff --git a/phy.c b/phy.c
index 584b103..890966d 100644
--- a/phy.c
+++ b/phy.c
@@ -475,6 +475,47 @@ COMMAND(set, rts, "<rts threshold|off>",
 	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_rts,
 	"Set rts threshold.");
 
+static int handle_wiphy_params(struct nl80211_state *state,
+			       struct nl_msg *msg,
+			       int argc, char **argv,
+			       enum id_input id)
+{
+	unsigned int rts = -1, radio_idx = NL80211_WIPHY_RADIO_ID_MAX;
+	int argidx = 0;
+	char *end;
+
+	if (argc < 2)
+		return 1;
+
+	if (!strcmp("radio", argv[argidx])) {
+		radio_idx = strtoul(argv[argidx + 1], &end, 10);
+		if (*end != '\0')
+			return 1;
+
+		argidx = argidx + 2;
+	}
+
+	NLA_PUT_U8(msg, NL80211_ATTR_WIPHY_RADIO_INDEX, radio_idx);
+
+	if (!strcmp("rts", argv[argidx]) && (strcmp("off", argv[argidx + 1])))
+		rts = strtoul(argv[argidx + 1], &end, 10);
+	else
+		rts = -1;
+
+	if (*end != '\0')
+		return 1;
+
+	NLA_PUT_U32(msg, NL80211_ATTR_WIPHY_RTS_THRESHOLD, rts);
+
+	return 0;
+nla_put_failure:
+	return 1;
+}
+
+COMMAND(set, wiphy, "[radio <idx>] rts <rts_threshold value>",
+	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_wiphy_params,
+	"Set per-radio wiphy parameters");
+
 static int handle_retry(struct nl80211_state *state,
 			struct nl_msg *msg,
 			int argc, char **argv, enum id_input id)
-- 
2.34.1


