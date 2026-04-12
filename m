Return-Path: <linux-wireless+bounces-34675-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id M/a9DQoI3GmoLQkAu9opvQ
	(envelope-from <linux-wireless+bounces-34675-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 23:00:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A363E5FD8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 23:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A241B3007E15
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 20:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A56362136;
	Sun, 12 Apr 2026 20:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EirTS/vN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FFF351C30;
	Sun, 12 Apr 2026 20:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027509; cv=none; b=LWmwRtbpzoEB+4l3faBB7XYdV1js9cw83DrMO7nPrvqDt2U6X90ug0NfB+68JLpRbieIA+7+VBxp2NQLGLo5SgT9rCvvgKIzEo+rpkesI4GXo0dN7ezjbl3ICHUbYgixg9U+Izygm8a84UocUKEmMjPCQVLNPNg0E3vZmGAJHhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027509; c=relaxed/simple;
	bh=UuQrIK1aHRDtycvnWsa1Fwi8cjQTRLCMiv417Myy+ds=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdYvbaMkAcvh5p8Z05ffkss+F8gbCyrrCFX7EDQGg0zqhem1/xfG/Zq5FU6qinqDFd+SGBecDjIJTVmWfpqiQjGq+bN4F+esvqfeU71J+uX8fGS+/Talv7HRN1N0VMV1C0xGEKFkcL5tsl+vBeUDrAwePVgl8eecKDyraq+1rMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EirTS/vN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F71C19424;
	Sun, 12 Apr 2026 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776027508;
	bh=UuQrIK1aHRDtycvnWsa1Fwi8cjQTRLCMiv417Myy+ds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EirTS/vNi0+PFAF/vsi/uXnaMv1Dz1SMdJRU/B+gZm/HCLWTakhjvnr8k6znCwm/D
	 QQsFkOdoasjSYryQKWj7hplaHhzfabTVxVEiv+3op45wbabHAMdLu88gKPotGp3t+o
	 pbtMfF8rtsGlLyDs77eBUBYVKdQAMamioPCVrQBnHIZ8Nh0TNfXcreYH7+1N+IZse9
	 MUg/L1ZrgrjNEpzM4ZR4oDEkBLNc0IviWWbsoi/HGIsJIzOVKurqqYGvwflFPECJP7
	 12IpAS/Q9AkPx2wBu7zS0vPrBcYAYN0BB4Szhr9J7TCK4fTUE6qYKaiZDGLUFRGq6D
	 xihgY1kW11bcA==
Date: Sun, 12 Apr 2026 13:58:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH net 1/4] nfc: digital: Fix stack buffer overflow in
 digital_in_recv_sensf_res()
Message-ID: <20260412135827.0cb6f44c@kernel.org>
In-Reply-To: <20260409223436.1887988-2-snowwlake@icloud.com>
References: <20260409223436.1887988-1-snowwlake@icloud.com>
	<20260409223436.1887988-2-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34675-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 96A363E5FD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 00:34:31 +0200 Lek=C3=AB Hap=C3=A7iu wrote:
> The function digital_in_recv_sensf_res() validates that the incoming
> SENSF_RES frame is at least DIGITAL_SENSF_RES_MIN_LENGTH (17) bytes,
> but does not check that it is at most NFC_SENSF_RES_MAXSIZE (18) bytes
> before copying into the 18-byte target.sensf_res stack buffer.

Hm, third similar fix we received for this.
struct digital_sensf_res is 19 bytes, you're capping the length at 18
something else is wrong here..

