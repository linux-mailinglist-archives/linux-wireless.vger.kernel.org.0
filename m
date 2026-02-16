Return-Path: <linux-wireless+bounces-31895-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yAJCIK1lk2k44QEAu9opvQ
	(envelope-from <linux-wireless+bounces-31895-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:45:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FE31470EE
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 19:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D40E3020D43
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Feb 2026 18:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7932E7653;
	Mon, 16 Feb 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="TiYK+085"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEB92E3387
	for <linux-wireless@vger.kernel.org>; Mon, 16 Feb 2026 18:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771267492; cv=none; b=m5T/cjjP4qgsQ1ylkwwN2ZXtnIGVQ3ACAw4yViN8igoPiqjGemp67Lmk/DVZV3497CrXGGHbAb9NfU9TKhRgaXz1ZItWdZcShv44hoR2p8PabNUjGxjPqbjSjklLudnIoxD2baBcv97kRwCm/wCemAMQ86CaAV+9i1c8HFggk3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771267492; c=relaxed/simple;
	bh=SqcFM0QZIXR5mNz9Q/hTHf9CMfMyffBH5iM9TEo2OZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=keQTiUAJe4ssUReiKjkzLo6siJwafajPPLmPeZI2gTrIXBwFFovu7wbUOZxkAHpDFwfbjyT7H0w4Pm2edGEV5MkLZ7EnZulDsUk0tKBGi6sYaA14ZClpwZ5E7n9q9DSfBiwlzVaIjnJSrLSIgr4V+S4wC2k4LYv1xRL4JcdAW9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=TiYK+085; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 45040 invoked from network); 16 Feb 2026 19:38:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1771267088; bh=s/zeP5079+6V8e1bUW5YeqfAw436nt3wg6E8nJ8iSCM=;
          h=From:To:Cc:Subject;
          b=TiYK+085dE3CLobuMc/0P0hMH0T18xB248N0qqsUJD2f90OQyp8r8ZrdSVdtnrpP1
           iQLX6c1ddXaSMyrPPRWWaIlJlhbmyMyz3j1KFsGiVAdjQ1HRPpdmd4dA6gAHPkjwJn
           PkAw5zJXS6ISgyIsEetmY4woRh/YpAjhBVctX9sjym7xMVJAR1PQzqp63e9GWFd05L
           6AqWOez7E0QjpK1h0aG0O0SyEQDfKeXWpgRDdFniB/wCpyM+oaV2+RRONHw/gjlA7a
           gpmmuQJoJfow7YQfjIt5xKxaTTj3dg6iTBUNTLu1tY4J/dt9EZ1QL2Xina/9Pupzdl
           aP5aQ3EmOD8qg==
Received: from 89-64-3-178.dynamic.play.pl (HELO localhost) (stf_xl@wp.pl@[89.64.3.178])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <kees@kernel.org>; 16 Feb 2026 19:38:08 +0100
Date: Mon, 16 Feb 2026 19:38:08 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2][next] iwlegacy: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <20260216183808.GA10063@wp.pl>
References: <aYlkt2WP2oQ1TgeH@kspp>
 <202602091212.743C6B9B7C@keescook>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202602091212.743C6B9B7C@keescook>
X-WP-MailID: 6b2f477e8aaab6c42e78d28ed9add274
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000001 [4XKh]                               
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31895-lists,linux-wireless=lfdr.de];
	FREEMAIL_FROM(0.00)[wp.pl];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:mid,wp.pl:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28FE31470EE
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 12:46:23PM -0800, Kees Cook wrote:
> @@ -2664,7 +2668,8 @@ struct il3945_beacon_notif {
>  } __packed;
>  
>  struct il4965_beacon_notif {
> -	struct il4965_tx_resp beacon_notify_hdr;
> +	struct il4965_tx_resp_hdr beacon_notify_hdr;
> +	__le32 status;
>  	__le32 low_tsf;
>  	__le32 high_tsf;
>  	__le32 ibss_mgr_status;
> 
> 
> What do folks think?

Both options, with __struct_group(), and this one, are ok for me.

Regards
Stanislaw


