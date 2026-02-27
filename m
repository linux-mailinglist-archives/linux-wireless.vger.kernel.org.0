Return-Path: <linux-wireless+bounces-32248-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D4qMNwaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32248-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:17:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF801B2952
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B313309BB70
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7A345750;
	Fri, 27 Feb 2026 04:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="MtumvPtl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0E028D8D1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165561; cv=none; b=qjdGj0YwrDZUTC8J3p6soaxUmnv9SZ6denal+UBm2BE3QC/GtL15NkVUwrS/JnU3f/YS/1ZWKlf2nIduejbPQHZ0/iwDoXwAk+FfrGCBL44jxNgEg8OBWyvelEQxTQGattyvDs2ufyjCn1h5bUejqgK3uxUV/OAM1XDiLKWLx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165561; c=relaxed/simple;
	bh=YzA983ZZy0R7KPrA6kOfdyK+ozcjLeWMqEz91S5i93A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+YlQEa7sBLDCoxBAM7e7xLQWUIBm4XYaJJP4b7wQg5aKS8qxdHLWYP8ypRWJnZWKmVGoRiso9z4vCxPNZoO41RScWRUAJKeloiZ9dub2TipACQPLK5yWPcyCgldFfAxmzypwUniGtSiZ0WNB/9PLE3/uD9kkw3Iw8nSNJCVpWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=MtumvPtl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82728e5680cso930422b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165559; x=1772770359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPCo/AjqSVa5xgc14A1DO5+TPeaV0FKl75w3V+RiMP8=;
        b=MtumvPtlu7GAnNL68ikDJ7yLKTsmRrRsRqTXiAUQ7Fmt4kPAROvdO47ddPk7IFYA4Y
         E27seD8FVXyhuMQ4RYFi8My3uzTcZ9lTPA+sI/6WJI/8f0uyZF5TNN8nhqFXV6ew4lfh
         XC3ieZNINEC+Ar2RyU+Fa/XM5UPs90NyN8UR3B2qAvyfLN2WxKoVmahnogiJOmCofhjv
         P9VeJJVogQmH1LXzc+h2SJlvWzVE2OWbZMF5IBPq5o0a9CKB+iy81sIgt+cfppqwYoH0
         A8Ab/kJ6orAwp7xr8InjN8DqiyDYlHFzkgDe6VmDoGU8/DU+MAs+iWOeBdXFA6FeJVQq
         V4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165559; x=1772770359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPCo/AjqSVa5xgc14A1DO5+TPeaV0FKl75w3V+RiMP8=;
        b=A8A3kzPBG5x1zi+3qRAQLT9pmFiOwxLjGB224rS2YCCl0lrE3GKPBTsgwKzFFnKUk1
         UHTcLRD9vzKRuIvtpIZtbqf1dwV0mZxOx9c4MZyRQDRocmPvKQB73cR+3lAXhRPRWib3
         F6tgvVWm+zIXhQcOCxPR+c7KamW89sOVdCYHOFt1bB6+i/SbHodejUduAV5TOSZ6jMgr
         aBW39H6MOzcV/3xakBhzGMg8AsAdHxADWIlM6JnyjaNjx1a3lDQ0AGiWSwhLJSDxZhdn
         XarqucVNPkT6leGXuyxg+xNops+Qo5g7BZUZOjMmIuR1TBjdamaDU6KTTyMtOmNZTBd3
         vDVA==
X-Forwarded-Encrypted: i=1; AJvYcCX+An3jzjstIjwAVOJnSG3zjB4mXtJy3UUw/Z675lvlF8Xq2OnuLDpY0xUzeyCNgLzgO+JYJm3HfPmikczyBA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ83wxep9Ze6m5IF0jjcsBTsPr7ChxogBJ057OV7gBkA/DiDOz
	XRRT+rTM/ItVhIZ35DdnDiyYqwYZThxDeiA/BWJvcydzk+3poc6AptRKe2CAAxTI8xc=
