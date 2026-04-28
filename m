Return-Path: <linux-wireless+bounces-35439-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFTVD4VM8Gm2RQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35439-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:58:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B346247DCF2
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 07:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AFC13014689
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 05:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717A33016E7;
	Tue, 28 Apr 2026 05:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HEkkRcWv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VCQjq4jM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2140435898
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777355905; cv=none; b=R7tIFS9TcmfJAvxPAsmIq6rjmy8cehgbJpLd0j6/LTmyMzLi0RXrkso8SXny1FJr4P/NTuHTbvDnSCbX2yjPvg41uvPUuF9p3BLzQQmJbYhdHTdjaVZK0dSbV7GMU03xfJTh8CI0JbeM1oZC6vP86vG5iUTGVPsqn4KXb/CBsCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777355905; c=relaxed/simple;
	bh=plvxbZGVvtxH16b/AkAWY8eg/GIMRwzbW221GKVryok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZpWmbj+R4huPPXHACa2PW43dPhGlFGHiQqaWLr4A89pUORWYs52ak3sc28M1dk2TaZcjKdVvyT870FR7YAXDZGhIB1C8Ge4vNy+ITCgFcp7CU39IIQNE6hdgso9N98K0NagqspbapOSRN7YY07YhvmPlYUrDNNejQOW+8d/JWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HEkkRcWv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VCQjq4jM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S42xgA1329581
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:58:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WAPnAOGU0+D8cxNtQpDecxsuOHirTuf6jKt
	wbH21O/o=; b=HEkkRcWv4xrKujsyQrgdPGrrNfxOJO59dtZK26KFY3MK3Eu+o46
	FO4gvZTaR2FIF3WhPMgcwfrVlyJi+7vDFfJyoWvu65sBqsCZqjp4sQIMPZ4DNzWJ
	/+Rw2GIXQfM+8dwr7Mc7RmQoOmj43/mIVbC7RfQKLMxCY0aPQWcFrsAppW8xrIMW
	bG7HesvkQiEAP1I0q3FrBoqdprbc/LSYt8459pe8wL6qbyMFuNZtEWEwbm964oWo
	3U1RmqOagvWXTzoshuGO06tgSdDuQ/HZR832rGUc/8hU0hfe9eJRVt8y7c/o5vou
	80k+uMGBri6PdlDgh1VmhpAUXVw6irUX7Bw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtnhagbcp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 28 Apr 2026 05:58:22 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c798ace3e03so4462215a12.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2026 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777355902; x=1777960702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAPnAOGU0+D8cxNtQpDecxsuOHirTuf6jKtwbH21O/o=;
        b=VCQjq4jMuBKDrgJIWj8nivqpJBqFQ+/2GbX6SPtiD73+kdnZElhA2Vl7spvdIOCMH1
         yPi3uusei9ZAaiZlKFdBGMTr3+9Gz0zhbQRAwH0mqaQY71M/TeA4a8kqzT40FPN6qs48
         q1uDqQx+PuP33JzUubOqlNlW0sVsPuvA0JEIF6GR4ur8917CeC/rzxL7obPHOyWiAOaY
         nHwgD9y1ZU6kJ06/e+VPQKinjbdOYxBnaUcQhWrR9BJyDJplzEXEl94GbhmXAVtH3bII
         x+tuT3oRvl2ii7rBJXsjsJpdwJysfNV+wYYoGK9fs1Nc0g2knq5oMdgQgrAeQLWwfWr+
         D+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777355902; x=1777960702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAPnAOGU0+D8cxNtQpDecxsuOHirTuf6jKtwbH21O/o=;
        b=S+ere4jGWys2cq/uVxXDZ8oc1ljXS4Ak6v3SWcDyWTWUEkjf9tyOW8j6YvdPx9OhF3
         fBjA8sMD2YP9rMUSNnIP4jnwu2UWVKxXwuLsxsW0P3fBUcRYL8JkB0duBI+7kToUFCsj
         PN7Z9HpVpAXVLR7mtjOya9H5oCjiDVqfNJ4oawp0JQWhzUeWAr33CYNEojZc6umrRrhD
         aQObHu6YdAqauyzViPRJuelyjVutODm6Gw1hNX0CEk5QbwQH2ZeMeMxL1Zjz+wYGcSK0
         lSr4ZaaSpnQ3kmLTxvFgKBpSZdjxt+AC4XDHdR2hIocesktr3xtEDBcfT7AnOVob+SoM
         tvGQ==
X-Gm-Message-State: AOJu0YymDWuD9/qC7WoLaoZWXuQkRPD6JStoTa/y9ACiINIm7O1f/W9g
	e5vnLd4i8sAB437NGqMf/SEMr5hVLYn3hgFNOPdYsXjQNzoaJyS1XLIVzo7zRMQZDxWjILIQNJO
	8O3ycLBbZTNCV3vBWOJGj2BQpC2Cz/cqTIoZsn55fjnkZ9a26WCQbBR8Bn7xomiLFgUNUpg==
