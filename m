Return-Path: <linux-wireless+bounces-38881-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5cx6Ddt4UmoGQQMAu9opvQ
	(envelope-from <linux-wireless+bounces-38881-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 19:09:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 991B6742565
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 19:09:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=BeZ5VluD;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=hZF68sDO;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38881-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38881-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 957953010ED8
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jul 2026 17:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEC33F59C;
	Sat, 11 Jul 2026 17:09:43 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8BE2989B5
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:09:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783789783; cv=none; b=cWf7/kGl0jW9wdkUsvh8lxxVJvXy2KWO8GtFbYmfmu7I9BRuO2QYw0Yv06i/7odEOIKs+o6BQhd3lv/TLb1zY4LkHfOesdQDpCs35GQ+wSMPILsOH7AcAFCUMuuQFh+Qo+iBdeCWICw4ZLDR5Kz/c/MpOM1XL5sxY92WGnNfCqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783789783; c=relaxed/simple;
	bh=cszv68Y52Jg1PsXFT2+De5hkRtRf/Rhr1q2X/HFkBj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KV3F785UMDl/XIMvvIhwr7I6WXSWWKoCVny0KFqN9AwmYEyBGWAsdl2bIIVoaM5H2+CWwccL3NCmvrNLPr0Yug0lWbCIo6N37DgtoUTGBvv7SPtmuw9DrYITpUBguPct8ItV8TVeXwfqRvXo1+0jEmHG0jpcjK9z0cu+kXMv6oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BeZ5VluD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hZF68sDO; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66BEOGkN4051836
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kyE9tVfbp56dU4Bi0JwnUg
	jE3A6bepO4L+0nMk6KWiE=; b=BeZ5VluDS4ThpqTDyjmoZPScoCDXvyB5RanXQz
	EUUTSC+khQDCqKMii1pxfJDuHqJqQDXLPNM1Bz7rmIm9uBQ+cHoLi7w/R2gMwafW
	heOid6yUiqKPSdMSTCWKkltGRskrzsf1PboaxeRhStEvfPYpu27gQAwQBzsIj3By
	XPZI/RMbwQVuMpOlR0hhf5rKOyk/5C9V1Vk/rMQ2CU+0rZ1fjeq+AOooMULae44n
	PdSG/BdoKC4gsc9x5dpOKmYW6qvHenD4j0dWS3DgRd8ITrk9e6ywJU51wjj5JxFX
	25DIH6aSkCHdwwnqd4LdoknBWYq/uh4Rb5n2fZdIBgzWr4yw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeams965-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 17:09:41 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c889d1eebafso1788969a12.0
        for <linux-wireless@vger.kernel.org>; Sat, 11 Jul 2026 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783789780; x=1784394580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kyE9tVfbp56dU4Bi0JwnUgjE3A6bepO4L+0nMk6KWiE=;
        b=hZF68sDOVLl3RtiptMnG8vuAz6kWP3XXHfwqqJa9k7yD6RwtKkl5TuM9nj0XU4paFi
         35wP6ZyTlXefKMWjv5HEibaS6baUsKlBm4VOwO+NBb7nuALlG3vE/R8NmRn4OYlL7SQC
         p5aX1h4Rq6eljKRP5EnVZ/ed2xB7C4B/TCNb1rb+++siLl9+kDABMsLKpIK2ObVF/2Lg
         Fc2cQJRxdTSgXo8+nlii8XVjFQ+DE84YMNrXr6UoQDcy2j/rTHOi2ttHKP4FNkCAUUsp
         l5o/YyKSiNFRnmHM1NWx1Xi0zDQC9V1q+zI7bYiGvRN5Jb5REkw1vzufYV4m1CLfXMYZ
         rnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783789780; x=1784394580;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kyE9tVfbp56dU4Bi0JwnUgjE3A6bepO4L+0nMk6KWiE=;
        b=KRk7K3nkZdRpdCS7ZsKIWYr32cr13P9Whxxwfvpmqdgu8zT1iJjWrqRdc+wFaUln+w
         6+NDmlrFUmgfznraZCTcXUQboncZgEpQvGrHLPVru2a6QGVKDt5K+V9rX5qZ505E58tG
         hTvsKrYHQ/dmMcMjKy/HNjZfetCoUV+JGe+cKbDtvTewb5RFYHsAr/CShhLHAhZ2lmRr
         krSDXPhEeqoc2/4bGfk2kwc0AvjoI4Y0vhAX9zhcQ5kpOTvnFBIOFHw4Eg3XRH1dUElR
         g3tXGgelOheh2V99MIO00it4zic7tu8/Gr0kXEeK0zgRAA5C2gF82z/zTx9ucNM6EvBr
         x9cw==
X-Gm-Message-State: AOJu0YwdKi0ckqNhUzM7SmRmaRDiMhACKC39iVVIHWljfMCtFIa/N2ks
	zRXhMvNmruKbeMme+FX+d8hsHCTwfh8iRXQ69UQIbwGmgozuAQ+vRl/OKnNmWKeR8fvZn793fzs
	L7sK0W5Z1LOTtT1i0d5Jyi53E3zqJ+GC0zFRC0me/BVJEsA+srOj/nvTBQGi9sV1pM59t/Lyg1I
	iIyQ==
X-Gm-Gg: AfdE7cmOxof61nZYcMihk3JDCIUY7uWUpcwjGF9iTyHUPeCXYbX5hj2Cjoz3zsHla6q
	IR/kazYHV0ljI4FCyE5TmuCSFW2akjxFlKoiWk41g92ePC8PtNm1wlntZFgaS+T4Ap/matqFyMY
	mYupfoKrBnsNln16L8OEhxuJdf2frNQl697+eRnNo7J1Vd0dQBRmEcI2WWr4PoA3gu9ujk20vnm
	hvW6S3P8xvz7rwrBFDMS/RhbwGaZL0ReBD9/yfFNOyeY7hQfFturmjAIjFHf3bDQmAziv5tDKiE
	GvO2lq48Hi+ixQkVUzcdkY03q/2PyIZwzk8MwMFGt4mOa6yFetLLmVLELIp0woV41ik6T+DT7FX
	1kCBxvCTAfz4zs/wE866squ4cJq5kH+RxYZMVE/g74WIEYgQZ/j/RVsBSfFNFPXxiwQ==
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38dc779ac27mr3590769a91.43.1783789780166;
        Sat, 11 Jul 2026 10:09:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4c89:b0:387:e0db:3fb2 with SMTP id 98e67ed59e1d1-38dc779ac27mr3590759a91.43.1783789779729;
        Sat, 11 Jul 2026 10:09:39 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311950eb930sm34998890eec.8.2026.07.11.10.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 10:09:38 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 10:09:37 -0700
Subject: [PATCH ath-current] wifi: ath6kl: avoid buffer overread in
 ath6kl_wmi_scan_complete_rx()
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-ath6kl_wmi_scan_complete_rx-v1-1-7b11e5f8b96c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANB4UmoC/x3MQQqDMBBA0avIrA0YC4b0KkXCdJzWoRplklZBv
 Luhy7f4/4DEKpzgXh2g/JMkSyywdQU0YnyzkaEY2qbtGmetwTx2nylss4REGAMt8zpx5qC7Qe/
 I0/PmB3RQDqvyS/b//QElNPRV5ZihP88Li+NqinoAAAA=
X-Change-ID: 20260711-ath6kl_wmi_scan_complete_rx-a97c9cb39da7
To: linux-wireless@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE3MyBTYWx0ZWRfXwqaeGwA+L2CI
 nZAUaLn1Q+jt8JJRJYjkWpeREsv9dpo7IPhepcgtl2NGLJkTG4OPTioHq0JRjLNrdxDoEHRyUJy
 eM04x7SmYGt163KG79suB0q/4Wx1JHI=
X-Proofpoint-GUID: JazHYGt0ZaZNE3hPdwCFZGHUYOmVg_FN
X-Proofpoint-ORIG-GUID: JazHYGt0ZaZNE3hPdwCFZGHUYOmVg_FN
X-Authority-Analysis: v=2.4 cv=dJSWXuZb c=1 sm=1 tr=0 ts=6a5278d5 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=MFar82-2d_bT9VDcRPwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE3MyBTYWx0ZWRfXwMTY1zyUmW8o
 Bu0gzXBBazmvifGuJO+OFEaziicqTgzC899/YPF8uY5j9xWWd/DST2hbvSwb4g/wNaSUXtcmtUQ
 hEGNhZ2yt5zuFxUI4sf6NOQy/EnPZwTbDAsaeC6ZBZf4wPeRiOwqGz7oVcLTfmzb3hHGmE9Xl9h
 zhuaeHr7EHO9PBAQX2sTpgUf/YZwN1U1L/9fwOPjxfsuBwFQUS+3Njo0OkiRSaaVZ8/r30zfMvu
 5ffIdA3WqW0KoTEQ9g0ayLsu8tUoumkoJoAA7GTE9n7aUrxpU+PnzdNvOL94AwNc5I6JRPqKHHU
 KtnvBPpzVbA2YkX6hulcPcO6RgfWsvWg98wG8pCxly1jM8AMEOfaRnhW1HeSaATWYCnSjUpexX2
 m/44NksKi2CC4E2w2TxtU8dH5HZBftS0vhLnn4vXXcFL1JehK1HvtZ2HCs30hN9m8K+lhlUXXDi
 EXOORXyEfBbXsvBT+Iw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_04,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110173
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38881-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jeff.johnson@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 991B6742565

Currently, ath6kl_wmi_scan_complete_rx() dereferences ev->status
without first verifying that the event buffer is large enough to hold
a wmi_scan_complete_event. Add a length check to prevent overread.

Fixes: bdcd81707973 ("Add ath6kl cleaned up driver")
Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath6kl/wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/ath6kl/wmi.c b/drivers/net/wireless/ath/ath6kl/wmi.c
index 72611a2ceb9d..1645f59b0dc1 100644
--- a/drivers/net/wireless/ath/ath6kl/wmi.c
+++ b/drivers/net/wireless/ath/ath6kl/wmi.c
@@ -1276,6 +1276,9 @@ static int ath6kl_wmi_scan_complete_rx(struct wmi *wmi, u8 *datap, int len,
 {
 	struct wmi_scan_complete_event *ev;
 
+	if (len < sizeof(*ev))
+		return -EINVAL;
+
 	ev = (struct wmi_scan_complete_event *) datap;
 
 	ath6kl_scan_complete_evt(vif, a_sle32_to_cpu(ev->status));

---
base-commit: fa1b1469f1c5f0f54ed9dab80106a117e7736bfd
change-id: 20260711-ath6kl_wmi_scan_complete_rx-a97c9cb39da7


