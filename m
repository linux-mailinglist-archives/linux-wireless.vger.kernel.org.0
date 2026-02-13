Return-Path: <linux-wireless+bounces-31811-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cPFAEqv2jmnbGAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31811-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B34134CF3
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 11:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 881BC30095C2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8C630AAA9;
	Fri, 13 Feb 2026 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ki7f0fqo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eafHyjlv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2877E0FF
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770976928; cv=none; b=ljLmAw5k9unwmU6k6pF83qSkKFeNHQsfAzgfFqTb89XUyNQL5H1ryHMslFNxVtw6Ws0sazx2O5Ym113bBeaoj4637j+AwZBe7hSts1s8kvftUH/Gho3CSmn34Lw1TOC2NTZvJKVzgy2df5nQdfjVtSX6374ugRQtH8TBZ24HnKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770976928; c=relaxed/simple;
	bh=qguIqvEuTsr4+tIVCtESwN7vW1jqGN2t5UPw/2H72is=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BkH9TrgdOVe1J3K70x7xEJNBA+FiH77Ri0icsOUc5QPqhPrZwgrSsd2kunHEJfkk77vmvdW87jYINVAwTX7UWKRgjLnf1npoVIHtOEUUF4Ror8ysdaf4ItSGEexqKKZO1uxveaLIjPeGJm8jt7wN3ENNAVbCoahKxqG5+qSldXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ki7f0fqo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eafHyjlv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61D54Me71828056
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=aazsII0woAV1Oi/oJYUaWsqX0EmYozX3/kD
	4hkJwmvo=; b=ki7f0fqo48aP529JRnPyXh0kdVehxIPBqRx4/oLDbHdi2EwCC26
	lBR9LPQYbyhDkmR+bySk7cUtXdt5WCJDk8hpAyr9BwuZiDA1D5Xq+sg0/5oAISAg
	BjZupGAut51cCBCi/1AdZLEO5NH/qGVLolf3BNB6QQDegIaaEiu+h1MYCNoHId0W
	X+aIYLJBEz53/gYuGjOSCJbHaVB+AnTqjlGjcCrQOBPKFnByyqIYIaomUvhZdfG2
	LsYbrTs0ohUa/2GcTuDINrsC39I3TwwUmWNESypoTuiT2SIQ9xpUPy4CFcTnDyzv
	adj/agoLWDCox8KIEnvl59p7nqhgt0828fA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c9wg012ds-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 10:02:06 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aadeb3dee4so31345115ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 02:02:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770976926; x=1771581726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aazsII0woAV1Oi/oJYUaWsqX0EmYozX3/kD4hkJwmvo=;
        b=eafHyjlvL39Q75QzzwEfVHcdEo3a24BUw4VKMh4bTMci64hajm282GMLwaIcjo1gc8
         /IfpH+vu+l7Wre5iR2DcXl2MkflzzUj6pS14GB8L6d/Ow1VGZ2eR69cHB8h3s9Hu5pgX
         lQgRQ5Kc1wBuniEyndIz0fnVjoanq5YKbkjZKelC0UcO41bSBd/q22uC+5QMP8XRDpAF
         O4RRf+VZbRo2u7AeAMGVSY3oh/Ss+KbtwL57y64CtB3zROznwwt0rJFF5syPoLK0oXeU
         rjd6eLtnsNS9oNRnE3xLp7PkSvYJa/vAxGW6MtnjOvKtZVvPpwrUsCWcr4saFfjeZ4Mq
         bbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770976926; x=1771581726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aazsII0woAV1Oi/oJYUaWsqX0EmYozX3/kD4hkJwmvo=;
        b=dBED/YZyzsgH6zomtRa0B5/8kgu7WGHA+xBcuBs9uNsoXNKF68NB57fsIr4cqV0sQS
         b9ZOleBlvcTN5kXljipk4M69tzQ/iHqibuWMmeeEXF4Rj191/8owrcjGDpKfvs3t0oFY
         kj8veeVPyA0MjzygR/RpobPV9mXXTOh0fs1kNiIOVFMT56Bri9p789z9uWLXNGbkvFNN
         EHJkTsNMWU0IV47w2BIARvh/zpnkqsBOWFaw8vrWeprkUtsQcyxJzz5LWlLZm6C88M4M
         Q1bWAHRHdgAXGse7hWpZRXTsuq/Af5rC2xp47tr/25MwTtb0vq+d+0DizZhy3EzlG41F
         Q1dQ==
X-Gm-Message-State: AOJu0YyNKvJYMvS/R28ojiTFJ2bv8gS0+LZVujIb+ZC2NJHDIRrPGFj4
	zKiVRncGj77thm7x/T0QgGvpMdQ2F2Z5ejzxNvynSAH4hV6ZdW+/gB9u3vzQSRVGDmeRugr6Brn
	WwAtgq743C7JHXn1K3lEu6aSep0oGQJChCKEdSBVBANJPgLL095jgNxe/goc3Pbmp0yQCyw==
