Return-Path: <linux-wireless+bounces-33305-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLlkEnU7uGmpagEAu9opvQ
	(envelope-from <linux-wireless+bounces-33305-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:18:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0922B29DFFA
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 18:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546FF302DE02
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Mar 2026 17:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4AF3CFF41;
	Mon, 16 Mar 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SI02Y2H8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YKRBn1KS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2593330B2E
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681281; cv=none; b=ldaUd5gvfcsH7uSOdlImoRKjHN+3P+tn/0mfSTtdBrreqZ6WrR57iJ28Wm0WbMuiUgsE1dv4XCpKqQDFbfbVlAtqdg5gI/ObpoXbmKxAeVe4lmlvKVXz+bgDJpVuAlLVuODcbcpdn3WRg5RGnGZPdo5QQl5vZRVKPl2/7gDUQlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681281; c=relaxed/simple;
	bh=2dBil2sbvALdgakp7prwObt+Sv5oKY8OY7ILQNxJsqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrIhtdjGD9t0SD8LliZbv0ZrXIAk2+S3OI2m5XNWN/NjJdJsT3NbI3cd+zEQ5tuxcxCeeszW2lZusl97DYQEmAPrPBTiFK7rHqyoHLAdH25UseqD7dAJitGxKAaz9GumWznYJ/6Gi9Z5/h87H1M7wti9x9oLbMsYw2cCqslahzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SI02Y2H8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YKRBn1KS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEg6oe3295187
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=EL8eRmWCbyxanJKOyEB/eWK8uBWGSkS3eeh
	Q6T7GtLo=; b=SI02Y2H8+YoThHCRZREkTRX2uEwCLNGPtJXcEkMrmDsFkI3IzUI
	vLtUIm8GJyTlFqm1wuptT/AUiGJiro7tTHHmIf7ia+g4oWOPw0UBCv0clZ2ry7Qf
	UkiLu8WSZG96cyJ2Ctp4IiceifpqrJvP5pk6M/Ay3CBMKVW5FAuKt5uSntq8r7dP
	q8cuSxPr/0zH2lFxg6mX0OZwPEsZwqBtFGAHp9WDJ+D8DZKuGHf+puR9DOREe8NM
	CPGROv3EolZGUUkLyf+gE/MABR/i84Kf0wyARVn8srvqkiEPb/yIIVGzk0JXyns/
	x0Q/FOOydLUBHpngdq1scbrNPrDEnGanNEQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkuy0jg7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 17:14:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd91c0262fso176550385a.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Mar 2026 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773681278; x=1774286078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EL8eRmWCbyxanJKOyEB/eWK8uBWGSkS3eehQ6T7GtLo=;
        b=YKRBn1KS7ThhqBs8KAA1VAJXXYNxTRPJMx2nvjhAxvC0IZTsJ0OVzwtYXednPCuwWl
         YUv8xRLEfWqNKvXgX5bPqStlWA7j5dHeiwVYd/P2PKXY75Qae9DPowkmTy8IqvVZbYQZ
         yT1tkZeQMtzm1dL+LZxFHFNyacRqaTn02WyUANOKS8iwqATo1j2uMaAuW5zzgmGMVP6y
         RStH62ImLHMGI7shZJqjSjuvqbbPBDN9gpPws37TIcXlV39MXF8gQN7F5lyODyP/wgTM
         uyTwCkFc/0QbPkcMxD9PXd3yeT6S+0nfeJ9/YBs9BQX/BNowsPs1ZANwkbG0JpgFrRbp
         pYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681278; x=1774286078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EL8eRmWCbyxanJKOyEB/eWK8uBWGSkS3eehQ6T7GtLo=;
        b=lQ0gTs7rkPGHcvje+VSGSv4mKvmHq1k+UvDc1ZkXOR6tK6OpTibGRluM/rxirxBtWj
         G2WvxlGBqhoNlT7YSaENdNu2O9j4IolqBhsLJjQ8ESdT18R+/REbsQ2bdV7Ct8JEcnTG
         RRxbvE8SLvZbYevXtajBueadQFjvDAPwdRrkKRIq6uyMpV9Lx8kN2bhnIKdDESI5xNwN
         uC1Alf8R/ad8CAqJ7ewu2B6WftKU5l+bc70mKGspRADHGIk9o4H/b3iOxe98eawf/tCi
         FQU5/gIUQ30L5nSMOd4IbHS92g2E/t/zklhsXUNOvvaB3Q+NqawsjLyqg9jti+qmOJ5H
         U2iw==
X-Forwarded-Encrypted: i=1; AJvYcCWyMfAt8d2pPvc+OPauXp7UcMQkBjQA2FxMRSkfEvVleCP6e80OhEe71Llu3mzDsMPsTElVqeY9SiArm/w9sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxU2zV1tVcBUymPuakhVS0HsDFKVIClMK7c4wVuUvKrywEoZqSm
	kbGQ9rIx75a027Qspd5fd5zRVguM7cthsssQArO/wD0hFzKAPQfnAVi7Y0TQ94NPIG84ZG1T8DA
	G3KCTab+zMWt7LtmT4Vx7MAxGP1T9BIHvGRsHHID2lqk4Fsnm5fckQIs1NUtdh3WHJ7QaZw==
X-Gm-Gg: ATEYQzwDKiOapyGzOXSxh1VMQiLmN6o2zjjiEGjbC0sOPYuvGT2J3WEjOks/J4huUaM
	bc64VJUu5lF/FhKdyhIR24LhAa71Hd5B3nNHJ4WyW8Np2z5RfvoAZ/lJeFbjkxAFxISAjAWBdls
	SrcV6jmboQkVzuCPJhLTgZ4H7hLAObCDErW2olRNzDoKx+5KuQWj3oExauI9rJPoX5YUoK+lwu5
	F/wdse1nP5sBO70XnoGtljQJGKBlvI9dly2T9mL5Dfi49g709JRUcJ/9HG+0K3It8gt0oy7LzIq
	nsY3vxByf3LtRbA1S45hxKJ6RIdWmPCRHVcsuKRMadCfcROIjmNN/v5iNy5dle3BnC2I99aPUgD
	iYvnwZdPiJX+6Hb7/+TPzI2vzagaTApK21XMGNOxSwzuXoq/8Ug==
X-Received: by 2002:a05:620a:a494:b0:8cd:b90f:fc16 with SMTP id af79cd13be357-8cdb90ffcfbmr1273230685a.68.1773681278080;
        Mon, 16 Mar 2026 10:14:38 -0700 (PDT)
X-Received: by 2002:a05:620a:a494:b0:8cd:b90f:fc16 with SMTP id af79cd13be357-8cdb90ffcfbmr1273227985a.68.1773681277463;
        Mon, 16 Mar 2026 10:14:37 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:5dfc:3995:22ce:d286])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe20b544sm43860993f8f.20.2026.03.16.10.14.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 10:14:36 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: konradybcio@kernel.org, andersson@kernel.org
