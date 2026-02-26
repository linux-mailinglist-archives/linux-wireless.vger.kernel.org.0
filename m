Return-Path: <linux-wireless+bounces-32218-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKOCHn2ZoGlVlAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32218-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:33 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0591AE285
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 20:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F36CB3072BC3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Feb 2026 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCBF3B5315;
	Thu, 26 Feb 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FX+Gtz4l";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RHJ62wf5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3431BCAE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132181; cv=none; b=hWaJyn6HpcuQdA8+rWSejndZ0mND3wNK4nsAueIEMZajETtZLYuiIsmnMuOsPXT8ZSutmVXzj1HCWkufximnU2d3eqllr/DqhDQClFCcxwEItz4FXsxQ9HB0Ldeg3KxbFb9/V50OJMPOHKaFS9ktQlOAvBUUTJ5CSMdbqQ7TGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132181; c=relaxed/simple;
	bh=djqWPTJKO8U0/UwYJfExhtI9bGwKwosMR603nAcs9nI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pKpKwZJvMqbOx9yOo92QjotoYnVINmEqa9H43V3UDy5iFMir/JGC1avEmLhKq8rBQi1xxCZMOZkjtBDCkIskUJaNtxVgKcpToCC67oS7X3UbV3dsoCPMaYhAyLTH4rRLUPDzVE79nNW58WFC39DTEmhQdp8MIB0KK+DigDpDXbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FX+Gtz4l; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RHJ62wf5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61QHEefE460719
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4rsrBN5wo4u
	8poalGnfHAdlr3yEpFHSDvKW0VouEiuk=; b=FX+Gtz4lEbzvFRje6sih6vUJORw
	P4XtY1pRV59DQjlNg/eOEB1gcASttJJejdO5HQLSIi1S7IKjdMMJL97XOPZ+Q15a
	FYmMX7SKmq34obS8SV6XgYJKc0TlVsCb8xEGsFSUnLbJp7EDBmkvv9xvkkIUuLp/
	UTPqKUe39IhN3Rs90cY0JrggCW3vnirw0vCUUnO/uun5pvUdOFk1KYUycl6i1Zt9
	loGx+cLxp6XJDSb2EWE4WZKyZvQhv11h4P6YjmgdOjR4Pkvh36Cb0ynpfJXUb8Dg
	bvOjzCm6WROiAzMmvUK1dZP34w1ovkPSHFDLkKzl16L99LDIIvsngpzK0qA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cjn0x1mhu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 18:56:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3562692068aso1696955a91.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772132177; x=1772736977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4rsrBN5wo4u8poalGnfHAdlr3yEpFHSDvKW0VouEiuk=;
        b=RHJ62wf5yjry8OonW7KThpBTtb8ch9GBh9T1ZCU6rLakhoaGmiGxFbCFrFqCA4JGnT
         zAsepxAXNIu9FlvYH/71mGD1gbh0Ej8IWgWy5tmo3UHMSZ4Oz6zmskujnD7sLq/1IBjQ
         foA6sG2sOZSKutSifYhqJknwR0219Li8xrZKpbDwrW3VpsKXLGX8oso3cujoE+XQa8+P
         UbEB2gJikaxv1AKhjyMSj7hVWbaLUhXm5GnAHgrlR5vJW+syRjbmo63IXRlKHocQAun3
         cXYK7F8ueM8CC/J4A1nuWyM7mtfP+Y1A7ookiF8y9sccRfGHjSGWkMloYhxZ7qEvOd8O
         7b9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132177; x=1772736977;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4rsrBN5wo4u8poalGnfHAdlr3yEpFHSDvKW0VouEiuk=;
        b=WslDxMP2N0iZpGIJKoNu3NoA8STFeFA+34W7lSDlmKZuV6t6kCS/eqUGXXrX5q4K8N
         14ffXgKVI+oucvci5AziIUsX0FG0rX/FKfOrVs6ADhCW0enJEQAWPlZlh20hBFf01SRm
         mFuWelIxpUK3XjlgDxqVnjkkL8gj5v4A034DuWwdB2Qe9eZ4nupSoXe//HTSxw21ZFDW
         RTFI9PB3Y48sSvGB9+OAAa2nec/EYxLrSeJjIwAS3ZJvgI5kAkCYF4mtWN7MGUXCepnO
         fpoQl84Di0h/OnBtNtuOCC3butJd9Kvqczn3Mg4lHnj+NMMovixk7wqgd4fyhHG8fop6
         Jliw==