X-Gm-Gg: AeBDiesm4+AN2y/1EozH467JOhgy92GIAKKF3eM3JLTSfULYvThyLlzugoQY0I6nJeb
	vU7qjwCVjFETUIvb9aNJsDzmfq/QsKEMfCEeHfF+hToQMvtXfFRrS/oul+RSn/P4LMtrpUFa1I+
	1p9wVNj0eQ37qbBpisQXy0LuMqlt0m8Y20fGtoUwHQCCLBTTLmqlaejR46sO2swHX7hDA/81mjX
	xwv7mbmmlyvWf7QP83Ku3h2ARHWZ68IWD5W8ksgopTxj3VFiO/Mj56zwcDhnlx5uJgjQNkGjCnX
	/Kq7lF85bfZJGLgAzZ4YiI7PI82TPtBORCH4M4sAczBl4ekFg9xsTpsNSGhIEIr/4kpZsv6z+hO
	gSws5mDdlXamkQ67kvbih30cuhRV8ssu/g/pEwGOnESkqNz8vCelzALMXVEc0pn+N4wtuq2dlxH
	PUrJq6yx6uNJ3oYA9w7cTb7UH+8zBHT1359OKYZaSZbtsBtw==
X-Received: by 2002:a05:6a00:9510:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-834ddc39646mr1782471b3a.38.1777355901568;
        Mon, 27 Apr 2026 22:58:21 -0700 (PDT)
X-Received: by 2002:a05:6a00:9510:b0:82c:66f2:1226 with SMTP id d2e1a72fcca58-834ddc39646mr1782435b3a.38.1777355901068;
        Mon, 27 Apr 2026 22:58:21 -0700 (PDT)
Received: from QCOM-kZLYnuwaz1.na.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834dae00e40sm1660832b3a.12.2026.04.27.22.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 22:58:19 -0700 (PDT)
From: Kang Yang <kang.yang@oss.qualcomm.com>
To: ath10k@lists.infradead.org, kang.yang@oss.qualcomm.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next] wifi: ath10k: skip WMI and beacon transmission when device is wedged
Date: Tue, 28 Apr 2026 13:58:09 +0800
Message-ID: <20260428055809.984-1-kang.yang@oss.qualcomm.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA1MiBTYWx0ZWRfX7WfS1/QlKv0I
 pOBA3X13U2326bd++M3ZfUpNAU+KJgxBQ2uM1pDpBl4Zw0BUHYZ2M6HlkYwYQMntF8cOAysVZq1
 41s2gHZOSsLjve7dvfVl4JZmSMVxWxHAxa5tbVCfKRLAzbF742aeZB/x+RQxqVLX7QbniTKhsWo
 IkJ14NX+rZGz0jVfQEO9PWgmzPOptpPAP0iaqtywq6ZeCZaa1ouu2E+zmceBZkjvDQxkLvkvNW7
 MHMwPWVA/6AZO1YDRt0LX4W6X8zUw8h0XM1jvVM9kuc2OFCOMcIkXOQg3SCPVwCjRFCkFxxH7C+
 HcdVJ/sI0NG6oU9MKzaQ3ipmAalrtlvKze+cLJpPiM45d4zwLkH8pStlmcPeyTDU9UlUHrvlibC
 /1Bk2uStGITwj+riovovDBiTznC20zri5R15VHzdDEKgWDGhk81lOb230xCWc7JNAu8dl5J7Kym
 fR+BKvnnlG3pbGN3N6w==
X-Authority-Analysis: v=2.4 cv=JoDBas4C c=1 sm=1 tr=0 ts=69f04c7e cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ojnUS93u_2yoTveIRj4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: cgKzXLrnGqnHv5TaZSMS99I2UJoXyB33
X-Proofpoint-ORIG-GUID: cgKzXLrnGqnHv5TaZSMS99I2UJoXyB33
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1011
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604280052
X-Rspamd-Queue-Id: B346247DCF2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35439-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kang.yang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

In ath10k_wmi_cmd_send(), the current code detects ATH10K_STATE_WEDGED
and sets ret to -ESHUTDOWN, but still proceeds to transmit pending
beacons and calls ath10k_wmi_cmd_send_nowait().

This can lead to incorrect behavior, as WMI commands and beacons are
still sent after the device has been marked as wedged, and the original
-ESHUTDOWN return value may be overwritten by the result of the send
path.

The wedged state indicates the hardware is already unreliable, and no
further interaction with firmware is expected or meaningful in this
state.

Fix this by skipping beacon transmission and the WMI send path entirely
once ATH10K_STATE_WEDGED is detected, ensuring consistent return values
and avoiding unnecessary firmware interaction.

Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Fixes: c256a94d1b1b ("wifi: ath10k: shutdown driver when hardware is unreliable")
Signed-off-by: Kang Yang <kang.yang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/wmi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 0bdb38edd915..ef1cf6664449 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -1947,15 +1947,15 @@ int ath10k_wmi_cmd_send(struct ath10k *ar, struct sk_buff *skb, u32 cmd_id)
 			ret = -ESHUTDOWN;
 			ath10k_dbg(ar, ATH10K_DBG_WMI,
 				   "drop wmi command %d, hardware is wedged\n", cmd_id);
-		}
-		/* try to send pending beacons first. they take priority */
-		ath10k_wmi_tx_beacons_nowait(ar);
+		} else {
+			/* try to send pending beacons first. they take priority */
+			ath10k_wmi_tx_beacons_nowait(ar);
 
-		ret = ath10k_wmi_cmd_send_nowait(ar, skb, cmd_id);
-
-		if (ret && test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
-			ret = -ESHUTDOWN;
+			ret = ath10k_wmi_cmd_send_nowait(ar, skb, cmd_id);
 
+			if (ret && test_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags))
+				ret = -ESHUTDOWN;
+		}
 		(ret != -EAGAIN);
 	}), 3 * HZ);
 

base-commit: 34a5329beee86a22a446e27eb37f06caa63479ca
-- 
2.34.1


