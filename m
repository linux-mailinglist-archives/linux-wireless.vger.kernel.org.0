Return-Path: <linux-wireless+bounces-32584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAYOJKdvqmkwRgEAu9opvQ
	(envelope-from <linux-wireless+bounces-32584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 07:09:43 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4A21BF55
	for <lists+linux-wireless@lfdr.de>; Fri, 06 Mar 2026 07:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C84030221EE
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2026 06:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEDD347FFA;
	Fri,  6 Mar 2026 06:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sgv7Cuo2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fv0eESNW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEB93368B6
	for <linux-wireless@vger.kernel.org>; Fri,  6 Mar 2026 06:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772777380; cv=none; b=TDWynwS4HOXOUImkp4kGZQYmdsR9kKDdKW3pUYM3RD6Zw7pdgMeo4idlsx8GgLSk0lQSgKobJr+6Deo9X9j8zSk77wrtCvooIgFO+iAd9Myk1k3F7iXhEqO/HkogPVjfYOq5v+DQqGfc1vLZqRAhQm8kdo4KF/LCSzCq9zeBa94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772777380; c=relaxed/simple;
	bh=kQYbLCilUbb+tJ6BHQTjciRQ4x2b67HHhmkgxbdgcv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D3xG/r+QrvuVp0liLVeihgIzrbTfq7FlL+Y0WDkikpRMUpjyl6K+Ie02X2aK/6Rpwl+bQSMoix3Pq1tRNxxhD1aLZp/E0lBbY6nK6onjr4GouqvFR4Jj0i+pFymUmtt7wXN3XmjTLkIYaiZOxFMPrLJ9DIazC7vVA/NmA35nax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sgv7Cuo2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fv0eESNW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62654SKc4193518
	for <linux-wireless@vger.kernel.org>; Fri, 6 Mar 2026 06:09:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vu6Y028x4zA
	SceQh5U1ZTCIbypyQ+OTcaJ3ZuVOQx2g=; b=Sgv7Cuo2KFi5U11C8Ghi1IURCj+
	NjowpwY9j+kogdoAfS3xeZRmIvuUVECnEbeX8bkQOU/x9zD10J3xORBZzBNdK/+R
	nvjLWxJIPVkGWNCCKYcSSAEY9MvOCC9noA4yPWXpyDHTPaJiBWmLqk3VLDe7ei6B
	h2hveATwJXBVDoZ2ITk0wStaoaF2Bc/+awWUTNHrBWmFma/MGRUPAsC0TWpx6WSh
	Zyyo3fr0kcusgUxfuQMR00pmWqZVrnCCyVpd5lelosk+aRkkozY+4/RpyMkhiT0B
	TjHqJFU8Mb+csusn14csocrQovO6ARKqOr/cb1t4ySfPin2erNpU/G5jkBQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cqrf5r6mt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 06 Mar 2026 06:09:38 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae50386da7so33408995ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 22:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772777377; x=1773382177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu6Y028x4zASceQh5U1ZTCIbypyQ+OTcaJ3ZuVOQx2g=;
        b=fv0eESNWqt/YJE2JHGUXNYjVCTrKHLWGXSHZNzDmSdgw3CxJgElgN/w78JB3y1GCCl
         zt8OwBioZF15/VKK90hQrBAaxaBVHlzuurI1PyRNx8EzfkHV9WYLWod4T8iH4jbshmO7
         j1vUA3qfjwmeEPsGSMsxbNfe1I1552EjjIUVMni21dfV1sCKoYQ+rKGj4corwlXmFNBK
         KxZ2keUSYqF1qEYwBPKxZV9XDQWMVYrFtrX0jkbX6lDt8P+zX0GVQGZ7+kYY0BzWb8YZ
         x+lJUZ6RadJar6/gqK61UUBmzwO/wFloEyC9Kq2PSPD+vrBKQWNkEZNEKkvxJ0eOrmXm
         hmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772777377; x=1773382177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vu6Y028x4zASceQh5U1ZTCIbypyQ+OTcaJ3ZuVOQx2g=;
        b=iNCO9qKl9RAFxTdIkjRqItvNZHlSR1oeJ0ApeTCcl7R9HWPmXndeZ6pqnN71riY72D
         iLs+oMEgOH58zekSHbdgTYsxKLJlqCIpLWgqTIi8FQLAGOxaOnkpr3ZbUMgckqUWKd3f
         8LNcOd0Uy8HawNxM67tOsat2S5HH//HC19NQ9CbleoEkI6SIYawV/GJsVTUQhR/g+UGQ
         mrfOdSKdNwX8KCEVegKJmH1C7JuGu80VDoWEZq1/wSmNUoGIMnx60qlkIKqh0hvhiviV
         qz1JxWK2kLWxGpjrWHA3jb1+2LE69prqnYLHwJn/vuN+mgxK4/uk8abV9Glq54SrE79C
         fPFA==
X-Gm-Message-State: AOJu0Yxkn2PHdOnr05cX9y2eLi7MqHoSNLOZtLDgt6fEhSedt6LOtYmZ
	mkzvFFbTg7dyLkoTB/sDJnw4KECWsHa/g4KTiOuxbw42JAaDpKZeqAgt8vt3LAAiqis9boBKCn5
	YNabXqXGdMLHihdaKFaIhoFZYwSxOxtCgE28gH4oHFFX/1jGIuUTBReap0RRCrnJXDNdHGw==
X-Gm-Gg: ATEYQzwWKZcsmh1yRmQNemw3W3d65Vxh5GI9tt5TSJftLAxoDne4+chxThQhIyzGtyc
	Wl2IV0Ri+cKujj0Tu/AptM08qm51YCtdJS1u69qxthQXGJvEbywSZD71COkyFUDfXWJgcXkaX9c
	7YHajHeCD5CzQysxKp2JIbTejjWyLAcS9mNyNELsCbUpYoYs52O0ACxJkDWOy+xiZVyQjRm52lH
	rjqalGvQOc6fRhsjVwEwDlDfugTkCeUo/TzIh/wPRFwJlFIBzxq8fXtEpZisn/pGQrnoYO8yOmt
	wpsU4K38L+SaTuEW5uuwY+LA+Rj5pNl6+KZ+M/BScxfHZvpgSStVGXfoUCcvugUf+2AThh6O9R0
	WuRc9l5lHl7ICBRJvUm1uiG23a5p7/pI4T7H+k30JDhoiYBMIXIUNJLxnFRCzx6//fHRY0R8XA3
	d/sSFcMjQchh2HHewWkOlMqw9ty5NxDwkx1ZY=
X-Received: by 2002:a05:6a21:1f89:b0:38e:54b8:6085 with SMTP id adf61e73a8af0-3985a8a5718mr1045221637.30.1772777377053;
        Thu, 05 Mar 2026 22:09:37 -0800 (PST)
X-Received: by 2002:a05:6a21:1f89:b0:38e:54b8:6085 with SMTP id adf61e73a8af0-3985a8a5718mr1045188637.30.1772777376498;
        Thu, 05 Mar 2026 22:09:36 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48647e8sm589804b3a.33.2026.03.05.22.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:09:36 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v6 1/1] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Fri,  6 Mar 2026 11:39:27 +0530
