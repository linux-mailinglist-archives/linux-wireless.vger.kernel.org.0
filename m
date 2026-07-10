Return-Path: <linux-wireless+bounces-38842-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 021eKq2LUGqL1AIAu9opvQ
	(envelope-from <linux-wireless+bounces-38842-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 08:05:33 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AB3737837
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 08:05:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=p7pHLujK;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=K2pyy7je;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38842-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38842-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8A176300AD8C
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 06:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895983254A2;
	Fri, 10 Jul 2026 06:04:25 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA3E157487
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783663465; cv=none; b=gXxrZ5zZkAwXTObfmN5LzCr5gEFpC1nF0XYoBL4sbRS/Y99G9ox9AUPWTnlQjpZRrdeVvbUHnswC1tKu/BGGGUBeUWpWSf3KpUpP7VxfMleKEQEKcLvGcXD7z0v2ZtKDyo5TpgVZBJgNp9rwleLMOQy67zZAvFJ+TD7TJ8KdhfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783663465; c=relaxed/simple;
	bh=mbdoOaz9dwCI2p4lQz5yQ7LTvLx3ZoKnmbsqHmMhMdE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=onWXz4sz5cpRYKmQql4M3yCGwumS1fZTidyuY3gCGlGr8MZKuLCZ7kYpA9e8b9Y4JALg6ctPkEe3Vx801iTFLNdwXMr7yYi8v8SC9eGJfY00G+/6g3xuoQ9A4LfApGxNdbHLZWo6tyltVTiquslp5KIUCp9K+JDo4RMlmK8DSvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=p7pHLujK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K2pyy7je; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3nUxt3848876
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:04:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=9uUV/YqHY6aTj5CwU76uhCPjiAtkkIfxuP0
	cyyMZptk=; b=p7pHLujKwUI5evmuhSbR4ut4qeL6/70zKU5UsNzG0rgO3oKDvIp
	wupKrpnTzHmp8IKWcb1gt4UH0SCOzrOUM3u5wweENK4NTtQ+LR2WxdGbF4nJGl3D
	66LB7nibsMtRNnnwbrBwiEbxY+LbdGotuaX7a6uSQIALG16mQexC2HNPtUf8qEJ1
	rfz70FTvcaTkxsUKwPQA7JiPr0czOUPrq57VfAJ2RC40RPQ1G1uKyYic5BLAzAEE
	peah7cNBGRU4oAxXnMj82GOnEwVqigOFJudEmum4FdiF4Kwpjbae4IbcdrBOwvfc
	+Qy9VS2drX1taELqN/akHpJrUbmdMiSFDZA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu02h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 10 Jul 2026 06:04:22 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8952346bb9so445333a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 09 Jul 2026 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783663462; x=1784268262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uUV/YqHY6aTj5CwU76uhCPjiAtkkIfxuP0cyyMZptk=;
        b=K2pyy7jeTw7V1ba6qoeMq+mENHEvfcF38GNIxFkmIssN1HrHY6hBGoLAzbI3DJtFkm
         IEtqHKEOHMXY9I8ZDCvpJgSu8I5SkqrLx+yvwDfGW0DV58R/1gk2yrTG/OiEYfRYTUhI
         VQybXtdFfhbdGuA3bvP9O106cfxTzViuHrmMGpMdJCWh6JR++68fonyoZtu36nK2qlMt
         VmYTRXXXJNDP+sDCx9QBgiu0SOBy41O2MaQPvShnTEufAohwqqUTu1uju8gjY1J08+A7
         fCe7Vb1sjQHRUJnWlc+nc+bO0jZdDoJq7DUDbMfUie3x27H5g5UwN5yqq62FwYFviuOg
         zyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783663462; x=1784268262;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uUV/YqHY6aTj5CwU76uhCPjiAtkkIfxuP0cyyMZptk=;
        b=MrObojb3ciq2bm2WHY9fSt63Bn6qfzi/SrRzTLyjmHm8frYTUTL2++JHDjdHqhNeq2
         2JRvq9Dx+pXJxvb1lq9ahwBF1bXa4JBN3XOisnC0LH5r7gNxExJ6SNejNSbAdbNc4eKg
         awZsjMPIWqKQkHbg+0ygMf8Qek38FZMyYMoCNdJItZ6xSbLhFb0RDiJ6NHaBDZ8LAhz3
         LM6IWMai95QllxOCrbVgBiQ+zzuUpQ2l47v1fwDb1Pps3KOZamyFvqny7su0RqudIa6m
         iWcxeAuqdL9QJkJKYjvR5x3ol7iJlhbIFvTQBmoCqOWSoFW38MxVD7/tXxYJ5xXYCEus
         cgiw==
X-Gm-Message-State: AOJu0Yz2+7xhC3HWmIXa/e2dxPcIeUbzQA0OISAQXlhupM90a5aAasuW
	XvrcjqT8R9K+WmG5xOeLFFmEaNVtyIPUUlYuMewCcnL/RJ7YWtIpyYVx5ilBxfObqsUQJQ2QoIO
	wFK1sVWiIC2OmtXore6dLuQxpvCNls58fkci8IA9MH8wt0490GCyNwVM8tOzhEJQJiW5H+g==
X-Gm-Gg: AfdE7cmxt9YJJA1O3MszlSYP9KZOPM9M7ICbeP3noZtqh3obkz1cdWqxudPN0POWD2J
	VRiONv9E3n6ry3hZQJ5gG2u4nFA+gB1JcVOmQgSiVKYNhS5y/jJIBdlIeiC+nNsjn9Gb2WxhXBx
	1FPuMjXfn+nCh79ekQUyegwV8pK+WdKA90fGN6gtSm80jNX1rZJamKxnewEBlI124lnblKGvsUb
	Rn+FnAcFS9ZOp9tu2sL6dnbd6mzraG/M56CGB5q5gnxPf0P8qM7jVv8mxnMOyrjih65ubZnyEXh
	rirHTWkqC7zZvzGXV81FDJ49b0/msX1xqFuQQeQ6Vo90TWot91HW6DL5RbbkixbGcxJn+3M28GJ
	T35CdhvOtqtz/JpxuCUgbS8Wlq0ELVdrGxflChc5gCzZKyToTr0NQew==
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr12245454637.3.1783663461745;
        Thu, 09 Jul 2026 23:04:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr12245404637.3.1783663461222;
        Thu, 09 Jul 2026 23:04:21 -0700 (PDT)
Received: from hu-mpubbise-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b6593c9a1sm44154084c88.2.2026.07.09.23.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 23:04:20 -0700 (PDT)
From: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
To: ath10k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
Subject: [ath-next] wifi: ath10k: trigger hardware recovery upon rx failures
Date: Fri, 10 Jul 2026 11:34:06 +0530
Message-Id: <20260710060406.3323260-1-manikanta.pubbisetty@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 5X1QJhQVDe8KkUm3eJacDzM-y-fcezvg
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a508b66 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=uMDX15y2VdP6m-bf9tEA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1NSBTYWx0ZWRfXzm0P+FKjfUwE
 K9MhOopfY3LzVQZN0vACU8Aa4WLXcoUIssy2Ezc06PN7G2YIBqMCny1RMl9QE67QC854x/eDCrO
 E3ISBYMqs/5/Gjim/bo6y16n5Bu3eh4=
X-Proofpoint-ORIG-GUID: 5X1QJhQVDe8KkUm3eJacDzM-y-fcezvg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1NSBTYWx0ZWRfX1d+/PGfP02fj
 opcAn8D516qAldVtPTKTYxy6g/hjMcW3g/Tv0u13BIzvqHxPrvpRjR6QSKWKiFGOR5sq2ZMfJJ4
 TQw5LdzxJ3QjHsPIgoxGKfpTKxqPMUnXgduBkQ3yaeqGSFm8egYevBuQRvA4x4WjnFMP6bE8LoC
 sxiZDfwfDb9BASyXxVdo7oU1iYO/k6fJcoKfFRi5e+avuU1eTtAg5tniuVVuYdHu1e17/G5zVvb
 SEPcFtIw5sxPa9ZoGdrDlemHLItoyu3x4vVSILUHjzFW/+447d4kyisA5c7sWaoq09g4UiMHhgX
 D9DxLNzO4YRQO8VS/JdJgVFQPQKmgftFEsPR49WUA6glsAdyPpoEpKfa5/GAe5+eapOiXkGfZWr
 yhkS7p7p7FzteZdRPGWAjF7dw7djE6jxqTh3osg1/mJT6+DSsq/5Pc5Cj7clxjXEvoWYZ4Hb0nP
 NgcSWOA5YEu6hvy9Pmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100055
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38842-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ath10k@lists.infradead.org,m:linux-wireless@vger.kernel.org,m:manikanta.pubbisetty@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manikanta.pubbisetty@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manikanta.pubbisetty@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A4AB3737837

When an error occurs during RX packet processing (e.g., MSDU done
failure), the driver sets rx_confused and drops all subsequent RX
packets until a Wi-Fi ON/OFF cycle clears the flag. This can leave
the device in a bad state where it cannot process RX data traffic.

Instead of leaving the device in such a state, trigger hardware
recovery so that such an error state can be reset and the device
can function again normally.

Tested-on: WCN3990 hw1.0 WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
Tested-on: QCA6174 hw3.2 PCI WLAN.RM.4.4.1-00288-QCARMSWPZ-1
Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00189

Signed-off-by: Manikanta Pubbisetty <manikanta.pubbisetty@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/htt_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
index faac359aa9ac..1005daaaf158 100644
--- a/drivers/net/wireless/ath/ath10k/htt_rx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_rx.c
@@ -2343,10 +2343,8 @@ static int ath10k_htt_rx_handle_amsdu(struct ath10k_htt *htt)
 	if (ret < 0) {
 		ath10k_warn(ar, "rx ring became corrupted: %d\n", ret);
 		__skb_queue_purge(&amsdu);
-		/* FIXME: It's probably a good idea to reboot the
-		 * device instead of leaving it inoperable.
-		 */
 		htt->rx_confused = true;
+		ath10k_core_start_recovery(ar);
 		return ret;
 	}
 
@@ -3311,6 +3309,7 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 	if (ret < 0) {
 		ath10k_warn(ar, "failed to pop paddr list: %d\n", ret);
 		htt->rx_confused = true;
+		ath10k_core_start_recovery(ar);
 		return -EIO;
 	}
 
@@ -3344,6 +3343,7 @@ static int ath10k_htt_rx_in_ord_ind(struct ath10k *ar, struct sk_buff *skb)
 			ath10k_warn(ar, "failed to extract amsdu: %d\n", ret);
 			htt->rx_confused = true;
 			__skb_queue_purge(&list);
+			ath10k_core_start_recovery(ar);
 			return -EIO;
 		}
 	}

base-commit: 913998f903fb1432c0046c33003db38a9e8bedb1
-- 
2.34.1


