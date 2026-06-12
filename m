Return-Path: <linux-wireless+bounces-37711-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id u3C0Niy7K2oXDgQAu9opvQ
	(envelope-from <linux-wireless+bounces-37711-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDBF6777A5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 09:54:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mediatek.com header.s=dk header.b=XTo77VXZ;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37711-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37711-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=mediatek.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B83A33014866
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2026 07:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14A7301719;
	Fri, 12 Jun 2026 07:53:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69295397329
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2026 07:53:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250804; cv=none; b=DKpNzF/5SgnYDPfxqflkn1ifqELAiFlmLiJwWoskMEJ6DU4u6gyaR4mcnAolzuhJNysHiq+e8ibFsRFhsZsZ90PkWuMtjrMEw5sJqv7MnYxqSW4yZuYu11pQUwWFdPDyPU+HoHy0vepvaht/OUjmxLAAxViFznG8wCpNcrfHb34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250804; c=relaxed/simple;
	bh=ya2cn2gNP3LfVhkXkS+0sU0D3jJsXdX3YnEwnThc5qU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWQiaYWeYp4wmYrfeaTCX/wxrhmWeFqfAddkmdf6JaEW7RsopRxh+BbX38Q0kjBNdD5UTR313dYdmfgBsfmxrRsZn+aL4C148PZZegdaFEkCzUETi/0Xq9T/PMhVkDNqi4wmmD+pHqY14xRYzcPeiwabS9ilB2PBHY2PDkY83z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XTo77VXZ; arc=none smtp.client-ip=210.61.82.184
X-UUID: c644505e663311f18dc8c9802ae25ab1-20260612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=atYc+1FSH+0IX07sudMZK0pVFont4LcfKYYkTcVMLqo=;
	b=XTo77VXZ7O/qKs2mSwXt/l52i5+NidnvKg2r6mOV6ycx2l+m6jjJh/xYyXQjwAjkJtV//ZwHEPUNq+/R+8xVqJbSNqdqMk6efjWoEtTHWNGaNYFXhRUxoJC3RJZQ9nwPFZiKO3p1+JmLvTnh6dHejsCngohbQdDjhYYCRv9wb4s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15,REQID:a8b8c2da-8227-445d-93cc-d2dd99c4bcc3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e276073,CLOUDID:f3516397-22d1-4176-b420-d0d82ac3f01a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|836|865|888|898,TC:-5,
	Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c644505e663311f18dc8c9802ae25ab1-20260612
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <jb.tsai@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 163759795; Fri, 12 Jun 2026 15:53:18 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 12 Jun 2026 15:53:16 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 12 Jun 2026 15:53:16 +0800
From: JB Tsai <jb.tsai@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
	<Deren.Wu@mediatek.com>, <Sean.Wang@mediatek.com>, <Quan.Zhou@mediatek.com>,
	<Ryder.Lee@mediatek.com>, <Leon.Yen@mediatek.com>,
	<litien.chang@mediatek.com>, <emery.hsin@mediatek.com>,
	<jb.tsai@mediatek.com>, FC Wei <fc.wei@mediatek.com>, Xiong
	<xiong.huang@mediatek.com>
Subject: [PATCH 13/20] wifi: mt76: mt7925: add MT7928 FWDL support
Date: Fri, 12 Jun 2026 15:53:11 +0800
Message-ID: <20260612075313.2578154-3-jb.tsai@mediatek.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260612075313.2578154-1-jb.tsai@mediatek.com>
References: <20260612075313.2578154-1-jb.tsai@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mediatek.com,quarantine];
	R_DKIM_ALLOW(-0.20)[mediatek.com:s=dk];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-37711-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:nbd@nbd.name,m:lorenzo@kernel.org,m:linux-wireless@vger.kernel.org,m:linux-mediatek@lists.infradead.org,m:Deren.Wu@mediatek.com,m:Sean.Wang@mediatek.com,m:Quan.Zhou@mediatek.com,m:Ryder.Lee@mediatek.com,m:Leon.Yen@mediatek.com,m:litien.chang@mediatek.com,m:emery.hsin@mediatek.com,m:jb.tsai@mediatek.com,m:fc.wei@mediatek.com,m:xiong.huang@mediatek.com,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jb.tsai@mediatek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mediatek.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mediatek.com:dkim,mediatek.com:email,mediatek.com:mid,mediatek.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDDBF6777A5

