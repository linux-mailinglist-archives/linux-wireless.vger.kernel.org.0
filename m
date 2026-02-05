Return-Path: <linux-wireless+bounces-31585-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAiLC0JmhGkh2wMAu9opvQ
	(envelope-from <linux-wireless+bounces-31585-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 10:43:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E9F0F6B
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Feb 2026 10:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C92D3003EC3
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Feb 2026 09:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8678E22301;
	Thu,  5 Feb 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JZcVHTpZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EY+dslZp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5C33A0EA1
	for <linux-wireless@vger.kernel.org>; Thu,  5 Feb 2026 09:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770284545; cv=none; b=A0D4+2BCICjxhSXbO6Jk0RxSajfqfemn+lahVnnBrbPtCI/z/mSds9zyW9Hb13oZFjAc81J5ID9hnVWgCeE4izzaYTSOvT3eLb3V7CINaOIGW2x3uMSBy8eBSFqDtdpLCn+eHHZz5+Rdi6NeL5bmgtPeIGuirwxlkbVWyYRq2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770284545; c=relaxed/simple;
	bh=M4yLjHjnbPEib3TWtX92dJVVx1j6+09RsNhLBLiw/Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HscFNr0SkE9UtA1QxNSIyiYq2gcVbJpv52pZkmFW7+vQIBEAVF2Ynn9cVtK3fpQzZ6RyWEHsowi7Uzwu+zwDlzIWh86aGuylmeP3dtxPIxspEQvlw3PyrwsgTn8OJwo9DXJN25VYoCYpZrlerAbPCsKKrh+P8eiI+n9rPqAVevw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JZcVHTpZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EY+dslZp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6153e2wL2104147
	for <linux-wireless@vger.kernel.org>; Thu, 5 Feb 2026 09:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=1aFgHVIfZ2yLEDQAzRb3TYjSWteUfgWHSp5
	wk/19zoc=; b=JZcVHTpZq9wNZamP43mvwJLck1na60GSND2L3XKEvMZMDQuinpv
	Vs64kDUx6qawhZsUCpStZeRCtxWvB+hEIBb7E60fQPDnHqgHTXao11sQk8AvqtZ4
	U0cbdUQD0rNGe4HTXvYJ+8+eCmBgjEf1FQcjWchaLvdH7B6/MbTaCcqtQ4yi6XKR
	cZCsn+3JryXBO558MlN462vVwCdZ3rkoNzSpL+Um20NRQQJ0Aw9YCbpfmxIuObyf
	Knl1DgTMmvQgJZkNuKSv5mEKdFIhfNUxPgE778tgpgqox1acqvgdSPa+3QL/tgPJ
	Q/jkvsWnNfKPFZmgFg2d5gv3p3lKxKjKA2Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c44xjktqq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 09:42:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a863be8508so11469035ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 05 Feb 2026 01:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770284543; x=1770889343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1aFgHVIfZ2yLEDQAzRb3TYjSWteUfgWHSp5wk/19zoc=;
        b=EY+dslZpmx3Uty+kKQr9pYlPMoBcuBKMDiqqpX29kASR/gvJAeolFcqw/73lg/Oznf
         Z/crHFoGg/wZX3+VgvjL7mSvmjpw6UQ0YNHH8RnGsd62/ZA7KpTzCETuo5PyUHXC9/Em
         I8TkfsAF5fWGDG6zPukxLeR+42ZS9Meh5r2wq/QHOjzaM+RGuhn87L96V/S+9GXTdLAA
         ZiZXEto++U+RDdZV0/gFDI6czMHgRJWF8ADexb/s76joy99tNN1t7R49gE7T3OLBK20F
         z7I+EwfQRhh5I8vvaXaMOM/ibAz95Ig+1iVvhL1VPHiaGJGsaln5MYf93gVDoJtRdRpo
         ZvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770284543; x=1770889343;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1aFgHVIfZ2yLEDQAzRb3TYjSWteUfgWHSp5wk/19zoc=;
        b=he/xXFRtHaRbq1HrRx3B8Hbop8Wlatq6MVK/lndiZ+y0OKUi5c/97vP2icEWke6SXV
         5sLGdxrcMHjQyQWOHX7DRefwqbkuA0kys1q69v4BJv+7LfEvqBbHJcLzTGQ8rrp5PxRb
         LX/gjQKoYRwsU3GdCZ40q6JdHva92TW0+s1KeJCFWlIFAZf1vD2V08LFE9m9Ehe/1gOq
         29unqmuKaeYCdvN1npE/EhRees3S7IVayzn2aTYdLB6DKJbe0ZNM3KEsHDbV9m8bSx1M
         gU9tOeZYZmohK4Po0tbfO5D9bfgRqhlWKt/d8FTdNJOlvyG5kn9/Vxt87o0QVsOFRK/e
         vAEg==
X-Gm-Message-State: AOJu0YwaawfvxCztQ42ctYFylob+uZ+hWfS4b47iNY9zWi8MCDMZ10G4
	+gbXQ9uMRN7DKk3YcUUs0SeW/PAX4rIXRzMXMSi1n4M0fIlLSwrgkKKbRXBDe10Gmyq++niUAXc
	bASjibatiiaRPC87Y+e6cz8xvymv4kgnQcaUttRiBaH7uqqlmDciij/qHIn3oBe+12fCAHA==
X-Gm-Gg: AZuq6aKi33dE54Oa75rdWASkVn+oS1ZVdRyY7LdbrBSiTjLT5KPzyA5CO4Bfc4espVx
	FOeu0dw4HatlVuLN22cMFJW0mttOYREoazb/KBxHB20fUCSKBKzz6lIHvVTNfetDEo0U4aR6xmD
	KnQxddbenpqUDik17FpShxHAOpA7NCAakqB+C4u7igV1XFNzDvvvPBYg3kqyQTobGs4+9bGEwmz
	8uRXOG5GYSpq9vIBUhT24hRx//ek5IKvhBqgOY+oRi2+Og5LgC/KRcx+6fLbnPFb2VRpUGQRTAS
	Y1qWhaC79VXRmUiJV3xdEY1BHwArH4swSW1iE2WzSwjXXg1Sx2oxr+E17Jzf3Bg/Qoj3y/erVfH
	OrHrD5dhqXnbLDWZz1XZoChXEgHmu2vsIEISRPVhD0pcygUt0GhmKVdWkWNLFBQp9+WbX/Q/lO/
	t4w0TQFw4tmZBFo0kGmW2Ju7Y=
X-Received: by 2002:a17:902:e5d1:b0:2a0:c1e4:e25 with SMTP id d9443c01a7336-2a934123dd5mr58228675ad.54.1770284543207;
        Thu, 05 Feb 2026 01:42:23 -0800 (PST)
X-Received: by 2002:a17:902:e5d1:b0:2a0:c1e4:e25 with SMTP id d9443c01a7336-2a934123dd5mr58228465ad.54.1770284542651;
        Thu, 05 Feb 2026 01:42:22 -0800 (PST)
Received: from hu-aisr-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933854fcbsm46421675ad.18.2026.02.05.01.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 01:42:22 -0800 (PST)
From: Aishwarya R <aishwarya.r@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        Ramanathan Choodamani <quic_rchoodam@quicinc.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH wireless-next] wifi: mac80211: set default WMM parameters on all links
Date: Thu,  5 Feb 2026 15:12:16 +0530
Message-Id: <20260205094216.3093542-1-aishwarya.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DtpbOW/+ c=1 sm=1 tr=0 ts=69846600 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9ZobptKUMGgaKLDI8xEA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -Td2vEog_PrbjJVTC8IAQPMDLmxk479w
X-Proofpoint-ORIG-GUID: -Td2vEog_PrbjJVTC8IAQPMDLmxk479w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDA3MCBTYWx0ZWRfX2Ies+3u8fbGX
 vYJiZrT+1As3ucONWAHHcUIMuupPnhXKBIeoOB2ouS9p1IcakrXa9MPLN4xD9aEVx5xmqy/VDjH
 dhGc79if9eLGo/maAG9gedJrcAt4HVSh3Nn1JoGVgEvV+bygKcKHS4E+3bPe+Yhr6QaV8h/AWpn
 McFe6NmoyV64RXfXCuxy88SZOynHoW5pHZ+TTjoaaiabAiJfqRMW5eJjgrZiuyeBkr2SST7keeU
 mEGWhbErXgxG8pJPS2hXjb+xdq9YJ3k2LekwwjeNYEQo/5gToI93e6SRllE5okX8On2QDENcSa3
 L7grZHC6XnSy0JL9rOOYa5MArfnxNiVaEL7VKeV2bHsETPH9+UcTx2pPPHkk/BVUCRsPQ08OgJc
 FchDGbaWHi+jYYlCeE14dwJMvtmN7ADjlgZEo6ZicDsr/uDfFm1do1bpCXSN0zFQcdjmCKEx6tq
 jRG0pHBNBJVpNKz/Gfw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_01,2026-02-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 bulkscore=0
 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602050070
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31585-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aishwarya.r@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 804E9F0F6B
X-Rspamd-Action: no action

