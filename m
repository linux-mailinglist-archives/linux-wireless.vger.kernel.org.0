Return-Path: <linux-wireless+bounces-30602-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535D5D0AC54
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01B9330124DC
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 15:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8053D2135B8;
	Fri,  9 Jan 2026 15:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQHxG08E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4V/UteX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241BC19E819
	for <linux-wireless@vger.kernel.org>; Fri,  9 Jan 2026 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767970819; cv=none; b=mrd2bLDaS43ZDrQlJKxkskICgsWbssU84MTODNCq5/eSvANhMLKIjF4FMKHgpRerjjnBwbf7WOMnWXLF3uEwwaClTO2GdtJZ/grAEx31v9g4scOF7plV4x5BaXzLxyzDqRRMsZ/jAQX+FuKqclmTWgS2d6mdi06cASwXZSkCNEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767970819; c=relaxed/simple;
	bh=W0e17JPCErFmeXEqRtatxqOxZpqXn6HiC4m5gVGqaQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=q3ZL5RSwkv4vjl2+W7NB8E7fSBFKU9doUudCaUHXWw8izr9w3nCeZiWYY0m7ZoiC2m+efE64xZFG9xfVF5jaFFPxav533NH98Ack3kq1G3fl7FRT2UWa3ujEzBl55MO3eJOKWV4egcnaTYPqUmLHSz3SrW7pUaxU1xasznigEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQHxG08E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N4V/UteX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609Dwmg93141617
	for <linux-wireless@vger.kernel.org>; Fri, 9 Jan 2026 15:00:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ABxeclk2Cz+fYEYBZMCjIC
	l/nxfHYBr7XSJGrAq5U2E=; b=WQHxG08EvSev+rR+vs/rXsErWngeg2WpOE76+L
	LGoHRo/oPqZnmx3UrakKahSarrxaLYdz4tKEj5fgaU2kNlbO4e2lnelPtrMtQ17D
	LkDbHucwXMk8WugJr5kVnAqi0fr4snlkzPTkhlrSBdeHKMK2lZDWBeRtXYCt6q4Y
	SYQ/4kMr9yYQZ1LpuUUa7A23p1GTgwwUMiTG/+VrkIP/u4aIRQHMhR1FZR2+gc47
	CsoYIfdy11oBI3OEvj4JcMO89I+9xU0fO2y5D1wf5djqO2n/R3oXFH3Kly6jgY7F
	DB53UgYMhTSeWRBYRalgljLjUdGS8rEy5QfY8QOHJx1F2nEA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bjj8j313r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 15:00:17 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-34ab459c051so9752364a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 09 Jan 2026 07:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1767970816; x=1768575616; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABxeclk2Cz+fYEYBZMCjICl/nxfHYBr7XSJGrAq5U2E=;
        b=N4V/UteXbIxVTqMAZ6KawfbTsyMjhZ1Zr9oe5mVkD+rosrltq4NR67A32RqkKDKcg2
         dSuR7BAH60rBaL60E6qiy+xGf1BtSrLRkP3I7/PlrUd/KEgUrFCHss5uRARZfgDJQjye
         5rlhIdo8cz51O/qVzmBT/4J51xHlaeitiRxwOc8fZTQlaUUTfU6nSG17BAcKCD1txtxN
         8UcsZ2GYW+si9dgQK6UQTmj6k7VG7g+/mT7pBaeNgAUaMMr0IQUcvifKbLcFNKPpPROY
         al9ikhbSC9iM1kfw+DUTF7sUbSKw9JjYebRBejR2wC1WEc/L3X5xZKpdoyQWA8If2Jzg
         h3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767970816; x=1768575616;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABxeclk2Cz+fYEYBZMCjICl/nxfHYBr7XSJGrAq5U2E=;
        b=g3VesJUtHD5J3lwsLhCsn1USo8iBNR1GvIl8AHZcddDi9422nb9dOjwhBbOU6mUZCn
         GLXSIv/uYpzH36H95DwuN5qESomYunAvMsIT57bXvyWSUmWRK75WM5O7QNIC34FTuEtU
         vJ+Biebu2ZdVcVYhmD0GlWYf2FFABdLmbJMMJ5Q5ZO1fWZT9K6nzQsoj6PaFusO5U0K3
         wZj9u1hVpQ0nWQw8HJdrL5HPaWlmRs6V/Y2lOql80k3XFi+WbuX9WnkJdnY+TN3xrBgq
         TyIkvV1rJEEqR4Olc/03puHsZgxHLVELZppph+XX/lIL3TwP5Oip+T7PB3g9oqqlN/0K
         o9ow==
X-Gm-Message-State: AOJu0YyvNC42YRUkBhdnHxRC730Z+thrKhCFRBZmnaL3gpfHOVGFufZI
	seKKHUWf/hy4mi7rH0ZOVQdhLwfEju5i736yrIQdULRxSz9pvXJT6tk22iJ8GNWzUjpGFyieaxw
	/5g5zifZgEvHijprpMv38jA666XEJmR7N6niFN4KKzNPxsTbqFoFQeR+2UzL2ckE5FaRqKw==
