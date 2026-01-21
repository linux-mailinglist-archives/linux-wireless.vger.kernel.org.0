Return-Path: <linux-wireless+bounces-31043-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHuUDiancGlyYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31043-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:15:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C40550A7
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C09DB72B7FF
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 09:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028DB48095B;
	Wed, 21 Jan 2026 09:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FcGcdvdR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TONm/zr0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40069480952
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989069; cv=none; b=iYU11FdqmxeKnr3BOlcmu0zNFoNj6QfgIX4phPOdwYaJ4advGnNj65hjo0gj/utAojYfiJlnOp0Js0sbsdENA2oVhMC8DXBULKTPEFelCT61FdG1hkvip8qFP7tkzD+LGEhJqA4Hpu+4eupkpf6KgoLIW4Gx0S3fpAtxue6RMFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989069; c=relaxed/simple;
	bh=l4MMsyTuJZ/YHpNJCzs05k83aF0SBRxMCuDzdpmDjgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pqDZjGCPBqM96axd/ZYmKagZ2V02JbU+iXwo53C0XoD26JrNxSK8u8je3NNYq1dr4F3LaJJi0fskfDdXLDZQVAqAMt3J+zMWCOCoESByfMJ6m3Yex72tlXM5gXkcs4xMFO4JrhGhRcTYKBsVDiughrbbQso2rwRaHJDwxH2nwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FcGcdvdR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TONm/zr0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L5gLpd1036448
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=GiQ/XgYHT/W
	TkJNrYSdtUPJtPfB1bDJIXOaoB92xpxs=; b=FcGcdvdRaYlCBKan5SOhYwBOrQ3
	IsIyfqaapy+MPouZkjrCwYHX6lqjPSM4j/ZS35IvF6dXAJwMffxzgXPAGChQ5e2a
	1SEdk09nA6ktDj9MFCrdeJUFbFG838Z7vpGiaDJHKUSAPwiYq+3Jk4swpjpCQv44
	gCKpPeWhTdztA42VDDjMEXfihe2HeINBjPIouxJVs9slIdTj93fUfmS7CY5Te780
	4jEG0pLnXaja74oOmIALqrnBR9nVyss+F9vPaCHknXwZ/by1obeFgh4O/S0AJ1ZQ
	kYcxSf6DmDr29DlAttjP0S7zcUwwbZsPut2wUV8grBOfO1fQOvHIVR3i0iA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bth55jrj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-29f1f79d6afso69572165ad.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768989067; x=1769593867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiQ/XgYHT/WTkJNrYSdtUPJtPfB1bDJIXOaoB92xpxs=;
        b=TONm/zr0ndDM+XWpLZSoKEkbCaEpAB5DW8WiZKcV+LN80V/Pg/G7gO+qYzTaLWiU72
         3GSXYK1DgFzctXzlUY8wh+msVAoF203cgqude1ErdNzknH04WPw5LgMG+0O2D87GQCz0
         TC3MPE+GnXYFl5XugCMNocmdDpGLsd9b48T/0ErcZLyqe/RXD911vVpLXTthMlL/OvPO
         KHLdyyiU73vwkKzBo2w9kRnFW3DeYiA16zSmggrG9iQuav2n/CiIXAU3nD6E5jj2D0KF
         MYKI3zl5AQgVoMMXA8lxoHf/+fVXuT1qdSVaPQBPUfl7QpP7Ef9x5QZ6dfSYTcG8XA8x
         hKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989067; x=1769593867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GiQ/XgYHT/WTkJNrYSdtUPJtPfB1bDJIXOaoB92xpxs=;
        b=vJM+Xw20PRlpiysKvp7LHDKqxgx7zsgyx+hCVstFoUVJvb1IjlnopbHGbV/EV3ugko
         d23wsAGZbXbKOHHj812O5WgQoKghbWED2rqu/HpNrEg8PHsR/As0QNmUq97O98HgjnlC
         S+brjIiP4pMW+9cUvSaUJbs7GVt6pNZLlOYFRna/3i91wuuv6afj8xFj/SU4eSeCnRMt
         dPVFbjzayjIFvt3epJ4KB2JaesSEx1m8kn7GHNI82zZoo8gLOzWOjOOpb2io6IKbJdiY
         xWTQj1P6dpYCOiTGk44p3UcwbDEYY4onQS7maA70v0FYGRrG1iACFP3v18bdhb1QY5An
         tjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCF6S1zjzFgenQ20fBeIR0UP2BYoQgF1abzOqNRwTeOTInvGQmjd0iuA+sZNcsEhPZTgSSgw8/egQTe/Hhfg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3s0aSrxmlEQIWYPgaFg7OcynD6qzcknNGMouFfgzaZh3d9jBI
	vhrtWqH/eGkDf6Veo8+B+++O9PxpQktCadNiLqnl5XWpSIoZYtaKDnAM6s9DqWA/uCA1/3fbtra
	rknaIAoITOc6TW3YL8cJw2omGsvjDdwRNt9vNumLNwFomqWF/BowxU29OkNm/QeODRqKQJw==
X-Gm-Gg: AZuq6aKGRcrRjUlZXm/YTfr219cVpX88T/fmIzOIC0r5pqWVCGHn4KRqUJ5ikKs8yvl
	3l1yXMbKyl+yVS2lBF+djbU0JkQNM5ESohcsW10Tqb9FhqzgWtcnKKbjrFQ7n9yiNeODkb1uxDn
	yW1NiCD2LMxvpy2j/t+xS0QiC/l9bAwaLh6ugSOMrzfqdSTv5xGrXn4Rv/x67Nl7eeWNgEgaLZ9
	JPTADsWdNCvGrrKUJOe0Qo8whaFdMbimJYkGQzlYu12ivSO0e3CNBa0ISBG1c5UbClXIooRCtNq
	HuK6EdX77MpbUS9Vdd1qq0yjx/wGof62/f5QwJGRDk6SZ0QCMSMhSt5NHTctIKlEDm6kKrSRdti
	PyNtrfEvfEuqJRbVP8alsi3AesePDTd+Qznr//zN58YuHCWz1FeyHEm7UI954UaM58QCk