From: Ramanathan Choodamani <quic_rchoodam@quicinc.com>

Currently, mac80211 only initializes default WMM parameters
on the deflink during do_open(). For MLO cases, this
leaves the additional links without proper WMM defaults
if hostapd does not supply per-link WMM parameters, leading
to inconsistent QoS behavior across links.

Set default WMM parameters for each link during
ieee80211_vif_update_links(), because this ensures all
individual links in an MLD have valid WMM settings during
bring-up and behave consistently across different BSS.

Signed-off-by: Ramanathan Choodamani <quic_rchoodam@quicinc.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
---
 net/mac80211/link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mac80211/link.c b/net/mac80211/link.c
index 1e05845872af..b659497680b5 100644
--- a/net/mac80211/link.c
+++ b/net/mac80211/link.c
@@ -281,6 +281,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 	struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS];
 	struct ieee80211_link_data *old_data[IEEE80211_MLD_MAX_NUM_LINKS];
 	bool use_deflink = old_links == 0; /* set for error case */
+	bool non_sta = sdata->vif.type != NL80211_IFTYPE_STATION;
 
 	lockdep_assert_wiphy(sdata->local->hw.wiphy);
 
@@ -337,6 +338,7 @@ static int ieee80211_vif_update_links(struct ieee80211_sub_if_data *sdata,
 		link = links[link_id];
 		ieee80211_link_init(sdata, link_id, &link->data, &link->conf);
 		ieee80211_link_setup(&link->data);
+		ieee80211_set_wmm_default(&link->data, true, non_sta);
 	}
 
 	if (new_links == 0)

base-commit: c30e188bd2a886258be5facb970a804d8ef549b5
-- 
2.34.1


