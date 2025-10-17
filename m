Return-Path: <linux-wireless+bounces-28003-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CCCBE63E2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 06:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E13E621EB2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Oct 2025 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DB5823DD;
	Fri, 17 Oct 2025 04:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ldBnPG3J"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7FD1643B
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760673774; cv=none; b=gTyem++2SFpAuxWiWMfcQWWlD4C77TRQ+2CAu+YVK/19pJ6p3aJT5d9DfpAtgrX5SDWoqak4JhqDt1AT+VC89AmsD5XKD73ru+cpw6Vfeb9H5jlQCxskIhcaxYpn5xwj2lhU/yACDAm/Uk0XDI5VhXUUfMjV3YvfYB8uidjqbjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760673774; c=relaxed/simple;
	bh=qUCmlwco6LFpliHjmSkYBfxdHOHZ4wY/18jEY+blLK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mWjvq2t2aNkAHUAAu4SiEauSWRojZy13qTOOjspGavgKH7uTxi/4La0I6buvcYWrYWefJOr2GhPlAnZKNTMpvsdGRyb7YOM8qS9f8qkgYxXSykELB1ujn7sHdAsn0ykMNwAuufqX3vF8/X5ia+DJOd8E8Ov04Q/cWwijK7/ldvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ldBnPG3J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLbq0002679
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=LKJtqBqwFHaUM04CXOGGfS
	lfueOj3jTdPSGv9RKvqHk=; b=ldBnPG3JmKmhyYaYWNmI6iFjjQ57W5cZ3F/+X1
	2S2PV0oEphsf5Ouy35XIFFHEwtna38+RHjmbOaaW5FHgZYane28JeX+fnjRyacJb
	DvHzwIof+aL9tkFLS2U3QBWEDsOVz9o7sRO17aadyun3jiUNGedRNIziCbtRIb9R
	D1U2kfaQNuvQq12r9ELwjpi8q4hB8n6ptJtAsD+868u4jRC90uyTZ5O7uWf8C2+B
	lX6MuXkcPmrGqmd9sLKfCqCd/9Ab1SNwPE7MiKycKeFlgbJeqJBZjY+cmw9vmq2T
	RTKh89LDztcvbwjLxSIp1Rx8l4b0LXU/yuJwVPqsTyqPk2ug==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfd9auhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Oct 2025 04:02:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2909daa65f2so18452715ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Oct 2025 21:02:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760673771; x=1761278571;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKJtqBqwFHaUM04CXOGGfSlfueOj3jTdPSGv9RKvqHk=;
        b=PwXKmP43kZ9aibjyYCpcSKsbiQV5zU8b3j/8Lbt9S0jjsdYx6dhjEpLno9YQZlRo/H
         zoZ35EiCmCjRsPyXRfPDtMzJrL3UYClZxPdnZ5TRLX5GCCnNBgIBK0SU6c1Uc4hDVto8
         aFExJKZJCMECrBUfovUsufzIIkvE2AMOY6j+YHHr94LQSwpn46lSYM8Ded4PPfydNJof
         b2VLGx6gM5peHjyqbhLS2NOEVYFD+ENY4JvgfkhbYoHQniaUrhCt89LyxK8z5qrXMOBh
         CKOHor1uijktfDoYcA+STY58VqPGIFNsjawEiei86Qw/dLVeCTtViZRPoVOwvXbMwUME
         Sw1w==
X-Gm-Message-State: AOJu0YxCEzD+VJI9PAWuz9Ggelb3QBknIw8Ll/h/FOdIdY1l6XeTHGug
	Ei8o2nT7gNwH4ZyO65gR1ZA3FvfzLh0spRINSJ0baFGZ49rsi3lN9uhdt59dAbdJfH0lYeUdHrX
	YXssTQuxVDgtmxBMtNbNS/sexqIQ4rb+IvA+Mye3S0STceoWoX+55vTWQDR7N3Jx4OzBOLmYo6w
	tpBg==
X-Gm-Gg: ASbGnctxDj6A3IJ3O6MH472FLUZiTQ6Nh3SNriD5V6DCPfwjnG76411fwYe5Ofs9Akc
	KsfrJCOZbdYBY8gfPf7coeF+E3mujUqTenUTCPFZpqdG5cVt3IYazhpmRxK4vIVxiXfqAiZ73fY
	R5TGisiLj0kzGL64CtFSaSjaJ7sWGTDF9VvZCRk8QZvEJWg03NToNy19CLne4fXv3fquv4bgGiK
	ryi/PA1nnO5kq3Me7l9hDX5vnvcnHvGVxuAo25ZqgMfNrs1om705t7huBgBQGqCn56IqwVD19uk
	odU1CMOMyiiKHwgyAQIBMSi1L5+W27X5XMKwamgqa0Zu970BAXw7EBPyngNLR65L22OtSOqOlzs
	YsdLBPuiIgkYVuNP1IueGM6bNCNwt4eP4o15F5Ma82HrqiEDVqRrd+Fjuzry4iLRVuc0Uj2CVcj
	YoUYal80JZ+JpVFcC/oYRDAyM=
