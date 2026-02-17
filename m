Return-Path: <linux-wireless+bounces-31919-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANFoFm0BlGnH+QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31919-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 06:49:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4013148E1E
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 06:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8708530136A0
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Feb 2026 05:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B606A259CB6;
	Tue, 17 Feb 2026 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oqXQNzQk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTGvkAYG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925821ABD7
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771307369; cv=none; b=JU0c55kV/Y03xKVOoNtOpX8FPwwBc4UbzanarOt/7wjZQvAvTLlQDhVQPuCAxLX8rGtZpxOApuwD4e24k0+ksthbiYD9M1nmLkd0A3ivkK7s+Y7LcYnis4mgJ6eInw435uG6+OKguC4kkhILAeee9ikroemtC1yyBptDW9xQsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771307369; c=relaxed/simple;
	bh=IiL5vOYi5uJTgb6898qCbgCf5tY22q+t9tiHFEZ11iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q5z0OjBi8Li5wHoMygSP5f7EA7ofLFmUcRMSzDIAvAboTyJ/8yBGQDRk4FQFQFC9lRYvpqPfX7WYwXgdG9EY5u0b0fXw1wNxrxuDEPOacZ+lm23VlN+gOWiglWxX944hcmz6AQA491zs2/m9hRbwso1DcMyD2FQJ/ZKA01csRjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oqXQNzQk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTGvkAYG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61GFtR5c297136
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:49:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=bTsWrMquSjjeWNJuIv4XC+fsCoAqRCYpEBG
	yy0rF+h4=; b=oqXQNzQkpeNeQiqYJXDBB788+x7j1/NWqspzZiniv6tMma2rvRh
	+E7ye1AzPQwbidVwQ0KgmLeYwqtGMzkLtffMeLr/mwemWLA/1LS9TipvA7NdxDHe
	m1dYRQnErhYVkDX5BcDDVhquOyeqy6S+p5i3/Nok7lPjnVM+LcSoXHYJz9yFHtWN
	rZvtStdwSW+TF0B5bUZjW+pTIGh85Nt6VylG7AowmPaoniaPXwxJnSRPJe42o3I9
	7i7E3GbSdOOLAE7NHgQmkpkqy2AyUbOszIOy3FlcGBysd9Zobkve4BoU4A+wqbYg
	L7MuUpIPSuIGQOMdp+QcO49o60y1LmKJalA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cc6a9sb76-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 17 Feb 2026 05:49:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2aadeb3dee4so217557905ad.2
        for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 21:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771307366; x=1771912166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTsWrMquSjjeWNJuIv4XC+fsCoAqRCYpEBGyy0rF+h4=;
        b=eTGvkAYGBQ3EGIFnlKHugUYf1nJ/lAes9NrLqtXOlBSaTX1Eemd8R8upvql7jCtebA
         28VeBMY8T/M/4YP1hmnhQVe2w5qVE+XHct4x1QEpBnzAsd3AMEo1L75VNN0AyVfH7WeT
         b9vhq+fox2ZczNoLsfsv93OL4aHnb10em3PRmjrGUHHDBJ1iGTVm/m0uzPlh18p95bOU
         b1VMQ8t2+kAeoma+ufSJmb/aWbKSwPhignPBmTe+0Fks2ipkdhhalFBdA4qla1siZWPu
         dFI2YiGbXapug3/26I7un7Jt0Wd6tE+C/uMnIUcMGjVOInMe2bhXvdUsbKjGZ/ZyXZSG
         r3Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771307366; x=1771912166;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bTsWrMquSjjeWNJuIv4XC+fsCoAqRCYpEBGyy0rF+h4=;
        b=mh7p4pw4Eut4Vlwd4Tce8rYMXwWL64kL72+UfLPE2tGZtRIwZwd2bhksabvhTcERuU
         xQiwdntXaoJCeKE4GEVmzsIYlQKIBxZWrPyhZXTD1QBE7yO0WJWveCZboe/Nw/qOss3I
         /4pqeuf0vFPnl25QYaGoKjV4/7c5CndpUcVedHZBTHA3FOtPd9ghiaBJaAQ/++GYonx3
         bRgc8dPNH4UrFGirEtXBFvKvpTYCwCJeXZ6siVbReI2/rCik4OeLsteLuYnQu/00m8z9
         RObdqo8CrBFgUUWiCTOnsQKHHTceq54b+AEL0ZP5qjJzJQspKdIKgXyNkAkeRuK296IQ
         vEKg==
X-Gm-Message-State: AOJu0YxoivUAkw8uMbRgoCiBicTI4+Kk0E/gkHtkA444R0j+tpp3fAsF
	v65SgdvYxTtTExG/2+YjSpFkt5iPPMVhjaeTvZvb0+z19g7+1KYlizNVHV227OGhJpS9GHKiikH
	cWpUvhvXxgpJ2BUUwhLHadGNN75iU2U6LB3zPuxdaBVMqW9hyCgjWTojYjNmeE4whd2sR2w==