X-Gm-Gg: ATEYQzxb6uSMME//4p0S+KXl+zo5z3M+UPI1xSuRseDrgupprq8YDZXaBMpb+RMdctF
	3vanjFwhiLCMKrTa4XJ6jnyMXdf/5eyxxAyX2Be7eMAuECDoIRbrZe1C0CQEJJN53+O93mEqz2N
	mrCHjIYpVq0cPBgv9S9mZjzU0eLE2K3s2gs3f2bu0mMd8VwbaIXOezoh+rIM+lBLLQmJGaF/8h+
	cIx1SU5KbVTYDuu4JXPHiugYn+VOw6wohHEJUu4c2l/BOcuqH9sFfaRQzaDgyjDiRVOaDckueLe
	HUf4miaw0oS6Bn++vVmWObAvxbP/6s8G7PpbxJr7BO+1Huoesb86w27F596oF++penU6rXyGbrE
	xSnz0S3tVezU5iu//c6gLqeKtXPh79bo/g1328TlQ2rEdgWWRtnssLkW81QR9FJ4WOYZgAcBzMe
	DRWlWItC0sxClgIL9euS2agdNdLWaZ8yfkB3XmGW7xI9hV/fYQ3ri6XJ/dnuKSFoUmWbuHL1Otw
	fuIZt4y8KK7hZoJexi1R/rjXIetFv2ecXZcDPMcCg==
X-Received: by 2002:a05:6a20:a103:b0:394:857c:7f41 with SMTP id adf61e73a8af0-395c39de43fmr1417776637.11.1772165558741;
        Thu, 26 Feb 2026 20:12:38 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:38 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 09/35] wifi: mm81x: add fw.c
Date: Fri, 27 Feb 2026 15:10:19 +1100
Message-ID: <20260227041108.66508-10-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32248-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 2DF801B2952
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/fw.c | 743 +++++++++++++++++++++
 1 file changed, 743 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/fw.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/fw.c b/drivers/net/wireless/morsemicro/mm81x/fw.c
