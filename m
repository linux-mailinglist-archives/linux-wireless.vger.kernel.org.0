Return-Path: <linux-wireless+bounces-5695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64213893550
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 20:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB455B20C15
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964D7145B21;
	Sun, 31 Mar 2024 18:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="ENfHKHCF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D524688
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711908470; cv=pass; b=WTfXKAw0bo4DWz2kx5Mf2eIxzo3CJANvjaagts19no9lcclkd11GS6D7KQFfO5U9y0kRS90rvPqP7qXYDafbdRcLm679MWzyGqDnwVIJZzTh3HjEwuOwzbo/1Mmnm6WsQYEqA+2oKqOVQGRxpFOnpdGNirtKat40fq//XbGAaEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711908470; c=relaxed/simple;
	bh=O+v7TLaSMAEieSBS053ThteSgklJUCsx7AE3sZPx1CU=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=IFLemo4iwnSsY8/lGE9x8WWMd2PZOundfLzWhw6jyyYrzWzucnE6H7zhyowTdXSacQhhIW7lJLQQFjILYekHK9i0Tiparw5FQ18ocJT2zAhLbLlEgf49DvLr2NUHn2JrotbJ5qEQ//b2ptqIBfeHylicCmmR4ksVfc6+/BjrMNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=ENfHKHCF; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4V72DY5tlwz4Rrq;
	Sun, 31 Mar 2024 18:07:41 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [IPv6:2610:1c1:1:606c::24b:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4V72DY4v3Gz42ws;
	Sun, 31 Mar 2024 18:07:41 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711908461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QWFsyRgnApHufeu19p+rnrR5Cazct16bfM2s39Ru9Nw=;
	b=ENfHKHCFQIMkCg2fOhdiCYeMEyROJGuYlbCIfjqPxejExWneARnObla0Q2xiqQN+BQ8Y7E
	B8Rbs1UwXA2GQBEOSZ7Rp03lTtdTxnu5Smx6aT3uP4X2JWLy0qKVnTFYfwmBddkrFdSmL2
	91SEOHBru5PoQavmFQ1DtcMLAugAVTdIc1W2MyKv4XGFhF+JoXULlkU8sgyXz/BD67rR1o
	BBP80kb/SxPevxxv3802IAdfTcV2kfTlHgfVGZBbyL/HtiPEW2Y7IzkfK8FdYHEXW4BJzC
	nodyt8GQGokedrh6r5HgiPzOR4pn/axV5D1OIN49WNc+mSwISe/ZMWMtODcdzw==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711908461; a=rsa-sha256; cv=none;
	b=XPX7TxHJyk0Yug6Qm4j1Y2GtvI1tHLsBLHe/doAUVMk8ztcUls2BwELu9kS4FxtjI1vl2q
	Glib3q2phmFyfFh6a8sjAn06us0Rbmk+8fyxYOgMflolaxRNQwk+4Ovt39dKZpZMK6Jls7
	Did8lmqJedBjyp0QUW9zBpQc/5z/E8ejHwPrqUwo0F0qMTJVJuEGb2+EDMqsSS848BOgc/
	HztMDOmtW71sMUtU1KDBJ1dUEuCH2mU5JBssPZ75NlsNZYZNhx/Zp6DwW/1D/lD4pkZc45
	gXmwUC9uhqAvA3NmINaNSZeQDD2beMy8SQeW9YapXxubPDQzd+STEM7VVdVnZA==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711908461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=QWFsyRgnApHufeu19p+rnrR5Cazct16bfM2s39Ru9Nw=;
	b=C8+8Cx6QH/VWHb1TX/OqAYL65QhmUYVe5x5eruYSNjMKXSpmvTnHKGiry59IcWuy7PEh5b
	xKokZEi47qD6XCJZU9pWinwDOswq7K9iQnMyXHWez6+mYYt+VxWBejhtfEE/Wuo5ycp/sK
	Ii1f/MgyMw3kMlllXbqrSuRXlJaq/hIjCRrJbrUHB6zvFHQSpjMX+QmYhA+mvGkIaI6SMF
	1i2b8gXe9BFRFo88jYP+GhmVovB0Ep37PzDNdAaXae6/ZsVJO/b1U41+ebAaqYpeyaWAPw
	h8AP0dPO1balDYudDy47rkOCjj8NQ1zID/zchuaJb6eig6sclbidFrAeL3Rp+A==
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mx1.sbone.de", Issuer "SBone.DE Root Certificate Authority" (not verified))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4V72DY3lV2zVsm;
	Sun, 31 Mar 2024 18:07:41 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sbone.de (Postfix) with ESMTPS id 66F088D4A241;
	Sun, 31 Mar 2024 18:07:40 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id E1E052D029D9;
	Sun, 31 Mar 2024 18:07:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id r6GsfbF0UnPH; Sun, 31 Mar 2024 18:07:39 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id A397D2D029D2;
	Sun, 31 Mar 2024 18:07:38 +0000 (UTC)
Date: Sun, 31 Mar 2024 18:07:38 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH] wifi: iwlwifi: mvm: fix iwl_ssid_exist() duplicate check
Message-ID: <04759p9q-p8r3-p811-s0n4-q23r6n3s74s2@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

iwl_ssid_exist() seems to check if a given ssid/ssid_len already
exists in a given array ssid_list.
Correctly compare the ssid to the SSID of each array element
(with a matching SSID length) to better remove duplicates.

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
---
  drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git drivers/net/wireless/intel/iwlwifi/mvm/scan.c drivers/net/wireless/intel/iwlwifi/mvm/scan.c
index 7b6f1cdca067..343e70e58da5 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/scan.c
+++ drivers/net/wireless/intel/iwlwifi/mvm/scan.c
@@ -454,7 +454,7 @@ static int iwl_ssid_exist(u8 *ssid, u8 ssid_len, struct iwl_ssid_ie *ssid_list)
  		if (!ssid_list[i].len)
  			break;
  		if (ssid_list[i].len == ssid_len &&
-		    !memcmp(ssid_list->ssid, ssid, ssid_len))
+		    !memcmp(ssid_list[i]->ssid, ssid, ssid_len))
  			return i;
  	}
  	return -1;
-- 
2.40.0