X-Gm-Gg: AZuq6aLUwWuXLUDZtxQN927wCn36zmezlqH0QSK4FjKpM5QrFO5BgCSihyQBpXD8LtU
	WxXUyN4IXmO4ei86XXVsiLNSNwhh3I75tg/SELpqlS709Ux3+8t+kX5nCAl1kwbWBdi0rJaEAQU
	c63ztnGkEYAYl4PVUCmgpMpoLIAd2Uf7kpuKKgKMZplUkkRzGLpGxva0Ty1iwep/JKqE/x1TqTL
	CFU+0k+U1jby7a4afmptTVX3uJQK8kh+mn4KTPoXfIqqC2WeuAX2+DRuPCwzYr2lefQenyMzDI/
	7pK993u8xA+DS+DxkGcdDMfNdKC2tEVNB1kWQJyQsoMGxiPeKGWn8hHrmKYUpODO8Vee21XcUre
	CgmS8HJXafY7kMA98T8ZYI1v0Z1Glk6e9m/sf1QClPOi5Y3oaP5gSZAZccURWXy0NYE0II/DMFk
	GUrn9zzLP9mmsd/hIDdvRvGU2ySkUJbYJut8F9tIpBWrKXT7Q=
X-Received: by 2002:a17:902:e548:b0:2a9:496c:e738 with SMTP id d9443c01a7336-2ab4d093590mr22378015ad.52.1770976925654;
        Fri, 13 Feb 2026 02:02:05 -0800 (PST)
X-Received: by 2002:a17:902:e548:b0:2a9:496c:e738 with SMTP id d9443c01a7336-2ab4d093590mr22377665ad.52.1770976925055;
        Fri, 13 Feb 2026 02:02:05 -0800 (PST)
Received: from hu-surapk-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab2984ad4asm79314755ad.6.2026.02.13.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 02:02:04 -0800 (PST)
From: Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
        Suraj P Kizhakkethil <suraj.kizhakkethil@oss.qualcomm.com>
Subject: [PATCH wireless-next v2 0/2] wifi: mac80211: Fix issues related to sending NULL packets to probe stations
Date: Fri, 13 Feb 2026 15:31:24 +0530
Message-Id: <20260213100126.1414398-1-suraj.kizhakkethil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEzMDA3NiBTYWx0ZWRfX8gSVGktlpPlL
 ayyS3YP0aA30AGF7P1h4jZU5rlxuRbMR4QCNwwmMejOzTuQqahVGeh0+Y8me75E4b4Q52ZgNqj+
 YXOnPxRM//qnUoVaaYSM/TBvms6brze8eiX/w+09x5mU8RGwpeM2OkRqfjjOdT3GJFKUAP9RJzz
 mMcykO005twtnncJawEL3JPXnBHVQDpW+4G8pYtz3JhSa2mtG2+r58jl4d4Y/bA9ojDvruuAwCl
 aUeZNDMcDmedENORUvSxuwc6zv82pipKaCrDY7p9PfWUWj13ffH0nHFHIk3tn1eZU+JWKCRLwoW
 v1LtC4YoUNZPCG0fQf0XlfVblX4E2yW3MhoIxlb1wbBbZCIwU6/jRKFSwXNKCzl4EtO7cyfSgmg
 17KURyS9gGXdW8eLKzLTZ+cGMCk/ZOeeJdOay33nyPvuao3JSg6I8ZtKWX1GfKTcXNDww3csp43
 Ta8kV7fdbZ8CeePy9LQ==
X-Proofpoint-ORIG-GUID: DzTYyqYP8Pd1wCk2FiZC-EQaOXzrfTh4
X-Proofpoint-GUID: DzTYyqYP8Pd1wCk2FiZC-EQaOXzrfTh4
X-Authority-Analysis: v=2.4 cv=bo5BxUai c=1 sm=1 tr=0 ts=698ef69e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=30KM3DeeyDcYQNpkxpUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-13_01,2026-02-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602130076
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31811-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.kizhakkethil@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 05B34134CF3
X-Rspamd-Action: no action

This patch series addresses issues observed when sending NULL
packets to probe stations.
---
v2:
 - Modified commit message
 - Refactored the patches according to Johannes's comments
---

Suraj P Kizhakkethil (2):
  wifi: mac80211: set band information only for non-MLD when probing
    stations using NULL frame
  wifi: mac80211: Set link ID for NULL packets sent to probe stations

 net/mac80211/cfg.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)


base-commit: 333225e1e9ead7b06e5363389403bdac72ba3046
-- 
2.34.1


