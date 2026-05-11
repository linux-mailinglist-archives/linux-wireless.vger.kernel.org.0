Return-Path: <linux-wireless+bounces-36185-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UI8HI+1UAWpvVQEAu9opvQ
	(envelope-from <linux-wireless+bounces-36185-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:02:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4063507C68
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 06:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829513007AD4
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2026 04:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066371FF1B5;
	Mon, 11 May 2026 04:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M8q2cPBC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KvOL9EDb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A875854652
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778472170; cv=none; b=CJL30Bwr9UdBPD4hF/aPwzP3ZFlNs4PqUyWqa/FFmRaitOq6azwBG0WhmBz0Y9dwV1VwdqP8nendSogniVWU3PJExNtj3IYC2ULKH6/SmTivb2SxkC1NzmZly7ya0NcRzAynnDlrToXjT5mpCyHUQ5kW9/abdNANMz/NYN36kfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778472170; c=relaxed/simple;
	bh=8ue4lmodgiQg2ySfi/zjO6aIp5nELR9fhUffT5UvFqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fCaEZYAN763EPup5Ce3Vqsq0JIaYGvXpsRfaSMuadJPCqGtn0ijybX4a+gr4QsrCWD9ojW7hSxRxId7/seyBbqPM2NwvzGjiyH5bD/Fm6ysYbuixKaQJ+iutX4RfhwtOTj8rvaP80RJs1VFy6vrfyARKY+CP/a9+D7oek8p1PZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M8q2cPBC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KvOL9EDb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AMUXLW134370
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=v+VIpKzdOH/gc9Iwpm5muVNuFBdw1lCxrFt
	lQ3zbJTI=; b=M8q2cPBCmu36dVmHCfLskkSUoy7RwbUpT11EGo4HTUx3ZUZqQsS
	fNgaKqBPc+RqqZUXHO5c+mK/2MMu9EEAXbmk/UiQrgQoQJIJZ92nUbw8u1uXgfYZ
	V8blXM2u/q57fWfsZ2YXm+pMeB/1GqrFiv3OpDhoUE7aC+1K2i6BnAumXj5KeJE5
	CFES2ZaX4aZ05CPNCCNj563EDqNctGkqieK4/qmAiFpYKH6vQDb+miR6CUkh636+
	2rU49Rtd51MvcvG2kCAoIdY5uroOJ1FuQotIfFroHOJ+gKEezO2LVDpl0zGgG3IK
	nH3LBn00oJavIc+hO2nCbAaEQ4tX6oIAMyw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1vgy4b4c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 11 May 2026 04:02:48 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82f6e6a3a76so3962211b3a.0
        for <linux-wireless@vger.kernel.org>; Sun, 10 May 2026 21:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778472167; x=1779076967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+VIpKzdOH/gc9Iwpm5muVNuFBdw1lCxrFtlQ3zbJTI=;
        b=KvOL9EDbZ0cuwEMawrnoj7F0JvvwiG958Qavk9QFtx3bdCMj8UQqGQTCvKtG50a04q
         XTcNbVpMGM5i48eBkmhf6ngQkyblB5lxfUZqh7gtP5M59I/refHmM4n5a8OW3BTxXuut
         UeFgF5p6FYd2e15C6WdoCu2Dvip5BNb8N5x/Ve6j7cso9vAeJMAB5NZnw5hbrdP6+HQy
         WlvuiUvq/2zGI/hIlY/X/XqKjD0YpeMGyR5i5G3uFhA0SiI+SEChGMBH3UBNp/rhY+6d
         PN4T+H1Fhslu/ch7Y5HRYaX8lPIgtkuHl/HepfbEMWTTJNxP5HOQRDO6bxrh/K9zZVTl
         LYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778472167; x=1779076967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+VIpKzdOH/gc9Iwpm5muVNuFBdw1lCxrFtlQ3zbJTI=;
        b=kIH4/1LJsRC5ZpgubpVplHmkGq9n4EcRHI65a7vFlhDjkm5myO0/RV1124y9ZRYobc
         Y6DIyT8yej7gMl2YxDUWlcarRsJcZ2AaNmWMvlhAaazoMyGVBGfcnHAtA1PQQEaiF3yS
         a1peZVd6Ijo5obGowuN0ruuq/8I2PEG+F0E2I+LVdT+oOBQ+KDvq0OBeLe+FPd5cjyAV
         s7xK88pCt/MPF+9Ez5M7n2VjHcPZCHhAjxRAnJoDoYl9TrZnLdpdNs54p7IaBAfey4TD
         0wRPWEVAxJiDPochjIciBY5rLiuAxU6JXYq3OCkaZRiNwcHfbKapxIBXT0lWVKj5qs5o
         XD9g==
X-Gm-Message-State: AOJu0YyWwUHhBmYHH2ilsvfqgcuoWksErn7cTgE8SukCRaKBEN8SYfH/
	Kx4w7wElLcEcEcf8+JhMH4oCi/fRnpo5pmmDSOW3wwluT/yQAPj9k73xCAX7nv0D4MRtLjruNUt
	rEc66xE8g0Rm0TjOlkPPTH01aK/c91C+1GCU5KkVNBao8cVVEKVzmZsBiE0uR48++EHpdUw==
X-Gm-Gg: Acq92OFfFdMYXdyXZcekBsYydaqtrpwHSM5Sg/j0i3ZU2tJZkCPlV+/bRIZnOMYPR/u
	eYKyAR5AFv+3vWFY8CwZJr4I4V5O8Fqomm6rNIMRlDWAJ2QaKcexVja06lnbqf6CK6Nws+MYei1
	XZKtu7nOIhO2+G2TuRdp+haf13qAhHJkCSiTWMjz1qs18D4xyEoFR8e8ljJ6POA9kfxqFAZievx
	taeDdPnI5ldPpkdG9kgoLnm2ufdrszElV0OPaiQGBu0wPNIKmifdf0W1eHAyn9AnN6pklwtLb3F
	ZxkOH821KCy6fRHXp41o6SXi1MaEuCYcVhSfutpPa/2DDNWzoQ8cIw2ZZAvnaK94U7ZRdWXZiB3
	PZ8zSmWZUtkyQZLzlkz7ooJfx4XdsxHNA9+jko7OR1vWMcpompRu/zoKl1KLf2F4adMK4hJBwD9
	zbSY40hfUSdEzjkJln0PYIyjG74Qb7uJDHKSw=
X-Received: by 2002:a05:6a00:1a02:b0:83e:adf1:bf34 with SMTP id d2e1a72fcca58-83eadf1ce1cmr4685343b3a.28.1778472167300;
        Sun, 10 May 2026 21:02:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:1a02:b0:83e:adf1:bf34 with SMTP id d2e1a72fcca58-83eadf1ce1cmr4685311b3a.28.1778472166750;
        Sun, 10 May 2026 21:02:46 -0700 (PDT)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83967dbf0cesm22792259b3a.46.2026.05.10.21.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 21:02:46 -0700 (PDT)
From: Amith A <amith.a@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com
Subject: [PATCH ath-next v2 0/2] wifi: ath12k: Add support for handling incumbent signal interference in 6 GHz
Date: Mon, 11 May 2026 09:32:40 +0530
Message-Id: <20260511040242.1351792-1-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fpHsol4f c=1 sm=1 tr=0 ts=6a0154e8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=Qv-E1znO2Y0tXsqnBgEA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Nd4R38suU8nKYZiGOqdSYKtvN1nlOku6
X-Proofpoint-GUID: Nd4R38suU8nKYZiGOqdSYKtvN1nlOku6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA0MSBTYWx0ZWRfXwfWmMnRyaS+s
 eNCixfldn8YB2JMichKEGQWbtEVnaTf8Rxq+If2Y+Y6ztjfwGC9qqe5ApcqXWlc4R6uv5OvPXG2
 0HR/HXifqZLjtGWtCU2vDcdh0RqgM72I29+e0KLY9JTW8ayhXohwLkX191zK2+e7KIpcEDChqLF
 WDyfiBNgxPzDARfAimSybjymT7UAHkRciITGo35awEIWW4F9HnGP9Td2pVR2rw7I5SHwmz7mfwb
 1lZxWvokbQB9aOETYuSNv/7LqkE3bzvDLkJg5FqTw9KT8lQGzDspPtdKwJmEqQcseyf5W9TBa9P
 UHyZHND6DLPlKogGohUEjLz6tC1m28pbe78DQsAYzkiOEBZ7rIu0gN9tnO8UowuHAk/cKGvhzFo
 a8vUN406gEFjGkZLlVfQ6PN0m0CpkN0lHcnNR11BrSjhpeeG9HM4XdUxqLRCcuWWT5qSU0DbpYS
 /Ueu3+QqQpB25mSa6uw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_01,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 phishscore=0 clxscore=1015 spamscore=0 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110041
X-Rspamd-Queue-Id: E4063507C68
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-36185-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

This patch series adds the implementation of handling of interferences
due to incumbent signals in 6 GHz channels. When an interference is
detected, the firmware indicates it to the host using the
WMI_DCS_INTERFERENCE_EVENT.

The driver is expected to parse the new WMI event to retrieve the
interference information, validate the interference detected channel and
bitmap, and indicate the interference to mac80211, which then notifies
this interference to the userspace.
---
Changes in v2:
    - Added an explicit len check in sub-TLV parser before accessing info.
---
Aishwarya R (2):
  wifi: ath12k: Add support for handling incumbent signal interference
    in 6 GHz
  wifi: ath12k: Add debugfs support to simulate incumbent signal
    interference

 drivers/net/wireless/ath/ath12k/core.h    |   8 +
 drivers/net/wireless/ath/ath12k/debugfs.c |  46 +++
 drivers/net/wireless/ath/ath12k/mac.c     |  46 +++
 drivers/net/wireless/ath/ath12k/wmi.c     | 425 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  72 +++-
 5 files changed, 596 insertions(+), 1 deletion(-)


base-commit: e12d2d3983acb150fd987d19ec6a2a530da110df
-- 
2.34.1


