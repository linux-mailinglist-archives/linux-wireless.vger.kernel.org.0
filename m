Return-Path: <linux-wireless+bounces-32583-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mP7bIqJvqmkwRgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32583-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 07:09:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E298B21BF4E
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 07:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2E0423013B64
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 06:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E893347FFA;
	Fri,  6 Mar 2026 06:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kzi2dgc+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L1Hsvqyt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7EA3368B6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 06:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777374; cv=none; b=bVhnpK0WBU3AEkghMAR8kNh/CaURs7R9tNAuqgch1/nG2ADtpcUr2YRmT94kQz4mAG0yaD0/poG+7YPy7ExdLHydxtG+WNdmr+e4027M6VeM5bJowxjLlZajxWCkB5UJ7nUmic1NXcT4qA726Msmp0oo0QfrXPVqFnfTxHmAppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777374; c=relaxed/simple;
	bh=jq7MNUdbGLRNH90FSV9hUyKpIK0FSBV1Bo5xPcJOw1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=pex54e4IBdUBOzPOjRC7WdJgyBle0O2YLu4ClTI4Y6EcRFwLzJlB3veu+R0bs6vErOHADpNq+Jz+oG3/iYoyWgtJHf1byE+im7uSIJPzFLpKuadDpUX4p2iBKWiT8S7XZQMA37Ye9fVYNueRJUFyDYUsNlzNbLpNgwRbE9QMgog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kzi2dgc+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L1Hsvqyt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6264aBP13218970
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 06:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eMTwXXxFhVYjAuP+4+J65t
	kfVDJZB3H6ggebnAQkH5w=; b=kzi2dgc+wUBnQZ+EjkqVap7z8TRvB4/7mk6EEv
	hvi/mdJT7Fx+wKBovh+ClStmVNfAIs+qQCaQERxQs98+ulx+IG2UPgpmxDvDFJDT
	AfEDZ5qrQCI2piH4sdOWt+fctEY86RcaPW5w3AGPze4YY9DkmAqitFncrre0AZbZ
	6WXx9pBBE99iv4OBBZ6N8iHZbMny9UQhFheEYLmFptBp5y3MIPodNCFVrrGsGuEu
	nJENdOgyUAL1Vf2WNtOXRBFvcFlYHoEd87YMvA3LpHkSNM9ZCqjSHm61GmEaEfgw
	QHLSTN8J9lC0+ALYw5uGzQ6/dRa1D0IaFn+Wfg50meU6CCLg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqf25swam-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 06:09:32 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-829a535ad50so86061b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 22:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772777372; x=1773382172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMTwXXxFhVYjAuP+4+J65tkfVDJZB3H6ggebnAQkH5w=;
        b=L1HsvqytnYkavQqZJdOjI+xhn318ce1lc8l4PcryHno0/oNHE1fqPjTcmSuHqXRBaZ
         zKRouQ1xtQTvG/vfvaN0N1diAoVJIa+HOLsOhdwSFRcBMh1ed3RUr8q3lEAYYsHpOUOX
         kYSo8PbGbVJZcRx9hrCQk552kdWkO13FQJmFreuRmsnDTt6TzpMVWauzlejSJbL3kN5Y
         hAUNwfTD6uqEn+eU+BNtpe+jlh55vvk8YcPMAo4GpfxQ7g6xeVlp36q8SlFl5I1gI3s/
         0ycX0RQos4GLyAAQCPCi5hC6Im9b4nD99Xnp3n4awq24MvxGukfcynf3zrPcyjvxHT6d
         YNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777372; x=1773382172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMTwXXxFhVYjAuP+4+J65tkfVDJZB3H6ggebnAQkH5w=;
        b=iO50WofCXkunk/kdz3DofFGQwjpjFj/PWFpj5EFTCYc7mVlKmTl/o2jg26426OA2nz
         ZvXoK2rmZHRKs6g8Zk74lgq8A7flz32hPMoPGTaeooRDdIxWOTstM/e3wI9hnKmqpvJn
         IeBeDmTD19XT6r9qQf3OjxTV/HpR+RzeXCe31v1zYJu/BXWKaPnD8XrG0DOx/YvLf6QH
         IqJdI92jGL+1r6UbQC0lnXYrPhfHZ67XZkgNRd9oQAiF3A1NFKl1egibDGNlD0J9w9tV
         83Xt8Bn0CDWnwvXxggGmXbu7n+QcRRAxyjEnHw5kCaLGlsnLw3P1UMKoyyw8TlGynjf9
         Uxhg==
X-Gm-Message-State: AOJu0Yz3uiHhXoGlsOAc9PObedtzZRN126v1XHhneXZJw05jHdEFb89e
	OJp6eBRzlHUxNBgKfHSCFooXVjgxXMtKtV4r0cBw4eYzaFHeDf6GTigK+oYQ8xXjy3ORgVvAazD
	trd7tgJ3IA0PE3uahcTmnZ/+C9Ju6VtOQ66NMquBBLW6oy/rI5iiaNUNRK2Cx4ptFp6Htmby9Rh
	uzAg==
