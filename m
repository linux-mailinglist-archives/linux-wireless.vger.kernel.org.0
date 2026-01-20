Return-Path: <linux-wireless+bounces-31022-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL4gBUWzb2nHMAAAu9opvQ
	(envelope-from <linux-wireless+bounces-31022-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 17:54:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0EC48094
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 17:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E7137E5604
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jan 2026 15:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CED44CAC1;
	Tue, 20 Jan 2026 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ue/wWwIv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DXWDpMp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D1A44BCBB
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768922590; cv=none; b=kg4zf9VGZ2EqBlJ6CEeYEmNyaHq9FI1/Q+OZP79maVVtjz7wYg+AIYwOdSTNZXeBn5C2JMTfVb+cwpzUaqi2r5yoeplY6mu9z1CpiCQVKBt2/UINX3UXIEL3qPq2PRbk1LTW02kWXqv0+QGTww9d2RqZrQZsR4F/F1Ue2Mst4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768922590; c=relaxed/simple;
	bh=yDBrfi3iVP+Tq37muWZApc99HlZgA7MJrBe13kh3kQY=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Owkf+jWvK0e0jXi9zzi5/umEAtZmhHjPwtQ0JkXT6CfqC0wY2woWYbQ1OygkKOwlFJC2JhdxVID5xG9DHboL3VLbAZ4z19iXSpYIX0OdBXXazlev/idd7hYcHVAL/u/VuDy5oDECYxigDvW3xeArIchjpyZqab5/Vi21xcIq0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ue/wWwIv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DXWDpMp8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60KCxAwT797938
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 15:23:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=TpALKUDyKAgMeTAAjE5QQA
	f1vwVOBRkwtHr2nPfTUYM=; b=Ue/wWwIvi6KDYaZmeHSf3Tl7N+2trCKDp/81V+
	EWxGHJM7bK3yEH7aaBX2uu+zi6W8q90vXPBijifIxHrT4KqI5c1MlymgN3D1sT27
	Fc4bexH/Mhw/l5lQ7qhxdXr8kH6B9IpVrgckN+wyhO4cEF8qrQJxcgH05KuA138+
	UqER4ivR+G98y5lt/WroRzAO7l9xSC98uhzxutJHuGUtMzOispReaae2mOPalytn
	gsKaOIioKyxXsJ01pSATWPBMyGcURlX28pZk0q/6dm5l6oaX8UTY6pCFNCVIuNof
	pSUZ16eMrBGCWkLavXcY5v13HaaemooD4WdE1Tb/xj+VosPw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bta6q0dhk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 15:23:07 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2b6ba50fc34so3172228eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jan 2026 07:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768922586; x=1769527386; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpALKUDyKAgMeTAAjE5QQAf1vwVOBRkwtHr2nPfTUYM=;
        b=DXWDpMp8fVDdn6xzOVvQseXqoheYeZPjnjqygm7NUGNO7yFKva+82w7OOqe7eMnsv4
         6JbIJfkyu0zk37AMXNujbzIVSY/M8Dxvr1DjqKHTbfiIVAjNR4umKpWkBLycFDdGQ9vQ
         sjG7VmDejRlVFzyLjGNR/gJnZnYJHYgq6DlaoXDsy6uIIn8mKwyy7YqUvOgeOpf8JEMf
         yTBk+GjXyBXgfmkxYtJ3WwkTKWUhjBm8nzabrtICEAvYcoTcJxMJH+X0VYp9ZUdEtDkH
         Mua+2GhYlUrIHuFMahy8uZCz6TRfpUWRWXawBdjdp5YcR1Sg1xIL44R9P3UgnxVh0Ff/
         u56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768922586; x=1769527386;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TpALKUDyKAgMeTAAjE5QQAf1vwVOBRkwtHr2nPfTUYM=;
        b=k22jUAhg5oL2Fb/aaOdq5UnwScqO82JXfGNXRytFzLa5++irW29WeZphA/s+Oc6DJW
         j9UZsyhOYLo5UayS4KbYvvCcu15d8k2Jlyp/qoguMSZjLLQbc5+qkhwHCN9eGpUR+Mc6
         cdcVRcOx50HpBE8Ku7r3yypFoxza1NmlYHqgQDITqHOZUy8UwWYJ90gDtMK8LwTIwewy
         3E23tqgkHe3SxqBd9CrL14UxuHFZFhjY1BgOnjwx+TZDigVx82/bDRY2/Gf6wy4XEwZR
         dwRJDeb3YLbvQfVnMTEcsyUErcclNkS9iahjlJj29e7qeS/v68Pz33kxeh+GjIEcA0IJ
         Jf7A==
X-Gm-Message-State: AOJu0Yxt0TQT+Z6QDCgCHrRdFh+Yk3GopQr+Pw9A50Usi3AG0iU8Joyr
	VCn90bckInl4ErZ412Xfl7Lv3x5phJFg6FNL/pmt/N1GWXWMJOLuv2RSGH2kUTtnDCuaARPw5Ad
	aXkTU2+0Mz9Wc9jlOXYSYm4mOGcYe3kA8/wVy3qBv/P04mg2kdss9TvxobdtQsiK5+tb6Ef3l7I
	iUSg==
X-Gm-Gg: AZuq6aKXyQ7FOCy6mrUgdp67Vn4UJ4sWeghfus5q93KpuHaRl6YETWae6hgM0Mqm/Cd
	xNDfhOKSG8NM224WaCQfK0mrM5nXKg0B1OSf5idjWE66UUNu0nAHWQXnzO4uKgvjQeVYBSBtN2V
	vwv1McM8cwdQjvzZGJym2mwvez6xDgejm3WtIWAaJrPNUKu9xC3UfMyszbRpPN23+QBqt2eNfXb
	eFBDniEisTt6ocMFI+fwKgALJhoCjG8tp3jofF6oq6TJqa5buc+IJlPeI0bFFVH7ywToTW0rwCv
	cfI945Zdq/gYOACBad/LSxTTtGpz3+hYTYVZ3TYhW+jiAPj8DjqP55BzmGkDVf23XIEe4AJ8pVS
	/cY2095XdCenVtkUeb6D0diwMRspeMQZnBVtsfGm20709CQ==
X-Received: by 2002:a05:693c:4096:b0:2b7:110:519a with SMTP id 5a478bee46e88-2b701107280mr1114038eec.17.1768922584465;
        Tue, 20 Jan 2026 07:23:04 -0800 (PST)
X-Received: by 2002:a05:693c:4096:b0:2b7:110:519a with SMTP id 5a478bee46e88-2b701107280mr1113941eec.17.1768922582343;
        Tue, 20 Jan 2026 07:23:02 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b70a036d02sm654912eec.14.2026.01.20.07.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 07:23:02 -0800 (PST)
Message-ID: <65b400ca-8526-4184-ae0b-5e24e41dab9c@oss.qualcomm.com>
Date: Tue, 20 Jan 2026 07:23:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-next-20260120
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=QohTHFyd c=1 sm=1 tr=0 ts=696f9ddb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=TO4lM5bOfp6PPmgnV6YA:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDEyNyBTYWx0ZWRfX8qnsdz6n47/a
 +8QcLiF6750SDxYtScP980dpu6p1a61ya6n1Mu7XWZIgiOVtKd9xM7hkkDN5W3NgVMv6IpyutdI
 /jAbBvDRa0/ihj4wLd7n/+FI/kT/Q9j15E9XA8uSnaPuvdZ/QmP4JuN8vTWzcirAm9iDfqCiO1V
 Acm+UAj6pql5LZTWC7TcvYtcHZtqr34QSX6k+jY7s0NFws3EbuV6EQIqAUFkZ7Y4uzoYnkzj5dN
 ynLolsDp52YcIxRUQqQXm2XK/wmRPnpaZHEOGVC4yxlCo3eYHalzrukv35BAKVo0oc0CRLn9MBF
 df2g31pi+j04mR1wcH8z30AdQAqRMxHWJvB5Oc+g6k108LWgda/nHPlhaQGXHYi0ztKeaKT+Jig
 D7VQVxaa3gzeaIWhCLGMLxPM2jGRjcHl/E7rRYyadw6MydDI3KqErJEhJX/6EwUhljaOkcw5g3+
 RPwEAg7XFA+0tTzjTaw==
X-Proofpoint-GUID: iUEbfhoI8TLflaQRRX7tJNLRJGP5TwIj
X-Proofpoint-ORIG-GUID: iUEbfhoI8TLflaQRRX7tJNLRJGP5TwIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-20_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601200127
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31022-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AE0EC48094
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 24a57985670e9dac5547e5b7731bf8e7b03d5be8:

  wifi: cfg80211: don't apply HT flags to S1G channels (2026-01-13 10:44:26 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260120

for you to fetch changes up to d8e1f4a193101a72235416f189b01131a57e26e9:

  wifi: ath12k: enable QCC2072 support (2026-01-15 17:19:42 -0800)

----------------------------------------------------------------
ath.git patches for v6.20 (#2)

Highlights for some specific drivers include:

ath11k:
Add support for Channel Frequency Response measurement.

ath12k:
Add support for the QCC2072 chipset.

And of course there is the usual set of cleanups and bug fixes across
the entire family of "ath" drivers.

----------------------------------------------------------------
Alexander Minchev (1):
      wifi: ath12k: remove redundant pci_set_drvdata() call

Alexandru Gagniuc (1):
      wifi: ath11k: move .max_tx_ring to struct ath11k_hw_hal_params

Baochen Qiang (18):
      wifi: ath12k: do WoW offloads only on primary link
      wifi: ath12k: refactor PCI window register access
      wifi: ath12k: refactor REO CMD ring handling
      wifi: ath12k: refactor REO status ring handling
      wifi: ath12k: fix preferred hardware mode calculation
      wifi: ath12k: refactor 320 MHz bandwidth support parsing
      wifi: ath12k: fix mac phy capability parsing
      wifi: ath12k: add hardware registers for QCC2072
      wifi: ath12k: add hardware parameters for QCC2072
      wifi: ath12k: support LPASS_SHARED target memory type
      wifi: ath12k: support downloading auxiliary ucode image for QCC2072
      wifi: ath12k: add HAL descriptor and ops for QCC2072
      wifi: ath12k: add hardware ops support for QCC2072
      wifi: ath12k: handle REO CMD ring for QCC2072
      wifi: ath12k: handle REO status ring for QCC2072
      wifi: ath12k: limit number of channels per WMI command
      wifi: ath12k: send peer meta data version to firmware
      wifi: ath12k: enable QCC2072 support

Chien Wong (1):
      wifi: ath11k: fix comment typo in monitor mode handling

Dan Carpenter (1):
      wifi: ath12k: clean up on error in ath12k_dp_setup()

Krzysztof Kozlowski (1):
      dt-bindings: net: wireless: ath11k: Combine two if:then: clauses

Miaoqing Pan (1):
      wifi: ath12k: fix PCIE_LOCAL_REG_QRTR_NODE_ID definition for QCC2072

Qian Zhang (1):
      wifi: ath11k: Fix failure to connect to a 6 GHz AP

Randy Dunlap (4):
      wifi: ath5k: debug.h: fix enum ath5k_debug_level kernel-doc
      wifi: ath9k: debug.h: fix kernel-doc bad lines and struct ath_tx_stats
      wifi: ath9k: fix kernel-doc warnings in common-debug.h
      wifi: wil6210: fix a bunch of kernel-doc warnings

Rosen Penev (1):
      wifi: ath9k: add OF dependency to AHB

Ross Vandegrift (1):
      wifi: ath11k: add pm quirk for Thinkpad Z13/Z16 Gen1

Venkateswara Naralasetty (6):
      wifi: ath11k: Add initialization and deinitialization sequence for CFR module
      wifi: ath11k: Register debugfs for CFR configuration
      wifi: ath11k: Add support unassociated client CFR
      wifi: ath11k: Register relayfs entries for CFR dump
      wifi: ath11k: Register DBR event handler for CFR data
      wifi: ath11k: Register handler for CFR capture event

 .../bindings/net/wireless/qcom,ath11k.yaml         |    9 -
 drivers/net/wireless/ath/ath11k/Kconfig            |   11 +
 drivers/net/wireless/ath/ath11k/Makefile           |    1 +
 drivers/net/wireless/ath/ath11k/cfr.c              | 1023 ++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/cfr.h              |  308 ++++++
 drivers/net/wireless/ath/ath11k/core.c             |   81 +-
 drivers/net/wireless/ath/ath11k/core.h             |   19 +-
 drivers/net/wireless/ath/ath11k/dbring.c           |   50 +-
 drivers/net/wireless/ath/ath11k/dbring.h           |    8 +-
 drivers/net/wireless/ath/ath11k/debug.h            |    8 +-
 drivers/net/wireless/ath/ath11k/debugfs.c          |    2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.c      |  142 ++-
 drivers/net/wireless/ath/ath11k/dp.c               |   12 +-
 drivers/net/wireless/ath/ath11k/dp.h               |    1 -
 drivers/net/wireless/ath/ath11k/dp_tx.c            |    9 +-
 drivers/net/wireless/ath/ath11k/hal.c              |    3 +-
 drivers/net/wireless/ath/ath11k/hw.c               |   19 +-
 drivers/net/wireless/ath/ath11k/hw.h               |    8 +-
 drivers/net/wireless/ath/ath11k/mac.c              |   23 +-
 drivers/net/wireless/ath/ath11k/reg.c              |    9 +-
 drivers/net/wireless/ath/ath11k/wmi.c              |  147 ++-
 drivers/net/wireless/ath/ath11k/wmi.h              |   97 +-
 drivers/net/wireless/ath/ath12k/core.h             |    3 +
 drivers/net/wireless/ath/ath12k/dp.c               |    2 +-
 drivers/net/wireless/ath/ath12k/fw.c               |   10 +-
 drivers/net/wireless/ath/ath12k/fw.h               |    3 +-
 drivers/net/wireless/ath/ath12k/hal.c              |   46 +
 drivers/net/wireless/ath/ath12k/hal.h              |   34 +
 drivers/net/wireless/ath/ath12k/hw.h               |    2 +
 drivers/net/wireless/ath/ath12k/mac.c              |    2 +-
 drivers/net/wireless/ath/ath12k/pci.c              |   18 +-
 drivers/net/wireless/ath/ath12k/pci.h              |    7 +
 drivers/net/wireless/ath/ath12k/qmi.c              |  180 +++-
 drivers/net/wireless/ath/ath12k/qmi.h              |   16 +
 drivers/net/wireless/ath/ath12k/wifi7/Makefile     |    3 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.c      |   62 +-
 drivers/net/wireless/ath/ath12k/wifi7/dp_rx.h      |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |    8 +
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |    3 -
 drivers/net/wireless/ath/ath12k/wifi7/hal_desc.h   |   33 +-
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.c    |  503 ++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcc2072.h    |   13 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    |    8 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.c     |   97 +-
 drivers/net/wireless/ath/ath12k/wifi7/hal_rx.h     |   30 +-
 .../net/wireless/ath/ath12k/wifi7/hal_rx_desc.h    |   17 +
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.c    |    8 +-
 .../net/wireless/ath/ath12k/wifi7/hal_wcn7850.h    |    1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         |  101 ++
 drivers/net/wireless/ath/ath12k/wifi7/pci.c        |   26 +-
 drivers/net/wireless/ath/ath12k/wifi7/wmi.c        |    5 +
 drivers/net/wireless/ath/ath12k/wmi.c              |   54 +-
 drivers/net/wireless/ath/ath12k/wmi.h              |    7 +
 drivers/net/wireless/ath/ath12k/wow.c              |   16 +
 drivers/net/wireless/ath/ath5k/debug.h             |    4 +-
 drivers/net/wireless/ath/ath9k/Kconfig             |    2 +-
 drivers/net/wireless/ath/ath9k/common-debug.h      |    8 +-
 drivers/net/wireless/ath/ath9k/debug.h             |   15 +-
 drivers/net/wireless/ath/wil6210/wil6210.h         |   33 +-
 59 files changed, 3135 insertions(+), 236 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.c
 create mode 100644 drivers/net/wireless/ath/ath11k/cfr.h
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.c
 create mode 100644 drivers/net/wireless/ath/ath12k/wifi7/hal_qcc2072.h

