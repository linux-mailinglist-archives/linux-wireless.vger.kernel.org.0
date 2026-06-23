Return-Path: <linux-wireless+bounces-37997-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xuolKkorOmrq3AcAu9opvQ
	(envelope-from <linux-wireless+bounces-37997-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:44:26 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F17506B49F9
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 08:44:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=VcOlb0m+;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=BGS8gelN;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37997-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37997-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83E853037D5A
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2026 06:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E544E344DB9;
	Tue, 23 Jun 2026 06:44:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1253331EB5
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:44:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782197056; cv=none; b=b9pP5cRzyEdqXoFJDcWlxkNJ0djz1Q70Jbn4eD9132gvLFX+FBrQ7NfXKwBN8cOmmouke9I9XdvZIvmeQyrLKBW3b5QKLZ8xvdPqzyS/tP2jitamWs8w8XD5mpcd19YO24i+Wd7bFHAZ7/QIlzt7GRdDjc4tTiR04ScSFQoSN7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782197056; c=relaxed/simple;
	bh=v+Fo0gE/abAUkjNz766ndxI6seXCabhPpjOiZsZtwJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kxw59ywHgAcWPLkQEbe/Rdi8/kHLn2iRiOcXO9NpTPX4/VU6Jy316lYp9ySQVnDMcAAYjrxeEVp4ObMP7bX66nxW5l7XjXRZDbB8ryPpKgYW/bZ4CpR/IdwSr23APuGq+bjuMLdVTYVi/okXH2ikzdUVHG71GeN9x2zI+VSeurk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VcOlb0m+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BGS8gelN; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65N6clw31628501
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:44:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=uWG8ZbRoFu7VygoYFMNL7hhT7TFlyehiv+P
	+4V+rcck=; b=VcOlb0m+4HNUn9JrnDbMZY0DH7pABHAWGzOpsxnfnNr6HQ66g1r
	s2HQ1Rm+KfB0WUqJRUAxHC/RwQDqHjEEEaDutLxv2BCLnR9GihG2dB1zlymxV8yB
	EZVV6DCz68SFzLaWtfx7oVoQ/UH7cV10OCnX8V3skMaiu5//XCsYnbjXlgU2G8dY
	osdGDWJAJ1/Px5fxzvuhw0AGaEfD4Ea4ksdF8hTiVgX9QjNHkB5FYG63MVFrjFSH
	GMjujNZhRv975O+kKB642V77Q9VHbCySqfk/8umTdh4CqGd9CvGjuwZ/WexuouNf
	d6ioxYZfBVX9P/F9STqrrxmbbbCKDopzKeA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhuyh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 23 Jun 2026 06:44:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c890bac374eso6534005a12.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Jun 2026 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782197054; x=1782801854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uWG8ZbRoFu7VygoYFMNL7hhT7TFlyehiv+P+4V+rcck=;
        b=BGS8gelNdKYVL2I+MvMaER0yllHYcq42TO3T2bIrfZwxcjx+RI8eYD5fXU8Df61uKt
         s5d4rG7iiusKg3vNcORbJqxdO8X1xXcHg5QxRxQzm3E9Ahk/osvry94gWyd4U5A0DGm6
         Sa7y1Ap4VCt6RE74C3/2Egw+LGDgTu2FEWFF8plorvjicsMPKvpJ1kcXn6dyKXwf2/Fu
         AzRZapWkyvtevJSAIzdQVNh5etnkOGAzQONJD0L1vNR1V7suDEuK59Eqd38YzWjTCCXT
         oWPrDlgQx7gPD2vVCip+IvCoS4ptXPjfM6oBQN0tbRw+Jc7mbAvb0eo5mRhFw9tTRYck
         tuHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782197054; x=1782801854;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uWG8ZbRoFu7VygoYFMNL7hhT7TFlyehiv+P+4V+rcck=;
        b=poKXtkNqdyA3BEgnLhZ2FBDhhgmIysYYClkdbo4OINFzqZ22U1J8ogoxjGZ5wYEw3K
         eaw/DFc9K6pFMJELDC15jP/dw0fI+IRY0f3PoxzaRqlx43z11nMq2LMKNtZ0r0FTrrWk
         6hGz1XG+f2hvgB2y+ank6SAX1ZhE6J3w9/lEZzZ6IEaWgifwrwceBe9Jn+ew3bH5xmwg
         FxBaB7scXtzgr2OqczLboBDs8U6hJFta3705o/EupaXYUMdaXm4rf+UNavhtMfNNBPzi
         bjxTJ22eUcMbWEyCpT71m0Jieer9YdhWG/nyL/CGpAC4hQFvuwmiHEHBSttIyK4yt35B
         uAaQ==
X-Gm-Message-State: AOJu0YxACb7PYQ2+gNyuUXynzeToYObK/sNWysifEzEmPLepVSeVnIri
	sktuf7hhYA4ARgTgfQsa6WTA332mYbh6lRd9fPK5QVGmzJq3IiAqUwg0DGud9t0EKrcL+BY0/lz
	s/sQOWemKH00WZhJm3RcB/arIrAhyiBuOgR/tXfCRaClvmfLiYmSCOLOLUFp5VLmvGh5C6NVo3O
	bBow==
X-Gm-Gg: AfdE7cmEmsELh/KftT0LwtUtD8izEo+5qAJSJlc8FW9ShaJHvBetKyjJ1zY3db/p019
	7zI8wrS5eFfKrkfTueXjeetuTGA3tIPE/aGjxZDlLEewuXFIsS+bSEnuxuMQDeuFWtNjw+wCYJa
	n9G2zHBvSsGoqasz5AHBBXbZT96znLnRknyQCkN9eK6TDUJo+jB7Wh12ZrTZaZggnTbj/BaZ26D
	7QspmoL1I4w8OD8BEzBw0n1eTu1ZdrFFQsb69gE2GGx7AypcJuGKTihvjcng8sUwoUChgJb29em
	hRUdURiBLAzO1RElKjT/81zzyG76L2xg7lDfVQ962952EowKM5U8SYk5yA1dlv6Z3H+qC1n5Jiv
	A1RkVID13Hrdv9XThhwwrDUIpPWJrJUvL3gOOIpKEqoJZjB7wrQ98IA==
X-Received: by 2002:a17:903:4410:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2c7c9a06132mr12864645ad.24.1782197054147;
        Mon, 22 Jun 2026 23:44:14 -0700 (PDT)
X-Received: by 2002:a17:903:4410:b0:2bf:281f:19ec with SMTP id d9443c01a7336-2c7c9a06132mr12864065ad.24.1782197053572;
        Mon, 22 Jun 2026 23:44:13 -0700 (PDT)
Received: from hu-mpubbise-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af220sm94346315ad.16.2026.06.22.23.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 23:44:12 -0700 (PDT)
From: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
To: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Subject: [PATCH ath-next] wifi: ath10k: fix skb leak on incomplete msdu during rx pop
Date: Tue, 23 Jun 2026 12:13:55 +0530
Message-Id: <20260623064355.1876743-1-manikanta.pubbisetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX8p1vh0mVJgfv
 qz1Zlb/o3Q1I0SBwkb7d8uA7KRfm5XjGFKIDunRGK6s9E+9u9C4uSFHxSlLturyxuMQWqsIDfyv
 KKHMeO2dNUSNHEj6OyuemWSKc58wD50=
X-Proofpoint-ORIG-GUID: V8BPl7CZlfOtiFKAaqKmIDRWhdtSYo3N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA1MSBTYWx0ZWRfX2PkKp/eHWbgw
 7z+Xt7XBq4lkZz7a50GfujdMOdkEQUUA3mh7jcjNhnPQd2XvHYE6v+73BL2spsGlLSCIPDjyH5P
 VdACjuq7dMl7zx9StiRf6dAh07fw9uR50WsoF7mnvaKzSOCy9BiMH+e3n7wjdQ9An0jzlG5GWsn
 eW1CQd4X0ONfWV0ycX1uWO4esv/wAtZei7l1QhvZgbooBUBxrKnnmm47/FZkATg+CR01ZjVTfPD
 pTKfbb0unIswnIRsbURBExFy8I65aIP4RBBc7JqcB4mQxegG3TieJTZv71AQeFOMDnZ+v4/Ov0u
 kWSFkNLjhwoxl8kaKR3WL8kHcA4gzpraoovb1mGBYIsuzHfCYfZ+uysCwskE9Fjga69+t+Ap4qO
 ygLYM5f0nVmWQXdhFeBDgqi1HLqGGX1io5xXT7dwLehNqzjs7Ccl18EcPCLxsokTUwFhcxhSaRQ
 pq1VALrkB03cGFbOfOQ==
X-Proofpoint-GUID: V8BPl7CZlfOtiFKAaqKmIDRWhdtSYo3N
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a3a2b3e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=-FVftbl86dZ79iKRIzUA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606230051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37997-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath10k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:manikanta.pubbisetty@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manikanta.pubbisetty@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manikanta.pubbisetty@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F17506B49F9

When ath10k_htt_rx_pop_paddr32_list() or
ath10k_htt_rx_pop_paddr64_list() encounters an incomplete frame
(RX_ATTENTION_FLAGS_MSDU_DONE not set), it returns -EIO without
purging the skb list built up so far, leaking any skbs already
queued in the list.

Other early-exit paths within these same functions already call
__skb_queue_purge() before returning an error. Add it before the
-EIO return as well to be consistent and prevent the leak.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1

Fixes: c545070e404b ("ath10k: implement rx reorder support")
Fixes: 3b0b55b19d1d ("ath10k: Add support for 64 bit HTT in-order indication msg")
Signed-off-by: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index faac359aa9ac..b3f1b7186721 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -706,6 +706,7 @@ static int ath10k_htt_rx_pop_paddr32_list(struct ath10k_htt *htt,
 			if (!(__le32_to_cpu(rxd_attention->flags) &
 			      RX_ATTENTION_FLAGS_MSDU_DONE)) {
 				ath10k_warn(htt->ar, "tried to pop an incomplete frame, oops!\n");
+				__skb_queue_purge(list);
 				return -EIO;
 			}
 		}
@@ -770,6 +771,7 @@ static int ath10k_htt_rx_pop_paddr64_list(struct ath10k_htt *htt,
 			if (!(__le32_to_cpu(rxd_attention->flags) &
 			      RX_ATTENTION_FLAGS_MSDU_DONE)) {
 				ath10k_warn(htt->ar, "tried to pop an incomplete frame, oops!\n");
+				__skb_queue_purge(list);
 				return -EIO;
 			}
 		}

base-commit: 972c4dd19cb92e03d75b66c426cfade07582a1ba
-- 
2.34.1