Cc: linux-kernel@vger.kernel.org, Alex Elder <elder@kernel.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jeff Johnson <jjohnson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Srinivas Kandagatla <srini@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>, netdev@vger.kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, ath12k@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-sound@vger.kernel.org
Subject: [PATCH v2 0/4] Use the QMI service IDs from the QMI header
Date: Mon, 16 Mar 2026 18:14:10 +0100
Message-ID: <20260316171419.2619620-1-daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=69b83a7e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8 a=J1Y8HTJGAAAA:8 a=1XWaLZrsAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=iox4zFpeAAAA:8 a=ag1SF4gXAAAA:8
 a=COk6AnOGAAAA:8 a=JfrnYn6hAAAA:8 a=0T1-nGNzAKzEL-VDnLsA:9
 a=PEH46H7Ffwr30OY-TuGO:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=cvBusfyB2V15izCimMoJ:22
 a=WzC6qhA0u3u7Ye7llzcV:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=TjNXssC_j7lpFel5tvFf:22
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEzMyBTYWx0ZWRfX0VnrQH3K0z1f
 NQw3U89+gBVJbiBKkP93uKSmYRpMRwyWuyD1VpWbxn0MqcNdCvfmskhR4489Kv+j5u1xcHrU12U
 4YUzm7b2HMofWZom4oKuvQeHkn6vboUozAQrJDJ1HkHnd7y7z4zf0AMeNC9XQxINhv7zfLd4cCO
 GRv1MqdC01ZV/q0fonUXzbASHbgKw1rYNZbzus57Tlqg5vmaWXHldFmU9eaoLP3DSC5iTKN86tm
 d03tv01ftZPSEP9WU2Y+yWbJx8yrO8/tKNqSG1nOKqNhhYaj7q75LqdfXQi71gN3KDnWlUt4wui
 wxONMAHhFmMl4OfNNfQosiyDhYK5qNbiRo30zLzf8kXkzqO3ouQIVVWqvMH2ubgnwdpQzLx0HC6
 lEufmSrD0wIKcEEl9E12266euP0rXdiK6JmeU276tgTMMs1mPeopawpTq26yWeIwMmveylHLbV8
 L3QCldrSwuploF9+Cdw==
