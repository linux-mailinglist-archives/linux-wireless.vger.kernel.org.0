Return-Path: <linux-wireless+bounces-30754-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF7AD1AA84
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 18:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86C1E302EA08
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 17:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181842FDC55;
	Tue, 13 Jan 2026 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="haPXRqEP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PtRDpNO2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DB1FC110
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 17:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768325639; cv=none; b=p0HeIGpOx8UnAFMD9vEsLmRR0cT9OI3ei+spUM22WYRiQzXypNyB0p+32qeXwQgB/9mPrEq03aYjMungFZP6vK8DK6UX744hkGP7wD9HIfuYVx+0DUKm/0Eze0VJOgNPlzdgDnJcB3fqJ385Utw814bGIUuXy8FYCOz2nbsyEV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768325639; c=relaxed/simple;
	bh=NQu4soOgSwXZIIPjdH01VO9TRuR3rnbdSL0573Ux7pg=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=Hp0rpCtan/8mjzB1gHMWfxOVju75ki/DxNDBX95s4f4Rzis8G2PPl3BPL2amxQD7vcP6nU+p3UuwMDTTqR+TSq89uPvWSH/aQ6fXtYLZ/FBBmjzjKNnUo9Bz1oPu2P3BHA7PuyLK+c5kn+pWjxlL5vmspPkE6nZ4K7FVY2nBxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=haPXRqEP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PtRDpNO2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60DHQ6ap693889
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 17:33:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=3WDCTtPX8ZwvNdg61wmwVg
	Z/agZZgdp9VQEclxu8q5g=; b=haPXRqEP52EHnTIMb6QTDSdDWJVDOJ4csdx0s/
	zIf0AQdYY/lNEkeLBdHgez+ZwJGhmnonKLyuOyZfT+88pjUcYXViXISS/PnlN67h
	6Pn9FHGlALVtUqEiTiik8GWQhOhkC4a1n9ep+RPjVHtBrWQ8dDfXRL3RAN90qk+8
	KW6yOBJsEcBMXqCfJvE8+fPsItsPr0yYiVSUrBy4iRupDDiJ1BDjue4YzK2cFfwD
	woJJ+FN1mcGqn+mc8DLDcJNJ9fOyntYiGyWH8k74cXnuFk5eqESVJaEFuSXSmwn8
	rz1/vQmQeWRDaGNy0M07Bbsa1LhhdAsMMQziY0nVpSbqNZAg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bntet00v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 17:33:56 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-2b062c1aa44so24461547eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 09:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768325636; x=1768930436; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WDCTtPX8ZwvNdg61wmwVgZ/agZZgdp9VQEclxu8q5g=;
        b=PtRDpNO2/n9NPDSWvxZuulYhhXt5vgOQjCzGTwfiHuVj1/Q/hg6xtbGXHhPiETAz+U
         nvm3YFSIBV3c9xQjlbjT0gdTATKk83Uw2srjjytWCxRCjYZSrKVLQLLE94ZHzMb2NXg3
         3Fwm6fd+sjckPvtWLblNt8JuMZkM0U+TSdBFLMW7OXbwbQvId90wniKyPQpNFjWOGeIB
         FvI069G1M6rTybr1bosI1yTXzpgYW/AAWpZjTZsnoycscyQQZ1w/lRb/3QyXxdIsZDpD
         DeHrr6rtrylQ93YNxhtUleeYu9RvhUkR8VM+v9QziykbcLwBBbxHydMWbyPVV+f4iusO
         oysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768325636; x=1768930436;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3WDCTtPX8ZwvNdg61wmwVgZ/agZZgdp9VQEclxu8q5g=;
        b=Fy0y8S0K4XzMSe+YFyPSK6v3RlcT+s3U1XYyePMkzHFvMg/kkMU1Vy8MWdUkUKrwnN
         i6ixlx+mZeHU7O6L/GSmUWvXkLzDikobs6fWjtOcRbhzVAAHmx1zoumvJhnxZc2EyWne
         9S2u0lI3Db8oY1RUpwzVb1Pxv3vbVfIfzD/K88JfTIoQFku3U0XUa7cdZO9zoA/pSHvI
         K5i/SYfA9WORxzf/cFCZoP7My6iIqtFaW6qGgnkVYaEZnH1d8CWaGvctEpi7vO2W4bMF
         MV+l1xDiTr+JkF+036CHaITXb8r5fMM6tExu6FxDcfjDRQBMNvSA0t/tSMxgNYPbsmrE
         TJmg==
X-Gm-Message-State: AOJu0Ywm9prfOaJOSmGUhR62dQxBjgMKAEJwdSSYl7CD1WmSSTKdwmmQ
	oP5SJryH4OdQXMWWtIBS1DUN1vGF++PMjuiNoRNPS1FwaOJcAuLsv0qjuvWyLyV3mgbHjl55s84
	DWlpCknJadOTSZaCv+wcTqfw+yclI++CnRyC8IH/idoaAZGNNekppbViimSuFbiZ6sNHwB5ebJU
	RM3g==
X-Gm-Gg: AY/fxX41iIHS4Sfx5JIyp/PLD9nBx77iq6RHZNg/H31d6SuJSxpYqd3TzYdPY+8HH29
	/HMRtZ9kAowJRwKA78HFS4bl1Jf0vgq5FDov0XdZKgW+x9w27U7LijizO1CkZgTLt/PfCYzfMJd
	0SnDkrBZQiCiMO3rhTFysdDGf2ZTzTu/jRq1NxKWJ11vNsUTdcGJW0bXJCmDMZ2IxbUGTDt7o1S
	gbu8FRXgm9ayemK5z8M3V9MePTtAMAZ35x5zsdce3Ch6xV5nJJhH4JKBHr937HPuqGOFC0TyEIR
	0gQmmv4PLMtAJWeTuY8bfx5bwysUCvbDb6+riUi88RZy71wmRLfku59v4xMu4VzY7IxbbZMDxkY
	KcLoxCntmkUWqxbQtTxyil7oFHb/F/utVEZrXtYSBLOR+OA==
