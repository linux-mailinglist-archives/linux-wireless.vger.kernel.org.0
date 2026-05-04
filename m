Return-Path: <linux-wireless+bounces-35834-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPNMJSCT+Gl8wgIAu9opvQ
	(envelope-from <linux-wireless+bounces-35834-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:37:52 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C76B4BCF93
	for <lists+linux-wireless@lfdr.de>; Mon, 04 May 2026 14:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF2F300F1A4
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2026 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F5C3D3483;
	Mon,  4 May 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RTkGYbns";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XTVi2dP6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30AC3D3329
	for <linux-wireless@vger.kernel.org>; Mon,  4 May 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898270; cv=none; b=XxpQ/vyh8LYhnk5w62bWK/c50c/M+dvYrE5EiZ2s9RDsROzIMlZ1NQqOAJYRszbgKtb3VxJQmSegX1JZSicpG0XExvFBEP05m+suXK3npdPaKp2wkpWzbKGalXgFmMwtQcTXxs3j2eJxKGP1GVfHCwNuZN5PqlVpWifrTx564jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898270; c=relaxed/simple;
	bh=bkVafw9XhK7U8+lqaCVfSniKSuYrYja961noGtvvG48=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Owr+6SsMlltBh2HtG9DWChNFkaCgYGtg60zuxT58tuv2YoHvkhTlyuT7oNfch8D88SYljCC0DhxNPJoEfxowSQZuHlFHco6HAauL7isxBP2R0QJFwyM8faIXiXrUoT72P3pKh0pCQFs+zumr3bC3d4Wpl+jl1ore61R70DPs01Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RTkGYbns; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XTVi2dP6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 644B4PtY771599
	for <linux-wireless@vger.kernel.org>; Mon, 4 May 2026 12:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=nHNK6SS6B1MmAWq0ASM9+DXnGebDvRnAV2e
	PVRaf0eA=; b=RTkGYbnsHyV4PBrgUWpMH/TVL8frswJmMHZaB5LRyYVJdEIZVmS
	arL8YbBQ+CUoxhG/S7piY/oCJWRkRafVtU3+4+xN5MnU9dNChRdXwl/tgEoPXMWd
	ec8ywJ+zqfEpRUggAHpRK4uBtxCVJgEl77DLo0cwI5Nykw1KYtY2e+iiVNHzQ6RY
	vwih754PU/T7joyh4pUjz5EY3pnu+/eVj3Ph03RU932Yvi1bm7t5UMjRSTMkcYRH
	eZtOpaEzLwMx9hOFhqqFnZiefdIdEQIztVYyKMm2C8X4/Db6Dr7mn3JMSkXoz6QZ
	81IpfDg635LxKWwIV3n3yZ30D6rH4lxzW4A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dwaejnk2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 12:37:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35fbb57764aso5410192a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 04 May 2026 05:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777898268; x=1778503068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nHNK6SS6B1MmAWq0ASM9+DXnGebDvRnAV2ePVRaf0eA=;
        b=XTVi2dP6GSd84nGUczus0QmKxD2zItEflTOZ+trxTXSeArPI8WtCdSGHIb3puZW1PH
         NlHPd/2UHx9NHF3U2J2EpDJgXgRB/ikIUQkA414JWu7jXw6e1XEu7JZBy3m7RmYoQHXs
         PXjzYFKMx7luWe2jtam1ZmERB6dw4vZAVD8Wz/CaWPdmbVIqDwPzsCy1Te4gBBfTxdE7
         IaNnOPfx5FvO1tLjXuHk8nBJI/HCCsiYTzXUJhooJ27/7qD4nXW5VV0iTj1TVNXMboHy
         CMIOssHPPYt7mW6zmNYzStB+3aA/spT8Umav34VQxPv0v0lQ5XaoWNrqeSN5veVUPcIM
         4QDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898268; x=1778503068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nHNK6SS6B1MmAWq0ASM9+DXnGebDvRnAV2ePVRaf0eA=;
        b=NwOP08VymiEWmui0RfWnfUAGbEf9cHJmfHoCG8MryPuBSlFgU0dtZfuFaJlxwBrFWM
         YeYBJ0LReda94Cb7cxM+J3Ty0Mqr1AT8F7OGUUfbyWd9/VnvzZn5atZi+gtcx41qhnTJ
         O4mKm6P5RPRCWEGXdhrW8kCKEkGiWojnb1GyDoVru9jJOP2Z3P6UEO55Vcrhd+XRe4KF
         yye6j90aHOWjaJkGjCGUoGt3oOSTIln7rV3J2swf8V8PQYbna6r2RydTuCzbIHczXiIo
         SfVljuwuAvTBt09p19VhB6IMV+/QnX35Y1sz1lnZTvwXcFr4xOIzkUaas8dppSBqonij
         Ndow==
X-Gm-Message-State: AOJu0Yz79rYsKeQvhUzWeGYTjZ2SOiZH+pCEjNEZ7XApKYzmIF6GGrWH
	naGCJcMEjlYTHtNMKVWxJdwU9IehppgUIKrN6RMVJRuanWKK1gBBx9mpV32CuCF2Y8tFCe9Pg0r
	DkfFwVRWs3C9b4oOJcC+dzRK7Vb3n8O8iMtzJmVpfKzggXEXvRPhADyjqzrEpFqfe/yiTDw==
X-Gm-Gg: AeBDietKbdQ6X/l45zynrQcD60iYNPWlSGJJ/vhL4tvFLhxxABAYpqZurcXb1K9Vsge
	T8AU5gZXZFSbBFX1xyig9RMxXoNBDZA3XkxztDR7PVvmJ8hOWLqF3ZYnjK+AMd2Nlv8mydeZr1D
	19IRAJcXrenXwGSShNeZKBAjLDyaMWEfmKTbjmr4IRr1B2jc1m8ez5hRVcLU23Zq1OQSmY4OtFX
	1oWnR3/VsbPJxdts7w4SNH3TV6rFDIO7+vtya07QwcD1iDIEHnpjPG/ZYqApFJ3yAUGNXWp4mWk
	W2rgC3kYo6P6RDJpByXyUGh2ivVD76wRu1eF/OUsx790+YEcHyokB7AURbqpuKHHWqZPqdGQbFf
	1qLcKj3mAD3W2kLOYg3u+RQuie7G7LZ2N7sbdhI/UNOcB8ISWMVU3fJ9JH/bi/BlG
X-Received: by 2002:a17:902:9683:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2b9cabecf0emr71055685ad.1.1777898267510;
        Mon, 04 May 2026 05:37:47 -0700 (PDT)
X-Received: by 2002:a17:902:9683:b0:2b9:cabe:ce37 with SMTP id d9443c01a7336-2b9cabecf0emr71055565ad.1.1777898266951;
        Mon, 04 May 2026 05:37:46 -0700 (PDT)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae6ac32sm107505145ad.83.2026.05.04.05.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:46 -0700 (PDT)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 0/2] wifi: cfg80211/mac80211: indicate (Re)Association frame encryption in SME-in-driver mode