From: Emery Hsin <emery.hsin@mediatek.com>

Add CBMCU and PHY RAM firmware download flow for MT7928. The CBMCU
firmware is loaded in sections before the main WM firmware. Register
MT7928 firmware file names and is_mt7928() chip check.

Signed-off-by: FC Wei <fc.wei@mediatek.com>
Signed-off-by: Xiong <xiong.huang@mediatek.com>
Signed-off-by: Emery Hsin <emery.hsin@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt76_connac.h  |   7 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 251 +++++++++++++++++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  40 +++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   |  15 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  29 ++
 .../net/wireless/mediatek/mt76/mt792x_core.c  |  15 ++
 6 files changed, 353 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 2aa6078993e9..e21c393bb26d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -174,7 +174,7 @@ extern const struct wiphy_wowlan_support mt76_connac_wowlan_support;
 
 static inline bool is_connac3(struct mt76_dev *dev)
 {
-	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927;
+	return mt76_chip(dev) == 0x7925 || mt76_chip(dev) == 0x7927 || mt76_chip(dev) == 0x7928;
 }
 
 static inline bool is_mt7925(struct mt76_dev *dev)
@@ -187,6 +187,11 @@ static inline bool is_mt7927(struct mt76_dev *dev)
 	return mt76_chip(dev) == 0x7927;
 }
 
+static inline bool is_mt7928(struct mt76_dev *dev)
+{
+	return mt76_chip(dev) == 0x7928;
+}
+
 static inline bool is_320mhz_supported(struct mt76_dev *dev)
 {
 	return mt76_chip(dev) == 0x7927;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 6596c9e198f4..488fe5ef3fbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -67,7 +67,8 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 
 	if ((!is_connac_v1(dev) && addr == MCU_PATCH_ADDRESS) ||
 	    (is_connac2(dev) && addr == 0x900000) ||
-	    (is_connac3(dev) && (addr == 0x900000 || addr == 0xe0002800)) ||
+	    ((is_mt7925(dev) || is_mt7927(dev)) && (addr == 0x900000 || addr == 0xe0002800)) ||
+	    (is_mt7928(dev) && (addr == 0x900000 || addr == 0xe0002000)) ||
 	    (is_mt799x(dev) && addr == 0x900000))
 		cmd = MCU_CMD(PATCH_START_REQ);
 	else
@@ -77,6 +78,48 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_init_download);
 
