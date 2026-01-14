Return-Path: <linux-wireless+bounces-30815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8E7D1E5B7
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 12:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF3D3301E928
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 11:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F27378D86;
	Wed, 14 Jan 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h1e2MBZY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DWfGmsH+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D8C2BE629
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768389573; cv=none; b=S7VeNmY/bvY2VZXknxmLbRRnyELyhho2Wkp/rd2GYaLH+LaoKAd7seVyMh0zz44vHp4BVNIX8EMKwiqruTrJ+hu7lQMOj9s5GyV4zkcEx9XKk+MbJ43Z3jO8SxZhuYiOSgqnsX3g/IiN4UruFdMfFBbSyk8rPnzkk8lbr8YkgEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768389573; c=relaxed/simple;
	bh=zFNNedB9afWglmdxWCQw5icXBLHG8f3IGqplDOg3QcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sqtDJYzyQwjUEcW/ojWPI1MmnIJ5xmPXCwxXI5fFOd1n6nNN7B0cEREdDiLnhW/gUdyjuYOUY+OEh1W7Lzu4GC7nYACLr/1+BGH8T0btkj3pdT6xjgQHCsLfAioTxHt5jDUDzg4cDytLtjDrYWrT6UlSbhtSX8riEiUrUMTA3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h1e2MBZY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DWfGmsH+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60E85nbZ1942992
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YyguKhOxB3x
	JM29HtCL4bM2vOUVoXG6arX79b1l6hbQ=; b=h1e2MBZYUeE3i0iE3KbjrjEvkW/
	AcG+KIhkxI2FAQzvqZBcERboO3I401PAW/Y6/MIvVvyb+JgVuz4dlGJeB3oOf15i
	Tu5XP/JYUIdWVGNV9lWqeY3yD3S5FA/RWl77meAFmMcFRR4aVfdhhfqoaLhzU1Ig
	Ht457DbkLT6mFZK/snByTklcAYtPpGtVi62OJo0yQ8qXsqVQs/jP5TtE1plMjpaa
	6HcYjXBKQ7Mr79qr375mdUBBdxo6ZykVopF5j+n3wEtsAiIilvdu6KWRyEuvYarV
	n9JWFA+SlwuQy2jAPL5KEVjHxooIeh8TUIYCeyp2Wy/5qiS7kVsOo/MzuqQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bp7b6rrxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 11:19:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-34c5d203988so5474593a91.3
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 03:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768389570; x=1768994370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YyguKhOxB3xJM29HtCL4bM2vOUVoXG6arX79b1l6hbQ=;
        b=DWfGmsH+RnaxjD3K3PRtAhn9yYq347IuPyCcDNaDAoyhGmk5/32Y+B+UsHtid9Dgy4
         69nUttQqhWCJawGl/SD8gi/UiZhX3jSShwKnmjBQo/iH2SYJrvB4UjL+OBiuhUX5VN9s
         kOKnju6XE/4CGcFNt3QnoMhZGFoS1TecfYxmkBSq93ejdjaUEFM5C6yu/Ah6+Fs7pBfC
         5+awiuDFyHUzDFPLb2otw6XKvjY9LTA8uUzhTVPYFqyhO/MGNZu7/ah71cUmbs1GvQDI
         Hpai8TRaHQCO4XR8a8mk9UCJW2djWBfYIqxOswMnjbLX/mh+KgTV3JosB0nvqeZ4+nd3
         Tfjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768389570; x=1768994370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YyguKhOxB3xJM29HtCL4bM2vOUVoXG6arX79b1l6hbQ=;
        b=IVlUpIKyvEMWEkOv739Vw/Ep2IDy6Ylkk7Zx7atvIFy0H7D6+MXRUdvvVm0CjTks8j
         bigur/V8K3geoTLL/Gob6J3jNqVlMpgl/RjirSf0o7s46nuqP2RTgZrblyPk9/7Ppu8j
         6QQjmifFuIKQ4VWb8ig1OqeEx5Pm4LkFIfBscLXXcKUzGGQYpW5/HLTzxwcHIhXDVtKV
         w1xer+LU5Ms5/gc8fzVsxe+nOz7OiC1YB39pacGJYeQAb811voHoNUOSiMvcU7Tr0lGA
         6UL1b4w/O9stpqnZVAAe/1HCOEw3NSfSCPao9J6NLrxg/lv/OAS+li4VApPYkFkqizrt
         LbIg==
X-Gm-Message-State: AOJu0YxmcZkEVjYNNdt42xMU/7jrPJIm50SKLMtsTQWW0me5m3BuFHc/
	PODfNcuMrWGXBbFLnjEdtWxF6n+92xvGxqIL2bykUMJTvYrD4CW6Kgbrd3ReFbpPVaERN2jNSt3
	Wk1wNoFwhiCfTczWf72FPfUBpBdIyDOvYjUYAqLpsyo5WztlmpPa8aZJg608SkEjANAEdWQ==
X-Gm-Gg: AY/fxX6cdg+wZT+OGX45AbQJNVw9jQqr+7e1hQLUFWywSckdfGQtXDrDlIfnzPKINIt
	j1GpTaJCQjCBKBTiqW/3HY0M2fPCA//Txr8M8TuFWD2HXnnqCmPdtjQo29QA1mnyeHI+8eipLXF
	RmqIEs7+N8YKcyTVPN1/W1x0bl4KvBLwj/P/877u9TAkVb5Gky3N7IBN6qOFc3Ih5i2qOyQSE3B
	/bwj6zDh7ks1SIAgXvVqTATttUgVMa9FazfvrO559lNCYp1Q/eEfrkmM28dPCqbpQKpD3kbvRKY
	ZRLZzCo4Hd0eseRSE8GHTdTMxrdD661GlARjxufHnL/LEvdzPaDx3BjHJfJ4LEkEbPWYmjzFOU+
	NPAaQcY4N3GNYy8q4rC+UeHGNc8IbxZd3M23DezLmtg==