Date: Mon,  4 May 2026 18:06:22 +0530
Message-Id: <20260504123624.529218-1-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDEzNCBTYWx0ZWRfX5hNz0aSnl8bj
 qyD9UCCsrXt+DuIqLdbxg+ICXmgIrGln9ktprsI61HChSTugNZy2CI1plgKVe5G3V4D2yQJ4eCd
 unYiiUX1SlWP3ltbgg3RWnIzNG9rmpyBOVONoPNGeOalFSlXVPbFd4n9Cf+xLrZHMJ1ekHyvAKA
 6bufKwwW6BWLuEGd0Y9+XPmbh7rqNjIVtrH2HdVr8Ze3ZdQNRfIuWpaC0ngj2sZteG2qlIEwiFx
 D6oSzHSyKFTW/ejOKqcXIV245khGkg3n1SmjA+olLYJRRbX59pvnQa1j5rDVMZaq78VEJWruICx
 6HAPT9yuxVHtG8BbztlG17tPVKHUwZGkDh6so4KYStNHZogfd5LzmpsAPLCtjreajefEmhk7/bS
 e4HVqpxElr8rzW8NdpV878SmdLRkDtKKyPudHgMhxgWw6frXNm6r/sp/QEXVX8nqdBV8UnM+Q32
 phzdfFUcsAa1fjuIFGA==
X-Authority-Analysis: v=2.4 cv=Wa48rUhX c=1 sm=1 tr=0 ts=69f8931c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=nVJCyJ3Yu9inJ6tiwNYA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: N__mDyUVq55ShPig9jwFnoGf7s876Veb
X-Proofpoint-GUID: N__mDyUVq55ShPig9jwFnoGf7s876Veb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040134
X-Rspamd-Queue-Id: 0C76B4BCF93
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
	TAGGED_FROM(0.00)[bounces-35834-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]

Add support for indicating (Re)Association frame encryption
(IEEE P802.11bi/D4.0, 12.16.6) to userspace (e.g., wpa_supplicant)
in SME-in-driver mode.

These changes are tested with Hwsim Tool.

---
Changes in v3:
 - This is a continuation of "[PATCH wireless-next v2] wifi: cfg80211:
   indicate (Re)Association frame encryption to userspace".
 - Bring back the following patch based on reviewer feedback:
   "[PATCH wireless-next 2/2] wifi: cfg80211/mac80211: extend
    cfg80211_rx_assoc_resp_data() for assoc encryption"
 - Split into two patches as suggested by Johannes: keep all cfg80211
   infrastructure changes in the first patch and mac80211 changes in
   the second patch.
---
Changes in v2:
 - This is a continuation of the previous series:
   "[PATCH wireless-next 0/2] wifi: cfg80211/mac80211: indicate
    (Re)Association frame encryption in SME-in-driver mode".
   Now sending as a single patch.
 - Dropped the patch 2/2, as there is no current use case for passing
   assoc_encrypted when both NL80211_CMD_ASSOCIATE and
   NL80211_CMD_CONNECT are indicated.
 - Removed redundant NLA_REJECT entry and Updated commit message.
---

Kavita Kavita (2):
  wifi: cfg80211: indicate (Re)Association frame encryption to userspace
  wifi: mac80211: set assoc_encrypted for EPP associations

 include/net/cfg80211.h       | 6 ++++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/mac80211/mlme.c          | 9 +++++++++
 net/wireless/mlme.c          | 1 +
 net/wireless/nl80211.c       | 4 +++-
 net/wireless/sme.c           | 1 +
 6 files changed, 29 insertions(+), 1 deletion(-)


base-commit: 7baf5857e15d722776898510a10546d6b2f18645
-- 
2.34.1


