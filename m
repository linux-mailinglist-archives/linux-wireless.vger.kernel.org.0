Return-Path: <linux-wireless+bounces-23832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E8CAD163B
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 02:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAE23AA2DC
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B114258A;
	Mon,  9 Jun 2025 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W43EUjPN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8D1FC3
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 00:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749427859; cv=none; b=NKfCPdQkseJ5SkPqKiO1WaqZ1/aMYeaS+OaWBIDhSYSHTZ2KqSQ3eoqvOsvTIxAaOTsPfLyjyRaGjMgbykuPsBtS7ca7yjaZFJZRVMhn7Jvg6Q86ZVeRkZr/mxvl8AH9ylUzMO/3+OKzeJb4eNZrzZLfhTKeaQbA+L7ONKE3lmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749427859; c=relaxed/simple;
	bh=Ndo+cMKYByDpspU5O7vHHp4N8UhGFH1HsxdPYPWAZj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=QnNGNEALRqgiozY7mWark5SHiyol3IWg7dmNvc3QToKmFMCcB/O7sBm30KfUp+CYkAPX2yUPQPrQ3a9uxntfm6f9nuPh5NyBCMFSkFwHQ87qJrwdqocKue9dtRXCS/N9YOL5hv8DwX1I+4QC9E0kG30pezQox3YsIGv4G92e5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W43EUjPN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 558MlTMj030771
	for <linux-wireless@vger.kernel.org>; Mon, 9 Jun 2025 00:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PujGtJUOTRvTJg+tZCvIl+
	rtYKGXQDql7ImjiwUEAME=; b=W43EUjPNodOBvgk3TNfCIhSXRGz5iiW1+WWU+W
	jSfxBq1bD5y2o/UWBhWAg5QzX8sfnfNqsfCzAdvl6rFzQk7Ir6wGLbzVK82cv0Jh
	CmC+YklBRqnklWpYIqbQiY+oKBbERql0tBhanAWDJsBr1HguL46jRGDHSG71r/0A
	ZvxDgS2+rKcJBpqB8P39Ylpy6ncZvjJgWdH2vVVGnga4tou24SCbL+j5kE562SpH
	oxZst6tQWU7nQHLJlZeGqGQGb6NKfOcdkIDM1LlPtybLS3MFFeS6lYRqaDdl/vaT
	+wn0RzxR+hQHJax6ai4O1y+DcIMl94D032fAmifH2xT5HqsA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 475g75rh9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 09 Jun 2025 00:10:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23494a515e3so27756735ad.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Jun 2025 17:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749427854; x=1750032654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PujGtJUOTRvTJg+tZCvIl+rtYKGXQDql7ImjiwUEAME=;
        b=ULsgC7mAaBQOgSb9T8/LKbNUgqL6S4u5TB6Wfj5HM/CULzlbxgruj7rV1xANHSXCv3
         zNiew5+N8PMU8+1veBETktvbBdNmQu5VRf4tuj5K9Tez+sEGHgQ+Fwil1g0moTydnj3x
         BizQhpwvhU2Xo3sohgAYBCMt0LNl+1X9RV5jsN38K1JEmStJ7D/rfI8BtbJ5tO6pC6Ek
         Ud1UGgYhHe55uc/61O+QdR8O2yMBmJ+QsXWLsoDJpzvHwBHjrJgSO58lIzyFZzUqp081
         RWXdA85BDcmJrZVhpk3ImjmgDP49P0q+vOmmxz4YJUmPNDO4Z4CyHAuY3dGg5Z6Cz/b2
         o/0w==
X-Gm-Message-State: AOJu0YwVeKRnBJ58HOUVf8CKlZohpXK5EOiSPReNJXXvcQNDawiCk1xM
	1zviQyYyx06SnMqzYQ0Bwmi+U11F0T9R6mXMR6fPlZ38VrC6aIRuiwDDGH0RUE4ZDetVHvJu9R1
	sd1m/kRDKMQpGro+rV904+IJkRp4wl/K8/p6YyDjl4Elzdj5D6H62hCYJMbfAAh1Z/z42jamwYl
	urCw==
X-Gm-Gg: ASbGncsIvK6TKb7H9dcwvAMX0qzzo89Qdd8EJbi+98bSTST1YT5Rivj1nDgnHjTAvTf
	n2ilbtwKj9YrsvifEf1pA3JJW6QDR/yURjWuRlnCrQqxvLrj1V2qZQnwczmbvaW9J6s06rvnNrN
	MD8+rJkiYwtoQGZruGKq24Td9NwgDi/4RVFUZr21oo5W6JZd4Kw8wMJofP9ryO411NVgaC/+u7N
	cEACb1TUMheayK8pjT0ow+hlKpv+/raDKpL+gY3ggaNrTa9MasJv1cusu9qLMgNBTuQ7qSdUIki
	iJekcyb31HeK9XZ2RgqnU90IwMUXHoMZ4DM7m0o8HK9Sco6VjgcKn1dEQdPOTjuPVjrGh6EZUaW
	vLE2HVDREzfp3XrIpK1+1555mR2BAoaje/BMtmukgfrgJg8lUF5Q=
