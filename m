Return-Path: <linux-wireless+bounces-7571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD29F8C380E
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 980BD281FBD
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B480944369;
	Sun, 12 May 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="VDbXEzMm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30AF4436B
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715539814; cv=none; b=lnjX5LZQjL3ShFnWcvC/IWypIFYe91x9xfbnxeTTeOGdSjLF/uOCp+F8eJ9VMK8IpbFRs5Og3BWolS5lxUIAZnbf1AKzuffGoPqO1myRRL9QmiNVV120uzzcwA7kIoQNQBn6Qg4jLKUkp1ccsVRTvb7Pr159D8dBCIHqd+FCXHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715539814; c=relaxed/simple;
	bh=2/uT8JxozBPSDl5GUwJ2iTMTythpxS1KSIbHMy5kWAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qtaE5ydACFR7T3Y8eluh5zjZvDR8gRT56vJrOVa8AbI+AIHLbWH2KrEZOamaAPp6iMlOmb891V/k/raC0UwLlvKhyB5Bv/O1IyBT1Ob4YZz6Fypq8N/Vn2kpGKV90kHpUjXKihSogxv6TdDh6E2pVBYdzB5L3hiIkbp6+MnwVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=VDbXEzMm; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 03A6087F68;
	Sun, 12 May 2024 20:50:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715539804;
	bh=gvJCFtX/l45I3Jri+Dcv7igav8HsPzomgbJlEGKa3aE=;
	h=From:To:Cc:Subject:Date:From;
	b=VDbXEzMmNybf168lypL912HPVc/A7AxBsrpkVH2aaVwhVFXhB+Xnvvrxll8D6Gze/
	 k148kUQPhsMfbUukD+a8/T3de9MZ4qw1nlXnUjCDtwRYLnVI42Zpwl5E18tcwLZTqP
	 Ux43CNXAgbduUYte4cWbBCt/Bpbml9H8aBRgMjHZNBa15TmUd/3c05w+wyrkU7Hvyn
	 AW1xyB62CuRaAldVv4Q4LarMb5+lN7CQ4ewVh8phH/115BudusyOH4txB6T0h6kQ5R
	 iieGyRid0bQAsGH7lizFXR463figH4Um3VBPHo6FjmvIFMnN0SSx4Wf6DEkCFxIkLk
	 3u7jb8MkiJn4g==
From: Marek Vasut <marex@denx.de>
To: linux-wireless@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>,
	Abhishek Naik <abhishek.naik@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] iwlwifi: mvm: Ignore NVM write status 0x1000
Date: Sun, 12 May 2024 20:48:37 +0200
Message-ID: <20240512184932.25831-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

When loading custom NVM file on Wireless-AC 9260 160MHz, REV=0x324
8086:2526 (rev 29) Subsystem: 8086:001c firmware version 46.6b541b68.0
9260-th-b0-jf-b0-46.ucode , the NVM_WRITE_OPCODE return status is 0x1000
for all sections. What does this mean is unknown, however clearing the
top 4 bits permits the NVM to be written and the card operates as it
should.

Hexdump of the iNVM file is below, the iNVM file overrides antenna
settings to only use AUX antenna and disables MIMO .
00000000  54 4c 50 2a 2a 4d 56 4e  2c 11 00 00 08 10 21 20
00000010  c0 00 00 02 03 03 02 11  2f 00 00 00 00 00 00 00
00000020  00 00 00 00

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Abhishek Naik <abhishek.naik@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
index ae81772228813..29342b9a6743e 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/nvm.c
@@ -59,7 +59,7 @@ static int iwl_nvm_write_chunk(struct iwl_mvm *mvm, u16 section,
 	pkt = cmd.resp_pkt;
 	/* Extract & check NVM write response */
 	nvm_resp = (void *)pkt->data;
-	if (le16_to_cpu(nvm_resp->status) != READ_NVM_CHUNK_SUCCEED) {
+	if ((le16_to_cpu(nvm_resp->status) & 0xfff) != READ_NVM_CHUNK_SUCCEED) {
 		IWL_ERR(mvm,
 			"NVM access write command failed for section %u (status = 0x%x)\n",
 			section, le16_to_cpu(nvm_resp->status));
-- 
2.43.0


