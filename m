Return-Path: <linux-wireless+bounces-31878-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2K+qBBONkmkFuwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31878-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 660DC140BC1
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 04:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40FB23008507
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 03:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE2B2AE77;
	Mon, 16 Feb 2026 03:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FWonb3M3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h7CSUP4m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC028643C
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771212041; cv=none; b=RHLwEiKxFGo58gjSIugvMZ4keS3/KMqvROE7cHd4VN2I6UK6uXcJdKV8SildJkjtKLv9eZZFSJGdu9qJuJ8fJ7MwXlMUzY6YkdKhtGKN21gxpsdY5ff/X6TBAHsH/bPtGKQKDRPBHvwN8zBae044PRHnJla6CC/CUsr3J8nWoXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771212041; c=relaxed/simple;
	bh=mfSIm+367TLnpyoQQnFtZX7WGtd1lKu3sCG5fAEn710=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LdpSk3KhO4CIKuG+p3DOGqldtVR5kP+rC8zbtmLNGGUbu15VrXbQ5UQeopFWQEPAG+olUAvh7V2nXJB8dUxNfwYsHRRNfwpt4oXkgNLlzkZnSZ0+PUncoTfWblAcUs8dr0ewC4YVNd3jQIH1mRGprEFggMws8bnX7f6UQpnaRRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FWonb3M3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h7CSUP4m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61FLkgjh3372227
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcuQ0ONFJofhcozRi55Blwnw3VxUw/Ujy11ebN0P5Qs=; b=FWonb3M3CwdB4wux
	CypJEBO4UOMEwGyqggjn1iu1R4lcut8jzESZHx9mugUCiXnD5sbiRO6kUhGa1vq0
	zLxS+uU5ySWJ8p8lgw5pV3WfS2TNgwoTTCFsegfAx124zJgOKXspFfvmcsdJpi2Q
	VpKnTT48pq2Oqm62ZLx5RXt8BBLbBKMQuEWxryVYDV7F/zD4Zblt2VKTX93FMXmi
	8xAlkuBopnsnvI45gkmujNHtPayF0qmX+bJCEYpY7zHF+u2gV/588wwjxz2Jw6H8
	bcwu1EfmRybmCI/jsDiSCNZIIyI6loYztbXWybdJ6vS50i29x92cufz8EsyE7Jps
	1sMu+w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4caj7jb4h2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 03:20:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aad60525deso146906265ad.1
        for <linux-wireless@vger.kernel.org>; Sun, 15 Feb 2026 19:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1771212039; x=1771816839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcuQ0ONFJofhcozRi55Blwnw3VxUw/Ujy11ebN0P5Qs=;
        b=h7CSUP4mAftiBChbIAE25mQ4Cg42nR1Y3mPw1F0lFLFEPiOy997/S4Bkz9rykvWkA4
         tPFDghEYUOQnzCHdJDugYuruICb1BvAbUM+RZ9X/yl9zbgjVMGGmp5H8rF4x7oraDE0u
         zl9DDpe9+PqNP30+2sPQhd89RYcnEYl4oMsj0rUxnjXgaoEjepsVDwPtOkpmH40VDtwe
         1xEUPgMSlX2x7w/l9kjz0OJy26L5Syi4eZAZb3rcG4Hlz3L2j9nUMrrX/hdel9qg7L6r
         BDxocuhtWBACg6pt7M7bXd13AceCgZ07dsKzHemxIuqnTXb8XSkDUvYp1ldf2gBVuLPq
         DR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771212039; x=1771816839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bcuQ0ONFJofhcozRi55Blwnw3VxUw/Ujy11ebN0P5Qs=;
        b=kav20iZWQ6TBKlmIBu+CDMukJzw3fZQrLX0W2ILhEOfpO8lV6gwMyQ4x7s1B86iYhQ
         Y6V3MHI0vOPFzI8mqBpYWTjAEUi77gAkbS6GViVzP6w/4m+kos8qHxxyVaqNVp2fQR6I
         qArCIE6Gw9xyt6SzWvkbKB0Rjwx3+aBlB2GmKfVcDth3vdjrF+CTZEG14Yib5kZQK/GF
         zi32jFe3b9KlegYEuwGCQQVtu3a6t5UPOkxelFSD8JQ/don1vB4H1rPBu5V88uXy80ht
         OUHokgkn633yFUrUTyjK4Vvow/SPdpVm8WrYCAA3OHxtv6trES6AdehZRbJlUSOBADnQ
         gHRw==