Message-Id: <20260306060927.504567-2-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306060927.504567-1-amith.a@oss.qualcomm.com>
References: <20260306060927.504567-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: APb2BZpRohlGs5bu9Xt8cCIQ2mcwDyPt
X-Proofpoint-GUID: APb2BZpRohlGs5bu9Xt8cCIQ2mcwDyPt
X-Authority-Analysis: v=2.4 cv=L+oQguT8 c=1 sm=1 tr=0 ts=69aa6fa2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=hKFsE3avd91Dany1T-sA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDA1NiBTYWx0ZWRfXyiTQBjAbCdh+
 LCgc4zwZ8UZqD2QpEVQx2mOTs3oCOLzyOBfwwZU9Veufo7dnBjitvNYKAV9vWAIQ3TbHowW+wkW
 gvN4BbQMUXNGrhRxntGQsOYea9PTUhhFZ42DSpSwzie3ukIDtv/2FtCb1b99GvdDB0nk2evmMFP
 03AubBC1lA+fJ7q+RL/ME2TrL0ASGmYhFdeYJCeYPkpW4tGqwZphBDSUepVC/jKe4LhoN/kYH5m
 IAYWPlwzLPeDqlcgMrBG9eF8SPPyEhYcKY/Aq5lepjh5lzE06n6ZinToqUl2jwjp4xkc92QdObG
 1GVuq7uIK7FiEyh4aEb/3rGpc/W61szw0K7ZfyxkyXRt+LZrOlUtB4EFOcTsuGQkEKVBVeTkUiJ
 K+5Sjd/rlkXUJyM77alfZ87WI2MEZnR2kfqiahQycrpS3OVhgJuafH25Nq1dn+ntJPK6BUNY8TO
 yLPeExPJRKt4zFyfIhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_02,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060056
