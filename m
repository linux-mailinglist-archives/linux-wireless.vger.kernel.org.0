Return-Path: <linux-wireless+bounces-5694-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC928934C8
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 19:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A790C1F232C3
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F5D14B079;
	Sun, 31 Mar 2024 16:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b="mOp4NxDx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992504416
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 16:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903523; cv=pass; b=SYxDTqZ4PzUW8q359HFVua1nU7efEldQo2pf4DWEX9ey+BqAhIgue3JkMduczModvhvynn1kihSbRrUmxjnzbwL9VfQgY8nGlCKbBm4b3uOS/FkobxD1pMw19nHJljqio7cvUfHP+tnTuNB1UwfbWT0Sc8eWpxDNZS6y1HdWFKg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903523; c=relaxed/simple;
	bh=+NS8DRolFTEpqULXWD/Iuy5zgqspUBx0v3sCTySgzUo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=EKxhvVq5xuvg8xS1p9JG8UOvcgyWRxN9e0fGDBEy5zfHZ/fADSvI5i6TtlVI9ITvI+zJ7dw6sxH+GSTnJJVi6yJvjSkPpWLHKqIQCcOEDBPqudgdMrHeM3DL6uhatKX29O7aOx3dqza84XZp8lBHNwTalUsNRmdbSfz5wIQRKf0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=fail smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=mOp4NxDx; arc=pass smtp.client-ip=96.47.72.81; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=FreeBSD.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 4EED5208E2;
	Sun, 31 Mar 2024 18:45:20 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yj8znNeNeU3; Sun, 31 Mar 2024 18:45:19 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6CC0E208D8;
	Sun, 31 Mar 2024 18:45:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6CC0E208D8
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 600F2800062;
	Sun, 31 Mar 2024 18:45:19 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:45:19 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:36:43 +0000
X-sender: <linux-wireless+bounces-5629-peter.schumann=secunet.com@vger.kernel.org>
X-Receiver: <peter.schumann@secunet.com> ORCPT=rfc822;peter.schumann@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-dresden-01.secunet.de
X-ExtendedProps: BQBjAAoAK0mmlidQ3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.199
X-EndOfInjectedXHeaders: 12414
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-wireless+bounces-5629-peter.schumann=secunet.com@vger.kernel.org; receiver=peter.schumann@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2623920883
X-Original-To: linux-wireless@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=96.47.72.81
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711752064; cv=pass; b=EhgKJNWW8QggMFzzVGJf6nchTOcMaW+DcgLgjkGme1qWTJXVnAJhVVrzVhzKQnHGCK0K66EkAUpjq7Ou84wxnMHDRfHJDanBQfHgbZeGelgvjLhYWsab60SHqvOoiYRVj7iwGILmeU6XA+WDVQUk8UvcgAFkaGHachoIO+z8bsY=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711752064; c=relaxed/simple;
	bh=+NS8DRolFTEpqULXWD/Iuy5zgqspUBx0v3sCTySgzUo=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=jIcy/TNNGfW2oHIbBgom0fbqzPkdzPi6FsdMA+gE8dNFM2NElgRzASi/oTP88QlmgFxFTo11wtpcwoxC5wIgmtazDMHXgE618SyTtwXvJ1GIipxp3hLyNZhIzZTxgviP3KoDb6Ymqm8SohzP28fL4cC/rJjlh/KaJItNiuL280w=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org; spf=pass smtp.mailfrom=FreeBSD.org; dkim=pass (2048-bit key) header.d=freebsd.org header.i=@freebsd.org header.b=mOp4NxDx; arc=pass smtp.client-ip=96.47.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=FreeBSD.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=FreeBSD.org
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
X-Virus-Scanned: amavisd-new at sbone.de
Date: Fri, 29 Mar 2024 22:40:59 +0000 (UTC)
From: "Bjoern A. Zeeb" <bz@FreeBSD.org>
To: linux-wireless@vger.kernel.org
cc: miriam.rachel.korenblit@intel.com
Subject: [PATCH 3/3] wifi: iwlwifi: mvm: check for CONFIG_IWLMEI to be enabled
 for more code
Message-ID: <sq1o7pr0-2137-11np-1or1-650nrro75o13@SerrOFQ.bet>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

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


