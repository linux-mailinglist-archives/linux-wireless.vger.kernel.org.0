Return-Path: <linux-wireless+bounces-34707-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLy3CGAO3WkOZQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34707-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:40:16 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A0C3EE165
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 17:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38698302515B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Apr 2026 15:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA4C3E1CF8;
	Mon, 13 Apr 2026 15:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NnE3NY3n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QNEUFEXU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801063E1CF0
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094781; cv=none; b=LPtMo9vxwdOcFTFVto+pB306wIdvLuBJ/hR4r4qG6zqaRRJePdjJI4v29qCyNVerwkpopNTyAMnDscF3Vl03PMnjYZXyyh82YOkgPKi32UzAmO7ehXmE2QKydikNyhtHekB2dmG/mWX6n8dU3kETNJLafcVW2FDDyw+uub9QJHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094781; c=relaxed/simple;
	bh=dzvzgk85piI8yiA2wp6ATL4yBCiMADTSKSQoPRTTQYE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=irBCf15lvMgcH+vR38uOpcpGArWgKTxDuRXWl+lewfr+tvviW1vCxy1ByujjnK7/mrTqv34s0ayTuKSvWBHAmCevkNeTTaPFS9SDYqM1Qxgilz0JXCLPhBnQ9y08/vG6+QMXNw5mtEKZqfsrhdBkDv+rK/Vs9YfgUWVl2cwx+R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NnE3NY3n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QNEUFEXU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DEJJqd3539272
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=axp7tNpBNw3aQicWgliM1g5+tiQFHVw+0xR
	kGYUDKf4=; b=NnE3NY3nBoEYvIbAPn5ptA6I65H0TfAWclG2wxNonCqL01kOuO9
	c0H4heBRyVXGM2q3nEO+wpWBfGlF8vm4qAM9JIuGGZaecv3tJaWQ2Z6Rh8utREG7
	/iHV23VKZCIUUTOYlQ9stqyISziSZXF/lWJ95rTDiKnzNpiSgFLaHJwG3T5wsSMK
	l3C1qzoQACwNWiHewKE1BdAYY3g/2AKEZfJzbSaqtnI2HpwVu/F115P1MSdS8/Gk
	FsrDPyZ4hxbQ5CJL7SRFq89dqz7JtA3ugp5Fr86W5fXuWdD7LEPiRIkBXxckRCMR
	IiO/DcBE24n2fjkJelA8/ZjI2FHykAogmAA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh258r8nw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 15:39:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-35da99b90f6so5572336a91.1
        for <linux-wireless@vger.kernel.org>; Mon, 13 Apr 2026 08:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776094778; x=1776699578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axp7tNpBNw3aQicWgliM1g5+tiQFHVw+0xRkGYUDKf4=;
        b=QNEUFEXUy0g2BYzGRvJ8NfRmhfj4Fk5sLlwZFoimvplA8al0eC7UF2eGD7KQKGT/RV
         LkNuKHMrYt2gSepLbOHN1P3hsULq5Dr39wO4XGIa98U2zo9TqwxKbBPVObBDmqTYPnRD
         dNgkCi/+Hv8AH7E0JqVn1cY+8lFLLNSWUp0gxEO84IFbsGk/M0Qp+2rdV3mDIlg3vtlq
         gZYD0JyPFncXtOEy++rFMzRIylotKVyVqF6vzLOgmZ8aF4TJG4NXAoDKwPBSjlUj23Fb
         Lpv7mCymSy9WznyVde+Nnf5ObWlnxtrJWZFZLZDCu5Ko80l2aZj6SY+xSVC334K1C/6s
         f89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776094778; x=1776699578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axp7tNpBNw3aQicWgliM1g5+tiQFHVw+0xRkGYUDKf4=;
        b=eSQYEopv7gdg84GK9wSztVDtAjj925oBqddEHdzI49q5mJ26C/WoD6EBTLa506k8bg
         CiJwradO3V6E88KVzzPOtifwNNcyAXXHPOktkjZILkBZFjfrZInjABlOGP6tR55g/Iqn
         X6Lg+y+/xANWWG6HWwCBhjsztM4Mp6+OcENmsdzjV8Co8sJ/9hXCYasiUleBLpeap4aj
         hvH1MY2Vv9rPn8wvaqm7qzIgcPwE7JTKafNGn6j3Kpl4gLfhpgfZKSoLVvNqkOkBG+eA
         fp8Pf/+fNWkv+BP46Z2cQHlfOl6V6INo023dSb+o73LQ5mvmSERvw4xF7835XkuG6G9l
         xJAw==
X-Gm-Message-State: AOJu0Ywqv0Z8Rq4rsQzAjExYJ7S+zd5VvXeFeHVp7VdZ/feJsBa6hxZI
	IS14dCIBHZsoxObg/juknbnRqDKi2GubAeMTQqzonRyRPdP0N9rAjpHL+RCekotRZuyaZhHRu2I
	qGtHjN/kPK/BReNbDQNmI5SZvv1deRJx/IWJZc0RU1BtmPnjXXyKlVibyoNfB/Pf7HC8VIA==
