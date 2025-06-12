Return-Path: <linux-wireless+bounces-24071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE50AD6FCB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 14:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D92CE3A302B
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Jun 2025 12:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BBB2F432A;
	Thu, 12 Jun 2025 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UcuBZRx/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF42367B0
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749730300; cv=none; b=YfJBiZiH+9wWlyElaiPuKEEQEzGBvhL/rwbzYJD5YFaSGRqlOBVW5Wmmvb9yIOQ2Buvr/DZuiQxk6LwFCrORUHH3OltxVh/3gYXepFbMukVWK272j9qjywI+tk5YtGLVeFf/RrMS0U2Zbzjb0S/B+SMIiSVAHVld8GBSO0jj5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749730300; c=relaxed/simple;
	bh=/QbNC5oeb4PozRW2qgEaqaQm5eC5ECcXH/Vk+7Prrno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=FSbRso2HDIaPUoEBg827bA1RPwWHlxTE6RM9yjtXjb5o6ERKlrKDw0PMQe2OBUW8lx3mN7uqWZtG4ZfiulauVo8hAykjnjshBwePS6UYD3uVjAYvVJDhxDYuKZ1Jb/aU1oCCEPgESOyvvsIBGw3YeAY2yRnPpgpETOSklMUPUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UcuBZRx/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C96KNv002604
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:in-reply-to:message-id:references:subject:to; s=
	qcppdkim1; bh=yU7oSJGLbh4FW8bBDKQJ7R0JGuTvyQFJtUW2RLYDSCI=; b=Uc
	uBZRx/vcHRjsKhrt8KnNc6N1HU6MUwF6n1+lNlJ/bfB6qY5fXemHtYKPyEQKzk3n
	jxJPxNtHOgm2tasbYIADZux/PxZKhbHDjKDVJH9U4j5q0zRBq7ckWbJg6a7O5KB6
	yPfvTydyNWR1fENnoDFcfRN1F3BIVtbYcdi5CwzV563Qe+LVnyGEF++H1VnHwHPQ
	LY63jT9cMFlZX03/bDwaPFxkf2JizMWeew+hskbA8wQVdYby6/VI/W4AmQSe8sNw
	SjfKD5wFma18/HKmVO74cDHWjaWgvJHkEjAeko5LpgZwUq9/j6OeD2q/9XJ9ivid
	Vlkz84+NZGNmvpTwFqYA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 477jbphxba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 12:11:36 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-74877ac9ca7so902895b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 12 Jun 2025 05:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749730295; x=1750335095;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yU7oSJGLbh4FW8bBDKQJ7R0JGuTvyQFJtUW2RLYDSCI=;
        b=VtLHi97NgySivIeZHOBpcrNtPPnGeYZVdRP5JhTJ5XWUgMUgt/EFbeH1KENDk0Cc0v
         f+CBiUqIHlwWADBoyaFIllDA3kRw9EhLkpP+da1epjD326ogNMyJXXi+TleIa3larVE1
         gv9TAx+VeiCygrQoqjhs88iWmbuZuWflVxBlBPjGqU+8fy2sqzaVgctVmyKhc8dsCEoR
         184fq/J/1Hb4DREbJJ6W82a+izegRRZoWiTpO1jjTsG3EINvAeql+tb4BMY6awKdVVV4
         R30UgtsL4lXYj6afW4zQE1hJ3xX5jkIYaw9GPAgv2kNOpjuXi76Nm4hOHsoNdc7qqkFV
         z9vQ==
X-Gm-Message-State: AOJu0YycZxzDZJUEobM9rmxDDkdIVFqN9YIhxNcJ40BnuSKer7nnv663
	fgXWjJTsysFEM9EEK9Q911+W7lCtiBs+TF7ALwqA2soYIe5hcI8wW6uielKGWfBIHKoEAQVX83j
	00q2a7SQlu5nsEyJ9D7X5BEdDgTwUsW8ln+nKhx79Ce/EnuadZraVLmMDok22lChmG3i+kA==
X-Gm-Gg: ASbGncvVmmij3PHyOg8u9rlOQqMatdoEnwAasfBex+yKFCYOaxyoU5D609iBlvQoUwO
	AZ6O2EEjR2PdTDDJWgzawV7zdJV0N6iQ0UJAdDy4xXbTlC9FREPDJaVSiV+3RSdt5erLs4FEUqr
	MkqGCA5gUTDt8dEBpJO2/25Ku/OCOy60l3hZYL3oXOMcJt1nkfVbAN+wRq1ottyBnA7vIuVCrYB
	nzvrw4NTG6VYizpzP7sc8mlT7PkLMmWl6+Oo0889Cnhyl5sVkETrKq5ZYx4RUqGbuZ5PlQTiVSV
	YnGe/PsdRvc9hscM4wG7zOTzLpJOd4ee5On5GU+v0M9kAsdimteHp7BZFB/TDEQoaNTOQiM0Sc5
	UuF13LrWrKOieyJ53+4a1fCeSEqJJZo/xQ2Yz6wojhznTbjeDIUjuvNbC