X-Received: by 2002:a17:902:e5cd:b0:234:88f5:c0d1 with SMTP id d9443c01a7336-23601cf0994mr165667325ad.10.1749427854464;
        Sun, 08 Jun 2025 17:10:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfGiMcSJAmUzHBNfelT4glbwStsN1RFlfBEFxxoC7/qkH6374at+pe0KoIG0Ds3wmiauzR9g==
X-Received: by 2002:a17:902:e5cd:b0:234:88f5:c0d1 with SMTP id d9443c01a7336-23601cf0994mr165667115ad.10.1749427854104;
        Sun, 08 Jun 2025 17:10:54 -0700 (PDT)
Received: from hu-rkaliapp-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-236034059cbsm43731235ad.165.2025.06.08.17.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jun 2025 17:10:53 -0700 (PDT)
From: Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>
To: johannes@sipsolutions.net, ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>
Subject: [PATCH wireless-next 0/3] wifi: Preamble puncturing support for mesh
Date: Mon,  9 Jun 2025 05:40:45 +0530
Message-Id: <20250609001048.2263586-1-ramasamy.kaliappan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 44pZUB8HA2-SBX98FnGoEObt2XIUDEJy
X-Proofpoint-ORIG-GUID: 44pZUB8HA2-SBX98FnGoEObt2XIUDEJy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDAwMCBTYWx0ZWRfXyL4kQOKWM1hi
 EE0sP6GmH3vo05/U/BQtVJXr/6mLdF1tkPTjrXu/70THnAPY+ZsEdPDj0HKK46ouAnxNaBnB6Ec
 ziJxoYz4QC/RLhUcXfy40e3I0SZytp/90GQhTxN5deNEvv8VdcICpNcIcRCvyyz2wzOZRQHdnxi
 jiifLsjyIyzR4IpyR5d16g/WH9T4TmeHzaw0Ift9eoncB3oDADGHM7/Ert7cw1YUB7YVTfLXMy1
 N7DF7CLjaLLQIfehArOx0/WqAEThFOu/DWs8F4Q+EJdNFybf6+uvRkcn6a1tE0zP8SsG//STxvU
 NOqmBuM3p7F+inRq7kGvitHr0PRi3k6ud5JUn7jUnpYghOQ8Zz3OdiCSURH3V/Ra3IIuzlnjgLy
 gW0iciVJhxPTnIrxsEOQ4GpSzLsgRDwNQOAkOx6098iOdd5hsDD+YUz3ucCrv+63Zu1zttJX
X-Authority-Analysis: v=2.4 cv=TeqWtQQh c=1 sm=1 tr=0 ts=6846268f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=jaDM4XRiC6Djmw5d5WUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-08_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 clxscore=1015
 phishscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090000

From: Ramasamy Kaliappan <rkaliapp@qti.qualcomm.com>

Preamble puncturing(“Punctured 242-tone RU") refers to the transmission
of a PPDU in which no signal is present in at least one of the 20 MHz
subchannels within the PPDU bandwidth. Puncturing might be the result of
the unavailability of 20 MHz subchannel(s) within the PPDU bandwidth,
such as a busy channel indicated by the CCA or the setting of the disable
subchannel bitmap field (16 bit field) in the EHT Operations element.

EHT disable sub channel bitmap is a 16 bit field where
each bit corresponds to a 20 MHz channel in the given bandwidth.
Bit 0 corresponding to the channel with lowest frequency.
Bit set to 1 indicates that the channel is punctured, otherwise active.

Userspace can send the EHT disable sub channel bitmap via attribute
NL80211_ATTR_PUNCT_BITMAP in frequency  param as a part of join mesh
(NL80211_CMD_JOIN_MESH) command. The received puncturing bitmap is
validated and copied to chandef's punctured bitmap of mesh interface data.

Build the mesh beacon’s EHT Operation element including
disable_subchannel_bitmap based on chandef's punctured bitmap.

Validate and update peer mesh station's puncturing bitmap
in local structures while adding new mesh station
(parsed from peer mesh station's EHT Operation element)

Add changes to allow mesh peering with peer's that advertise
different puncturing pattern than self.

Rameshkumar Sundaram (3):
  wifi: cfg80211: add mesh peer with puncturing bitmap
  wifi: mac80211: Add preamble puncturing support for mesh
  wifi: ath12k: Send Puncturing pattern of mesh peer during assoc

 drivers/net/wireless/ath/ath12k/mac.c |  3 +++
 include/net/cfg80211.h                |  4 +++
 include/net/mac80211.h                |  5 +++-
 net/mac80211/cfg.c                    | 19 +++++++++++++-
 net/mac80211/mesh.c                   |  9 +++++++
 net/mac80211/mesh_plink.c             | 38 +++++++++++++++++++++++++++
 net/mac80211/util.c                   | 15 +++++++++--
 net/wireless/nl80211.c                | 11 ++++++++
 8 files changed, 100 insertions(+), 4 deletions(-)


base-commit: ea15e046263b19e91ffd827645ae5dfa44ebd044
-- 
2.34.1


