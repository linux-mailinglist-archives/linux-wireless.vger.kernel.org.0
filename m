Return-Path: <linux-wireless+bounces-31348-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOIEMq0yfGlzLQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31348-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 05:25:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F804B714E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 05:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0878300E3AB
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113B0314D3D;
	Fri, 30 Jan 2026 04:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2ayOwA7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE411C32FF;
	Fri, 30 Jan 2026 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769747105; cv=none; b=ulN19q0t5DCGZp4l2mSJcxN4/vQWcElHZdVQ2xxpSOhpRMDOPTHHXj/Kj4xIjtSUUG25Z6fPYFLNkp+tN9dl/aNF/1+UQXyY79/SVasbBkUwoDHT44cFPzqxMPtk+7dzc6sSavXzXxyglZYqU9X6QdwAjEt9PNSbYAcLJohuKOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769747105; c=relaxed/simple;
	bh=iClT2Sc7vLZbGB0wck1dQNHPHMa1CGLidlBKYnrT81k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jZNkZuzwdM4CVSuamCTM+voQVuLGXXs+e+ymySqYZrdPAk/wDaCPqkc4s1HXJD/jeq41jyTvSAC+D5CtpX/SP35f+rCoUFfs8myhDlmk6GZ6oQqYEmid6HwoqzfWVMBDV02jqU9Y70A9V/1/HR3iqvBjV3jobmB+PaYo6vIGhqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2ayOwA7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287D8C4CEF7;
	Fri, 30 Jan 2026 04:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769747105;
	bh=iClT2Sc7vLZbGB0wck1dQNHPHMa1CGLidlBKYnrT81k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I2ayOwA7Txbk+U29fX0ZndhmWdTB76k8WVSsMZgAuzh2bbo89417DGwa3klHh9e3Y
	 dYgx2T4NPE8Z6DITaioDa+XUdMD+xasQBFCNmxRCTCTJa2C7TorQIFlDQdP54dtrYM
	 ZUOM6FKSVGO6HD92BVteQ/tn+Ivld/rMD4RDgrfdgqJ6X6fzCPVeYecE0CPjxT9jbX
	 0MeKp+K32dAcwqdn0fBhSP5P6pOVU46iRYqeR2BtQ1XpRhCRRDD2oISwXOWTOrf1cv
	 KCsgwzMwvZXEXs82uYuJuSpICWFok1qsEQ5r9W929rsD1sRmKeB5m7h5lRQ/8Joabh
	 QzUYz9AltOeDw==
Date: Thu, 29 Jan 2026 20:25:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [GIT PULL] wireless-next-2026-01-29
Message-ID: <20260129202504.1696fdc9@kernel.org>
In-Reply-To: <20260129110136.176980-39-johannes@sipsolutions.net>
References: <20260129110136.176980-39-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31348-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F804B714E
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 11:58:31 +0100 Johannes Berg wrote:
> Another fairly large set of changes, notably:
>  - cfg80211/mac80211
>     - most of EPPKE/802.1X over auth frames support
>     - additional FTM capabilities
>     - split up drop reasons better, removing generic RX_DROP
>     - NAN cleanups/fixes
>  - ath11k:
>     - support for Channel Frequency Response measurement
>  - ath12k:
>     - support for the QCC2072 chipset
>  - iwlwifi:
>     - partial NAN support
>     - UNII-9 support
>     - some UHR/802.11bn FW APIs
>     - remove most of MLO/EHT from iwlmvm
>       (such devices use iwlmld)
>  - rtw89:
>     - preparations for RTL8922DE support

Pulled, thanks!