+int mt76_connac_cb_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get)
+{
+	u8 op = get ? PATCH_SEM_GET : PATCH_SEM_RELEASE;
+	struct {
+		u8 op;
+		u8 reserved[3];
+	} req = {
+		.op = op,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(CB_PATCH_SEM_CONTROL),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_cb_mcu_patch_sem_ctrl);
+
+int mt76_connac_cb_mcu_start_patch(struct mt76_dev *dev)
+{
+	struct {
+		__le32 reserved;
+	} req = {
+		.reserved = 0,
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(CB_PATCH_FINISH_REQ),
+				 &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_cb_mcu_start_patch);
+
+int mt76_connac_cb_mcu_init_download(struct mt76_dev *dev, u32 len)
+{
+	struct {
+		__le32 addr;
+		__le32 len;
+	} req = {
+		.addr = 0, /* addr is meaningless for cbmcu fwdl */
+		.len = cpu_to_le32(len),
+	};
+
+	return mt76_mcu_send_msg(dev, MCU_CMD(CB_PATCH_START_REQ), &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_cb_mcu_init_download);
+
 int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 {
 	int len, i, n_max_channels, n_2ch = 0, n_5ch = 0, n_6ch = 0;
@@ -3042,6 +3085,57 @@ mt76_connac_mcu_send_ram_firmware(struct mt76_dev *dev,
 	return mt76_connac_mcu_start_firmware(dev, override, option);
 }
 
+static int
+mt76_connac_mcu_send_phy_ram_firmware(struct mt76_dev *dev,
+				      const struct mt76_connac2_fw_trailer *hdr,
+				      const u8 *data)
+{
+	int i, offset = 0, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	u32 override = 0, option = 0;
+
+	for (i = 0; i < hdr->n_region; i++) {
+		const struct mt76_connac2_fw_region *region;
+		u32 len, addr, mode;
+		int err;
+
+		region = (const void *)((const u8 *)hdr -
+					(hdr->n_region - i) * sizeof(*region));
+		mode = mt76_connac_mcu_gen_dl_mode(dev, region->feature_set,
+						   true);
+		len = le32_to_cpu(region->len);
+		addr = le32_to_cpu(region->addr);
+
+		if (region->feature_set & FW_FEATURE_NON_DL)
+			goto next;
+
+		if (region->feature_set & FW_FEATURE_OVERRIDE_ADDR)
+			override = addr;
+
+		err = mt76_connac_mcu_init_download(dev, addr, len, mode);
+		if (err) {
+			dev_err(dev->dev,
+				"The request to dowload PHY firmware failed.\n");
+			return err;
+		}
+
+		err = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       data + offset, len, max_len);
+		if (err) {
+			dev_err(dev->dev, "Failed to send PHY firmware.\n");
+			return err;
+		}
+
+next:
+		offset += len;
+	}
+
+	if (override)
+		option |= FW_START_OVERRIDE;
+	option |= FW_START_WORKING_PDA_DSP;
+
+	return mt76_connac_mcu_start_firmware(dev, override, option);
+}
+
 int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 			  const char *fw_wa)
 {
@@ -3109,6 +3203,39 @@ int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_load_ram);
 
+int mt76_connac3_load_phy_ram(struct mt76_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac2_fw_trailer *hdr;
+	const struct firmware *fw;
+	int ret;
+
+	ret = request_firmware(&fw, fw_name, dev->dev);
+	if (ret)
+		return ret;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid PHY firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)(fw->data + fw->size - sizeof(*hdr));
+	dev_info(dev->dev, "PHY Firmware Version: %.10s, Build Time: %.15s\n",
+		 hdr->fw_ver, hdr->build_date);
+
+	ret = mt76_connac_mcu_send_phy_ram_firmware(dev, hdr, fw->data);
+	if (ret) {
+		dev_err(dev->dev, "Failed to start PHY firmware\n");
+		goto out;
+	}
+
+out:
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_load_phy_ram);
+
 static u32 mt76_connac2_get_data_mode(struct mt76_dev *dev, u32 info)
 {
 	u32 mode = DL_MODE_NEED_RSP;
@@ -3222,6 +3349,128 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 }
 EXPORT_SYMBOL_GPL(mt76_connac2_load_patch);
 
+int mt76_connac3_load_cb_patch(struct mt76_dev *dev, const char *fw_name)
+{
+	const struct mt76_connac3_multi_header_v2_sec_raw_format *sect = NULL;
+	const struct mt76_connac3_multi_header_v2_raw_format *hdr = NULL;
+	int i, ret, sem, max_len = mt76_is_sdio(dev) ? 2048 : 4096;
+	const struct firmware *fw = NULL;
+	const u8 *dl;
+	u32 len;
+
+	sem = mt76_connac_cb_mcu_patch_sem_ctrl(dev, true);
+	switch (sem) {
+	case CB_PATCH_IS_DL:
+		return 0;
+	case CB_PATCH_GET_SEM_NEED_PATCH:
+		break;
+	default:
+		dev_err(dev->dev, "Failed to get cb patch semaphore %u\n", sem);
+		return -EAGAIN;
+	}
+
+	ret = request_firmware(&fw, fw_name, dev->dev);
+	if (ret)
+		goto out;
+
+	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
+		dev_err(dev->dev, "Invalid firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	hdr = (const void *)fw->data;
+	dev_info(dev->dev, "HW/SW Version: 0x%x, Pack Time: %.21s\n",
+		 le32_to_cpu(hdr->patch_ver), hdr->pack_time);
+
+	if (le32_to_cpu(hdr->sec_num) < 2) {
+		dev_err(dev->dev, "Invalid section numbers %u\n",
+			le32_to_cpu(hdr->sec_num));
+		ret = -EINVAL;
+		goto out;
+	}
+
+	sect = &hdr->sects[0];
+	/* check the fw bin basic info */
+	if (((le32_to_cpu(sect->type) & SEC_TYPE_SUBSYS_MASK)
+	    != SEC_TYPE_SUBSYS_CBMCU) ||
+	    ((le32_to_cpu(sect->type) & SEC_TYPE_SUBSYS_SEC_MASK)
+	    != SEC_TYPE_SUBSYS_SEC_IMG_SIGN)) {
+		dev_err(dev->dev, "Invalid CBMCU firmware\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* download global desc + sect map + cert section */
+	len = sizeof(struct mt76_connac3_multi_header_v2_raw_format) -
+	      offsetof(struct mt76_connac3_multi_header_v2_raw_format,
+		       global_desc_head) +
+	      sizeof(struct mt76_connac3_multi_header_v2_sec_raw_format) *
+	      le32_to_cpu(hdr->sec_num) +
+	      le32_to_cpu(hdr->sects[0].size);
+	dl = &hdr->global_desc_head[0];
+
+	ret = mt76_connac_cb_mcu_init_download(dev, len);
+	if (ret) {
+		dev_err(dev->dev, "Download cb cert section request failed\n");
+		goto out;
+	}
+
+	ret = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+				       dl, len, max_len);
+	if (ret) {
+		dev_err(dev->dev, "Failed to send cb patch cert section\n");
+		goto out;
+	}
+
+	ret = mt76_connac_cb_mcu_start_patch(dev);
+	if (ret) {
+		dev_err(dev->dev, "CBMCU cert check fail\n");
+		goto out;
+	}
+
+	/* download cbmcu idlm */
+	for (i = 1; i < le32_to_cpu(hdr->sec_num); i++) {
+		dl = (uint8_t *)hdr + le32_to_cpu(hdr->sects[i].offset);
+		len = le32_to_cpu(hdr->sects[i].size);
+
+		ret = mt76_connac_cb_mcu_init_download(dev, len);
+		if (ret) {
+			dev_err(dev->dev,
+				"Download cb section %u request failed\n", i);
+			goto out;
+		}
+
+		ret = __mt76_mcu_send_firmware(dev, MCU_CMD(FW_SCATTER),
+					       dl, len, max_len);
+		if (ret) {
+			dev_err(dev->dev,
+				"Failed to send cb patch section %u\n", i);
+			goto out;
+		}
+	}
+
+	ret = mt76_connac_cb_mcu_start_patch(dev);
+	if (ret)
+		dev_err(dev->dev, "Failed to start cb patch\n");
+
+out:
+	sem = mt76_connac_cb_mcu_patch_sem_ctrl(dev, false);
+	switch (sem) {
+	case CB_PATCH_REL_SEM_SUCCESS:
+		break;
+	default:
+		ret = -EAGAIN;
+		dev_err(dev->dev, "Failed to release cb patch semaphore\n");
+		break;
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_connac3_load_cb_patch);
+
 int mt76_connac2_mcu_fill_message(struct mt76_dev *dev, struct sk_buff *skb,
 				  int cmd, int *wait_seq)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 6d0429f40b0f..5674090961d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -35,6 +35,12 @@
 #define PATCH_SEC_ENC_SCRAMBLE_INFO_MASK	GENMASK(15, 0)
 #define PATCH_SEC_ENC_AES_KEY_MASK		GENMASK(7, 0)
 
+#define SEC_TYPE_SUBSYS_MASK			GENMASK(23, 16)
+#define SEC_TYPE_SUBSYS_CBMCU			BIT(16)
+
+#define SEC_TYPE_SUBSYS_SEC_MASK		GENMASK(15, 0)
+#define SEC_TYPE_SUBSYS_SEC_IMG_SIGN		0x05
+
 enum {
 	FW_TYPE_DEFAULT = 0,
 	FW_TYPE_CLC = 2,
@@ -193,6 +199,25 @@ struct mt76_connac2_fw_region {
 	u8 rsv1[14];
 } __packed;
 
+struct mt76_connac3_multi_header_v2_sec_raw_format {
+	__le32 type;
+	__le32 offset;
+	__le32 size;
+	u8 spec[52];
+} __packed;
+
+struct mt76_connac3_multi_header_v2_raw_format {
+	u8 pack_time[20];
+	u8 chip_id_eco_ver[8];
+	__le32 patch_ver;
+	u8 global_desc_head[4];
+	__le32 global_subsys;
+	u8 rsv2[4];
+	__le32 sec_num;
+	u8 rsv3[48];
+	struct mt76_connac3_multi_header_v2_sec_raw_format sects[];
+} __packed;
+
 struct tlv {
 	__le16 tag;
 	__le16 len;
@@ -1104,6 +1129,13 @@ enum {
 	PATCH_REL_SEM_SUCCESS
 };
 
+enum {
+	CB_PATCH_GET_SEM_NEED_PATCH,
+	CB_PATCH_IS_DL,
+	CB_PATCH_NO_SEM_NEED_PATCH,
+	CB_PATCH_REL_SEM_SUCCESS
+};
+
 enum {
 	FW_STATE_INITIAL,
 	FW_STATE_FW_DOWNLOAD,
@@ -1332,6 +1364,9 @@ enum {
 	MCU_CMD_PATCH_START_REQ = 0x05,
 	MCU_CMD_PATCH_FINISH_REQ = 0x07,
 	MCU_CMD_PATCH_SEM_CONTROL = 0x10,
+	MCU_CMD_CB_PATCH_SEM_CONTROL = 0x30,
+	MCU_CMD_CB_PATCH_START_REQ = 0x31,
+	MCU_CMD_CB_PATCH_FINISH_REQ = 0x32,
 	MCU_CMD_WA_PARAM = 0xc4,
 	MCU_CMD_EXT_CID = 0xed,
 	MCU_CMD_FW_SCATTER = 0xee,
@@ -2018,6 +2053,9 @@ int mt76_connac_mcu_init_download(struct mt76_dev *dev, u32 addr, u32 len,
 				  u32 mode);
 int mt76_connac_mcu_start_patch(struct mt76_dev *dev);
 int mt76_connac_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
+int mt76_connac_cb_mcu_init_download(struct mt76_dev *dev, u32 len);
+int mt76_connac_cb_mcu_start_patch(struct mt76_dev *dev);
+int mt76_connac_cb_mcu_patch_sem_ctrl(struct mt76_dev *dev, bool get);
 int mt76_connac_mcu_start_firmware(struct mt76_dev *dev, u32 addr, u32 option);
 
 void mt76_connac_mcu_build_rnr_scan_param(struct mt76_dev *mdev,
@@ -2101,7 +2139,9 @@ int mt76_connac_mcu_rdd_cmd(struct mt76_dev *dev, int cmd, u8 index,
 int mt76_connac_mcu_sta_wed_update(struct mt76_dev *dev, struct sk_buff *skb);
 int mt76_connac2_load_ram(struct mt76_dev *dev, const char *fw_wm,
 			  const char *fw_wa);
+int mt76_connac3_load_phy_ram(struct mt76_dev *dev, const char *fw_name);
 int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name);
+int mt76_connac3_load_cb_patch(struct mt76_dev *dev, const char *fw_name);
 int mt76_connac2_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 				  int cmd, int *wait_seq);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index e94fa544ff20..0b4ca5cf5734 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -26,13 +26,24 @@ int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	}
 
 	rxd = (struct mt7925_mcu_rxd *)skb->data;
-	if (seq != rxd->seq)
-		return -EAGAIN;
+	if (seq != rxd->seq) {
+		if (!is_mt7928(mdev))
+			return -EAGAIN;
+		else if (is_mt7928(mdev) &&
+			 cmd != MCU_CMD(CB_PATCH_SEM_CONTROL) &&
+			 cmd != MCU_CMD(CB_PATCH_FINISH_REQ))
+			return -EAGAIN;
+	}
 
 	if (cmd == MCU_CMD(PATCH_SEM_CONTROL) ||
 	    cmd == MCU_CMD(PATCH_FINISH_REQ)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
+	} else if (is_mt7928(mdev) &&
+		   (cmd == MCU_CMD(CB_PATCH_SEM_CONTROL) ||
+		   cmd == MCU_CMD(CB_PATCH_FINISH_REQ))) {
+		skb_pull(skb, sizeof(*rxd) - 4);
+		ret = *skb->data;
 	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 7d014de030c4..8c7ecd3ce126 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -47,6 +47,7 @@
 #define MT7922_FIRMWARE_WM	"mediatek/WIFI_RAM_CODE_MT7922_1.bin"
 #define MT7925_FIRMWARE_WM	"mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin"
 #define MT7927_FIRMWARE_WM	"mediatek/mt7927/WIFI_RAM_CODE_MT6639_2_1.bin"
+#define MT7928_FIRMWARE_WM	"mediatek/mt7928/WIFI_RAM_CODE_MT7935_1_1.bin"
 
 #define MT7902_ROM_PATCH	"mediatek/WIFI_MT7902_patch_mcu_1_1_hdr.bin"
 #define MT7920_ROM_PATCH	"mediatek/WIFI_MT7961_patch_mcu_1a_2_hdr.bin"
@@ -54,6 +55,10 @@
 #define MT7922_ROM_PATCH	"mediatek/WIFI_MT7922_patch_mcu_1_1_hdr.bin"
 #define MT7925_ROM_PATCH	"mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin"
 #define MT7927_ROM_PATCH	"mediatek/mt7927/WIFI_MT6639_PATCH_MCU_2_1_hdr.bin"
+#define MT7928_ROM_PATCH	"mediatek/mt7928/WIFI_MT7935_PATCH_MCU_1_1_hdr.bin"
+
+#define MT7928_CB_ROM_PATCH	"mediatek/mt7928/CBMCU_CODE_MT7935_1_1.bin"
+#define MT7928_PHY_RAM		"mediatek/mt7928/WIFI_MT7935_PHY_RAM_CODE_1_1.bin"
 
 #define MT792x_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
 #define MT792x_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
@@ -494,6 +499,8 @@ static inline char *mt792x_ram_name(struct mt792x_dev *dev)
 		return MT7925_FIRMWARE_WM;
 	case 0x7927:
 		return MT7927_FIRMWARE_WM;
+	case 0x7928:
+		return MT7928_FIRMWARE_WM;
 	default:
 		return MT7921_FIRMWARE_WM;
 	}
@@ -512,11 +519,33 @@ static inline char *mt792x_patch_name(struct mt792x_dev *dev)
 		return MT7925_ROM_PATCH;
 	case 0x7927:
 		return MT7927_ROM_PATCH;
+	case 0x7928:
+		return MT7928_ROM_PATCH;
 	default:
 		return MT7921_ROM_PATCH;
 	}
 }
 
+static inline char *mt792x_cb_patch_name(struct mt792x_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7928:
+		return MT7928_CB_ROM_PATCH;
+	default:
+		return NULL;
+	}
+}
+
+static inline char *mt792x_phy_ram_name(struct mt792x_dev *dev)
+{
+	switch (mt76_chip(&dev->mt76)) {
+	case 0x7928:
+		return MT7928_PHY_RAM;
+	default:
+		return NULL;
+	}
+}
+
 int mt792x_load_firmware(struct mt792x_dev *dev);
 
 /* usb */
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
index b50825eccdaf..9bd679b7e889 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
@@ -985,6 +985,15 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 		dev_warn(dev->mt76.dev,
 			 "MCU is not ready for firmware download\n");
 
+	if (is_mt7928(&dev->mt76)) {
+		dev_info(dev->mt76.dev, "Loading CB firmware patch: %s\n",
+			 mt792x_cb_patch_name(dev));
+		ret = mt76_connac3_load_cb_patch(&dev->mt76, mt792x_cb_patch_name(dev));
+		if (ret)
+			return ret;
+	}
+
+	dev_info(dev->mt76.dev, "Loading firmware patch: %s\n", mt792x_patch_name(dev));
 	ret = mt76_connac2_load_patch(&dev->mt76, mt792x_patch_name(dev));
 	if (ret)
 		return ret;
@@ -996,6 +1005,12 @@ int mt792x_load_firmware(struct mt792x_dev *dev)
 			ret = __mt792x_mcu_drv_pmctrl(dev);
 	}
 
+	if (is_mt7928(&dev->mt76)) {
+		ret = mt76_connac3_load_phy_ram(&dev->mt76, mt792x_phy_ram_name(dev));
+		if (ret)
+			return ret;
+	}
+
 	ret = mt76_connac2_load_ram(&dev->mt76, mt792x_ram_name(dev), NULL);
 	if (ret)
 		return ret;
-- 
2.45.2


