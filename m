Return-Path: <linux-wireless+bounces-32006-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEMDBZ6+lmlHlgIAu9opvQ
	(envelope-from <linux-wireless+bounces-32006-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 08:41:18 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A978715CC2D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 08:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E66723006450
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Feb 2026 07:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E389C279355;
	Thu, 19 Feb 2026 07:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="doZhYw1d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f/BgmxY6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9C02D46C0
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771486874; cv=none; b=PWhjwdF/GSgtzTQg1KfIJVvPi3oaFEnJ22eIOOaTxY7KIrSmvGmN0FaYUihZnhCB2yvcQi2T/H0/Liqb20a96vZOysLnZT7Jxep2jNtThsAQ1pVO/MazfJr1X7HCy1kpiHOpiJq4YIkRuoOfY7ljYt8UCQSrML3hYU34nLPE/cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771486874; c=relaxed/simple;
	bh=VdDjSTYlddr7tMlcikXi2o+g6kH2NdlOEdEZOqMtiRg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=eByRR6yzBEsTNkcCS0LHv8aPY3Wo17g/eZK43D0H/R4R2z4tZVsHtL7r83RUkQ0d+BSRMRVSMLJftFmvGU60U9KVWtNC4LssUcohJdV8vxxvp4bvmm0F77jbFnxSi3/hJcQwQ9VkNDLGEhtb8bKOKKsZI+URVXZVvpmnSxnyNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=doZhYw1d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f/BgmxY6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61J6DEvs421065
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 07:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:date:from:message-id:subject:to; s=qcppdkim1; bh=Vngj+bPcsT9q
	8cGQW7aQKCmPQjyzHumirAjRa82Dfog=; b=doZhYw1dSqMqxxFvgVmEhp1mAJNU
	hgtuBekbvz2unvWxRAjyKmDnz4VI16ySRv/GFWebU9SRrAmlxmpXr+gY4sLgICgU
	HX3h9RMKApsBJnJtHNhsS4KSlkSDMCLL7mNGSnteuXDrvM8tdscWT5mljIfYLDZ4
	e8z4DzBSe6/ZI0hmfczk2bqLLEnRKIfGnylp4zL9T7xH4PPUVVNdEyQj8Gn2cVmB
	i6KFHVuWtToVCdlW1FhOwS/fGnmBpJ4nkl5KOdiPpE/D+DBknORXWZFDHb/IGYrf
	PAczwRhVOi+hGa1CD1NJz3UuIT9oFR0iLrdABEDH8n/yM17MNcs7lh1GPw==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cd76e3pa4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 19 Feb 2026 07:41:12 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-679a47a1febso8144864eaf.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Feb 2026 23:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771486871; x=1772091671; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vngj+bPcsT9q8cGQW7aQKCmPQjyzHumirAjRa82Dfog=;
        b=f/BgmxY6+qzhC/2LCau3uHTvZW0M8mjYvC0wVu0gubPJ0VhO5URUJFnoiNo4CXWBMm
         0REkQ6RK0sc85ld3eee/UqoemZ75yUMlhcxX4VZeLJiYak8QqRAdFI/RBzZywoM8ocgT
         10Jajxuowp0hC1Hr0b09C02+OG3OoNYkxFpLm+j8UTQASuG/5JK3vmK1LQ5LKxb0sKC2
         oyXIX/PUkOHjNHeGNahN+7zo46B14viVQXKkws+WqZ4B87R0fqXvi/aBtu1JP/n1Ldd3
         50r94AWvoM1fwZedUUFKQfyV6zhZ+ogKgXLsPahk1lxRyqEyRvMsWU8yu5ek9Ewjayl2
         N95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771486871; x=1772091671;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vngj+bPcsT9q8cGQW7aQKCmPQjyzHumirAjRa82Dfog=;
        b=DdnrkHYzqN3cKSlneyAE+pEOYIZK6NueoEpmyqg0CQGGLBuo6Ebhi9ClnUtWs7vtJg
         T93M6ehYmBsVxzCCZnrIw0iHbCKv0S14714XftkQPXnDvcUJStDv7BHIZwsy+VoOiL94
         QpLShmHKHdtXJRmXery2ycWP7DYvj/B/hGN2xpYfkZ66CLa6NlGsiqA0V/V23ZFERXvb
         Zw3krvxfYfSxhqMpbgfxi++X94hC/6SXm04qG+1kuVAm9/o+ezZVls7oWnF/E37Vd4Bm
         92/iDhsYLPZOSqTtj4uO7vXg+A6Q8isBAtdHZD5kFqjoBIFrjwyNFXNnJuUcRWGO7iMp
         D8ew==
X-Gm-Message-State: AOJu0YyhloEtTQQRGQTipJX3mrP0cyy6edWhHrVVtW7WwjVuKWZAIj/i
	CzzUZR4HdyWOXzaagX22aSseQ6TNWGpUXegVxCAGfIQVLzwOAr70EIHgXYI03Ei4OLM9mXhYrtp
	g3lvmI3tSWHvYVqxJnUHB4Ytk0+FIun+PUzHo/Iqero8v0tYxD2v8WAknMYwpzRCRY+nzgzMAx1
	WfAA==
X-Gm-Gg: AZuq6aK/35kOQUjE0NmIRtVN16cbkf+MX5MBHUD69T7ODGaHNaZGPr/F1lQRyRXccl9
	/sfS/UZ6aMu7Ek2Meas8syg8wI+TGtJlKc+sNdwsrCDe2xve6l5TL3a92vUugwwYjCoqR3vc1a4
	RjX1y/Sijhlj7cltDJ1itGRAtd37QIBxS5QJChNY1sb+6+T/NO83U+MlcyhnZtQoyoUb1XOSjps
	0ix2wNHtXgFwO04NeAaVm0kHWsonHPaZMalgqR/HKz6XjKCxxdlmTczpOLzXpZSY4TCeEh7/8FQ
	+HNzpjjrS+TudkC8nMc54v8J1EA5o4A1HaRcbjKiAG3J5mv+BWl0PzAI0ZwzwuwYIFk/SiBtpqy
	HeIOwYtiKJ+pF80lqKuHcL4Z57BVAfZPeHZ+rENpfTvasZ81C5CBgZ6fGuE4iN6JO
X-Received: by 2002:a05:6820:1694:b0:679:971a:305 with SMTP id 006d021491bc7-679a7477291mr2435015eaf.76.1771486871288;
        Wed, 18 Feb 2026 23:41:11 -0800 (PST)
X-Received: by 2002:a17:90b:4a8a:b0:34a:b4a2:f0c8 with SMTP id 98e67ed59e1d1-358891ca7c4mr3473125a91.30.1771486486614;
        Wed, 18 Feb 2026 23:34:46 -0800 (PST)
Received: from che-ventolnx02.qualcomm.com ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6e52fd0ecasm17180269a12.7.2026.02.18.23.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 23:34:46 -0800 (PST)
From: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
        Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>,
        Aishwarya R <aishwarya.r@oss.qualcomm.com>
Subject: [PATCH ath-next v2] wifi: ath12k: add basic hwmon temperature reporting
Date: Thu, 19 Feb 2026 13:04:40 +0530
Message-Id: <20260219073440.19618-1-maharaja.kennadyrajan@oss.qualcomm.com>
X-Mailer: git-send-email 2.17.1
X-Authority-Analysis: v=2.4 cv=OKsqHCaB c=1 sm=1 tr=0 ts=6996be98 cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=NPPaRV88JsJ7pIHLkfUA:9
 a=-UhsvdU3ccFDOXFxFb4l:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDA2OSBTYWx0ZWRfX5ieb3npKX83G
 V/kU52koTg2lLiCd6O4UCBIRCtFzqS+R3u+v5wSh3xseSsH0ReGtDsQb5HEL1hkNUSqJyjjpnAk
 +itk1a+LOzgk8MZMgmZ5yaPqPZKM+QEclGHTRY0CqWbBAAnw7zbmWhkLDAJduqGm1O5pdj0M0g+
 Q8v3K5p2b6zASVkqEScpSHsGJg0Q+wNPm5oS3XVgWY0n8P7+gB0USxpxlvPv22ikIGMJ01S0Lsz
 cFNcE46m0ezU0mpM5EYty177sjF86ihwyBk2pOoFbE0X5lI5D4OaqXIJAO/s68rG0v4lFphi0MO
 Zp6T/drdvtUWx9QQit2gz+Q/vQuE+SiuVE9eJ6TPKFjZ/AfmyB6tSwJe/wtBinYP23QGKhTzaF6
 qCLSngl1OUEL8Gjw39xeI6NsIm43XSw4WIo5k3pmO+I3Fe+x7mlihczIecKOc5aD5wYDgKJX7a+
 MQAiaFhNKhJ9zQ8sqyw==
X-Proofpoint-GUID: 6hDnNL0QQ3USDh4CXoiuJcQ5HPQeyyB_
X-Proofpoint-ORIG-GUID: 6hDnNL0QQ3USDh4CXoiuJcQ5HPQeyyB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602190069
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32006-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,qualcomm.com:email,qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maharaja.kennadyrajan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A978715CC2D
X-Rspamd-Action: no action

Add initial thermal support by wiring up a per-radio (pdev) hwmon temperature
sensor backed by the existing WMI pdev temperature command and event.
When userspace reads the sysfs file temp1_input, the driver sends
WMI_PDEV_GET_TEMPERATURE_CMDID (tag WMI_TAG_PDEV_GET_TEMPERATURE_CMD) and waits
for the corresponding WMI_PDEV_TEMPERATURE_EVENTID
(tag WMI_TAG_PDEV_TEMPERATURE_EVENT) to get the temperature and pdev_id.

Export the reported value in millidegrees Celsius as required by hwmon.
The temperature reported is per-radio (pdev). In a multi-radio wiphy under a
single phy, a separate hwmon device is created for each radio.

Sample command and output:
$ cat /sys/devices/pci0000:00/.../ieee80211/phyX/hwmonY/temp1_input
$ 50000

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.6-01243-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.1.c5-00302-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.115823.3

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602160145.YQdvbqYY-lkp@intel.com/
Co-developed-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Signed-off-by: Aishwarya R <aishwarya.r@oss.qualcomm.com>
Signed-off-by: Maharaja Kennadyrajan <maharaja.kennadyrajan@oss.qualcomm.com>
---

v2: Fixed the kernel test robot reported build test error. 

 drivers/net/wireless/ath/ath12k/Makefile  |   1 +
 drivers/net/wireless/ath/ath12k/core.c    |  13 +++
 drivers/net/wireless/ath/ath12k/core.h    |   3 +
 drivers/net/wireless/ath/ath12k/mac.c     |   5 +
 drivers/net/wireless/ath/ath12k/thermal.c | 125 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath12k/thermal.h |  44 ++++++++
 drivers/net/wireless/ath/ath12k/wmi.c     |  57 +++++-----
 7 files changed, 217 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.c
 create mode 100644 drivers/net/wireless/ath/ath12k/thermal.h

diff --git a/drivers/net/wireless/ath/ath12k/Makefile b/drivers/net/wireless/ath/ath12k/Makefile
index 3ba1236956cc..3b39b2c33307 100644
--- a/drivers/net/wireless/ath/ath12k/Makefile
+++ b/drivers/net/wireless/ath/ath12k/Makefile
@@ -32,6 +32,7 @@ ath12k-$(CONFIG_ATH12K_TRACING) += trace.o
 ath12k-$(CONFIG_PM) += wow.o
 ath12k-$(CONFIG_ATH12K_COREDUMP) += coredump.o
 ath12k-$(CONFIG_NL80211_TESTMODE) += testmode.o
+ath12k-$(CONFIG_THERMAL) += thermal.o
 
 # for tracing framework to find trace.h
 CFLAGS_trace.o := -I$(src)
diff --git a/drivers/net/wireless/ath/ath12k/core.c b/drivers/net/wireless/ath/ath12k/core.c
index 9d6c50a94e64..9dca1a0af73e 100644
--- a/drivers/net/wireless/ath/ath12k/core.c
+++ b/drivers/net/wireless/ath/ath12k/core.c
@@ -863,11 +863,22 @@ static int ath12k_core_pdev_create(struct ath12k_base *ab)
 		return ret;
 	}
 