X-Gm-Gg: AeBDievvTL4vDNEVdqpHs4i+xx92xawuQXaPtZWz7vZkiFUPkLLXpvLhybGl4+HaxLj
	KIGEUSYHA2L1tfKbCvzTlFOUOqbLm2oqlSxvH18F4XoY0chBS+6JNjMeqMlblt3J8rKfxwVWI8D
	rmZ9/sWX1A6v6mbN0W7VtLELQg4rqbD9rR9mRURHwYfOcprXZIM0EntUIzriDG1sV7WyQLeFcXx
	KfY64PGexTjrhXVVEgrKbGlxPbp4XfbZXDfJtwKGPGbMF9434EjDYnYfFWl3b3qi3jDJSxfJtOw
	jOfTqtuUb9cFTR+yfhkLk2kOnFStfI0zZ26PIs7OfMAoENn1I5U6Nf9CXOvAcFaw9ajE4NSTKU5
	pp5roaOMXZghUr8sgwYpvnlkUPVHccL5ktcqU8D68dsE5VofeghTIGlvAK2ENL6vaRcQpxS7+PK
	3N4qOm+apAmi8fqXQGNZcUByTmnMzDgtozN+qCMHnA2vU1Jrrpgwk=
X-Received: by 2002:a17:90b:2689:b0:35f:b953:244c with SMTP id 98e67ed59e1d1-35fb953263bmr3380820a91.0.1776094778163;
        Mon, 13 Apr 2026 08:39:38 -0700 (PDT)
X-Received: by 2002:a17:90b:2689:b0:35f:b953:244c with SMTP id 98e67ed59e1d1-35fb953263bmr3380793a91.0.1776094777619;
        Mon, 13 Apr 2026 08:39:37 -0700 (PDT)
Received: from hu-mkenna-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e411ff4e1sm13000123a91.3.2026.04.13.08.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 08:39:37 -0700 (PDT)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
Subject: [PATCH ath-next v2 0/5] wifi: ath12k: thermal throttling and cooling device support
Date: Mon, 13 Apr 2026 21:08:35 +0530
Message-Id: <20260413153840.1969931-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sTff0RmKuU7HmYWeTHhhrTBeMIqrMGbM
X-Authority-Analysis: v=2.4 cv=Vo4Txe2n c=1 sm=1 tr=0 ts=69dd0e3b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=kPw7zogRYXnG0GdHtlcA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: sTff0RmKuU7HmYWeTHhhrTBeMIqrMGbM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE1MyBTYWx0ZWRfX7qb66wBtWIkD
 cGrCC1SCmC5jNW63e/fzG8xB3kp6U5rioDqqSWiHuv7/WCwKxSmMNOc3SPkRRymn4pNgGY+euYi
 nz7N+NuDRxACi8tJQ6KuGGWPmtmHyeweqEUjvGQnTrGAvabLbtMPHn06RdNgLtKltQIxhviToXw
 +fgGIaTip1N+CA6LT3ZINtZj2O7n5OOupl/M560WDvuFJXC1JReFRm+lTkTUyei8ewRwP02ftS6
 NaNQrx/0XPLmpWvq1YLsC//SxSciNKcMPz59Hozsd7FZ6X2nDvVTL2Rxas5aSrsVe4Fq8xaDug3
 qNqLDC9sdDM8K46CiVBD5dteWQSqjLEIVTGAOrAA5acfM2GV0p++7Cxpgj7e9iTGW67TRjZmaPH
 g2vC0pXUm06EXhAeqL432LhWoc9lF4ghPP2+GCgJlt3vIWyV/ZyB9J156IjwN9Wrw9PhrSKVDEn
 KlEAk0DdKjS+yvuJixg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130153
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34707-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6A0C3EE165
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 handles the firmware stats event so we can track the current
temperature and throttle level per pdev without spamming logs.

Patch 2 enables thermal throttling at bring-up and programs default level
tables to firmware via WMI_THERM_THROT_SET_CONF_CMDID; the driver picks
IPA/XFEM defaults based on the firmware WMI service bitmap, supports 4 or 5
levels as advertised, and only fills optional fields (pout reduction,
tx chain mask) when the corresponding WMI service bits are present.

Patch 3 refactors per-radio thermal hwmon cleanup to reduce code duplication and
ensure consistent cleanup across thermal register and unregister paths.

Patch 4 reorders the group teardown logic symmetric for safe thermal sysfs cleanup.

Patch 5 exposes a thermal cooling device per radio so the kernel thermal
framework or userspace can set the TX duty-cycle off percentage; writes
are validated against the throttling state range and host state is kept in
sync with successful firmware updates.

Examples:
echo 40 > /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_stat
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/cur_state
cat /sys/devices/pci0000:00/0000:00:1d.1/0000:58:00.0/ieee80211/phyX/cooling_device/max_state

v2: Addressed Jeff's comment by rebased on latest TOT with wmi tb - alloc and free
    interface change.

Maharaja Kennadyrajan (5):
  wifi: ath12k: handle thermal throttle stats WMI event
  wifi: ath12k: configure firmware thermal throttling via WMI
  wifi: ath12k: refactor per-radio thermal hwmon setup and cleanup
  wifi: ath12k: reorder group start/stop for safe thermal sysfs cleanup
  wifi: ath12k: add thermal cooling device support

 drivers/net/wireless/ath/ath12k/core.c    |  50 +++--
 drivers/net/wireless/ath/ath12k/mac.c     |   9 +
 drivers/net/wireless/ath/ath12k/thermal.c | 252 ++++++++++++++++++----
 drivers/net/wireless/ath/ath12k/thermal.h |  35 +++
 drivers/net/wireless/ath/ath12k/wmi.c     | 108 ++++++++++
 drivers/net/wireless/ath/ath12k/wmi.h     |  50 +++++
 6 files changed, 447 insertions(+), 57 deletions(-)


base-commit: 9a4f673eb08d2a7713b258d671b4a45f2a6e68b7
-- 
2.34.1