X-Gm-Message-State: AOJu0YxmqPqTDgXJ+9cefn/7nK5wpVMwdJT4RrC1LVdrlge0xTNp2QkQ
	JvKnDgBJvjv4s58A/yKpU9Tt02gicOjLjkIwdWtkI9iB9qDgwjgkCNy0+5bXid/Po4Iv8AkyXyB
	hs5+f7sm6DM9aKhuQvBkKicLk+yAzCcTDiv8Pf8/hv+KB1Qlhy6sapjPh8ajFikcXwk0GvII2z+
	4Dtw==
X-Gm-Gg: ATEYQzwCsSTqVYbLiqVtjcMCoH8uHoOax9p43aAXnQO3/fDlinCqb97hJ0kCSo2FBNn
	LVIUbyNWBJdM9WW+11WfWh9lv+ajkLK5Kep2Efxnhk9+xTZyC3mnRPlG87KsQp7rjNAdLAG/wKQ
	l7GLKpIFzSbofzCwOhmIx3RlDTqTJij+LvZAMATPySEQiAK+/DHqLK7rg/jmcOccuaTRExIn3Kk
	HxvRB1n5W8Bxk/wqKsxV93ncpfWD/HyMjpjle0S/oLfCmoYMpKyI1aPPmmGDluzNua4+JBlnLdu
	zG2jkncq220B/XQop2b9ndGS6LG5y7Lv8eipO4Dv69HQm5UzsZkCH2YYKvrCE0IarG8FjXV1vnF
	zMw6isc+Gvd4ziZKnztUpFK5CHfN5qf7FT4cjV3K5jaRMDhyq1kWAmw==
X-Received: by 2002:a17:90b:28cc:b0:354:c40c:7010 with SMTP id 98e67ed59e1d1-3593886599fmr2625340a91.11.1772132177559;
        Thu, 26 Feb 2026 10:56:17 -0800 (PST)
X-Received: by 2002:a17:90b:28cc:b0:354:c40c:7010 with SMTP id 98e67ed59e1d1-3593886599fmr2625333a91.11.1772132177050;
        Thu, 26 Feb 2026 10:56:17 -0800 (PST)
Received: from hu-kkavita-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590158f8a3sm6375579a91.2.2026.02.26.10.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 10:56:16 -0800 (PST)
From: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 1/5] wifi: mac80211_hwsim: Advertise support for (Re)Association frame encryption
Date: Fri, 27 Feb 2026 00:25:49 +0530
Message-Id: <20260226185553.1516290-2-kavita.kavita@oss.qualcomm.com>
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
X-Proofpoint-GUID: dyDljkBLzbec_45l_maPTYN8Mn5RiyXz
X-Authority-Analysis: v=2.4 cv=I9Johdgg c=1 sm=1 tr=0 ts=69a09752 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3Ng-q8XzLfVAo1ZYyPMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI2MDE3MyBTYWx0ZWRfXzBu4Y3+MKgiT
 8r888uHfaOd3Dcya2PYD2bPa3hU4m0nPZAHFACiuu57beu9pOzN373sHGMJTK60Fb7eZ8iGcmZP
 oyqD/oSw+yQMoFzfvRqUCoAzI+1QeTxnNKMEUZpDP5g52B+J5YMU84r+d7YeSeNtUocnhAJ+cJG
 tf/ZIkfuqAx/LQckTYOoJafggk7O3jNZIAq/wkThH1rtCPRA9DJ26iec1S9s9LKQ838CZDaz5Gc
 S1WedYlNpu8Uq0Pra+X8ZVsyE60nh41CLfZA8BaBjBKKhl4lQyRIF108K4gxRJ/HDaGmmqViTVD
 vl8GPnbaWHHw4uVPPzWsyM3DWGQ3T0c7cr82jxvvmGEcpnqJJxJRaQhhBHtU+nY/Uc1a1X44rUy
 VPreTTSqz9SLPTXx+LeZvIdgYMOmny0nUjmtbno2OtUQP8wsMMaoZo+CaaITuF6Wcqz7N9nccLB
 uGzfLaGZpCtpIXbRwpA==
X-Proofpoint-ORIG-GUID: dyDljkBLzbec_45l_maPTYN8Mn5RiyXz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-26_02,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602260173
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
	TAGGED_FROM(0.00)[bounces-32218-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 0C0591AE285
X-Rspamd-Action: no action

Advertise support for (Re)Association frame encryption in mac80211_hwsim
for testing scenarios.

Signed-off-by: Kavita Kavita <kavita.kavita@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..35f6266acf4b 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5639,6 +5639,8 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 			      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
 	wiphy_ext_feature_set(hw->wiphy,
 			      NL80211_EXT_FEATURE_BSS_COLOR);
+	wiphy_ext_feature_set(hw->wiphy,
+			      NL80211_EXT_FEATURE_ASSOC_FRAME_ENCRYPTION);
 
 	hw->wiphy->interface_modes = param->iftypes;
 
-- 
2.34.1