X-Gm-Gg: AY/fxX5RRSaTe+7zdvlvCT7E4HrjGDPh/UckGza0p+XPmSzDBGmPlgXDt7MJ75JHEFv
	OlDqZyZYMAfX0pxWwNE8tsBPmnSGR1Zc5C+CmN5CyNmcvW2Xcn/x5IlO8ulZesuRNZlW7k0NkWg
	GanhtZW+faeNzQbzlxzHFu2GBEChPnMk4Ew2pjidDoYF/QMUcDCB42E6NqLhYuBOXxn2fmPaqwG
	V+oaIsxMABZHYGhDbU87CAiG4BJOwtJi4qjhcLQ8w5zbTL6dKGMVfQelGZ7xiElWhZG7OaHVG8+
	IRfu4x2zX71CJnYTjRUgLpatk6X4pXWMpgq+OicR8bwwfq91GjNVRcAGb88YdJ/TKT9rAZPPySM
	UtuYsWht84HpeTWM/NlGRpeOe9qj4+qG05Qvzb+iJmahkt75GXyI=
X-Received: by 2002:a17:90b:5784:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34f68c4dcd8mr10745626a91.24.1767970815918;
        Fri, 09 Jan 2026 07:00:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFzOca9xfKveGTgo/hbPr0BMmBHvml5knA43GN+MaN0zo0ItmywYjtPN8o31sfWBXhKf5XcAg==
X-Received: by 2002:a17:90b:5784:b0:343:66e2:5f9b with SMTP id 98e67ed59e1d1-34f68c4dcd8mr10745582a91.24.1767970815292;
        Fri, 09 Jan 2026 07:00:15 -0800 (PST)
Received: from hu-vjakkam-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5fb64b3esm10842022a91.10.2026.01.09.07.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 07:00:14 -0800 (PST)
From: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>
Date: Fri, 09 Jan 2026 20:30:04 +0530
Subject: [PATCH wireless-next] wifi: cfg80211: Fix bitrate calculation
 overflow for HE rates
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-he_bitrate_overflow-v1-1-95575e466b6e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAPMXYWkC/42OwQqDMBBEf0VybsREDaan/kcpEpNNDahpExst4
 r83em1py8LAsLtvZkEenAGPjsmCHATjjR2iIYcEyVYMV8BGRY9oRllGMo5bqBszOjFCbQM43dk
 Jc1aVSlSEZZKi+HlzoM28U89oMg468B4PMI/oEtet8aN1zz0zkP3oKz4QHEfmqqh0LkuiT9b79
 P4QnbR9n0bZQn8jQIHmglPKtHpHbM0C/aMNjaic6KYsSFTxCbWu6wsdJV95WgEAAA==
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, veerendranath.jakkam@oss.qualcomm.com
X-Mailer: b4 0.12.5-dev-2aabd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDExMSBTYWx0ZWRfX9DTA8qTF2i+2
 +gVbDWnQd4yeVW7pY8MCwBB7dLFuM9bLriQIRPu79v62R8dI0mjYf1ADgiJj4R/w1BuwvgpLjIv
 pTySv2yIKXxYx2JFNnjUBXfCHLldWlp0Px8VdOUkU70FFsMfErkmfYgbnAPx4B0GnaiSPaqhJMY
 aLGBZ2CZ7cOyxq2PHZvx3wZ3fOfwtuDpcKqtGczAwslOHD1tn/a55dOFpHJ4jLnQtJrPEfAUkvB
 gXjbKsRKelglrNqSmn820KWYMcbjfrV7AcgAW+/m2ReMsscPbDdIkVN44x3oo2+HdmDp213h/Yv
 /+g2Q2TDGCh7RNt4Tja0lpWTg8uJgxoZmu6lk6PsJm9BCXU9U70DjysXtvQg51yKN/gkCZWhBRz
 wqw1CHECny/R9kxSISuHkqLlsMEx1g/YJMewhZI81jxpDKAmwM4rcHAo1Dv73wgWWTb5QDuqs9d
 iLDNI85rGcGBT+EOXBA==
X-Authority-Analysis: v=2.4 cv=JIs2csKb c=1 sm=1 tr=0 ts=69611801 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=48vHsAWMPIeAy46LMi4A:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 20cj3R8veqepCo4cCBJWViUeUWd9jJ9_
X-Proofpoint-ORIG-GUID: 20cj3R8veqepCo4cCBJWViUeUWd9jJ9_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_04,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1011
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601090111

An integer overflow occurs in cfg80211_calculate_bitrate_he() when
calculating bitrates for high throughput HE configurations.
For example, with 160 MHz bandwidth, HE-MCS 13, HE-NSS 4, and HE-GI 0,
the multiplication (result * rate->nss) overflows the 32-bit 'result'
variable before division by 8, leading to significantly underestimated
bitrate values.

The overflow occurs because the NSS multiplication operates on a 32-bit
integer that cannot accommodate intermediate values exceeding
4,294,967,295. When overflow happens, the value wraps around, producing
incorrect bitrates for high MCS and NSS combinations.

Fix this by utilizing the 64-bit 'tmp' variable for the NSS
multiplication and subsequent divisions via do_div(). This approach
preserves full precision throughout the entire calculation, with the
final value assigned to 'result' only after completing all operations.

Signed-off-by: Veerendranath Jakkam <veerendranath.jakkam@oss.qualcomm.com>
---
 net/wireless/util.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index cc55b759694e..08c525835518 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1562,12 +1562,14 @@ static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 	tmp = result;
 	tmp *= SCALE;
 	do_div(tmp, mcs_divisors[rate->mcs]);
-	result = tmp;
 
 	/* and take NSS, DCM into account */
-	result = (result * rate->nss) / 8;
+	tmp *= rate->nss;
+	do_div(tmp, 8);
 	if (rate->he_dcm)
-		result /= 2;
+		do_div(tmp, 2);
+
+	result = tmp;
 
 	return result / 10000;
 }

---
base-commit: d66676e6ca96bf8680f869a9bd6573b26c634622
change-id: 20260109-he_bitrate_overflow-9685da8160c2