X-Received: by 2002:a05:7300:e9ce:20b0:2b4:7971:fb66 with SMTP id 5a478bee46e88-2b47971ff25mr891141eec.41.1768325635978;
        Tue, 13 Jan 2026 09:33:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlVV5wiowpUo2Nox6aqo/BkpUnum6WEyQXQkmPHOgyzMlaQ96MbXJbsrdZQzciQWHXFabJGA==
X-Received: by 2002:a05:7300:e9ce:20b0:2b4:7971:fb66 with SMTP id 5a478bee46e88-2b47971ff25mr891106eec.41.1768325635342;
        Tue, 13 Jan 2026 09:33:55 -0800 (PST)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b45e73b401sm1283444eec.21.2026.01.13.09.33.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 09:33:55 -0800 (PST)
Message-ID: <98386125-c0bb-495e-b2ba-2765aaed19d8@oss.qualcomm.com>
Date: Tue, 13 Jan 2026 09:33:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-wireless@vger.kernel.org, Johannes Berg <johannes@sipsolutions.net>
Cc: ath10k@lists.infradead.org, ath11k@lists.infradead.org,
        ath12k@lists.infradead.org, jjohnson@kernel.org
Subject: pull-request: ath-current-20260113
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: WctVts59LhLhRI9PQxwOZRiYmVL4dsU6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTEzMDE0NSBTYWx0ZWRfXxDVSps73a4H4
 eQU+znukx3tACtZywjdyIF0nwc5GyjSVaFTkWzzXExXYSQtcuyNDJLBIwW7aYsEh3Z9T9gWlv1q
 dzf7j+aQ6/bVt+flWbtDvKsYZovSITpRj4eU8lQiFlRNfpKrtse/1YsY3C+I9tzeyzIoRiNPvXd
 PVXZ+WUATW0bzI8jALsMpQsvnZRhmqWxbe7LLx9BHpCFJ628qP4V/mwMZPjwfz0slsXdcq1Ygtc
 NpndwD3IKL9re5iTTxIU2wveD4GDCw9FwT8c2Ygpk3dpXSIXrja0hasq+D5N1BR0RG50HubSpC3
 ON9frHAQRpndtAx6GxSaPMnyXjTM30dFrzF6IjQ2g9FVqYdEkOjRyjdaWD5tEmTqcr8nQxxEeKe
 2e7JTuHv7/ESRnDOqUZ7CpO8QKfbF2NNMGPBVjIyOL4WvFZ7JM98mVQkjtEB/NZDuPXSjG9oPax
 hs/onO9VHtZNBfPgdmw==
X-Authority-Analysis: v=2.4 cv=TMlIilla c=1 sm=1 tr=0 ts=69668205 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=jiOn_W3BcUuOKtM18IsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: WctVts59LhLhRI9PQxwOZRiYmVL4dsU6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-13_04,2026-01-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2512120000
 definitions=main-2601130145

The following changes since commit a203dbeeca15a9b924f0d51f510921f4bae96801:

  wifi: mac80211: collect station statistics earlier when disconnect (2026-01-08 13:33:11 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-current-20260113

for you to fetch changes up to 31707572108da55a005e7fed32cc3869c16b7c16:

  wifi: ath12k: Fix wrong P2P device link id issue (2026-01-13 07:25:02 -0800)

----------------------------------------------------------------
ath.git update for v6.19-rc6

A collection of small bug fixes in ath10k and ath12k.

Note to maintainers:

This tag includes:
31707572108d ("wifi: ath12k: Fix wrong P2P device link id issue")

That commit contains the following:

Note to linux-next and netdev maintainers:

This patch going through the "current" tree conflicts with
the following going through the "next" tree:
commit 631ee338f04d ("Merge branch 'ath12k-ng' into ath-next")

The conflict resolution is to leave the following file unmodified:
drivers/net/wireless/ath/ath12k/mac.

And to apply the following patch to ath12k_wifi7_mac_op_tx()
in the file drivers/net/wireless/ath/ath12k/wifi7/hw.c -705,7 +705,10

 			return;
 		}
 	} else {
-		link_id = 0;
+		if (vif->type == NL80211_IFTYPE_P2P_DEVICE)
+			link_id = ATH12K_FIRST_SCAN_LINK;
+		else
+			link_id = 0;
 	}

 	arvif = rcu_dereference(ahvif->link[link_id]);

----------------------------------------------------------------
Baochen Qiang (2):
      wifi: ath12k: don't force radio frequency check in freq_to_idx()
      wifi: ath12k: fix dead lock while flushing management frames

Manish Dharanenthiran (1):
      wifi: ath12k: cancel scan only on active scan vdev

Thomas Fourier (2):
      wifi: ath10k: fix dma_free_coherent() pointer
      wifi: ath12k: fix dma_free_coherent() pointer

Yingying Tang (2):
      wifi: ath12k: Fix scan state stuck in ABORTING after cancel_remain_on_channel
      wifi: ath12k: Fix wrong P2P device link id issue

 drivers/net/wireless/ath/ath10k/ce.c  | 16 ++++++++--------
 drivers/net/wireless/ath/ath12k/ce.c  | 12 ++++++------
 drivers/net/wireless/ath/ath12k/mac.c | 16 ++++++++++------
 drivers/net/wireless/ath/ath12k/wmi.c |  9 +--------
 4 files changed, 25 insertions(+), 28 deletions(-)

