Return-Path: <linux-wireless+bounces-32219-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPwtOYOZoGlhlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32219-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:39 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A361AE28D
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8047307448A
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A17A42B737;
	Thu, 26 Feb 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HxGy5nMx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PGjirwoR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511A71A3179
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132183; cv=none; b=UADPdnq6HJSU1+2dOLuDfm5iqfiEIlkTamI446iA2dlylK1lFATxIhRZ8GfuAjzfcFWLyOQulGaQdhnKF4U6j4ZODz6pkgsHQWBUjlno0r+a+foxFoH1d/Gz9uZD7UweWPRlUDzXiJ22o+HyrI0OQYPqXgyhJBwwOMvTkAZai2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132183; c=relaxed/simple;
	bh=FEAVCDBN0TzGzWy9g+4tHbTzW5zcskrNxE0MGRf5BdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F6xqMEZp9UyQsC+xr7Y4dlNV/o9xR15FqGUOVhB8SCSJgsllCRF9/cCIG74W/d/swXXA0G5DYFtdrbq/quhvVnW+jkdoEpWG4rOXRa6ylNZcrrN/iO26NMc1s4vBw6cGVgmpbANkWIL1A13Mf5zf2HlkPO75i6icnpeBR4G33y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HxGy5nMx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PGjirwoR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QIroFN2807837
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Xyd1y15loAP
	lwTRsY79E1Dwxkx3kOd350XwUZxIkzaU=; b=HxGy5nMx+TX568WEa8pNaJdhbBl
	Pcpn8J1VIgWDWW/vgpFIf6XFjZUjPvmwaI4Op8C/xNyZXidQgAsnnJ+A4+7jYhOy
	MsUB47xfms9PTrRn0otFNNIBbGrC+BRgZQozRlhTxMd1QOROf5hdt1okNhrKW8Wq
	dvW0UEr8qkL5MaIxRYnmflAdUtT9jwZ61YRZ33T26qmYWLVRU3JSltayFDCjxV5e
	PcKNzmXSji2Xb21Vu1QppJThgId2Gd5XZ/rdVCta7tocjXF37v8yDf21CNa09LSM
	FQs/ALCfESAQJzig8Q9cJjhs33MN38juCE+W2yDblWw8/3+QXHZghlUNK2w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjuur00bx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:20 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-359124b11easo1194975a91.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132180; x=1772736980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xyd1y15loAPlwTRsY79E1Dwxkx3kOd350XwUZxIkzaU=;
        b=PGjirwoR3m/+s/0ZhqKCF9Yb0fFZefe4siL9rbMizy4d9RUhgb5jEBEuJMbU0dthfr
         HIkujqpByCmdhZBcAcuwYZnfkAeOB8UbiCoajaAwWWVChrTca348E+B6/HeJEMhl6Kzt
         KgLJwa+2jMBoab8QcNlLGCi/U8B09UkUu8FXONIjUteOgfxW6m7CSxEOPk5HiYKJ54zd
         ox/5et3R15cwOON6dHwqXBA/DYTPAsY+/eSaJd4/crPaKEMy9lINHGDblvU1L5JQ06en
         WFZx6DOaqk6K6oboI8L/dZw6zQF5V0M59RM35AkLTo1yl46TBIoSnMAtVx9nQdq4fFUd
         /Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132180; x=1772736980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xyd1y15loAPlwTRsY79E1Dwxkx3kOd350XwUZxIkzaU=;
        b=hpkHK/AWcBL+z9JCnyW+0TkoaTYzHkah00RKD+VSqo9FuLr/Fr+3JsQ75O8uvQx59e
         h6HaAbYVNxYLnXKBSxG7vglmlS9/3lR91bm2STa69uKqhKG6NQ9L7r8A63TOKwx76nOQ
         ZxMAkD5LvGGIDH7vzR83SE1aqN6amwU4Naqo3Cgwkj1vUifiwyG9XwgdA7P4sgJUGj5c
         neFKunKkChf2Xplu+CBj5RVvCcphjHYxhAU0Q61DoJXxCDlLc6lyWJ+W1QITKJktpsDe
         PuOUzqAIYyL0m0Oa3LdPG8dBjqeecRl8Rplml0bEZ7Au91zSP1jZw212CuQQmAO0SKyC
         qb3A==
X-Gm-Message-State: AOJu0Yz9HYLQPETWfF50c6OKfB4JiwDcYrMDvyLeAe17WsTTaNVDO6E8
	vLvTdZjnawHb3+cuPkVlfMnin0zzVMVItOOo2GQLRF5Z0tiGf6K5iJa5jX42Mwmb/Dde7Lo4juq
	GIjVnRvGcySwpSvq/94p8KpkOumKNqRlFDL48dVbumHO9wCq1bZv5AaNau1JzKxuZ9CpU3ILFHQ
	u9nQ==