new file mode 100644
index 000000000000..6d138419abce
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/fw.c
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/kernel.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/string_choices.h>
+#include <net/mac80211.h>
+#include <linux/elf.h>
+#include <linux/crc32.h>
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "bus.h"
+
+/*
+ * Maximum wait time (milliseconds) for firmware to boot (for host table
+ * pointer to be available)
+ */
+#define MAX_WAIT_FOR_HOST_TABLE_PTR_MS 1200
+
+/* Number of times to attempt flashing FW */
+#define FW_FLASH_ATTEMPT_COUNT 3
+
+static int mm81x_fw_get_header(const u8 *data, mm81x_elf_ehdr *ehdr)
+{
+	mm81x_elf_ehdr *p = (mm81x_elf_ehdr *)data;
+
+	/* Magic check */
+	if (p->e_ident[EI_MAG0] != ELFMAG0 || p->e_ident[EI_MAG1] != ELFMAG1 ||
+	    p->e_ident[EI_MAG2] != ELFMAG2 || p->e_ident[EI_MAG3] != ELFMAG3)
+		return -EINVAL;
+
+	/* elf32 and little endian */
+	if (p->e_ident[EI_DATA] != ELFDATA2LSB ||
+	    p->e_ident[EI_CLASS] != ELFCLASS32)
+		return -EINVAL;
+
+	ehdr->e_phoff = mm81x_fle32_to_cpu(p->e_phoff);
+	ehdr->e_phentsize = mm81x_fle16_to_cpu(p->e_phentsize);
+	ehdr->e_phnum = mm81x_fle16_to_cpu(p->e_phnum);
+	ehdr->e_shoff = mm81x_fle32_to_cpu(p->e_shoff);
+	ehdr->e_shentsize = mm81x_fle16_to_cpu(p->e_shentsize);
+	ehdr->e_shnum = mm81x_fle16_to_cpu(p->e_shnum);
+	ehdr->e_shstrndx = mm81x_fle16_to_cpu(p->e_shstrndx);
+	ehdr->e_entry = mm81x_fle32_to_cpu(p->e_entry);
+
+	return 0;
+}
+
+static void mm81x_fw_parse_info(struct mm81x *mm, const u8 *data, int length)
+{
+	const struct mm81x_fw_info_tlv *tlv =
+		(const struct mm81x_fw_info_tlv *)data;
+
+	while ((u8 *)tlv < (data + length)) {
+		switch (le16_to_cpu(tlv->type)) {
+		case MM81X_FW_INFO_TLV_BCF_ADDR:
+			mm->bcf_address =
+				get_unaligned_le32((__force __le32 *)tlv->val);
+			break;
+		default:
+			break;
+		}
+		tlv = (const struct mm81x_fw_info_tlv *)((u8 *)tlv +
+							 le16_to_cpu(
+								 tlv->length) +
+							 sizeof(*tlv));
+	}
+}
+
+static int mm81x_fw_get_section_header(const u8 *data, mm81x_elf_ehdr *ehdr,
+				       mm81x_elf_shdr *shdr, int i)
+{
+	mm81x_elf_shdr *p = (mm81x_elf_shdr *)(data + ehdr->e_shoff +
+					       (i * ehdr->e_shentsize));
+
+	shdr->sh_name = mm81x_fle32_to_cpu(p->sh_name);
+	shdr->sh_type = mm81x_fle32_to_cpu(p->sh_type);
+	shdr->sh_offset = mm81x_fle32_to_cpu(p->sh_offset);
+	shdr->sh_addr = mm81x_fle32_to_cpu(p->sh_addr);
+	shdr->sh_size = mm81x_fle32_to_cpu(p->sh_size);
+	shdr->sh_flags = mm81x_fle32_to_cpu(p->sh_flags);
+
+	return 0;
+}
+
+static int mm81x_fw_set_boot_addr(struct mm81x *mm, uint32_t addr)
+{
+	int status;
+
+	mm81x_dbg(mm, MM81X_DBG_FW, "Overwriting boot address to 0x%x", addr);
+	mm81x_claim_bus(mm);
+	status = mm81x_reg32_write(mm, MM81X_REG_BOOT_ADDR(mm), addr);
+	mm81x_release_bus(mm);
+	return status;
+}
+
+static int mm81x_fw_load_fw(struct mm81x *mm, const struct firmware *fw)
+{
+	int i;
+	int ret = 0;
+	mm81x_elf_ehdr ehdr;
+	mm81x_elf_phdr phdr;
+	mm81x_elf_shdr shdr;
+	mm81x_elf_shdr sh_strtab;
+	const char *sh_strs;
+
+	u8 *fw_buf = devm_kmalloc(mm->dev, ROUND_BYTES_TO_WORD(fw->size),
+				  GFP_KERNEL);
+
+	if (!fw_buf)
+		return -ENOMEM;
+
+	if (mm81x_fw_get_header(fw->data, &ehdr)) {
+		mm81x_err(mm, "Wrong file format");
+		return -EINVAL;
+	}
+
+	if (mm81x_fw_get_section_header(fw->data, &ehdr, &sh_strtab,
+					ehdr.e_shstrndx)) {
+		mm81x_err(mm, "Invalid firmware. Missing string table");
+		return -ENOENT;
+	}
+
+	sh_strs = (const char *)fw->data + sh_strtab.sh_offset;
+
+	for (i = 0; i < ehdr.e_phnum; i++) {
+		int status;
+		int address;
+
+		mm81x_elf_phdr *p = (mm81x_elf_phdr *)(fw->data + ehdr.e_phoff +
+						       i * ehdr.e_phentsize);
+
+		phdr.p_type = le32_to_cpu((__force __le32)p->p_type);
+		phdr.p_offset = le32_to_cpu((__force __le32)p->p_offset);
+		phdr.p_paddr = le32_to_cpu((__force __le32)p->p_paddr);
+		phdr.p_filesz = le32_to_cpu((__force __le32)p->p_filesz);
+		phdr.p_memsz = le32_to_cpu((__force __le32)p->p_memsz);
+
+		address = phdr.p_paddr;
+		if (address == IFLASH_BASE_ADDR || address == DFLASH_BASE_ADDR)
+			continue;
+
+		if (phdr.p_type != PT_LOAD || !phdr.p_memsz)
+			continue;
+
+		if (phdr.p_filesz && phdr.p_offset &&
+		    (phdr.p_offset + phdr.p_filesz) < fw->size) {
+			u32 padded_size = ROUND_BYTES_TO_WORD(phdr.p_filesz);
+
+			memcpy(fw_buf, fw->data + phdr.p_offset, padded_size);
+			/* Set padding to 0xff */
+			memset(fw_buf + phdr.p_filesz, 0xff,
+			       padded_size - phdr.p_filesz);
+			mm81x_claim_bus(mm);
+			status = mm81x_dm_write(mm, address, fw_buf,
+						padded_size);
+			mm81x_release_bus(mm);
+			if (status) {
+				ret = -EIO;
+				break;
+			}
+		}
+	}
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		if (mm81x_fw_get_section_header(fw->data, &ehdr, &shdr, i))
+			continue;
+
+		/* This is the firmware info. Parse it */
+		if (!strncmp(sh_strs + shdr.sh_name, ".fw_info",
+			     sizeof(".fw_info")))
+			mm81x_fw_parse_info(mm, fw->data + shdr.sh_offset,
+					    shdr.sh_size);
+	}
+
+	if (ehdr.e_entry)
+		ret = mm81x_fw_set_boot_addr(mm, ehdr.e_entry);
+
+	devm_kfree(mm->dev, fw_buf);
+	return ret;
+}
+
+static int __mm81x_fw_load_bcf(struct mm81x *mm, unsigned int addr,
+			       const void *src, size_t src_len, u8 *scratch,
+			       size_t scratch_cap)
+{
+	size_t rounded = ROUND_BYTES_TO_WORD(src_len);
+	int st;
+
+	if (rounded > scratch_cap)
+		return -EINVAL;
+	if (rounded > BCF_DATABASE_SIZE)
+		return -EFBIG;
+
+	memcpy(scratch, src, src_len);
+	if (rounded > src_len)
+		memset(scratch + src_len, 0xff, rounded - src_len);
+
+	mm81x_claim_bus(mm);
+	st = mm81x_dm_write(mm, addr, scratch, rounded);
+	mm81x_release_bus(mm);
+
+	return st ? -EIO : 0;
+}
+
+static int mm81x_fw_load_bcf(struct mm81x *mm, const struct firmware *bcf,
+			     unsigned int bcf_address)
+{
+	int i, ret = 0;
+	size_t reg_prefix_len, cfg_len_rounded = 0, reg_len_rounded;
+	mm81x_elf_ehdr ehdr;
+	mm81x_elf_shdr shdr, sh_strtab;
+	const char *sh_strs, *reg_prefix = ".regdom_", *reg_src;
+	size_t reg_len;
+	u8 *bcf_buf;
+
+	bcf_buf = devm_kmalloc(mm->dev, ROUND_BYTES_TO_WORD(bcf->size),
+			       GFP_KERNEL);
+	if (!bcf_buf)
+		return -ENOMEM;
+
+	if (mm81x_fw_get_header(bcf->data, &ehdr)) {
+		mm81x_err(mm, "Wrong file format");
+		ret = -EINVAL;
+		goto out_free;
+	}
+
+	if (mm81x_fw_get_section_header(bcf->data, &ehdr, &sh_strtab,
+					ehdr.e_shstrndx)) {
+		mm81x_err(mm, "Invalid BCF - missing string table");
+		ret = -ENOENT;
+		goto out_free;
+	}
+
+	sh_strs = (const char *)bcf->data + sh_strtab.sh_offset;
+	reg_prefix_len = strlen(reg_prefix);
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		if (mm81x_fw_get_section_header(bcf->data, &ehdr, &shdr, i))
+			continue;
+		if (strcmp(sh_strs + shdr.sh_name, ".board_config"))
+			continue;
+
+		cfg_len_rounded = ROUND_BYTES_TO_WORD(shdr.sh_size);
+		mm81x_dbg(mm, MM81X_DBG_FW,
+			  "Write BCF board_config - addr 0x%x size %zu",
+			  bcf_address, cfg_len_rounded);
+
+		ret = __mm81x_fw_load_bcf(mm, bcf_address,
+					  bcf->data + shdr.sh_offset,
+					  shdr.sh_size, bcf_buf,
+					  ROUND_BYTES_TO_WORD(bcf->size));
+		if (ret)
+			goto out_free;
+
+		bcf_address += cfg_len_rounded;
+		break;
+	}
+
+	ret = -EINVAL;
+	for (; i < ehdr.e_shnum; i++) {
+		if (mm81x_fw_get_section_header(bcf->data, &ehdr, &shdr, i))
+			continue;
+		if (strncmp(sh_strs + shdr.sh_name, reg_prefix, reg_prefix_len))
+			continue;
+		if (strncmp(sh_strs + shdr.sh_name + reg_prefix_len,
+			    mm->country, 2))
+			continue;
+
+		reg_src = bcf->data + shdr.sh_offset;
+		reg_len = shdr.sh_size;
+		mm81x_dbg(mm, MM81X_DBG_FW, "Write BCF %s - addr 0x%x size %zu",
+			  sh_strs + shdr.sh_name, bcf_address,
+			  ROUND_BYTES_TO_WORD(reg_len));
+		ret = 0;
+		break;
+	}
+
+	if (ret)
+		goto out_free;
+
+	reg_len_rounded = ROUND_BYTES_TO_WORD(reg_len);
+	if ((cfg_len_rounded + reg_len_rounded) > BCF_DATABASE_SIZE) {
+		ret = -EFBIG;
+		goto out_free;
+	}
+
+	ret = __mm81x_fw_load_bcf(mm, bcf_address, reg_src, reg_len, bcf_buf,
+				  ROUND_BYTES_TO_WORD(bcf->size));
+
+out_free:
+	devm_kfree(mm->dev, bcf_buf);
+	return ret;
+}
+
+static void mm81x_fw_clear_aon(struct mm81x *mm)
+{
+	int idx;
+	u8 count = MM81X_REG_AON_COUNT(mm);
+	u32 address = MM81X_REG_AON_ADDR(mm);
+
+	if (address) {
+		for (idx = 0; idx < count; idx++, address += 4) {
+			if (mm->bus_type == MM81X_BUS_TYPE_USB && idx == 0)
+				/* Keep the USB power domain enabled in AON. */
+				mm81x_reg32_write(mm, address,
+						  MM81X_REG_AON_USB_RESET(mm));
+			else
+				/* clear AON */
+				mm81x_reg32_write(mm, address, 0x0);
+		}
+	}
+
+	mm81x_hw_toggle_aon_latch(mm);
+}
+
+static void mm81x_fw_trigger(struct mm81x *mm)
+{
+	const unsigned int wait_after_msi_trigger_ms = 1;
+
+	mm81x_claim_bus(mm);
+	/*
+	 * If not coming from a full reset, some AON flags may be latched.
+	 * Make sure to clear any hanging AON bits (can affect booting).
+	 */
+	mm81x_fw_clear_aon(mm);
+
+	if (MM81X_REG_CLK_CTRL(mm))
+		mm81x_reg32_write(mm, MM81X_REG_CLK_CTRL(mm),
+				  MM81X_REG_CLK_CTRL_VALUE(mm));
+
+	mm81x_reg32_write(mm, MM81X_REG_MSI(mm), MM81X_REG_MSI_HOST_INT(mm));
+	mm81x_release_bus(mm);
+
+	/* Give the chip a chance to boot */
+	mdelay(wait_after_msi_trigger_ms);
+}
+
+static int mm81x_fw_verify_magic(struct mm81x *mm)
+{
+	int ret = 0;
+	int magic = ~MM81X_REG_HOST_MAGIC_VALUE(mm);
+
+	mm81x_claim_bus(mm);
+	mm81x_reg32_read(mm,
+			 mm->host_table_ptr +
+				 offsetof(struct host_table, magic_number),
+			 &magic);
+
+	if (magic != MM81X_REG_HOST_MAGIC_VALUE(mm)) {
+		mm81x_err(mm, "FW magic mismatch 0x%08x:0x%08x",
+			  MM81X_REG_HOST_MAGIC_VALUE(mm), magic);
+		ret = -EIO;
+	}
+
+	mm81x_release_bus(mm);
+	return ret;
+}
+
+static int mm81x_fw_get_flags(struct mm81x *mm)
+{
+	int ret = 0;
+	int fw_flags = 0;
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm,
+			       mm->host_table_ptr + offsetof(struct host_table,
+							     firmware_flags),
+			       &fw_flags);
+	mm->firmware_flags = fw_flags;
+	mm81x_release_bus(mm);
+
+	return ret;
+}
+
+static int mm81x_fw_check_compatibility(struct mm81x *mm)
+{
+	int ret = 0;
+	u32 fw_version;
+	u32 major;
+	u32 minor;
+	u32 patch;
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm,
+			       mm->host_table_ptr + offsetof(struct host_table,
+							     fw_version_number),
+			       &fw_version);
+	mm81x_release_bus(mm);
+
+	major = MM81X_SEMVER_GET_MAJOR(fw_version);
+	minor = MM81X_SEMVER_GET_MINOR(fw_version);
+	patch = MM81X_SEMVER_GET_PATCH(fw_version);
+
+	/* Firmware on device must be recent enough for driver */
+	if (ret == 0 && major != HOST_CMD_SEMVER_MAJOR) {
+		mm81x_err(
+			mm,
+			"Incompatible FW version: (Driver) %d.%d.%d, (Chip) %d.%d.%d\n",
+			HOST_CMD_SEMVER_MAJOR, HOST_CMD_SEMVER_MINOR,
+			HOST_CMD_SEMVER_PATCH, major, minor, patch);
+		ret = -EPERM;
+	} else if (ret == 0 && minor != HOST_CMD_SEMVER_MINOR) {
+		mm81x_warn(
+			mm,
+			"FW version mismatch, some features might not be supported: (Driver) %d.%d.%d, (Chip) %d.%d.%d",
+			HOST_CMD_SEMVER_MAJOR, HOST_CMD_SEMVER_MINOR,
+			HOST_CMD_SEMVER_PATCH, major, minor, patch);
+	}
+
+	return ret;
+}
+
+static int mm81x_fw_invalidate_host_ptr(struct mm81x *mm)
+{
+	int ret;
+
+	mm->host_table_ptr = 0;
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_write(mm, MM81X_REG_HOST_MANIFEST_PTR(mm), 0);
+	mm81x_release_bus(mm);
+	return ret;
+}
+
+static int mm81x_fw_get_host_table_ptr(struct mm81x *mm)
+{
+	int ret = 0;
+	unsigned long timeout =
+		jiffies + msecs_to_jiffies(MAX_WAIT_FOR_HOST_TABLE_PTR_MS);
+
+	mm81x_claim_bus(mm);
+	while (1) {
+		ret = mm81x_reg32_read(mm, MM81X_REG_HOST_MANIFEST_PTR(mm),
+				       &mm->host_table_ptr);
+
+		if (mm->host_table_ptr)
+			break;
+
+		if (time_after(jiffies, timeout)) {
+			ret = -EIO;
+			break;
+		}
+
+		usleep_range(5000, 10000);
+	}
+
+	mm81x_release_bus(mm);
+	return ret;
+}
+
+static int mm81x_fw_read_ext_host_table(struct mm81x *mm,
+					struct ext_host_tbl **ext_host_table)
+{
+	int ret = 0;
+	u32 host_tbl_ptr = mm->host_table_ptr;
+	u32 ext_host_tbl_ptr;
+	u32 ext_host_tbl_ptr_addr =
+		host_tbl_ptr + offsetof(struct host_table, ext_host_tbl_addr);
+	u32 ext_host_tbl_len;
+	u32 ext_host_tbl_len_ptr_addr;
+	struct ext_host_tbl *host_tbl = NULL;
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm, ext_host_tbl_ptr_addr, &ext_host_tbl_ptr);
+	if (ret)
+		goto exit;
+
+	if (!ext_host_tbl_ptr) {
+		ret = -ENXIO;
+		goto exit;
+	}
+
+	ext_host_tbl_len_ptr_addr =
+		ext_host_tbl_ptr +
+		offsetof(struct ext_host_tbl, ext_host_tbl_length);
+
+	ret = mm81x_reg32_read(mm, ext_host_tbl_len_ptr_addr,
+			       &ext_host_tbl_len);
+	if (ret)
+		goto exit;
+
+	ext_host_tbl_len = ROUND_BYTES_TO_WORD(ext_host_tbl_len);
+	if (WARN_ON(ext_host_tbl_len == 0 || ext_host_tbl_len > INT_MAX)) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	host_tbl = kmalloc(ext_host_tbl_len, GFP_KERNEL);
+	if (!host_tbl) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	ret = mm81x_dm_read(mm, ext_host_tbl_ptr, (u8 *)host_tbl,
+			    (int)ext_host_tbl_len);
+	if (ret)
+		goto exit;
+
+	mm81x_release_bus(mm);
+	*ext_host_table = host_tbl;
+	return ret;
+
+exit:
+	mm81x_release_bus(mm);
+	kfree(host_tbl);
+	return ret;
+}
+
+static void mm81x_fw_update_capabilities(struct mm81x *mm,
+					 struct ext_host_tbl_s1g_caps *caps)
+{
+	int i;
+
+	for (i = 0; i < FW_CAPABILITIES_FLAGS_WIDTH; i++) {
+		mm->fw_caps.flags[i] = le32_to_cpu(caps->flags[i]);
+		mm81x_dbg(mm, MM81X_DBG_FW, "Firmware Manifest Flags%d: 0x%x",
+			  i, le32_to_cpu(caps->flags[i]));
+	}
+	mm->fw_caps.ampdu_mss = caps->ampdu_mss;
+	mm->fw_caps.mm81x_mmss_offset = caps->mm81x_mmss_offset;
+	mm->fw_caps.beamformee_sts_capability = caps->beamformee_sts_capability;
+	mm->fw_caps.maximum_ampdu_length_exponent = caps->maximum_ampdu_length;
+	mm->fw_caps.number_sounding_dimensions =
+		caps->number_sounding_dimensions;
+
+	mm81x_dbg(mm, MM81X_DBG_FW, "\tAMPDU Minimum start spacing: %u",
+		  caps->ampdu_mss);
+	mm81x_dbg(mm, MM81X_DBG_FW, "\tMorse Minimum Start Spacing offset: %u",
+		  caps->mm81x_mmss_offset);
+	mm81x_dbg(mm, MM81X_DBG_FW, "\tBeamformee STS Capability: %u",
+		  caps->beamformee_sts_capability);
+	mm81x_dbg(mm, MM81X_DBG_FW, "\tNumber of Sounding Dimensions: %u",
+		  caps->number_sounding_dimensions);
+	mm81x_dbg(mm, MM81X_DBG_FW, "\tMaximum AMPDU Length Exponent: %u",
+		  caps->maximum_ampdu_length);
+}
+
+static void mm81x_fw_update_validate_skb_checksum(
+	struct mm81x *mm,
+	struct ext_host_tbl_insert_skb_checksum *validate_checksum)
+{
+	mm->hif.validate_skb_checksum =
+		validate_checksum->insert_and_validate_checksum;
+	mm81x_dbg(mm, MM81X_DBG_ANY, "Validate checksum inserted by fw %s",
+		  str_enabled_disabled(mm->hif.validate_skb_checksum));
+}
+
+int mm81x_fw_parse_ext_host_tbl(struct mm81x *mm)
+{
+	int ret;
+	u8 *head;
+	u8 *end;
+	struct ext_host_tbl *ext_host_table = NULL;
+
+	ret = mm81x_fw_read_ext_host_table(mm, &ext_host_table);
+	if (ret || !ext_host_table)
+		goto exit;
+
+	/* Parse the TLVs */
+	head = ext_host_table->ext_host_table_data_tlvs;
+	end = ((u8 *)ext_host_table) +
+	      le32_to_cpu(ext_host_table->ext_host_tbl_length);
+
+	while (head < end) {
+		struct ext_host_tbl_tlv_hdr *hdr =
+			(struct ext_host_tbl_tlv_hdr *)head;
+
+		switch (le16_to_cpu(hdr->tag)) {
+		case MM81X_FW_HOST_TABLE_TAG_S1G_CAPABILITIES:
+			mm81x_fw_update_capabilities(
+				mm, (struct ext_host_tbl_s1g_caps *)hdr);
+			break;
+
+		case MM81X_FW_HOST_TABLE_TAG_INSERT_SKB_CHECKSUM:
+			mm81x_fw_update_validate_skb_checksum(
+				mm,
+				(struct ext_host_tbl_insert_skb_checksum *)hdr);
+			break;
+
+		case MM81X_FW_HOST_TABLE_TAG_YAPS_TABLE:
+			mm81x_yaps_hw_read_table(
+				mm, &((struct ext_host_tbl_yaps_table *)hdr)
+					     ->yaps_table);
+			break;
+		default:
+			break;
+		}
+
+		head += le16_to_cpu(hdr->length);
+		if (!hdr->length)
+			break;
+	}
+
+	kfree(ext_host_table);
+	return ret;
+exit:
+	mm81x_err(mm, "failed to parse ext host table %d", ret);
+	return ret;
+}
+
+static int __mm81x_fw_flash(struct mm81x *mm, const struct firmware *fw,
+			    const struct firmware *bcf, bool reset)
+{
+	int ret;
+
+	if (reset || !mm->chip_was_reset) {
+		ret = mm81x_hw_digital_reset(mm);
+		if (ret)
+			return ret;
+	}
+
+	mm81x_hw_pre_firmware_ndr_hook(mm);
+
+	ret = mm81x_fw_invalidate_host_ptr(mm);
+	if (ret)
+		return ret;
+
+	ret = mm81x_fw_load_fw(mm, fw);
+	if (ret)
+		return ret;
+
+	ret = mm81x_fw_load_bcf(mm, bcf, mm->bcf_address);
+	if (ret)
+		return ret;
+
+	mm81x_fw_trigger(mm);
+	mm81x_hw_post_firmware_ndr_hook(mm);
+
+	ret = mm81x_fw_get_host_table_ptr(mm);
+	if (ret)
+		return ret;
+
+	ret = mm81x_fw_verify_magic(mm);
+	if (ret)
+		return ret;
+
+	return mm81x_fw_check_compatibility(mm);
+}
+
+static int mm81x_fw_flash(struct mm81x *mm, const struct firmware *fw,
+			  const struct firmware *bcf, bool reset)
+{
+	int ret;
+	int retries = FW_FLASH_ATTEMPT_COUNT;
+
+	while (retries--) {
+		ret = __mm81x_fw_flash(mm, fw, bcf, reset);
+		if (!ret)
+			return 0;
+
+		mm->chip_was_reset = false;
+	}
+
+	return ret;
+}
+
+static uint32_t binary_crc(const struct firmware *fw)
+{
+	return ~crc32_le(~0, (unsigned char const *)fw->data, fw->size) &
+	       0xffffffff;
+}
+
+int mm81x_fw_init(struct mm81x *mm, bool reset)
+{
+	int ret;
+	int n;
+	int board_id;
+	char *fw_path;
+	char bcf_path[MAX_BCF_NAME_LEN];
+	const struct firmware *fw = NULL;
+	const struct firmware *bcf = NULL;
+
+	fw_path = mm81x_core_get_fw_path(mm->chip_id);
+	if (!fw_path)
+		return -ENOMEM;
+
+	board_id = mm81x_hw_otp_get_board_type(mm);
+
+	if (strlen(board_config_file) > 0) {
+		n = snprintf(bcf_path, sizeof(bcf_path), "%s/%s", MM81X_FW_DIR,
+			     board_config_file);
+	} else if (mm81x_hw_otp_valid_board_type(board_id)) {
+		mm81x_dbg(mm, MM81X_DBG_FW, "Using board type 0x%04x from OTP",
+			  board_id);
+		n = snprintf(bcf_path, sizeof(bcf_path),
+			     "%s/bcf_boardtype_%04x.bin", MM81X_FW_DIR,
+			     board_id);
+	} else {
+		mm81x_err(mm, "BCF or Serial parameters are not defined");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (n < 0 || n >= sizeof(bcf_path)) {
+		mm81x_err(mm, "Failed to create BCF path");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = request_firmware(&fw, fw_path, mm->dev);
+	if (ret) {
+		if (ret == -ENOENT)
+			dev_err(mm->dev, "Firmware %s not found\n", fw_path);
+		goto out;
+	}
+
+	dev_info(mm->dev, "Loaded firmware from %s, size %zu, crc32 0x%08x\n",
+		 fw_path, fw->size, binary_crc(fw));
+
+	ret = request_firmware(&bcf, bcf_path, mm->dev);
+	if (ret) {
+		if (ret == -ENOENT)
+			dev_err(mm->dev, "BCF %s not found\n", bcf_path);
+		goto out;
+	}
+
+	dev_info(mm->dev, "Loaded BCF from %s, size %zu, crc32 0x%08x\n",
+		 bcf_path, bcf->size, binary_crc(bcf));
+
+	ret = mm81x_fw_flash(mm, fw, bcf, reset);
+	if (ret) {
+		mm81x_err(mm, "failed to flash firmware: %d", ret);
+		goto out;
+	}
+
+	ret = mm81x_fw_get_flags(mm);
+
+out:
+	release_firmware(fw);
+	release_firmware(bcf);
+	kfree(fw_path);
+
+	if (ret)
+		mm81x_err(mm, "failed to init firmware: %d", ret);
+	else
+		mm81x_dbg(mm, MM81X_DBG_FW, "firmware initialised");
+
+	return ret;
+}
-- 
2.43.0