X-Gm-Message-State: AOJu0YzYScqZRi+dnQuqmOULfHXOs4MlmYm9VCgkz9US4kNsudsedWdt
	w+VBoW5qJ78fmTkb7HdasNi73a8ZtYTox6pTxVhq4Bkso/XufQXq4Ov+eWlzTG6MaTYP8iOznLi
	d138XioOPBvKKD/fucsEKpH6dufilukbq+IQEP0pHt35XhshJzHbSaud35VTryqzOjuyfpw==
X-Gm-Gg: AZuq6aJ3atqS7TyPOgdpJDEC3MBJKgl0ztMiPGpKiQklw628fMeLLgV/Mmeiy0lK+Lz
	k8566O2mNeDkOrogdEmfK1HmEA7+v+TghsRm8LzI9H5hs54DBK+2XROUByek9MWZSja4eueP+gD
	DDrG3DSBIgdReZU/JSTmDCTM8EBnlfdRlE3C0/XVnrCNstvsOkRxkxzd7T6x2uYPXd7kmG8X4dZ
	U4Ka6Wa6iinGL1tRAfHwYb+vO803nNu9OZXeJ3PaSlVN6vTeQrJ8gmbEJEUxFZQXhx38mArqIjR
	62bYRG7Mfy0e/vS12oPzoEcilvxG8iA8rMwelrTH8UI7ZsflhHbMTJxbDl/6TDuxNSH7MO9PGtx
	OnD4u7zsZg4Vo/x8vEUK3WkTykO+kdUWY0+N+qay2j7gcn0ccZ6/jZWTqhYSGVxIKiskyWZVEgJ
	Jupa8f28Fy8H5rSBXooKih3rCLMbie8LAVSIs=
X-Received: by 2002:a17:903:198b:b0:2aa:f0d6:bf3b with SMTP id d9443c01a7336-2ab4d09b924mr90940255ad.53.1771212038792;
        Sun, 15 Feb 2026 19:20:38 -0800 (PST)
X-Received: by 2002:a17:903:198b:b0:2aa:f0d6:bf3b with SMTP id d9443c01a7336-2ab4d09b924mr90940075ad.53.1771212038316;
        Sun, 15 Feb 2026 19:20:38 -0800 (PST)
Received: from hu-amitajit-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1ace5e1asm54637485ad.92.2026.02.15.19.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 19:20:38 -0800 (PST)
From: Amith A <amith.a@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, amith.a@oss.qualcomm.com,
        Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Subject: [PATCH wireless-next v5 2/2] wifi: mac80211_hwsim: add incumbent signal interference detection support
Date: Mon, 16 Feb 2026 08:50:27 +0530
Message-Id: <20260216032027.2310956-3-amith.a@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
References: <20260216032027.2310956-1-amith.a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dIurWeZb c=1 sm=1 tr=0 ts=69928d07 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=EUspDBNiAAAA:8 a=QGnwtivkGmgvWoY_tBMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE2MDAyNiBTYWx0ZWRfX9zkV9+6eODPm
 mhsvccbUNcCgQeC9IL1z2ogNCt2UAiW4QG8ybuxj6YGLApPPNWvpQ3LJmdEF89lgI0eqR05h9dq
 DcBRxmm60QSdgj8OLIhvLgMR/btPGO74Pe87hgSZMaU3SODfs1nofI1JierzTWAqtJvORKCOiCi
 xTEdM4NPAd0bUQtY6CRgGZW7R5nNsmZt/xc4m0t2OhSliwwLzvb79p2HrXP9myTpdDA9j9/o9Jc
 Mltt6Y47hyq/uLtL23UCSqZmnd9ffauiVuN4KGX2QhI8bzBj6pXpjfYFb9kIQJXL+Uc14y4/qSz
 5w5ahRPNcGri/ni/YKo5D4uAuaKZe1PPECkrgf7V/i65qgi45yzRNg2q2O8h3vKprn5DPiN0Brl
 XL1CbPCe+uz8Tf8EmTdh9zD0aQGm/IRYXMDNXM3wvDKJFOPMcaebOO1+anFtlonPOV6aBJGxyQ9
 lInd9tPsSNUZ6bK4LAw==
