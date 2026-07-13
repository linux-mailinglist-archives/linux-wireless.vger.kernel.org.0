Return-Path: <linux-wireless+bounces-38943-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 25PHM7OUVGo+nwMAu9opvQ
	(envelope-from <linux-wireless+bounces-38943-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:33:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3FF7482F2
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 09:33:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FsfGYZ7x;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="U+vJc/64";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38943-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38943-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0BBB6300138A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jul 2026 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A86F38F230;
	Mon, 13 Jul 2026 07:30:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E78738E8BE
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783927831; cv=none; b=NvOIx644N47neLHmQqhDwJPIV8dHov+SkdSVk+ZCIa4d1aYAwudMWHuWBe1sLXHOm/petCTjpzQdiotJXXj35k1thNT8/+ChPNfBNmgYMNTQ9AUZ32SpZqaBHjMxF+jNY950oSq3Ge0Q2TrKQ7ONFKtRExxuYWYI84ql0szcD1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783927831; c=relaxed/simple;
	bh=c/WbPPv4RkwxRzYF4uWmRJreh5iKXZqoFKs7He5VVbA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igIA5jvvdbe2jSnMvHTFMM8vziIAnHlMtBTa/H7/8ycfAYDUzyaRj1I2JsRwQsu7qbFJ/TbHedCAhDYsoslNpII9F79CNqOrLLdwwueo/lPHXXCGNyLM6Qq6V+wu9No9urn5QJxpnwj9a5K66Sp80qNzaeLTyVjPg75GH1KDBXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FsfGYZ7x; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=U+vJc/64; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6ON9j473851
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iXbx79m4mELfQ+yxJXteo5
	YQs+iJo6r0y6/Vp4M+W0c=; b=FsfGYZ7xGK7oMZpxs7qRBaagPlkjtitaAw4ztr
	kMZe+oTw5Af6YDtc9j88gfkdkOlQ5FWNSGE0HPbGbpx1kDDSMCw3tSY38njhUwqK
	34ooALuzyvjmYe/99JvwBGrCefgjdrxl93r8ceAfhg9QKoH/sv7LWzSrwctKp4c/
	+C9NhrDGs9ImK+xxyzvdWpn9V+R8n76p/2Ta9qFRRi78EEQVRVfvPd5jvkx1DBp8
	nBwWNtKooAkeDkWkKJWfGg2P7khXZQl46rZzonlb26/oEFt5d5Nb/TQZw5cEtCLD
	WENo6xny4xDvl9ZkpgRhf3UrCUJX69AKSwA7qkky0mT2er/A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbee9n1mk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 07:30:28 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c88aab7c1d4so4102728a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jul 2026 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783927828; x=1784532628; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iXbx79m4mELfQ+yxJXteo5YQs+iJo6r0y6/Vp4M+W0c=;
        b=U+vJc/64faRpM8CcBBk0x6WmikaS5H3atN67AyMrhy5uV0YON6ErpnNa5u5NEO47PI
         /Iv9DHlJtBw4KmVbeIWQoVPalsB8cIRnlv7N2rxnb0aGNLV5tNbKpoWS0WEskEovkW2Z
         /+DAx5LwKTx2YmpL04rudtOBGtV65PF8GQZU0HbFkoJJSssgYVzBiw5VlzFoZ6k+HgV2
         XpknOtOBwSvobTYoNE78fP6hZ9GWdk9b3Dlxkt13g+1rL8jGY/9QLGdA5Dq880aqRaBR
         5vPgaOMkvs9zOSLwa1DxyPV7XpgmGDmHHkoV/E3w545H5jQvIQZc06qNALHL+uPcmXIZ
         nNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783927828; x=1784532628;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iXbx79m4mELfQ+yxJXteo5YQs+iJo6r0y6/Vp4M+W0c=;
        b=auUPjb9A3cSt7Qp8Y9Yn/hfgbk+LXQv3QBYh7ZQvX1EL9igA2zawFcKAVWRS4Md9ab
         QrC9k+n7g6Ho2YA20H+1gix9XrGElyaiBr46aVY7VO4/7sN6KQ+BDfYCmGrm4QeVBI0w
         JPW+ktqHy5T0M+hg/yHsbzlQ+IXhinBJovMFrh8HoR5Dp1tGs5uUdsIaLr5KpTXAKrbK
         mUhnDecH+u7V5xCHTypV/fP1kb3PzNdFPMIeGZjnOOFbnqtf14LH6/A6eaLhnAO5sDWn
         mGdWcJC2zTIki2BHoKJCQv7UoHrSMECqALpUemB2Ulbiqi8Uf2BPNxF7hsoSOuDUwho7
         IszA==
X-Gm-Message-State: AOJu0YwwB1wTp90T57/vKUVUYV/lMT2JSyuJ+KnxkbhC8EPS1Z27aKXT
	Y2rFnnk3ju+mXDdLBSVVCMAktwXuavkmeFmZLQorhqdlsPYCtNtbG70Fgs6P9STjgsPv/si8VQ/
	YkbLGdVg7EalwrpkfRpY0mFLYPMsxoOzvrYPm5luG0E29KQzaJpdWQXV+FBvP84c2vjbkcao1bj
	0Eudjp
X-Gm-Gg: AfdE7ckxKCZ+y56KuJ+gPqqm4GvQaQ2e7xbSi4o5wzbQsp+1aRIUlm1mx2oSdflHJxU
	1LkObcc2OyBqj+Xpa/OrjkNemrhZLFlhEbM+Cwlr678We19p6XQBNXePVWsIrJZLu1VvAmCttfD
	CXiGKsegaIeepPC6RK7J96R44flZLEJumftw7IeQIQ6i6nfh49QtdeOTGuHX6KWX4JpUn+zrZaQ
	JfMJrcYkGibraQOzz9L1BB7Q87wfcOtaIZaY7o3QCNG1+Mw5IVRPQEZITdzGrAqLEHkdtXMikb+
	EjwgKMCDQonT5G9sqJMDNgcykU/oXZi9miT710kcIcfhF8af6U5OnKcuHJOCpKnp9dwkzInt6ur
	c2JWkT3k4pTHCVBQ+zcaMySQhu/5GdDLdyTysaWDXPm48j8PW+aPFifcD7Ji6CLwg
X-Received: by 2002:a05:6a21:484:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3c11077e771mr8139862637.27.1783927827797;
        Mon, 13 Jul 2026 00:30:27 -0700 (PDT)
X-Received: by 2002:a05:6a21:484:b0:3a3:a9c4:3d60 with SMTP id adf61e73a8af0-3c11077e771mr8139829637.27.1783927827363;
        Mon, 13 Jul 2026 00:30:27 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ca5b31628c1sm7947252a12.19.2026.07.13.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 00:30:26 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Subject: [PATCH ath-current v6 0/8] wifi: ath12k: support
 firmware-allocated MLD peer ID
Date: Mon, 13 Jul 2026 15:29:52 +0800
Message-Id: <20260713-ath12k-fw-allocated-ml-peer-id-v6-0-20f6f212e413@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPGTVGoC/5XQzUrEMBDA8VdZcjZLMvlq9+R7iIc0ndhgt12Tb
 lWWvrtjEdyDpXgJDJn8/pAbK5gTFnY63FjGOZU0DjTYhwMLnR9ekKeWZgYCrDDguJ86Ca88vnP
 f92PwE7b83PMLYqZVDo02tqqlNC4yQi4ZY/pYA0+M3vJwzRmHiT3TZZfKNObPNT7LdeWnU+11Z
 skFd04LparWI+rHsZTj29X3YTyfj3SshRl+VSvqXRVIBe2Crb2y4OKGqv6nKlJR29AEI6SCZkP
 Vd6rc/wFNam2diG0LQPCGau5UgF3VfKvRC3TaCfD1H+qyLF/x1cOaOAIAAA==
X-Change-ID: 20260527-ath12k-fw-allocated-ml-peer-id-2b456891157f
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfXzuCW6A1EvMao
 nNBLbY3R7iLq5jeAbEFBVY2kVvZ5v9X8ijiygV2VSlSTo9zh9GDrtTZfSHHGDsc1AxChuR09EXH
 ILMQDqdD0h4DQu35RCZtX5CdA5xC0as=
X-Proofpoint-GUID: KZ5k-YcXxIeH3eFJHqDv7OROuuot7Y2r
X-Authority-Analysis: v=2.4 cv=a7UAM0SF c=1 sm=1 tr=0 ts=6a549414 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Iq4hiD-WU0-YEpfp37cA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA3NiBTYWx0ZWRfX6R3Vd6je+rSe
 pq+YP0QWY3MEVE6sG4hWEz6vAyZNpk2e+YIF+5Dpyxs8y4sVRsj9E2p1InVK9Y58slHqiWrHNDR
 4N+7+N8U3lvBQwwovhJLJJ1f1fwB6Jd/+JteslDJCTOCaniS+MjygskwUrW0uhYXSkzpl46al2L
 CNuwBY8CLZhYIk/docBTqeKLBPYL4V8OygLX4AB1kKxagswoahSz5SwycfhwloahjpgNAPNCjuS
 HNJZuf8EpuAa82iwz+TW7bp1IGxd2HQSA0aIvTjH3UHvX6YFEMExrA/wHqM/dynNhWSmY8PsxmJ
 EJS22CEacV2wo+rba4G7BWWOQky1LEra2aHmmYdmVxlXxrMqERtzPuwTTcFdJT7Wf+WI25jGO7m
 oHMahPxlj052ctJRwGBUb0v2gxzRNvZeslZn6vd/viE8f1A4NkT4JaYAsHFRt8cdCM2TFwxmD1x
 tGRxcaEk7z+itmGT9hA==
X-Proofpoint-ORIG-GUID: KZ5k-YcXxIeH3eFJHqDv7OROuuot7Y2r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 spamscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38943-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath12k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE3FF7482F2

ath12k currently assumes the host allocates the MLD peer ID and passes
it down to firmware via WMI_PEER_ASSOC_CMDID. This works on QCN9274
but breaks WCN7850/QCC2072, whose firmware always picks the ID itself
and reports it back through HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP. As a
result dp_hw->dp_peers[] is never populated for MLO peers and the data
path lookup fails. On QCC2072 the firmware additionally crashes on MLO
disconnect when ATH12K_WMI_FLAG_MLO_PEER_ID_VALID was set in the peer
assoc command.

Add a host_alloc_ml_id hw_param to branch behavior, defer the
dp_peers[] publish to the HTT event for firmware-allocated chips, and
propagate the firmware-assigned ID through the existing host
bookkeeping when it arrives.

Patch summary:

1: fix for an out-of-bounds clear_bit() in
     ath12k_mac_dp_peer_cleanup().
  2: group peer assoc send-and-wait into a helper
  3: refactor, keep ATH12K_PEER_ML_ID_VALID set in ahsta->ml_peer_id
     so later patches do not have to OR or mask it at every call site;
  4: parse the HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP message;
  5: introduce hw_param host_alloc_ml_id, set true on QCN9274 family
     and false on WCN7850/QCC2072;
  6: on host_alloc_ml_id == false, leave peer_id_valid unset and send
     ml_peer_id == 0 in WMI_PEER_ASSOC_CMDID;
  7: on host_alloc_ml_id == false, mark ahsta->ml_peer_id and
     dp_peer->peer_id as ATH12K_MLO_PEER_ID_PENDING and skip the
     dp_hw->dp_peers[] publish until the firmware reports the ID;
  8: in the MLO_RX_PEER_MAP handler, propagate the firmware-assigned
     ID into dp_peer->peer_id, every dp_link_peer in
     dp_peer->link_peers[], and ahsta->ml_peer_id, all under
     dp_hw->peer_lock.

---
Baochen Qiang (8):
      wifi: ath12k: fix out-of-bounds clear_bit in ath12k_mac_dp_peer_cleanup()
      wifi: ath12k: factor out peer assoc send-and-wait into a helper
      wifi: ath12k: keep ATH12K_PEER_ML_ID_VALID set in ath12k_sta::ml_peer_id
      wifi: ath12k: add support for HTT_T2H_MSG_TYPE_MLO_RX_PEER_MAP
      wifi: ath12k: introduce host_alloc_ml_id hardware parameter
      wifi: ath12k: do not advertise MLD peer ID for firmware-allocate devices
      wifi: ath12k: defer dp_peer registration when firmware allocates MLD peer ID
      wifi: ath12k: resolve PENDING ML peer ID from MLO_PEER_MAP HTT event

 drivers/net/wireless/ath/ath12k/core.c     |   2 +
 drivers/net/wireless/ath/ath12k/core.h     |   3 +
 drivers/net/wireless/ath/ath12k/dp_htt.c   |  49 +++++++++
 drivers/net/wireless/ath/ath12k/dp_htt.h   |  12 +++
 drivers/net/wireless/ath/ath12k/dp_peer.c  |  75 +++++++++++--
 drivers/net/wireless/ath/ath12k/dp_peer.h  |   2 +
 drivers/net/wireless/ath/ath12k/hw.h       |   2 +
 drivers/net/wireless/ath/ath12k/mac.c      | 164 ++++++++++++++++++++---------
 drivers/net/wireless/ath/ath12k/peer.c     |  31 +++++-
 drivers/net/wireless/ath/ath12k/peer.h     |   1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c |  12 +++
 11 files changed, 292 insertions(+), 61 deletions(-)
---
base-commit: 951dc0a744e4dc8490935316d3b76e23990bde3c
change-id: 20260527-ath12k-fw-allocated-ml-peer-id-2b456891157f

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