X-Received: by 2002:a05:6a21:9994:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-38e00bba20dmr17504850637.12.1768989066727;
        Wed, 21 Jan 2026 01:51:06 -0800 (PST)
X-Received: by 2002:a05:6a21:9994:b0:38d:fa67:e87f with SMTP id adf61e73a8af0-38e00bba20dmr17504826637.12.1768989066234;
        Wed, 21 Jan 2026 01:51:06 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af047sm16997295a91.10.2026.01.21.01.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:51:05 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzk@kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v4 ath-current 1/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Wed, 21 Jan 2026 17:50:54 +0800
Message-Id: <20260121095055.3683957-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
References: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lpR9SJcLtUyo9WWk12NOOMC-3bFt_nzx
X-Authority-Analysis: v=2.4 cv=Oa6VzxTY c=1 sm=1 tr=0 ts=6970a18b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JMaiino2ulENCBURCGwA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MiBTYWx0ZWRfX9DEFTMWrtD3g
 dlY4oOuA7WWf8qhWyiZtyK13xPpxt2zlc75kILxGxLrF4lHVi7lUc4bOaLFx+EdAT5C8WESHxrt
 C5YfFvgUBoeSNDjgd3FiKH3A7CT+OYUAR1SEKxiBTghFhNPlCXEsVfNd7rPXn1Kowvkiy8UHVim
 6tt3kCS/4GpPTYqFpsHD3cHyYQw/FDUCvVKfxa7Wy92ZSoENwnWWs/igFDgZ7G5V3wASitRCVjJ
 5HGR9akDwxiDatN2VeFiU8MPbLDzKYcRSZwy3aGz4FzK32HfkIuACJdBCdoYSPAZ1sbSllSGM67
 54mYDeSkR21QDUb423KjtO4pr+7V5h2cbAIXf43V/b/9dGutNnIgfEj9Rb63q+nBOM9E+jFdlEa
 thqsqjWlYEMibMciQMAwRCWojsCXmi4DXcciu3naOKfofT8VMjH6jgN7SK+bj0oXWPp4XmY9eIW
 8zxmASkTFHewGyMcFXQ==
X-Proofpoint-GUID: lpR9SJcLtUyo9WWk12NOOMC-3bFt_nzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210082
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31043-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 96C40550A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

For M.2 WLAN chips, there is no suitable DTS node to specify the
firmware-name property. In addition, assigning firmware for the
M.2 PCIe interface causes chips that do not use usecase specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names. Currently, only WCN6855
HW2.1 requires this.

However, support for the firmware-name property is retained to keep
the ABI backwards compatible.

For details on usecase specific firmware, see:
https://lore.kernel.org/all/20250522013444.1301330-3-miaoqing.pan@oss.qualcomm.com/.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-04685-QCAHSPSWPL_V1_V2_SILICONZ_IOE-1

Fixes: edbbc647c4f3 ("wifi: ath11k: support usercase-specific firmware overrides")
Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/core.c | 27 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h |  4 ++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index de84906d1b27..3f6f4db5b7ee 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -1044,6 +1044,33 @@ static const struct dmi_system_id ath11k_pm_quirk_table[] = {
 	{}
 };
 
+static const struct __ath11k_core_usecase_firmware_table {
+	u32 hw_rev;
+	const char *compatible;
+	const char *firmware_name;
+} ath11k_core_usecase_firmware_table[] = {
+	{ ATH11K_HW_WCN6855_HW21, "qcom,lemans-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,monaco-evk", "nfa765"},
+	{ ATH11K_HW_WCN6855_HW21, "qcom,hamoa-iot-evk", "nfa765"},
+	{ /* Sentinel */ }
+};
+
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab)
+{
+	const struct __ath11k_core_usecase_firmware_table *entry = NULL;
+
+	entry = ath11k_core_usecase_firmware_table;
+	while (entry->compatible) {
+		if (ab->hw_rev == entry->hw_rev &&
+		    of_machine_is_compatible(entry->compatible))
+			return entry->firmware_name;
+		entry++;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(ath11k_core_get_usecase_firmware);
+
 void ath11k_fw_stats_pdevs_free(struct list_head *head)
 {
 	struct ath11k_fw_stats_pdev *i, *tmp;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 3f41e6569a78..a0d725923ef2 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -1292,6 +1292,7 @@ bool ath11k_core_coldboot_cal_support(struct ath11k_base *ab);
 
 const struct firmware *ath11k_core_firmware_request(struct ath11k_base *ab,
 						    const char *filename);
+const char *ath11k_core_get_usecase_firmware(struct ath11k_base *ab);
 
 static inline const char *ath11k_scan_state_str(enum ath11k_scan_state state)
 {
@@ -1346,6 +1347,9 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 
 	of_property_read_string(ab->dev->of_node, "firmware-name", &fw_name);
 
+	if (!fw_name)
+		fw_name = ath11k_core_get_usecase_firmware(ab);
+
 	if (fw_name && strncmp(filename, "board", 5))
 		snprintf(buf, buf_len, "%s/%s/%s/%s", ATH11K_FW_DIR,
 			 ab->hw_params.fw.dir, fw_name, filename);
-- 
2.34.1