X-Gm-Gg: ATEYQzw/fuzr8tPJhJACO+hwPUM4D/Bvs3sbyCSt+PBCoyCHgSIzOZbzP9SAK3wXD5O
	3wMeAFaYZXE5gPo87KZ0AA6pn0nO4ec4hNH7TpYynPRWNK/Kld/ZAez6jxC0cOPRnIkcYMlFxhT
	ySDIypF6ZbYw81fKSn4b4KGzuzQK8tPsII55zjYftg05ZSpqr52yGHZdJCGb8eKShdh5LP2qAN4
	kvmvr0h3KCTB7sgFnK9Txd3wvXVNtaWOm8mb0rh7raQGTyqrkE8EjhYT1ddVR1xIJfqAe+T+SM4
	+XQW4iTW0k2uLcfGn89xplanr7W8eSAcCeaCCW5NJUoWGMzcDV/oclscc0CMtoPvrvlUk6oBcHh
	sH5TWWUNWN9OKX+vGgluuwTeQ4dB5wAMzv5T16dXbBazUPwxtUiEeBg==
X-Received: by 2002:a17:90b:3852:b0:356:2fee:92c8 with SMTP id 98e67ed59e1d1-35965c9d1abmr216011a91.17.1772132179836;
        Thu, 26 Feb 2026 10:56:19 -0800 (PST)
X-Received: by 2002:a17:90b:3852:b0:356:2fee:92c8 with SMTP id 98e67ed59e1d1-35965c9d1abmr215989a91.17.1772132179363;
        Thu, 26 Feb 2026 10:56:19 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:19 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 2/5] wifi: mac80211: Advertise EPPKE support based on driver capabilities
Date: Fri, 27 Feb 2026 00:25:50 +0530
Message-Id: <20260226185553.1516290-3-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
References: <20260226185553.1516290-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Nu__SkUVzugOpuyAHUYJ5fIvYkW_HIe3
X-Authority-Analysis: v=2.4 cv=PN8COPqC c=1 sm=1 tr=0 ts=69a09755 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=OQI9FvOzkc_s05o5xeQA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MiBTYWx0ZWRfXzXyqLeM59SX/
 C1O2Rg24AcKbHaXFMKTOgni0GN53FdGrMnVU/WRt0kfsNwh5b1wVNC2xiSZO47tUN0R9BHh9HEb
 wGzZZS3l4knm2ZtPEl2L2oL/MUVa5G4DUJhx6H9CeadwPB+lL3NHx++K4rh//lBiyq8gDJ9IGZh
 DaUuYEZwz68JgXK3KXLIXmb7OJW0H4wybrcD9/yHlvkmu8cSAkSM5PzNgUduUjoGXBC6MD9geL8
 dLUH4a3+aj3JeZrZhRHFAx+LsVMJX+gUafu1gJtXjIpIZ2/f1ondmHZCr8M1y2MsfH+w6lm+HFO
 lbMhYZuo6zMooh2EZuygSkxIBF0wrwqEZWVHuqsH6ULXz5+zlnPksyjJwWSoyrZy24zWQLnP14p
 YcoB/Neb6cccmnglXzx3r07082KYV7H+f36LFrxOdlXHzOo9jnNhdGeZ/mhQuNkUSD+X2Eqkzvk
 +ZjKCCBjVlYoFPI98KA==
X-Proofpoint-ORIG-GUID: Nu__SkUVzugOpuyAHUYJ5fIvYkW_HIe3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32219-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kavita.kavita@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C6A361AE28D
X-Rspamd-Action: no action

Advertise support for Enhanced Privacy Protection Key Exchange (EPPKE)
authentication protocol in mac80211 when the driver supports
(Re)Association frame encryption. Since EPPKE mandates (Re)Association
frame encryption.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 net/mac80211/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index bedc81956fbc..93af2f58d7f7 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1598,6 +1598,15 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		local->sband_allocated |= BIT(band);
 	}
 
+	/*
+	 * mac80211 supports EPPKE, if the driver supports (Re)Association
+	 * frame encryption
+	 */
+	if (wiphy_ext_feature_isset(local->hw.wiphy,
+				    NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION))
+		wiphy_ext_feature_set(local->hw.wiphy,
+				      NL80211_EXT_FEATURE_EPPKE);
+
 	result = wiphy_register(local->hw.wiphy);
 	if (result < 0)
 		goto fail_wiphy_register;
-- 
2.34.1