X-Proofpoint-GUID: 7MahQ9smKWgPYO9jqa0QfOTsbrKY5SFn
X-Proofpoint-ORIG-GUID: 7MahQ9smKWgPYO9jqa0QfOTsbrKY5SFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-16_01,2026-02-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602160026
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31878-lists,linux-wireless=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amith.a@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 660DC140BC1
X-Rspamd-Action: no action

From: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>

Add a debugfs ‘simulate_incumbent_signal_interference’ with custom
file_operations and a .write that accepts “<freq_mhz> <bitmap>”. The
handler selects the 6 GHz chanctx whose primary 20 MHz center matches
<freq_mhz> and reports the event via cfg80211_incumbent_signal_notify().
The bitmap marks affected 20 MHz segments within the current chandef
(lowest bit = lowest segment)

Signed-off-by: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>
Signed-off-by: Amith A <amith.a@oss.qualcomm.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 80 +++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index 4d9f5f87e814..2a61997e8312 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -36,6 +36,9 @@
 #include <linux/virtio.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
+#include <linux/uaccess.h>
+#include <linux/kstrtox.h>
+#include <linux/string.h>
 #include "mac80211_hwsim.h"
 
 #define WARN_QUEUE 100
@@ -1164,6 +1167,80 @@ static int hwsim_write_simulate_radar(void *dat, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(hwsim_simulate_radar, NULL,
 			 hwsim_write_simulate_radar, "%llu\n");
 
+struct hwsim_chanctx_iter_arg {
+	struct ieee80211_chanctx_conf **out;
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
+		*arg->out = conf;
+}
+
+static ssize_t hwsim_simulate_incumbent_signal_write(struct file *file,
+						     const char __user *ubuf,
+						     size_t len, loff_t *ppos)
+{
+	struct mac80211_hwsim_data *data = file->private_data;
+	struct ieee80211_chanctx_conf *chanctx_conf = NULL;
+	struct hwsim_chanctx_iter_arg arg;
+	u32 freq_mhz, bitmap;
+	char *sptr, *token;
+	char buf[64];
+
+	if (!len || len >= sizeof(buf))
+		return -EINVAL;
+
+	if (copy_from_user(buf, ubuf, len))
+		return -EFAULT;
+	buf[len] = '\0';
+
+	strim(buf);
+	sptr = buf;
+	token = strsep(&sptr, " \t");
+	if (!token)
+		return -EINVAL;
+	if (kstrtou32(token, 0, &freq_mhz))
+		return -EINVAL;
+
+	token = strsep(&sptr, " \t");
+	if (!token)
+		return -EINVAL;
+	if (kstrtou32(token, 0, &bitmap))
+		return -EINVAL;
+
+	if (!freq_mhz)
+		return -EINVAL;
+
+	arg.out = &chanctx_conf;
+	arg.freq_mhz = freq_mhz;
+	ieee80211_iter_chan_contexts_atomic(data->hw,
+					    hwsim_6ghz_chanctx_iter,
+					    &arg);
+
+	if (!chanctx_conf)
+		return -EINVAL;
+
+	cfg80211_incumbent_signal_notify(data->hw->wiphy,
+					 &chanctx_conf->def,
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
@@ -5832,6 +5909,9 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 		debugfs_create_file("dfs_simulate_radar", 0222,
 				    data->debugfs,
 				    data, &hwsim_simulate_radar);
+	debugfs_create_file("simulate_incumbent_signal_interference", 0200,
+			    data->debugfs,
+			    data, &hwsim_simulate_incumbent_signal_fops);
 
 	if (param->pmsr_capa) {
 		data->pmsr_capa = *param->pmsr_capa;
-- 
2.34.1


