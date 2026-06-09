Return-Path: <linux-wireless+bounces-37590-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dg2wJWMpKGpI/QIAu9opvQ
	(envelope-from <linux-wireless+bounces-37590-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:55:31 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1376D661659
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 16:55:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZfgrAb5g;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=REdE91xw;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37590-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37590-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0DE73110968
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 14:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE95284690;
	Tue,  9 Jun 2026 14:37:41 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486A2DC357
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 14:37:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015861; cv=none; b=jAl+EDzT0YuxA1fKAa30BhaRpQrhoOUn5RI5wYm8UFDr9c7wq084xTRinK6vo/jTfIQO0P3R3zV19X/65ArsuSYgJhmGisp8RPo6pVOg+5wsFYtMMjpt3nFHwaGK4yFYZfSe8lSZIEpiRkZsEsSYqUw/mtBPTHnhVv299HuSXm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015861; c=relaxed/simple;
	bh=s99SLuShYVwPzIUt1Ny8l9ieuXz8eTmDhcGcMS54Ivc=;
	h=Message-ID:Date:MIME-Version:To:Cc:Subject:From:Content-Type; b=TnCiw7RKQheyp5TU0H9JRkv8q1Tv7rxHgS8u6cWfs7XroX2lYLku5AMS6XnE5h5P5VBWkuISwb6/GkGu3mahZsZC5A81khdBYs7GQdXtihI+5zyGcsy3GaHG1OM+SR/mHOqeMUk2u1htQTUQIWq0SFgn/Fqz34ZVSvO9JYJ7PWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZfgrAb5g; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=REdE91xw; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 659ClGI02251540
	for <linux-wireless@vger.kernel.org>; Tue, 9 Jun 2026 14:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Yh/qlCI4RSGheI4VM0m2qK
	RN3/NEqC81qg+NEzqwGBc=; b=ZfgrAb5g3zWFsoWEFyoYMCvs/vrkIJKHzECsPc
	tx19/cWZ3vzIZBdzaZFGze2cCrRcmEsWW+7QjJHQ8HgGZzLBSYg3Q3jl//b4mn4H
	pbm5cy/FWBZso6kVYKtQUu2jSsdKzi1VHXo9BTINYJnj1NLEpUQDYKPGaDhRT2Rf
	djnFcnLKbkclj+KxREWnriJxCUsVzWom8AWBP2cyhmy81sL4uQcUn3T0bCmHZc3Y
	lbtz6NAcxC9dq99N47mFBQhir85pv9tlsmioV/BAKDsT5qWmRnHsNFkue7fHBETc
	Hz4W2Mcc1jxgImldhcP6IEiiO3NY73ItlxGUVwbZqqv6+mEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqghvpu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 14:37:39 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-304b8d0ee63so7779293eec.0
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781015859; x=1781620659; darn=vger.kernel.org;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yh/qlCI4RSGheI4VM0m2qKRN3/NEqC81qg+NEzqwGBc=;
        b=REdE91xwrh3dNSQRDJprg/PDW8ZLD/oDhlKmmfEuUQegABe7ZeMrX6q4fdgKRc1Dt5
         oi3NO3u9OeUJfiDTJ73r7vKrTap0Rhd0VOQH+/WhpxVcZhs/GA9Ci9SgERgVSN3bIJHd
         O36opISdk5LaEDOHWs8vhuyE80rHrQ4/iCUzuEWXky62ubaNiKrWQZj5rWoMH/jnjh5z
         Z6sirAAAYFT5khsvSsXppXHvBcM0dz0q66D8XttgXUgkU1rCk60NxIe0Gv8BrJsY4sKI
         QSGB3wwhwF6k+Hha5PGd7gdZMmHE7oeukFnH5uufPCqQ8ZrQzYwMgEGsm68FYamUphmu
         v8iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781015859; x=1781620659;
        h=content-transfer-encoding:from:content-language:subject:cc:to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yh/qlCI4RSGheI4VM0m2qKRN3/NEqC81qg+NEzqwGBc=;
        b=pP1viyUOKkMl6pRwJOotc0pqMGdoga5CT9t/3kdwzzruaelNDjIKn5cZK3T2IgfYcA
         fvIt6SGIfDmN2IIqDMyirfTbuJcBY+n/8RkIiAcNO3+iR+IaLNFB8QuBR9VtV9gJE24n
         i5WCRjP3ot9VR2TlYrGf+zGQ74NRRz3X2nFI33qKab0lcxsKG3c54C3uEdL0Jb9YeJwx
         7Byb3fS4YxB51k99Z0YqWuhNPA9DAjBtMbETMKSvBUCos3Er96LXiQcnHHTq3ORuGvC9
         dNcsk1l4olxMVb7+h3ExUuxPsZITGbT9i/EqybXwdg0YUuvB+qAARSPAsIxyRsgd3Qmy
         Bx6Q==
X-Gm-Message-State: AOJu0Yyz1iCrZAFAfRgfizCdDYOWD8dogtaCGPLndne/A5qBswBskJx6
	3jKxGVDSfnCWNkeUT60MbObxJM6NBYgpSUg1SVFCmLug9gHbwXhDUt+sUh2M/8uslvUCZtVdq64
	ZJelDwoB260P32RZ3tgY8ZbCnFPKR1mSja6xF5rfMEXCKVC6ly3vDDlrVXiONweKT85Uu0h0TfE
	eZuA==
X-Gm-Gg: Acq92OHDhOjGU6V9+9KvAz/eX8cLlC78UFmnV7C5fNwbO+Jko8WxbNSTSUKHpOlULEK
	W0zr93agV8epiCXReB0fbgDAiEObpyNJhZjHCDC/r1yN+yDIgrukfrvvc0/JIEtyeMnxmI94X/i
	QE0YQQEiyfp/QmCOjQK6clrZQz3IxzZuGN6BroR8hHk6Z2o98MxHY3Ux/xHQpJI48r3J8uZsIua
	bdYv7rSeU2LS+JdvFuZUJuhhTLGXBG9T1j2JkEsJxscy7KjTu7SwYV3yEPR/v2KQR8oukrxU/AP
	dZhV6sBEiEu4pMn4N0V+iJeBlP24Cw1fvEenouwex8avWWPUHrZGelAHAOkMq4hOEzl4Fg9GeVc
	Y612KMCDDNCalLX2RFrcZeUczbOgCLwoI/YkLU82TGNXer+wKYH5AyM0xybTHAeiRESuN
X-Received: by 2002:a05:693c:37c3:b0:304:de94:1c55 with SMTP id 5a478bee46e88-3077b38e7e4mr14417792eec.35.1781015858620;
        Tue, 09 Jun 2026 07:37:38 -0700 (PDT)
X-Received: by 2002:a05:693c:37c3:b0:304:de94:1c55 with SMTP id 5a478bee46e88-3077b38e7e4mr14417728eec.35.1781015857847;
        Tue, 09 Jun 2026 07:37:37 -0700 (PDT)
Received: from [10.81.91.45] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db85f60sm26513545eec.8.2026.06.09.07.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 07:37:37 -0700 (PDT)
Message-ID: <a90fba3c-c4c1-470f-b5fa-5cf1fee17163@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 07:37:36 -0700
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
Subject: pull-request: ath-next-20260609
Content-Language: en-US
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfX+EXkbCNA5Zyp
 /zLpWtgRhdYURIxh/YAhD/u3Dgj8YgMLddPHbkr/SmLPuTQaZ0fBxi/cSrwHdY8zaIrAaKki8Pf
 hj7uZXwtbEG/oEJnl8Z9A8aUdtwJnn0hE4CVAqNpdDBh0zgWKRFE1Z6SyK2RBEhNxFDGk82fsi5
 oTbg4tfwFGdHDNTCyxU+bChMQs2LiRl6e3XI8LrntctpI06OPVqlM0stSxcmPP3d1JfDuBvo12j
 63N64I07dSnRUdnHJNUDPdL6NW0er47brSsvAKwYfA7/bZUtC/bKutPotPwDI6VRB59LhxvLcbt
 T9KU7zKllIFq84ZxxPflNcJH5gByIN4Dx/xYUKSXFkA1Z0Y1Oc79MZoICUQDK0AuHaA0l7H1Tbi
 OmiGHXKNnZT65aFUo0DNZfs19aMc8biOtJtzpgX8ftZqGM2SVlYkqtw0W0fftF79v23oROPtXBF
 S4fZq3vDSuvj07g0LSg==
X-Proofpoint-ORIG-GUID: CfZzyv6AdXlALE1M84dBW-q2Y2oDyMcA
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a282533 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=Of_zAPQQtSp_xK_LWJsA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: CfZzyv6AdXlALE1M84dBW-q2Y2oDyMcA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090139
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37590-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,m:ath10k@lists.infradead.org,m:ath11k@lists.infradead.org,m:ath12k@lists.infradead.org,m:jjohnson@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1376D661659

The following changes since commit a26c2a22e7e88b2b5afb1349f3994fc564c988b1:

  Merge tag 'iwlwifi-next-2026-06-03' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next (2026-06-04 13:22:11 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath.git tags/ath-next-20260609

for you to fetch changes up to 63abe299b12b317dfee5bcd09037da4668a4431a:

  wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported (2026-06-09 06:50:29 -0700)

----------------------------------------------------------------
ath.git patches for v7.2 (PR #4)

An assortment of cleanups and minor bug fixes across wcn36xx, ath9k,
ath10k, ath11k, and ath12k.

----------------------------------------------------------------
Baochen Qiang (1):
      wifi: ath12k: fix EAPOL TX failure caused by stale tcl_metadata bits

Jeff Johnson (4):
      wifi: ath12k: Update Qualcomm copyrights
      wifi: ath11k: Update Qualcomm copyrights
      wifi: ath10k: Update Qualcomm copyrights
      wifi: ath: Update copyright in testmode_i.h

Rosen Penev (6):
      wifi: wcn36xx: allocate chan_surveys with main struct
      wifi: ath9k_htc: use module_usb_driver
      wifi: ath9k: Clear DMA descriptors without memset
      wifi: ath9k: remove TX99 power array zero init
      wifi: ath9k: remove disabling of bands
      wifi: ath9k_htc: allocate tx_buf and buf together

Stepan Ionichev (1):
      wifi: wcn36xx: fix spelling mistakes in dxe header comment

Tristan Madani (3):
      wifi: wcn36xx: fix heap overflow from oversized firmware HAL response
      wifi: wcn36xx: fix OOB read from firmware count in PRINT_REG_INFO indication
      wifi: wcn36xx: fix OOB read from short trigger BA firmware response

Wen Gong (1):
      wifi: ath12k: enable IEEE80211_VHT_EXT_NSS_BW_CAPABLE when NSS ratio is reported

 drivers/net/wireless/ath/ath10k/bmi.c              |  1 -
 drivers/net/wireless/ath/ath10k/ce.c               |  1 -
 drivers/net/wireless/ath/ath10k/coredump.c         |  1 -
 drivers/net/wireless/ath/ath10k/coredump.h         |  2 +-
 drivers/net/wireless/ath/ath10k/debug.c            |  1 -
 drivers/net/wireless/ath/ath10k/debugfs_sta.c      |  1 -
 drivers/net/wireless/ath/ath10k/htc.c              |  1 -
 drivers/net/wireless/ath/ath10k/htt.c              |  2 +-
 drivers/net/wireless/ath/ath10k/htt.h              |  2 +-
 drivers/net/wireless/ath/ath10k/htt_rx.c           |  1 -
 drivers/net/wireless/ath/ath10k/htt_tx.c           |  1 -
 drivers/net/wireless/ath/ath10k/hw.c               |  2 +-
 drivers/net/wireless/ath/ath10k/hw.h               |  2 +-
 drivers/net/wireless/ath/ath10k/pci.c              |  1 -
 drivers/net/wireless/ath/ath10k/pci.h              |  2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.c     |  2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h     |  2 +-
 drivers/net/wireless/ath/ath10k/rx_desc.h          |  2 +-
 drivers/net/wireless/ath/ath10k/sdio.c             |  2 +-
 drivers/net/wireless/ath/ath10k/thermal.c          |  2 +-
 drivers/net/wireless/ath/ath10k/usb.h              |  2 +-
 drivers/net/wireless/ath/ath10k/wmi-tlv.h          |  2 +-
 drivers/net/wireless/ath/ath10k/wow.c              |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.c              |  2 +-
 drivers/net/wireless/ath/ath11k/ahb.h              |  2 +-
 drivers/net/wireless/ath/ath11k/ce.c               |  1 -
 drivers/net/wireless/ath/ath11k/ce.h               |  2 +-
 drivers/net/wireless/ath/ath11k/coredump.c         |  1 -
 drivers/net/wireless/ath/ath11k/coredump.h         |  2 +-
 drivers/net/wireless/ath/ath11k/debug.c            |  1 -
 drivers/net/wireless/ath/ath11k/debugfs.c          |  1 -
 drivers/net/wireless/ath/ath11k/debugfs.h          |  2 +-
 .../net/wireless/ath/ath11k/debugfs_htt_stats.c    |  1 -
 .../net/wireless/ath/ath11k/debugfs_htt_stats.h    |  2 +-
 drivers/net/wireless/ath/ath11k/debugfs_sta.h      |  2 +-
 drivers/net/wireless/ath/ath11k/dp.c               |  1 -
 drivers/net/wireless/ath/ath11k/dp.h               |  2 +-
 drivers/net/wireless/ath/ath11k/dp_rx.h            |  2 +-
 drivers/net/wireless/ath/ath11k/dp_tx.c            |  1 -
 drivers/net/wireless/ath/ath11k/dp_tx.h            |  2 +-
 drivers/net/wireless/ath/ath11k/fw.c               |  1 -
 drivers/net/wireless/ath/ath11k/fw.h               |  2 +-
 drivers/net/wireless/ath/ath11k/hal_desc.h         |  2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.c           |  2 +-
 drivers/net/wireless/ath/ath11k/hal_rx.h           |  2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.c           |  2 +-
 drivers/net/wireless/ath/ath11k/hal_tx.h           |  2 +-
 drivers/net/wireless/ath/ath11k/hif.h              |  2 +-
 drivers/net/wireless/ath/ath11k/htc.c              |  2 +-
 drivers/net/wireless/ath/ath11k/htc.h              |  2 +-
 drivers/net/wireless/ath/ath11k/hw.c               |  2 +-
 drivers/net/wireless/ath/ath11k/mac.h              |  2 +-
 drivers/net/wireless/ath/ath11k/mhi.h              |  2 +-
 drivers/net/wireless/ath/ath11k/p2p.c              |  2 +-
 drivers/net/wireless/ath/ath11k/p2p.h              |  2 +-
 drivers/net/wireless/ath/ath11k/pcic.c             |  1 -
 drivers/net/wireless/ath/ath11k/pcic.h             |  2 +-
 drivers/net/wireless/ath/ath11k/peer.c             |  2 +-
 drivers/net/wireless/ath/ath11k/peer.h             |  2 +-
 drivers/net/wireless/ath/ath11k/qmi.h              |  2 +-
 drivers/net/wireless/ath/ath11k/reg.h              |  2 +-
 drivers/net/wireless/ath/ath11k/rx_desc.h          |  2 +-
 drivers/net/wireless/ath/ath11k/spectral.c         |  1 -
 drivers/net/wireless/ath/ath11k/spectral.h         |  2 +-
 drivers/net/wireless/ath/ath11k/testmode.c         |  2 +-
 drivers/net/wireless/ath/ath11k/testmode.h         |  2 +-
 drivers/net/wireless/ath/ath11k/thermal.c          |  2 +-
 drivers/net/wireless/ath/ath11k/thermal.h          |  2 +-
 drivers/net/wireless/ath/ath11k/trace.h            |  2 +-
 drivers/net/wireless/ath/ath11k/wow.c              |  2 +-
 drivers/net/wireless/ath/ath11k/wow.h              |  2 +-
 drivers/net/wireless/ath/ath12k/acpi.c             |  2 +-
 drivers/net/wireless/ath/ath12k/acpi.h             |  2 +-
 drivers/net/wireless/ath/ath12k/coredump.c         |  2 +-
 drivers/net/wireless/ath/ath12k/coredump.h         |  2 +-
 drivers/net/wireless/ath/ath12k/dbring.h           |  2 +-
 drivers/net/wireless/ath/ath12k/debug.h            |  2 +-
 drivers/net/wireless/ath/ath12k/debugfs.h          |  2 +-
 drivers/net/wireless/ath/ath12k/debugfs_sta.h      |  2 +-
 drivers/net/wireless/ath/ath12k/dp.c               | 10 ++++-----
 drivers/net/wireless/ath/ath12k/hif.h              |  2 +-
 drivers/net/wireless/ath/ath12k/mac.c              |  4 ++++
 drivers/net/wireless/ath/ath12k/p2p.c              |  1 -
 drivers/net/wireless/ath/ath12k/p2p.h              |  2 +-
 drivers/net/wireless/ath/ath12k/reg.c              |  2 +-
 drivers/net/wireless/ath/ath12k/reg.h              |  2 +-
 drivers/net/wireless/ath/ath12k/testmode.h         |  2 +-
 drivers/net/wireless/ath/ath12k/trace.c            |  2 +-
 drivers/net/wireless/ath/ath12k/trace.h            |  2 +-
 drivers/net/wireless/ath/ath12k/wow.h              |  2 +-
 drivers/net/wireless/ath/ath9k/ar9002_mac.c        | 15 +++++++++++++-
 drivers/net/wireless/ath/ath9k/ar9003_mac.c        | 23 +++++++++++++++++----
 drivers/net/wireless/ath/ath9k/ar9003_phy.c        |  4 ++--
 drivers/net/wireless/ath/ath9k/hif_usb.c           | 24 +++-------------------
 drivers/net/wireless/ath/ath9k/hif_usb.h           |  4 +---
 drivers/net/wireless/ath/ath9k/htc_drv_init.c      | 18 ----------------
 drivers/net/wireless/ath/ath9k/hw.c                | 16 ++++-----------
 drivers/net/wireless/ath/ath9k/hw.h                |  2 --
 drivers/net/wireless/ath/testmode_i.h              |  2 +-
 drivers/net/wireless/ath/wcn36xx/dxe.c             |  4 ++--
 drivers/net/wireless/ath/wcn36xx/main.c            | 13 ++----------
 drivers/net/wireless/ath/wcn36xx/smd.c             | 13 ++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h         |  2 +-
 103 files changed, 139 insertions(+), 171 deletions(-)