X-Received: by 2002:a17:902:f64b:b0:262:f975:fcba with SMTP id d9443c01a7336-290c68e2eeemr27479825ad.9.1760673770659;
        Thu, 16 Oct 2025 21:02:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKeQFKsAlvfnZHtq+UbKKvYnVqLQ2FEk0e0bHP8Q5+fYl9zuFzCeIZealt28y4nptUhJMBKA==
X-Received: by 2002:a17:902:f64b:b0:262:f975:fcba with SMTP id d9443c01a7336-290c68e2eeemr27479525ad.9.1760673770219;
        Thu, 16 Oct 2025 21:02:50 -0700 (PDT)
Received: from hu-adisi-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909934a8e6sm47682595ad.30.2025.10.16.21.02.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:02:49 -0700 (PDT)
From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 09:32:41 +0530
Subject: [PATCH wireless-next] wifi: mac80211_hwsim: advertise puncturing
 feature support
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-hwsim_set_punct_feature_bit-v1-1-3be1bb3450c0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOC/8WgC/42NWwqDMBBFt1Lmu5EkVjD96j6KhMSOdcBXM/FRx
 L03uIL+XDjcy7k7MAZChvtlh4ALMY1DAnW9QN264Y2CXolBS10oKY1oV6beMkY7zUMdbYMuzgG
 tpyiMNsbdfC59qSEZpoANbaf9CSsF7JBZDLhFqFLdEscxfM/vRZ2jv24WJZSolcx9YZzXZf4Ym
 bPP7Lp67PssBVTHcfwArrQ6RNwAAAA=
X-Change-ID: 20251009-hwsim_set_punct_feature_bit-9299a4b30b82
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: coUeFzLHVEhwEX--uHGHQrQQHoATwZGX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfX1+VQbFi679aw
 DE5TciENLv+VDv7ZHFUZSor3npRiFyfGegRndEuNeJ7YHSYxULMiJgWckuRAhVRGj2k7Lej8J33
 bpTNObaI8je+NWgbr3uQgaPgFCz+YNqvEcgGfKQV16AZtAhWdfxbIW4A9dGNyQF4vZMITx+kMAr
 aJ6GNcniyypYWM/IgzoyTI11iE9ajRm8rNE0yFi5xcUTV4iJaoDVrYlwWHmrswBYXEmJISrRY/2
 Ah6lrRnl54/iwC7tUxocs9bzhPu7JyimaXKNzEbFO6ukytq8nebp+d1vHM0G3RZvgWsJt457/f/
 XEKjRaR8mA8gS/y69J03s4gSRdBZTkcZCGQvvo/gIWGurPSt2hiy0UGZqIh9I4mmlDR3K0ZoMvL
 JnKskjqKbcGU9EFbZwZQqKlA6cX0WQ==
X-Proofpoint-GUID: coUeFzLHVEhwEX--uHGHQrQQHoATwZGX
X-Authority-Analysis: v=2.4 cv=PdTyRyhd c=1 sm=1 tr=0 ts=68f1bfeb cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=6mnrFCliqZ2cnhrunzQA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

If userspace provides a puncturing bitmap via the NL80211_ATTR_PUNCT_BITMAP
attribute, the kernel with mac80211_hwsim driver currently rejects the
command with the error: "driver doesn't support puncturing", because the
driver does not advertise support for this feature.

At present, the following hwsim test cases utilize puncturing, but the
bitmap is not sent to the kernel. Instead, the puncturing information is
conveyed only through the beacon data:
 * eht_5ghz_80mhz_puncturing_override_1
 * eht_5ghz_80mhz_puncturing_override_2
 * eht_5ghz_80mhz_puncturing_override_3

A future change in hostapd will begin configuring the puncturing bitmap
explicitly, which will cause these test cases to fail unless the driver
advertises support.

To address this, update mac80211_hwsim driver to advertise puncturing
feature support.

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 9f856042a67a..cd84dfd5b47e 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5793,6 +5793,7 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		ieee80211_hw_set(hw, NO_AUTO_VIF);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_PUNCT);
 
 	for (i = 0; i < ARRAY_SIZE(data->link_data); i++) {
 		hrtimer_setup(&data->link_data[i].beacon_timer, mac80211_hwsim_beacon,

---
base-commit: 94aced6ed9e2630bae0b5631e384a5302c4b6783
change-id: 20251009-hwsim_set_punct_feature_bit-9299a4b30b82


