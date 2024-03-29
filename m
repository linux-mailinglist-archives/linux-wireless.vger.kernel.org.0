Return-Path: <linux-wireless+bounces-5629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D578926E1
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 23:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0763B22D5E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Mar 2024 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A08943AC2;
	Fri, 29 Mar 2024 22:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="mOp4NxDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx2.freebsd.org (mx2.freebsd.org [96.47.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDC28DCA
	for <linux-wireless@vger.kernel.org>; Fri, 29 Mar 2024 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752064; cv=pass; b=EhgKJNWW8QggMFzzVGJf6nchTOcMaW+DcgLgjkGme1qWTJXVnAJhVVrzVhzKQnHGCK0K66EkAUpjq7Ou84wxnMHDRfHJDanBQfHgbZeGelgvjLhYWsab60SHqvOoiYRVj7iwGILmeU6XA+WDVQUk8UvcgAFkaGHachoIO+z8bsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752064; c=relaxed/simple;
	bh=+NS8DRolFTEpqULXWD/Iuy5zgqspUBx0v3sCTySgzUo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=jIcy/TNNGfW2oHIbBgom0fbqzPkdzPi6FsdMA+gE8dNFM2NElgRzASi/oTP88QlmgFxFTo11wtpcwoxC5wIgmtazDMHXgE618SyTtwXvJ1GIipxp3hLyNZhIzZTxgviP3KoDb6Ymqm8SohzP28fL4cC/rJjlh/KaJItNiuL280w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=mOp4NxDx; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
Received: from mx1.freebsd.org (mx1.freebsd.org [96.47.72.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits)
	 client-signature RSA-PSS (4096 bits))
	(Client CN "mx1.freebsd.org", Issuer "R3" (verified OK))
	by mx2.freebsd.org (Postfix) with ESMTPS id 4V5wNs6XzMz4WnG;
	Fri, 29 Mar 2024 22:41:01 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "smtp.freebsd.org", Issuer "R3" (verified OK))
	by mx1.freebsd.org (Postfix) with ESMTPS id 4V5wNs5lhGz4Rvg;
	Fri, 29 Mar 2024 22:41:01 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org; s=dkim;
	t=1711752061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dWMhzPy1cNnI3iwH3ixCyPFnhDnothTqn2MInSE3b04=;
	b=mOp4NxDx6/iQknmZ9dDXUumXeFMEHzFlR0t87ybU9s7v0ZQPAyIW/8muf8SsI57MmLFyFl
	FSJZ3n7gEv0Pc+6PXtrk2U2D2BTOlzhv06reZvhCRrmintsn/czUGIqBlXqETHCaeD3In5
	v3ZZgabbbk0q4vYy5F63khBpQwklEymOpsNdSjZXSRK3Tv/O27Tkuaqi4A/kzJ1C0yFWUP
	nT/SR8J4WpA8CcN9vUg5e9Q52+rGF3mpXtNVX1FZsWKy97PGAHTPKYrqEGP8/kS1J4s6FK
	HEeS8Kg4ghzqIEpfcCSvRfx+/ljSyohrpDRsiMlTLDOHgKkquJCnhoACdCJWsQ==
ARC-Seal: i=1; s=dkim; d=freebsd.org; t=1711752061; a=rsa-sha256; cv=none;
	b=bwtPue1aMceuJocDIXpipKjuhrCJCupGOKNCqD/os0KAljQTBDDADtZsdoEdHVVlyYuDLz
	5g6AWveVI6kkCuRBd6XE2hK1w/VmFwulfBw7M8pQDnU+rMKVAEnQ5THExna2VBbxo9H7ls
	AiHHzjmDOXvCIxxVAWSuWq5g/TXgFB2X8okesyfQqmDGnC1VLxQmKv2KolC0KXnGTLd/34
	EKPgduMfz379BBFTCrxAWCX9tqCR+aiHaK3a2O4Pr0jl5AdS0opndLU0VXiSK7Vwdtx2OP
	AsE21JjTg/f4EwPFU7SttH3P+ry8Wr2Lasgrj4ji8F88x70epNE/no0jPKvvDw==
ARC-Authentication-Results: i=1;
	mx1.freebsd.org;
	none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=freebsd.org;
	s=dkim; t=1711752061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=dWMhzPy1cNnI3iwH3ixCyPFnhDnothTqn2MInSE3b04=;
	b=cfkgmUVBeZMip0ukhKy4BbEknkJioer2Z7mOGUA0ailhvl382wlRavhnS8sTs3S92v+hCk
	1prkfvHz6J9QTMSWeusHudphzBAlDydVYuHsl0lb14bhXRWYwLBcFetqft9lxXCUEuTbbe
	QtQyyTlX6ZK77MdVLyh7SHj+7X29ojPKXARnXydIfFwIZg8G3MjwmAW/dGrP+ZGUI7qJia
	IGZyhPUK6VWJpeeZL1DsTd+2DHDiUMfLn8ZZNOTxgWt3OSGmnicVRFq/45ugHiazs6t9M3
	dIecoPO4mEZDKnjWkAphRa6VV2XxLjWlQPnyR3x8Vx+QGmUOvDmiF2zmYFCq2A==