X-Rspamd-Queue-Id: BAC4A21BF55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32584-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Add a debugfs 'simulate_incumbent_signal_interference' with custom
file_operations and a .write that accepts "<freq_mhz> <bitmap>". The
handler selects the 6 GHz chanctx whose primary 20 MHz center matches
<freq_mhz> and reports the event via cfg80211_incumbent_signal_notify().
The bitmap marks affected 20 MHz segments within the current chandef
(lowest bit = lowest segment)

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 475918ee8132..37d1c9022752 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -36,6 +36,8 @@
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
+#include <linux/uaccess.h>
+#include <linux/string.h>
 #include "mac80211_hwsim.h"
 
 #define WARN_QUEUE 100
@@ -1201,6 +1203,65 @@ static const struct file_operations hwsim_background_cac_ops = {
 	.llseek = default_llseek,
 };
 
+struct hwsim_chanctx_iter_arg {
+	struct ieee80211_chanctx_conf *conf;
+	u32 freq_mhz;
+};
+
+static void hwsim_6ghz_chanctx_iter(struct ieee80211_hw *hw,
+				    struct ieee80211_chanctx_conf *conf,
+				    void *data)
+{
+	struct hwsim_chanctx_iter_arg *arg = data;
+
+	if (conf->def.chan &&
+	    conf->def.chan->band == NL80211_BAND_6GHZ &&
+	    conf->def.chan->center_freq == arg->freq_mhz)
+		arg->conf = conf;
+}
+
+static ssize_t hwsim_simulate_incumbent_signal_write(struct file *file,
+						     const char __user *ubuf,
+						     size_t len, loff_t *ppos)
+{
+	struct mac80211_hwsim_data *data = file->private_data;
+	struct hwsim_chanctx_iter_arg arg = {};
+	u32 bitmap;
+	char buf[64];
+
+	if (!len || len > sizeof(buf) - 1)
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+	buf[len] = '\0';
+
+	if (sscanf(buf, "%u %i", &arg.freq_mhz, &bitmap) != 2)
+		return -EINVAL;
+
+	if (!arg.freq_mhz)
+		return -EINVAL;
+
+	ieee80211_iter_chan_contexts_atomic(data->hw,
+					    hwsim_6ghz_chanctx_iter,
+					    &arg);
+
+	if (!arg.conf)
+		return -EINVAL;
+
+	cfg80211_incumbent_signal_notify(data->hw->wiphy,
+					 &arg.conf->def,
+					 bitmap,
+					 GFP_KERNEL);
+
+	return len;
+}
+
+static const struct file_operations hwsim_simulate_incumbent_signal_fops = {
+	.open	= simple_open,
+	.write	= hwsim_simulate_incumbent_signal_write,
+};
+
 static int hwsim_fops_group_read(void *dat, u64 *val)
 {
 	struct mac80211_hwsim_data *data = dat;
@@ -5948,6 +6009,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		debugfs_create_file("dfs_background_cac", 0200,
 				    data->debugfs,
 				    data, &hwsim_background_cac_ops);
+	debugfs_create_file("simulate_incumbent_signal_interference", 0200,
+			    data->debugfs,
+			    data, &hwsim_simulate_incumbent_signal_fops);
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
-- 
2.34.1