+	ret = ath12k_thermal_register(ab);
+	if (ret) {
+		ath12k_err(ab, "could not register thermal device: %d\n", ret);
+		goto err_dp_pdev_free;
+	}
+
 	return 0;
+
+err_dp_pdev_free:
+	ath12k_dp_pdev_free(ab);
+	return ret;
 }
 
 static void ath12k_core_pdev_destroy(struct ath12k_base *ab)
 {
+	ath12k_thermal_unregister(ab);
 	ath12k_dp_pdev_free(ab);
 }
 
@@ -1361,6 +1372,7 @@ static int ath12k_core_reconfigure_on_crash(struct ath12k_base *ab)
 
 	mutex_lock(&ab->core_lock);
 	ath12k_link_sta_rhash_tbl_destroy(ab);
+	ath12k_thermal_unregister(ab);
 	ath12k_dp_pdev_free(ab);
 	ath12k_ce_cleanup_pipes(ab);
 	ath12k_wmi_detach(ab);
@@ -1502,6 +1514,7 @@ static void ath12k_core_pre_reconfigure_recovery(struct ath12k_base *ab)
 			complete(&ar->vdev_delete_done);
 			complete(&ar->bss_survey_done);
 			complete_all(&ar->regd_update_completed);
+			complete_all(&ar->thermal.wmi_sync);
 
 			wake_up(&ar->dp.tx_empty_waitq);
 			idr_for_each(&ar->txmgmt_idr,
diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 990934ec92fc..760c76d6f0f4 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -36,6 +36,7 @@
 #include "coredump.h"
 #include "cmn_defs.h"
 #include "dp_cmn.h"
+#include "thermal.h"
 
 #define SM(_v, _f) (((_v) << _f##_LSB) & _f##_MASK)
 
@@ -757,6 +758,8 @@ struct ath12k {
 
 	s8 max_allowed_tx_power;
 	struct ath12k_pdev_rssi_offsets rssi_info;
+
+	struct ath12k_thermal thermal;
 };
 
 struct ath12k_hw {
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 68431a0e128e..d1db1285449c 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -14792,6 +14792,11 @@ static void ath12k_mac_setup(struct ath12k *ar)
 	init_completion(&ar->mlo_setup_done);
 	init_completion(&ar->completed_11d_scan);
 	init_completion(&ar->regd_update_completed);
+	init_completion(&ar->thermal.wmi_sync);
+	mutex_init(&ar->thermal.read_lock);
+
+	ar->thermal.temperature = 0;
+	ar->thermal.hwmon_dev = NULL;
 
 	INIT_DELAYED_WORK(&ar->scan.timeout, ath12k_scan_timeout_work);
 	wiphy_work_init(&ar->scan.vdev_clean_wk, ath12k_scan_vdev_clean_work);
diff --git a/drivers/net/wireless/ath/ath12k/thermal.c b/drivers/net/wireless/ath/ath12k/thermal.c
new file mode 100644
index 000000000000..b01e03e5a357
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/thermal.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: BSD-3-Clause-Clear
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/device.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/sysfs.h>
+#include <linux/thermal.h>
+#include "core.h"
+#include "debug.h"
+
+static ssize_t ath12k_thermal_temp_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct ath12k *ar = dev_get_drvdata(dev);
+	unsigned long time_left;
+	int ret, temperature;
+
+	guard(wiphy)(ath12k_ar_to_hw(ar)->wiphy);
+	guard(mutex)(&ar->thermal.read_lock);
+
+	if (ar->ah->state != ATH12K_HW_STATE_ON)
+		return -ENETDOWN;
+
+	reinit_completion(&ar->thermal.wmi_sync);
+	ret = ath12k_wmi_send_pdev_temperature_cmd(ar);
+	if (ret) {
+		ath12k_warn(ar->ab, "failed to read temperature %d\n", ret);
+		return ret;
+	}
+
+	if (test_bit(ATH12K_FLAG_CRASH_FLUSH, &ar->ab->dev_flags))
+		return -ESHUTDOWN;
+
+	time_left = wait_for_completion_timeout(&ar->thermal.wmi_sync,
+						ATH12K_THERMAL_SYNC_TIMEOUT_HZ);
+	if (!time_left) {
+		ath12k_warn(ar->ab, "failed to synchronize thermal read\n");
+		return -ETIMEDOUT;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	temperature = ar->thermal.temperature;
+	spin_unlock_bh(&ar->data_lock);
+
+	/* display in millidegree celsius */
+	return sysfs_emit(buf, "%d\n", temperature * 1000);
+}
+
+void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature)
+{
+	spin_lock_bh(&ar->data_lock);
+	ar->thermal.temperature = temperature;
+	spin_unlock_bh(&ar->data_lock);
+	complete_all(&ar->thermal.wmi_sync);
+}
+
+static SENSOR_DEVICE_ATTR_RO(temp1_input, ath12k_thermal_temp, 0);
+
+static struct attribute *ath12k_hwmon_attrs[] = {
+	&sensor_dev_attr_temp1_input.dev_attr.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(ath12k_hwmon);
+
+int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int i, j, ret;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return 0;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		ar->thermal.hwmon_dev =
+			hwmon_device_register_with_groups(&ar->ah->hw->wiphy->dev,
+							  "ath12k_hwmon", ar,
+							  ath12k_hwmon_groups);
+		if (IS_ERR(ar->thermal.hwmon_dev)) {
+			ret = PTR_ERR(ar->thermal.hwmon_dev);
+			ar->thermal.hwmon_dev = NULL;
+			ath12k_err(ar->ab, "failed to register hwmon device: %d\n",
+				   ret);
+			for (j = i - 1; j >= 0; j--) {
+				ar = ab->pdevs[i].ar;
+				if (!ar)
+					continue;
+
+				hwmon_device_unregister(ar->thermal.hwmon_dev);
+				ar->thermal.hwmon_dev = NULL;
+			}
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+void ath12k_thermal_unregister(struct ath12k_base *ab)
+{
+	struct ath12k *ar;
+	int i;
+
+	if (!IS_REACHABLE(CONFIG_HWMON))
+		return;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		ar = ab->pdevs[i].ar;
+		if (!ar)
+			continue;
+
+		if (ar->thermal.hwmon_dev) {
+			hwmon_device_unregister(ar->thermal.hwmon_dev);
+			ar->thermal.hwmon_dev = NULL;
+		}
+	}
+}
diff --git a/drivers/net/wireless/ath/ath12k/thermal.h b/drivers/net/wireless/ath/ath12k/thermal.h
new file mode 100644
index 000000000000..a853af5f2441
--- /dev/null
+++ b/drivers/net/wireless/ath/ath12k/thermal.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: BSD-3-Clause-Clear */
+/*
+ * Copyright (c) 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _ATH12K_THERMAL_
+#define _ATH12K_THERMAL_
+
+#include <linux/mutex.h>
+
+#define ATH12K_THERMAL_SYNC_TIMEOUT_HZ (5 * HZ)
+
+struct ath12k_thermal {
+	struct completion wmi_sync;
+
+	/* temperature value in Celsius degree protected by data_lock. */
+	int temperature;
+	struct device *hwmon_dev;
+	/* Serialize concurrent sysfs reads to avoid completion races */
+	struct mutex read_lock;
+};
+
+#if IS_REACHABLE(CONFIG_THERMAL)
+int ath12k_thermal_register(struct ath12k_base *ab);
+void ath12k_thermal_unregister(struct ath12k_base *ab);
+void ath12k_thermal_event_temperature(struct ath12k *ar, int temperature);
+#else
+static inline int ath12k_thermal_register(struct ath12k_base *ab)
+{
+	return 0;
+}
+
+static inline void ath12k_thermal_unregister(struct ath12k_base *ab)
+{
+}
+
+static inline void ath12k_thermal_event_temperature(struct ath12k *ar,
+						    int temperature)
+{
+}
+
+#endif
+#endif /* _ATH12K_THERMAL_ */
diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 7617fc3a2479..69f2dbcfca63 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -6778,31 +6778,6 @@ static int ath12k_pull_peer_assoc_conf_ev(struct ath12k_base *ab, struct sk_buff
 	return 0;
 }
 
-static int
-ath12k_pull_pdev_temp_ev(struct ath12k_base *ab, struct sk_buff *skb,
-			 const struct wmi_pdev_temperature_event *ev)
-{
-	const void **tb;
-	int ret;
-
-	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
-	if (IS_ERR(tb)) {
-		ret = PTR_ERR(tb);
-		ath12k_warn(ab, "failed to parse tlv: %d\n", ret);
-		return ret;
-	}
-
-	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
-	if (!ev) {
-		ath12k_warn(ab, "failed to fetch pdev temp ev");
-		kfree(tb);
-		return -EPROTO;
-	}
-
-	kfree(tb);
-	return 0;
-}
-
 static void ath12k_wmi_op_ep_tx_credits(struct ath12k_base *ab)
 {
 	/* try to send pending beacons first. they take priority */
@@ -8811,25 +8786,45 @@ static void
 ath12k_wmi_pdev_temperature_event(struct ath12k_base *ab,
 				  struct sk_buff *skb)
 {
+	const struct wmi_pdev_temperature_event *ev;
 	struct ath12k *ar;
-	struct wmi_pdev_temperature_event ev = {};
+	const void **tb;
+	int temp;
+	u32 pdev_id;
+
+	tb = ath12k_wmi_tlv_parse_alloc(ab, skb, GFP_ATOMIC);
+	if (IS_ERR(tb)) {
+		ath12k_warn(ab, "failed to parse tlv: %ld\n", PTR_ERR(tb));
+		return;
+	}
 
-	if (ath12k_pull_pdev_temp_ev(ab, skb, &ev) != 0) {
-		ath12k_warn(ab, "failed to extract pdev temperature event");
+	ev = tb[WMI_TAG_PDEV_TEMPERATURE_EVENT];
+	if (!ev) {
+		ath12k_warn(ab, "failed to fetch pdev temp ev\n");
+		kfree(tb);
 		return;
 	}
 
+	temp = a_sle32_to_cpu(ev->temp);
+	pdev_id = le32_to_cpu(ev->pdev_id);
+
+	kfree(tb);
+
 	ath12k_dbg(ab, ATH12K_DBG_WMI,
-		   "pdev temperature ev temp %d pdev_id %d\n", ev.temp, ev.pdev_id);
+		   "pdev temperature ev temp %d pdev_id %u\n",
+		   temp, pdev_id);
 
 	rcu_read_lock();
 
-	ar = ath12k_mac_get_ar_by_pdev_id(ab, le32_to_cpu(ev.pdev_id));
+	ar = ath12k_mac_get_ar_by_pdev_id(ab, pdev_id);
 	if (!ar) {
-		ath12k_warn(ab, "invalid pdev id in pdev temperature ev %d", ev.pdev_id);
+		ath12k_warn(ab, "invalid pdev id %u in pdev temperature ev\n",
+			    pdev_id);
 		goto exit;
 	}
 
+	ath12k_thermal_event_temperature(ar, temp);
+
 exit:
 	rcu_read_unlock();
 }

base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
-- 
2.17.1