X-Gm-Gg: AZuq6aI3ILSi1VLtjnRaBPZRo4VesCE30PNOxFVhCULHxRDI7sh4mhvqmDbtYsltXL0
	Lm6JrS/5wfJbqUaAhFc79TPx1/D/4ww7mgacoPc8QENMY8ITEnYzNBFAlkmNRZEEz2+2OZ2gKVW
	6BujXgkKjnL8DTJ3LmxRvIQUhyNIOedd6OYD6ryf2gNP7ePjEO9/5rVRTsyIEiOEEyUALu/2SCd
	kS1YtUwM3sxKYEDzMYUFvoJpuZna44jQZtk7lwOqh9gKeeRO5JTHaXobHyO0eKLTRDOw/3fmD5U
	AE1nh/wxw5VPIShsNUswBH3HInfT8DAqi8hw0rhkgRss4hxEQ1oGfhhkiI2+PD8BEoW9Kp9gKbn
	4ZDOLInf6uoBNdK1Ega+0hekZ/F3BUTlTJWtgy0zrPHFw4A+n/PtFJ3RU8WXQ2dTiOg==
X-Received: by 2002:a17:902:e84d:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2ab4d02efc0mr143807415ad.35.1771307366354;
        Mon, 16 Feb 2026 21:49:26 -0800 (PST)
X-Received: by 2002:a17:902:e84d:b0:2a3:bf9d:9399 with SMTP id d9443c01a7336-2ab4d02efc0mr143807155ad.35.1771307365898;
        Mon, 16 Feb 2026 21:49:25 -0800 (PST)
Received: from hu-kathirve-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5bbcsm89808175ad.56.2026.02.16.21.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 21:49:25 -0800 (PST)
From: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
Subject: [PATCH wireless-next v4 00/02] wifi: ieee80211/mac80211: Add UHR (802.11bn) Capability and Operation parsing helpers
Date: Tue, 17 Feb 2026 11:17:29 +0530
Message-Id: <20260217054731.3667600-1-karthikeyan.kathirvel@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDA0NiBTYWx0ZWRfX707fcOIESFYn
 N8OS0eecmKi0btItOT+ADyeDLqkFdUX/NiqEv6SXg8bAjdtmhW+GCt4y+Z8Sjdtn8ruxM1xmuWF
 I+SwlObcvjrst0UqH0g0ONy/TshYlqNxHPwiWrbZeNVucqxZdmQFQ6slrk2UKgLknp3wMnBnkE2
 21G9z0Bn3gTyg+FSOrxVbS1JJtKgnyH6oojeTkXIPkS242jf2QfNsl7PY/Z2AfJqZckDT0chXI1
 lT6JPqwXbsKaINeJ9vSIPewa2ECT7PX0dMzI9QhhnqbrfDHTGVoOeixN2Vy7DpLm1g10ZQj6PKi
 dfPA9vED8sr1qO4t1jJ52VBg6bjfTvsUXFpim+8JjftqJHhl/I6WCnX88R6h7X3nxGb2sQn2/Bt
 uo4XLh1l4iUVAfqj8RrotOMVJVkhx603JGtue3BpVI0JQlNVc1BBMAb6WBJgke8asBORDnFTdWF
 MWFQa8Uf9wm90EKf2jg==
X-Proofpoint-GUID: tbjt0MgfgV3TtdyWojv8dHjiVxYq58rk
X-Proofpoint-ORIG-GUID: tbjt0MgfgV3TtdyWojv8dHjiVxYq58rk
X-Authority-Analysis: v=2.4 cv=TPNIilla c=1 sm=1 tr=0 ts=69940167 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=9AfIhKOTUZz-8RWr15wA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_08,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602170046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31919-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[karthikeyan.kathirvel@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A4013148E1E
X-Rspamd-Action: no action

This series covers support for UHR capability and operation (11bn)
parsing helpers for DPS/DBE/P-EDCA, and adds mac80211 hwsim changes.

The code changes are based on the IEEE 802.11bn Draft P802.11bn/D1.3.
There may be changes in the code to adopt upcoming 11bn spec changes.

---
v4:
	- Addressed Pablo's comment on mac80211_hwsim

v3:
	- Addressed Johannes's comments
	- Removed reserved macros and unwanted
	  IEEE80211_UHR_DBE_OPER_DIS_SUBCHANNEL_BITMAP

v2:
	- Rebased the changes on top of Johannes's initial UHR commits
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 288 ++++++++++++++++++
 include/linux/ieee80211-uhr.h                 | 239 ++++++++++++++-
 2 files changed, 520 insertions(+), 7 deletions(-)

base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
-- 
2.34.1


