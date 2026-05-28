Return-Path: <linux-wireless+bounces-37071-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCOZF05+GGoskggAu9opvQ
	(envelope-from <linux-wireless+bounces-37071-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BA05F5CB1
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 19:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3A73C30EB458
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2026 17:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3E3FDC15;
	Thu, 28 May 2026 17:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b="JjfcVLnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtpweb146.aruba.it (smtpweb146.aruba.it [62.149.158.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA6F3FBED9
	for <linux-wireless@vger.kernel.org>; Thu, 28 May 2026 17:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779989697; cv=none; b=mdkioOODox3BEfIBTOjchD93Iak/RXIMZEH3QP+g+BNFpQFdNewdBSzVo4/4z4qtzFHhPREM9ezXAy2hYZkdTIVkUMztiy8KfaDuMqItaFRH8F/uIn6Rdl8mu6r5Eg0ctw7GW1qyFffgLNOAc45QPbKdLonM62EsxjJBO2jb9nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779989697; c=relaxed/simple;
	bh=SYIv7H7SpupxdJet3IQpOb3GAjuN7nX15ZBOx75fnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To; b=bAHMS+uKPgvJhapazwBB55sYcxxqMGC4gZOFnpkTKCV9nmGBdLyckaPCO7deEwzzLHdk94JvZ+QK13224AJmYlcYc5Ok5/zE0clofkj75ILA4ijQtcoafJpr1WbYFWFwxde5vg8Q3hMX6jKJMcyPWu21BH5s9+XyBs7IIhGZP0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it; spf=pass smtp.mailfrom=mythread.it; dkim=pass (2048-bit key) header.d=mythread.it header.i=@mythread.it header.b=JjfcVLnv; arc=none smtp.client-ip=62.149.158.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mythread.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mythread.it
Received: from [192.168.1.237] ([94.34.125.0])
	by Aruba SMTP with ESMTPSA
	id Sea5wczvrrbJKSea6w6A3J; Thu, 28 May 2026 19:31:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mythread.it; s=a1;
	t=1779989502; bh=SYIv7H7SpupxdJet3IQpOb3GAjuN7nX15ZBOx75fnxU=;
	h=From:Date:Subject:MIME-Version:Content-Type:To;
	b=JjfcVLnv8Z9gfg+QYPbUQjBZthMfNSpIwH00Mgq/gLV3IUWNiOVC6erSiHyabCswF
	 HCPSI8+YsNtzmr1j079ODdWLTrL2vmYR+4t8mB+L9maQ45wtdKiSvV+DpJ25n2MGrt
	 3uuW6kDy+Nw+VAdhc8en1EkEnbIe3HgRQleXnb03iUP4LY8XDBy23KIojKzO1+0OeK
	 eMYj3Z3BbcV1tTcsuewJDFPAvDtpQjpRQ/09TNVfNaYMA9Xj0/s993omWdTWnxqDWt
	 2z6fRv/uJK3jPuYghmaqM63T+H6kkgAlC1npifv6NrnnNhb/eass3hPmUJQGqqiwSs
	 20gZwMipH1EZA==
From: Alessio Ferri <alessio.ferri@mythread.it>
Date: Thu, 28 May 2026 19:31:36 +0200
Subject: [PATCH v4 2/7] b43: add d11 core revision 0x16 to id table
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-2-464566194d47@gmail.com>
References: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
In-Reply-To: <20260528-b43_complete_n_phy_rev_8_radio_2057_rev_8_support-v4-0-464566194d47@gmail.com>
To: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Alessio Ferri <alessio.ferri@mythread.it>
X-Mailer: b4 0.14.3
X-CMAE-Envelope: MS4xfOUW+OMsbislXLVfjghoLiIMSllfjXG3jKhyT1qtr1TPotfGmGoeb8vIdxFRzON3ha+X1I01ALnINSxjunIRNJpkd+hb2Tso3vfQ6c4Al8AAeBDPURzQ
 29rmtnLnULRa/0VO3EcRCGmWXrooQhLCSqu40xytABMkKlcKB3hRVoC95GKPgsnpJAd3K9lN6GO5nNKsx17R2Mutn7NSdr9S/uiqb1CtsCb/hg8E+yllqt/u
 ISNj8R6MRy9W4IQM8xcXYODVPcwBRGWI658r2/xDq9z4g/xbS34L7GLyOev25WmdqYS+z22dTV35Abi8K3uXSBOpyhKw+cyRTuLnPPUyqtk=
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mythread.it,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mythread.it:s=a1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alessio.ferri@mythread.it,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-37071-lists,linux-wireless=lfdr.de];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mythread.it:email,mythread.it:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[mythread.it:+]
X-Rspamd-Queue-Id: 21BA05F5CB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add d11 core revision 0x16 (= 22) to the b43 bcma device id table.

The b43 bcma id table covers d11 revisions 0x11, 0x15, 0x17, 0x18,
0x1C, 0x1D, 0x1E, 0x28 and 0x2A. Revision 0x16 belongs to the same
N-PHY family as revisions 0x17 and 0x18 (radio 2057) and needs no
new PHY or radio code beyond the radio_rev 8 dispatcher entries
added later in this series - only the device id entry is missing.
Without it bcma scan enumerates the 802.11 core but no driver binds.

The revision is used by the Broadcom BCM6362 single-die integrated
2.4 GHz wireless block found in xDSL SoCs.

Assisted-by: Claude:claude-4.7-opus
Signed-off-by: Alessio Ferri <alessio.ferri@mythread.it>
---
 drivers/net/wireless/broadcom/b43/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireless/broadcom/b43/main.c
index 37c5d9928..85ea8fdd9 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -117,6 +117,7 @@ MODULE_PARM_DESC(allhwsupport, "Enable support for all hardware (even it if over
 static const struct bcma_device_id b43_bcma_tbl[] = {
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x11, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x15, BCMA_ANY_CLASS),
+	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x16, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x17, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x18, BCMA_ANY_CLASS),
 	BCMA_CORE(BCMA_MANUF_BCM, BCMA_CORE_80211, 0x1C, BCMA_ANY_CLASS),

-- 
2.54.0