Received: from mx1.sbone.de (mx1.sbone.de [IPv6:2a01:4f8:13b:39f::9f:25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mx1.sbone.de", Issuer "SBone.DE Root Certificate Authority" (not verified))
	(Authenticated sender: bz/mail)
	by smtp.freebsd.org (Postfix) with ESMTPSA id 4V5wNs4jVZzdKY;
	Fri, 29 Mar 2024 22:41:01 +0000 (UTC)
	(envelope-from bz@FreeBSD.org)
Received: from mail.sbone.de (mail.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sbone.de (Postfix) with ESMTPS id A895F8D4A241;
	Fri, 29 Mar 2024 22:41:00 +0000 (UTC)
Received: from content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPS id 6479B2D029D8;
	Fri, 29 Mar 2024 22:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at sbone.de
Received: from mail.sbone.de ([IPv6:fde9:577b:c1a9:4902:0:7404:2:1025])
	by content-filter.t4-02.sbone.de (content-filter.t4-02.sbone.de [IPv6:fde9:577b:c1a9:4902:0:7404:2:2742]) (amavisd-new, port 10024)
	with ESMTP id k7yc9PnNa1Tj; Fri, 29 Mar 2024 22:40:59 +0000 (UTC)
Received: from strong-iwl0.sbone.de (strong-iwl0.sbone.de [IPv6:fde9:577b:c1a9:4902:b66b:fcff:fef3:e3d2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.sbone.de (Postfix) with ESMTPSA id 7AF7C2D029D2;
	Fri, 29 Mar 2024 22:40:59 +0000 (UTC)
Date: Fri, 29 Mar 2024 22:40:59 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 3/3] wifi: iwlwifi: mvm: check for CONFIG_IWLMEI to be enabled
 for more code
Message-ID: <sq1o7pr0-2137-11np-1or1-650nrro75o13@SerrOFQ.bet>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Some of the code is only needed in case MEI support is available
but given it is a GPL-only feature this may lead to unused and/or
unresolved symbols on platforms sharing the otherwise dual-licensed
driver code or in case CONFIG_IWLMEI is turned off.

Signed-off-by:	Bjoern A. Zeeb <bz@FreeBSD.org>
Sponsored by:	The FreeBSD Foundation
Link: https://cgit.freebsd.org/src/commit/sys/contrib/dev/iwlwifi/mvm/ops.c?id=75c779fb279c2bea90c08e275af5937213bdca81
---
  drivers/net/wireless/intel/iwlwifi/mvm/ops.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git drivers/net/wireless/intel/iwlwifi/mvm/ops.c drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index adbbe19aeae5..2514319bce2a 100644
--- drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -1029,6 +1029,7 @@ static const struct iwl_dump_sanitize_ops iwl_mvm_sanitize_ops = {
  	.frob_mem = iwl_mvm_frob_mem,
  };

+#if IS_ENABLED(CONFIG_IWLMEI)
  static void iwl_mvm_me_conn_status(void *priv, const struct iwl_mei_conn_info *conn_info)
  {
  	struct iwl_mvm *mvm = priv;
@@ -1078,6 +1079,7 @@ static void iwl_mvm_mei_roaming_forbidden(void *priv, bool forbidden)

  	iwl_mvm_send_roaming_forbidden_event(mvm, mvm->csme_vif, forbidden);
  }
+#endif

  static void iwl_mvm_sap_connected_wk(struct work_struct *wk)
  {
@@ -1111,6 +1113,7 @@ static void iwl_mvm_sap_connected_wk(struct work_struct *wk)
  	ieee80211_free_hw(mvm->hw);
  }

+#if IS_ENABLED(CONFIG_IWLMEI)
  static void iwl_mvm_mei_sap_connected(void *priv)
  {
  	struct iwl_mvm *mvm = priv;
@@ -1135,6 +1138,7 @@ static const struct iwl_mei_ops mei_ops = {
  	.sap_connected = iwl_mvm_mei_sap_connected,
  	.nic_stolen = iwl_mvm_mei_nic_stolen,
  };
+#endif

  static struct iwl_op_mode *
  iwl_op_mode_mvm_start(struct iwl_trans *trans, const struct iwl_cfg *cfg,
-- 
2.40.0