X-Proofpoint-ORIG-GUID: oyj7dbPgBaxCVFB0bc1rRS07rmP3z7o6
X-Proofpoint-GUID: oyj7dbPgBaxCVFB0bc1rRS07rmP3z7o6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160133
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[27];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33305-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.lezcano@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0922B29DFFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The different subsystems implementing the QMI service protocol are
using their own definition of the service id. It is not a problem but
it results on having those duplicated with different names but the
same value and without consistency in their name.

The QMI service IDs are defined in the qmi.h header file. Use those
instead of defining the IDs in the protocol implementation file. It
will result in unifying and providing a consistent way to represent
the supported protocols.

This series is based on the immutable branch [1] containing the QMI
service id definitions along with some drivers using them.

How a patch can be merged ?

 * Add the Ack tag and let it go through the QCom's tree

   OR

 * Apply the patch on top of the immutable branch [1]

[1] https://lore.kernel.org/all/abdkE2qWX5Amf5Jo@baldur/


Changelog:

  v2:
   * Added Reviewed-by tags
   * Removed patches picked up by Bjorn
   * Rebase on top of the immutable branch from QCom's tree
   * Fixed up short description prefix for wifi changes
  v1:
   * Initial post

Cc: Alex Elder <elder@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Jeff Johnson <jjohnson@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Srinivas Kandagatla <srini@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Kees Cook <kees@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: ath10k@lists.infradead.org
Cc: ath11k@lists.infradead.org
Cc: ath12k@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-remoteproc@vger.kernel.org
Cc: linux-sound@vger.kernel.org
---
Daniel Lezcano (4):
  net: ipa: Use the unified QMI service ID instead of defining it
    locally
  wifi: ath: Use the unified QMI service ID instead of defining it
    locally
  slimbus: qcom-ngd-ctrl: Use the unified QMI service ID instead of
    defining it locally
  ALSA: usb-audio: qcom: Use the unified QMI service ID instead of
    defining it locally

 drivers/net/ipa/ipa_qmi.c                      | 6 ++----
 drivers/net/wireless/ath/ath10k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath10k/qmi_wlfw_v01.h | 1 -
 drivers/net/wireless/ath/ath11k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h          | 1 -
 drivers/net/wireless/ath/ath12k/qmi.c          | 2 +-
 drivers/net/wireless/ath/ath12k/qmi.h          | 1 -
 drivers/slimbus/qcom-ngd-ctrl.c                | 5 ++---
 sound/usb/qcom/qc_audio_offload.c              | 2 +-
 sound/usb/qcom/usb_audio_qmi_v01.h             | 1 -
 10 files changed, 8 insertions(+), 15 deletions(-)

-- 
2.43.0