X-Received: by 2002:a05:6a21:4006:b0:215:d1dd:df4c with SMTP id adf61e73a8af0-21f9900abcdmr5060924637.6.1749730295557;
        Thu, 12 Jun 2025 05:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZt26IwlLJ/jeX136unBPZvhI/cBP9yckghD2HkZuBIJqgoRjVPIvIXz1/vuHEs257SPO76g==
X-Received: by 2002:a05:6a21:4006:b0:215:d1dd:df4c with SMTP id adf61e73a8af0-21f9900abcdmr5060880637.6.1749730295147;
        Thu, 12 Jun 2025 05:11:35 -0700 (PDT)
Received: from che-siroccolnx03.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fd6376366sm1189405a12.68.2025.06.12.05.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 05:11:34 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 2/2] wifi: mac80211: process group addressed Rx data and mgmt packets on intended interface
Date: Thu, 12 Jun 2025 17:41:27 +0530
Message-Id: <20250612121127.1960948-3-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
References: <20250612121127.1960948-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Proofpoint-GUID: D5GOKh339iy6lk-9kTBmt7kaZeNW_P4B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA5MyBTYWx0ZWRfX3K58kH8U0NTa
 yH6WfRBbcllGyTrEC78Eco6IVNPxN1gfF0naTfaEchyn5MoOxqun8poDEWAH0oIAWbUJCWeu/V8
 C6PNGT0gMlGWeH6I/gjfhaI3j3X25vk0WkPbE6tqt+qHohSOZqH8Nb0dFFWEkbuw41SVmdHTN+Z
 Uu3qoRMVBsCgN/QMxtOaHHMuD3KzhT3ZuQk7ief7MMbmoCvU+3ud44PZnE/QZyC9urj8mj+gETL
 6XSMM27hi1CIZpPRYary2LRlsMjobGzwtLaZlaGQF0EuwAPrl/B1mVUBJnkZVVWMhtm0AI2hFpd
 +BBj0JzUDSoyAVDsmwkhUcMBUA+36uh7wWhM6nDPMx9bXps9eGEiSxKcvlphlvpVbUAJhZ43GUR
 OBYDP+USqm93aLfshJIll1tNDhxbCTYuJch2uDUny1ziGYXJMzmzlkSQJaprnkjtTKonOWMV
X-Proofpoint-ORIG-GUID: D5GOKh339iy6lk-9kTBmt7kaZeNW_P4B
X-Authority-Analysis: v=2.4 cv=OLgn3TaB c=1 sm=1 tr=0 ts=684ac3f8 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=uuzzVUd8oATLJfYfrdoA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_08,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120093
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Currently, in multi-radio devices, group-addressed data and management
frames received on one band are getting processed on an interface running
on a different band. This occurs because these frames do not have the
destination station information, unlike unicast Rx frame processing where
the transmitting station is known.

There is no check to ensure that the sdata is running on the same band as
the frames are received on before processing those frames.

Fix this by checking the operating frequency of the interface against the
frequency of the packets received before forwarding them to the interface
in multi-radio devices.

The current behavior is retained as a fallback mechanism when the frequency
is not reported by the drivers.

Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---
 net/mac80211/rx.c | 50 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 09beb65d6108..b4f715040983 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -5125,6 +5125,32 @@ static bool ieee80211_rx_for_interface(struct ieee80211_rx_data *rx,
 	return ieee80211_prepare_and_rx_handle(rx, skb, consume);
 }
 
+static bool
+ieee80211_rx_is_sdata_match(struct ieee80211_sub_if_data *sdata,
+			    int freq)
+{
+	struct ieee80211_link_data *link;
+	struct ieee80211_bss_conf *bss_conf;
+	struct ieee80211_chanctx_conf *conf;
+
+	if (!freq)
+		return true;
+
+	for_each_link_data(sdata, link) {
+		bss_conf = link->conf;
+		if (!bss_conf)
+			continue;
+		conf = rcu_dereference(bss_conf->chanctx_conf);
+		if (!conf || !conf->def.chan)
+			return true;
+
+		if (conf->def.chan->center_freq == freq)
+			return true;
+	}
+
+	return false;
+}
+
 /*
  * This is the actual Rx frames handler. as it belongs to Rx path it must
  * be called with rcu_read_lock protection.
@@ -5264,18 +5290,26 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 		 * the loop to avoid copying the SKB once too much
 		 */
 
-		if (!prev) {
-			prev = sdata;
-			continue;
-		}
+		/* Process the group addressed management and data packets
+		 * in the intended interface when the operating frequency
+		 * matches with rx_status->freq in multi-radio devices.
+		 * If rx_status->freq is not set by the driver, then
+		 * follow the existing code flow.
+		 */
 
-		rx.sdata = prev;
-		ieee80211_rx_for_interface(&rx, skb, false);
+		if (ieee80211_rx_is_sdata_match(sdata, status->freq)) {
+			if (!prev) {
+				prev = sdata;
+				continue;
+			}
 
-		prev = sdata;
+			rx.sdata = prev;
+			ieee80211_rx_for_interface(&rx, skb, false);
+			prev = sdata;
+		}
 	}
 
-	if (prev) {
+	if (prev && ieee80211_rx_is_sdata_match(prev, status->freq)) {
 		rx.sdata = prev;
 
 		if (ieee80211_rx_for_interface(&rx, skb, true))
-- 
2.17.1