X-Received: by 2002:a05:6a20:3952:b0:384:d0fc:f51b with SMTP id adf61e73a8af0-38befd3d93bmr1779878637.80.1768389570096;
        Wed, 14 Jan 2026 03:19:30 -0800 (PST)
X-Received: by 2002:a05:6a20:3952:b0:384:d0fc:f51b with SMTP id adf61e73a8af0-38befd3d93bmr1779858637.80.1768389569626;
        Wed, 14 Jan 2026 03:19:29 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cca06b2edsm22402512a12.32.2026.01.14.03.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:19:29 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        ainy.kumari@oss.qualcomm.com, sai.magam@oss.qualcomm.com,
        quic_drohan@quicinc.com
Subject: [PATCH wireless-next v4 4/9] wifi: nl80211: Add support for EPP peer indication
Date: Wed, 14 Jan 2026 16:48:55 +0530
Message-Id: <20260114111900.2196941-5-kavita.kavita@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
References: <20260114111900.2196941-1-kavita.kavita@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Jln0BuFb14RW6JtAcORCBNHl38awLL9q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDA5MyBTYWx0ZWRfXweyjQ/Fc1gu1
 nrNNfcIK2YXzZdA1eG7y8xIRx2Qu7jPWyx5XAlcMaGrEfVAK6GJtwk/OnOd3tzHbMkNyxqyLCll
 iggec2UCBNbnIOtE355d2/Rp1SlLM8iNrJFsnKA+T1lz/OtWR2t7mIFKTbXmnEz7B/a+pzmozwD
 3aZptFi57HyssxKFO3Iq+/yVn6FcDMMnrxn0zJg+9xnC/yMl6w7cReJMUDho5wH7gtMfkZCnefn
 bK2tJ5eBMYAZvy3k6rFQ8qAbUF4QdS1eNPX6H4BC0AhfXv/9r3llvhF06NCHjUYde0fugsR3fUr
 2bJT/Fqyu3dwrLVm1HF+iXzrXaIf2ektIXnHhwZsnoKVofJo01Pz9afRBW34ftgfc2nxX1eBaNz
 W8Mirpdhfi8yDG6TO2OgGj5VVZqKkHRfzGPjER4nYQa3KwCIXgG8JsNr7Y9vurn914YdIYSn7Bb
 H5UrqVfYHwF6PI56Nug==
X-Authority-Analysis: v=2.4 cv=W+w1lBWk c=1 sm=1 tr=0 ts=69677bc3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=9dOlbBCAFMcID_eLY7AA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Jln0BuFb14RW6JtAcORCBNHl38awLL9q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_03,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601140093

From: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>

Introduce a new netlink attribute NL80211_ATTR_EPP_PEER
to be used with NL80211_CMD_NEW_STA and
NL80211_CMD_ADD_LINK_STA for the userspace to indicate
that a non-AP STA is an Enhanced Privacy Protection (EPP)
peer.

Co-developed-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Rohan Dutta <quic_drohan@quicinc.com>
Signed-off-by: Sai Pratyusha Magam <sai.magam@oss.qualcomm.com>
Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 2 ++
 include/uapi/linux/nl80211.h | 5 +++++
 net/wireless/nl80211.c       | 5 +++++
 3 files changed, 12 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index cbccedf32228..6d8e35a0dde4 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1785,6 +1785,7 @@ struct cfg80211_ttlm_params {
  *	present/updated
  * @eml_cap: EML capabilities of this station
  * @link_sta_params: link related params.
+ * @epp_peer: EPP peer indication
  */
 struct station_parameters {
 	struct net_device *vlan;
@@ -1811,6 +1812,7 @@ struct station_parameters {
 	bool eml_cap_present;
 	u16 eml_cap;
 	struct link_station_parameters link_sta_params;
+	bool epp_peer;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 60573334e086..eb92296457c9 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -2973,6 +2973,9 @@ enum nl80211_commands {
  *	primary channel is 2 MHz wide, and the control channel designates
  *	the 1 MHz primary subchannel within that 2 MHz primary.
  *
+ * @NL80211_ATTR_EPP_PEER: A flag attribute to indicate if the peer is an EPP
+ *	STA. Used with %NL80211_CMD_NEW_STA and %NL80211_CMD_ADD_LINK_STA
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3541,6 +3544,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_S1G_PRIMARY_2MHZ,
 
+	NL80211_ATTR_EPP_PEER,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index df159a5f1816..3d74bea09ba3 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -932,6 +932,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 		NLA_POLICY_NESTED(nl80211_s1g_short_beacon),
 	[NL80211_ATTR_BSS_PARAM] = { .type = NLA_FLAG },
 	[NL80211_ATTR_S1G_PRIMARY_2MHZ] = { .type = NLA_FLAG },
+	[NL80211_ATTR_EPP_PEER] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -8792,6 +8793,10 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 			goto out;
 		}
 	}
+
+	params.epp_peer =
+		nla_get_flag(info->attrs[NL80211_ATTR_EPP_PEER]);
+
 	err = rdev_add_station(rdev, dev, mac_addr, &params);
 out:
 	dev_put(params.vlan);
-- 
2.34.1