X-Gm-Gg: ATEYQzxpLDoMZ44PlFdunDNU6STUtY3s6E2gZPkdKmSl9/Oh83J048OLGaBj4kRF7tP
	OgS8mFtzBgkgeO2lbd4LkOnFh5ixigyAnYEibqPmoanCsbT0mVoRkK0KViPVqr/LOxeTGefRwei
	YUDToB53HUZszJKPgwibN/Wpg/e/UEvCXq0Pi5SZ65GznPBmeEiHDMG6akNq5CTrp9/mfkc4ilB
	eUH/lyx9Lv3dK6BTknq6AZo1MF7QeaUze36ksCCXioGhI/lZQvH/8MTeyieF3hh8y9DPhAmOvXM
	hW0r+l4AG67mjGV6diF12zHIGlirGemwJZEa1mbLZ2lDfH7zH0QskQ3ma+5f5YfJN14zyZXksIz
	9lDbPbjs1ZVkyngOVQppmZxaAOGqp48vmjcaAKiPyjU04tfA/7of85XOCmo4a8Z73ttv/tJGFHx
	EZMdFfzwc4WrMufkdUFwDg5u3cRuKOymCsjRE=
X-Received: by 2002:a05:6a00:21d0:b0:829:7087:7e79 with SMTP id d2e1a72fcca58-829a2f49b43mr1040172b3a.30.1772777371883;
        Thu, 05 Mar 2026 22:09:31 -0800 (PST)
X-Received: by 2002:a05:6a00:21d0:b0:829:7087:7e79 with SMTP id d2e1a72fcca58-829a2f49b43mr1040139b3a.30.1772777371333;
        Thu, 05 Mar 2026 22:09:31 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48647e8sm589804b3a.33.2026.03.05.22.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:09:31 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH wireless-next v6 0/1] wifi: cfg80211/mac80211: add support to handle incumbent signal detected event
Date: Fri,  6 Mar 2026 11:39:26 +0530
Message-Id: <20260306060927.504567-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 7s3WlUbG7TJO6RO51mARYaHAriHr9_Rm
X-Authority-Analysis: v=2.4 cv=Uvdu9uwB c=1 sm=1 tr=0 ts=69aa6f9c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1P1qi0jZ29cQl9APfZwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1NiBTYWx0ZWRfXzm7bV1D4Ev98
 IGv9fMqSTww3TvQ2FM6sJdMEekred+A3H+g5Zn0zUvdCUnwQqe+C2HqDXIJFImqB0swhcn82sGe
 dJYAxwUq6cICZRn9nftcpbhnm5VNSWSHmEymnR+LKlFUgHzL4jvlxqssXPDc1aMId/8Fm4y8ShB
 HbymnoAuZx4p11XSv6nHDApql+V2dL3rr1HBzkkqcrACuw7ul9LeChyill30/5BoJcDQe+2QD1Z
 h17p0xKxKIFI4bq1uk4wod07i+68iBGm+CR/hJIoMBNXk/o2ALx0+B2KHd6cUVZd3FXpb0Hd2z6
 XT5n3w70zc2bV4n0rGXY+ObJ0slu4+FQcoJZdK4ohMLDVO5Nbj5XHmCnWAkfrrM+EtYwqGe0wPg
 oW2L5JXWdmP3uNdoAScm3Ilgfm7pOMs4M/RWP4JksodYtDuYruDWERFycwgGYUmky6jOBrXZ6rK
 KKDycRIsxPC5hpFQobQ==
X-Proofpoint-GUID: 7s3WlUbG7TJO6RO51mARYaHAriHr9_Rm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060056
X-Rspamd-Queue-Id: E298B21BF4E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-32583-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series adds support to handle incumbent signal interference
detected event in 6 GHz band. When an incumbent signal is detected by an
AP/mesh interface operating in 6 GHz band, the AP/mesh is expected to
vacate the channels affected by it.

Driver is expected to call the newly introduced API with required
information to notify the interference detection. This information will be
ultimately sent to user space via NL802111 command. User space is expected
to process it and take further action - vacate the channel, or reduce the
bandwidth.

Aditya Kumar Singh (1):
  wifi: mac80211_hwsim: add incumbent signal interference detection
    support
---
Changes in v6:
 - Simplified chanctx iterator plumbing, tightened input length validation
   replaced strsep/kstrtou32 parsing with sscanf and collapsed local
   variables to reduce complexity.
 - Removed patch "wifi: cfg80211: add support to handle incumbent
   signal detected event from mac80211/driver" from the series as it
   got accepted.
Changes in v5:
 - Made chandef const in cfg80211_incumbent_signal_notify()
 - Removed mac80211 wrapper ieee80211_incumbent_signal_detected(). 
   Driver/hwsim calls cfg80211 notify directly.
 - In mac80211_hwsim, switched debugfs to custom fops with .write that
   accepts “freq_mhz bitmap”. Now 6 GHz chanctx is selected by primary
   20 MHz center.

Changes in v4:
 - Restored gfp_t in cfg80211_incumbent_signal_notify().
 - Dropped incumbt_sig_intf_bmap from ieee80211_chanctx_conf and passed
   bitmap directly.
 - Updated trace/call path: api_incumbent_signal_detected() to take bitmap
 - Simplified hwsim: removed helper struct.

Changes in v3:
 - Removed the workqueue mechanism in ieee80211_incumbent_signal_detected(),
   exported the cfg80211_ function that sends the NL80211 command and called
   it from ieee80211_incumbent_signal_detected() directly.
 - Renamed nl80211_incumbent_signal_notify() to
   cfg80211_incumbent_signal_notify() and removed the gfp argument from it.

Changes in v2:
 - Updated the kernel doc of NL80211_ATTR_INCUMBENT_SIGNAL_INTERFERENCE_BITMAP
   to include details of how it interacts with puncturing.
 - Rebased on ToT
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)


base-commit: 5d048bbed1bb2bbef612dad0bb9c177c434e63a4
-- 
2.34.1


