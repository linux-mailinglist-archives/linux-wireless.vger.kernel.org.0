Return-Path: <linux-wireless+bounces-31682-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKZ4L4mhimniMQAAu9opvQ
	(envelope-from <linux-wireless+bounces-31682-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:10:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25860116AEF
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 04:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E4E830067BE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Feb 2026 03:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179252D879B;
	Tue, 10 Feb 2026 03:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojQTTvcU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f9FVZisZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08D7288513
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770692872; cv=none; b=btTAjg8W+YvHBPnu9vm47SBCchgSBe8aYhbUUuqCyfFiHQ/+kWeybHRaR+CHqwJrDuaffclTyFenOb0NMbcWHGdtOoSWnEXeO2InJ3OE29EgXkijteaJbd5LNKTStu5uTHvYlbhG4aFuT1bc1Rx5oBiQf7oVQGaUH4TnZ1fEo+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770692872; c=relaxed/simple;
	bh=mx/ZMY1qwnveDYFCMTbdwj1wQ9/r/kOCs5MsMKnH77k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KRFcZAgHw5cnfE2iUFUd/ELSy20uogdwdKmCNsnaPE42n2iaPEexPgn+VCVT6Z/MiUjpMUdPZoHBecuEioj1C/glRtPna5FOzTuxJteEq9/e6XkGjx3TYLpR6AWO+n7o662A74lksk2VNj3kc4CRl3c1JpNyPj14npTfHmgsYQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojQTTvcU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f9FVZisZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 619MUbHc857095
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ExK72ja4yh8yu/tb5MMW3I
	lYKu3JA+KhCd2SUHccSVA=; b=ojQTTvcUeSzQRAsgLEo5wauOkglUIdH/tPftqe
	as70mtAp7wMEKbYDZ50JEpcjacbGtvX4w2ayZTMWd3Mfhb4lW5bIiXbJKHL1GLh7
	CR4Qd1KpwI/+Rjh1gYmNHoUym9hoyo37088WsO1JpcVL5+7dcI5NBmTBW2wlgAz8
	i9qAwZeabCKsBQFTE4ZpstC/pAOQJ6iPD1kTzPLb2DV4r9h6d/l6LFkscGne3HdJ
	j/gG80qWg2hfqUa7fs9eHykUb3RuyrIN9mklnc7PMr/AqEb4ePlOj1HOCZUN2m1c
	3hQdBLTw2NVxuy99EDmN5n93Pob+LmqnpyVkNVbvbsrZ5VAw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c7ga62gjn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Feb 2026 03:07:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3562bdba6f7so6206441a91.2
        for <linux-wireless@vger.kernel.org>; Mon, 09 Feb 2026 19:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770692869; x=1771297669; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ExK72ja4yh8yu/tb5MMW3IlYKu3JA+KhCd2SUHccSVA=;
        b=f9FVZisZ2irUk5mFLpmrvUCQfa5CWgu1E+O5+MiaKzICUvXtK1cCkdEFQ0eEavPeLC
         8hlTTmQGbOgVlL3ocEDp31Td1p+aKkID1DfAWrR4W+qmhKLzo5hKUtEQdGdhy6nq2nEg
         Wn5N+/VvI7GHJZej7H6bNgJa5mYSjLbuh5DzRkEdTf6C6AdeR8oirkpqZEt7MekoJOQP
         1fjdQrDMyaIjcZROpxlD/TDnoKchxKr/tZ+J5NvLKrbXOSFdic4oM1zXY2Ny6XixU21j
         4rgm3byvU8CAG0zfoYMSFmn7XMXINb7pMjM5EHN89zhBWVF0r7EaxwcIjK5hAAa/A8gx
         VgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770692869; x=1771297669;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExK72ja4yh8yu/tb5MMW3IlYKu3JA+KhCd2SUHccSVA=;
        b=I5H1kBTyINx/LLrM0RtxMzJby3C0J77577QHFAtRBy6XqSovfrrgwOA08X2DmYJIWx
         ITmobEFFVFPCwkF6lKwn1YbMAHAcVeqjpqGICadowjfxQpc17U+wU+8ew6O8YPrX+1Px
         mbkB09m84ZduBnCKC0UABiE/dSnp7dcoiYxUIA1gxKrxUzhLydAahMHSNMxxL2OF3ZCw
         C8uz1DkjzuBmFMqCWxfFYUn8C63tUbnyUNLQ3Z1dYYHuUgYYp0jJU2X4ai42EIjbAKwB
         ha9HRXlon1s68JWHclds+FhfrngcFCfVS8rB0MHQ7N7DHnwFxVPJbnw5HlLZOMBRFTCp
         eAbw==
X-Gm-Message-State: AOJu0YzeiUdV9rrF5uUhAQrfmIUz+Aa3L4cca7/BBcLRq+M67KDhlO8b
	BGP9XVt7pH593WSWHNPms9TJSqhund2ThtEp4BD1EiVM2yLfa+BJpJMAdG4GWoZqrXflr7x4QzE
	iKQyqnaqDVzYvEtFLQe9yKMAMy+kfRIc/Vp/IORmESzkOc9RWW2zg2crdU1XRztQmd7FTQQ==
X-Gm-Gg: AZuq6aIsxMA8pvorfWy6GkSdXjLQB0AoDPd9TJVZ/Eoo9cGr0AZki67c0ROicVoQygJ
	srMjeUuDNvhl5zCnSBQuy691hVHtuhMWB3uc0H39rjuD4W7l1tPnXs/usY/+FxT4a2kBBobCGFF
	Xnxq0yR+ZY1TMGWXZFXJ5WCziahckQQILhmhFzsn6GyGK0cxGeIx380beOm1ufNLatfEk8bGiLj
	GTZ3w97KZLTg6G/vchm85DaVpOfeX88VOgpVjikvEMpA1I6oq8UfyjJ0PhdGUWoUVxc98bN52WE
	8alUcw/M2XPca5C7rbi4UcpVCJCPLNS1kGE4Nw9oCHaCV78+7DpZYnYUrFFNNciEhcPZU0d6rY9
	50G8U0M/gyHU3QMCj0WyScBCDzmRGdxPEKafuLRsg/6njOyOGaFRgOuSNooLOEby7KnLO22hrpw
	8=
X-Received: by 2002:a17:90b:4e90:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35667d522c9mr652715a91.23.1770692869375;
        Mon, 09 Feb 2026 19:07:49 -0800 (PST)
X-Received: by 2002:a17:90b:4e90:b0:356:2c7b:c026 with SMTP id 98e67ed59e1d1-35667d522c9mr652695a91.23.1770692868950;
        Mon, 09 Feb 2026 19:07:48 -0800 (PST)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354b30f899csm5180790a91.3.2026.02.09.19.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 19:07:48 -0800 (PST)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Tue, 10 Feb 2026 11:07:31 +0800
Subject: [PATCH ath-current] wifi: ath12k: prepare REO update element only
 for primary link
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260210-ath12k-rxtid-double-free-v1-1-8b523fb2886d@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPKgimkC/4WNTQ6CMBCFr0Jm7ZBOkaa68h6GBbSDNCLVthAM4
 e42XMDNS768vw0iB8cRrsUGgRcXnZ8y0KkAM7TTg9HZzCCFVIKkxjYNJJ8Y1uQsWj93I2MfmFH
 qCwnRdTWpCnL9Hbh36zF9h9xCM4fAU4Imm4OLyYfvcbvQEfn/sBASaqOsrelc9VrdfIzlZ25H4
 1+vMgs0+77/ACqBclfUAAAA
X-Change-ID: 20260128-ath12k-rxtid-double-free-289100bb5163
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: XsSj4CKImoLmD6hrQr15Y1QX0lzSd0eQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAyNCBTYWx0ZWRfXwaoxdEHlKt2l
 m09CYtMVTpXz97d+uSJRBS2xaqArw0yald3T5lrVTQFd2JEcN6XTsINwrPtvHimaNKl5Fm5E0j+
 mImlueY/zchm/xNA12GepHDBrHh+4GYhbMGU/CSe25k0XYI6LU0Lf/8ghHMhzTJklqLVbIELYWq
 7WHTEkViv9tRhhCTrFYnSak8IId3tqDKZA6C4movlLuKU4QTBbii7IgdWAg33ILrZt+5ChD/ScM
 sn6Vj2GiKZ2d1JXl3dgpBfhvDjcK9AdzJQtw6f7/QuIJfL6RA1eV1+q0nMBCqhG8WjrC5Aj5oQD
 gE/mvvS+hhMfPe5A/T8Hu0jLJIiFlLymQ/ze6kNLFb3nT8KaPRQEZ5EOXmQvReqF/zirb0ghuwy
 6r6yBky8FgfmQ1mFQwsnLmVj2yYV45UNNgprCAgljHDf+QPPUKGs7SB1+wALx5Lt22VwkXsNgNq
 hhQy+UQci7hqPbBcAvw==
X-Authority-Analysis: v=2.4 cv=WK1yn3sR c=1 sm=1 tr=0 ts=698aa106 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Z60ED8iFgELaZGRuqMgA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: XsSj4CKImoLmD6hrQr15Y1QX0lzSd0eQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 suspectscore=0 adultscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602100024
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31682-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 25860116AEF
X-Rspamd-Action: no action

Commit [1] introduces dp->reo_cmd_update_rx_queue_list for the purpose
of tracking all pending REO queue flush commands. The helper
ath12k_dp_prepare_reo_update_elem() allocates an element and populates
it with REO queue information, then add it to the list. The element would
be helpful during clean up stage to finally unmap/free the corresponding
REO queue buffer.

In MLO scenarios with more than one links, for non dp_primary_link_only
chips like WCN7850, that helper is called for each link peer. This
results in multiple elements added to the list but all of them pointing
to the same REO queue buffer. Consequently the same buffer gets
unmap/freed multiple times:

BUG kmalloc-2k (Tainted: G    B   W  O       ): Object already free
-----------------------------------------------------------------------------
Allocated in ath12k_wifi7_dp_rx_assign_reoq+0xce/0x280 [ath12k_wifi7] age=7436 cpu=10 pid=16130
 __kmalloc_noprof
 ath12k_wifi7_dp_rx_assign_reoq
 ath12k_dp_rx_peer_tid_setup
 ath12k_dp_peer_setup
 ath12k_mac_station_add
 ath12k_mac_op_sta_state
 [...]
Freed in ath12k_dp_rx_tid_cleanup.part.0+0x25/0x40 [ath12k] age=1 cpu=27 pid=16137
 kfree
 ath12k_dp_rx_tid_cleanup.part.0
 ath12k_dp_rx_reo_cmd_list_cleanup
 ath12k_dp_cmn_device_deinit
 ath12k_core_stop
 ath12k_core_hw_group_cleanup
 ath12k_pci_remove

Fix this by allowing list addition for primary link only. Note
dp_primary_link_only chips like QCN9274 are not affected by this change,
because that's what they were doing in the first place.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Fixes: 3bf2e57e7d6c ("wifi: ath12k: Add Retry Mechanism for REO RX Queue Update Failures") # [1]
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221011
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/dp_rx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/dp_rx.c b/drivers/net/wireless/ath/ath12k/dp_rx.c
index a32ee9f8061a..6995de7761df 100644
--- a/drivers/net/wireless/ath/ath12k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath12k/dp_rx.c
@@ -565,6 +565,9 @@ static int ath12k_dp_prepare_reo_update_elem(struct ath12k_dp *dp,
 
 	lockdep_assert_held(&dp->dp_lock);
 
+	if (!peer->primary_link)
+		return 0;
+
 	elem = kzalloc(sizeof(*elem), GFP_ATOMIC);
 	if (!elem)
 		return -ENOMEM;

---
base-commit: d9a2be2d72d4f9035f0334e0ff49180fe9df6e52
change-id: 20260128-ath12k-rxtid-double-free-289100bb5163

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


